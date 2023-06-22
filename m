Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B63EB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFVVlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjFVVlI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:41:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1F1FED
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:41:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C741F30E02;
        Thu, 22 Jun 2023 17:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WaIb9AX3EmSw1D+hYZjgLy/8GVf/pPAPSnn+bL
        pEw8M=; b=OyTtP0Cu2CcVaY2y2b2rYd/XOV45EyyNz6el+PiluwEw5esZOPWSrM
        3v97iurP0KWNFxVJfIXRaqZR95/NA2JxOlDieay+MiYdibJE/wk3n75GJq0onxNJ
        WYhCXfoV3412nc9pVRQaK7VPk1D2hs/P0KfaHu30sRTbTwBUV3LHE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF9A830E01;
        Thu, 22 Jun 2023 17:41:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC68730DFF;
        Thu, 22 Jun 2023 17:41:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 1/3] var: add support for listing the shell
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230622195059.320593-2-sandals@crustytoothpaste.net>
        <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
        <xmqqjzvvdx7g.fsf@gitster.g>
        <ZJS8Ot+dHDRXZD/t@tapette.crustytoothpaste.net>
Date:   Thu, 22 Jun 2023 14:41:02 -0700
In-Reply-To: <ZJS8Ot+dHDRXZD/t@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 22 Jun 2023 21:25:14 +0000")
Message-ID: <xmqq4jmzdvkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CCB47B6-1145-11EE-BC6E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-06-22 at 21:05:39, Junio C Hamano wrote:
>> Correct.  I also suspect that we want to add test_path_is_executable
>> helper next to test_path_is_{file,dir,missing} helpers and list it
>> in t/README.  One downside of your approach is that the output from
>> the command is only in $shpath and cannot be observed easily in the
>> $TRASH_DIRECTORY after the test fails, but with such a helper we can
>> report the problematic path when the expectation fails.
>
> At first glance, I thought that was a good idea, too, but unfortunately
> there is no way to make that work on Windows.  That's why all of our
> tests skip those assertions with POSIXPERM, and why my tests
> specifically look for something different on Windows.
>
> We could in theory just make it always succeed there, but my concern
> with writing such a function is that people will think it works
> generally, when in fact it does not.  That's why, typically throughout
> the codebase, we specifically use "test -x".

Hmph.  I would have thought that test_path_is_executable that is
based on "test -x" and gives a diagnosis when "test -x" fails would
be better than using bare "test -x" and be silent, even on Windows.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DEBC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjEPSxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 14:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPSxl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 14:53:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6001FD4
        for <git@vger.kernel.org>; Tue, 16 May 2023 11:53:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 365D31F8AA1;
        Tue, 16 May 2023 14:53:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YzJ0dBOpzrVm8fGRi/eTQhbwLsL0PDKzdRPVCQ
        pMh+g=; b=W9umZ06YhlqNu8pA4OkYr0fWgxZ6hc7xmIOvibAQ/TA4eRREHidLZF
        4XdQI2GmJPt6K0c6UtwIxqQ/hiSjSluK99UbzAuyFdVvj7WA0wQEyB40z1DzbDFB
        +3eTOBW+mQQ2QDrp2Q9jTu08MzN3So9rGMVoWt/tALmfky6A1KCVM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E4121F8AA0;
        Tue, 16 May 2023 14:53:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 404751F8A99;
        Tue, 16 May 2023 14:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] run-command.c: need alloc.h for our own at-exit handler
 emulation
References: <009501d98817$9eb44560$dc1cd020$@nexbridge.com>
        <ZGO4LesPe4A2ftdm@nand.local> <xmqqlehourbf.fsf@gitster.g>
        <xmqqh6scur3r.fsf_-_@gitster.g> <ZGPEHu2pCYfdNI0h@nand.local>
        <ZGPE9ozRChUJ3NGV@nand.local> <xmqq353wune3.fsf@gitster.g>
        <ZGPP02zYlSM9iRYt@nand.local>
Date:   Tue, 16 May 2023 11:53:36 -0700
In-Reply-To: <ZGPP02zYlSM9iRYt@nand.local> (Taylor Blau's message of "Tue, 16
        May 2023 14:47:47 -0400")
Message-ID: <xmqqy1lot8en.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F73EAE86-F41A-11ED-9F63-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, May 16, 2023 at 11:44:36AM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > OK, having now read both completely, I would say I have a vague
>> > preference for my version since it keeps the include at the top and
>> > unconditional, and has slightly more information in the patch message.
>> >
>> > But I do not prefer it so much over yours that I would be sad if you had
>> > already queued yours and didn't want to bother shuffling it around.
>>
>> I do not have much preference between the two, either.  Both lack
>> one important description that we are reasonably confident that this
>> breakage is limited to run-command.c and no other files.
>
> I believe that mine does:
>
>   (Everything else compiles fine when NO_PTHREADS is defined, so this is
>   the only spot that needs fixing).

Not quite.  Who says NO_PTHREADS is the only conditional that may
hide use of ALLOC_GROW()?

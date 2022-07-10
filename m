Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DACC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 05:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGJFs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 01:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJFs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 01:48:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E712ADC
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 22:48:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 309C9199DA6;
        Sun, 10 Jul 2022 01:48:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cwlauzZyWgoSnhrNfwiTHxGY/PDafdNdaObgl5
        NtesQ=; b=iB80aoMjsLEgbrEjYDZfEnOmIENbgPbymGyxXTFVQZ6MfxZ4W+44gO
        +KD3b5o5+iMJz+6CD6z7Ry7NGcfAewK1fZK6WuIBV/pDzpfomlJVMf7jTUmDqePd
        Lresvs5yDgq6lImiOFPkyMOGsvjewelz33PXod2KgbzDwj7KDOdNY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C19B199DA5;
        Sun, 10 Jul 2022 01:48:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE0E4199DA4;
        Sun, 10 Jul 2022 01:48:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust
 level to string
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
        <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
        <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
        <xmqqwncmt3el.fsf@gitster.g>
        <CAPig+cScKabgrh80e5rqWX8cnNEgvxP9JyVJCu+afBOJk_yopg@mail.gmail.com>
Date:   Sat, 09 Jul 2022 22:48:21 -0700
In-Reply-To: <CAPig+cScKabgrh80e5rqWX8cnNEgvxP9JyVJCu+afBOJk_yopg@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 10 Jul 2022 01:44:53 -0400")
Message-ID: <xmqqilo5sel6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8BA7F94-0013-11ED-AE3A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Given the small, fixed number of trust levels, and if the list is
> unlikely to change much in the future, I might suggest simply
> initializing the fields at compile-time rather than on-demand at
> run-time:
>
>     static struct {
>         const char *key;
>         const char *display_key;
>         enum signature_trust_level value;
>     } sigcheck_gpg_trust_level[] = {
>         { "UNDEFINED", "undefined", TRUST_UNDEFINED },
>         { "NEVER", "never", TRUST_NEVER },
>         { "MARGINAL", "marginal", TRUST_MARGINAL },
>         { "FULLY", "fully", TRUST_FULLY },
>         { "ULTIMATE", "ultimate", TRUST_ULTIMATE },
>     };

Yup, that is even better.  I wonder if we can upcase in C
preprocessor macro?  It would be wonderful if we can do so,
but for just 5 entries, we can type each token three times
just fine.





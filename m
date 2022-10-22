Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3243C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 17:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJVRva (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 13:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJVRv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 13:51:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7BC5F232
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 10:51:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 911111BAC91;
        Sat, 22 Oct 2022 13:51:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EECasO99NjfiYcpgPopOquAkhQB7VO7e1/2YUA
        jBXkk=; b=E7Ok8ew1B8FFavJT2UtLXETobNj/i37BX5GIU+AuuLxi0rP7+lnTvk
        1kScisZXRzvJUNz6bR/BrzPsG30iRIJDw0sEUw+yCgyfM+IdpHD2rUmaOS6ded7L
        WBiiFFytfWpBj1CfaC1vO+2gm1Z30t0JVgHIumaxQNGFWX0I+ukvo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8812F1BAC90;
        Sat, 22 Oct 2022 13:51:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ADF541BAC8F;
        Sat, 22 Oct 2022 13:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
        <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net>
Date:   Sat, 22 Oct 2022 10:51:23 -0700
In-Reply-To: <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 21 Oct 2022 16:17:06 -0400")
Message-ID: <xmqqilkbhhlw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2560AE94-5232-11ED-926E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 21, 2022 at 01:45:13PM +0000, Phillip Wood via GitGitGadget wrote:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> 
>> If the input to strtoimax() or strtoumax() does not contain any digits
>> then they return zero and set `end` to point to the start of the input
>> string.  git_parse_[un]signed() do not check `end` and so fail to return
>> an error and instead return a value of zero if the input string is a
>> valid units factor without any digits (e.g "k").
>
> This one is easier to test than the last. Just:
>
>   git config --int --default='m' some.key
>
> works. And even playing devil's advocate, I can't think of a case where
> anybody would rely on the current behavior.

Hmph, but --default=" m" would not be caught with the patch with the
same error, but is still a valid way to say zero mega unit.

Personally I do not see if this one is worth worrying about at all,
even though the fixes in 1/3 and 3/3 may be more worthwhile.

THanks.

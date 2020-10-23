Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61AFC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5043520BED
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 18:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YTQQwqZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbgJWSzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:55:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61086 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbgJWSze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 14:55:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B49393C27;
        Fri, 23 Oct 2020 14:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SunVgxroPNoGrm62zCGYtLuRxVo=; b=YTQQwq
        ZzQERF7/NJ88m+L+DGZwGTdWg1ockQpoSo6BzTxYiU84B4PLm5G7O3vXhxRa3t1p
        Id2+NN8j+69oHBAhOQpCu2LtRxyJR52YHJALLB9Vgtg/WXt1jzUjd32yDMymEyrJ
        K3NrV/rP6xX8kZd8eKuq7P08JGnC6lB4zJDsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qc+VnmazqIw/RYxXJTROHIoPb5AuIBr+
        Zh0psySiVzNhrnN6uLyhhbI1mGmauVmywt2Jjv5ECwX1MAars6Wx3/fXMXe7Zdxu
        Kk+hUt8eEmYEdA7Rnd+vx69JK4WsKuKCCOGp8PmKJ1CWqCpU4QgunLoWkU7nhi8t
        VLy9UykdLHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12B5993C26;
        Fri, 23 Oct 2020 14:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97AF093C25;
        Fri, 23 Oct 2020 14:55:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [Outreachy] [PATCH v3] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201022112201.51459-1-sangunb09@gmail.com>
        <xmqqft66m8wm.fsf@gitster.c.googlers.com>
        <CAHjREB4qGO1=XCy-F+H39FP_KU_zZjKCDA=b9JxCe0WZdM06KQ@mail.gmail.com>
        <xmqqr1pphsvs.fsf@gitster.c.googlers.com>
        <CAHjREB4egt95fCz6pzON2h5rVH-XvYKf1oGnyU-8gVL-U3WrmA@mail.gmail.com>
Date:   Fri, 23 Oct 2020 11:55:30 -0700
In-Reply-To: <CAHjREB4egt95fCz6pzON2h5rVH-XvYKf1oGnyU-8gVL-U3WrmA@mail.gmail.com>
        (Sangeeta NB's message of "Fri, 23 Oct 2020 23:47:20 +0530")
Message-ID: <xmqqd018hivx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 532CDB3C-1561-11EB-BF39-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta NB <sangunb09@gmail.com> writes:

>> I found this change a "noise":
>
> Oh okay, Again sorry for the misunderstanding.
>
>>
>>         strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>>         if (ignore_untracked)
>> -               strvec_push(&cp.args, "-uno");
>> +               strvec_push (&cp.args, "-uno");
>>
>> If it were going the other direction, "we fix coding style violation
>> while at it" may be a good justification to do so, but this
>> particular change (1) is not neeeded for the purpose of this patch,
>> and (2) is making the code worse by deviating from the coding
>> guideline.  Please drop it.
>>
> This part of the change was introduced because we had a failing test
> here[3]. There was some problem it getting both the flags propagated
> through ...

Are you talking about the new "else" clause added to the "if"
statement we see above?  I am not saying it is a "noise".

But look at what you did to the existing call to strvec_push() to
add "-uno" shown above in the patch, i.e. the addition of space
before the parenthesis.  We cannot justify that change, can we?
That's noise as far as I can see.

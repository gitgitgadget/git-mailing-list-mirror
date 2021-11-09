Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54251C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAAF61177
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbhKISjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:39:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55740 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbhKISjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 13:39:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1D991509CE;
        Tue,  9 Nov 2021 13:36:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9yx+zMr+WVcJIFMDb7d9y96JrMYqAg3GfREWAP
        +E6VI=; b=YCj9x/dV3xq+oHrF2kU+CYPsOTqqAbywAb9kTHAeNH0lTv7PMpOUH0
        YeAsGcK8DJbMCf8ubx06hjZqSBjBmUmKfm/1E7tOOH60FbaxBZ0BoRqVL9Q0ltQi
        pobOfGmvrS/Dp/LPzZGj5dJEcPXBxD1sgCNRA4uRNSxUYag5n6DVs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAD2D1509CD;
        Tue,  9 Nov 2021 13:36:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AE8A1509CA;
        Tue,  9 Nov 2021 13:36:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Yvon <samuelyvon9@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
References: <211109.868rxxvgdi.gmgdl@evledraar.gmail.com>
        <20211109152219.11037-1-samuelyvon9@gmail.com>
Date:   Tue, 09 Nov 2021 10:36:30 -0800
In-Reply-To: <20211109152219.11037-1-samuelyvon9@gmail.com> (Samuel Yvon's
        message of "Tue, 9 Nov 2021 10:22:19 -0500")
Message-ID: <xmqqbl2t2n2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F52CBA36-418B-11EC-9874-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Yvon <samuelyvon9@gmail.com> writes:

> On one hand, flushing then showing the editor seems to indicate that we want the
> editor to be up-to-date, but because the status is prepared before the flushing,
> maybe not?
>
> While it seems the current behaviour has been the behaviour since the start,
> I am inclined to continue pushing for this change. Unless I am missing something,
> the comment is contradictory and we should be coherent with the idea of
> accepting changes made within the pre-commit hook, as noted in 
> https://lore.kernel.org/git/xmqqk0yripca.fsf@gitster.c.googlers.com/t/#u:
>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> Even before ec84bd00 (git-commit: Refactor creation of log message.,
>>> 2008-02-05), the code anticipated that pre-commit may touch the index
>>> and tried to cope with it.

You seem to be quoting the thread over and over, but what you are
quoting is somewhat different from the concluding part of what I
said, which was:

    If I have to guess, I think the reason is because pre-commit
    automation is expected to be some sort of mechanical change and
    not part of the actual work that the end-user produced, it would
    become easier to perform the "final review" of "what have I done
    so far---does everything make sense?"  if such "extra" changes
    are excluded.

    So, in short, it is not "undefined", but rather it seems to be a
    designed behaviour that we are seeing.

I do not personally mind if we change the philosophy but because it
has been a longstanding designed behaviour, it may need a careful
transition plan.

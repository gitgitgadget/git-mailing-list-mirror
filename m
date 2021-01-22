Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE38C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F3B238EE
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAVCSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 21:18:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55379 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbhAVCSD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 21:18:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55902108546;
        Thu, 21 Jan 2021 21:17:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uzZ0fm3F16x3rDmQ4Lpo5873YKY=; b=Lv5OJ8
        3ZhXtYN/zjtUEipxYTzCjUu8yKutwtX7YwiFg2IcHBDeg04Zh8puCD4Zz+2GKW83
        JlRi9x8TZ3FdyCJexEmD88NLhC5iRiQn4R/QRXuKIdhI0YXstQ+K50az7NFN0UHa
        SES+J06TTIhNI/t0QrubwzQdJ3cGxkNCH8W+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gncko8nDoxWTgV4NDOT1IruSP2MySkEa
        LSZ2wS2lhTM1GuZ4bbLkxJCB6Iys/GMYa1t/ow42t9Gode5l/OH9fuCX6m1+y/11
        VVo8Yqs7ROHhbju3oRxseU1TUr9V2RYioJZb+1JN1MtwbhhjdKIMTID/oFe2PL6d
        Xs3l8QFJbpI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E445108545;
        Thu, 21 Jan 2021 21:17:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98CB5108544;
        Thu, 21 Jan 2021 21:17:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] use delete_refs when deleting tags or branches
References: <20210121032332.658991-1-phil.hord@gmail.com>
        <xmqqpn1xalav.fsf@gitster.c.googlers.com>
        <CABURp0pqdK+Mrqi=r40YeUitaB2s44iYO=2UFFSh0UC_o4Mosg@mail.gmail.com>
Date:   Thu, 21 Jan 2021 18:17:16 -0800
In-Reply-To: <CABURp0pqdK+Mrqi=r40YeUitaB2s44iYO=2UFFSh0UC_o4Mosg@mail.gmail.com>
        (Phil Hord's message of "Thu, 21 Jan 2021 16:27:22 -0800")
Message-ID: <xmqqlfclaf6b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3C1FAA4-5C57-11EB-B67C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> Oof.  Sorry.  I forgot I have diff.noprefix=true in my local config.
> It is a huge timesaver for me when looking at diffs on a console since
> I can quickly highlight the filename with a mouse to paste into an
> editor.
>
> Sometimes it bites me, though.  Usually I notice in the diff, but this
> one I was sending with format-patch / send-email.
>
> I guess I'll turn that off in git.git so I don't misfire at you again someday.

I think per-repository configuration might be sufficient for this
particular case (after all, it is project's preference), I wonder if
a more command-specific variant of diff.noprefix so that "log -p"
and "format-patch" can be configured separately would make sense,
something like...

    [diff]
	noprefix = true
    [diff "format-patch"]
	noprefix = false
    [diff "show"]
	noprefix = false


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DC6C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20131613E3
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 19:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhDTTmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 15:42:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63058 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhDTTmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 15:42:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 82E56136A8F;
        Tue, 20 Apr 2021 15:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rAV9buQ+YTYhn1wqp5tm8fOUl/E=; b=qkFc4a
        AWo2Hevjl7oxYgeY55DMC0hBt07jZJqDobQQEx8EwW6D6uTp+68XueKUxJpLcP66
        w07w+iWcpoIhRJkFofkxJW8kGkuW/2Qtf/HpK6DiJH/omt4VSlXJMhjHuJ5zFNFM
        YYnL7XsH7cOX9ODxx+WaPeeA5RX7A88IlEilI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xzuFvBQQw1pIGoxn/hzmD4LdkY97qAzx
        boW1cMVlb0iAU0KdyZN+X8hK+nrOrAShP4QvwthGEuV+yGVG7WKhc8rAhYY9oEIx
        ai1DPjx3nF5WkXhU8TAwYJ38lK5ao0uEitWWuA+YFTYAGT86pZMNTr/6ZYD+SwUP
        gakGSnNgFGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7522D136A8D;
        Tue, 20 Apr 2021 15:42:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7CD8136A8C;
        Tue, 20 Apr 2021 15:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 03/28] refs/debug: trace into reflog expiry too
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
        <9ae5ddff6aed48184d2a10c569e41441b9199f10.1618832277.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Apr 2021 12:41:56 -0700
In-Reply-To: <9ae5ddff6aed48184d2a10c569e41441b9199f10.1618832277.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 19 Apr 2021
        11:37:31 +0000")
Message-ID: <xmqqsg3k68vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77C812E0-A210-11EB-92D3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)

Nicely done.  

I as a reader of this patch do have to wonder, with the above very
limited log message material, how useful did "debug_reflog_expire()"
machinery used to be without any tracing.

It just reported the fact that expire method was called and what the
backend did as a whole, instead of reporting what the machinery
decided for each reflog entry to be pruned (or not pruned)?

Not a problem with this patch at all, and certainly it does not have
to be part of this series, but it feels very backwards, at least to
me, to have the method should_prune in ref backends.  As a function
to make a policy decision (e.g. "this has a timestamp older than X,
so needs to be pruned", "the author of this change I do not like, so
let's prune it ;-)"), it is more natural to have it as independent
as possible from the individual backends, no?

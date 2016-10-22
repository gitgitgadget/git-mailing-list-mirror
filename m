Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9931C20986
	for <e@80x24.org>; Sat, 22 Oct 2016 17:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbcJVRLt (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 13:11:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55208 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935413AbcJVRLs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 13:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67FF546BE0;
        Sat, 22 Oct 2016 13:11:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4nJcWqclo2YunFI56YYMR26jug=; b=t69iJF
        P8fSBaDnt8iEtlix100ND4V+pEAmJsmvsV1fLz0Vbv9BZjEgomt1sdw+BL+zgn25
        zLAGKKHk4gIazUbO6ZXxvT8YTMA/uHDfUtMDEF2pMOvNztsFptcV2jvpaVxiy14H
        oh9Ct/CQDNtZ4PvwzVjKngqxLFB742kvRHuIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ao4MrLoA3IazuaXXMlL5qKymjR5xYejb
        2LhvvlOQqAw7VszcW2E2RjuFL+iPZzEIym06ZNVNvN/r2mjoUjsprnWv+du8f0xq
        QE+qRKMYYiD9WKeLCdTUnIdpSRVmk1M+iCq7UdAIMldLG8qDajgylPh+rxga5ECX
        vfgQss+XYkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EB3046BDF;
        Sat, 22 Oct 2016 13:11:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4CD246BDC;
        Sat, 22 Oct 2016 13:11:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
Date:   Sat, 22 Oct 2016 10:11:44 -0700
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 21 Oct 2016 14:23:45 +0200 (CEST)")
Message-ID: <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CF735AE-987A-11E6-99D2-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series marks the '4' in the countdown to speed up rebase -i
> by implementing large parts in C (read: there will be three more patch
> series after that before the full benefit hits git.git: sequencer-i,
> rebase--helper and rebase-i-extra).
> ...
> It would be *really* nice if we could get this patch series at least into
> `next` soon, as it gets late and later for the rest of the patches to make
> it into `master` in time for v2.11 (and it is not for lack of trying on my
> end...).

This "countdown 4" step can affect cherry-pick and revert, even
though we were careful to review changes to the sequencer.c code.  I
prefer to cook it in 'next' sufficiently long to ensure that we hear
feedbacks from non-Windows users if there is any unexpected breakage.

There isn't enough time to include this topic in the upcoming
release within the current https://tinyurl.com/gitCal calendar,
however, which places the final on Nov 11th.

I am wondering if it makes sense to delay 2.11 by moving the final
by 4 weeks to Dec 9th.

Thoughts?

Speaking of what to and not to include in the upcoming release, we
do want to include Stefan's off-by-one fix to the submodule-helper,
but that is blocked on Windows end due to the test.  I think
everybody agreed that a longer time "right thing to do" fix is to
address the "when base is /path/to/dir/., where is ../sub relative
to it?" issue, but if we are to do so, it would need a longer
gestation period once it hits 'next', as it can affect the current
users and we may even need B/C notes in the release notes for the
change.  Giving ourselves a few more weeks of breathing room would
help us to make sure the fix to relative URL issue is sound, too.

As to "countdown 3" and below steps, I am guessing that some of them
can start cooking in 'next' before 2.11, but even with lengthened
schedule, it is likely that they need to cook there beyond the end
of this cycle, unless they are truly trivial changes that do not
even need any reviews.

Thanks.

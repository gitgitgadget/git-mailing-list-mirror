Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D5C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 18:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4529A6127C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhDSS4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 14:56:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53204 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhDSS4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 14:56:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F23CAE7B7;
        Mon, 19 Apr 2021 14:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j19GuQp18Wfa
        JqI24fHPaC3X+qw=; b=Pyr6KqrvsM6lace/G4OOTTBAhEkL2DZy7cHZklqpeH4V
        k5E9MFIqazgO4c5vCzPZD3CDQTg6iquRSlLEQ5qYOePcuuQLHOBEherZO/n9Ujmf
        4Z6UUXbx5fsaXou2Meh7MuRpdJYK6CJ3HgAdZGp09JlSvn9VtzhuGy2rwAVflg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fqsEiJ
        2f6AIfmciFvxemDKXhQSoribrsXuXmTUwJRY1m+o0WeFBSVNfa8ytmqo3RViZOsJ
        AujS535sNTr4FDyMpe6k95++bLqzUAV6wyhEopDtMJ/D3KiWCS+u9SROO6IyBxPl
        5Iqdp+KrHlXLzOzQ80JkjHTH99E3rELH8P+Gc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15D1FAE7B4;
        Mon, 19 Apr 2021 14:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93AE1AE7B1;
        Mon, 19 Apr 2021 14:55:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Trygve Aaberge <trygveaa@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: Using --term-* with bisect breaks skip
References: <20210418151459.GC10839@aaberge.net>
Date:   Mon, 19 Apr 2021 11:55:42 -0700
In-Reply-To: <20210418151459.GC10839@aaberge.net> (Trygve Aaberge's message of
        "Sun, 18 Apr 2021 17:14:59 +0200")
Message-ID: <xmqqlf9e9k9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D7D8D6E0-A140-11EB-87A6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trygve Aaberge <trygveaa@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue=
)
> 1. git bisect start --term-new=3Dfixed --term-old=3Dunfixed master HEAD=
~10
> 2. git bisect skip
>
> What did you expect to happen? (Expected behavior)
> Git should mark the commit as skipped and change HEAD to a different co=
mmit.
>
> What happened instead? (Actual behavior)
> The commit was marked as skipped, but HEAD was not changed.
>
> What's different between what you expected and what actually happened?
> After running bisect skip, HEAD was still at the same commit as before,
> instead of having changed to a new that I can test. The usual output ab=
out
> steps left to test and the new commit was also missing, skip did not ou=
tput
> anything.
>
> Anything else you want to add:
> - If I don't provide any --term-* options, skip works as expected.
> - The revisions provided in the reproduction steps doesn't matter, they=
're
>   just an example.
> - I tried running from the next branch, and it happened there too.
>
> [System Info]
> git version:
> git version 2.31.1

Thanks for a report.

I suspect that this is a fairly recent regression.  With Git 2.30.2,
"bisect skip" does flip HEAD and mark the commit to as untestable.

Can you "bisect" the problem?  There aren't that many commits that
touched bisection code during the period.

$ git log --format=3D'%aN %s' --no-merges v2.30.2..v2.31.1 -- \
  bisect.c builtin/bisect--helper.c git-bisect.sh
Jeff King bisect: peel annotated tags to commits
Ren=C3=A9 Scharfe use CALLOC_ARRAY
Johannes Sixt replace "parameters" by "arguments" in error messages
Pranit Bauva bisect--helper: retire `--check-and-set-terms` subcommand
Pranit Bauva bisect--helper: reimplement `bisect_skip` shell function in =
C
Pranit Bauva bisect--helper: retire `--bisect-auto-next` subcommand
Pranit Bauva bisect--helper: use `res` instead of return in BISECT_RESET =
case option
Pranit Bauva bisect--helper: retire `--bisect-write` subcommand
Pranit Bauva bisect--helper: reimplement `bisect_replay` shell function i=
n C
Pranit Bauva bisect--helper: reimplement `bisect_log` shell function in C
Martin =C3=85gren hash-lookup: rename from sha1-lookup


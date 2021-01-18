Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBF4C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B8C22D08
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437290AbhART0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:26:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63356 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390476AbhARTQG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 14:16:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09A161115A5;
        Mon, 18 Jan 2021 14:15:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j/Gb1BzSduntvKFFVA5QsvyLvbU=; b=kfBV6q
        Kyo3lP+OsD23jC5Bu4d+n5RlHme12e0YKQN0ZHLCnP7Kb0b04eSx4MfxGX9qMDxN
        5FX/LFcx847lQnnH3CD0GN9ruRkG8Izennht+JZCQlzpFEs1d6mYMMiDYrHsTtcq
        4u4xDVYGKZec5IfGNPbhZD+7shN5JbBn77kC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=inN2XPIokZEHxfHXLO/roeOsLH5DDAQB
        dHohdXNhJ2l77TL1oPupWz86qJuX+Fs3LLQxS/LSgfXPLQnds6V4xgLAaNUooASb
        hFzlSSTHRlF3D+cJXoRUl68Qp8jRRGyQ6/OX8t7jOn3l4LU6ifNP7qVZMHbv7l/g
        BBafQ9DTTmo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 020D01115A4;
        Mon, 18 Jan 2021 14:15:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2466C1115A3;
        Mon, 18 Jan 2021 14:15:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
Date:   Mon, 18 Jan 2021 11:15:16 -0800
In-Reply-To: <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us> (Kyle Marek's
        message of "Mon, 18 Jan 2021 02:56:22 -0500")
Message-ID: <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80565DDC-59C1-11EB-883B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

> I'll investigate the revision-mark shifting idea. I am concerned that
> it would get complicated if a graph edge extends around a revision
> that needs to be shifted,...

The "current graph layout makes it harder to see where the root is"
problem has a natural solution: fix the graph layout so that the
root is easily visible.

I however think it is a much harder approach to solve than using a
different mark for root commits, and it is the reason why there have
been at least a few attempts in the past that did essentially the
same patch as yours, plus the "linear break" which we accepted.

> *   8d82d0a (HEAD -> master) Merge branch 'o1'
> |\
> | * 3479914 (o1) O1
> | * a674e07 O1        <-- root commit
> | * 2237b52 (t) T
> | * f525fa5 T
> |/
> * f15f936 A
> | * 9e289ed (u) U
> |/
> * ee911c8 initial     <-- root commit
>
> vs:
>
> *   8ee9b14 (HEAD -> master) Merge branch 'u'
> |\
> | * ed1990f (u) U
> * |   277f31c Merge branch 'o1'
> |\ \
> | * | eaa71bb (o1) O1
> | * | 9203a43 O1      <-- root commit
> |  /
> | | * bc2c4d9 (t) T
> | | * 2d3c03b T
> | |/
> |/|
> * | 6a26183 A
> |/
> * da85ccf initial     <-- root commit

Sorry, I am not quite sure what you are trying to illustrate with
the comparison between the above two.  The latter makes it clear
that 9203a43 and da85ccf do not have parents in the depicted part of
the history [*1*].

In the former one, does 2237b52 have no child in the depicted part of
the history, and is the problem that it appears as if it has a674e07
as a child?  I wonder if we can just shift them, either:

> *   8d82d0a (HEAD -> master) Merge branch 'o1'
> |\__
> |   * 3479914 (o1) O1
> |   * a674e07 O1        <-- root commit
> | * 2237b52 (t) T
> | * f525fa5 T
> |/
> * f15f936 A

or

> *   8d82d0a (HEAD -> master) Merge branch 'o1'
> |\
> | * 3479914 (o1) O1
> | * a674e07 O1        <-- root commit
> |   * 2237b52 (t) T
> | __* f525fa5 T
> |/
> * f15f936 A

Or we could punt to show it with an extra blank line, although it is
suboptimial.

> *   8d82d0a (HEAD -> master) Merge branch 'o1'
> |\
> | * 3479914 (o1) O1
> | * a674e07 O1        <-- root commit
> |
> | * 2237b52 (t) T
> | * f525fa5 T
> |/
> * f15f936 A


[Footnote]

*1* Stepping back a bit, I think concentrating too much on "is it
    root?" is a wrong way to think about the problem.  Suppose you
    have two histories, e.g. (time flows from left to right; A and X
    are roots)

            A---B
                 \
          X---Y---Z

    and doing "git log --graph --oneline Z" would show A, B, X, Y
    and Z.

    If it benefits to show "A" (and "X") specially in the graph,
    that would mean that the current algorithm would show some other
    commit after showing A (probably X if it goes in chronological
    order), and it probably is confusing because X is shown on the
    same column as A, when there is no parent-child relationship
    between them (A is root after all).

    We are trying to highlight that A is not a child of anybody by
    using '#' instead.

    But in a slightly modified graph:

          C
         /
        O---A---B
                 \
          X---Y---Z

    if you do "git log --graph --oneline C..Z", you should see the
    same commits listed as above (A, B, X, Y and Z), and most likely
    in the same order.

    So special casing by "Ah, A is a root commit, so let's show it
    with '#'" does not help, even though we are facing exactly the
    same problem in the latter graph.

    And the right way to look at it is "does A have any parent in
    the part of the history being shown?", not "does A have any
    parent?"  Then 'A' will get exactly the same treatment in the
    two examples, and the visual problem that makes A appear as if
    it has parent-child relationship with unrelated commit X goes
    away.

    

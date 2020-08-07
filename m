Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08674C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81F2204EA
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 17:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w731WFI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHGRnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:43:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61630 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGRnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 13:43:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B85FDF58E3;
        Fri,  7 Aug 2020 13:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9B22mdubl8fUHm9oz8QeJip0VdU=; b=w731WF
        I0Njut88Db4oZKaABioSEZur7GJOPK+ttCBsb7a7k//Gnad+af3EWdaZxQtTudC9
        o96um9n78to6e7E33rNQP0QjQ9oFdubFNwS+EWXlO7xLzBgWWKh9nQkjMxT5cn42
        eIpJiXkZbrqmw/0V2Eak+7x3uQv/vN9bYECKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ciO5Q9ihjw+eP2SVqn9JDnitu4BSmXR9
        21gaHSHXBI9RtqsG8JENn3f7n6ok/x/A838mQPGeNHrOlblXgt5nO0VVHaLImX7+
        NhCFJa2lgj+ApeLLWx7HGotkwd9LnzJwZ7QuYePTI88S1dNu+GJrYTQS9dPx0G+2
        TX3C89ZvgeI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1903F58E2;
        Fri,  7 Aug 2020 13:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 06684F58E1;
        Fri,  7 Aug 2020 13:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
Date:   Fri, 07 Aug 2020 10:43:08 -0700
In-Reply-To: <20200807082643.GA34012@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 7 Aug 2020 04:26:43 -0400")
Message-ID: <xmqqlfiqgxn7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7592B304-D8D5-11EA-B9ED-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Agreed. My only question is whether the possibility of later having
> those other options might influence how we name the two options we add
> now. I think it's clear to all of us in this thread how those two easy
> options should behave, but if the intent is to eventually allow these to
> be mutually exclusive:
>
>   - no diff
>   - combined
>   - dense combined
>   - individual diff against each parent
>
> but orthogonal to the selection of the parent-set (none, all, or
> selected ones) then e.g. "all" makes less sense for "individual diff
> against each parent". I don't have a good succinct name suggestion,
> though.
>
> TBH, I would be happy enough with any of the suggestions in the thread,
> so I am really just finishing the thought here, and not trying to derail
> progress. :)

I agree in principle that the above is a good framework to think
about the issue around "what to do with diff when showing a merge
commit", but I suspect that overly spending our effort to cover the
possibilities become mostly useless mental exercise, mostly because
(1) comparing with second parent is mostly useful only when the
merge was done in the wrong direction (i.e. an attempt by a leaf
contributor to "catch up to the trunc"), (2) octopus merges are rare
curiosity and discouraged due to bisect efficiency anyway, and (3)
even when looking at an octopus merge, omitting some and using only
a few selected parents to view with --cc/-c has dubious usefulness,
as the postimage has to show contributions from all the parents
plus "evil" adjustment anyway (iow, the primary effect of omitting
parents while viewing --cc/-c is to make it fuzzy which part of
apparently "evil" adjustment is what the merge did vs what the
hidden parents did).  These are all examples that show not all the
combinations are useful.

So...

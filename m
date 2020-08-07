Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E25C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E833C2086A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OR8rYXIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHGTBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:01:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59666 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:01:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27AFBEFD11;
        Fri,  7 Aug 2020 15:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=29T52a0zVy9cDVoyjbOD25edz8k=; b=OR8rYX
        IpiHI+OyfSHNfvNHWIkwLLe8I+KCawGdlPY9R73Hv5nbfoNw2TkPR1Sp9O/FD367
        tm3bXhAk32QoRyCHIMBEfOxP2zEtSMLHbXQHF/wUTeohNxHCcQWmDXInPgubP13K
        xgFZGEHRBITrUkg5+BG6mSW/rP3JHe6m50lM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZRVUZ9TkEDiWC2GuQw8AdB2JpG92n1CB
        1qzFVI/79RrvC4S03pAkkBfPxY2LHUMGKrBq1bWyhx6GDmNsvQHrq0eJ57HcZqpQ
        jtKzcyZEqux8xuGkQEYMnaDNXOvyCGSqflbiATduZpZfl3XvuznnXYYPht5z/vYr
        ENQSn5J/SHk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2033EEFD10;
        Fri,  7 Aug 2020 15:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 650AEEFD0F;
        Fri,  7 Aug 2020 15:01:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
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
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
Date:   Fri, 07 Aug 2020 12:01:29 -0700
In-Reply-To: <87364ymji7.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        07 Aug 2020 20:52:00 +0300")
Message-ID: <xmqqh7tegu0m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67D1C97A-D8E0-11EA-9BF9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> I agree in principle that the above is a good framework to think
>> about the issue around "what to do with diff when showing a merge
>> commit", but I suspect that overly spending our effort to cover the
>> possibilities become mostly useless mental exercise, mostly because
>> (1) comparing with second parent is mostly useful only when the
>> merge was done in the wrong direction (i.e. an attempt by a leaf
>> contributor to "catch up to the trunc"), (2) octopus merges are rare
>> curiosity and discouraged due to bisect efficiency anyway, and (3)
>> even when looking at an octopus merge, omitting some and using only
>> a few selected parents to view with --cc/-c has dubious usefulness,
>> as the postimage has to show contributions from all the parents
>> plus "evil" adjustment anyway (iow, the primary effect of omitting
>> parents while viewing --cc/-c is to make it fuzzy which part of
>> apparently "evil" adjustment is what the merge did vs what the
>> hidden parents did).  These are all examples that show not all the
>> combinations are useful.
>>
>> So...
>
> So, does
>
> --diff-merges=(off,none|comb|dense,dense-comb,comb-dense|sep,split)
>
> make sense as covering all the current features?

If we are primarily interested in theoretical completeness, it may.
If we are interested more in practical usefulness, I am not sure if
such a "full flexibility" matrix is a good way to present the
feature to the end-users.

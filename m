Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F0C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88152224D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DraWGYKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHGUjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:39:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55360 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgHGUjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 16:39:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71284878FB;
        Fri,  7 Aug 2020 16:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bX7Z2EF5hixJAHhg5yHryJCimKE=; b=DraWGY
        Km/UWBMj/IrA1s1OYN+SPBn/H8HIIu1Tk2Vr2vU9WtGfsf/LYfTYmzCbmEbu+4fH
        cp7+i1J402R9fXHfiSFSQx8gg1pcDoYr96ukZ6lF/V9YhYJIgrT477PyP3RUgYuC
        82MFJ+oZWzKMsmcgFnADtbACK125RceVM0uSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fE2ZxPF6geJUexfQXXS2Evh2wMJd/ith
        UE6El309Ery1cfiOD/+xNugOk/GZ4z8jlLRu+aAcq7AjLRlXBfQ91c1NwCY666oC
        mX8dojqHwNU9mCJFY5Vy3V2TKLZWUfUic6yaEnzvXR0RQ7QzHQwTK14NUxEm+/63
        NyURiVlr5gs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66F0C878FA;
        Fri,  7 Aug 2020 16:39:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7AC5878F9;
        Fri,  7 Aug 2020 16:39:11 -0400 (EDT)
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
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com> <87tuxel17m.fsf@osv.gnss.ru>
        <xmqq8seqgrx3.fsf@gitster.c.googlers.com> <87a6z6kxmm.fsf@osv.gnss.ru>
Date:   Fri, 07 Aug 2020 13:39:11 -0700
In-Reply-To: <87a6z6kxmm.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        07 Aug 2020 23:29:53 +0300")
Message-ID: <xmqqv9hufaxc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CF9597E-D8EE-11EA-BB20-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I had no intention to introduce --diff-parents, at least for now, and
> maybe never. What I said about it was theoretical discussion rather than
> actual proposal.
>
> If we agree on the above, I intended to instead propose something like:
>
> --diff-merges=first-parent or just =first

OK, so the combined, combined-dense and split were meant to work
with all the parents, and off is the only one that means comparison
with no parents.  That makes sense.


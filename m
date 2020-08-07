Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A1C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1D92224D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 19:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nFsneRdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHGTq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:46:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54012 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 15:46:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 554D8D0168;
        Fri,  7 Aug 2020 15:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IVsrHI9r3sIw0eUHjZeYXu1wjY8=; b=nFsneR
        dB8yroRm3Y7B3dNeiMK4GIkxlHdBgCzDsvk7+ukYF2FVA74caVMGtbyMOEfGiEUt
        WAKduKBP40mjDDMuTKTiIFrlY2R/H3GYFNJqWfgB6yEbuOWValkVQNanc9HPF4Mi
        bkv6IhCvNtTZRzTvbi0l0hqj+gDJ/3tYfdpMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GIPxVFksRFpjVzof43UPXskKR4k/JqVl
        mRjTVmscj093UIbgRZqAw3wnK8qw/aRaL5HPk8DNOKqpY8RshN5OOp0nG5XhjwbS
        XsraU0zdKk9SS+vsHXieCesITqv8OdWdQWtCV1IAWPYq4BiyOejaVKBAIHiOGwAF
        izJ1Z2QdBoI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E74CD0167;
        Fri,  7 Aug 2020 15:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74491D015D;
        Fri,  7 Aug 2020 15:46:50 -0400 (EDT)
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
Date:   Fri, 07 Aug 2020 12:46:48 -0700
In-Reply-To: <87tuxel17m.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        07 Aug 2020 22:12:29 +0300")
Message-ID: <xmqq8seqgrx3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC813DE2-D8E6-11EA-92F7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>> So, does
>>>
>>> --diff-merges=(off,none|comb|dense,dense-comb,comb-dense|sep,split)
>>>
>>> make sense as covering all the current features?
>>
>> If we are primarily interested in theoretical completeness, it may.
>> If we are interested more in practical usefulness, I am not sure if
>> such a "full flexibility" matrix is a good way to present the
>> feature to the end-users.
>
> I thought it's just a -c, -cc, and -m in better wording. No any
> matrix:
>
> -c  = --diff-merges=combined
> -cc = --diff-merges=dense
> -m  = --diff-merges=split
>
> Just separate mutually exclusive options assembled into one multi-value
> option, so it's explicit they are mutually exclusive. I don't see any
> matrix here.

Oh, matrix comes from specifying the set of parents in a separate
parameter.  If we are not doing that, then you cannot even express
"when showing a merge, compare only with the first parent", no?

And when you add --diff-parents=1 (i.e. diff with first-parent), you
are opening the interface up so that it can express dubious
combinations like --diff-merges=dense-combined --diff-parents=1,3
(i.e. --cc but exclude the second parent as one of the preimages).

You also have a redundant combination, e.g.

    --diff-merges=(off,combined,dense-combined,each) --diff-parents=""

would be the same as --diff-merges=off without saying which parents
to compare with.





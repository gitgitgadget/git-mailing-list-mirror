Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E5C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6429C206D4
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ah0ytivg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHETYp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:24:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59182 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgHETYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 15:24:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16E4076257;
        Wed,  5 Aug 2020 15:24:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+C1D4VCKjD1FctvEAsSk20+iY90=; b=Ah0yti
        vgtLvjALJIPBsyUnLm+TNRgwP1oReRWCjZNJytgQGs60a5eH7GIA2hyx7XcUIvHQ
        vZRjzDh6P+bfqGotS82C7CLpj76culmS7uiqcV375aIJYlsRxKgDFnrDYrq2Zl4k
        VsaTfwLrzPILzq76034Pm1E/XSlGddlMUKj4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KLWdo9hRD1miWYMlUWCH7Fc3p3YSV3Xs
        y4ca9d2wUlwG8319wh1c4oxlwkMGU1BvYgxhB3FLqtF1YKFc3mNA+vASoHbiE96i
        idfwxi/rowoL8IEyqufRoBzqkeOov/ae+zSl7QFv3Xr9+Eqdbgl2B8t5e1Nh4KUR
        Fh2W8O5qkY0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DB0076256;
        Wed,  5 Aug 2020 15:24:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79D3F76255;
        Wed,  5 Aug 2020 15:24:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <87k0ydp0hc.fsf@osv.gnss.ru> <xmqqeeoloz74.fsf@gitster.c.googlers.com>
        <87d045nfju.fsf@osv.gnss.ru>
Date:   Wed, 05 Aug 2020 12:24:38 -0700
In-Reply-To: <87d045nfju.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        05 Aug 2020 20:55:17 +0300")
Message-ID: <xmqqsgd0opzd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E5BC6CA-D751-11EA-BA50-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Yes, we can invent the rule that implied options don't ...

"invent"?  It is nothing new, isn't it?  IIRC, Peff's "first-parent
implies 'm' but can be countermanded with --no-diff-merges" defines
"implication" exactly that way.  I do not think that is a recent
invention but it is just following the patterns set by other options
that has conditional implications.

IOW,

	$ git log --no-diff-merges --first-parent -p next
	$ git log --first-parent -p --no-diff-merges next

should both mean the same thing.  The user said no patch is wanted
for merge commits with --no-diff-merges and --first-parent does not
affect it.



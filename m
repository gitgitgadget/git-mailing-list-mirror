Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10182C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A8A206DA
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="csypAfkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHCQfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:35:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53427 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgHCQfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:35:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96E15775C6;
        Mon,  3 Aug 2020 12:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BcdPyX3fZD48Z0UpUR/1mzklstk=; b=csypAf
        kziT/P8BtHOw/P0fAX5xq0a42egC8qK9bX0RpfVVPW5oqEqo9wdiThsbUmnzHkeG
        DH8dizVxn51Va17JKuREMmG9EoEWEedpW2z9qF8wCxwSrO60Z/uxtvb8CwzJ+cs5
        QebPwH7IKLiMnKUHyRxyfgVKURFC6+rhlYsU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hLF6hz6B1KkJZ2XAV0TeUI4Sku45Rvbv
        pJcIKcoyeZZRT9XjrgC/WKS7/RLeV0sRGUApI5S2c4XpTO3BYNCWrl361J5CgSP1
        RnGkMtAfGferAfna0YLDaAUAF2mV+5U+QpjeqATdBzmginS7Ur4xitJnYQlLRA1v
        829jBg9/9HQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D723775C5;
        Mon,  3 Aug 2020 12:35:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A014775C4;
        Mon,  3 Aug 2020 12:35:35 -0400 (EDT)
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
Date:   Mon, 03 Aug 2020 09:35:34 -0700
In-Reply-To: <87o8nrybnb.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        03 Aug 2020 18:47:20 +0300")
Message-ID: <xmqqd047wuuh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B00B9EA-D5A7-11EA-AC2A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Sounds great, I only hoped we can do it right now, with this new
> --diff-merges option, maybe as a pre-requisite to the patches in
> question, but Jeff said it's too late, dunno why.

A follow-up patch or two to remove the "--diff-merges" option and
add the "--diff-parents=(none|<number>|c|cc|all)" option on top of
the jk/log-fp-implies-m topic BEFORE it graduates to 'master' is a
possibility.

But is it worth the delay?  I dunno.

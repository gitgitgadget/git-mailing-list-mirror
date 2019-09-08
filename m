Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EDEA1F461
	for <e@80x24.org>; Sun,  8 Sep 2019 22:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfIHWeN (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 18:34:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63918 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbfIHWeN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 18:34:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E327E8B1B8;
        Sun,  8 Sep 2019 18:34:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPs8Sl23B1KPwdPeu9iTQuUOYsA=; b=dDNFJf
        i+SdJWwMrR3dFqso+jJ0fbsmwNmmfQ6c5qXvB/Tqb5BP86i5PzW9f5HBRkE3+czL
        EwwWwoN0rtpDTOrIaS1hXNhvZBPJ/HhQDIsJJ3Ae940YhDFcsNC/Iqo5H0OyQm78
        Ds+DRukbMtcAw9aDePm/xl+3ZFNrCj8wtyB6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ce+pymS1tyOyrEIXfevtkT3kzqRlqQrU
        Z6fHxMnl9AxIlO3CkNA0jzeXUO0fr5FyRptqP4Rf4Ct7mK6saHo82N/WFJlx66BC
        qGbluCvzIEPFbulqBCVA+JArSF0pHz+drgSKyYmfa7iVZetCcZuIFveuLLhWX6Jk
        qTsjmDHarDw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB8F68B1B7;
        Sun,  8 Sep 2019 18:34:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 185E48B1B6;
        Sun,  8 Sep 2019 18:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Freese <ericdfreese@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
References: <20190907213646.21231-1-ericdfreese@gmail.com>
        <20190907213646.21231-2-ericdfreese@gmail.com>
        <20190908100543.GB15641@sigill.intra.peff.net>
        <xmqq8sqyn6ek.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 08 Sep 2019 15:34:05 -0700
In-Reply-To: <xmqq8sqyn6ek.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 08 Sep 2019 08:40:03 -0700")
Message-ID: <xmqq4l1mmn8i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C56D2EF8-D288-11E9-BCC6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> So in my mind there's an endgame we'd like to eventually reach where
>> the option added by your patch isn't needed anymore. But we're a long
>> way from that. And it's not entirely clear where we'd draw the line
>> anyway.
>
> All true and very good "thinking out loud".
>
>> So in the meantime, this seems like a useful thing, and it
>> wouldn't be a burden to carry it even if we eventually added
>> "--omit=%(symref)" or something.

We can introduce two new options, e.g. --(include|exclude)=<format>
where

 * Without either, there is no filtering based on the placeholder
   expansion;

 * With only --include, only the refs for which <format> expands to
   non-empty are included.

 * With only --exclude, the refs for which <format> expands to
   non-empty are excluded (and everything else included).

 * With both --include and --exclude, only the refs for which the
   <format> for --include expands to non-empty are eligible to be
   included, but among them, the ones for which the <format> for
   --exclude expands to non-empty are discarded.

Then "--exclude=%(symref)" would be Eric's --no-symref,
"--include=%(symref)" would be the opposite (i.e. "show only
symbolic refs"), etc.

I guess with "%(if)...%(then)...%(else)...%(end)" you might be able
to do either one of --include/--exclude without supporting the
other, e.g. "--include='%(if)%(symref)%(then)%(else)not a
symref%(end)" would be usable as "I do not want to see symrefs" in a
system that supports only "--include" without "--exclude".


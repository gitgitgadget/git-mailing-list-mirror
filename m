Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE6C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D0820838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WVHtpSd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbgJLRJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:09:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64336 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404055AbgJLRJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 13:09:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 15B62F08E9;
        Mon, 12 Oct 2020 13:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wLHWQJd1bMz0tb6KvREwnePHAVw=; b=WVHtpS
        d1tompngyit15XIkXaFIqDSk4PO14Qrult6teqW/6Lzazw2kTRF5yj9nQmgN3Uu0
        GB59E5W/6LzLETIJMaI+E956P3EKQ8WkA9nWzv25sMpNHPlqcJz0DYwWbLgay+bY
        Hn6B112JhiCWG+T69On/rb0dN7RjhdIpd+biA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dy5AruPpCOc1ssbWMBjdw9WwA0mf6RUI
        mmcYHK/9fNFKIMi6Nlvq6pLGq9dm78sYlhP+Z7C2P78PdJHCYCYSjecBV3lJgs8R
        Dnf7HKKk5lU+WZ7cX0T85+EF0pqAZ5Vj4oQlCrpqxzVp6zHpjlgGaMKeccsq2e2o
        QcUqCto+39E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E686F08E8;
        Mon, 12 Oct 2020 13:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A32EF08E7;
        Mon, 12 Oct 2020 13:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] merge-base, xdiff: zero out xpparam_t structures
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-2-michal@isc.org>
        <nycvar.QRO.7.76.6.2010121313020.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 10:09:10 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010121313020.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Oct 2020 13:14:50 +0200 (CEST)")
Message-ID: <xmqq1ri3qsll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A64CAC6E-0CAD-11EB-92CD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  	xpparam_t xpparam;
>> +
>> +	memset(&xpparam, 0, sizeof(xpparam));
>
> A slightly more elegant way to do this would be
>
> 	xpparam_t xpparam = { 0l };
>
> Or even
>
> 	xpparam_t xpparam = XPPARAM_T_INIT;
>
> with
>
> 	#define XPPARAM_T_INIT { 0l, NULL, 0 }
>
> in `xdiff/xdiff.h`.

Let's not suggest any of the above.

I think we had a recent thread [*1*] on which we agreed that "{ 0 }"
is the way to spell "a naturally zero" initialization like this one,
if we were to spell it out.

TBH, I'd say that memset() is also OK as-is in this codebase as an
established way (git grep 'memset([^,]*, 0, sizeof' gives too many
hits).

Thanks.


[Reference]

*1* https://lore.kernel.org/git/xmqq4knca7c6.fsf@gitster.c.googlers.com/

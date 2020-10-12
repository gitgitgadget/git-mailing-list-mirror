Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C2C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC0B20797
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 21:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hX2Hos58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgJLVnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 17:43:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56937 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgJLVnF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 17:43:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F05C98E3AB;
        Mon, 12 Oct 2020 17:43:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PNzB+WUS6KKXaLoMK2o21P9CoH0=; b=hX2Hos
        58e6JCaKDJE5m5hrasVPY6pELcA+gr5CMVU0743POYH3g8esHwNSW32EaFAM4yhV
        yVYbTZEVGwZYERYgsGRr/Q9bStknvuytXuIb2b1MLKJz/tqbM730Lv8N4ZKEqlSS
        MBL1UYGOVHbltcvRnzVQ9NsoOxJLGXvZ+KH50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LlBkoLSa+4/dz2fyzVNkGCm+/2cSqqSb
        PhvHFPhyoqPPcZ6Jz4VR6rDzY8SS42n23QWePDxZMrQQ0H09oBeZh7EPuOsYFVYD
        FLD+8z9lHxRkyMnm2VIFYNtgM8fePruYIe16MGXhC3ZFnRssdg9RcFhgzHb4i0ZE
        YqWuwgnUofI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4FEA8E3AA;
        Mon, 12 Oct 2020 17:43:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 567568E3A9;
        Mon, 12 Oct 2020 17:43:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-3-michal@isc.org>
        <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
        <xmqqo8l7nrjc.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010122236130.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 14:43:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010122236130.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 12 Oct 2020 22:39:20 +0200 (CEST)")
Message-ID: <xmqqpn5nm87u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7556E6E-0CD3-11EB-8960-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> the use of `xcalloc()`, and now that I think further about it, an
> `xmalloc()` should be plenty enough: `regcomp()` does not need that struct
> to be initialized to all zero.

Yup, I think it makes sense.

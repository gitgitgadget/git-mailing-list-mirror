Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DBD61F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 20:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfHLUFD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 16:05:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61414 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfHLUFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 16:05:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2BFE868F50;
        Mon, 12 Aug 2019 16:05:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Yc4TcyxqR1/VW+wHjXeMW/eJdw=; b=gNe3Fa
        SnKA9nQ1YnH5RTcnV+ArO5/zmqaeag4+HdANnDTmoV/ZXI4LegBhUsYCVlOww0gA
        v/0y11+27ZF39hf5EjQex63uDquLkEkDWsBWrKhiqthWm/POmffr0LaVVWPItYoI
        yHbPaEmUBiQ1xoEqce24E9bhbaxlHyr5N9v8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gdTIWKqYNDZ5isPA8JdKqLvmDCF+povI
        zrAJ6fFwDRU4jGnk+XFPGtsIyIyRMynJhyEyQoLuMmPZCzklrn6Ytrh5IRB5NnH2
        hPiEzbtHpv0CPDEvlLEvMaoto1UH/sd7RqalIDpwbfPYmf52+N/zw41VOT9iESNK
        T7cYLEZgJYU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2422F68F4F;
        Mon, 12 Aug 2019 16:05:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D5A268F4E;
        Mon, 12 Aug 2019 16:04:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, l.s.r@web.de
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
References: <20190810220251.3684-1-carenas@gmail.com>
        <nycvar.QRO.7.76.6.1908111317540.46@tvgsbejvaqbjf.bet>
        <CAPUEspg62pRNH6=_VvWDxQ4YujHUJAoTTampc0L4t68QMj30xg@mail.gmail.com>
        <20190812195537.GA14223@sigill.intra.peff.net>
Date:   Mon, 12 Aug 2019 13:04:55 -0700
In-Reply-To: <20190812195537.GA14223@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 12 Aug 2019 15:55:37 -0400")
Message-ID: <xmqqd0ha9ml4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7530DCAC-BD3C-11E9-B60F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it might be worth just eliminating the whole idea.

I kinda like the simplification ;-) An even thinner wrapper that
calls malloc() and dies if it gets NULL, without any "try-to-free"
logic.

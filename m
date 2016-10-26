Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783052022A
	for <e@80x24.org>; Wed, 26 Oct 2016 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934020AbcJZQIr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 12:08:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932356AbcJZQIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 12:08:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1839847CE5;
        Wed, 26 Oct 2016 12:08:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+piNM4THnfPS9MHDxahO2d4vobc=; b=LnKU8v
        pLStXXNCTbYWnl0vX8jBaMickfe7cpTiSn1ag3KxkFtBt1LQkGXm7PA3QdbH0w6w
        yyoL7UQ7h0pLqEETodTP51SmkU2qvmlw8DaQd5gIbkn/VT5uiUYFlC8xLCkojcn7
        oW0r9+0SEY4H6rhfQpw9bTXmE9swJKmPADqp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ujlPRAN/EnZAGo8xezW8ZltM88LbEKBT
        L2JHcHczcqLHlFC3nI8oKm/pd9mGmhcZ24zbSlnPkPgBNtAINVB+TdRX/c3ggzL9
        kBt15T1JI//Fr+BTR/cvZ5lA+0HmlHURI65bk/Ypt2UdKNWgsTx6uCOlh9+QgzbD
        M3JRSHFhP1M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EF0147CE4;
        Wed, 26 Oct 2016 12:08:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 823E747CE3;
        Wed, 26 Oct 2016 12:08:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610071319520.35196@virtualbox>
        <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
        <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
        <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1610081034430.35196@virtualbox>
        <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
        <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
        <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
        <alpine.DEB.2.20.1610111142490.35196@virtualbox>
        <20161011150118.7eb474yg5c3oe5mn@sigill.intra.peff.net>
        <CACsJy8DUqrsaqmrCHzzuS3Q7DXRAPkisOJbSmYPX8-AhmNUz6w@mail.gmail.com>
Date:   Wed, 26 Oct 2016 09:08:41 -0700
In-Reply-To: <CACsJy8DUqrsaqmrCHzzuS3Q7DXRAPkisOJbSmYPX8-AhmNUz6w@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 26 Oct 2016 20:23:16 +0700")
Message-ID: <xmqqinsfccty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77A5547E-9B96-11E6-9532-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I don't object the alias.<name>.<property> approach though. It's
> definitely a cleaner one in my opinion. It just needs people who can
> spend time to follow up until the end. But if someone decides to do
> that now, I'll drop the "(properties)!command" and try to support
> him/her.

I don't object to either approach, but what I would love to see
people avoid is to end up with both.

Thanks.

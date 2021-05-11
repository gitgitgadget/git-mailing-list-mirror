Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F7C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544D76146E
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEKVeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:34:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60544 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:34:15 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 344AC13D378;
        Tue, 11 May 2021 17:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kfw+nENUqBSDM37MI5yLmXTDu1TjBv81sJOXuQ
        9JHYM=; b=PtAhgwQ4jk2C/PMZKQoAMojrmjJb2k8em9P3A3tET8Sy0tqFSAqqsN
        PvjBNo5K+Yp9rMT5nAzdbPXeXBofE5S+ALvMjZ3inEhiBseBg/1QQXBsZOwlj9vD
        NxREFQPNCIh6zgNP190EUbrAoTTgQqMAxfWPevTv/oYKNrlxcSAKw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C84913D377;
        Tue, 11 May 2021 17:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56B0013D376;
        Tue, 11 May 2021 17:33:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
References: <20200404142131.GA679473@coredump.intra.peff.net>
        <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
        <xmqqv97w1wl1.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
        <xmqqh7jfy3du.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105111632380.57@tvgsbejvaqbjf.bet>
        <YJrGOqjS10Z/WkE8@coredump.intra.peff.net>
        <xmqqlf8lkmwo.fsf@gitster.g>
        <YJryDGSliWvvABDB@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 06:33:03 +0900
In-Reply-To: <YJryDGSliWvvABDB@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 17:07:24 -0400")
Message-ID: <xmqq4kf9klbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78A7C61A-B2A0-11EB-B7AA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So switching to "return errno ? errno : EIO" does indeed work here,
> because the compiler now knows that the result of that return will
> always be non-zero.

OK.

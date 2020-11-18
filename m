Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD61C56202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 05:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8980624654
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 05:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpEtwp6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgKRFok (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 00:44:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRFok (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 00:44:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECF1B828D1;
        Wed, 18 Nov 2020 00:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RIcia2FD7fr3FLYJLGDH8r4xhDc=; b=gpEtwp
        6/m+0ttlOfPGsl7hxmo8Z5Yv8BltHu+676GjtxnO8u9Iplvd1jqXq/yFenDm5XU7
        XU6UcAq4TvWahcMct/c8Z2zGh/r96nqWWkL3tXYdPFdC88r5f+do6f+18+vb9go+
        XJOari5tKyy43gy5/PGZM0pEguJ1uMlMUaz8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K2do2Zb0/HPb+WirI1tsMh/JG8x2v5eC
        qB5qV88UqVWx8ARaPCbs4gtSuFwMQmFzsUOzXv0w6ON0VLgix3YDbAxcPqLDg9u2
        07yvyuoP8DX4GbPs5qJcnsqpiOfjUWBh1N4Ag6MKySySCHT30/09FLBWZ6HQQJxy
        AvfkHu2S7yI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4C4D828D0;
        Wed, 18 Nov 2020 00:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6DEC6828CD;
        Wed, 18 Nov 2020 00:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
References: <cover.1605269465.git.ps@pks.im>
        <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
        <87mtzlflw7.fsf@evledraar.gmail.com>
        <xmqqy2j1851k.fsf@gitster.c.googlers.com>
        <20201117023454.GA34754@coredump.intra.peff.net>
        <20201118005014.GC389879@camp.crustytoothpaste.net>
Date:   Tue, 17 Nov 2020 21:44:36 -0800
In-Reply-To: <20201118005014.GC389879@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 18 Nov 2020 00:50:14 +0000")
Message-ID: <xmqqeekr43sr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25068B7C-2961-11EB-81B8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I don't personally love shell quoting as an interchange mechanism; I'd
> prefer something like URI-encoding, which is a bit more standardized and
> easier to reason about from a security perspective.  But if we decide to
> change it, it doesn't matter, since it's still undocumented and this
> would be the only acceptable way to pass config through the environment.

Surely.  

I am kind-of surprised that nobody has brought up json or yaml ;-)

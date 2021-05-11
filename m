Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B5FC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62447616E9
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKVDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:03:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64331 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:03:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6D2AC3E4D;
        Tue, 11 May 2021 17:02:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Czd9lyScZ4zs8b3uvM+LvNn/dMdSvDAM+NS8DU
        X26T0=; b=sIXeok/3sg5Game5yod/7yrXSf6PfFgXqrS12u92U12DyHUYKOYMXI
        Q0s/V8tcTEVAfcbQ/hoUHCYYsiPZ06upVpMhpxBVZ3cTEecj7Aarkuqyjh7APBJx
        SPrtJ8UHxfUQU1infiJE0UFwKfY8Y3xhg+E3Y7DD83gF2Zjhsp0YQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEBC5C3E4C;
        Tue, 11 May 2021 17:02:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 48AD3C3E4B;
        Tue, 11 May 2021 17:02:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] remote-curl: fix clone on sha256 repos
References: <20210511103730.GA15003@dcvr> <874kf9tjgj.fsf@evledraar.gmail.com>
        <YJrMNmH92mKrIX0N@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 06:02:22 +0900
In-Reply-To: <YJrMNmH92mKrIX0N@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 14:25:58 -0400")
Message-ID: <xmqqh7j9kmqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EB47750-B29C-11EB-B13C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There are specific dumb-http tests in t5550. And I think we can and do
> run the suite with GIT_TEST_DEFAULT_HASH=sha256. But I suspect that
> covers up the problem. If I understand the problem correctly, it comes
> about when the client thinks the default hash is sha1, but the server is
> sha256. Whereas GIT_TEST_DEFAULT_HASH affects _both_ sides.
>
> So I think we'd want interop tests in t5550 that specifically create a
> sha256 server and access it with a sha1 client (and possibly vice
> versa).

Ahh, you're right.  Such a combination is worth testing but is
tricky to arrange.

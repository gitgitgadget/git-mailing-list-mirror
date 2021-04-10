Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF88C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E14361026
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhDJBoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:44:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56638 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJBoK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:44:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5311BE781;
        Fri,  9 Apr 2021 21:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JxCXLRDvADK5x7Fj77ZwkdJaOPs=; b=LDeJhO
        4dFHxF0QdO9YzBF8Ti8QF9B1az+668aBHImQG9Tbs4XChxqb5XINnFzFpHHK+N3z
        LV1qz0ZFz/WXeJbKpAtnlDAdvRuLFNlgEnbkOVOo5rT1AmHp68wdp5xSnRr53Wdq
        4tJQ1yg/QBJJNOyVzJ9W8uCt7WJTMADcnre7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VvyYs+uYyzWX4sJFrHgFFqzzMKdjRX6q
        vnQGea6WG5ggXHF47dNLgt5A0r7/CwHv+HMNzFB6jvgYFzd4KIDQoGGnOKFHtYUj
        z6vELirOHnqW3hIAXvaBlkNinbVTIUVGWD8k4rWBm59iYn9c6cWOusCOcWD4hbpu
        VrSNbH0lO1o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC6E9BE77F;
        Fri,  9 Apr 2021 21:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E3B6BE77D;
        Fri,  9 Apr 2021 21:43:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
        <xmqqa6q8tymu.fsf@gitster.g>
        <YHCzhcBkqdeEMrWA@coredump.intra.peff.net>
        <xmqqv98vm7lt.fsf@gitster.g>
        <YHD+BMo35krbH9rx@coredump.intra.peff.net>
Date:   Fri, 09 Apr 2021 18:43:54 -0700
In-Reply-To: <YHD+BMo35krbH9rx@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 9 Apr 2021 21:23:16 -0400")
Message-ID: <xmqq8s5qlxr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35FED8B4-999E-11EB-BA89-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So a function like:
>
>   int git_parse_tristate(const char *value, int *out);
>
> which returned success/error via its return value, and put the value
> into "out" would feel pretty natural to me.

Yeah, with s/tristate/bool-or-auto/, and if we do this throughout
the types, that would be ideal.  FWIW git_parse_ulong() and friends
for sized numerics already follow that pattern, but helpers for
boolean like git_parse_maybe_bool() don't, which is unfortunate.

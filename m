Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17621F461
	for <e@80x24.org>; Wed, 17 Jul 2019 20:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfGQUKj (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 16:10:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54821 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQUKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 16:10:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29A5416C6EB;
        Wed, 17 Jul 2019 16:10:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3nxt8EcMO4KO2ZosQhtqJzwoyOM=; b=SM+rhw
        cOdlWaZ2m1hoj4EGgO0i4tGhZ3SOhL9tJK5JFETA8YxHAWHDImE/7GNpMKzpI3HZ
        6AkZPvog5twdDziEqQWUZUUt/QJCCEYcL96FRXR6OjaPH0Smo7iHBqAjQhApwczF
        Pu5vUjdqxxyauF9BLjk0Khk9bER/bOPD8Ml4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=coNM303/3J44J42yMVJt6LQXHlEgkTM5
        b+X7dsd9RMPgzDWt9WMLd5cXQlwvm9MSJFbKnpdklCvv/++3qsNaB01K01a/dtsJ
        EK98yADeICslNTr/3zpFjtcfGSfCvrCjfPPQM53DBZ6jkiJcnzLRtQX+F/A6wgcF
        J7ryRZ1n8oY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2047316C6EA;
        Wed, 17 Jul 2019 16:10:37 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8599216C6E9;
        Wed, 17 Jul 2019 16:10:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
References: <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
        <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
        <20190714005129.GA4525@sigill.intra.peff.net>
        <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
        <20190715144602.GA26636@sigill.intra.peff.net>
        <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
        <20190715181527.GA30747@sigill.intra.peff.net>
        <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
        <20190716200101.GA6558@sigill.intra.peff.net>
        <xmqq1ryo1qdr.fsf@gitster-ct.c.googlers.com>
        <20190717192121.GA5447@sigill.intra.peff.net>
Date:   Wed, 17 Jul 2019 13:10:35 -0700
In-Reply-To: <20190717192121.GA5447@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 17 Jul 2019 15:21:21 -0400")
Message-ID: <xmqqmuhczakk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0A5D1EE-A8CE-11E9-8FB6-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Other than that, our options seem to be:
>
>   1. Live with it. IIRC we're already not sparse-clean, and Ramsay
>      mostly looks at the diff to find new problems.

OK.

>   2. Pass -Wno-non-pointer-null to sparse. Unfortunately that also
>      disables more useful warnings (like passing "0" instead of NULL to
>      a function).

Non starter, I am afraind.  The loss outweighs.

>   3. Switch to NULL here, and adhere to that going forward.

This does not sound too bad.

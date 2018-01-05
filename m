Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C74A1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 22:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeAEWUQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 17:20:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51023 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeAEWUP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 17:20:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9EF93CAEFE;
        Fri,  5 Jan 2018 17:20:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vsi9sTRNNBGxsn5E0E17PQZTbY4=; b=a6O1XP
        MvFXWDXxLg0JY9SnjmkArP8rTWe5cLOOt8T7sP1A67FonTbYI0aGRWqzKZND5UUu
        qGfPy1icQvDMX9WtH9H12ZmshmI53EO4PNLysNqsqWzZnhS9kYDIStqNRs12q6XX
        ZqbjKQ1fDzTIBFlQspoVclT7SoQ7hnXhzNBFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZqCUnF6aoYeDvG65SIi7idNc7gnsSL6c
        8/ATj+b8/goworLZ7xXCJ0AurA/gAVjdyFxDT59HGb1F5c1CfAQB8/4EcreQf9VH
        aABgZkVNaJjEPIdYksKndW+xKtbANTbKNq17jSrUh0lrn3Px7Urg/aBpxS/EeBn4
        P1KW1ZrFxM0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9764ACAEFD;
        Fri,  5 Jan 2018 17:20:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D3FCCAEFC;
        Fri,  5 Jan 2018 17:20:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
References: <CAELBRWKYZK2tVhGZSExXRXrRB94jFN-4N3d=iKARzEsqLu7k1g@mail.gmail.com>
        <87fu7nc9a2.fsf@evledraar.gmail.com>
        <CAN0heSrZ4dEFqNX69PgtGCERJKabokz88v-vnNZkUBXfK118mg@mail.gmail.com>
        <CAELBRWK6Y=-7WBwai16dBKd8OLxdXWOiZMALVJXrP9ak8gF-LA@mail.gmail.com>
Date:   Fri, 05 Jan 2018 14:20:11 -0800
In-Reply-To: <CAELBRWK6Y=-7WBwai16dBKd8OLxdXWOiZMALVJXrP9ak8gF-LA@mail.gmail.com>
        (Yasushi SHOJI's message of "Fri, 5 Jan 2018 11:45:43 +0900")
Message-ID: <xmqqincgaqxw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98BF0452-F266-11E7-8A47-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yasushi SHOJI <yasushi.shoji@gmail.com> writes:

> The patch (actually, I've tested the one in pu, 2e9fdc795cb27) avoids
> the seg fault for sure, but the question is:
>
> When does the list allowed to contain NULLs?

A very legitimate question.  With the proposed log message alone, it
is even tempting to declare that the change may merely be sweeping
the issue under the rug.  A bit better explanation is needed, at
least.

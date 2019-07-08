Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2451F461
	for <e@80x24.org>; Mon,  8 Jul 2019 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbfGHR64 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 13:58:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59156 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfGHR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 13:58:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A83596A1DA;
        Mon,  8 Jul 2019 13:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EAUNeEm2HNQx0+oCmB3JhDebCQk=; b=ZeDNF6
        0BvjlMtvYO6MOmmolbHIkPG/KYDVCyEg0lRomCvHv+vE7+r6B7S0+LuYyfXpGRqm
        Brg2Kgr/lQWWL8eIBlLEBzx6EfOs2N/SaK2jnuzMDFWy6HjtU4s9lhTQ2M60iGd3
        iFfTdHqrfF5ijpio+ii1h5Cj5ExseknYqmKzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AR4E6vuIVEXuLQ6PrqadASmTIFuQz9uB
        VwU185I+cRd7LrV/lmYvtDWbVKEF3AUBjCt/AGoF3CKTdxktBe3bRUcp8hp68Xpy
        I/N2TdW9WE9XYUF/6RsqEYFb2ez+b7NnKYvjUKgwRmKnYzxV4m8+ZXXTp88y82vG
        xRjuO0x0qwE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EED56A1D8;
        Mon,  8 Jul 2019 13:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC5076A1D7;
        Mon,  8 Jul 2019 13:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
References: <20190624130226.17293-1-pclouds@gmail.com>
        <20190624130226.17293-6-pclouds@gmail.com>
        <20190704200133.GD20404@szeder.dev>
        <CACsJy8CZZAkcuN_hqp6YmMkhKs0ON6b-+Cyo+Q+Jk4zFh0Ve7w@mail.gmail.com>
Date:   Mon, 08 Jul 2019 10:58:50 -0700
In-Reply-To: <CACsJy8CZZAkcuN_hqp6YmMkhKs0ON6b-+Cyo+Q+Jk4zFh0Ve7w@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 5 Jul 2019 06:54:49 +0700")
Message-ID: <xmqqd0ikz9ut.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BF3DE22-A1AA-11E9-9C91-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The command is to dump .git/index, not the shared one. And since this
> is not a split index test, rather a (quite low-level) json dump test,
> I did not bother to also dump the shared index, which should look like
> a regular one. Producing a unified view in json might not be easy with
> the current code because it's tied to file reading code, nearly stream
> out json as we read the file, and split-index requires a post
> processing step. I could contribute a python script or something to
> combine shared/main index together. That way you can still see the
> combined one, but we don't have to add/maintain more C code.

Well, such a post-processing is something external scripts shine at
and exporting the internal data in json format is exactly to support
these scripts, so it may make a good first test case ;-)

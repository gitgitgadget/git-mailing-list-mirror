Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A5D1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfKHIeo (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 03:34:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55846 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIeo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 03:34:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC86C9D20B;
        Fri,  8 Nov 2019 03:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3T4Uhj82lrJ2xcjs+id3sHD8JK8=; b=x4ym7b
        JoC240Xu6gANcRL1gaMMUA0HpiHife/4JqdXv5lMYAlNcdng6ck1qjgJY9PyIyt9
        AjV1ZtA+QLLfNG/NwrD1ZFAoaIZIe3zTFRqrZT0CcWJivew/LqzGng26dSS6CGGm
        7Eq3+iQpaHjTcb+QfAukrvrWYCTyfeVdqKVbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wf0KXKiCiRurZ+9lIIlPoCLizfghcY8K
        fiuAlCXlYGClzhEUNGXlMK2BbGGt+9xCz7jsIpvJSIQEgA5ToG1Ja4VoS9PuIhh0
        Hg/sEouOxFVzkaa9gSPqmResEbJwtGaphHAI1adu/21pQF/DPTurYqzjbjFmbQBK
        4iMMErWAM5A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C55CD9D20A;
        Fri,  8 Nov 2019 03:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F0B0B9D209;
        Fri,  8 Nov 2019 03:34:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom allocators
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
        <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com>
        <20191106041644.GE4307@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1911061009230.46@tvgsbejvaqbjf.bet>
        <xmqqsgn1tjup.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911062029230.46@tvgsbejvaqbjf.bet>
Date:   Fri, 08 Nov 2019 17:34:38 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911062029230.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 6 Nov 2019 20:38:46 +0100 (CET)")
Message-ID: <xmqqimnun4v5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B7C12CC-0202-11EA-957A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... which was broken in non-US locales (most notably in a Japanese setup;
> apparently there _still_ are developers who did not yet move away from a
> Japanese locale... at least on Windows).

I think the above was a reference to a tangential comment I made in
a response to Peff.

Oh, I do not expect Japanese Windows users would "move away from"
Japanese locale, ever.

I do however know that an app that supports only legacy encoding is
frowned upon these days.  They still use and will keep using
Japanese menus and messages, and they still write their documents in
Japanese and not in US English.

But they store their Japenese documents encoded in UTF-8 on their
system that is in Japanese locale.

There are two models of gadgets I am interested in getting, between
which one of them that is slightly older supports UTF-8 and MS-Kanji
(aka Shift-JIS) while the latest model only supports MS-Kanji.  The
list price of them are comparable (actually, the latest one lists a
bit more), but the latest model is deeply discounted while the other
one with UTF-8 is not as much.  At shopping sites, user reviews
often mention "I've migrated my text to UTF-8 already and going back
to Shift JIS in this year is too cumbersome, so I'll skip this
latest model".

I am hoping a software update might happen, and will pull the
trigger once the latest one starts supporting UTF-8 ;-)

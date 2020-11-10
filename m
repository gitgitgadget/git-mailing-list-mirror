Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D9C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E7D208CA
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 17:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CyEeM/1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgKJRUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:20:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53700 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbgKJRUo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 12:20:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 780D399731;
        Tue, 10 Nov 2020 12:20:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uE5R3ayLWydmtOgCdVC9o54WdLY=; b=CyEeM/
        1OFpBeioDsCVvgwpN/BJDkrtecRtTkYxOliWNV4uqIZamZOfe8v9V+f+AyjrPgB1
        eLeyXSZxZYV8Gh9UE5lYHC18zIRNdlsxD3PfJ8cLImELjLXnuJ1k6wGNNqeemw0v
        bF9p33Q2stNHbqQaXHIcx+T/zBq7TKPXG6Gkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VUyv2tE10Strj9Q9KglwU0qrTJv8jsFu
        1uqnr52zjZT3lOa/i24yX01A9SpCmMW9KMofeJKAJAeP5MLc735bk/WdHnTyAGFc
        FcDxozhy60uMz0JdlT/84bl8Uqd6HdFkiCr3TT60ql2k0QhY3OETU08CXb2gG/Rs
        3UAgCSC8ISg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7065399730;
        Tue, 10 Nov 2020 12:20:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB4479972F;
        Tue, 10 Nov 2020 12:20:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Daniel Gurney <dgurney99@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
References: <20201107234751.10661-1-dgurney99@gmail.com>
        <20201108095739.23144-1-dgurney99@gmail.com>
        <20201110003127.GA1268480@coredump.intra.peff.net>
        <20201110023620.GH6252@camp.crustytoothpaste.net>
        <xmqqft5h92fm.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet>
        <f41271c0-973d-ee3f-9535-d7fbc5b073cf@gmail.com>
        <nycvar.QRO.7.76.6.2011101643460.18437@tvgsbejvaqbjf.bet>
Date:   Tue, 10 Nov 2020 09:20:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011101643460.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 10 Nov 2020 16:47:17 +0100
        (CET)")
Message-ID: <xmqqy2j96sd4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E1E7692-2379-11EB-9EE0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As a maintainer, I am less concerned about the "result today" than I am
> about keeping things easy and effortless to maintain. One of your patches
> accomplishes that. The other one made it into `next`:
> https://github.com/git/git/commit/91a67b86f77

I do not think reverting it and requeuing

https://lore.kernel.org/git/20201107221916.1428757-1-dgurney99@gmail.com/

would help future folks why we ignore _MSC_VER as any sign usable to
detect endianness, so I'd prefer to see a patch *on top* of 1af265f0
(compat/bswap.h: simplify MSVC endianness detection, 2020-11-08),
which is 91a67b86f77^2, that explains why we prefer to list archs
explicitly in its log message, which would be the primary value of
that commit.

Something along this line, perhaps?

-- >8 --

Subject: compat/bswap.h: do not assume MSVC is little-endian only

Earlier, with 1af265f0 (compat/bswap.h: simplify MSVC endianness
detection, 2020-11-08), we tried to simplify endianness detection
used in compat/bswap.h by assuming that any version Git compiled by
MSVC (detected by _MSC_VER preprocessor macro) is meant to run on
little endian boxes, as the versions of old MSVC that support m68k
and MIPS do not support some C99 features used in the codebase
anyway.

While it might hold true that modern versions of Windows are all
little-endian, MSVC is and/or can be ported to build for big-endian
boxes, so tying _MSC_VER with endianness is a bit too restrictive.

Let's go back to the old way to use _MSC_VER to learn what
preprocessor macros compiler uses to tell us which arch we are
building for, and list these arches that are little-endian
explicitly.

... signed-off-by from you and helped-by from others ...
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
    diffstat
    patch


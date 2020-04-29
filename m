Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B707AC83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A1F2085B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 12:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sorrel.sh header.i=@sorrel.sh header.b="HxA7LZku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgD2MgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:36:07 -0400
Received: from balrog.mythic-beasts.com ([46.235.227.24]:35773 "EHLO
        balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgD2MgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 08:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sorrel.sh;
         s=mythic-beasts-k1; h=Date:To:From:Subject;
        bh=vRmlx4uFJYZKCiAr/6VYwY9EE3/UYlcWQZNXSOvFP2E=; b=HxA7LZkukv6ZQHmqv8M304KCwv
        DnFhrlkdjJuY3OWoPib+/kmif3T3YzlZS5g2X2vzKI6gy2cm3LmG4hj7nvRXJndqk3+cn3ECrDq+y
        QHaCfPTtMO31GLwH1LzMQvbZp0XLeCEQet6srKbHPEpKcuyAaicFDtUPwEQf8yIZSjnMGGUnGSBXm
        eluLFoK3W7HBpjrfpP0QP9fgRJl9iF7Oo4D62ms3OiHaTM0YbsHpYw3pZ+X9Mx0/s/8QBn2LD1JJZ
        Wp08ox6zYQtuVfLZsCjH33/0xgqLCVS0l0jAh4TmIbtmd+bTh3U8HDpqzYDmEJ21/wEfEMR3bYaLi
        LFwIX8mg==;
Received: from [212.56.100.202] (port=56887 helo=localhost)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <ash@sorrel.sh>)
        id 1jTlwW-0000Vc-CB; Wed, 29 Apr 2020 13:36:04 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Boxuan Li" <liboxuan@connect.hku.hk>,
        "Alban Gruin" <alban.gruin@gmail.com>
Subject: Re: [PATCH] userdiff: support Markdown
From:   "Ash Holland" <ash@sorrel.sh>
To:     "Johannes Sixt" <j6t@kdbg.org>
Date:   Wed, 29 Apr 2020 13:21:13 +0100
Message-Id: <C2DOR3QPGHWC.2H494OQI75ZRW@what>
In-Reply-To: <91ff4bdb-9b53-8fd1-6282-ac19a9caf1d8@kdbg.org>
X-BlackCat-Spam-Score: 39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri Apr 24, 2020 at 8:21 PM BST, Johannes Sixt wrote:
> Am 24.04.20 um 01:42 schrieb Ash Holland:
> > On Thu Apr 23, 2020 at 9:17 PM PST, Johannes Sixt wrote:
> >> Am 21.04.20 um 03:00 schrieb Ash Holland:
> >>> diff --git a/userdiff.c b/userdiff.c
> >>> index efbe05e5a..f79adb3a3 100644
> >>> --- a/userdiff.c
> >>> +++ b/userdiff.c
> >>> @@ -79,6 +79,9 @@ PATTERNS("java",
> >>>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >>>  	 "|[-+*/<>%&^|=3D!]=3D"
> >>>  	 "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> >>> +PATTERNS("markdown",
> >>> +	 "^ {0,3}#{1,6}( .*)?$",
> >>
> >> What is the purpose of making the heading text optional? Why would you
> >> want to match a sequence of hash marks without any text following it?
> >=20
> > Strictly speaking, a markdown heading is allowed to be empty -- see for
> > example https://spec.commonmark.org/0.29/#example-49. I'm happy to
> > change it if you think it's more useful to show a previous heading whic=
h
> > contains text than an empty one, though.
>
> I don't know what makes sense, I don't write markdown regularly. A quick
> check shows that the sequence of hashmarks appears in the hunk header.
> Is that useful? (A genuine question!)

I think probably it would be more confusing to have Git silently ignore
empty headings, having occasionally written documents with empty
headings in the past (e.g. when I know I want some different sections,
but I don't know what to call them yet). Probably not many people would
ever run into this situation either way, though.

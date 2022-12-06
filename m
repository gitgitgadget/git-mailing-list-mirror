Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D62EC4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiLFCE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiLFCE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:04:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A00E23E8B
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:04:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n21so2769449ejb.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WhgDoQru77FvtO8XquSaPHKQX9MpaQnYqsQ1wb0++a4=;
        b=Dwh66fCf8P+4AVa5OYl5TIwdNr/gGh60doZLuZPKXAbpQie1d2mIE/JEziLNSzkEv7
         EsDIuWg4dIcCpcUxM0lNxggxV5Gozkd4Vn5qR8uLaxkcUgpns637tTyXAPnzuyRuAHb3
         EE5ie0CnAYxqCb1EZ0T+J8lkXbueaJd+6bY2zkdxWSI+ITOurFm2EOcOWQoRwzejtSHD
         GcF6Py5ozMbO4N95KTWbXS+HgmtCwtEZJ9ZCUraomx4npq+S3v7lVZBctzfw6d7W3vG+
         A0pUvYiDybpNnaXg3EKMoJ1DnrMopAn8L+0oeiZiCqI8wGS2kcI7sG5YiYbwFhwGvKo/
         uItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhgDoQru77FvtO8XquSaPHKQX9MpaQnYqsQ1wb0++a4=;
        b=sgJ0kBJ0hui2AFM5TB2XKZKisJXXFMpRa7TIHUwzZ214rfC/UnsGd+H0m45VoDOrIN
         W0ED+a+8RXSxJjXePtax5CP91EgXdZPY1H6RmwIRZ2F5AC3b9JW5ZM2s+Vyz3D+RjwWn
         lTAXSbecHIPFX6YPKKKEFBP3hoU/U8GzdUInfW1/ZcDFd3bJ/P8mrxlR8Pib3fXhylCN
         gGpk300JqKmrIyKinl+wgCTTDOMNjCbNYuxvO2YIZcnEPnkpYtoMGC6mbv09Mlb+UTPe
         4QdINuMBe5daHBIAiUfORqED+8ysJrIvFHC00XCPeg8Qop9lSOQNspr2tjG8SlkBBEEJ
         kqKA==
X-Gm-Message-State: ANoB5pneKr8VRmaCXAgbhm5/r4vkwsywASZO3VCyqB8DYh2g7dr/edOp
        +OQREXUXzEXqcfZeuiaNt+M=
X-Google-Smtp-Source: AA0mqf4pWyI0THPP7U6sO8Kb0GjPcH+kAzQN7DZPc8CGT3JLo7QmXOL9nktAJ9xsOtP4xFm6+rGmPw==
X-Received: by 2002:a17:906:c458:b0:7c0:e23f:17cd with SMTP id ck24-20020a170906c45800b007c0e23f17cdmr8031570ejb.491.1670292295037;
        Mon, 05 Dec 2022 18:04:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b007933047f923sm6772540ejc.118.2022.12.05.18.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:04:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2NKI-003Pl3-0P;
        Tue, 06 Dec 2022 03:04:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
Date:   Tue, 06 Dec 2022 02:58:53 +0100
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
 <a8e33b1e-1056-5f75-55b5-65c0bceef3ca@web.de>
 <Y45yaYV3xFB/xR2G@nand.local>
 <221206.868rjle7za.gmgdl@evledraar.gmail.com>
 <Y46fHhD3xionHgPE@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y46fHhD3xionHgPE@coredump.intra.peff.net>
Message-ID: <221206.86v8mpcmnt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 05 2022, Jeff King wrote:

> On Tue, Dec 06, 2022 at 12:12:32AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> But if we *are* doing that then surely we should provide the full set of
>> functions. I.e. ALLOC() and ALLOC_ARRAY(), CALLOC() and CALLOC_ARRAY(),
>> and REALLOC() and REALLOC_ARRAY()?
>
> FWIW, I would be happy to see all of those (minus REALLOC(), as there is
> not really any point in growing or shrinking something with a fixed
> size).
>
> The biggest argument against them that I can see is that:
>
>   struct foo *x =3D malloc(sizeof(*x));
>
> is idiomatic C that newcomers to the project will easily understand,
> and:
>
>   struct foo *x;
>   ALLOC(x);
>
> is not. But it feels like we already crossed that bridge with
> ALLOC_ARRAY(), etc.

This is probably too ugly to exist, but if we are going to have more
variants maybe one that would allow use within declarations would be
better, e.g.:

=09
	diff --git a/attr.c b/attr.c
	index 42ad6de8c7c..43ade426e57 100644
	--- a/attr.c
	+++ b/attr.c
	@@ -666,11 +666,10 @@ static void handle_attr_line(struct attr_stack *res,
=09=20
	 static struct attr_stack *read_attr_from_array(const char **list)
	 {
	-	struct attr_stack *res;
	+	struct attr_stack *INIT_CALLOC_ARRAY(res, 1);
	 	const char *line;
	 	int lineno =3D 0;
=09=20
	-	CALLOC_ARRAY(res, 1);
	 	while ((line =3D *(list++)) !=3D NULL)
	 		handle_attr_line(res, line, "[builtin]", ++lineno,
	 				 READ_ATTR_MACRO_OK);
	diff --git a/git-compat-util.h b/git-compat-util.h
	index a76d0526f79..932d0907f3f 100644
	--- a/git-compat-util.h
	+++ b/git-compat-util.h
	@@ -1089,6 +1089,7 @@ int xstrncmpz(const char *s, const char *t, size_t l=
en);
=09=20
	 #define ALLOC_ARRAY(x, alloc) (x) =3D xmalloc(st_mult(sizeof(*(x)), (allo=
c)))
	 #define CALLOC_ARRAY(x, alloc) (x) =3D xcalloc((alloc), sizeof(*(x)))
	+#define INIT_CALLOC_ARRAY(x, alloc) x =3D xcalloc((alloc), sizeof(*(x)))
	 #define REALLOC_ARRAY(x, alloc) (x) =3D xrealloc((x), st_mult(sizeof(*(x)=
), (alloc)))
=09=20
	 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(ds=
t)) + \

I suspect (but haven't checked) that it might get us into the same
parsing trouble as your UNUSED(name) macro.

Or maybe:
=09
	diff --git a/attr.c b/attr.c
	index 42ad6de8c7c..c3cb5c98bbf 100644
	--- a/attr.c
	+++ b/attr.c
	@@ -669 +669 @@ static struct attr_stack *read_attr_from_array(const char =
**list)
	-	struct attr_stack *res;
	+	INIT_CALLOC_ARRAY(struct attr_stack *, res, 1);
	@@ -673 +672,0 @@ static struct attr_stack *read_attr_from_array(const cha=
r **list)
	-	CALLOC_ARRAY(res, 1);
	diff --git a/git-compat-util.h b/git-compat-util.h
	index a76d0526f79..fd9af571dc9 100644
	--- a/git-compat-util.h
	+++ b/git-compat-util.h
	@@ -1091,0 +1092 @@ int xstrncmpz(const char *s, const char *t, size_t len=
);
	+#define INIT_CALLOC_ARRAY(d, x, alloc) d x =3D xcalloc((alloc), sizeof(*(=
x)))
=09
I think it's also worth considering just having the "normal C' versions,
but we could transform anything that doesn't look lik ea narrow
whitelist of patterns into an error with coccinelle.

I.e. if we're paranoid about "v" v.s. "*var" in the "sizeof" we could
also check & tranform that with coccinelle...

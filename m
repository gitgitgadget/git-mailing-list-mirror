Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBA2C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBFQcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBFQcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:32:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A67F279A2
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:32:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gr7so35814638ejb.5
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zGQCjnFd+QzVQuYyTAYXFfui9Ad1ACgKNQXumEy49TM=;
        b=SjeZEMkWX1k9QDtzVQ5YT1qcxs6zO+R5wUwbIDGWCT8Lma0FWI5QZbWVI9tYNpwgkf
         TKLHLhJRteT9q+n3G6buuUtQ5Uw7Qem4F11kcQSmR2j0A7WiclMrzFmfy3wS6dNlvrfS
         1eGsdLfEDxaebaECGKWYssQFfVcCNUEF2LHB+di/izqI/vGC3Yw2ou+a7YSCCgUFbFvt
         HpSCLPGz7NQ3swH41xPrVTJyTZOrbidHJY2HJ3KRxjCpJQyOnLwEkUFW/z8difCwFynK
         Jgf5pPN4Tk+LFLfjKyPt0RmV5XjbgiTUgWbWFc84q1GmBJyvM2/QlC5GR/jDMA787prL
         QJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGQCjnFd+QzVQuYyTAYXFfui9Ad1ACgKNQXumEy49TM=;
        b=sDv4LxXSlj10pmGU/Jk+8kV3+z32S6V0DDn3PTlFrU8dYh8OpKP6X0Rdi1GFt1RmII
         czC8P400K7Edb4GfLZRPAyxi0PyHLk14OZnQUYEPXX4fScEmjsLiFNi85KTLepNouyq9
         pPgC0sWoFxIxiPZLw5XM7RXNQRoifdmwQkEhqUPN6+ZBzk1YLJUEg2aeqG1kVM1LPMRa
         gwqvihcp87fywVV5OPAwkXKCyiDArMU4F9ZgKaxDjt4fCdf3V7JXWdvsz+B523tF+X61
         wQ/NPBRDkq1KelAhaPPMs0SBNtpSr7JmtzQK8g043IYw5A+C5aV6nQs4Cpr3HGWVKW3L
         TTEA==
X-Gm-Message-State: AO0yUKUCuuYaxMHzJuilLI/KEmHfZFxx2ClD1soCAdOYDhoaEvBHNXXX
        HrZQu736tZ1GiDaXH2xHMbQ=
X-Google-Smtp-Source: AK7set/f9TrtMEUZL6cH5kV5MDOFHOqWXxUqQfDAZ+/e5J+CM0Ljp2kYXNFtuug/FpGa9WxP0zWKEg==
X-Received: by 2002:a17:907:9709:b0:888:1613:49d4 with SMTP id jg9-20020a170907970900b00888161349d4mr4313ejc.0.1675701147769;
        Mon, 06 Feb 2023 08:32:27 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906080700b00887a28ac01asm5645744ejd.31.2023.02.06.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:32:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP4Pq-000PRX-1O;
        Mon, 06 Feb 2023 17:32:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
Date:   Mon, 06 Feb 2023 17:18:06 +0100
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
 <b1a3e684-26f9-0053-9446-751d73e83961@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <b1a3e684-26f9-0053-9446-751d73e83961@github.com>
Message-ID: <230206.86a61q7o11.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 06 2023, Derrick Stolee wrote:

> On 2/5/2023 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> [...]
>> One wonders if (even for this index-related code) we really need such
>> careful management of growth, and could instead do with:
>>=20
>> 	strbuf_setlen(tree_path, base_path_len);
>> 	strbuf_add(tree_path, entry.path, entry.pathlen);
>> 	strbuf_addch(tree_path, '/');
>
> This would be my preferred way to go here.

*nod*

>> Or even just:
>>=20
>> 	strbuf_addf(tree_path, "%*.s/", (int)entry.pathlen, entry.path);
>
> Please do not add "addf" functions that can be run in tight loops.
> It's faster to do strbuf_add() followed by strbuf_addch().

Good point.

I wondered just how much slower, and it's up to 3x! At least according
to this[1] artificial test case (where I usurped a random test helper).

I wondered if we could just handle some common strbuf_addf() cases
ourselves, and the benchmark shows (manually annotated, too lazy to set
up the -n option):

	git hyperfine -L rev HEAD~5,HEAD~4,HEAD~3,HEAD~2,HEAD~1,HEAD~0 -s 'make CF=
LAGS=3D-O3' './t/helper/test-tool online-cpus' -r 3
	[...]
	Summary
	  './t/helper/test-tool online-cpus' in 'HEAD~0' ran <=3D=3D strbuf_add() =
+ strbuf_addch()
	    1.06 =C2=B1 0.11 times faster than './t/helper/test-tool online-cpus' =
in 'HEAD~1' <=3D=3D strbuf_addstr() + strbuf_addch()
	    1.18 =C2=B1 0.12 times faster than './t/helper/test-tool online-cpus' =
in 'HEAD~4' <=3D=3D hand optimized strbuf_addf() for "%sC"
	    1.33 =C2=B1 0.18 times faster than './t/helper/test-tool online-cpus' =
in 'HEAD~2' <=3D=3D hand optimized strbuf_addf() for "%*sC"
	    2.63 =C2=B1 0.05 times faster than './t/helper/test-tool online-cpus' =
in 'HEAD~5' <=3D=3D strbuf_addf("%s/")
	    2.92 =C2=B1 0.25 times faster than './t/helper/test-tool online-cpus' =
in 'HEAD~3' <=3D=3D strbuf_addf("%*s/")

The "hand optimization" just being a very stupid handling of "%sC" for
arbitrary values of a single char "C", and ditto for "%*sC" (which
curiously is slower here).

So, for truly hot loops we'd still want to use the add + addch, but if
anyone's interested (hashtag #leftoverbits) it looks like we could get
some easy wins (and reduction in code size, as we could stop worrying
about addf being slow in most cases) with some very dumb minimal
vaddf(), which could handle these cases (but not anything involving
padding etc.).

I didn't dig, but wouldn't be surprised if the reason is that C
libraries need to carry a relatively fat & general sprintf() for all
those edge cases, locale handling etc, whereas most of our use could
trivially be represented as some sequence of addstr()/addf() etc.

Another interesting approach (and this is very #leftoverbits) would be
to perform the same optimization with coccinelle.

I.e. our current use of it is purely "this code X should be written like
Y, and we should commit Y".

But there's no reason for why we couldn't effectively implement our own
compiler optimizations for our own APIs with it, so just grab "%s/" etc,
unpack that in OCaml, then emit strbuf_add() + strbuf_addch(), and that
would be what the C compiler would see.

1.
=09
	9d23ffb1117 addf + nolen
	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
	index 8cb0d53840f..c802ec579d0 100644
	--- a/t/helper/test-online-cpus.c
	+++ b/t/helper/test-online-cpus.c
	@@ -1,9 +1,17 @@
	 #include "test-tool.h"
	 #include "git-compat-util.h"
	 #include "thread-utils.h"
*	+#include "strbuf.h"
=09=20
	 int cmd__online_cpus(int argc, const char **argv)
	 {
	-	printf("%d\n", online_cpus());
	+	struct strbuf sb =3D STRBUF_INIT;
	+	const char *const str =3D "Hello, World";
	+
	+	for (size_t i =3D 0; i < 10000000; i++) {
	+		strbuf_reset(&sb);
	+		strbuf_addf(&sb, "%s/", str);
	+		puts(sb.buf);
	+	}
	 	return 0;
	 }
	9f74eff5623 addf + nolen optimize
	diff --git a/strbuf.c b/strbuf.c
	index c383f41a3c5..750e5e6a5b4 100644
	--- a/strbuf.c
	+++ b/strbuf.c
	@@ -332,8 +332,16 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t=
 n)
	 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
	 {
	 	va_list ap;
	+
	 	va_start(ap, fmt);
	-	strbuf_vaddf(sb, fmt, ap);
	+	if (*fmt =3D=3D '%' && *(fmt + 1) =3D=3D 's' && *(fmt + 2) && !*(fmt + 3=
)) {
	+		const char *arg =3D va_arg(ap, const char *);
	+
	+		strbuf_addstr(sb, arg);
	+		strbuf_addch(sb, *(fmt + 2));
	+	} else {
	+		strbuf_vaddf(sb, fmt, ap);
	+	}
	 	va_end(ap);
	 }
=09=20
	ca60bb9b479 addf + len
	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
	index c802ec579d0..7257e622015 100644
	--- a/t/helper/test-online-cpus.c
	+++ b/t/helper/test-online-cpus.c
	@@ -7,10 +7,11 @@ int cmd__online_cpus(int argc, const char **argv)
	 {
	 	struct strbuf sb =3D STRBUF_INIT;
	 	const char *const str =3D "Hello, World";
	+	const size_t len =3D strlen(str);
=09=20
	 	for (size_t i =3D 0; i < 10000000; i++) {
	 		strbuf_reset(&sb);
	-		strbuf_addf(&sb, "%s/", str);
	+		strbuf_addf(&sb, "%*s/", (int)len, str);
	 		puts(sb.buf);
	 	}
	 	return 0;
	1f47987d095 addf + len optimize
	diff --git a/strbuf.c b/strbuf.c
	index 750e5e6a5b4..88801268f7a 100644
	--- a/strbuf.c
	+++ b/strbuf.c
	@@ -334,11 +334,16 @@ void strbuf_addf(struct strbuf *sb, const char *fmt,=
 ...)
	 	va_list ap;
=09=20
	 	va_start(ap, fmt);
	-	if (*fmt =3D=3D '%' && *(fmt + 1) =3D=3D 's' && *(fmt + 2) && !*(fmt + 3=
)) {
	+	if (*fmt =3D=3D '%' &&
	+	    *(fmt + 1) =3D=3D '*' &&
	+	    *(fmt + 2) =3D=3D 's' &&
	+	    *(fmt + 3) &&
	+	    !*(fmt + 4)) {
	+		int len =3D va_arg(ap, int);
	 		const char *arg =3D va_arg(ap, const char *);
=09=20
	-		strbuf_addstr(sb, arg);
	-		strbuf_addch(sb, *(fmt + 2));
	+		strbuf_add(sb, arg, len);
	+		strbuf_addch(sb, *(fmt + 3));
	 	} else {
	 		strbuf_vaddf(sb, fmt, ap);
	 	}
	55c698c0b95 addstr
	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
	index 7257e622015..2716b44ca15 100644
	--- a/t/helper/test-online-cpus.c
	+++ b/t/helper/test-online-cpus.c
	@@ -7,11 +7,11 @@ int cmd__online_cpus(int argc, const char **argv)
	 {
	 	struct strbuf sb =3D STRBUF_INIT;
	 	const char *const str =3D "Hello, World";
	-	const size_t len =3D strlen(str);
=09=20
	 	for (size_t i =3D 0; i < 10000000; i++) {
	 		strbuf_reset(&sb);
	-		strbuf_addf(&sb, "%*s/", (int)len, str);
	+		strbuf_addstr(&sb, str);
	+		strbuf_addch(&sb, '/');
	 		puts(sb.buf);
	 	}
	 	return 0;
	b17fb99bf7e (HEAD -> master) add
	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
	index 2716b44ca15..5e52b622c4d 100644
	--- a/t/helper/test-online-cpus.c
	+++ b/t/helper/test-online-cpus.c
	@@ -7,10 +7,11 @@ int cmd__online_cpus(int argc, const char **argv)
	 {
	 	struct strbuf sb =3D STRBUF_INIT;
	 	const char *const str =3D "Hello, World";
	+	const size_t len =3D strlen(str);
=09=20
	 	for (size_t i =3D 0; i < 10000000; i++) {
	 		strbuf_reset(&sb);
	-		strbuf_addstr(&sb, str);
	+		strbuf_add(&sb, str, len);
	 		strbuf_addch(&sb, '/');
	 		puts(sb.buf);
	 	}

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6674AC636D3
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 11:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBLLVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 06:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLLVA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 06:21:00 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C099125BD
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 03:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676200850; bh=MqBh4R9T+2bdSTQP3QKLGQB2orJO7NAT8QU4jUmpX3Q=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=GMOEKY628r4kzzGDXPFigklDBI+FfueaP8jLov0BT6H3vWuBBPF6fuz0oMTdGGQ4h
         qphASQz8eakuWirzBKsn8eE90bWk/7EXMYc097HB2tFIVjiYytiB5a/KkwGnBPiqzf
         S7jMY3bBcghz7fPHpihGPgn6gEPDIZEHy1TSb+F20AbircNTGtb+UI4geJWD+ITBGt
         6FR3GPqKWOdhjcrEw6DnNq2VJ2ofGgVHSucQZp+/HGknPpv+oR+c9boVLtlYj/DtRU
         VW9LVVh3Rrsb3XR55hc5lr9CzQH1lyqIEcI4enuGi5DAd/3pi8kgGzEOOOkckH+C6N
         W4Mw2vyKXps9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1pWgic0jYa-005YE1; Sun, 12
 Feb 2023 12:20:50 +0100
Message-ID: <49071578-0007-bd9d-f286-58abfa848991@web.de>
Date:   Sun, 12 Feb 2023 12:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
 <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
 <b1a3e684-26f9-0053-9446-751d73e83961@github.com>
 <230206.86a61q7o11.gmgdl@evledraar.gmail.com>
Content-Language: en-US
In-Reply-To: <230206.86a61q7o11.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q89Xn6DGlcFezWqOv3PGwUj3dyIaR4bBxz3Wa6r8jRZUW+llCUd
 Q5DIBto9QOug5MwKbBcwDIeiQhu+S89MlX3n55KAMSQq56/1OXGI7Qh2cDaE+Gh3vG8YCZy
 Xt02wMdUXoJKAxN5nECQ2uy9k1anMQlNRB74BqvytyVhb0fcW6JN4zHlzV6ldZHyNXdNMih
 E/mkpkcSHxDBCWVBMk7Fg==
UI-OutboundReport: notjunk:1;M01:P0:m0Ow8+KIcM4=;RnAqWxK7eWBcryWoIz9eT6v6pGs
 W0kEr+caxxjQJJ4Wneb45w5vqNzx5OSHhdj5PZmtTM3up9EpgGBTcO4J5TypwCFXuNYs1BPhN
 7Cy1E4AQdTsx8/LoJM7tRogY0xqLkOg2LNsWPXhwgifSfVES/e3yqo8/wj+nttkpnrp/8/WX3
 KrOuVL0XUorWvwvd7/crbBi9/JARVf6nmqNKwgotArEI2eHDUVUUIba58ml4XQcqMviwvRpkc
 Ki0qrN+M3pdd613bGo1L7hs0ZxVGhTN7utSxgrRl2E/Skvw690aNc+ox6GneF1MgviCNRmS+F
 dti7htTJ5JgQlsH1Oz7fLCQpxVwobHBHA4JmGTLVXbTRXicHOxdrbhH4BC8YYVQBm34bUivda
 La05t2Hsj6AoRAeH9TdphjErh/ltxpxCyTYeSYDCUexMWxyQOHv2hjkvXuh9ivvidskh2eYSE
 VSiPvqnGkPDDL0sS7H5LOleXcXF/qbgJn6cy1cz/wKW7/cax3u3bfCBa4v9sjvDxGSSHGtqgN
 GDveSfpALE1SM87gb2VPi28axh3t7Uo2y55Hti0uKvDo0teymr6Y5HAxzzw7osLqSxNKL6cmr
 xNU3gasCuG8Gwi8jLMMTJszYXQGJdvUy8CYdyzpnjjOqI1wa0scIvWVr1B7LWvqovovs+v5pq
 4kFS5plq4OSYW9b3MJmLqSWPLnLK8FmwhUk5FbOnbJn9Pgd+nIpF54a2lt2ByqiwLYIlA/LYe
 H78j9iOh/qVXPASfFhF3Au+7ZOz1YTv5Wg9QqSKeLDigW1o/eTy53tCUEjKKuozfLyJ2qNv4s
 Axmqq18idog2RpM1laaqdTsJbAdKlMqbZFr9/09AlwRihlGaA1EbYmGz8xZggEZEce0dPtYbE
 6AWKkV7wOE4xHDtSCIw/SkWfDbSGbJUdPtsUxzkSEJ0Nzqup81gw/A5Cy0MI0gW8EzOiWuFRa
 89RZMtkhbQaXG3BoSuqiCWCX5/U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.23 um 17:18 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Feb 06 2023, Derrick Stolee wrote:
>
>> On 2/5/2023 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>> Or even just:
>>>
>>> 	strbuf_addf(tree_path, "%*.s/", (int)entry.pathlen, entry.path);
>>
>> Please do not add "addf" functions that can be run in tight loops.
>> It's faster to do strbuf_add() followed by strbuf_addch().
>
> Good point.
>
> I wondered just how much slower, and it's up to 3x! At least according
> to this[1] artificial test case (where I usurped a random test helper).
>
> I wondered if we could just handle some common strbuf_addf() cases
> ourselves, and the benchmark shows (manually annotated, too lazy to set
> up the -n option):
>
> 	git hyperfine -L rev HEAD~5,HEAD~4,HEAD~3,HEAD~2,HEAD~1,HEAD~0 -s 'make=
 CFLAGS=3D-O3' './t/helper/test-tool online-cpus' -r 3
> 	[...]
> 	Summary
> 	  './t/helper/test-tool online-cpus' in 'HEAD~0' ran <=3D=3D strbuf_add=
() + strbuf_addch()
> 	    1.06 =C2=B1 0.11 times faster than './t/helper/test-tool online-cpu=
s' in 'HEAD~1' <=3D=3D strbuf_addstr() + strbuf_addch()
> 	    1.18 =C2=B1 0.12 times faster than './t/helper/test-tool online-cpu=
s' in 'HEAD~4' <=3D=3D hand optimized strbuf_addf() for "%sC"
> 	    1.33 =C2=B1 0.18 times faster than './t/helper/test-tool online-cpu=
s' in 'HEAD~2' <=3D=3D hand optimized strbuf_addf() for "%*sC"
> 	    2.63 =C2=B1 0.05 times faster than './t/helper/test-tool online-cpu=
s' in 'HEAD~5' <=3D=3D strbuf_addf("%s/")
> 	    2.92 =C2=B1 0.25 times faster than './t/helper/test-tool online-cpu=
s' in 'HEAD~3' <=3D=3D strbuf_addf("%*s/")

Woah!

> The "hand optimization" just being a very stupid handling of "%sC" for
> arbitrary values of a single char "C", and ditto for "%*sC" (which
> curiously is slower here).

"%*s" adds padding if needed, your version doesn't.  Perhaps you thought
of "%.*s"?  That might be relevant because for "%*s" vsnprintf(3) needs
to run strlen(3) again on the argument, while for "%.*s" it can stop
when the given length is reached.

> So, for truly hot loops we'd still want to use the add + addch, but if
> anyone's interested (hashtag #leftoverbits) it looks like we could get
> some easy wins (and reduction in code size, as we could stop worrying
> about addf being slow in most cases) with some very dumb minimal
> vaddf(), which could handle these cases (but not anything involving
> padding etc.).
>
> I didn't dig, but wouldn't be surprised if the reason is that C
> libraries need to carry a relatively fat & general sprintf() for all
> those edge cases, locale handling etc, whereas most of our use could
> trivially be represented as some sequence of addstr()/addf() etc.

If that's the reason then resisting the urge to handle ever more cases
in strbuf_addf() would be quite important.

> Another interesting approach (and this is very #leftoverbits) would be
> to perform the same optimization with coccinelle.
>
> I.e. our current use of it is purely "this code X should be written like
> Y, and we should commit Y".
>
> But there's no reason for why we couldn't effectively implement our own
> compiler optimizations for our own APIs with it, so just grab "%s/" etc,
> unpack that in OCaml, then emit strbuf_add() + strbuf_addch(), and that
> would be what the C compiler would see.

Extracting the %s is technically possible using a semantic patch without
scripting:

   @@
   expression sb, str;
   format fmt =3D~ "^s$";
   @@
   + strbuf_addstr(sb, str);
     strbuf_addf(sb, "%@fmt@..."
   - , str
   + + 2
     );

The "+ 2" is ugly and runs afoul of compiler warning -Wstring-plus-int,
though.  Resolving this probably requires Python scripting as in
https://github.com/coccinelle/coccinelle/blob/master/demos/format.cocci,
or the OCaml magic you have in mind.  I have to admit that I don't even
understand the linked examples, however. :-/

The warning can be avoided by using an array subscription, by the way,
but that's even uglier:

   @@
   expression sb, str;
   format fmt =3D~ "^s$";
   @@
   + strbuf_addstr(sb, str);
     strbuf_addf(sb,
   + &
     "%@fmt@..."
   - , str
   + [2]
     );

>
> 1.
>
> 	9d23ffb1117 addf + nolen
> 	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
> 	index 8cb0d53840f..c802ec579d0 100644
> 	--- a/t/helper/test-online-cpus.c
> 	+++ b/t/helper/test-online-cpus.c
> 	@@ -1,9 +1,17 @@
> 	 #include "test-tool.h"
> 	 #include "git-compat-util.h"
> 	 #include "thread-utils.h"
> *	+#include "strbuf.h"
>
> 	 int cmd__online_cpus(int argc, const char **argv)
> 	 {
> 	-	printf("%d\n", online_cpus());
> 	+	struct strbuf sb =3D STRBUF_INIT;
> 	+	const char *const str =3D "Hello, World";
> 	+
> 	+	for (size_t i =3D 0; i < 10000000; i++) {
> 	+		strbuf_reset(&sb);
> 	+		strbuf_addf(&sb, "%s/", str);
> 	+		puts(sb.buf);
> 	+	}
> 	 	return 0;
> 	 }
> 	9f74eff5623 addf + nolen optimize
> 	diff --git a/strbuf.c b/strbuf.c
> 	index c383f41a3c5..750e5e6a5b4 100644
> 	--- a/strbuf.c
> 	+++ b/strbuf.c
> 	@@ -332,8 +332,16 @@ void strbuf_addchars(struct strbuf *sb, int c, siz=
e_t n)
> 	 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
> 	 {
> 	 	va_list ap;
> 	+
> 	 	va_start(ap, fmt);
> 	-	strbuf_vaddf(sb, fmt, ap);
> 	+	if (*fmt =3D=3D '%' && *(fmt + 1) =3D=3D 's' && *(fmt + 2) && !*(fmt =
+ 3)) {
> 	+		const char *arg =3D va_arg(ap, const char *);
> 	+
> 	+		strbuf_addstr(sb, arg);
> 	+		strbuf_addch(sb, *(fmt + 2));
> 	+	} else {
> 	+		strbuf_vaddf(sb, fmt, ap);
> 	+	}
> 	 	va_end(ap);
> 	 }
>
> 	ca60bb9b479 addf + len
> 	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
> 	index c802ec579d0..7257e622015 100644
> 	--- a/t/helper/test-online-cpus.c
> 	+++ b/t/helper/test-online-cpus.c
> 	@@ -7,10 +7,11 @@ int cmd__online_cpus(int argc, const char **argv)
> 	 {
> 	 	struct strbuf sb =3D STRBUF_INIT;
> 	 	const char *const str =3D "Hello, World";
> 	+	const size_t len =3D strlen(str);
>
> 	 	for (size_t i =3D 0; i < 10000000; i++) {
> 	 		strbuf_reset(&sb);
> 	-		strbuf_addf(&sb, "%s/", str);
> 	+		strbuf_addf(&sb, "%*s/", (int)len, str);
> 	 		puts(sb.buf);
> 	 	}
> 	 	return 0;
> 	1f47987d095 addf + len optimize
> 	diff --git a/strbuf.c b/strbuf.c
> 	index 750e5e6a5b4..88801268f7a 100644
> 	--- a/strbuf.c
> 	+++ b/strbuf.c
> 	@@ -334,11 +334,16 @@ void strbuf_addf(struct strbuf *sb, const char *f=
mt, ...)
> 	 	va_list ap;
>
> 	 	va_start(ap, fmt);
> 	-	if (*fmt =3D=3D '%' && *(fmt + 1) =3D=3D 's' && *(fmt + 2) && !*(fmt =
+ 3)) {
> 	+	if (*fmt =3D=3D '%' &&
> 	+	    *(fmt + 1) =3D=3D '*' &&
> 	+	    *(fmt + 2) =3D=3D 's' &&
> 	+	    *(fmt + 3) &&
> 	+	    !*(fmt + 4)) {
> 	+		int len =3D va_arg(ap, int);
> 	 		const char *arg =3D va_arg(ap, const char *);
>
> 	-		strbuf_addstr(sb, arg);
> 	-		strbuf_addch(sb, *(fmt + 2));
> 	+		strbuf_add(sb, arg, len);
> 	+		strbuf_addch(sb, *(fmt + 3));
> 	 	} else {
> 	 		strbuf_vaddf(sb, fmt, ap);
> 	 	}
> 	55c698c0b95 addstr
> 	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
> 	index 7257e622015..2716b44ca15 100644
> 	--- a/t/helper/test-online-cpus.c
> 	+++ b/t/helper/test-online-cpus.c
> 	@@ -7,11 +7,11 @@ int cmd__online_cpus(int argc, const char **argv)
> 	 {
> 	 	struct strbuf sb =3D STRBUF_INIT;
> 	 	const char *const str =3D "Hello, World";
> 	-	const size_t len =3D strlen(str);
>
> 	 	for (size_t i =3D 0; i < 10000000; i++) {
> 	 		strbuf_reset(&sb);
> 	-		strbuf_addf(&sb, "%*s/", (int)len, str);
> 	+		strbuf_addstr(&sb, str);
> 	+		strbuf_addch(&sb, '/');
> 	 		puts(sb.buf);
> 	 	}
> 	 	return 0;
> 	b17fb99bf7e (HEAD -> master) add
> 	diff --git a/t/helper/test-online-cpus.c b/t/helper/test-online-cpus.c
> 	index 2716b44ca15..5e52b622c4d 100644
> 	--- a/t/helper/test-online-cpus.c
> 	+++ b/t/helper/test-online-cpus.c
> 	@@ -7,10 +7,11 @@ int cmd__online_cpus(int argc, const char **argv)
> 	 {
> 	 	struct strbuf sb =3D STRBUF_INIT;
> 	 	const char *const str =3D "Hello, World";
> 	+	const size_t len =3D strlen(str);
>
> 	 	for (size_t i =3D 0; i < 10000000; i++) {
> 	 		strbuf_reset(&sb);
> 	-		strbuf_addstr(&sb, str);
> 	+		strbuf_add(&sb, str, len);
> 	 		strbuf_addch(&sb, '/');
> 	 		puts(sb.buf);
> 	 	}

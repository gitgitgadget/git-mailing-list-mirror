Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE28C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 20:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbjDFUT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDFUT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 16:19:27 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AD7692
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680812353; i=l.s.r@web.de;
        bh=Svaz4bE7LrmURr7t8A0ZUNqg29pRHzJSkPINJA4l++I=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=nAmWML7VanrVmKp6cPnZs/gDAE6GJEArw5b87iYtzNPRBa1Uu/FlRszq7HnGOP3tB
         AelfezbQuYdBdHWU5vZj8LOVtULoqj+JuvyFTMMHMEzP5ld0uxjYILk5oQHG4t623M
         0Ubz+lD2CtqA/Yksw2mSq+jNVw7vr013V1vJyk5AkCbOYrRwSUFGrOlAmqqUP/HmDx
         6VOHCoglKkjwC9SChB+QwSyXrgp4lSLUZGs73/s2qP70vOfcLk7WoTkvaAEHcqUKLy
         c0L8GYQ1yxD8g13+DaJtkF64gTDlZ5DsUu8ueBlKZ9DwbihYfIB6WfqZqXq0YmkSFR
         Xq5+17NVwr1Rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1qAk5Y07ph-00iAEl; Thu, 06
 Apr 2023 22:19:13 +0200
Message-ID: <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
Date:   Thu, 6 Apr 2023 22:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: [PATCH] userdiff: support regexec(3) with multi-byte support
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
 <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
 <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
Content-Language: en-US
In-Reply-To: <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K6P+S/2EvAoGP9KKfT+VXNK4K7QQKcSmMwHt8SOWujhvlb0b0Rl
 UgZnis3TqldGKNykzupnk7xkf7IOfSSIP+Wx+2IMr3E0xMVB8E5HMGv5kTaP8d+5rnVlEeR
 X/eC2+NDkfNDGxmiOcMPMc+zJmITehFy2HWqtteNAMwLj12+YUCEbLgTWlZPzDbdTaAC22D
 4EutqOJmF6Ffju819N+ug==
UI-OutboundReport: notjunk:1;M01:P0:yPyzCK7TmGM=;Cr3TqY1cuNwXb8GfsN9jG8lLjhR
 mla6q4a6JU5nlYAA71AJDc0QJxDv4OV7k3jvZjAJvNFXz0jZLfDW4vwRpHhGDB+asRuCTyRhU
 oI4K5nc1QhAS+iERst+0yP7w9Fl0+Txquu16mCgIvOiDOch3ciijeW8FeGxFcncUG0qIb3Kf6
 a/n1Uw7nJPuTlaM+FtDEJhv52QxIAwFINCCrhIM0hCZ6RnVn/j+7nQiEq06+ZIxS9KoEcyyY0
 OUurQymyWKrxDVbil//x/Xw+5S0cKYRn3udw7kkeGnVe/VI5DTN+lZ5VIl8xIWfeO32yumSIy
 1zsJPK6sZagCds+7fql+/hkZWcYkjlAzRNuz8AaciKwQBwfCQB7LbQuRkGROgdP1oQ9XwxTRh
 AXvT9SuPNoyiEW9JGyholz4aJuvc2TIJ/GG4ekeSUdOi+HPYTdvUS4ke0Oxo+BnxDJNV7WVwY
 CTBhHAicpxJsbF7A0twmKD1U1s9UmQKi4GO8kwNzspfMdTn29iDb5kCOfjkmpPtyTa/NgAiyz
 +htx4qQwWqrYpxc9w5IqNf5LACuNcDoq8EX6U7aJXmlATR0krTYTgG+s3EjFsKywPYz8MF31/
 yjMfUYFjTeriprT1AAeVJyHBW1vHxTFuZ7dWWpW5ipEFRT3Pj8E569iBR5D8jEny3U+IKqDaC
 5iXkUzuzBKsBrsRoXMO1I//ss3A+6LZsbb4NL6V1SLNJzCPve23zeFkC2WvJWMZzTVStbQsfQ
 h9ssoybzgoJFc33eMruFhM82SWVPItBUjQX9gxCHqDf6e5v9I7n3nCpqvDayVJ2gayFNkPwR0
 vBt5odFxJ8nIGjiqqeyvbsR0fhTOW+YOK9YfPJwDURkoVl6Oma8qwpdCCjRpYEnGuTGsWtODe
 jc99/eieTT4+f8fKHdyBhe7pJZ2z2lBR7Q0uJdzbb0KjgRizH1heYxOyV+SjXlrsvDs1tYMKU
 /jwnww==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 1819ad327b (grep: fix multibyte regex handling under macOS,
2022-08-26) we use the system library for all regular expression
matching on macOS, not just for git grep.  It supports multi-byte
strings and rejects invalid multi-byte characters.

This broke all built-in userdiff word regexes in UTF-8 locales because
they all include such invalid bytes in expressions that are intended to
match multi-byte characters without explicit support for that from the
regex engine.

"|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" is added to all built-in word
regexes to match a single non-space or multi-byte character.  The \xNN
characters are invalid if interpreted as UTF-8 because they have their
high bit set, which indicates they are part of a multi-byte character,
but they are surrounded by single-byte characters.

Replace that expression with "|[^[:space:]]" if the regex engine
supports multi-byte matching, as there is no need to have an explicit
range for multi-byte characters then.  Check for that capability at
runtime, because it depends on the locale and thus on environment
variables.  Construct the full replacement expression at build time
and just switch it in if necessary to avoid string manipulation and
allocations at runtime.

Additionally the word regex for tex contains the expression
"[a-zA-Z0-9\x80-\xff]+" with a similarly invalid range.  The best
replacement with only valid characters that I can come up with is
"([a-zA-Z0-9]|[^\x01-\x7f])+".  Unlike the original it matches NUL
characters, though.  Assuming that tex files usually don't contain NUL
this should be acceptable.

Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4034-diff-words.sh |  4 ++++
 userdiff.c            | 31 +++++++++++++++++++++++++++++--
 userdiff.h            |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 15764ee9ac..74586f3813 100755
=2D-- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -69,6 +69,10 @@ test_language_driver () {
 		echo "* diff=3D'"$lang"'" >.gitattributes &&
 		word_diff --color-words
 	'
+	test_expect_success "diff driver '$lang' in Islandic" '
+		LANG=3Dis_IS.UTF-8 LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" \
+		word_diff --color-words
+	'
 }

 test_expect_success setup '
diff --git a/userdiff.c b/userdiff.c
index 09203fbc35..eaec6ebb5e 100644
=2D-- a/userdiff.c
+++ b/userdiff.c
@@ -17,6 +17,7 @@ static int drivers_alloc;
 		.cflags =3D REG_EXTENDED, \
 	}, \
 	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+	.word_regex_multi_byte =3D wrx "|[^[:space:]]", \
 }
 #define IPATTERN(lang, rx, wrx) { \
 	.name =3D lang, \
@@ -26,6 +27,7 @@ static int drivers_alloc;
 		.cflags =3D REG_EXTENDED | REG_ICASE, \
 	}, \
 	.word_regex =3D wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
+	.word_regex_multi_byte =3D wrx "|[^[:space:]]", \
 }

 /*
@@ -294,7 +296,7 @@ PATTERNS("scheme",
 	 /* All other words should be delimited by spaces or parentheses */
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
+	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
 { "default", NULL, NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
@@ -330,6 +332,25 @@ static int userdiff_find_by_namelen_cb(struct userdif=
f_driver *driver,
 	return 0;
 }

+static int regexec_supports_multi_byte_chars(void)
+{
+	static const char not_space[] =3D "[^[:space:]]";
+	static const char utf8_multi_byte_char[] =3D "\xc2\xa3";
+	regex_t re;
+	regmatch_t match;
+	static int result =3D -1;
+
+	if (result !=3D -1)
+		return result;
+	if (regcomp(&re, not_space, REG_EXTENDED))
+		BUG("invalid regular expression: %s", not_space);
+	result =3D !regexec(&re, utf8_multi_byte_char, 1, &match, 0) &&
+		match.rm_so =3D=3D 0 &&
+		match.rm_eo =3D=3D strlen(utf8_multi_byte_char);
+	regfree(&re);
+	return result;
+}
+
 static struct userdiff_driver *userdiff_find_by_namelen(const char *name,=
 size_t len)
 {
 	struct find_by_namelen_data udcbdata =3D {
@@ -405,7 +426,13 @@ int userdiff_config(const char *k, const char *v)
 struct userdiff_driver *userdiff_find_by_name(const char *name)
 {
 	int len =3D strlen(name);
-	return userdiff_find_by_namelen(name, len);
+	struct userdiff_driver *driver =3D userdiff_find_by_namelen(name, len);
+	if (driver && driver->word_regex_multi_byte) {
+		if (regexec_supports_multi_byte_chars())
+			driver->word_regex =3D driver->word_regex_multi_byte;
+		driver->word_regex_multi_byte =3D NULL;
+	}
+	return driver;
 }

 struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
diff --git a/userdiff.h b/userdiff.h
index 24419db697..d726804c3e 100644
=2D-- a/userdiff.h
+++ b/userdiff.h
@@ -18,6 +18,7 @@ struct userdiff_driver {
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *word_regex;
+	const char *word_regex_multi_byte;
 	const char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
=2D-
2.40.0


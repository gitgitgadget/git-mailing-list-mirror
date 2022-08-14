Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE89C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 13:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiHNNks (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNNkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 09:40:47 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Aug 2022 06:40:46 PDT
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570CC11C0D
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660484444;
        bh=qYQ3NHVuv082w5dVN0/O5MfXH5Mm/V7vh1nNtqELub8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=L3FkQmQD7AAXLUjwsDTgQ3z9tkk1x8vzOKoMcO8m95StspImj+KxRTUnaWLyOBa4F
         LiI4YECdzbN1lIfW/5isulqMET/dEQ57zG0tzAv7ZQn4GtdvAMqNkacXQnv3ozIyZb
         i22SZUR6Ayk5uUwA7qCBICQTxXVydm8ru2PfVthw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V6G-1oNlk11dII-000eHD; Sun, 14
 Aug 2022 15:35:39 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC 1/1] diff.c: When appropriate, use utf8_strwidth()
Date:   Sun, 14 Aug 2022 15:35:31 +0200
Message-Id: <20220814133531.16952-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NxLfPKGC9tmMJTbKgK4x1XAbzgaOucHZX3KImmJGRa2O6hrZNXr
 ShQMsXigaUZF5UNWKr+jSZp80vVeUQV+pYlU2UV+k+ZtwzV7QTRsLusqEaJuKgXQZbIRShR
 VanOyv6Syi2V/HAqGMimiljHYtV2FQ6JY4XRVGMi9Kl2+9ABsbGI58u7F7zCSgEPSsKpmdW
 kYdiqsvXHux/gPIpYIHUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKepH5H8Ziw=:UoNHMnQU4n6M48u5zwDrpj
 n0iLqfq4yews0O4HXjjAwbwmUx6JnVQAfkbWl1TVihMvcGSI+hD48KvJnG5bsHg9IYUn1004L
 cTTPAVtX7GMfb5yN/5IzR42uXriesCegEcPdgjzWOgUXfDw1vJdhbjAlqE/Zz7SMngcgc5zS4
 SkfEEdCjVau6NETcctTJDvxCdX1NkjqA06G+KeuEnie3ET4XiE3W36anYI4Z+bIqmGZYp8mlu
 I6JvRKOM9yWfXoUr4sBcjseNN1URrTSzFFOAVUWJu4igZWspyn2KIma1LXinx8Yud23qfaZvQ
 nWVIZQkSZSYUEQX5W/+vPtHRIAHheXj2U8buXl/ntZrYI7j8I00Zt6rywQG5R/zDd243sRmAa
 srXpN20iRaS/j0cRhfJ20QBOaBF3czvqBhn9SRPzm/ryO6d5ixrA8TJ75o66l81OZ5oRhjebM
 lhe5uMq277tnB9bOIA/3VXshgGXH2oABjsnTENBgbkL77e9vwWi/Eo8egbmVWzQov6B0cX1mT
 AOnC/sZzd0QOdyriKA4ufII/nwQJC/RoZQ6XRirvVOnoRLgyrysYLt4xQgOndmHlTtjnVCKa9
 0F2wj6/c5f/LNIFeCs/yCe8dTNnr7tatyhKIeoC7t5KwuwBzPSYNhccf99bgGiH9SmvgtgX+0
 vz/B1tAAFna2YC3Q7CatUVUX6Znrwh/CI3uZZ8tLu9+cDvMUOa0EtpRmIxDlBSKtPyrYyvE6d
 QUHO1/Yz5I9FIRdjqZz2CYsGCcakocszoyTiHbiqXi4lMyMBG1usJFQSw4JneeObu472A0Nzo
 J8Od68wag2uQrzcwCLzzXLiVCPv3IoZ+POkW/z9qJYg5XPCxbNahJmJyEU+p1kHik0Dx1d+/R
 Q7lz8nGKICbWQ+rSRkqpdBdbBKqy8ORQN5z83CfgGMJ7Z1Q7NYODJzFXDvOoBj2V8P+JGoNc2
 y8wIYozWm+EqqWQ1IjcFwMCHD89boFHmGztRdof13lDEYeRf5v9ZOOnD00ltMoEdY0xuuj2Oe
 c9PkBVZdN9DRY+9C+9W+4yyzc/cLfKUAVGCPzCAVeW2HXQr7+gsoiAQ7I46hM7ZhOw3J+WSSO
 iEzCbpmP/YxTzV8/6w06z18wC4T2u3lE9rW
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

When unicode filenames (encoded in UTF-8) are used, the visible width
on the screen is not the same as strlen(filename).

For example, `git log --stat` may produce an output like this:

$ git log --stat

[snip the header]

 Arger.txt  | 1 +
 =C3=84rger.txt | 1 +
 2 files changed, 2 insertions(+)

A side note: the original report was about cyrillic filenames.
After some investigations it turned out that
a) This is not a problem with "ambiguous characters" in unicode
b) The same problem exist for all unicode code points (so we
  can use Latin based Umlauts for demonstrations below)

The '=C3=84' takes the same space on the screen as the 'A'.
But needs one more byte in memory, so the the `git log --stat` output
for "Arger.txt" (!) gets mis-aligned:
The maximum length is derived from "=C3=84rger.txt", 10 bytes in memory,
9 positions on the screen. That is why "Arger.txt" gets one extra ' '
for aligment, it needs 9 bytes in memory.
If there was a file "=C3=96", it would be correctly aligned by chance,
but "=C3=96h=C3=B6" would not.

The solution is of course, to use utf8_strwidth() instead of strlen()
when dealing with the width on screen.

And then there is another problem: code like this
strbuf_addf(&out, "%-*s", len, name);

(or using the underlying snprintf() function) does not align the
buffer to a minimum of len measured in screen-width, but uses the
memory count, if name is UTF-8 encoded.

We could be tempted to wish that snprintf() was UTF-8 aware.
That doesn't seem to be the case anywhere (tested on Linux and Mac),
probably snprintf() uses the "bytes in memory"/strlen() approach to be
compatible with older versions and this will never change.

The choosen solution is to split code in diff.c like this

strbuf_addf(&out, "%-*s", len, name);

into 2 calls, like this:

strbuf_addf(&out, "%s", name);
if (len > utf8_strwidth(name))
    strbuf_addchars(&out, ' ', len - utf8_strwidth(name));

Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a621..7fb254c545 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2620,7 +2620,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 			continue;
 		}
 		fill_print_name(file);
-		len =3D strlen(file->print_name);
+		len =3D utf8_strwidth(file->print_name);
 		if (max_len < len)
 			max_len =3D len;

@@ -2734,6 +2734,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		char *name =3D file->print_name;
 		uintmax_t added =3D file->added;
 		uintmax_t deleted =3D file->deleted;
+		size_t num_padding_spaces =3D 0;
 		int name_len;

 		if (!file->is_interesting && (added + deleted =3D=3D 0))
@@ -2743,7 +2744,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		 * "scale" the filename
 		 */
 		len =3D name_width;
-		name_len =3D strlen(name);
+		name_len =3D utf8_strwidth(name);
 		if (name_width < name_len) {
 			char *slash;
 			prefix =3D "...";
@@ -2753,10 +2754,14 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
 			if (slash)
 				name =3D slash;
 		}
+		if (len > utf8_strwidth(name))
+			num_padding_spaces =3D len - utf8_strwidth(name);

 		if (file->is_binary) {
-			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
-			strbuf_addf(&out, " %*s", number_width, "Bin");
+			strbuf_addf(&out, " %s%s ", prefix,  name);
+			if (num_padding_spaces)
+				strbuf_addchars(&out, ' ', num_padding_spaces);
+			strbuf_addf(&out, "| %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
 				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
@@ -2776,8 +2781,10 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
 			continue;
 		}
 		else if (file->is_unmerged) {
-			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
-			strbuf_addstr(&out, " Unmerged\n");
+			strbuf_addf(&out, " %s%s ", prefix,  name);
+			if (num_padding_spaces)
+				strbuf_addchars(&out, ' ', num_padding_spaces);
+			strbuf_addstr(&out, "| Unmerged\n");
 			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 					 out.buf, out.len, 0);
 			strbuf_reset(&out);
@@ -2803,8 +2810,10 @@ static void show_stats(struct diffstat_t *data, str=
uct diff_options *options)
 				add =3D total - del;
 			}
 		}
-		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
-		strbuf_addf(&out, " %*"PRIuMAX"%s",
+		strbuf_addf(&out, " %s%s ", prefix,  name);
+		if (num_padding_spaces)
+			strbuf_addchars(&out, ' ', num_padding_spaces);
+		strbuf_addf(&out, "| %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
 		show_graph(&out, '+', add, add_c, reset);
=2D-
2.34.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1943AECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 08:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiH0IuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiH0IuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 04:50:21 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433DF1E3D1
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661590216;
        bh=0l/TGFkfZYYppv9UBpp6OJw711BoArn42aDrPZwXfS8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aZCaHCZWFeF9lpNGBmKmbNSOsQetHyx8N/bEVa8OH2ZqQD1fwkvKH6p5x1wXja31L
         eUEuKyw4aJk32PxKHjX9dce7btkdpRa4W+c61lw1UYNEnlMhUABGSW+zissYrxglzk
         EyuddqFqzT8Zzr40uqYdeGPgUFCn3bnGChHiT17M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1oosYF3Vzg-00NGWc; Sat, 27
 Aug 2022 10:50:15 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
Date:   Sat, 27 Aug 2022 10:50:07 +0200
Message-Id: <20220827085007.20030-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VNjSzOYDeJF3AiphBwCgn0iG/JYBbhNgLFbG5Wsxgxym5KxebK1
 kf9cm/OTdsMmWa+A3edzacpvDXqKVjNqaCDyilDakUcFuqnwGl0axvukrI05UWl0KUuYEZv
 vsVjpg1hA4qJs/qm+WnklltvPgbk+g2vveNnHoIO022d6BWMjzPG5FE8Y6aR75b3a2tSigm
 unpC9IPvQVdIJz5Hpm9Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kzwKGo5cAqE=:v2v1/gD6+VwtldjTTgkTpw
 x7+1eO8TTUsdSheOUvV46GaYp+t9RS6iFCvCo1YClWInjS3evQhJ0uZZce/49P/voVov8wqAs
 nNIiuBmwQFj14AI2fc8G6QhSMEK9Z3xi7EKR7QqBYstuoRP5JbjccN5KAIZOZKOd/4D7hYexc
 yFl1VexCGbJsF7VRzNCiBW+RlyjqFpyAuYeTViXxtyvB+h7QNJ/d9jP9h90MhzCwZkVdyPkgI
 t0xqrvE/uUYoqxGAjFhSElUibwxuDxKTjJdui/7Vr6a7YIOPBTNZjJ6CcqrgNvYpJV+pcZWjw
 vohlxoo52Y1HcQV7KWXyEnqtzELYe+Cg91/+5VsZinSd0Gl0WAA4dg5geAJNUMKKYkgYwjlwm
 /GWQVIEF82GvFUTMH4wGNqYo1Dc65Dm5z3ZkJkrgnvU/wETR2i3MB2BAUdyg3z55LXqkI3/z2
 VULPSz8JlHGzrK2Q1P5EvQYgikQyuYugxee2sgqDYou76Xd/KejudMm//GLSkrFxCiUfRbDP5
 +MIvc+9iqTBtPJAFoYcxdyFyawtHJQO/l3Uxtd1tipT78jUtNMoxtUb0NeZGF4ZO+68pB9ZEb
 JkrP1lvH0Q/uz/pC6DfxgHSI12iNPHIkT6C84cbpiC4Au/+QFi6hSOXxP4yXWjiN+8Qe6AT28
 BG4OOWyGxSXqx2uxiNHC3Cgb7fH9a+Gwj4nfYtnb8OvndGQNThw873MkSdbTHzf0QUd5h0rEz
 K3uIxUiGhx9ihI80dXm5M12HuOXOyWEFiqZ/tKZrdO7LhT9Q+22AJ8WKH+XGphRf/6FkWJMrI
 /dBU9IDBnQDiJEd3AAytTZMmZOdI6kR5fByjqKlH0qUbqao7K3HReMtGw4SoDCqS9fx+URyl4
 b4igNMnEGUNqfkvwp/GlNfKTNZ18BicEwZ2iD1m4FN2dcSnU/HlMiQ56a6bWTdlW3Gf0oUt7J
 gmmVjw7SR2YLFogKyimIOamtjJgevRHQvABWpjbm+XO9HI4QbHCUPYOmYMpxP5icJxc1QhHRq
 RtwKsFS+lfdQU4PpXTooFNAOsY322t2JY/IUhzU/BVcKu+PTCEH88Ah6i3dqk4IRLzx5+xg0S
 1HbD40a7WQjt5rjWcijXvbk5jYoIjBgX8BO
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

into something like this:

size_t num_padding_spaces =3D 0;
// [snip]
if (len > utf8_strwidth(name))
    num_padding_spaces =3D len - utf8_strwidth(name);
strbuf_addf(&out, "%s", name);
if (num_padding_spaces)
    strbuf_addchars(&out, ' ', num_padding_spaces);

Tests:
Two things need to be tested:
- The calculation of the maximum width
- The calculation of num_padding_spaces

The name "textfile" is changed into "textfil=C3=AB", both have a width of =
8.
If strlen() was used, to get the maximum width, the shorter "binfile" woul=
d
have been mis-aligned:
 binfile   |  [snip]
 textfil=C3=AB | [snip]

If only "binfile" would be renamed into "binfil=C3=AB":
 binfil=C3=AB |  [snip]
 textfile | [snip]

In order to verify that the width is calculated correctly everywhere,
"binfile" is renamed into "binf=C3=AFl=C3=AB", giving 2 bytes more in strl=
en()
"textfile" is renamed into "textfil=C3=AB", 1 byte more in strlen(),
and the updated t4012-diff-binary.sh checks the correct aligment:
 binf=C3=AFl=C3=AB  | [snip]
 textfil=C3=AB | [snip]

Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c                 | 37 +++++++++++++++++++++++--------------
 t/t4012-diff-binary.sh | 14 +++++++-------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a621..cf38e1dc88 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2591,7 +2591,7 @@ void print_stat_summary(FILE *fp, int files,
 static void show_stats(struct diffstat_t *data, struct diff_options *opti=
ons)
 {
 	int i, len, add, del, adds =3D 0, dels =3D 0;
-	uintmax_t max_change =3D 0, max_len =3D 0;
+	uintmax_t max_change =3D 0, max_width =3D 0;
 	int total_files =3D data->nr, count;
 	int width, name_width, graph_width, number_width =3D 0, bin_width =3D 0;
 	const char *reset, *add_c, *del_c;
@@ -2620,9 +2620,9 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 			continue;
 		}
 		fill_print_name(file);
-		len =3D strlen(file->print_name);
-		if (max_len < len)
-			max_len =3D len;
+		len =3D utf8_strwidth(file->print_name);
+		if (max_width < len)
+			max_width =3D len;

 		if (file->is_unmerged) {
 			/* "Unmerged" is 8 characters */
@@ -2646,7 +2646,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)

 	/*
 	 * We have width =3D stat_width or term_columns() columns total.
-	 * We want a maximum of min(max_len, stat_name_width) for the name part.
+	 * We want a maximum of min(max_width, stat_name_width) for the name par=
t.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- par=
t.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
 	 * for " | NNNN " and one the empty column at the end, altogether
@@ -2701,8 +2701,8 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		graph_width =3D options->stat_graph_width;

 	name_width =3D (options->stat_name_width > 0 &&
-		      options->stat_name_width < max_len) ?
-		options->stat_name_width : max_len;
+		      options->stat_name_width < max_width) ?
+		options->stat_name_width : max_width;

 	/*
 	 * Adjust adjustable widths not to exceed maximum width
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
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index c509143c81..2d49de01c8 100755
=2D-- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -113,20 +113,20 @@ test_expect_success 'diff --no-index with binary cre=
ation' '
 '

 cat >expect <<EOF
- binfile  |   Bin 0 -> 1026 bytes
- textfile | 10000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
+ binf=C3=AFl=C3=AB  |   Bin 0 -> 1026 bytes
+ textfil=C3=AB | 10000 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++
 EOF

 test_expect_success 'diff --stat with binary files and big change count' =
'
-	printf "\01\00%1024d" 1 >binfile &&
-	git add binfile &&
+	printf "\01\00%1024d" 1 >binf=C3=AFl=C3=AB &&
+	git add binf=C3=AFl=C3=AB &&
 	i=3D0 &&
 	while test $i -lt 10000; do
 		echo $i &&
 		i=3D$(($i + 1)) || return 1
-	done >textfile &&
-	git add textfile &&
-	git diff --cached --stat binfile textfile >output &&
+	done >textfil=C3=AB &&
+	git add textfil=C3=AB &&
+	git -c core.quotepath=3Dfalse diff --cached --stat binf=C3=AFl=C3=AB tex=
tfil=C3=AB >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
=2D-
2.34.0


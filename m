Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB219ECAAD2
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 04:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiIBEVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 00:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiIBEVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 00:21:45 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021671982
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662092500;
        bh=GxIG6DiV9b7WPghqVgemguXkCT0RjotSn0+XREvWQg4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rbhpGsRwWptn7sBnGZEudATDxIBvAVtzR9noqHHkW7odTG2Q8lnBqrTzHjURT3jME
         do+u9URe7Oh+CQCfaT5fQ4nGFMVMPfElBPXQv50M+D75r5Uk77Wwb7NCNELy3ttRG1
         plBStJaPTTO5KWySvS72h+Ir4r+jP8GK/aozqnuQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWQyX-1osZih2pyt-00Y5NK; Fri, 02
 Sep 2022 06:21:40 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 2/2] diff.c: More changes and tests around utf8_strwidth()
Date:   Fri,  2 Sep 2022 06:21:38 +0200
Message-Id: <20220902042138.13901-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LZqufC/lK5UQYiAp5ywS7yBbFV4gx/kXT4YdVMjSxMvNKlM4fTh
 12sDn1c5B7skx6GCdDUPdzraoIneue3e652vu+V6kwqiqH2kpKt1NPKPIVXQgpn7mI9mmOX
 8wIRsZNGw8aeWxyKbTpKDbMcP9ZoIJw426ze38/Tn2J1DqzRZ4DFDNMkND0fv8jATZmoIP+
 NQ8/EKWZhEnQQGYGtGhrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r/mItxjEHHg=:OkK23YrAaz6jmVt80fgg6Z
 zqJbO1Dnn0dlVqA8hwkZ23Ols/0rivWQcBwlROLKecoIwwm1oNt4/Yi5C6L/V2w1ZqvXRufue
 7flUIOKZfqqVZ7aCKtHxClUBz4R9Y37+DIedHy4tBVyOsWvr/vmAUwomf1+ELPHhpv0tMFRzs
 yRDnePsLLPbKVuj9OMJFeG+wGeRtVlWC3wpn3soq1Am4htoixgEA8Br+qPQ7OnDWnanPr2Ytj
 faSprKR84OWUqKXfnLxIW90o0dZixUNGXxkfrFSeNNvYA8p6aUwaMIJOvvxopNHz5f6mqcNFi
 lciza3R5EM7Ovu/LpBlc1zXZVYZBD9votB9EngQPyp21Xs3VDK3HaVS559RTFytMWq77eGr2Z
 +mDH+Y/RQQJPfFQ+RVRpRaQno4aDeOot6N1i1fqdAnALjgxl2WPM0AlsTg2Au4S6zdd/pELwb
 uXthHDzOJ7zns4WRFytF9paO8Th4oPCZHS972C3vPFpQOMnQF5gKJXDUw1MkFE0867/kmRyaN
 GzGvD0PUWqaVLvI9hMYeyVuaeYM/1cZ4Ukvyaz5Jba5b9nz1Z5slt1YCsYbLuq2QI5pQwbv1K
 W4gxscH7m4KMQTHq0SAbJtZXUq5knvEejLDXC2FBoIagXuHo/ABNWh+4L2DrfrF9vcO+L9OhL
 D4ypIwdvRfkz8hnnkcVD7kpr6Gf16YDWVpgKUCYysy/0x99/ne5/n1m6eERIMl3C8CWcUFoVX
 hoyiVoMcsFS5OTkeleTrRnn0Z2cXCq/fIr17QcpCSOV2k5aSDaEqKY+yWGHb0Ob7D0Q0+bV3h
 cdGE3QCRO3VfKg4r9szS91WT8LNiWbj6B9tUc3SE3eBrK60+gXhi31haMz8oJP1WHJPT0YEzu
 nthVNVgmAi5o8nPAZaWUqSS6UPgOtw9vOc24td140OyJMJPg0aMz/wIV5fkFwtgTlhfto2ZQZ
 iErIqyGV+Fg16OiX6LebefkijXrar9FGFsEA80OhdY/FVBY3oS4kskqKDargmo75BZ81c9JkR
 vOF27MI/UKLxNJnK/fpgv/AGG1uvNBmrMmKIjo74iKk8ZKltyAlMfLvsAaEgICwQ9FdafVqUb
 VhQnNAjK22JEkzxK0Y3QwqyslSs9GF0oQX/A3gCKqnIjSztYK42ILxE9PA4KYN3cuQgh9U1dY
 5sFx9GADMqdo6uAT9fAGdaNg6p
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

When unicode filenames (encoded in UTF-8) are used, the visible width
on the screen is not the same as strlen(filename).

For example, `git log --stat` may produce an output like this:

[snip the header]

 Arger.txt  | 1 +
 =C3=84rger.txt | 1 +
 2 files changed, 2 insertions(+)

The last commit uses utf8_strwidth() instead of strlen() in diff.c
and it is time to test the change.

And now we detect another problem that is fixed here: code like this
strbuf_addf(&out, "%-*s", len, name);
(or using the underlying snprintf() function) does not align the
buffer to a minimum of len measured in screen-width, but uses the
memory count.

One could be tempted to wish that snprintf() was UTF-8 aware.
That doesn't seem to be the case anywhere (tested on Linux and Mac),
probably snprintf() uses the "bytes in memory"/strlen() approach to be
compatible with older versions and this will never change.

The chosen solution is to split code in diff.c like this
strbuf_addf(&out, "%-*s", len, name);

into something like this:
size_t num_padding_spaces =3D 0;
// [snip]
if (len > utf8_strwidth(name))
    num_padding_spaces =3D len - utf8_strwidth(name);
strbuf_addf(&out, "%s", name);
if (num_padding_spaces)
    strbuf_addchars(&out, ' ', num_padding_spaces);

I couldn't convince myself to write a wrapper here that is
"easy to read and understandable" and would fit nicely into the chain of
strbuf_addX() calls used in diff.c

Tests:
Two things need to be tested:
 - The calculation of the maximum width
 - The calculation of num_padding_spaces

The name "textfile" is changed into "t=C3=ABxtfil=C3=AB", both have a widt=
h of 8.
If strlen() was used, to get the maximum width, the shorter "binfile" woul=
d
have been mis-aligned:
 binfile    |  [snip]
 t=C3=ABxtfil=C3=AB | [snip]

If only "binfile" would be renamed into "binfil=C3=AB":
 binfil=C3=AB |  [snip]
 textfile | [snip]

In order to verify that the width is calculated correctly everywhere,
"binfile" is renamed into "binfil=C3=AB", giving 1 bytes more in strlen()
"t=C3=ABxtfile" is renamed into "t=C3=ABxtfil=C3=AB", 2 byte more in strle=
n().

The updated t4012-diff-binary.sh checks the correct aligment:
 binfil=C3=AB  | [snip]
 t=C3=ABxtfil=C3=AB | [snip]

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c                 | 33 +++++++++++++++++++++------------
 t/t4012-diff-binary.sh | 14 +++++++-------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/diff.c b/diff.c
index b5df464de5..cf38e1dc88 100644
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
@@ -2621,8 +2621,8 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		}
 		fill_print_name(file);
 		len =3D utf8_strwidth(file->print_name);
-		if (max_len < len)
-			max_len =3D len;
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
index c509143c81..c64d9d2f40 100755
=2D-- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -113,20 +113,20 @@ test_expect_success 'diff --no-index with binary cre=
ation' '
 '

 cat >expect <<EOF
- binfile  |   Bin 0 -> 1026 bytes
- textfile | 10000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
+ binfil=C3=AB  |   Bin 0 -> 1026 bytes
+ t=C3=ABxtfil=C3=AB | 10000 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
 EOF

 test_expect_success 'diff --stat with binary files and big change count' =
'
-	printf "\01\00%1024d" 1 >binfile &&
-	git add binfile &&
+	printf "\01\00%1024d" 1 >binfil=C3=AB &&
+	git add binfil=C3=AB &&
 	i=3D0 &&
 	while test $i -lt 10000; do
 		echo $i &&
 		i=3D$(($i + 1)) || return 1
-	done >textfile &&
-	git add textfile &&
-	git diff --cached --stat binfile textfile >output &&
+	done >t=C3=ABxtfil=C3=AB &&
+	git add t=C3=ABxtfil=C3=AB &&
+	git -c core.quotepath=3Dfalse diff --cached --stat binfil=C3=AB t=C3=ABx=
tfil=C3=AB >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
=2D-
2.34.0


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622DECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 15:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiINPOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiINPNn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 11:13:43 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820657C18F
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663168419; bh=CXRKa2oJvGjGrgypdiXW3/0uCNCHIjMexlYQ/Ro1cbI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l0eg2OOUgZYHf32Zwsag6fRHOtUM0rvYx9xiACAFmjqAqnK/3r2XtL3OZ+maQxWCm
         mYeXTC3/AoG9JA/BSjQAPX6/IFSO2zvDGlF12TvhLaXHQFN2Kq5c8dQ8HWLdJrQXbY
         wPZtC88joQ/DtRFpjJ4+wiZ0KKTesHRIxK/6oWgzg+KuFq46lNlH3RKmCPBvWS1sdJ
         woX2BNSo68Jz5OCu2siAfDeTFbv62kS4R6W+F5No0y6hbfpaZM9jNJOsd4dWGjvNar
         52Vj2SoWPKZnCcx56HO8Ir640aOoNEPt9DsmhCnqcdvotAG+iF+allwUt03ntNyUd7
         7Nbf1qJN/gWgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1oqHoX3KbL-00IORy; Wed, 14
 Sep 2022 17:13:38 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
Date:   Wed, 14 Sep 2022 17:13:33 +0200
Message-Id: <20220914151333.3309-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FNzIpcsifz82dMRvtmblMPRrnj/yEBEj/i77JK/dhjI/8zG+cH9
 B4qKaUtv01H3RsArK19wG0kDqVQTDC80wsDbXiqPtdeB6nTZ2nwc68n/HcDxmLi2XgSL9Fo
 1Li06AEDzmoZEdJs2gz1JBOTB9k/4OEXB0B67IDtRfCpF/SDFsRbR3EiYiCPqU1RJ9Afjwd
 dMPB9AczGrAcv8m8ZhUEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vbUB+HVSzg0=:yTfq3I34tJIlp+5rF91/Ox
 4ilCnsvuk0e5j8neDRYMh8tfVSBu7R5hlgJg9n5YQ5IyWW8O5FFlxK/OUQnbYPX9txvdxbVsi
 8wAladsQjf7K4Yzfyc32cNpxAr4gDRINYMjXVBaDyEnngERY9FA0pgS9bteghGATOG0DHmn49
 Mn5XuojuwRpNoru2zg4YiFo0C4ZyLFBJ38jTDwHbGFQBVvkbAx9mqh3cVdoO3j0lALiSqjpmr
 a7QfYdtypLtIS29jwnfm2FqJNbzx9UUtWi/5/4bYSRVbgAP2uCVAPWo7ZF+vsSJA6RLS9r6xg
 2Z7p6u8skkxQ4AfK3RWTVeTaXsPCOxgb7EoladpB1sm7ngq3xQQH7GGRxl/VQn4+pupLlHi2q
 NmRtv30pkjcE6zb9loy8/bh6OnKVP7D60l4cF7+Oj1GwyhccFeo5Ip6sOWJed79GwqusS0Lua
 54ODSLaRuo/Gr5TkV8DIui8aGk7CGdR5qFlKDxO+podVabjMd2BxBADHhK914ioxDkNkXoZDI
 JyzPpo5cWWTfkiEbnT0asMDcF4JMVbmrhdhNfZYsmBSNdVbPKDC9jfZ+FUa5uxIqPn1/W0BOP
 wH28u+kKoghBF7UPjUP7qf5DvlYDgsqus53yCqefRJqhwKoboBeFo6H+XqGsWcDpcW3AETWJW
 VwGNxLsN5kvyPw0daJeddsEcc+MBIQn0Y/YCjYqACOrYnxshyi0dyiPNNR862KIU2eix6o6zo
 TDShP6LKME96L2QBX82hGO9xKlGyFGSRZg8FSNLazEOlV88gJru6eiYqAywZ1cVzREbXqJFfk
 2m1+po/dqurxDh5cl78hwSBFcHE5H2Wroc4ikDrzAkxG005HhYVdpt5gghmMLxtwBEBAE+NoS
 aLyXzo0nqcGB0lvCP33+00uMNW7Z4NCH0lZEUM8D4jRSRd5LU6gN9j8wysmtpkk73SYqq/8LI
 Q/aHq3WiBDqUcCKqZ5aF+cGsRfqntGkn081D14NZekCYu+qeqiemVXRa4TQwjC4ktCfPUAy2J
 ICk86dKhw980jFTW55vnW2/Q5vDeGGaEK/EIPQ+96r1ETcjso7HX+UjmEaQEIbe7BqJydyFsR
 pDR11C3Q7Igy6MMuzBietuxarU9SIHt4QRPB1gyrI0ApxRieift7SL/04OZTLmjmvA50nX00v
 g9sC4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

When unicode filenames (encoded in UTF-8) are used, the visible width
on the screen is not the same as strlen().

For example, `git log --stat` may produce an output like this:

[snip the header]

 Arger.txt  | 1 +
 =C3=84rger.txt | 1 +
 2 files changed, 2 insertions(+)

A side note: the original report was about cyrillic filenames.
After some investigations it turned out that
a) This is not a problem with "ambiguous characters" in unicode
b) The same problem exists for all unicode code points (so we
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

And then there is another problem, code like this:
strbuf_addf(&out, "%-*s", len, name);
(or using the underlying snprintf() function) does not align the
buffer to a minimum of len measured in screen-width, but uses the
memory count.

One could be tempted to wish that snprintf() was UTF-8 aware.
That doesn't seem to be the case anywhere (tested on Linux and Mac),
probably snprintf() uses the "bytes in memory"/strlen() approach to be
compatible with older versions and this will never change.

The basic idea is to change code in diff.c like this
strbuf_addf(&out, "%-*s", len, name);

into something like this:
int padding =3D len - utf8_strwidth(name);
if (padding < 0)
	padding =3D 0;
strbuf_addf(&out, " %s%*s", name, padding, "");

The real change is slighty bigger, as it, as well, integrates two calls
of strbuf_addf() into one.

Tests:
Two things need to be tested:
 - The calculation of the maximum width
 - The calculation of padding

The name "textfile" is changed into "t=C3=ABxtfil=C3=AB", both have a widt=
h of 8.
If strlen() was used, to get the maximum width, the shorter "binfile" woul=
d
have been mis-aligned:
 binfile    | [snip]
 t=C3=ABxtfil=C3=AB | [snip]

If only "binfile" would be renamed into "binfil=C3=AB":
 binfil=C3=AB | [snip]
 textfile | [snip]

In order to verify that the width is calculated correctly everywhere,
"binfile" is renamed into "binfil=C3=AB", giving 1 bytes more in strlen()
"t=C3=ABxtfile" is renamed into "t=C3=ABxtfil=C3=AB", 2 byte more in strle=
n().

The updated t4012-diff-binary.sh checks the correct aligment:
 binfil=C3=AB  | [snip]
 t=C3=ABxtfil=C3=AB | [snip]

Reported-by: Alexander Meshcheryakov <alexander.s.m@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c                 | 27 ++++++++++++++++-----------
 t/t4012-diff-binary.sh | 14 +++++++-------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a621..35b9da90fe 100644
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

@@ -2734,7 +2734,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		char *name =3D file->print_name;
 		uintmax_t added =3D file->added;
 		uintmax_t deleted =3D file->deleted;
-		int name_len;
+		int name_len, padding;

 		if (!file->is_interesting && (added + deleted =3D=3D 0))
 			continue;
@@ -2743,7 +2743,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		 * "scale" the filename
 		 */
 		len =3D name_width;
-		name_len =3D strlen(name);
+		name_len =3D utf8_strwidth(name);
 		if (name_width < name_len) {
 			char *slash;
 			prefix =3D "...";
@@ -2753,10 +2753,14 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
 			if (slash)
 				name =3D slash;
 		}
+		padding =3D len - utf8_strwidth(name);
+		if (padding < 0)
+			padding =3D 0;

 		if (file->is_binary) {
-			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
-			strbuf_addf(&out, " %*s", number_width, "Bin");
+			strbuf_addf(&out, " %s%s%*s | %*s",
+				    prefix, name, padding, "",
+				    number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
 				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
@@ -2776,8 +2780,9 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 			continue;
 		}
 		else if (file->is_unmerged) {
-			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
-			strbuf_addstr(&out, " Unmerged\n");
+			strbuf_addf(&out, " %s%s%*s | %*s",
+				    prefix, name, padding, "",
+				    number_width, "Unmerged");
 			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 					 out.buf, out.len, 0);
 			strbuf_reset(&out);
@@ -2803,10 +2808,10 @@ static void show_stats(struct diffstat_t *data, st=
ruct diff_options *options)
 				add =3D total - del;
 			}
 		}
-		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
-		strbuf_addf(&out, " %*"PRIuMAX"%s",
-			number_width, added + deleted,
-			added + deleted ? " " : "");
+		strbuf_addf(&out, " %s%s%*s | %*"PRIuMAX"%s",
+			    prefix, name, padding, "",
+			    number_width, added + deleted,
+			    added + deleted ? " " : "");
 		show_graph(&out, '+', add, add_c, reset);
 		show_graph(&out, '-', del, del_c, reset);
 		strbuf_addch(&out, '\n');
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CCCC38145
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 05:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiICFjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 01:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiICFjn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 01:39:43 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69C1CB0C
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662183577;
        bh=Cqmpz9Vvt6rzcm45CCyIsCgYublIXBo+uozgBQQ5iiA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KmJOdSR4UbO4qm01EWGsb6QbEcKYKGLRzJhIWxYCOFzpDuyC7YjODw802V6uowUFW
         Uz4OJcFaJFOMYE9UwvtmmFsWpsuALUybKk83aWr+z3Elp7oGr3GnngdMLJhOKx8K0P
         cJ2DpA/PmFUBaLTSFrT+ZEifB/mlxvzxCBZ0L5uQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1pAGH339uT-00ovZE; Sat, 03
 Sep 2022 07:39:36 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 2/2] diff.c: More changes and tests around utf8_strwidth()
Date:   Sat,  3 Sep 2022 07:39:34 +0200
Message-Id: <20220903053934.15629-1-tboegi@web.de>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ih4d4M1yb+mDrJXdlGpSvdBs9LQRsYqhRKUMLw3nV1uLTsztMkz
 SAwtwTJO8Fb7I0qpOGxJmA0dqO9IemDzhbA3dzLzY+DBXq3Ka1qhYkoyFkm9jahJoXE6Des
 xxeNj3LeNmj7fH5Wgc+CaNjJYYcE0KDsvRtcA+q6o7z8WRqfXSebOC+vW1r3XfSMnw7jGOM
 9LM7TLj+CStPlSF8DQnOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BeLLq4Me+gQ=:sxZ84pn+IaOQpdz/l/T36l
 yi8TrtLRu4wZe/dXsJpLjeENdvY6aLRZQ8JEPu0tZ9wNQYh4CnoagND7QiyChCQhL1VJL4UTe
 P1eUP1VjTy7+ccu6iXjT7AU8Lv1fg10lAIFVja56YWhnIxZs9rIP3Ecb3T0RAk4467JatvTWa
 S4nDJfCUAs6gh5Jul1TwDh3g7SLnVqcDaiMEn8zVamL+IGHPZZV3yc/GAFkBQ8k1NU7sB5ZZ9
 XapdcFIK41EDd3vyFIIyK4Fk5Rm1pa9YwcmVTW/3Fa5JWjKZ1Aw/johwjJmGL7Gc9DeVEYVGB
 ERXGF9uCRkavDNNqoNI/wtuuui7PeAs3LCHRJMepNXAcpyc9rH/PpqeYcLiOvVgXvZopMYixq
 uKP3g3KAJ1tKdN1ojroXF6T97tRo/9eBMtA6vL31z4dMhXrv2MU5sfIvApJPGYmXPFFJVJMAe
 FFpil1bJC71LW1CRwekJCw5kSOd9OZ2Ofpm39mSz6zvhrK5beyKOHiOKuHZKzFqumt221tfU6
 vjC8txs3nDRW4yJTgS+Ho7dBqxtUSxeBvjnqElC1PPsoeH0XRhoZ9Zr1//6LEO8cOdbZstVsu
 OWcvdbJNG54KJhi0QG6HvvVeHpAKdP5kysid+OmXKMmnQaYi4KZpp6pCCXE5Hg4tbLbciora4
 /EdzI9avygV3a/jX4GEbqhReOKXY72qeQEMsaaKuSy+Wi9vH4hkRo9H/aelO6LShV9SA69h3U
 QiIgP+m1KjbD7i8xLU3pN7aKGMa5G+K0o/IMLtDxM0aibiKdP6Sdj73H5ch3lyWzZCtJexBbU
 G6ZrbG+eLYhZAFhTEJbvu/ruiI8iS1WdDmHwbtOMA6+f2JB3VkmoYlLw4VuYV+HrgGBBgTXQI
 rliJIAa/JzOIlDYn7a+j3NairV2OunV32GtjnCqzmDRFXc09ta7B0KPIVvFf1UgM3DAhXemOw
 xF4Xpu2pI6gYnmovPrmtIUxRv21ESBQO9G8YFK0cls20I1AkRRTXv8KkBGcNcqrLF7A4VEylt
 8qBWtN21pW67Nx6qGdwUwJt8VuvtnoH0yllknRgnVPp7GmdFx/OQA9R9xNYJU6ig56l78NwMR
 YUR+s3IxPcmnSUkzzndVW/SSMcJbfYzwdjoM9C6O76MOQ97MKUezJG6As4RKrmyXDoAJVTtxS
 qgvATONtgk9GQsJl+beQdvcRbl
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

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 diff.c                 | 23 ++++++++++++++---------
 t/t4012-diff-binary.sh | 14 +++++++-------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index b5df464de5..35b9da90fe 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2734,7 +2734,7 @@ static void show_stats(struct diffstat_t *data, stru=
ct diff_options *options)
 		char *name =3D file->print_name;
 		uintmax_t added =3D file->added;
 		uintmax_t deleted =3D file->deleted;
-		int name_len;
+		int name_len, padding;

 		if (!file->is_interesting && (added + deleted =3D=3D 0))
 			continue;
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


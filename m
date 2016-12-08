Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AFDB20259
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932245AbcLHOYh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:37 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36005 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbcLHOYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so3850140wma.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtaP5Zh6YMzMsLESsxDwp0PQOTNXnthu/FAnUrQKomc=;
        b=nMVI//PNqI4yZhe/+Myiz8w90u572nZBVP/mJfa0f27GXyIGGOqKTgkrk/TWMWZwZO
         iB45shCr2PsSv56IsRtEhJkkTQB8IwiOFpqTXHoKQKzUHlmv1x7qAMwYnL2bCBCK4JW3
         vShc6YhTe/aP8DbSO5UOg1w4Y0PHeBVsg6pkXTd4DmjzGspInakDrr19ygL3GyP8GlXG
         XI/QSn5F4PYXJ0PyC4puWgqcImW6M1LqcOiuc1X1PoGSkLZX9OpfLxbPzdWpULfJAB+n
         57UX1S48pDy4p+qjw+eV8kqrQw7WPdqSBPW78X0QVDZ/lq/NR7gJVuHMZgLR8e8ELRoK
         Gq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtaP5Zh6YMzMsLESsxDwp0PQOTNXnthu/FAnUrQKomc=;
        b=ERF06RgJvvN8MvWalU+lfVAI2+s5Px/30HsQKXQSsmSzXDfv4kcVvO36FOF9Ihr9Mh
         DzccHtHrh3cS42+EZ7QdvfDu1AlHCaUOulJiPNoIxxWZ+6EUgJiWyXDeHGFn44s5F2+U
         DNX9Q9cKcnQfOjgrlymBJVkjxXX2KoeRDI0yBzGONUc/KU9IHhdzuy2vU73umQU7WAO2
         J1taU8B8h54SaP+yxgzI+ApQjyqDBy2EFu8OYub+X0VZKqdyZtCGaY2hO2kSOj1wx2s/
         /9H7jM+/YiQveG9SK7PIX/CwtAv6TZnTksmj0bk6Qyuyjx3jzYOzgCfSGLOgevr2u+Ct
         Oltg==
X-Gm-Message-State: AKaTC02k4hMZs4ezFb7yx6px1dLjyn0OuupHDAI0aysXf1I0zDZ8XgsoB69QHLevl9OmMw==
X-Received: by 10.28.131.1 with SMTP id f1mr2551907wmd.43.1481207072790;
        Thu, 08 Dec 2016 06:24:32 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 6/7] versioncmp: use earliest-longest contained suffix to determine sorting order
Date:   Thu,  8 Dec 2016 15:24:00 +0100
Message-Id: <20161208142401.1329-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161208142401.1329-1-szeder.dev@gmail.com>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When comparing tagnames, it is possible that a tagname contains more
than one of the configured prerelease suffixes around the first
different character.  After fixing a bug in the previous commit such a
tagname is sorted according to the contained suffix which comes first
in the configuration.  This is, however, not quite the right thing to
do in the following corner cases:

  1.   $ git -c versionsort.suffix=-bar
             -c versionsort.suffix=-foo-baz
             -c versionsort.suffix=-foo-bar
             tag -l --sort=version:refname 'v1*'
       v1.0-foo-bar
       v1.0-foo-baz

     The suffix of the tagname 'v1.0-foo-bar' is clearly '-foo-bar',
     so it should be listed last.  However, as it also contains '-bar'
     around the first different character, it is listed first instead,
     because that '-bar' suffix comes first the configuration.

  2. One of the configured suffixes starts with the other:

       $ git -c versionsort.prereleasesuffix=-pre \
             -c versionsort.prereleasesuffix=-prerelease \
             tag -l --sort=version:refname 'v2*'
       v2.0-prerelease1
       v2.0-pre1
       v2.0-pre2

     Here the tagname 'v2.0-prerelease1' should be the last.  When
     comparing 'v2.0-pre1' and 'v2.0-prerelease1' the first different
     characters are '1' and 'r', respectively.  Since this first
     different character must be part of the configured suffix, the
     '-pre' suffix is not recognized in the first tagname.  OTOH, the
     '-prerelease' suffix is properly recognized in
     'v2.0-prerelease1', thus it is listed first.

Improve version sort in these corner cases, and

  - look for a configured prerelease suffix containing the first
    different character or ending right before it, so the '-pre'
    suffixes are recognized in case (2).  This also means that
    when comparing tagnames 'v2.0-pre1' and 'v2.0-pre2',
    swap_prereleases() would find the '-pre' suffix in both, but then
    it will return "undecided" and the caller will do the right thing
    by sorting based in '1' and '2'.

  - If the tagname contains more than one suffix, then give precedence
    to the contained suffix that starts at the earliest offset in the
    tagname to address (1).

  - If there are more than one suffixes starting at that earliest
    position, then give precedence to the longest of those suffixes,
    thus ensuring that in (2) the tagname 'v2.0-prerelease1' won't be
    sorted based on the '-pre' suffix.

Add tests for these corner cases and adjust the documentation
accordingly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config.txt |  6 ++++--
 t/t7004-tag.sh           | 31 +++++++++++++++++++++++++++++++
 versioncmp.c             | 33 +++++++++++++++++++++++++--------
 3 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c1a9616e9..58009c70c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3010,8 +3010,10 @@ order of suffixes in the config file determines the sorting order
 (e.g. if "-pre" appears before "-rc" in the config file then 1.0-preXX
 is sorted before 1.0-rcXX).
 If more than one suffixes match the same tagname, then that tagname will
-be sorted according to the matching suffix which comes first in the
-configuration.
+be sorted according to the suffix which starts at the earliest position in
+the tagname.  If more than one different matching suffixes start at
+that earliest position, then that tagname will be sorted according to the
+longest of those suffixes.
 The sorting order between different suffixes is undefined if they are
 in multiple config files.
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index c7aaace8c..e2efe312d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1564,6 +1564,37 @@ test_expect_success 'version sort with prerelease reordering, multiple suffixes
 	test_cmp expect actual
 '
 
+test_expect_success 'version sort with prerelease reordering, multiple suffixes match the same tag' '
+	test_config versionsort.prereleaseSuffix -bar &&
+	git config --add versionsort.prereleaseSuffix -foo-baz &&
+	git config --add versionsort.prereleaseSuffix -foo-bar &&
+	git tag foo1.8-foo-bar &&
+	git tag foo1.8-foo-baz &&
+	git tag foo1.8 &&
+	git tag -l --sort=version:refname "foo1.8*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.8-foo-baz
+	foo1.8-foo-bar
+	foo1.8
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'version sort with prerelease reordering, multiple suffixes match starting at the same position' '
+	test_config versionsort.prereleaseSuffix -pre &&
+	git config --add versionsort.prereleaseSuffix -prerelease &&
+	git tag foo1.9-pre1 &&
+	git tag foo1.9-pre2 &&
+	git tag foo1.9-prerelease1 &&
+	git tag -l --sort=version:refname "foo1.9*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.9-pre1
+	foo1.9-pre2
+	foo1.9-prerelease1
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'version sort with very long prerelease suffix' '
 	test_config versionsort.prereleaseSuffix -very-looooooooooooooooooooooooong-prerelease-suffix &&
 	git tag -l --sort=version:refname
diff --git a/versioncmp.c b/versioncmp.c
index f86ac562e..ae0a9199b 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -27,14 +27,18 @@ static int initialized;
 /*
  * off is the offset of the first different character in the two strings
  * s1 and s2. If either s1 or s2 contains a prerelease suffix containing
- * that offset, then that string will be forced to be on top.
+ * that offset or a suffix ends right before that offset, then that
+ * string will be forced to be on top.
  *
  * If both s1 and s2 contain a (different) suffix around that position,
  * their order is determined by the order of those two suffixes in the
  * configuration.
  * If any of the strings contains more than one different suffixes around
  * that position, then that string is sorted according to the contained
- * suffix which comes first in the configuration.
+ * suffix which starts at the earliest offset in that string.
+ * If more than one different contained suffixes start at that earliest
+ * offset, then that string is sorted according to the longest of those
+ * suffixes.
  *
  * Return non-zero if *diff contains the return value for versioncmp()
  */
@@ -44,27 +48,40 @@ static int swap_prereleases(const char *s1,
 			    int *diff)
 {
 	int i, i1 = -1, i2 = -1;
+	int start_at1 = off, start_at2 = off, match_len1 = -1, match_len2 = -1;
 
 	for (i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
-		int j, start, suffix_len = strlen(suffix);
+		int j, start, end, suffix_len = strlen(suffix);
 		if (suffix_len < off)
-			start = off - suffix_len + 1;
+			start = off - suffix_len;
 		else
 			start = 0;
-		for (j = start; j <= off; j++)
-			if (i1 == -1 && starts_with(s1 + j, suffix)) {
+		end = match_len1 < suffix_len ? start_at1 : start_at1-1;
+		for (j = start; j <= end; j++)
+			if (starts_with(s1 + j, suffix)) {
 				i1 = i;
+				start_at1 = j;
+				match_len1 = suffix_len;
 				break;
 			}
-		for (j = start; j <= off; j++)
-			if (i2 == -1 && starts_with(s2 + j, suffix)) {
+		end = match_len2 < suffix_len ? start_at2 : start_at2-1;
+		for (j = start; j <= end; j++)
+			if (starts_with(s2 + j, suffix)) {
 				i2 = i;
+				start_at2 = j;
+				match_len2 = suffix_len;
 				break;
 			}
 	}
 	if (i1 == -1 && i2 == -1)
 		return 0;
+	if (i1 == i2)
+		/* Found the same suffix in both, e.g. "-rc" in "v1.0-rcX"
+		 * and "v1.0-rcY": the caller should decide based on "X"
+		 * and "Y". */
+		return 0;
+
 	if (i1 >= 0 && i2 >= 0)
 		*diff = i1 - i2;
 	else if (i1 >= 0)
-- 
2.11.0.78.g5a2d011


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3281FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbcLHOYa (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:30 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34695 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbcLHOY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:29 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so54695889wjc.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kuix8g9bfZzkuzomJU73N1gDooo6DUMgtagYRLIirjU=;
        b=vTo7KNFc/i63D3TZnZp/ei/29UR4NBFCfnCfb/em1qCoNyaSxAJ8qZe9COiOdDA47f
         5boqVuWUsx+dG7CU6iIyxHmNdwm4Q7XoOTMUGJ/CHYAeus6Kbo+XN0UD7CTA2pjJF44u
         sn4Q7hWKno6wKifUHQ393m46G9R9DJ0e6TYP2FExgukHWhgfG+uQeBrTxFuNsJpgJbG7
         r3gFtbj5u4/U2VeS6bWgKw6r2uSqPD3mh2M+FtxidXMgjvtyAUAcvuzXTnSg1r6RKMAA
         N8R0T5QpUxffjXdlQTvOFpVCcTTakFrHj4sXXuW23SuWm0opemPcu6Vk3n/E32htBxo+
         DMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kuix8g9bfZzkuzomJU73N1gDooo6DUMgtagYRLIirjU=;
        b=BMfJKK0H2dpGpxMutVRbScdBnCvIcxLsiT+CI1KBvld1j1tVAEBlt1B6OAeyqvWUaW
         z+2k7pUzLi+uMIvtFOb8tZL7wADQwRB3YromEjxE4zB8MANcKdTBfbSyO6QmGnVYFD0y
         PKpXgumKqweM6bMfTELPhHwCjv5jlU31w/JqILV2dNu9K+2yWzjfKj4uDiT5TTLRnXj+
         Yze2BFFWhAJxqQMcBOw7ttxcA0wnJ1qXKKNKzfba+SQE+/8qES4eGG6YSNVz5vdHY/7N
         ZC2hTlWBBJ+4SPX9bQi/0+ve5LTK0ybuqavPS0zpDrFYx7ED87o3KG/zF3CQT+YXcaog
         N2uQ==
X-Gm-Message-State: AKaTC02qOczFllplK6iiorG1TljvUD69wCerlYhHoep+iMmmMkJ1bfcbcyR5Ac3p4i1l4w==
X-Received: by 10.194.137.15 with SMTP id qe15mr72206233wjb.16.1481207067437;
        Thu, 08 Dec 2016 06:24:27 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 0/7] Fix and generalize version sort reordering
Date:   Thu,  8 Dec 2016 15:23:54 +0100
Message-Id: <20161208142401.1329-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> After having slept on this a couple of times

After having slept on it a few (erm...) more times...

> I think the longest
> matching prerelease suffix should determine the sorting order.
> 
> A release tag usually consists of an optional prefix, e.g. 'v' or
> 'snapshot-', followed by the actual version number, followed by an
> optional suffix.  In the contrived example quoted above this suffix
> is '-foo-bar', thus it feels wrong to match '-bar' against it, when
> the user explicitly configured '-foo-bar' as prerelease suffix as
> well.

At the risk of overthinking it: I think it would be more correct to
say that the earliest starting matching prerelease suffix should
determine the sorting order in the first place.

> Then here is a more realistic case for sorting based on the longest
> matching suffix, where
> 
>    - a longer suffix starts with the shorter one,
>    - and the longer suffix comes after the shorter one in the
>      configuration.
> 
> With my patches it looks like this:
> 
>     $ git -c versionsort.prereleasesuffix=-pre \
>           -c versionsort.prereleasesuffix=-prerelease \
>           tag -l --sort=version:refname
>     v1.0.0-prerelease1
>     v1.0.0-pre1
>     v1.0.0-pre2
>     v1.0.0

And when there happen to be more than one matching suffixes starting
at the same earliest position, then we should pick the longest of
them.  The new patch 6/7 implements this behavior.

Changes since v1:
 - Documentation, in-code comment and commit message updates.
 - Use different tagnames and suffixes in the tests, keeping the new
   tests simpler and changes to existing tests smaller.
 - Added a test of questionable value to try to check that we don't
   read memory before the tagname strings in case of an unusually long
   suffix.
 - Removed unnecessary {}.
 - Added two patches on top to address the corner cases and to
   introduce 'versionsort.suffix' for the resulting more general
   suffix reordering behavior.

The interdiff at the bottom is between v1 and only the first five
patches of v2, i.e. not including the two new patches.  I think it's
easier to judge the changes this way.

SZEDER Gábor (7):
  t7004-tag: delete unnecessary tags with test_when_finished
  t7004-tag: use test_config helper
  t7004-tag: add version sort tests to show prerelease reordering issues
  versioncmp: pass full tagnames to swap_prereleases()
  versioncmp: cope with common part overlapping with prerelease suffix
  versioncmp: use earliest-longest contained suffix to determine sorting
    order
  versioncmp: generalize version sort suffix reordering

 Documentation/config.txt  |  44 ++++++++++++----
 Documentation/git-tag.txt |   4 +-
 t/t7004-tag.sh            | 132 +++++++++++++++++++++++++++++++++++++++-------
 versioncmp.c              |  68 +++++++++++++++++-------
 4 files changed, 196 insertions(+), 52 deletions(-)

-- 
2.11.0.78.g5a2d011


diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb6790d..c1a9616e9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3008,8 +3008,12 @@ versionsort.prereleaseSuffix::
 This variable can be specified multiple times, once per suffix. The
 order of suffixes in the config file determines the sorting order
 (e.g. if "-pre" appears before "-rc" in the config file then 1.0-preXX
-is sorted before 1.0-rcXX). The sorting order between different
-suffixes is undefined if they are in multiple config files.
+is sorted before 1.0-rcXX).
+If more than one suffixes match the same tagname, then that tagname will
+be sorted according to the matching suffix which comes first in the
+configuration.
+The sorting order between different suffixes is undefined if they are
+in multiple config files.
 
 web.browser::
 	Specify a web browser that may be used by some commands.
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f0cfe1fa3..c7aaace8c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1511,14 +1511,14 @@ test_expect_success 'invalid sort parameter in configuratoin' '
 '
 
 test_expect_success 'version sort with prerelease reordering' '
-	test_config versionsort.prereleaseSuffix -beta &&
-	git tag foo1.6-beta1 &&
-	git tag foo1.6-beta2 &&
+	test_config versionsort.prereleaseSuffix -rc &&
+	git tag foo1.6-rc1 &&
+	git tag foo1.6-rc2 &&
 	git tag -l --sort=version:refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.3
-	foo1.6-beta1
-	foo1.6-beta2
+	foo1.6-rc1
+	foo1.6-rc2
 	foo1.6
 	foo1.10
 	EOF
@@ -1526,54 +1526,49 @@ test_expect_success 'version sort with prerelease reordering' '
 '
 
 test_expect_success 'reverse version sort with prerelease reordering' '
-	test_config versionsort.prereleaseSuffix -beta &&
+	test_config versionsort.prereleaseSuffix -rc &&
 	git tag -l --sort=-version:refname "foo*" >actual &&
 	cat >expect <<-\EOF &&
 	foo1.10
 	foo1.6
-	foo1.6-beta2
-	foo1.6-beta1
+	foo1.6-rc2
+	foo1.6-rc1
 	foo1.3
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'version sort with prerelease reordering and common leading character' '
-	test_config versionsort.prereleaseSuffix -beta &&
-	git tag foo1.6-after1 &&
-	git tag -l --sort=version:refname "foo*" >actual &&
+	test_config versionsort.prereleaseSuffix -before &&
+	git tag foo1.7-before1 &&
+	git tag foo1.7 &&
+	git tag foo1.7-after1 &&
+	git tag -l --sort=version:refname "foo1.7*" >actual &&
 	cat >expect <<-\EOF &&
-	foo1.3
-	foo1.6-beta1
-	foo1.6-beta2
-	foo1.6
-	foo1.6-after1
-	foo1.10
+	foo1.7-before1
+	foo1.7
+	foo1.7-after1
 	EOF
 	test_cmp expect actual
 '
 
-# Capitalization of suffixes is important here, because "-RC" would normally
-# be sorted before "-beta" and the config settings should override that.
 test_expect_success 'version sort with prerelease reordering, multiple suffixes and common leading character' '
-	test_config versionsort.prereleaseSuffix -beta &&
-	git config --add versionsort.prereleaseSuffix -RC &&
-	git tag foo1.6-RC1 &&
-	git tag foo1.6-RC2 &&
-	git tag -l --sort=version:refname "foo*" >actual &&
+	test_config versionsort.prereleaseSuffix -before &&
+	git config --add versionsort.prereleaseSuffix -after &&
+	git tag -l --sort=version:refname "foo1.7*" >actual &&
 	cat >expect <<-\EOF &&
-	foo1.3
-	foo1.6-beta1
-	foo1.6-beta2
-	foo1.6-RC1
-	foo1.6-RC2
-	foo1.6
-	foo1.6-after1
-	foo1.10
+	foo1.7-before1
+	foo1.7-after1
+	foo1.7
 	EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'version sort with very long prerelease suffix' '
+	test_config versionsort.prereleaseSuffix -very-looooooooooooooooooooooooong-prerelease-suffix &&
+	git tag -l --sort=version:refname
+'
+
 run_with_limited_stack () {
 	(ulimit -s 128 && "$@")
 }
diff --git a/versioncmp.c b/versioncmp.c
index 87b49a622..f86ac562e 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -26,16 +26,15 @@ static int initialized;
 
 /*
  * off is the offset of the first different character in the two strings
- * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
- * at that offset or the character at that offset is part of a
- * prerelease suffix, then that string will be forced to be on top.
+ * s1 and s2. If either s1 or s2 contains a prerelease suffix containing
+ * that offset, then that string will be forced to be on top.
  *
- * If both s1 and s2 contain a (different) suffix at that position, the
- * order is determined by config file.
- *
- * Note that we don't have to deal with the situation when both s1 and
- * s2 contain the same suffix because the common part is already
- * consumed by the caller.
+ * If both s1 and s2 contain a (different) suffix around that position,
+ * their order is determined by the order of those two suffixes in the
+ * configuration.
+ * If any of the strings contains more than one different suffixes around
+ * that position, then that string is sorted according to the contained
+ * suffix which comes first in the configuration.
  *
  * Return non-zero if *diff contains the return value for versioncmp()
  */
@@ -53,18 +52,16 @@ static int swap_prereleases(const char *s1,
 			start = off - suffix_len + 1;
 		else
 			start = 0;
-		for (j = start; j <= off; j++) {
+		for (j = start; j <= off; j++)
 			if (i1 == -1 && starts_with(s1 + j, suffix)) {
 				i1 = i;
 				break;
 			}
-		}
-		for (j = start; j <= off; j++) {
+		for (j = start; j <= off; j++)
 			if (i2 == -1 && starts_with(s2 + j, suffix)) {
 				i2 = i;
 				break;
 			}
-		}
 	}
 	if (i1 == -1 && i2 == -1)
 		return 0;

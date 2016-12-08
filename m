Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0811FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbcLHOYf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:35 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33701 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbcLHOYd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:33 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so54758782wjc.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJLqIURFiQhVe8jY/y+KGplEXram3IRhjhpBFzy4JyU=;
        b=jKtQpoc9TxK96S+DCwmJ67dAiIorGv6skRF9ciDJiBY1XOfpPWz9wgpcEBtUmC+Cdk
         Vzp+DT/cDlsHKc0dwMhgIgy8snmVEbZ2zX9oljCPnAw1BuondLAagdk/P10SVEbROPAE
         zNGDWqB93Bq7hcy+LSJm9CCi58CApn9OtKqLSP9PrTLfD/GnJaTvCUJ6B8SGNTHwcbgA
         STlEzmh6v1uwFyeYbOgkep4TEs6+AF6vyhxOzbKQEAsGHpRP3kktwlTG54fSagKhzsVr
         V6EGVSni1RhOrVQ00MAxR9tK8vfcsR9IDnZmUShKoG0PP/rdCGG4Ozt3p36tNABmyXZB
         rVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJLqIURFiQhVe8jY/y+KGplEXram3IRhjhpBFzy4JyU=;
        b=M4GJZmJNepWzoaXBJqoo7Ac5OFJt6pCn2Muk4NJbQlmGYdwwFYFFWCCtkyTmUXjHFO
         Kl975mX40jIETKSrX3lWsj2Ca7UyaZGF46nyvflsMLLgPjVGZ2k2Zx+KaViR9gxVWn6w
         OrKoeeNP0SvDFMVtO0Lm0BaKIyuA17j2GYa7UJIHeQdXu+lMGgJZuh9e1340/Gg8M9R/
         v+FPenghFgkB6VXxKo3NE1DvlyygTr1Tq8InWCMuJYetcM5d+fjatS8Am33+TcbOtimt
         pfRj0zk9JyrieMlQifmbxuyNkWtE5uzl0IzW9/P1wRInyGm3kL4CG+QmEzMxgbn3dkiz
         AMQQ==
X-Gm-Message-State: AKaTC02K/5Iq4wq0HNNrEZb3WUnx4Rk+cUn56/ZlbniXKYnB60jbtWBv+xM5HJGQkQwsOQ==
X-Received: by 10.194.111.102 with SMTP id ih6mr62656139wjb.214.1481207071878;
        Thu, 08 Dec 2016 06:24:31 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 5/7] versioncmp: cope with common part overlapping with prerelease suffix
Date:   Thu,  8 Dec 2016 15:23:59 +0100
Message-Id: <20161208142401.1329-6-szeder.dev@gmail.com>
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

Version sort with prerelease reordering sometimes puts tagnames in the
wrong order, when the common part of two compared tagnames overlaps
with the leading character(s) of one or more configured prerelease
suffixes.  Note the position of "v2.1.0-beta-1":

  $ git -c versionsort.prereleaseSuffix=-beta \
        tag -l --sort=version:refname v2.1.*
  v2.1.0-beta-2
  v2.1.0-beta-3
  v2.1.0
  v2.1.0-RC1
  v2.1.0-RC2
  v2.1.0-beta-1
  v2.1.1
  v2.1.2

The reason is that when comparing a pair of tagnames, first
versioncmp() looks for the first different character in a pair of
tagnames, and then the swap_prereleases() helper function looks for a
configured prerelease suffix _starting at_ that character.  Thus, when
in the above example the sorting algorithm happens to compare the
tagnames "v2.1.0-beta-1" and "v2.1.0-RC2", swap_prereleases() tries to
match the suffix "-beta" against "beta-1" to no avail, and the two
tagnames erroneously end up being ordered lexicographically.

To fix this issue change swap_prereleases() to look for configured
prerelease suffixes _containing_ the position of that first different
character.

Care must be taken, when a configured suffix is longer than the
tagnames' common part up to the first different character, to avoid
reading memory before the beginning of the tagnames.  Add a test that
uses an exceptionally long prerelease suffix to check for this, in the
hope that in case of a regression the illegal memory access causes a
segfault in 'git tag' on one of the commonly used platforms (the test
happens to pass successfully on my Linux system with the safety check
removed), or at least makes valgrind complain.

Under some circumstances it's possible that more than one prerelease
suffixes can be found in the same tagname around that first different
character.  With this simple bugfix patch such a tagname is sorted
according to the contained suffix that comes first in the
configuration for now.  This is less than ideal in some cases, and the
following patch will take care of those.

Reported-by: Leho Kraav <leho@conversionready.com>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config.txt |  8 ++++++--
 t/t7004-tag.sh           |  9 +++++++--
 versioncmp.c             | 28 +++++++++++++++++++++-------
 3 files changed, 34 insertions(+), 11 deletions(-)

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
index 6445aae29..c7aaace8c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1538,7 +1538,7 @@ test_expect_success 'reverse version sort with prerelease reordering' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'version sort with prerelease reordering and common leading character' '
+test_expect_success 'version sort with prerelease reordering and common leading character' '
 	test_config versionsort.prereleaseSuffix -before &&
 	git tag foo1.7-before1 &&
 	git tag foo1.7 &&
@@ -1552,7 +1552,7 @@ test_expect_failure 'version sort with prerelease reordering and common leading
 	test_cmp expect actual
 '
 
-test_expect_failure 'version sort with prerelease reordering, multiple suffixes and common leading character' '
+test_expect_success 'version sort with prerelease reordering, multiple suffixes and common leading character' '
 	test_config versionsort.prereleaseSuffix -before &&
 	git config --add versionsort.prereleaseSuffix -after &&
 	git tag -l --sort=version:refname "foo1.7*" >actual &&
@@ -1564,6 +1564,11 @@ test_expect_failure 'version sort with prerelease reordering, multiple suffixes
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
index a55c23ad5..f86ac562e 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -26,12 +26,15 @@ static int initialized;
 
 /*
  * off is the offset of the first different character in the two strings
- * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
- * at that offset, it will be forced to be on top.
+ * s1 and s2. If either s1 or s2 contains a prerelease suffix containing
+ * that offset, then that string will be forced to be on top.
  *
- * If both s1 and s2 contain a (different) suffix at that position,
+ * If both s1 and s2 contain a (different) suffix around that position,
  * their order is determined by the order of those two suffixes in the
  * configuration.
+ * If any of the strings contains more than one different suffixes around
+ * that position, then that string is sorted according to the contained
+ * suffix which comes first in the configuration.
  *
  * Return non-zero if *diff contains the return value for versioncmp()
  */
@@ -44,10 +47,21 @@ static int swap_prereleases(const char *s1,
 
 	for (i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
-		if (i1 == -1 && starts_with(s1 + off, suffix))
-			i1 = i;
-		if (i2 == -1 && starts_with(s2 + off, suffix))
-			i2 = i;
+		int j, start, suffix_len = strlen(suffix);
+		if (suffix_len < off)
+			start = off - suffix_len + 1;
+		else
+			start = 0;
+		for (j = start; j <= off; j++)
+			if (i1 == -1 && starts_with(s1 + j, suffix)) {
+				i1 = i;
+				break;
+			}
+		for (j = start; j <= off; j++)
+			if (i2 == -1 && starts_with(s2 + j, suffix)) {
+				i2 = i;
+				break;
+			}
 	}
 	if (i1 == -1 && i2 == -1)
 		return 0;
-- 
2.11.0.78.g5a2d011


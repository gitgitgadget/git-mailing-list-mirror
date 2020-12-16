Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F2C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 10:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE102313C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 10:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgLPKKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 05:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgLPKKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 05:10:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E2C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 02:09:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p18so5705607pgm.11
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM3Kc2eCcCGfrvvqN/E7qivNeLF/s7ppITzGbpDUzSI=;
        b=P1vN5akcrIARatX0O2Nln1xzWC98inkWWLWSjVVo8R8hLBZcrgVIO72MU6PPA7jxWp
         gzzdygwKi5Vk9tqjGf9dIDeKjQMxSBskCjTHe5KMUx1yxJYYYXJQ+vR7UABbPqDaMCtx
         OURmr+qBURc11xk/DXv7JIwVO6zaLXJ9Btj1zEYkE6vZ/d1vpg4b7J6lqIENjnkUX4hI
         fgNyu9ecE6nZucRGLuLyFw8zWYh4+AoUqimOhHIW6rbk+ZU2cGtxMLTkpeFl0GKOkY3f
         xB2L46Z0yJwoz5RQZYnLOV/DBTfYBL5MZrF4CRzklwvfswY6yWZ04dcmGpdi0WQEpHw3
         Qk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM3Kc2eCcCGfrvvqN/E7qivNeLF/s7ppITzGbpDUzSI=;
        b=AKRxetsFbRBrSL5E4YriGNuYCDL3zvuKmj0/TdNEJ7NbPKABpjhSMrEIlI4TALlG0Y
         GkCX7+5N5AW2F3TNKHdOkUiliy68r+sJCifdfeBVX3oVhvf/bDjHxrFvzMFTD5Y+SpoN
         igkdhA/Z9eAGosnDgle8P/OUAIrM+zQplVXZy/xtKvYQ9boQ/2JWFzey1GGiV1NjZUGb
         IFJisRnJ3IGVDVVueaWEfamo1qAEEbREODQ9GiBvVXnQR/savlL5j0OaGOgUNxd1wAEj
         GG+LawT3om+Q79m5BsDxwwbn/ie8Quj65q+btmA6AIodPXGu99C+PZ5PNMlSq3dCVI1m
         glEw==
X-Gm-Message-State: AOAM530c3bEES9luLo71F2c1seWtbU8GiDBJZqWOSz1VPHB/tE1pHcYm
        SQiCgSkiw7jlmLTHnDuKuID+k37PM1230UwR
X-Google-Smtp-Source: ABdhPJx+xVOXYKswAL6u83lFyMhl7zmlcsq7tgDjfrM9UDo+LeXZIKcrDGFb0osmmt6ps7JRnzh0Qw==
X-Received: by 2002:aa7:868e:0:b029:19e:3ac9:f622 with SMTP id d14-20020aa7868e0000b029019e3ac9f622mr31374327pfo.37.1608113396165;
        Wed, 16 Dec 2020 02:09:56 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id v10sm1653235pjr.47.2020.12.16.02.09.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 02:09:55 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "Daniel C . Klauer" <daniel.c.klauer@web.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH] pack-redundant: fix crash when one packfile in repo
Date:   Wed, 16 Dec 2020 05:09:52 -0500
Message-Id: <20201216100952.16890-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbHOczhRoJkOofFNQ6VA3BiyOF=QjffFBDvLn43Ts8B67w@mail.gmail.com>
References: <CANYiYbHOczhRoJkOofFNQ6VA3BiyOF=QjffFBDvLn43Ts8B67w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Command `git pack-redundant --all` will crash if there is only one
packfile in the repository.  This is because, if there is only one
packfile in local_packs, `cmp_local_packs` will do nothing and will
leave `pl->unique_objects` as uninitialized.

Junio will add additional option for pack-redundant for preparing
its removal.  So replace `git pack-redundant` command with variable
`$git_pack_redundant` in t5323.

Reported-by: Daniel C. Klauer <daniel.c.klauer@web.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/pack-redundant.c  |  6 ++++
 t/t5323-pack-redundant.sh | 65 +++++++++++++++++++++++++++++----------
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 178e3409b7..690775fa82 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -473,6 +473,12 @@ static void cmp_local_packs(void)
 {
 	struct pack_list *subset, *pl = local_packs;
 
+	/* only one packfile */
+	if (!pl->next) {
+		llist_init(&pl->unique_objects);
+		return;
+	}
+
 	while ((subset = pl)) {
 		while ((subset = subset->next))
 			cmp_two_packs(pl, subset);
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 6b4d1ca353..45436bd6e1 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -39,6 +39,8 @@ relationship between packs and objects is as follows:
 master_repo=master.git
 shared_repo=shared.git
 
+git_pack_redundant='git pack-redundant'
+
 # Create commits in <repo> and assign each commit's oid to shell variables
 # given in the arguments (A, B, and C). E.g.:
 #
@@ -112,19 +114,28 @@ test_expect_success 'setup master repo' '
 	create_commits_in "$master_repo" A B C D E F G H I J K L M N O P Q R
 '
 
+test_expect_success 'master: pack-redundant works with no packfile' '
+	(
+		cd "$master_repo" &&
+		cat >expect <<-EOF &&
+			fatal: Zero packs found!
+			EOF
+		test_must_fail $git_pack_redundant --all >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
 #############################################################################
 # Chart of packs and objects for this test case
 #
 #         | T A B C D E F G H I J K L M N O P Q R
 #     ----+--------------------------------------
 #     P1  | x x x x x x x                       x
-#     P2  |     x x x x   x x x
-#     P3  |             x     x x x x x
 #     ----+--------------------------------------
-#     ALL | x x x x x x x x x x x x x x         x
+#     ALL | x x x x x x x                       x
 #
 #############################################################################
-test_expect_success 'master: no redundant for pack 1, 2, 3' '
+test_expect_success 'master: pack-redundant works with one packfile' '
 	create_pack_in "$master_repo" P1 <<-EOF &&
 		$T
 		$A
@@ -135,6 +146,26 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		$F
 		$R
 		EOF
+	(
+		cd "$master_repo" &&
+		$git_pack_redundant --all >out &&
+		test_must_be_empty out
+	)
+'
+
+#############################################################################
+# Chart of packs and objects for this test case
+#
+#         | T A B C D E F G H I J K L M N O P Q R
+#     ----+--------------------------------------
+#     P1  | x x x x x x x                       x
+#     P2  |     x x x x   x x x
+#     P3  |             x     x x x x x
+#     ----+--------------------------------------
+#     ALL | x x x x x x x x x x x x x x         x
+#
+#############################################################################
+test_expect_success 'master: no redundant for pack 1, 2, 3' '
 	create_pack_in "$master_repo" P2 <<-EOF &&
 		$B
 		$C
@@ -154,7 +185,7 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		EOF
 	(
 		cd "$master_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -192,7 +223,7 @@ test_expect_success 'master: one of pack-2/pack-3 is redundant' '
 		cat >expect <<-EOF &&
 			P3:$P3
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -231,7 +262,7 @@ test_expect_success 'master: pack 2, 4, and 6 are redundant' '
 			P4:$P4
 			P6:$P6
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -266,7 +297,7 @@ test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
 			P6:$P6
 			P8:$P8
 			EOF
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		format_packfiles <out >actual &&
 		test_cmp expect actual
 	)
@@ -284,9 +315,9 @@ test_expect_success 'master: clean loose objects' '
 test_expect_success 'master: remove redundant packs and pass fsck' '
 	(
 		cd "$master_repo" &&
-		git pack-redundant --all | xargs rm &&
+		$git_pack_redundant --all | xargs rm &&
 		git fsck &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -304,7 +335,7 @@ test_expect_success 'setup shared.git' '
 test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -343,7 +374,7 @@ test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
 			P5:$P5
 			P7:$P7
 			EOF
-		git pack-redundant --all --verbose >out 2>out.err &&
+		$git_pack_redundant --all --verbose >out 2>out.err &&
 		test_must_be_empty out &&
 		grep "pack$" out.err | format_packfiles >actual &&
 		test_cmp expect actual
@@ -356,9 +387,9 @@ test_expect_success 'shared: remove redundant packs, no packs left' '
 		cat >expect <<-EOF &&
 			fatal: Zero packs found!
 			EOF
-		git pack-redundant --all --alt-odb | xargs rm &&
+		$git_pack_redundant --all --alt-odb | xargs rm &&
 		git fsck &&
-		test_must_fail git pack-redundant --all --alt-odb >actual 2>&1 &&
+		test_must_fail $git_pack_redundant --all --alt-odb >actual 2>&1 &&
 		test_cmp expect actual
 	)
 '
@@ -386,7 +417,7 @@ test_expect_success 'shared: create new objects and packs' '
 test_expect_success 'shared: no redundant without --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all >out &&
+		$git_pack_redundant --all >out &&
 		test_must_be_empty out
 	)
 '
@@ -417,7 +448,7 @@ test_expect_success 'shared: no redundant without --alt-odb' '
 test_expect_success 'shared: one pack is redundant with --alt-odb' '
 	(
 		cd "$shared_repo" &&
-		git pack-redundant --all --alt-odb >out &&
+		$git_pack_redundant --all --alt-odb >out &&
 		format_packfiles <out >actual &&
 		test_line_count = 1 actual
 	)
@@ -454,7 +485,7 @@ test_expect_success 'shared: ignore unique objects and all two packs are redunda
 			Px1:$Px1
 			Px2:$Px2
 			EOF
-		git pack-redundant --all --alt-odb >out <<-EOF &&
+		$git_pack_redundant --all --alt-odb >out <<-EOF &&
 			$X
 			$Y
 			$Z
-- 
2.30.0.rc0


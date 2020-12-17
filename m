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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27EAC1B0D8
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6682823441
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgLQB5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQB5x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:57:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5F5C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:57:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v1so2729991pjr.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pF8ELB0TCGzPahipAT8GgRRl8ouggMttJD8MXntExdI=;
        b=j3ClxHwCSOc+UA6wUdZyK7V8ma7TRNam+fdi9gpX3dqkTpeZ5GaIrH85/+xLbQuZ5D
         N1/QSgd4cnMqQnATdz0hYgLXVsI1hf05ST1Tw6T2PwzgU+ZzarRAMBR6ECi8F7Y2DSK1
         3x81PRdb3D/yQbMALg5LHeiIc1r9Of5CfHTOR/hfwAFtgvTcahXzkVvudUWRiiARGgGa
         2KRxEeLPOfTkr5Hkil0p4uCrU4wBvm9m7+XfhVEW3gAt5C8N3zcuRvvNjfn6XlrIAkDT
         YtYgrrNadTzkyeVqygyq+0Uc7u/ihxM+EFREMadBaqbNcBZo9mZiSaNKrsNWBcVtfH0C
         bNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pF8ELB0TCGzPahipAT8GgRRl8ouggMttJD8MXntExdI=;
        b=c7JSXv9Hc+rbDL5Ykje4q31R6K9aywNEz1K0Mi14JdhR3L5tQ9ZSbydFC01sYDaY5m
         7FWaDJAo4Ppw/xxC9XRYyo50zhu1p1M01wsDKnGOJ8N7hMNyFLI6NXPDpr2brvv/Woc0
         tRdZBU57j8rWp+yj31hceWa/+CBNgEVHWcyNR0fpU+MU6rxkQLVkjD1UpF2DaW1ZtmQi
         H85dT3jkYtRo0GdyEyT1Y6VzVDIMo7KpT3j9UI33ifqVppDXcQVyILqvxCCBu4dKOCNR
         Ml+fo0AOawdlpIO3rho11Zz57pRiVHgALgqk2W8gVzYLej/+tJfSE5FyS1q3BlrDtb2m
         NqFw==
X-Gm-Message-State: AOAM530IgfcPan4rDhJ8M7oqwEyJy9ZEr3rs9ddtAlvFyRe18oWw9mBJ
        cX4i14UbqsoU8Vuv8U4g9raS0YaQouOjK9q8
X-Google-Smtp-Source: ABdhPJxPQQBptCSkh/C08BSj0ySGS3+hs6tYvgf/oVUIH0cYlbxzVowqyc0fVRH/LsxD7boRTn01/A==
X-Received: by 2002:a17:902:6803:b029:da:1469:8945 with SMTP id h3-20020a1709026803b02900da14698945mr33706427plk.15.1608170232222;
        Wed, 16 Dec 2020 17:57:12 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e21sm2685808pgv.74.2020.12.16.17.57.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 17:57:11 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "Daniel C . Klauer" <daniel.c.klauer@web.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2] pack-redundant: fix crash when one packfile in repo
Date:   Wed, 16 Dec 2020 20:57:09 -0500
Message-Id: <20201217015709.28827-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqo8it4pxt.fsf@gitster.c.googlers.com>
References: <xmqqo8it4pxt.fsf@gitster.c.googlers.com>
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

Also add testcases for repository with no packfile and one packfile
in t5323.

Reported-by: Daniel C. Klauer <daniel.c.klauer@web.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/pack-redundant.c  |  6 ++++++
 t/t5323-pack-redundant.sh | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

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
index 6b4d1ca353..7e3340843f 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -112,19 +112,28 @@ test_expect_success 'setup master repo' '
 	create_commits_in "$master_repo" A B C D E F G H I J K L M N O P Q R
 '
 
+test_expect_success 'master: pack-redundant works with no packfile' '
+	(
+		cd "$master_repo" &&
+		cat >expect <<-EOF &&
+			fatal: Zero packs found!
+			EOF
+		test_must_fail git pack-redundant --all >actual 2>&1 &&
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
@@ -135,6 +144,26 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
 		$F
 		$R
 		EOF
+	(
+		cd "$master_repo" &&
+		git pack-redundant --all >out &&
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
-- 
2.30.0.rc0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48A031F516
	for <e@80x24.org>; Mon,  2 Jul 2018 13:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeGBNbM (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 09:31:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39801 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeGBNbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 09:31:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so7648348oib.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OiCAIQ+PWUu5dupqnRSsHCiGp8OTgOL6F/ml/Z9SOi8=;
        b=nBUPt7g9yYNGV6vqoslthPvx0DOTQpOGiKwgo/shwO70Q+OxwDQgq+dm5hzGfj2oJB
         HhJUBKu5/5osDq3FgDrB8akmuXaTdMF0LccB+gj1O5zbI3Jl6eUorZ4XIWg1puHSLRsC
         FV17l0iFpXMXsS3HdCGun2z7gxe14du0nS1Xl3wdmBQgeg4HBKjqMoLR4BdySsvYQBx3
         wStkEOSLj1VyV39NYUF6hIq3Wq2OWk7yfD6vj3ygJEgdTi5Wd1JwU18kTvvih99lXC5t
         rOKypeAEEMTLW5L4D/hY6C+/WNybalXu90UlvcsQK3Lq85iYL4CmyzGOxM1eD98II2fn
         kYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OiCAIQ+PWUu5dupqnRSsHCiGp8OTgOL6F/ml/Z9SOi8=;
        b=qk3yHpcoMaLgB+8w6aP8WylUdn/VTGBSdc/COVJuSw/uOEwduZELXnou3Cz0ZyEfax
         hZ8LFrJXhuYAre+khfkbyfslPSV8+sniPStKZZRLU7MyuKFVxkm7Gnp8J8hsmuoIsCtH
         9lL1QWORWDXv1C4Z4As/2/3UC1jznz4iXY2COHMTkZ5h1QhSwl/VBlYWH7FGlPuX/+D8
         c89SCPSaBFVIugfZZzbMb4TrBC4kiESHUzbXf1e4peVskgY5uqA5YpGsGHRIBoHXP+0s
         B5Hbsa+g6n65UN3Dfqn5Eguy9JnEouMyMYPlyb/z0zYlwNXdFhRkc+BySopURoyig4CM
         8x2A==
X-Gm-Message-State: APt69E30SAjswMtYNkRWRSlH2+qxMek2i/pkOc2G35gnWaDtyEdHno0b
        j1/vHFRU4FJSxY92xxyahUilCQ==
X-Google-Smtp-Source: AAOMgpf5J9lNPxl9RSaVn/BSYn2+zuBs9dfvffsrs3IVCtgBoLp99ik1NIGBjz662/X712X8LXXyLg==
X-Received: by 2002:aca:b7c3:: with SMTP id h186-v6mr14550527oif.54.1530538269910;
        Mon, 02 Jul 2018 06:31:09 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id r16-v6sm12232366otd.43.2018.07.02.06.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:31:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] t6042: add testcase covering rename/rename(2to1)/delete/delete conflict
Date:   Mon,  2 Jul 2018 06:30:53 -0700
Message-Id: <20180702133054.18638-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180702133054.18638-1-newren@gmail.com>
References: <20180702133054.18638-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If either side of a rename/rename(2to1) conflict is itself also involved
in a rename/delete conflict, then the conflict is a little more complex;
we can even have what I'd call a rename/rename(2to1)/delete/delete
conflict.  (In some ways, this is similar to a rename/rename(1to2)/add/add
conflict, as added in commit 3672c9714830 ("merge-recursive: Fix working
copy handling for rename/rename/add/add", 2011-08-11)).  Add a testcase
for such a conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6042-merge-rename-corner-cases.sh | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 788a31451..46e1aa7df 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -759,4 +759,72 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 	)
 '
 
+# Testcase rrdd, rename/rename(2to1)/delete/delete
+#   Commit O: foo, bar
+#   Commit A: rename foo->baz, rm bar
+#   Commit B: rename bar->baz, rm foo
+#   Expected: CONFLICT (rename/rename/delete/delete), two-way merged baz
+
+test_expect_success 'rrdd-setup: rename/rename(2to1)/delete/delete conflict' '
+	test_create_repo rrdd &&
+	(
+		cd rrdd &&
+		echo foo >foo &&
+		echo bar >bar &&
+		git add foo bar &&
+		git commit -m O &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv foo baz &&
+		git rm bar &&
+		git commit -m "Rename foo, remove bar" &&
+
+		git checkout B &&
+		git mv bar baz &&
+		git rm foo &&
+		git commit -m "Rename bar, remove foo"
+	)
+'
+
+test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
+	(
+		cd rrdd &&
+
+		git checkout A^0 &&
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		# Not sure whether the output should contain just one
+		# "CONFLICT (rename/rename/delete/delete)" line, or if it
+		# should break it into three: "CONFLICT (rename/rename)" and
+		# two "CONFLICT (rename/delete)" lines; allow for either.
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (rename.*delete)" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >file_count &&
+		test_line_count = 2 file_count &&
+		git ls-files -u >file_count &&
+		test_line_count = 2 file_count &&
+		git ls-files -o >file_count &&
+		test_line_count = 2 file_count &&
+
+		git rev-parse >actual \
+			:2:baz :3:baz &&
+		git rev-parse >expect \
+			O:foo  O:bar  &&
+
+		test_cmp file_is_missing foo &&
+		test_cmp file_is_missing bar &&
+		# baz should have two-way merged contents of the original
+		# contents of foo and bar; check that content from both sides
+		# is present.
+		grep foo baz &&
+		grep bar baz
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d


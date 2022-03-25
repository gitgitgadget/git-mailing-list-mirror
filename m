Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A54DC433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiCYTkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiCYTiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3AE14F103
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4946161wmb.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AP9SNTM7WVjUHhCS+GQ65mp/TiD0F/WG4OyokL6Ru9s=;
        b=cQQKSnNLevmX55+mucgbiUjf/tVHfvRKgvLas/Cnwadv4E69+KnVMmR2y9Ptp75rvy
         w6GgHj7YgcvBAbwdmocBvuyMkfIIX0qyqn67MHZMCJ1OQgQym1CD2oHGozt2sFU4yiIL
         HbEB99yd1t3yWgjmR5XyxSrIswCgliqbVYWCQeDzNkXN3lhAsOMLYYuOJvof2LIJ7AVk
         TEs/+CG7jFsRZCfNZYIAyCkv108S56/Vb0kjAz795KyA4cRRFWFEhknAU5n9FBuQ7Bvs
         WJ++GJefqCplC2C7fxsoC4lXe8scKpxEu4SxzTNtRfaMMgCnMMBFf/swpAnUsFOdp6th
         I7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AP9SNTM7WVjUHhCS+GQ65mp/TiD0F/WG4OyokL6Ru9s=;
        b=niq2bIe/WBGzPqpAZbjzDKOCaaQzQqgwgLv2BwSj1tfpDfS3Hx21xqYT/7C5P3fno3
         2jyjzqjr+uSUQXF/ejGr3Fin8Lc9jsDwT4spToBt4n/kY08XU48Y0W1ZXWSYf2J6c4N/
         LjInAUMfZegRMDjpPMDMOWJ0mVmAp82D2pRrqXSg+C5Guw1jTm5FCvUx6/eBKlWrsEtz
         S09MLNk+MeZ668DS1gFy6XbqMndTX4jMfegmdFrSg9mHtlePAqcQAriRIm/LjgdAg8qb
         zMtLp4hn6T8iV4QlRl3mHrjc4uy+s8YZ536RvoWc94LewTzvRoTWZdOgB1ppN2B7mWhC
         6srA==
X-Gm-Message-State: AOAM5314I14dF7GKrvigkgzauc9WPzLKOghlJLNHGFPocUwE+mRl9/oc
        o3H+0kGZzc028BG4HXHsOBRyRCamLuIVHg==
X-Google-Smtp-Source: ABdhPJwFUNIfUgIIqs3xLsasg+POk/E8kuX0jFRpnei63Z0xKeP3lowY2Fdn/lX7vijZCHdSXcfBXA==
X-Received: by 2002:a05:600c:3b1e:b0:38c:da9f:9309 with SMTP id m30-20020a05600c3b1e00b0038cda9f9309mr7363049wms.9.1648228794085;
        Fri, 25 Mar 2022 10:19:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 24/27] revisions API: call diff_free(&revs->pruning) in revisions_release()
Date:   Fri, 25 Mar 2022 18:18:48 +0100
Message-Id: <patch-v3-24.27-006fa1fcc34-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call diff_free() on the "pruning" member of "struct rev_info".  Doing
so makes several tests pass under SANITIZE=leak.

This was also the last missing piece that allows us to remove the
UNLEAK() in "cmd_diff" and "cmd_diff_index", which allows us to use
those commands as a canary for general leaks in the revisions API. See
[1] for further rationale, and 886e1084d78 (builtin/: add UNLEAKs,
2017-10-01) for the commit that added the UNLEAK() there.

1. https://lore.kernel.org/git/220218.861r00ib86.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-index.c                | 1 -
 builtin/diff.c                      | 1 -
 revision.c                          | 1 +
 t/t1001-read-tree-m-2way.sh         | 1 +
 t/t1002-read-tree-m-u-2way.sh       | 1 +
 t/t2200-add-update.sh               | 1 +
 t/t4039-diff-assume-unchanged.sh    | 1 +
 t/t4206-log-follow-harder-copies.sh | 2 ++
 t/t6131-pathspec-icase.sh           | 2 ++
 9 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 3a83183c312..7d158af6b6d 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -70,7 +70,6 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		return -1;
 	}
 	result = run_diff_index(&rev, option);
-	UNLEAK(rev);
 	result = diff_result_code(&rev.diffopt, result);
 	release_revisions(&rev);
 	return result;
diff --git a/builtin/diff.c b/builtin/diff.c
index dd48336da56..f539132ac68 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -594,7 +594,6 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	result = diff_result_code(&rev.diffopt, result);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
-	UNLEAK(rev);
 	release_revisions(&rev);
 	UNLEAK(ent);
 	UNLEAK(blob);
diff --git a/revision.c b/revision.c
index 380e6d9fe43..9ac06e4d285 100644
--- a/revision.c
+++ b/revision.c
@@ -2960,6 +2960,7 @@ void release_revisions(struct rev_info *revs)
 	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
+	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 }
 
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 0710b1fb1e9..516a6112fdc 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -21,6 +21,7 @@ In the test, these paths are used:
 	yomin   - not in H or M
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 46cbd5514a6..bd5313caec9 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -9,6 +9,7 @@ This is identical to t1001, but uses -u to update the work tree as well.
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0c38f8e3569..be394f1131a 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -14,6 +14,7 @@ only the updates to dir/sub.
 Also tested are "git add -u" without limiting, and "git add -u"
 without contents changes, and other conditions'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 0eb0314a8b3..78090e6852d 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -2,6 +2,7 @@
 
 test_description='diff with assume-unchanged entries'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # external diff has been tested in t4020-diff-external.sh
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index 4871a5dc92f..33ecf82c7f9 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -6,6 +6,8 @@
 test_description='Test --follow should always find copies hard in git log.
 
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index 39fc3f6769b..770cce026cb 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test case insensitive pathspec limiting'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq CASE_INSENSITIVE_FS
-- 
2.35.1.1509.ge4eeb5bd39e


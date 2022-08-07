Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88651C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 04:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiHGEOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 00:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiHGEOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 00:14:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F77D10FC1
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 21:14:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f192so5519441pfa.9
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwQSIqSJQY91YX7HKnfyjKUWJ4xfGmIOD5cfPv6OaBU=;
        b=TK9h8Y5ZI+zTznl/mTDDgLCTcNpaE1fz28mkABzLyP0Tdzcf7lAyTK5eIrS/YKFLq8
         cTiDSTR9qrSpgknh6QlPzHr9CBMW+negkQNw+p9HcDD1urzwAj9vg6ryMR7OVZgZmnza
         ipeVw37eri494Ps93oyNHdCBe28CdGpK3D/1ggp2ijQ0c2tejxoyqNVK26k9dIfVmCa8
         1sKhJx3S7kSyf0bR/dtQR/kEhylfiGm/etzEmg8wyu8scOmqd1Yu1NXYps44HvqkqqvA
         QQKTd+EHof41R3tCPVOvRXphZl8rdnTcbk9W823L3VLpSgH9sYkhN8DQTNcelyLXDtmE
         3Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwQSIqSJQY91YX7HKnfyjKUWJ4xfGmIOD5cfPv6OaBU=;
        b=iBwgc/Y2+pBJX7VV2/aZb5Acg7A+v2H1C1PVc9e9ro1tMkjCkl5Fx72GPtKOE0AyQI
         X3E7oIKJlvEByFaRoFncACjVVcT44P3+9VubA2u2TYhQLPAl3gjtwCkyW7Bm3m5Ipq2T
         juAS4ej1Qp5cxUlFws5P5NxAG+M3CLr/wMHsJNiD7UZWS49uabUs9yvexDzOMmTib5mk
         czzVqCQWc7xkXq+v+gtcMoW66w7AQoXZmBdcrXktNFGRvB1TqQpk5aNGG3VMdiB3cfJW
         Z5nq5eDb5xchs2QfQtGU3MF9kCt7qxZQOXx9/1gwB0pJLC261DrKNMEsXG9xgWpsbPRf
         Uugg==
X-Gm-Message-State: ACgBeo1AzNpjgXG5B1MhUhcveTKRQtnicZrb53ELvOd4XYJN258kNhT9
        L61tbWOml6AsezttjKsP7aNOzznZa/Aihg==
X-Google-Smtp-Source: AA6agR66dyxuxiOgzSDKMLzhRbQ6zXEgspsAIcUL/c+DICvO4X+4wyTqbDgoOK9qpJnietMrlF91eQ==
X-Received: by 2002:a05:6a00:1d9e:b0:52d:aa13:67fc with SMTP id z30-20020a056a001d9e00b0052daa1367fcmr13374786pfw.73.1659845640789;
        Sat, 06 Aug 2022 21:14:00 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.209.111])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090a0e1600b001f333fab3d6sm8057027pje.18.2022.08.06.21.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:14:00 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 4/4] rm: integrate with sparse-index
Date:   Sun,  7 Aug 2022 12:13:35 +0800
Message-Id: <20220807041335.1790658-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
References: <20220803045118.1243087-1-shaoxuan.yuan02@gmail.com>
 <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable the sparse index within the `git-rm` command.

The `p2000` tests demonstrate a ~92% execution time reduction for
'git rm' using a sparse index.

Test                              HEAD~1            HEAD
--------------------------------------------------------------------------
2000.74: git rm ... (full-v3)     0.41(0.37+0.05)   0.43(0.36+0.07) +4.9%
2000.75: git rm ... (full-v4)     0.38(0.34+0.05)   0.39(0.35+0.05) +2.6%
2000.76: git rm ... (sparse-v3)   0.57(0.56+0.01)   0.05(0.05+0.00) -91.2%
2000.77: git rm ... (sparse-v4)   0.57(0.55+0.02)   0.03(0.03+0.00) -94.7%

----
Also, normalize a behavioral difference of `git-rm` under sparse-index.
See related discussion [1].

`git-rm` a sparse-directory entry within a sparse-index enabled repo
behaves differently from a sparse directory within a sparse-checkout
enabled repo.

For example, in a sparse-index repo, where 'folder1' is a
sparse-directory entry, `git rm -r --sparse folder1` provides this:

        rm 'folder1/'

Whereas in a sparse-checkout repo *without* sparse-index, doing so
provides this:

        rm 'folder1/0/0/0'
        rm 'folder1/0/1'
        rm 'folder1/a'

Because `git rm` a sparse-directory entry does not need to expand the
index, therefore we should accept the current behavior, which is faster
than "expand the sparse-directory entry to match the sparse-checkout
situation".

Modify a previous test so such difference is not considered as an error.

[1] https://github.com/ffyuanda/git/pull/6#discussion_r934861398

Helped-by: Victoria Dye <vdye@github.com>
Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/rm.c                             |  2 ++
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 20 +++++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 58ed924f0d..b6ba859fe4 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -287,6 +287,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only)
 		setup_work_tree();
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	if (read_cache() < 0)
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index c181110a43..fce8151d41 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -123,5 +123,6 @@ test_perf_on_all git blame $SPARSE_CONE/f3/a
 test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
+test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 94464cf911..68ded9063b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -912,7 +912,7 @@ test_expect_success 'read-tree --prefix' '
 	test_all_match git read-tree --prefix=deep/deeper1/deepest -u deepest &&
 	test_all_match git status --porcelain=v2 &&
 
-	test_all_match git rm -rf --sparse folder1/ &&
+	run_on_all git rm -rf --sparse folder1/ &&
 	test_all_match git read-tree --prefix=folder1/ -u update-folder1 &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -1874,7 +1874,7 @@ test_expect_success 'rm pathspec inside sparse definition' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_failure 'rm pathspec outside sparse definition' '
+test_expect_success 'rm pathspec outside sparse definition' '
 	init_repos &&
 
 	for file in folder1/a folder1/0/1
@@ -1914,7 +1914,7 @@ test_expect_failure 'rm pathspec outside sparse definition' '
 	test_sparse_match git status --porcelain=v2
 '
 
-test_expect_failure 'rm pathspec expands index when necessary' '
+test_expect_success 'rm pathspec expands index when necessary' '
 	init_repos &&
 
 	# in-cone pathspec (do not expand)
@@ -1933,4 +1933,18 @@ test_expect_failure 'rm pathspec expands index when necessary' '
 	test_must_be_empty sparse-index-err
 '
 
+test_expect_success 'sparse index is not expanded: rm' '
+	init_repos &&
+
+	ensure_not_expanded rm deep/a &&
+
+	# test in-cone wildcard
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded rm deep/* &&
+
+	# test recursive rm
+	git -C sparse-index reset --hard &&
+	ensure_not_expanded rm -r deep
+'
+
 test_done
-- 
2.37.0


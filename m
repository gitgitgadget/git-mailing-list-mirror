Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC8FC433FE
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbiDBKws (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354573AbiDBKwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:52:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916B140749
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a17so5659402edm.9
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnHM35yB8X/bMfdbrxf8ttWv/VeaHGM1cz+6+ojs2rE=;
        b=ByrSEQOkHsYh7reqIH6n+4FMr6Sa0ow4ebL3DH3/e8xhN7Ip7E6huK83OHOCozveDM
         FDbFfW8U7ViNZdbk84OUALcj1EZl6OyMaj9MVVaRd6eEmqhlh1Ome8Q5xqNqg3e0OZt9
         N+ldJ3kMKUOBHF9chqL/IiuSjf4dWxXjJs4Upn4q+yxJjqeGGj0Sbih7SU0Yaz9zBWc8
         Kp39VY7bQzo1HmSAxmPu2efnWmp4TKYnmy/a+2aL/ihG0RBHfzmaigkrwYdXGlmGSdXF
         eyvn73WF1A3nRH04AuyyPIyHt4siAJL1a8Ha3x7XBog1gZ4adBjGZOOweq+DgfiWQOlX
         TpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnHM35yB8X/bMfdbrxf8ttWv/VeaHGM1cz+6+ojs2rE=;
        b=N5Kn97aB6H1msEfsbhrbB1kVj9DILttWZD81f2jrtLaYnU5nFRQ+zoai/LrZ6FKpxH
         FUVzaRE58Rd7XsBB/K2/WeNfpYz7jtUbRbyj+dWdXeqY2v8nWdjg8mid2HuSuPPyrUkP
         ymGPM8jX/1lDeBNsuUjkxoiy0VA4eU/AVqPNpbYYTFlBT2397EL/7MbQ4TaJ9HpNnJgB
         JWcxicpP9qyFSVVvgV0YPB0ZKZClvsFY71gwqnjwEyGWruXJtZ7jojKQzvjoqwCzHO/+
         A7gOoG3q/yAcXds3wPMMxglLMtoesI3ED1YcSBooelPSDcF9QdekegAQZrNN2EU5BGYz
         g3HA==
X-Gm-Message-State: AOAM530yHnO7a4NwgFPpuQwS1uFnrtGueJc3kYmEHLzGInux1W3IworS
        dbuiheSqHGhW91gC2OR7C+BTFHK0iDhZ4w==
X-Google-Smtp-Source: ABdhPJz/dWem7wxpAKmx9EeKpl6ws8tTE4v8xMbWB6hHvQayykcVktjCA+Mux6MLurfS0x7Yk+6BZA==
X-Received: by 2002:a50:ec18:0:b0:419:3af:5736 with SMTP id g24-20020a50ec18000000b0041903af5736mr24806916edr.215.1648896608304;
        Sat, 02 Apr 2022 03:50:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:50:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 24/27] revisions API: call diff_free(&revs->pruning) in revisions_release()
Date:   Sat,  2 Apr 2022 12:49:38 +0200
Message-Id: <patch-v5-24.27-c7f3e92a8d1-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
index e972addd8fc..8bc777da828 100644
--- a/revision.c
+++ b/revision.c
@@ -2955,6 +2955,7 @@ void release_revisions(struct rev_info *revs)
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
2.35.1.1585.gd85f8dcb745


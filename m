Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A8C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiCINTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiCINT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2AD1795F7
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:18:05 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 19so1345385wmy.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBB4FmwGFyw3PD995/YaYVF2NUNg1FlTppFzSnKnrJY=;
        b=RJlZqYB8m0b2nBSv/rGjcmpme5hEgTaIeD4wi/3wOiZ1Z3uD+KGuPcayHKs7uADbEn
         wD8hTk8Rg//V90Rog48iKw3cLRo3eI8S0QO8sCbZYu0iTT+dxKCOkMMPzCxDA/7zhYX/
         +K/O9+5bh12p4LupfNx8Uv8Mhsdofj4M1YfZQUt3mH8+xXg41qZcZLqmAQz3X2xfPc0K
         yNvqL99Batywx0ZKaWs4Wq/nx7gamPFMVEU7B4RtvutWPw7G9Z6YtChcWupDjJMcHj1T
         uLdd0EDslTqWq4WPBEyLNcGjykOp069mxD+jQ9JHHJFai1yj23s1SaQMEDxX5ZDCVuOZ
         c/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBB4FmwGFyw3PD995/YaYVF2NUNg1FlTppFzSnKnrJY=;
        b=HL3/AZxIm6sE+AL9YFEzkNkxK4UGaG4wpu69WEYZuE+ROhqCVRnQhDA6vT/68azXyP
         KI20lyyMrnYShbuccInB4WdjRWLqLdwUfpylIboQ5OUPobMSB/cpxHL2r68eUeAY0Zqp
         IElxR/2G3ScTW31AFn+P6vD5Q2qHum64RSM8VYiowzbOpC1osgBpFIagAHSwJjpZf8wC
         vp2dXWU2TkMioEEjI7kNoORv1CUTWqlx4+vl1H9I+VZKD/rbKBOx8+hZcDXEYc0yM6jg
         O+xg6aOwWINYwl6sGSUwtv6aSXPPHBvqcUMcV4cnO7fTz70URbHvYg/OIniIe39SJQyL
         6lkA==
X-Gm-Message-State: AOAM531Q0rcPgS/cMtjkEovbYQBnba0jCGWdqi7Qi4RlQRSx+E3GXjZi
        2ut6wNlVFzuESzd8uGMgX4bKDqEtMxiI7Q==
X-Google-Smtp-Source: ABdhPJwvmGhXHJltMKyU14i/CF8TDgBv5JoaP6ibm2hDfcJzuzHn1OBevXfxI9TOuGa65qDOC5osJQ==
X-Received: by 2002:a1c:4e15:0:b0:387:3661:e857 with SMTP id g21-20020a1c4e15000000b003873661e857mr7517800wmh.94.1646831883344;
        Wed, 09 Mar 2022 05:18:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:18:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 22/24] revisions API: call diff_free(&revs->pruning) in revisions_release()
Date:   Wed,  9 Mar 2022 14:16:52 +0100
Message-Id: <patch-22.24-f387b9e744a-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call diff_free() on the "pruning" member of "struct rev_info". We'll
handle the "diffopt" member of the same type some other time, doing so
will require us to untangle the "no_free" conditions I added in
e900d494dcf (diff: add an API for deferred freeing, 2021-02-11).

Even without "diffopt" addressing leaks in "pruning" makes several
tests pass under SANITIZE=leak.

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
 revision.c                          | 2 ++
 t/t2016-checkout-patch.sh           | 1 +
 t/t4039-diff-assume-unchanged.sh    | 1 +
 t/t4206-log-follow-harder-copies.sh | 2 ++
 t/t6131-pathspec-icase.sh           | 2 ++
 7 files changed, 8 insertions(+), 2 deletions(-)

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
index ec6cd662467..81f4a36fc9d 100644
--- a/revision.c
+++ b/revision.c
@@ -2956,6 +2956,8 @@ void release_revisions(struct rev_info *revs)
 	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
+	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
+	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 }
 
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index abfd586c32b..83c246ab0a5 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -2,6 +2,7 @@
 
 test_description='git checkout --patch'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success PERL 'setup' '
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
2.35.1.1295.g6b025d3e231


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344018AbiBBLwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbiBBLwE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:52:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5CEC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:52:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v13so37774332wrv.10
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Vhtoo+vg2nwep/QYQOFY6uQorSQFtW2nD+wMGTfPkgU=;
        b=YfAgv+ogFRwGKCFCZYmsYrJrUdeJVmoIvZs5QJSeZUCK7AdaJvMy+5dLFhPsGulnlv
         8kAvop+tW2pCZK0GrFWGYjyC45EsvmXVW4GfFhU9+/spERHrsec1QbBSThgoXnd24osj
         4V0Nnl4sluzV4Hv91I79yFByQ/0VFBtvzGMHNFfQHJvnZnkP7c1koL1sh8pchrc7bWEy
         /l6hezu8PWQVhPYT9xMhBaPoQRusCIFXnEukz145dLhXrKwe9cbauDUPCHwQCxhccLRI
         J2Pw6eqGCBhjuH+oFnK8l+HlLTZeLyngmdzc7u0uH4hAmwGudsIqsaThsULQYkRdF+Hm
         XcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vhtoo+vg2nwep/QYQOFY6uQorSQFtW2nD+wMGTfPkgU=;
        b=W+StxaqPpmNBpzO65W5C5n9uSQd4/zVlD0ICUFNc3bSkVzGd3bdnP9kfTozug7g+Vp
         GJTuRz8XdkW/G4ZWmUYObxbkn+49lObj9ZK/9+PWNiJbBAuXiab9swQeot3vP2lV21i1
         6qaI0i265oqlNR9NsM4BXO8kUYztePvQpimzQgEaxbmduPxmo0NWdNrT46SLwn+Iz3yl
         eBLg5rT9HMiihhVmgLYslH+vUQ9tzkMr/gG3+FMlmBaUSpEpZ8yNZ6lJ01nR2KCBI2gR
         w0QPqyt9SD7JMEX7Q7RyV5oTXV82rs9yaoNvSxGbzSqkMUAMSirrIvELUHcTC4Y6/mBt
         5NWQ==
X-Gm-Message-State: AOAM530ker/kTtNkK7x/IuBbf/zXJ3rG0/JVBlp9sJiynlBWG4bqMUi4
        upL7vPlaynK3JDqKKy5Z1vARXQbZUIQ=
X-Google-Smtp-Source: ABdhPJxfyHbzOk7bR56N1SsUI8G98Hf/C0T7wwj4IIPduGZ+DIouCt0elsaUv/QJn6svA1QzvB2P/w==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr25785998wru.58.1643802722779;
        Wed, 02 Feb 2022 03:52:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22sm4972163wmc.27.2022.02.02.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:52:02 -0800 (PST)
Message-Id: <pull.1137.git.1643802721612.gitgitgadget@gmail.com>
From:   "Viaceslavus via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Feb 2022 11:52:01 +0000
Subject: [PATCH] forbid a hard reset before the initial commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Viaceslavus <vaceslavkozin619@gmail.com>,
        Viacelaus <vaceslavkozin619@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Viacelaus <vaceslavkozin619@gmail.com>

Performing 'git reset --hard' on empty repo with staged files
may have the only one possible result - deleting all staged files.
Such behaviour may be unexpected or even dangerous. With this
commit, when running 'git reset --hard', git will check for the
existence of commits in the repo; in case of absence of such, and
also if there are any files staged, git will die with an error.

Signed-off-by: Viacelaus <vaceslavkozin619@gmail.com>
---
    Forbid a hard reset on empty repo with staged files.
    
    Performing git reset --hard on empty repo (initialized repository
    without any commits) with staged files may have the only one possible
    result - deleting all staged files. Such behaviour may be unexpected or
    even dangerous, as it is possible to permanently delete the whole
    project. It is also absolutely useless. So with this patch, when running
    git reset --hard, git will check for the existence of commits in the
    repository; in case of absence of such, and also if there are files
    staged, git will return an error. All the tests were added into
    t/t7104-reset-hard.sh file.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1137%2FViaceslavus%2Fhard-reset-safety-on-empty-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1137/Viaceslavus/hard-reset-safety-on-empty-repo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1137

 builtin/reset.c                | 14 ++++++++++++++
 t/t7104-reset-hard.sh          | 18 ++++++++++++++++++
 t/t7106-reset-unborn-branch.sh | 11 -----------
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index b97745ee94e..5a0e80d380f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -301,6 +301,11 @@ static void die_if_unmerged_cache(int reset_type)
 
 }
 
+static int check_commit_exists(const char *refname, const struct object_id *oid, int f, void *d)
+{
+	return is_branch(refname);
+}
+
 static void parse_args(struct pathspec *pathspec,
 		       const char **argv, const char *prefix,
 		       int patch_mode,
@@ -474,6 +479,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			die(_("Cannot do %s reset with paths."),
 					_(reset_type_names[reset_type]));
 	}
+
+	if (reset_type == HARD) {
+		int commits_exist = for_each_fullref_in("refs/heads", check_commit_exists, NULL);
+		if(!commits_exist) {
+			if(read_cache() == 1)
+				die(_("Hard reset isn`t allowed before the first commit."));
+		}
+	}
+
 	if (reset_type == NONE)
 		reset_type = MIXED; /* by default */
 
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index cf9697eba9a..30fb71e6fb9 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -44,4 +44,22 @@ test_expect_success 'reset --hard did not corrupt index or cache-tree' '
 
 '
 
+test_expect_success 'reset --hard on empty repo without staged changes works fine' '
+	git reset --hard
+'
+
+test_expect_success 'reset --hard on empty repo with staged changes results in an error' '
+	touch n &&
+	git add n &&
+	test_must_fail git reet --hard
+'
+
+test_expect_success 'reset --hard after a commit works fine' '
+	touch new &&
+	git add new &&
+	git commit -m "initial" &&
+	git reset --hard 2> error &&
+	test_must_be_empty error
+'
+
 test_done
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index ecb85c3b823..8d45f640480 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -53,15 +53,4 @@ test_expect_success 'reset --soft is a no-op' '
 	test_cmp expect actual
 '
 
-test_expect_success 'reset --hard' '
-	rm .git/index &&
-	git add a &&
-	test_when_finished "echo a >a" &&
-	git reset --hard &&
-
-	git ls-files >actual &&
-	test_must_be_empty actual &&
-	test_path_is_missing a
-'
-
 test_done

base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
-- 
gitgitgadget

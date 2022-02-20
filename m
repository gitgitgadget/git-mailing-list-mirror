Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705DAC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 05:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiBTFGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 00:06:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBTFGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 00:06:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F433517DE
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 21:05:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so21355319wra.0
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 21:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=b7Dd8nap5pgOWdhuTy9VGMEXPvaxwW6mjyVoeC8FZo4=;
        b=dXjtBRUEsuWu4Yfzmk15dIJlZ7hJ13uxrwUzAFNIRpPAHGuhduiEeZM5Cj3pus5un2
         JrC2KpSa0IjUZtkzTgtz9zimfFaZRsAxTwYuEFeb3V6j/GbryhP1SZpwpvhyLRiYJBab
         qN8OOIAbpIhU2YpTS0k0IQEAfcW2MzcZWTECFueFTQIIvWzEb2Mn6lKjAaBJfbD2zSj6
         DviReYwRTphl4bdGaPLYmbpSSoJpx7rxHYgkKjZJEFPzUMa9LfM2IhDAijlayzdGMiNR
         DTNXOZt10eu0bX9fC29JO+t40ID8p9bv9kaLSVyqNOjU7gs5Sral0BAsWH/73VM7ubQ+
         6hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b7Dd8nap5pgOWdhuTy9VGMEXPvaxwW6mjyVoeC8FZo4=;
        b=GCg7Q+aX0EYVg50jhEjODFd2r7uffwk9kKE55wyoDHIc7tcn8ep2Sh31x9YGolyCP7
         VHhZhovMDeQE7eFyfpGjT0MsS0WdJCxfbmOMeLb3O/Cn90dNWXnEb8qcIwZMT8GqbzkK
         5xWbINpxqKe1TL85oJNZa1nuoetbZ52iXOxM1IvHuZlwxlcV5DLRsEiW4qCz3eU/yipu
         TEgbOQHlcSk6EvsDWpevgC90ovoJZZb5O5Pso8+K0PWQs23woLzivi5AI9I0ebB1YFa0
         hlTlaTE75+Ta/d9dRUtrbbQRnbjDDJq2b40T0lyg31I5P8kvkbVwvFTSH04c1ATQERxO
         EtyQ==
X-Gm-Message-State: AOAM533TmxGXrIb4P/thdOwkG8yXvE0GE+yNq92Lhe85CRQbKX3992ME
        SsQcJwOrR9qnrmzQxZF9SsdNDYXEhRY=
X-Google-Smtp-Source: ABdhPJxJBnKCaQyxcN/OXAR9d9DNyjQdmJUjHtycmA/hxifPM4ROlgDZkuVourBM4ZGzGJHJVq3l7Q==
X-Received: by 2002:a5d:6d4c:0:b0:1e6:335f:6b65 with SMTP id k12-20020a5d6d4c000000b001e6335f6b65mr11828588wri.371.1645333543712;
        Sat, 19 Feb 2022 21:05:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg23sm4858656wmb.5.2022.02.19.21.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:05:43 -0800 (PST)
Message-Id: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 05:05:41 +0000
Subject: [PATCH] Provide config option to expect files outside sparse patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Typically with sparse checkouts, we expect files outside the sparsity
patterns to be marked as SKIP_WORKTREE and be missing from the working
tree.  VFS for Git can be used to turn this expectation on its head:
all files are considered present in the working copy, though they are
not vivified until first access access.  With VFS for Git, most of the
files do not match the sparsity patterns at first, and the VFS layer
automatically updates the sparsity patterns to add more files whenever
files are written.

With this background, this special usecase does not play well with the
safety check we added in commit 11d46a399d ("repo_read_index: clear
SKIP_WORKTREE bit from files present in worktree", 2022-01-06).
Checking SKIP_WORKTREE files to see if they are present in the working
tree causes them all to be immediately vivified.  Further, the special
VFS layer, by virtue of automatically updating the sparsity patterns and
catching all accesses, isn't in need of that safety check either.
Provide a configuration option, core.expectFilesOutsideSparsePatterns
so that those with this special usecase can turn off the safety check.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    Provide config option to expect files outside sparse patterns
    
    Builds on en/present-despite-skipped, and addresses issue reported at
    https://lore.kernel.org/git/YhBCsg2DCEd9FXjE@google.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1153%2Fnewren%2Fpresent-despite-skip-worktree-toggle-for-vfs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1153/newren/present-despite-skip-worktree-toggle-for-vfs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1153

 cache.h                          |  1 +
 config.c                         |  5 +++++
 environment.c                    |  1 +
 sparse-index.c                   |  3 ++-
 t/t1090-sparse-checkout-scope.sh | 19 +++++++++++++++++++
 5 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 281f00ab1b1..1f35d8a59ea 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,7 @@ extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
+extern int core_expect_files_outside_sparse_patterns;
 
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
diff --git a/config.c b/config.c
index 2bffa8d4a01..68e877a1d80 100644
--- a/config.c
+++ b/config.c
@@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
+		core_expect_files_outside_sparse_patterns = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.precomposeunicode")) {
 		precomposed_unicode = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index fd0501e77a5..c86ebe9ce74 100644
--- a/environment.c
+++ b/environment.c
@@ -70,6 +70,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
+int core_expect_files_outside_sparse_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/sparse-index.c b/sparse-index.c
index eed170cd8f7..8e2a3973856 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -396,7 +396,8 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 
 	int i;
 
-	if (!core_apply_sparse_checkout)
+	if (!core_apply_sparse_checkout ||
+	    core_expect_files_outside_sparse_patterns)
 		return;
 
 restart:
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 3deb4901874..feef883523b 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -84,4 +84,23 @@ test_expect_success 'in partial clone, sparse checkout only fetches needed blobs
 	test_cmp expect actual
 '
 
+test_expect_success 'skip-worktree on files outside sparse patterns' '
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone "a*" &&
+	git checkout-index --all --ignore-skip-worktree-bits &&
+
+	git ls-files -t >output &&
+	! grep ^S output >actual &&
+	test_must_be_empty actual &&
+
+	test_config core.expectFilesOutsideSparsePatterns true &&
+	cat <<-\EOF >expect &&
+	S b
+	S c
+	EOF
+	git ls-files -t >output &&
+	grep ^S output >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: d79d29935262f8422a6e620bd33cc2fce28e669d
-- 
gitgitgadget

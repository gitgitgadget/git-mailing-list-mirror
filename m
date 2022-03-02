Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83049C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 04:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiCBEeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiCBEd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 23:33:57 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801014B43B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 20:33:14 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso130756oou.5
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 20:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djjlVoQ0mbBPNn9+CHVOzQYpwZUBXwVHXSZnrG6GecI=;
        b=Dql+Y9qzg4uCWGd6LNv2tP1bYI2Q/3hYVJEOU7TpcM80bIft1+ZKrW1rFDf4Dvnk6m
         6LX7J3m4fwA2ki7nSnRHHQoQ7K20a7BGvCBRaQMIOz/exfEdU7xRhI76Xqp+Ye6r2JsY
         ub9YhqtI+mpSJLBWsIkQiTCiYcpgppjvmNUoTWGBgM8iUBkCoBVotdYe1veyqdtk2mKn
         jVnsnQog6jyClKB0b26438ATtAMtT/Y8Pa7dS7/lPSIO1ObUOWcPiY6ehF3xEPqsAy9X
         wpLnMCCw52sFbkzrHLCok9RXi0prWjcHVY/a3uva1d3TJDYmLuR5DqqKzrPgQrfVUHV4
         U9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djjlVoQ0mbBPNn9+CHVOzQYpwZUBXwVHXSZnrG6GecI=;
        b=fgjDjUH1YpIAUZCwLSeKQMUF0ngiOf7tXaqVNP6ZoY803h6fnmVbwdhWQ7WEv7eB2q
         hxY/VoiUQE6uYf/0fXXToy/Bo28Sx83RE1BXMlvQz5n0T9SSJzFPznloGzMa2iTuqOia
         QVOf2Gy1ZQ+2F566XlybqBF17q75OEjVwgdU+jTsRUCPbYWLORPG+AHdxgN8vEH6TtZB
         Mp8srjfRahSvsUXN7b2b6xoHJiSKZ8t025OGlRNtDl2gmCyyDKSuaembNuZ36bIKjUDh
         hQqd75oApAaf+cOpjBmMMmVdlWt9k8sFFi8XlNXMe0T6/khgQ9GyR5OHf4eFLL/EtGlm
         EYwA==
X-Gm-Message-State: AOAM532Nj1SlOzCIdFrMuK/WinHLPK8hnVSUncYZHa1eh/Fn5giyCOfr
        9hpJlO8+YppW6EWMICuO9woEYM3RYfUx1A==
X-Google-Smtp-Source: ABdhPJyLcP90/OUc8/l8IleixBlgLECQcClL+pmXsYPmYdXUYKollLUoyhZKD8bxFgDYJtAbMY6dGQ==
X-Received: by 2002:a05:6870:8316:b0:d3:a001:96cf with SMTP id p22-20020a056870831600b000d3a00196cfmr13611882oae.85.1646195593287;
        Tue, 01 Mar 2022 20:33:13 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::3b])
        by smtp.gmail.com with ESMTPSA id he19-20020a056870799300b000d75f1d9b8dsm1067559oab.58.2022.03.01.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 20:33:12 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5] repo_read_index: add config to expect files outside sparse patterns
Date:   Tue,  1 Mar 2022 20:33:01 -0800
Message-Id: <20220302043301.1620188-1-newren@gmail.com>
X-Mailer: git-send-email 2.35.1.355.g49d31b1b5a.dirty
In-Reply-To: <20220226061222.797107-1-newren@gmail.com>
References: <20220226061222.797107-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typically with sparse checkouts, we expect files outside the sparsity
patterns to be marked as SKIP_WORKTREE and be missing from the working
tree.  Sometimes this expectation would be violated however; including
in cases such as:
  * users grabbing files from elsewhere and writing them to the worktree
    (perhaps by editing a cached copy in an editor, copying/renaming, or
     even untarring)
  * various git commands having incomplete or no support for the
    SKIP_WORKTREE bit[1,2]
  * users attempting to "abort" a sparse-checkout operation with a
    not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
    working tree is not atomic)[3].
When the SKIP_WORKTREE bit in the index did not reflect the presence of
the file in the working tree, it traditionally caused confusion and was
difficult to detect and recover from.  So, in a sparse checkout, since
af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files present
in worktree", 2022-01-06), Git automatically clears the SKIP_WORKTREE
bit at index read time for entries corresponding to files that are
present in the working tree.

There is another workflow, however, where it is expected that paths
outside the sparsity patterns appear to exist in the working tree and
that they do not lose the SKIP_WORKTREE bit, at least until they get
modified.  A Git-aware virtual file system[4] takes advantage of its
position as a file system driver to expose all files in the working
tree, fetch them on demand using partial clone on access, and tell Git
to pay attention to them on demand by updating the sparse checkout
pattern on writes.  This means that commands like "git status" only have
to examine files that have potentially been modified, whereas commands
like "ls" are able to show the entire codebase without requiring manual
updates to the sparse checkout pattern.

Thus since af6a51875a, Git with such Git-aware virtual file systems
unsets the SKIP_WORKTREE bit for all files and commands like "git
status" have to fetch and examine them all.

Introduce a configuration setting sparse.expectFilesOutsideOfPatterns to
allow limiting the tracked set of files to a small set once again.  A
Git-aware virtual file system or other application that wants to
maintain files outside of the sparse checkout can set this in a
repository to instruct Git not to check for the presence of
SKIP_WORKTREE files.  The setting defaults to false, so most users of
sparse checkout will still get the benefit of an automatically updating
index to recover from the variety of difficult issues detailed in
af6a51875a for paths with SKIP_WORKTREE set despite the path being
present.

[1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
[2] The three long paragraphs in the middle of
    https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
[3] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
[4] such as the vfsd described in
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v4:
  - Corrected an incorrect footnote

Range-diff:
1:  5ded1532cd ! 1:  d348cc766f repo_read_index: add config to expect files outside sparse patterns
    @@ Commit message
         [2] The three long paragraphs in the middle of
             https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
         [3] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
    -    [1] such as the vfsd described in
    +    [4] such as the vfsd described in
         https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
     
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

 Documentation/config.txt         |  2 ++
 Documentation/config/sparse.txt  | 27 +++++++++++++++++++++++++++
 cache.h                          |  1 +
 config.c                         | 14 ++++++++++++++
 environment.c                    |  1 +
 sparse-index.c                   |  3 ++-
 t/t1090-sparse-checkout-scope.sh | 19 +++++++++++++++++++
 7 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sparse.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b168f02dc3..8628ae2634 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -468,6 +468,8 @@ include::config/sequencer.txt[]
 
 include::config/showbranch.txt[]
 
+include::config/sparse.txt[]
+
 include::config/splitindex.txt[]
 
 include::config/ssh.txt[]
diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
new file mode 100644
index 0000000000..aff49a8d3a
--- /dev/null
+++ b/Documentation/config/sparse.txt
@@ -0,0 +1,27 @@
+sparse.expectFilesOutsideOfPatterns::
+	Typically with sparse checkouts, files not matching any
+	sparsity patterns are marked with a SKIP_WORKTREE bit in the
+	index and are missing from the working tree.  Accordingly, Git
+	will ordinarily check whether files with the SKIP_WORKTREE bit
+	are in fact present in the working tree contrary to
+	expectations.  If Git finds any, it marks those paths as
+	present by clearing the relevant SKIP_WORKTREE bits.  This
+	option can be used to tell Git that such
+	present-despite-skipped files are expected and to stop
+	checking for them.
++
+The default is `false`, which allows Git to automatically recover
+from the list of files in the index and working tree falling out of
+sync.
++
+Set this to `true` if you are in a setup where some external factor
+relieves Git of the responsibility for maintaining the consistency
+between the presence of working tree files and sparsity patterns.  For
+example, if you have a Git-aware virtual file system that has a robust
+mechanism for keeping the working tree and the sparsity patterns up to
+date based on access patterns.
++
+Regardless of this setting, Git does not check for
+present-despite-skipped files unless sparse checkout is enabled, so
+this config option has no effect unless `core.sparseCheckout` is
+`true`.
diff --git a/cache.h b/cache.h
index 281f00ab1b..b6b8e83ae3 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,7 @@ extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
+extern int sparse_expect_files_outside_of_patterns;
 
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
diff --git a/config.c b/config.c
index 2bffa8d4a0..9b9ad1500a 100644
--- a/config.c
+++ b/config.c
@@ -1544,6 +1544,17 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	return platform_core_config(var, value, cb);
 }
 
+static int git_default_sparse_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
+		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config/sparse.txt. */
+	return 0;
+}
+
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding"))
@@ -1675,6 +1686,9 @@ int git_default_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (starts_with(var, "sparse."))
+		return git_default_sparse_config(var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index fd0501e77a..fb55bf6129 100644
--- a/environment.c
+++ b/environment.c
@@ -70,6 +70,7 @@ char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
+int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/sparse-index.c b/sparse-index.c
index eed170cd8f..daeb5112a1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -396,7 +396,8 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 
 	int i;
 
-	if (!core_apply_sparse_checkout)
+	if (!core_apply_sparse_checkout ||
+	    sparse_expect_files_outside_of_patterns)
 		return;
 
 restart:
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 3deb490187..d1833c0f31 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -52,6 +52,25 @@ test_expect_success 'return to full checkout of main' '
 	test "$(cat b)" = "modified"
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
+	test_config sparse.expectFilesOutsideOfPatterns true &&
+	cat <<-\EOF >expect &&
+	S b
+	S c
+	EOF
+	git ls-files -t >output &&
+	grep ^S output >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
 	test_create_repo server &&
 	git clone "file://$(pwd)/server" client &&
-- 
2.35.1.355.g49d31b1b5a.dirty


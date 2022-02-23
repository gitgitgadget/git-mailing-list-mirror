Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7208C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 02:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiBWC1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 21:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiBWC1E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 21:27:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED592E4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 18:26:35 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id bd1so1421801plb.13
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 18:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RPAsZeGI+ihoITpUfRfYZZyDNFtcNoPARbGQWCAX5PM=;
        b=XsNW+srEdIdKlbXRfOCHYOnDj7COmQNjOKot+7jirThgc5snGIoQhZKbJkI8XXCLxg
         bU+raEW57MB2aqEz4jf6pIn7i+1/D/ofdpptoD7y0J8c+GaZ1zM7kU1Ct6aNT1+ho/Hz
         hLBSQU0LZPN/7njkwzmAC36XXQZ5mTyR8a/pkz33m/GonSxDTGfIoaEM3FnubI8hrGF2
         j8CwYG+1+X1NVl7DsYbwUqDsu7GtBB2KhtxvZRyzwT8iy9wn1Xp3VK1ew/U0VKXY8u5b
         tBu2xsApYqRxxL+2ddpF7FmqN6VvXUYhX+83pMSdc8yPcqhGcD8Kj4oAmf+VzWYG3nab
         P/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RPAsZeGI+ihoITpUfRfYZZyDNFtcNoPARbGQWCAX5PM=;
        b=d+cQKIm2llirYQQKVO6UysN/6yLW5YIcKZmJC/GlrtItuA1yau3e6XlhJxkZg7a1j1
         14M6Ybod+KrbnyMcCzO37yU0E4igYixEHmHgW65eliR5jeObcrKMP5TXF8aAhssh5g2E
         m+NZdDz7FmJx4K0/oVdEdVz9X1Qu32JXXmvJXByzzwFoWTu8aus7rP3J/t57VY3lDDG9
         3z+uEFntWOXSji6KyNYbTuK4CxbuyaLz33Flkx25vDh2UEr20FxFccmwmy0om0Ud7+Zt
         32uLqJCmPISOMH2znG0FeRcT+QXptwNrZh4cv10lVNCA8jqOgd1A+bIKP2lgllKTZJkW
         BWLA==
X-Gm-Message-State: AOAM5315FDJMBSJl3CbUaBShpl9q2s0CAt9kIHYIpqvCS3a2qHqbG0It
        9ZBxrwTu5wE3Y6+d9V/hdWIyp+RUtPo=
X-Google-Smtp-Source: ABdhPJwMUSDMvCMc6hVpm10gfpoPjc65OFWJdMVOxMFsYtzoO5p0/ozw8ZdnWt2LxGX225Gih9SiYA==
X-Received: by 2002:a17:90a:c58b:b0:1bc:842c:6c56 with SMTP id l11-20020a17090ac58b00b001bc842c6c56mr4050567pjt.142.1645583194936;
        Tue, 22 Feb 2022 18:26:34 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:2ada:62da:c2a8:ce2c])
        by smtp.gmail.com with ESMTPSA id o14sm12851016pfw.121.2022.02.22.18.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 18:26:34 -0800 (PST)
Date:   Tue, 22 Feb 2022 18:26:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        jabolopes@google.com, Jeff Hostetler <jeffhostetler@github.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] repo_read_index: add config to expect files outside
 sparse patterns
Message-ID: <YhWbWOd6PeF1RZw1@google.com>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Typically with sparse checkouts, we expect files outside the sparsity
patterns to be marked as SKIP_WORKTREE and be missing from the working
tree.  In edge cases, this can be violated and cause confusion, so in
a sparse checkout, since 11d46a399d ("repo_read_index: clear
SKIP_WORKTREE bit from files present in worktree", 2022-01-06), Git
automatically clears the SKIP_WORKTREE bit at read time for entries
corresponding to files that are present in the working tree.

However, there is a more atypical situation where this situation would
be expected.  A Git-aware virtual file system[1] takes advantage of
its position as a file system driver to expose all files in the
working tree, fetch them on demand using partial clone on access, and
tell Git to pay attention to them on demand by updating the sparse
checkout pattern on writes.  This means that commands like "git
status" only has to examine files that have potentially been modified,
whereas commands like "ls" are able to show the entire codebase
without requiring manual updates to the sparse checkout pattern.

Thus since 11d46a399d, Git with such Git-aware virtual file systems
unsets the SKIP_WORKTREE bit for all files and commands like "git
status" have to fetch and examine them all.

Introduce a configuration setting sparse.expectFilesOutsideOfPatterns
to allow limiting the tracked set of files to a small set once again.
A Git-aware virtual file system or other application that wants to
maintain files outside of the sparse checkout can set this in a
repository to instruct Git not to check for the presence of
SKIP_WORKTREE files.  The setting defaults to false, so most users of
sparse checkout will still get the benefit of an automatically
updating index to recover from interrupted updates that forget to
delete some files or unset SKIP_WORKTREE for them.

[1] such as the vfsd described in
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

[jn: fleshed out commit message and documentation, added missing
 include to config.txt, moved to a separate config callback]

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Some minor updates, but this is basically the same as the patch you
sent.  Thoughts?

Thanks,
Jonathan

 Documentation/config.txt         |  2 ++
 Documentation/config/sparse.txt  | 24 ++++++++++++++++++++++++
 cache.h                          |  1 +
 config.c                         | 14 ++++++++++++++
 environment.c                    |  1 +
 sparse-index.c                   |  3 ++-
 t/t1090-sparse-checkout-scope.sh | 19 +++++++++++++++++++
 7 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/sparse.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b168f02dc3d..8628ae2634d 100644
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
index 00000000000..c790c728276
--- /dev/null
+++ b/Documentation/config/sparse.txt
@@ -0,0 +1,24 @@
+sparse.expectFilesOutsideOfPatterns::
+	Typically with sparse checkouts, files not matching any
+	sparsity patterns are marked as such in the index file and
+	missing from the working tree.  Accordingly, Git will
+	ordinarily check whether files that the index indicates are
+	outside of the sparse area are present in the working tree and
+	mark them as present in the index if so.  This option can be
+	used to tell Git that such present-but-unmatching files are
+	expected and to stop checking for them.
++
+The default is `false`.  Leaving this set to `false` is recommended in
+most situations because it allows Git to recover from an interrupted
+operation that updated the working tree without updating the index or
+vice versa.
++
+A Git-based virtual file system (VFS) can turn the usual expectation
+on its head: files are present in the working copy but do not take
+up much disk space because their contents are not downloaded until
+they are accessed.  With such a virtual file system layer, most files
+do not match the sparsity patterns at first, and the VFS layer
+updates the sparsity patterns to add more files whenever files are
+written.  Setting this to `true` supports such a setup where files are
+expected to be present outside the sparse area and a separate, robust
+mechanism is responsible for keeping the sparsity patterns up to date.
diff --git a/cache.h b/cache.h
index 281f00ab1b1..b6b8e83ae35 100644
--- a/cache.h
+++ b/cache.h
@@ -1003,6 +1003,7 @@ extern const char *core_fsmonitor;
 
 extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
+extern int sparse_expect_files_outside_of_patterns;
 
 /*
  * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
diff --git a/config.c b/config.c
index 2bffa8d4a01..9b9ad1500aa 100644
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
index fd0501e77a5..fb55bf61290 100644
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
index eed170cd8f7..daeb5112a18 100644
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
index 3deb4901874..d1833c0f31b 100755
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
2.35.1.574.g5d30c73bfb


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7747DC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 06:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiBZGNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 01:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiBZGNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 01:13:09 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE24B85B
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:12:34 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q5so9286477oij.6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNjocOuAY5rSy/H+NkI4ngPzebLGeBdxLlSTR6wSPiM=;
        b=R6WNVdavylBX/Tt7ep95sc/cZFj/S+mw6dqroWq3wkWhbKEq4zyVO5FLei7mdz8CeI
         v9Z/ARtTkiETLWSsAtdsa7UOcb8Mp24hdnHEzWfH+ziUKjDTID+q/q9J3EP7NEdHhtt2
         Hs0uMb1G6QaaEB7INyzuO1BFyB+6ZssCehh60JEO5rsOF22IgeXLuhOM+S/2yufGF/4G
         +7DyVPyXGVpQxiezeaE10zf/x/bkC5EI7jDlcLlxqmj/9AkyJbPlLfUI/oXOgZ6hWlmE
         5WWWIKprHO+3+38eOoZWwC8Pp6sSJVhCKFxW1m/YRAg8yrLXwB/YqmZ7neLLx1+xTGKi
         tp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNjocOuAY5rSy/H+NkI4ngPzebLGeBdxLlSTR6wSPiM=;
        b=1mJwv7uKP8l05vL2od6fK/x8A0RZ7Amesa2/j7DdlM845monV2NYZzWMsxxK5UDL5M
         z0SCJVi9zh1Xi5Gyuu+aN/zxbA10JJi2iP8u852dcayyRo9DKbHtTRN/J3X+s70qIoOG
         rEytuD0oq8SkRC8lUxFtlXOf9xw4BpBSJwo16vwB98yfaIO+OpUGRO+hlKC1FfAqtEDL
         CqxQdkELx8WipcTD7Dn/1k7i3vL1HTHxRZGPZsHjXuXQoMfyQO/CuBFBI2uXi93I7h5C
         Uus0dhnOCUWMzKoEm6haqGGvIVIx/wrjXlH2+6ueE14qjuaL7NU90QBDRpWWUTdqoNnb
         H5pw==
X-Gm-Message-State: AOAM530bZCXVPXebkE4+Anze3TiHdBxOE3nb8Ja3jpIMGOavLJD7WU/K
        GRAEPpBrR2hku3wz7VKsIAZrQy5ifgH4RQ==
X-Google-Smtp-Source: ABdhPJzkgjNFN7ZPC7NtInW2qVh5qg+7qS2L+Uuxi7zMcBCJxNuwt+Xl8KbVijeDWSYhYCR1Lj77LA==
X-Received: by 2002:a05:6808:168d:b0:2d3:65f0:582f with SMTP id bb13-20020a056808168d00b002d365f0582fmr4079870oib.152.1645855953017;
        Fri, 25 Feb 2022 22:12:33 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::3b])
        by smtp.gmail.com with ESMTPSA id i11-20020a056830402b00b005af1411565bsm2029039ots.78.2022.02.25.22.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 22:12:32 -0800 (PST)
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
Subject: [PATCH v4] repo_read_index: add config to expect files outside sparse patterns
Date:   Fri, 25 Feb 2022 22:12:22 -0800
Message-Id: <20220226061222.797107-1-newren@gmail.com>
X-Mailer: git-send-email 2.35.1.278.g4f05fa7020.dirty
In-Reply-To: <20220224052259.30498-1-newren@gmail.com>
References: <20220224052259.30498-1-newren@gmail.com>
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
[1] such as the vfsd described in
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes since v3:
  * Many wording updates based on feedback and suggestions from both
    Jonathan and Junio.  Thanks for providing concrete suggestions!

Range-diff:
1:  92a13a8f08 ! 1:  5ded1532cd repo_read_index: add config to expect files outside sparse patterns
    @@ Commit message
     
         Typically with sparse checkouts, we expect files outside the sparsity
         patterns to be marked as SKIP_WORKTREE and be missing from the working
    -    tree.  In edge cases, this can be violated and cause confusion, so in a
    -    sparse checkout, since 11d46a399d ("repo_read_index: clear SKIP_WORKTREE
    -    bit from files present in worktree", 2022-01-06), Git automatically
    -    clears the SKIP_WORKTREE bit at read time for entries corresponding to
    -    files that are present in the working tree.
    +    tree.  Sometimes this expectation would be violated however; including
    +    in cases such as:
    +      * users grabbing files from elsewhere and writing them to the worktree
    +        (perhaps by editing a cached copy in an editor, copying/renaming, or
    +         even untarring)
    +      * various git commands having incomplete or no support for the
    +        SKIP_WORKTREE bit[1,2]
    +      * users attempting to "abort" a sparse-checkout operation with a
    +        not-so-early Ctrl+C (updating $GIT_DIR/info/sparse-checkout and the
    +        working tree is not atomic)[3].
    +    When the SKIP_WORKTREE bit in the index did not reflect the presence of
    +    the file in the working tree, it traditionally caused confusion and was
    +    difficult to detect and recover from.  So, in a sparse checkout, since
    +    af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files present
    +    in worktree", 2022-01-06), Git automatically clears the SKIP_WORKTREE
    +    bit at index read time for entries corresponding to files that are
    +    present in the working tree.
     
    -    However, there is a more atypical situation where this situation would
    -    be expected.  A Git-aware virtual file system[1] takes advantage of its
    +    There is another workflow, however, where it is expected that paths
    +    outside the sparsity patterns appear to exist in the working tree and
    +    that they do not lose the SKIP_WORKTREE bit, at least until they get
    +    modified.  A Git-aware virtual file system[4] takes advantage of its
         position as a file system driver to expose all files in the working
         tree, fetch them on demand using partial clone on access, and tell Git
         to pay attention to them on demand by updating the sparse checkout
    @@ Commit message
         like "ls" are able to show the entire codebase without requiring manual
         updates to the sparse checkout pattern.
     
    -    Thus since 11d46a399d, Git with such Git-aware virtual file systems
    +    Thus since af6a51875a, Git with such Git-aware virtual file systems
         unsets the SKIP_WORKTREE bit for all files and commands like "git
         status" have to fetch and examine them all.
     
    @@ Commit message
         SKIP_WORKTREE files.  The setting defaults to false, so most users of
         sparse checkout will still get the benefit of an automatically updating
         index to recover from the variety of difficult issues detailed in
    -    11d46a399d for paths with SKIP_WORKTREE set despite the path being
    +    af6a51875a for paths with SKIP_WORKTREE set despite the path being
         present.
     
    +    [1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
    +    [2] The three long paragraphs in the middle of
    +        https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
    +    [3] https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
         [1] such as the vfsd described in
         https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/
     
    -    Helped-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
         Signed-off-by: Elijah Newren <newren@gmail.com>
    +    Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
     
      ## Documentation/config.txt ##
     @@ Documentation/config.txt: include::config/sequencer.txt[]
    @@ Documentation/config/sparse.txt (new)
     @@
     +sparse.expectFilesOutsideOfPatterns::
     +	Typically with sparse checkouts, files not matching any
    -+	sparsity patterns are marked as such in the index file and
    -+	missing from the working tree.  Accordingly, Git will
    -+	ordinarily check whether files that the index indicates are
    -+	outside of the sparse area are present in the working tree and
    -+	mark them as present in the index if so.  This option can be
    -+	used to tell Git that such present-but-unmatching files are
    -+	expected and to stop checking for them.
    ++	sparsity patterns are marked with a SKIP_WORKTREE bit in the
    ++	index and are missing from the working tree.  Accordingly, Git
    ++	will ordinarily check whether files with the SKIP_WORKTREE bit
    ++	are in fact present in the working tree contrary to
    ++	expectations.  If Git finds any, it marks those paths as
    ++	present by clearing the relevant SKIP_WORKTREE bits.  This
    ++	option can be used to tell Git that such
    ++	present-despite-skipped files are expected and to stop
    ++	checking for them.
     ++
    -+The default is `false`.  Paths which are marked as SKIP_WORKTREE
    -+despite being present (which can occur for a few different reasons)
    -+typically present a range of problems which are difficult for users to
    -+discover and recover from.  The default setting avoids such issues.
    ++The default is `false`, which allows Git to automatically recover
    ++from the list of files in the index and working tree falling out of
    ++sync.
     ++
    -+A Git-based virtual file system (VFS) can turn the usual expectation
    -+on its head: files are present in the working copy but do not take
    -+up much disk space because their contents are not downloaded until
    -+they are accessed.  With such a virtual file system layer, most files
    -+do not match the sparsity patterns at first, and the VFS layer
    -+updates the sparsity patterns to add more files whenever files are
    -+written.  Setting this to `true` supports such a setup where files are
    -+expected to be present outside the sparse area and a separate, robust
    -+mechanism is responsible for keeping the sparsity patterns up to date.
    ++Set this to `true` if you are in a setup where some external factor
    ++relieves Git of the responsibility for maintaining the consistency
    ++between the presence of working tree files and sparsity patterns.  For
    ++example, if you have a Git-aware virtual file system that has a robust
    ++mechanism for keeping the working tree and the sparsity patterns up to
    ++date based on access patterns.
     ++
    -+Note that the checking and clearing of the SKIP_WORKTREE bit only
    -+happens when core.sparseCheckout is true, so this config option has no
    -+effect unless core.sparseCheckout is true.
    ++Regardless of this setting, Git does not check for
    ++present-despite-skipped files unless sparse checkout is enabled, so
    ++this config option has no effect unless `core.sparseCheckout` is
    ++`true`.
     
      ## cache.h ##
     @@ cache.h: extern const char *core_fsmonitor;

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
2.35.1.278.g4f05fa7020.dirty


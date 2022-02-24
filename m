Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF78C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 05:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiBXFX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiBXFXz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 00:23:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E95C0872
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:23:26 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 185so981640qkh.1
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 21:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptRGMmQZi0diyxHEzoSr/WWqt2PwHalhhC5S1aR32EI=;
        b=GuBqDYWrPm1boXzLy6LlNKuOTcGDq0083pw37GVHy3jSG5csM2p5arP2TeUgg9YofV
         s/EJn9DYkqXYR+ZcKomIcsPG0JqMK417vQLWoPwAstLAfRqIkc/h3kJVlNiXL8EFAqbo
         BVsEevibXsJISr/U2iOCeSkAEY7SZRA9Io/MqZtaf+Zak2V6ky2a9e8kXc4EOfg10X21
         JzW8eAK6nWDaRwZ/Y3aueg6BoRtpvuCsPA5LZj8ksoNAyrwTIFIcI3IIbhG6LDEe/BMh
         9XampHPHtRdKGJQjJkVsWHH9UecES4ESpzNxdtR2dBOe6wkpBrVS1ZH+LZsBA5itxRkt
         LkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptRGMmQZi0diyxHEzoSr/WWqt2PwHalhhC5S1aR32EI=;
        b=qL2nFbvEuGwrgQqOvmldXvezSXBhz8kjx/JhOKYqqiWw071xPNlVErjTjwRf+ORMV8
         33q4qeXEnc+4A7gHVLNVEh/vHPgUwMOSEm9oqhsTuAOKogI42UHySQR1Eq6iPy3sICht
         L1wZz6ojzULGJlvvO8P1jXlMuCG7rMMan9McLuqA4SYdXZQ51o2AjvtvLIqY5L/XNbH5
         LGzjjwxC8oCOtEpUgrVlo/tcjFdG3XZh+YNoSL5bEL6LEfgUK8iIw8yp7mbGQO/hiDSd
         MqZmawTMrszCSbGNCXkAJisr157Bi6FXYkWvADYpMGNARstjmv5G2/Hf9avblP0M4MKn
         6q4Q==
X-Gm-Message-State: AOAM533cxrKC9cNtwUSRCgWx5YImqctANZw9yqERbgduwP3Nhuv8VAy2
        74imfQIjoY/R9gok8yKy8ygjLpnGPEmmvg==
X-Google-Smtp-Source: ABdhPJzeNIYd5wG98FmofqXPVVDy4kUhQ7kTo/gDxjLiunGqL0egqKWshlZ9sCkNd96mZ6sgDKM81w==
X-Received: by 2002:a05:620a:1519:b0:648:bbdd:8feb with SMTP id i25-20020a05620a151900b00648bbdd8febmr610697qkk.634.1645680204624;
        Wed, 23 Feb 2022 21:23:24 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::3b])
        by smtp.gmail.com with ESMTPSA id i19sm1097856qtx.19.2022.02.23.21.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:23:23 -0800 (PST)
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
Subject: [PATCH v3] repo_read_index: add config to expect files outside sparse patterns
Date:   Wed, 23 Feb 2022 21:22:59 -0800
Message-Id: <20220224052259.30498-1-newren@gmail.com>
X-Mailer: git-send-email 2.34.0.22.g587c05af5b.dirty
In-Reply-To: <YhWbWOd6PeF1RZw1@google.com>
References: <YhWbWOd6PeF1RZw1@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typically with sparse checkouts, we expect files outside the sparsity
patterns to be marked as SKIP_WORKTREE and be missing from the working
tree.  In edge cases, this can be violated and cause confusion, so in a
sparse checkout, since 11d46a399d ("repo_read_index: clear SKIP_WORKTREE
bit from files present in worktree", 2022-01-06), Git automatically
clears the SKIP_WORKTREE bit at read time for entries corresponding to
files that are present in the working tree.

However, there is a more atypical situation where this situation would
be expected.  A Git-aware virtual file system[1] takes advantage of its
position as a file system driver to expose all files in the working
tree, fetch them on demand using partial clone on access, and tell Git
to pay attention to them on demand by updating the sparse checkout
pattern on writes.  This means that commands like "git status" only have
to examine files that have potentially been modified, whereas commands
like "ls" are able to show the entire codebase without requiring manual
updates to the sparse checkout pattern.

Thus since 11d46a399d, Git with such Git-aware virtual file systems
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
11d46a399d for paths with SKIP_WORKTREE set despite the path being
present.

[1] such as the vfsd described in
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v2:
  * Made tweaks to the commit message and the text of the config option as
    highlighted in my response to Jonathan's v2.

I'm guessing that since there are no code (only documentation) changes since
Jonathan's v2 submission, that this patch satisfies vfsd/Google's needs.
I'm also guessing it matches what Stolee and Dscho stated in their comments
on v1.  But it'd be nice to have an ack from each side just to make sure.
    
 Documentation/config.txt         |  2 ++
 Documentation/config/sparse.txt  | 28 ++++++++++++++++++++++++++++
 cache.h                          |  1 +
 config.c                         | 14 ++++++++++++++
 environment.c                    |  1 +
 sparse-index.c                   |  3 ++-
 t/t1090-sparse-checkout-scope.sh | 19 +++++++++++++++++++
 7 files changed, 67 insertions(+), 1 deletion(-)
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
index 0000000000..fba504173c
--- /dev/null
+++ b/Documentation/config/sparse.txt
@@ -0,0 +1,28 @@
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
+The default is `false`.  Paths which are marked as SKIP_WORKTREE
+despite being present (which can occur for a few different reasons)
+typically present a range of problems which are difficult for users to
+discover and recover from.  The default setting avoids such issues.
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
++
+Note that the checking and clearing of the SKIP_WORKTREE bit only
+happens when core.sparseCheckout is true, so this config option has no
+effect unless core.sparseCheckout is true.
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
2.34.0.22.g587c05af5b.dirty


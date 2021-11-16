Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECDC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17AF63212
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhKPSap (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbhKPSal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:30:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D38C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:27:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n29so39343046wra.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ic3kalAV0icaGsw21hya2kwjlAVBZUvRk+9bcJtPve4=;
        b=DNTtNZ/TdBEi/nSS+G06Ve6ipP24gXX/7nYvHFgq5a4QCTFHBitrvOpgymtAJanJzT
         WMcvOzvdhCIWfl0KNn7txnrCiV0DCCYCmVz6BuT1WVrAOqena5B/Po1yealA75GJAnK/
         ZwvWp7DvO7Z/OT/A9J2bYO9zQusRTnS8oburO9FPd4RVr1rl7Th00U4SzUufU3nfHrs7
         9gimmyhHzFMkNf0PR2JtxzyxK8kBd6Oqj56dI7i2Y1YrTDe20+hjUk1xCMBQ4fL6olkQ
         JO5CrRVjK0oC5N1WjKTV2/H1g1qEWkx7I5OeRK6p93S77JhReYhVMvRumluhx2fQnSmo
         w1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ic3kalAV0icaGsw21hya2kwjlAVBZUvRk+9bcJtPve4=;
        b=32E9upX6NY3s+HfsEed8wfGhWPjDnBHhxBkR/SwDoP7DaFbMv0y8h52JpIGmoLBCuu
         zZLJ85IOkTsZPS0VLZiZTBxjADC2ggRpoxjHwRtgjvvV/WIncWc9bDe/8KSQGEpqeuA1
         e52mcUh6SsUEt+N2fgMgMqT82Vh5d+Yayqf/67QBC8neQvm736yqxm588L2AmJBUkAP9
         8T3TjeESaccuiltW+oK4UeWgJbx7pRMKIp8mmGZjgeNhkvadhT2O4MbqXUIRtaxc5h4q
         yZTR9kBVT7SxXz/uQCjfR7bUjcSFv6aBYZHfTXHQOkG0hB2L6MFYbgqY2ZvU8g8vVRu6
         SkIw==
X-Gm-Message-State: AOAM5339JdtZ0qi114e1hNHi26ejtUJPFZfcZ5JPVSE/oYX0U781kbwW
        AdjZlgDCzTozsVEI/4nKuKNJXvwsdqVYAw==
X-Google-Smtp-Source: ABdhPJwOqmvar+rHGsMwXFVINtLSeou9Qi8OMgJqpFJD/o7taxCv5ykS7WD/prk7ikLQNQQlRy2ALw==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr11571174wry.361.1637087261041;
        Tue, 16 Nov 2021 10:27:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm3367465wmb.7.2021.11.16.10.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:27:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4] checkout: fix "branch info" memory leaks
Date:   Tue, 16 Nov 2021 19:27:38 +0100
Message-Id: <patch-v4-1.1-57bcd0cbc23-20211116T182604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <patch-v3-1.1-337c8b7177e-20211103T112732Z-avarab@gmail.com>
References: <patch-v3-1.1-337c8b7177e-20211103T112732Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "checkout" command is one of the main sources of leaks in the test
suite, let's fix the common ones by not leaking from the "struct
branch_info".

Doing this is rather straightforward, albeit verbose, we need to
xstrdup() constant strings going into the struct, and free() the ones
we clobber as we go along.

This also means that we can delete previous partial leak fixes in this
area, i.e. the "path_to_free" accounting added by 96ec7b1e708 (Convert
resolve_ref+xstrdup to new resolve_refdup function, 2011-12-13).

There was some discussion about whether "we should retain the "const
char *" here and cast at free() time, or have it be a "char *". Since
this is not a public API with any sort of API boundary let's use
"char *", as is already being done for the "refname" member of the
same struct.

The tests to mark as passing were found with:

    rm .prove; GIT_SKIP_TESTS=t0027 prove -j8 --state=save t[0-9]*.sh :: --immediate
    # apply & compile this change
    prove -j8 --state=failed :: --immediate

I.e. the ones that were newly passing when the --state=failed command
was run. I left out "t3040-subprojects-basic.sh" and
"t4131-apply-fake-ancestor.sh" to to optimization-level related
differences similar to the ones noted in[1], except that these would
be something the current 'linux-leaks' job would run into.

1. https://lore.kernel.org/git/cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
A v4 with a leak that was missed, and a marking of 3x new passing
tests that pass as a result. Junio: Hopefully this can be picked up
now post-release.

Range-diff against v3:
1:  337c8b7177e ! 1:  57bcd0cbc23 checkout: fix "branch info" memory leaks
    @@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
      		branch->name = xstrdup(buf.buf);
     +	}
      	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
    ++	free(branch->path);
      	branch->path = strbuf_detach(&buf, NULL);
      }
    + 
     @@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opts *opts,
      				      opts->new_branch_log,
      				      opts->quiet,
    @@ t/t4121-apply-diffs.sh: test_description='git apply for contextually independent
      
      echo '1
     
    + ## t/t4204-patch-id.sh ##
    +@@ t/t4204-patch-id.sh: test_description='git patch-id'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
    + ## t/t5410-receive-pack-alternates.sh ##
    +@@ t/t5410-receive-pack-alternates.sh: test_description='git receive-pack with alternate ref filtering'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
      ## t/t5609-clone-branch.sh ##
     @@ t/t5609-clone-branch.sh: test_description='clone --branch option'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    @@ t/t6407-merge-binary.sh: test_description='ask merge-recursive to merge binary f
      
      test_expect_success setup '
     
    + ## t/t6414-merge-rename-nocruft.sh ##
    +@@ t/t6414-merge-rename-nocruft.sh: test_description='Merge-recursive merging renames'
    + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success 'setup' '
    +
      ## t/t7113-post-index-change-hook.sh ##
     @@ t/t7113-post-index-change-hook.sh: test_description='post index change hook'
      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main

 builtin/checkout.c                          | 86 +++++++++++++--------
 t/t0020-crlf.sh                             |  1 +
 t/t1005-read-tree-reset.sh                  |  1 +
 t/t1008-read-tree-overlay.sh                |  1 +
 t/t1403-show-ref.sh                         |  1 +
 t/t1406-submodule-ref-store.sh              |  1 +
 t/t1505-rev-parse-last.sh                   |  1 +
 t/t2007-checkout-symlink.sh                 |  1 +
 t/t2008-checkout-subdir.sh                  |  1 +
 t/t2009-checkout-statinfo.sh                |  1 +
 t/t2010-checkout-ambiguous.sh               |  1 +
 t/t2011-checkout-invalid-head.sh            |  1 +
 t/t2014-checkout-switch.sh                  |  2 +
 t/t2017-checkout-orphan.sh                  |  1 +
 t/t2019-checkout-ambiguous-ref.sh           |  2 +
 t/t2021-checkout-overwrite.sh               |  2 +
 t/t2022-checkout-paths.sh                   |  1 +
 t/t2026-checkout-pathspec-file.sh           |  1 +
 t/t2106-update-index-assume-unchanged.sh    |  1 +
 t/t3040-subprojects-basic.sh                |  2 +
 t/t3305-notes-fanout.sh                     |  1 +
 t/t3422-rebase-incompatible-options.sh      |  2 +
 t/t4115-apply-symlink.sh                    |  1 +
 t/t4121-apply-diffs.sh                      |  1 +
 t/t4204-patch-id.sh                         |  1 +
 t/t5410-receive-pack-alternates.sh          |  1 +
 t/t5609-clone-branch.sh                     |  1 +
 t/t6407-merge-binary.sh                     |  1 +
 t/t6414-merge-rename-nocruft.sh             |  1 +
 t/t7113-post-index-change-hook.sh           |  1 +
 t/t7509-commit-authorship.sh                |  1 +
 t/t7815-grep-binary.sh                      |  1 +
 t/t9102-git-svn-deep-rmdir.sh               |  2 +
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |  1 +
 t/t9128-git-svn-cmd-branch.sh               |  2 +
 t/t9167-git-svn-cmd-branch-subproject.sh    |  2 +
 36 files changed, 98 insertions(+), 31 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cbf73b8c9f6..43d0275187f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -91,8 +91,8 @@ struct checkout_opts {
 };
 
 struct branch_info {
-	const char *name; /* The short name used */
-	const char *path; /* The full name of a real branch */
+	char *name; /* The short name used */
+	char *path; /* The full name of a real branch */
 	struct commit *commit; /* The named commit */
 	char *refname; /* The full name of the ref being checked out. */
 	struct object_id oid; /* The object ID of the commit being checked out. */
@@ -103,6 +103,14 @@ struct branch_info {
 	char *checkout;
 };
 
+static void branch_info_release(struct branch_info *info)
+{
+	free(info->name);
+	free(info->path);
+	free(info->refname);
+	free(info->checkout);
+}
+
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
@@ -688,9 +696,12 @@ static void setup_branch_path(struct branch_info *branch)
 		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
 
 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
-	if (strcmp(buf.buf, branch->name))
+	if (strcmp(buf.buf, branch->name)) {
+		free(branch->name);
 		branch->name = xstrdup(buf.buf);
+	}
 	strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
+	free(branch->path);
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
@@ -894,7 +905,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				      opts->new_branch_log,
 				      opts->quiet,
 				      opts->track);
-		new_branch_info->name = opts->new_branch;
+		free(new_branch_info->name);
+		free(new_branch_info->refname);
+		new_branch_info->name = xstrdup(opts->new_branch);
 		setup_branch_path(new_branch_info);
 	}
 
@@ -1062,8 +1075,7 @@ static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
 	int ret = 0;
-	struct branch_info old_branch_info;
-	void *path_to_free;
+	struct branch_info old_branch_info = { 0 };
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
@@ -1071,25 +1083,32 @@ static int switch_branches(const struct checkout_opts *opts,
 	trace2_cmd_mode("branch");
 
 	memset(&old_branch_info, 0, sizeof(old_branch_info));
-	old_branch_info.path = path_to_free = resolve_refdup("HEAD", 0, &rev, &flag);
+	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
 	if (old_branch_info.path)
 		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
 	if (!(flag & REF_ISSYMREF))
-		old_branch_info.path = NULL;
+		FREE_AND_NULL(old_branch_info.path);
 
-	if (old_branch_info.path)
-		skip_prefix(old_branch_info.path, "refs/heads/", &old_branch_info.name);
+	if (old_branch_info.path) {
+		const char *const prefix = "refs/heads/";
+		const char *p;
+		if (skip_prefix(old_branch_info.path, prefix, &p))
+			old_branch_info.name = xstrdup(p);
+		else
+			BUG("should be able to skip past '%s' in '%s'!",
+			    prefix, old_branch_info.path);
+	}
 
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
 		if (new_branch_info->name)
 			BUG("'switch --orphan' should never accept a commit as starting point");
 		new_branch_info->commit = NULL;
-		new_branch_info->name = "(empty)";
+		new_branch_info->name = xstrdup("(empty)");
 		do_merge = 1;
 	}
 
 	if (!new_branch_info->name) {
-		new_branch_info->name = "HEAD";
+		new_branch_info->name = xstrdup("HEAD");
 		new_branch_info->commit = old_branch_info.commit;
 		if (!new_branch_info->commit)
 			die(_("You are on a branch yet to be born"));
@@ -1102,7 +1121,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (do_merge) {
 		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
 		if (ret) {
-			free(path_to_free);
+			branch_info_release(&old_branch_info);
 			return ret;
 		}
 	}
@@ -1113,7 +1132,8 @@ static int switch_branches(const struct checkout_opts *opts,
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
-	free(path_to_free);
+	branch_info_release(&old_branch_info);
+
 	return ret || writeout_error;
 }
 
@@ -1145,16 +1165,15 @@ static void setup_new_branch_info_and_source_tree(
 	struct tree **source_tree = &opts->source_tree;
 	struct object_id branch_rev;
 
-	new_branch_info->name = arg;
+	new_branch_info->name = xstrdup(arg);
 	setup_branch_path(new_branch_info);
 
 	if (!check_refname_format(new_branch_info->path, 0) &&
 	    !read_ref(new_branch_info->path, &branch_rev))
 		oidcpy(rev, &branch_rev);
-	else {
-		free((char *)new_branch_info->path);
-		new_branch_info->path = NULL; /* not an existing branch */
-	}
+	else
+		/* not an existing branch */
+		FREE_AND_NULL(new_branch_info->path);
 
 	new_branch_info->commit = lookup_commit_reference_gently(the_repository, rev, 1);
 	if (!new_branch_info->commit) {
@@ -1574,12 +1593,11 @@ static char cb_option = 'b';
 
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[])
+			 const char * const usagestr[],
+			 struct branch_info *new_branch_info)
 {
-	struct branch_info new_branch_info;
 	int parseopt_flags = 0;
 
-	memset(&new_branch_info, 0, sizeof(new_branch_info));
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
@@ -1688,7 +1706,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, opts, &rev);
+					     new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1697,7 +1715,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		if (get_oid_mb(opts->from_treeish, &rev))
 			die(_("could not resolve %s"), opts->from_treeish);
 
-		setup_new_branch_info_and_source_tree(&new_branch_info,
+		setup_new_branch_info_and_source_tree(new_branch_info,
 						      opts, &rev,
 						      opts->from_treeish);
 
@@ -1717,7 +1735,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
+		if (opts->new_branch && argc == 1 && !new_branch_info->commit)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
 				argv[0], opts->new_branch);
 
@@ -1766,11 +1784,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		strbuf_release(&buf);
 	}
 
-	UNLEAK(opts);
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, &new_branch_info);
+		return checkout_paths(opts, new_branch_info);
 	else
-		return checkout_branch(opts, &new_branch_info);
+		return checkout_branch(opts, new_branch_info);
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
@@ -1789,6 +1806,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret;
+	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1819,7 +1837,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, checkout_usage);
+			    options, checkout_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts.pathspec);
 	FREE_AND_NULL(options);
 	return ret;
 }
@@ -1840,6 +1860,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret;
+	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
@@ -1859,7 +1880,8 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	cb_option = 'c';
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, switch_branch_usage);
+			    options, switch_branch_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
 	FREE_AND_NULL(options);
 	return ret;
 }
@@ -1881,6 +1903,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int ret;
+	struct branch_info new_branch_info = { 0 };
 
 	memset(&opts, 0, sizeof(opts));
 	opts.accept_ref = 0;
@@ -1896,7 +1919,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
-			    options, restore_usage);
+			    options, restore_usage, &new_branch_info);
+	branch_info_release(&new_branch_info);
 	FREE_AND_NULL(options);
 	return ret;
 }
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index f25ae8b5e1f..4125ab8b884 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -5,6 +5,7 @@ test_description='CRLF conversion'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 83b09e13106..12e30d77d09 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -2,6 +2,7 @@
 
 test_description='read-tree -u --reset'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index 4512fb0b6e6..ad5936e54d1 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -5,6 +5,7 @@ test_description='test multi-tree read-tree without merging'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 17d3cc14050..4d261e80c6f 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -4,6 +4,7 @@ test_description='show-ref'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..3c19edcf30b 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -5,6 +5,7 @@ test_description='test submodule ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store submodule:sub"
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 2803ca9489c..4a5758f08a8 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -5,6 +5,7 @@ test_description='test @{-N} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 6f0b90ce127..bd9e9e7530d 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -7,6 +7,7 @@ test_description='git checkout to switch between branches with symlink<->dir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index eadb9434ae7..8a518a44ea2 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -4,6 +4,7 @@
 
 test_description='git checkout from subdirectories'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index b0540636ae3..71195dd28f2 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -5,6 +5,7 @@ test_description='checkout should leave clean stat info'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 6e8757387d1..9d4b37526a3 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -5,6 +5,7 @@ test_description='checkout and pathspecs/refspecs ambiguities'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index e52022e1522..d9997e7b6b4 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -5,6 +5,7 @@ test_description='checkout switching away from an invalid branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2014-checkout-switch.sh b/t/t2014-checkout-switch.sh
index ccfb1471135..c138bdde4fe 100755
--- a/t/t2014-checkout-switch.sh
+++ b/t/t2014-checkout-switch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Peter MacMillan'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 88d6992a5e1..f3371e26460 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -10,6 +10,7 @@ Main Tests for --orphan functionality.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 TEST_FILE=foo
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index b99d5192a96..2c8c926b4d7 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='checkout handling of ambiguous (branch/tag) refs'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ambiguous refs' '
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index 660132ff8d5..713c3fa6038 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='checkout must not overwrite an untracked objects'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index c49ba7f9bd4..f1b709d58be 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -4,6 +4,7 @@ test_description='checkout $tree -- $paths'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index 43d31d79485..9db11f86dd6 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='checkout --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 2d450daf5c8..d943ddf47e0 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -3,6 +3,7 @@
 test_description='git update-index --assume-unchanged test.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 6abdcbbc94a..bd65dfcffc7 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Basic subproject functionality'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: create superproject' '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 94c1b02251c..960d0587e18 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -2,6 +2,7 @@
 
 test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 path_has_fanout() {
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index eb0a3d9d487..6dabb05a2ad 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test if rebase detects and aborts on incompatible options'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index 872fcda6cb6..d0f3edef54a 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -7,6 +7,7 @@ test_description='git apply symlinks and partial files
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index b45454aaf4b..a80cec9d119 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -4,6 +4,7 @@ test_description='git apply for contextually independent diffs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echo '1
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index f120857c20a..e78d8097f39 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,6 +5,7 @@ test_description='git patch-id'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 0b28e4e452f..7a45d4c311e 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -5,6 +5,7 @@ test_description='git receive-pack with alternate ref filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index f86a674a032..252e1f7c20f 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -4,6 +4,7 @@ test_description='clone --branch option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_HEAD() {
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index d4273f2575b..e34676c204b 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,6 +5,7 @@ test_description='ask merge-recursive to merge binary files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6414-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
index d7e3c1fa6e6..69fc1c9e697 100755
--- a/t/t6414-merge-rename-nocruft.sh
+++ b/t/t6414-merge-rename-nocruft.sh
@@ -4,6 +4,7 @@ test_description='Merge-recursive merging renames'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index 688fa995c91..a21781d68a1 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -5,6 +5,7 @@ test_description='post index change hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index d568593382c..21c668f75ed 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -5,6 +5,7 @@
 
 test_description='commit tests of various authorhip options. '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 author_header () {
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index 90ebb64f46e..ac871287c03 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -2,6 +2,7 @@
 
 test_description='git grep in binary files'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' "
diff --git a/t/t9102-git-svn-deep-rmdir.sh b/t/t9102-git-svn-deep-rmdir.sh
index 66cd51102c8..7b2049caa0c 100755
--- a/t/t9102-git-svn-deep-rmdir.sh
+++ b/t/t9102-git-svn-deep-rmdir.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 test_description='git svn rmdir'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
diff --git a/t/t9123-git-svn-rebuild-with-rewriteroot.sh b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
index ead404589eb..3320b1f39cf 100755
--- a/t/t9123-git-svn-rebuild-with-rewriteroot.sh
+++ b/t/t9123-git-svn-rebuild-with-rewriteroot.sh
@@ -5,6 +5,7 @@
 
 test_description='git svn respects rewriteRoot during rebuild'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 mkdir import
diff --git a/t/t9128-git-svn-cmd-branch.sh b/t/t9128-git-svn-cmd-branch.sh
index 4e95f791db1..9871f5abc93 100755
--- a/t/t9128-git-svn-cmd-branch.sh
+++ b/t/t9128-git-svn-cmd-branch.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn partial-rebuild tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize svnrepo' '
diff --git a/t/t9167-git-svn-cmd-branch-subproject.sh b/t/t9167-git-svn-cmd-branch-subproject.sh
index ba35fc06fce..d9fd111c105 100755
--- a/t/t9167-git-svn-cmd-branch-subproject.sh
+++ b/t/t9167-git-svn-cmd-branch-subproject.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='git svn branch for subproject clones'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize svnrepo' '
-- 
2.34.0.795.g1e9501ab396


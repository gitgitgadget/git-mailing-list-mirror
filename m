Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B9C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 200612078C
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR2LgHw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437973AbgE2AE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 20:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437912AbgE2AEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 20:04:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65660C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 17:04:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 16so486353qka.15
        for <git@vger.kernel.org>; Thu, 28 May 2020 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DIQ0T+NdRg6DkeoJtlNl9akQyJbtrjX1jUUEGqLftaM=;
        b=NR2LgHw/grJSWHAx6b0wvBU8rBhCUQy8ooydhEbh5YK0zP0cyudqTY5x5aQbA2dzu1
         YoYz5rSBsrA1VYlNeSs2Zfv8ZIPO6uhCRBf1duUN4Mtsi6TPIQb6hfOpG3lbhvIVUYso
         KOMReT4Il2j/iVvaKsWjmtcx9ancrGQiYC6oNxn3kYzluYrlniNAjO8/Hf+2ay9aPXIW
         Fv03S0NoEX2FDMk0I0rmsVZbIu3gqBVNkkREujhEMnrl7pbIq4vidTSNVSBdtda2GCLn
         S3vd3rv4r6kLKOE6Ajj5QCCD97MSKTuz+y2APN4JG1OQN+m5Vg7zrgY/Xm1oVMzvt2W3
         +4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DIQ0T+NdRg6DkeoJtlNl9akQyJbtrjX1jUUEGqLftaM=;
        b=XCaMSlX9Rr/82r5A+t0RP2r/96yMm6cTUOIwHCgFVLr2j4Xt1bx5Pe7DH9lILFLolQ
         uX1+RLLVQr5R2qTJiXjFMLCNi/r6GjeBzb1+Rf6OqqL94HCC6iAX7Y7ogqf+mk3nCuA7
         xoKPsyqR8eABf6lviF/+xmj5URRNioH08Dn0fL9XeyaqtBNi0vQDB3ZilVcwBTl+Tn5I
         t/u775lxAPuqQgEiMFLaiUZ6f2D6AnRan17wwz2q+ku+b2IiNXrUxvBBgSX0womy9ql4
         LCH1yiKqCAkIqRRu9qs30RtKLwY5HoW3RuVdMQbVhFKJ3hxb8FwixegWQHp0WYu6TWPp
         XexQ==
X-Gm-Message-State: AOAM531woiHxlbn+zrFlxfz4Xbbsbaf/tq1hYPV1gdDFjH+n+sFic1CS
        NlOT8mYtGw2Xb+g7kHfgqlFXUp21BrIOjq4Ev+5UheRg8bq+nnUVVHi+wwhuTbw6yuIyJ5M7xAM
        UdUAk7MEwBFS8edcdTPF5rT2t3avoFjh+MlutQg/OMs7VBLFAO6ZKg+kKSqU2
X-Google-Smtp-Source: ABdhPJzlSOyJEC/V2Xc7VpbTr2JTRijQgBZ4U+DOpxFEZRTPeOrBcZh5dUMJ5/CMXufc2T5fJY+Nn6V8gKY+
X-Received: by 2002:a05:6214:6a1:: with SMTP id s1mr5818666qvz.46.1590710692454;
 Thu, 28 May 2020 17:04:52 -0700 (PDT)
Date:   Thu, 28 May 2020 17:04:32 -0700
In-Reply-To: <20200528191739.GA114915@google.com>
Message-Id: <20200529000432.146618-1-delphij@google.com>
Mime-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v4] fetch: allow adding a filter after initial clone.
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>, jrnieder@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, iankaz@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Retroactively adding filter can be useful for existing shallow clones as
they allow users to see earlier change histories without downloading all
git objects in a regular --unshallow fetch.

Without this patch, users can make a clone partial by editing the
repository configuration to convert the remote into a promisor, like:

  git config core.repositoryFormatVersion 1
  git config extensions.partialClone origin
  git fetch --unshallow --filter=blob:none origin

Since the hard part of making this work is already in place and such
edits can be error-prone, teach Git to perform the required configuration
change automatically instead.

Instead of bailing out immediately when no promisor is available, make
the code perform a more precise check for any potential problems
(extensions became special in repository version 1, while it can have
any value in version 0, so upgrade should not happen if the repository
have an unsupported configuration that would render it invalid if we
upgraded).

Signed-off-by: Xin Li <delphij@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/fetch.c                  |  3 --
 builtin/sparse-checkout.c        |  2 +
 cache.h                          |  2 +
 list-objects-filter-options.c    |  3 +-
 repository.h                     |  6 +++
 setup.c                          | 77 ++++++++++++++++++++++++++++++--
 t/t0410-partial-clone.sh         | 23 ++++++++++
 t/t1090-sparse-checkout-scope.sh |  1 -
 t/t2404-worktree-config.sh       |  4 +-
 t/t5500-fetch-pack.sh            |  1 -
 t/t5702-protocol-v2.sh           |  1 -
 11 files changed, 111 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5788c16bf..3347d578ea 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1790,9 +1790,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
-	if (filter_options.choice && !has_promisor_remote())
-		die("--filter can only be used when extensions.partialClone is set");
-
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 95d0882417..95669815d4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -249,6 +249,8 @@ static int set_config(enum sparse_checkout_mode mode)
 {
 	const char *config_path;
 
+	if (upgrade_repository_format(1) < 0)
+		die(_("unable to upgrade repository format to enable worktreeConfig"));
 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
 		error(_("failed to set extensions.worktreeConfig setting"));
 		return 1;
diff --git a/cache.h b/cache.h
index 0f0485ecfe..66dcd2f219 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,6 +1042,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int has_extensions;
 	char *work_tree;
 	struct string_list unknown_extensions;
 };
@@ -1056,6 +1057,7 @@ struct repository_format {
 	.version = -1, \
 	.is_bare = -1, \
 	.hash_algo = GIT_HASH_SHA1, \
+	.has_extensions = 0, \
 	.unknown_extensions = STRING_LIST_INIT_DUP, \
 }
 
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 256bcfbdfe..3553ad7b0a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -326,7 +326,8 @@ void partial_clone_register(
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
-		git_config_set("core.repositoryformatversion", "1");
+		if (upgrade_repository_format(1) < 0)
+			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
diff --git a/repository.h b/repository.h
index 6534fbb7b3..40cc12c7cf 100644
--- a/repository.h
+++ b/repository.h
@@ -196,4 +196,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
 
 void prepare_repo_settings(struct repository *r);
 
+/*
+ * Return 1 if upgrade repository format to target_version succeeded,
+ * 0 if no upgrade is necessary; returns -1 when upgrade is not possible.
+ */
+int upgrade_repository_format(int target_version);
+
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 65fe5ecefb..0759e9f8f9 100644
--- a/setup.c
+++ b/setup.c
@@ -13,6 +13,9 @@ static int work_tree_config_is_bogus;
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
 
+static int verify_repository_format_eligibility(const struct repository_format *,
+    struct strbuf *, int);
+
 /*
  * The input parameter must contain an absolute path, and it must already be
  * normalized.
@@ -455,6 +458,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
+		data->has_extensions = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
@@ -506,9 +510,15 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		die("%s", err.buf);
 	}
 
-	repository_format_precious_objects = candidate->precious_objects;
-	set_repository_format_partial_clone(candidate->partial_clone);
-	repository_format_worktree_config = candidate->worktree_config;
+	if (candidate->version >= 1) {
+		repository_format_precious_objects = candidate->precious_objects;
+		set_repository_format_partial_clone(candidate->partial_clone);
+		repository_format_worktree_config = candidate->worktree_config;
+	} else {
+		repository_format_precious_objects = 0;
+		set_repository_format_partial_clone(NULL);
+		repository_format_worktree_config = 0;
+	}
 	string_list_clear(&candidate->unknown_extensions, 0);
 
 	if (repository_format_worktree_config) {
@@ -538,6 +548,34 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
+int upgrade_repository_format(int target_version)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf repo_version = STRBUF_INIT;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+
+	strbuf_git_common_path(&sb, the_repository, "config");
+	read_repository_format(&repo_fmt, sb.buf);
+	strbuf_release(&sb);
+
+	if (repo_fmt.version >= target_version)
+		return 0;
+
+	if (verify_repository_format_eligibility(&repo_fmt, &err,
+	    target_version) < 0) {
+		warning("unable to upgrade repository format from %d to %d: %s",
+		    repo_fmt.version, target_version, err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	strbuf_addf(&repo_version, "%d", target_version);
+	git_config_set("core.repositoryformatversion", repo_version.buf);
+	strbuf_release(&repo_version);
+	return 1;
+}
+
 static void init_repository_format(struct repository_format *format)
 {
 	const struct repository_format fresh = REPOSITORY_FORMAT_INIT;
@@ -562,7 +600,7 @@ void clear_repository_format(struct repository_format *format)
 	init_repository_format(format);
 }
 
-int verify_repository_format(const struct repository_format *format,
+static int verify_repository_format_version(const struct repository_format *format,
 			     struct strbuf *err)
 {
 	if (GIT_REPO_VERSION_READ < format->version) {
@@ -571,6 +609,18 @@ int verify_repository_format(const struct repository_format *format,
 		return -1;
 	}
 
+	return 0;
+}
+
+int verify_repository_format(const struct repository_format *format,
+			     struct strbuf *err)
+{
+	int result;
+
+	result = verify_repository_format_version(format, err);
+	if (result != 0)
+		return (result);
+
 	if (format->version >= 1 && format->unknown_extensions.nr) {
 		int i;
 
@@ -585,6 +635,25 @@ int verify_repository_format(const struct repository_format *format,
 	return 0;
 }
 
+static int verify_repository_format_eligibility(const struct repository_format
+    *format, struct strbuf *err, int target_version)
+{
+	int result;
+
+	result = verify_repository_format_version(format, err);
+	if (result != 0)
+		return (result);
+
+	if (format->version <= 0 && format->has_extensions &&
+	    target_version >= 1) {
+		strbuf_addf(err, _("extensions found for repository version %d"),
+			      format->version);
+		return -1;
+	}
+
+	return 0;
+}
+
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a3988bd4b8..463dc3a8be 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -30,6 +30,29 @@ test_expect_success 'extensions.partialclone without filter' '
 	git -C client fetch origin
 '
 
+test_expect_success 'convert shallow clone to partial clone' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	git -C client fetch --unshallow --filter="blob:none" &&
+	test_cmp_config -C client true remote.origin.promisor &&
+	test_cmp_config -C client blob:none remote.origin.partialclonefilter &&
+	test_cmp_config -C client 1 core.repositoryformatversion
+'
+
+test_expect_success 'convert shallow clone to partial clone must fail with any extension' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	test_cmp_config -C client 0 core.repositoryformatversion &&
+	git -C client config extensions.partialclone origin &&
+	test_must_fail git -C client fetch --unshallow --filter="blob:none"
+'
+
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
 	rm -rf repo &&
 	test_create_repo repo &&
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 40cc004326..f35a73dd20 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -63,7 +63,6 @@ test_expect_success 'in partial clone, sparse checkout only fetches needed blobs
 	git -C server commit -m message &&
 
 	test_config -C client core.sparsecheckout 1 &&
-	test_config -C client extensions.partialclone origin &&
 	echo "!/*" >client/.git/info/sparse-checkout &&
 	echo "/a" >>client/.git/info/sparse-checkout &&
 	git -C client fetch --filter=blob:none origin &&
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 286121d8de..9536d10919 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -23,8 +23,10 @@ test_expect_success 'config --worktree without extension' '
 '
 
 test_expect_success 'enable worktreeConfig extension' '
+	git config core.repositoryformatversion 1 &&
 	git config extensions.worktreeConfig true &&
-	test_cmp_config true extensions.worktreeConfig
+	test_cmp_config true extensions.worktreeConfig &&
+	test_cmp_config 1 core.repositoryformatversion
 '
 
 test_expect_success 'config is shared as before' '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8c54e34ef1..0f5ff25179 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -999,7 +999,6 @@ fetch_filter_blob_limit_zero () {
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
 
 	git clone "$URL" client &&
-	test_config -C client extensions.partialclone origin &&
 
 	test_commit -C "$SERVER" two &&
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5039e66dc4..8b27fad6cd 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -348,7 +348,6 @@ test_expect_success 'partial fetch' '
 	rm -rf client "$(pwd)/trace" &&
 	git init client &&
 	SERVER="file://$(pwd)/server" &&
-	test_config -C client extensions.partialClone "$SERVER" &&
 
 	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
 		fetch --filter=blob:none "$SERVER" master:refs/heads/other &&
-- 
2.27.0.rc0.183.gde8f92d652-goog


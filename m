Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623991E5714
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940180; cv=none; b=M2/LRQtMWwYGLzjuXvr4+QdcQcxvPkB75qulCvUfLwmU3ZrxUWvd2aj/JEAQmyTKNHHPF7SfwB4GJz5ZX73W3mFFCp2SdNB0vvuH6lwg7DPynrHEnptJiYtIrS3bIG2zc+xLqzn195dbm1qePUS9GxHj0BfLCGbdHMgasgZPVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940180; c=relaxed/simple;
	bh=JToCAOZ9OJ8CJcgPuHUaJ4TXhYfBesWZqU3MWMa9AXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liF2b2HQ8pTmkZ6Goqoy9uWbrejpBz3FIcDkGDgbZW4ro2/pRjrvmFl406NcNaYRSDczZ8nfeoaUMPX+cWefmk7aoA/25p0FI+kfv9dXxKcnkGHBnVavuABugrXQdDJixv2cv07xEaWrMvyGMoMdyUVrQreZBPC+2AscVgyRqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MQDidB6x; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MQDidB6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940175;
	bh=JToCAOZ9OJ8CJcgPuHUaJ4TXhYfBesWZqU3MWMa9AXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=MQDidB6xvRhAok0IzafXBy7G2rEP6yp2ldTyc+e9E/fVslnzOh/9gmUgaZTB0A4eQ
	 B2Z7bYfsYsAQt7R0btja+3Mthtzq7jhx+Yx7sRkXBEh6GQ3m8Nbb1PSX2Q4KUloISY
	 OhctFVEMUxPHOt3wAFapcwauYrHLiCLrDPJRt2AdeWp9sxWjH3Yz1pZMTWlImNDGDD
	 At1nCTfLRrVKd5eT2+2v5rXj4awgV8AwgAIY3iJePD9Ibz55ajv84vWqFuFpq2xgIR
	 MbTZreAev8lrKzJjR8AP5bs88SngfUgDlmnevkp2qeGIunELMbc3E1v/OUvtzv0GUf
	 qQ+lxkx7QndjOSqOALS7Qnw7/okm4VDM0pkjmVajCn8SrIBLh3BDikENvZDxXgoiRe
	 HVnmbyoltGCK/4VtZjqXQn+e3iaWAvGVH2hkqfsPAH2tBX1DtfaabIdf4byK3H+DRy
	 BpzguN9NFM4FwUsxxDz+uc/nUnU8nNMnvcQVftWa3nNKB/mHWas
Received: from tapette.. (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 361B420194;
	Thu, 22 May 2025 18:56:15 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	pwodd,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 5/5] builtin/stash: provide a way to import stashes from a ref
Date: Thu, 22 May 2025 18:55:24 +0000
Message-ID: <20250522185524.18398-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have a way to export stashes to a ref, let's provide a way
to import them from such a ref back to the stash.  This works much the
way the export code does, except that we strip off the first parent
chain commit and then store each resulting commit back to the stash.

We don't clear the stash first and instead add the specified stashes to
the top of the stash.  This is because users may want to export just a
few stashes, such as to share a small amount of work in progress with a
colleague, and it would be undesirable for the receiving user to lose
all of their data.  For users who do want to replace the stash, it's
easy to do to: simply run "git stash clear" first.

We specifically rely on the fact that we'll produce identical stash
commits on both sides in our tests.  This provides a cheap,
straightforward check for our tests and also makes it easy for users to
see if they already have the same data in both repositories.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I'll need Phillip's sign-off for this patch.

 Documentation/git-stash.adoc |   7 ++
 builtin/stash.c              | 167 +++++++++++++++++++++++++++++++++++
 t/t3903-stash.sh             |  94 ++++++++++++++++++++
 3 files changed, 268 insertions(+)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index e8efd43ba4..f8193b712e 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -24,6 +24,7 @@ SYNOPSIS
 'git stash' create [<message>]
 'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
 'git stash' export (--print | --to-ref <ref>) [<stash>...]
+'git stash' import <commit>
 
 DESCRIPTION
 -----------
@@ -161,6 +162,12 @@ export ( --print | --to-ref <ref> ) [<stash>...]::
 	a chain of commits which can be transferred using the normal fetch and
 	push mechanisms, then imported using the `import` subcommand.
 
+import <commit>::
+
+	Import the specified stashes from the specified commit, which must have been
+	created by `export`, and add them to the list of stashes.  To replace the
+	existing stashes, use `clear` first.
+
 OPTIONS
 -------
 -a::
diff --git a/builtin/stash.c b/builtin/stash.c
index ca00663e36..59fcb461eb 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -61,6 +61,8 @@
 	N_("git stash create [<message>]")
 #define BUILTIN_STASH_EXPORT_USAGE \
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
+#define BUILTIN_STASH_IMPORT_USAGE \
+	N_("git stash import <commit>")
 #define BUILTIN_STASH_CLEAR_USAGE \
 	"git stash clear"
 
@@ -77,6 +79,7 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_CREATE_USAGE,
 	BUILTIN_STASH_STORE_USAGE,
 	BUILTIN_STASH_EXPORT_USAGE,
+	BUILTIN_STASH_IMPORT_USAGE,
 	NULL
 };
 
@@ -135,6 +138,10 @@ static const char * const git_stash_export_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_import_usage[] = {
+	BUILTIN_STASH_IMPORT_USAGE,
+	NULL
+};
 
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -144,6 +151,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
  * b_commit is set to the base commit
  * i_commit is set to the commit containing the index tree
  * u_commit is set to the commit containing the untracked files tree
+ * c_commit is set to the first parent (chain commit) when importing and is otherwise unset
  * w_tree is set to the working tree
  * b_tree is set to the base tree
  * i_tree is set to the index tree
@@ -154,6 +162,7 @@ struct stash_info {
 	struct object_id b_commit;
 	struct object_id i_commit;
 	struct object_id u_commit;
+	struct object_id c_commit;
 	struct object_id w_tree;
 	struct object_id b_tree;
 	struct object_id i_tree;
@@ -1992,6 +2001,163 @@ static int write_commit_with_parents(struct repository *r,
 	return ret;
 }
 
+static int do_import_stash(struct repository *r, const char *rev)
+{
+	struct object_id chain;
+	struct oid_array items = OID_ARRAY_INIT;
+	int res = 0;
+	ssize_t i;
+	const char *buffer = NULL;
+	unsigned long bufsize;
+	struct commit *this = NULL;
+	char *msg = NULL;
+
+	if (repo_get_oid(r, rev, &chain))
+		return error(_("not a valid revision: %s"), rev);
+
+	this = lookup_commit_reference(r, &chain);
+	if (!this)
+		return error(_("not a commit: %s"), rev);
+
+	/*
+	 * Walk the commit history, finding each stash entry, and load data into
+	 * the array.
+	 */
+	for (;;) {
+		const char *author, *committer;
+		size_t author_len, committer_len;
+		const char *p;
+		const char *expected = "git stash <git@stash> 1000684800 +0000";
+		const char *prefix = "git stash: ";
+		struct commit *stash;
+		struct tree *tree = repo_get_commit_tree(r, this);
+
+		if (!tree ||
+		    !oideq(&tree->object.oid, r->hash_algo->empty_tree) ||
+		    (this->parents &&
+		     (!this->parents->next || this->parents->next->next))) {
+			res = error(_("%s is not a valid exported stash commit"),
+					oid_to_hex(&this->object.oid));
+			goto out;
+		}
+
+		buffer = repo_get_commit_buffer(r, this, &bufsize);
+
+		if (!this->parents) {
+			/*
+			 * We don't have any parents.  Make sure this is our
+			 * root commit.
+			 */
+			author = find_commit_header(buffer, "author", &author_len);
+			committer = find_commit_header(buffer, "committer", &committer_len);
+
+			if (!author || !committer) {
+				error(_("cannot parse commit %s"), oid_to_hex(&this->object.oid));
+				goto out;
+			}
+
+			if (author_len != strlen(expected) ||
+			    committer_len != strlen(expected) ||
+			    memcmp(author, expected, author_len) ||
+			    memcmp(committer, expected, committer_len)) {
+				res = error(_("found root commit %s with invalid data"), oid_to_hex(&this->object.oid));
+				goto out;
+			}
+			break;
+		}
+
+		p = strstr(buffer, "\n\n");
+		if (!p) {
+			res = error(_("cannot parse commit %s"), oid_to_hex(&this->object.oid));
+			goto out;
+		}
+
+		p += 2;
+		if (((size_t)(bufsize - (p - buffer)) < strlen(prefix)) ||
+		    memcmp(prefix, p, strlen(prefix))) {
+			res = error(_("found stash commit %s with unexpected prefix"), oid_to_hex(&this->object.oid));
+			goto out;
+		}
+
+		stash = this->parents->next->item;
+
+		if (repo_parse_commit(r, this->parents->item) ||
+		    repo_parse_commit(r, stash)) {
+			res = error(_("cannot parse parents of commit: %s"),
+					oid_to_hex(&this->object.oid));
+			goto out;
+		}
+
+		if (check_stash_topology(r, stash)) {
+			res = error(_("%s does not look like a stash commit"),
+					oid_to_hex(&stash->object.oid));
+			goto out;
+		}
+
+		repo_unuse_commit_buffer(r, this, buffer);
+		buffer = NULL;
+		oid_array_append(&items, &stash->object.oid);
+		this = this->parents->item;
+	}
+
+	/*
+	 * Now, walk each entry, adding it to the stash as a normal stash
+	 * commit.
+	 */
+	for (i = (ssize_t)items.nr - 1; i >= 0; i--) {
+		const char *p;
+		const struct object_id *oid = items.oid + i;
+
+		this = lookup_commit_reference(r, oid);
+		buffer = repo_get_commit_buffer(r, this, &bufsize);
+		if (!buffer) {
+			res = error(_("cannot read commit buffer for %s"), oid_to_hex(oid));
+			goto out;
+		}
+
+		p = strstr(buffer, "\n\n");
+		if (!p) {
+			res = error(_("cannot parse commit %s"), oid_to_hex(oid));
+			goto out;
+		}
+
+		p += 2;
+		msg = xmemdupz(p, bufsize - (p - buffer));
+		repo_unuse_commit_buffer(r, this, buffer);
+		buffer = NULL;
+
+		if (do_store_stash(oid, msg, 1)) {
+			res = error(_("cannot save the stash for %s"), oid_to_hex(oid));
+			goto out;
+		}
+		FREE_AND_NULL(msg);
+	}
+out:
+	if (this && buffer)
+		repo_unuse_commit_buffer(r, this, buffer);
+	oid_array_clear(&items);
+	free(msg);
+
+	return res;
+}
+
+static int import_stash(int argc, const char **argv, const char *prefix,
+			struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_import_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc != 1)
+		usage_msg_opt("a revision is required", git_stash_import_usage, options);
+
+	return do_import_stash(repo, argv[0]);
+}
+
 static int do_export_stash(struct repository *r,
 			   const char *ref,
 			   int argc,
@@ -2165,6 +2331,7 @@ int cmd_stash(int argc,
 		OPT_SUBCOMMAND("create", &fn, create_stash),
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
 		OPT_SUBCOMMAND("export", &fn, export_stash),
+		OPT_SUBCOMMAND("import", &fn, import_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..c827709468 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-unique-files.sh
 
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	export_base sha1:73c9bab443d1f88ac61aa533d2eeaaa15451239c
+	export_base sha256:f210fa6346e3e2ce047bdb570426b17075980c1ac01fec8fc4b75bd3ab4bcfe4
+	EOF
+'
+
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
 	grep "or: git stash" usage &&
@@ -1412,6 +1419,93 @@ test_expect_success 'stash --keep-index --include-untracked with empty tree' '
 	)
 '
 
+test_expect_success 'stash export and import round-trip stashes' '
+	git reset &&
+	>untracked &&
+	>tracked1 &&
+	>tracked2 &&
+	git add tracked* &&
+	git stash -- &&
+	>subdir/untracked &&
+	>subdir/tracked1 &&
+	>subdir/tracked2 &&
+	git add subdir/tracked* &&
+	git stash --include-untracked -- subdir/ &&
+	git tag t-stash0 stash@{0} &&
+	git tag t-stash1 stash@{1} &&
+	simple=$(git stash export --print) &&
+	git stash clear &&
+	git stash import "$simple" &&
+	test_cmp_rev stash@{0} t-stash0 &&
+	test_cmp_rev stash@{1} t-stash1 &&
+	git stash export --to-ref refs/heads/foo &&
+	test_cmp_rev "$(test_oid empty_tree)" foo: &&
+	test_cmp_rev "$(test_oid empty_tree)" foo^: &&
+	test_cmp_rev t-stash0 foo^2 &&
+	test_cmp_rev t-stash1 foo^^2 &&
+	git log --first-parent --format="%s" refs/heads/foo >log &&
+	grep "^git stash: " log >log2 &&
+	test_line_count = 13 log2 &&
+	git stash clear &&
+	git stash import foo &&
+	test_cmp_rev stash@{0} t-stash0 &&
+	test_cmp_rev stash@{1} t-stash1
+'
+
+test_expect_success 'stash import appends commits' '
+	git log --format=oneline -g refs/stash >out &&
+	cat out out >out2 &&
+	git stash import refs/heads/foo &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = $(wc -l <out2) actual
+'
+
+test_expect_success 'stash export can accept specified stashes' '
+	git stash clear &&
+	git stash import foo &&
+	git stash export --to-ref refs/heads/bar stash@{1} stash@{0} &&
+	git stash clear &&
+	git stash import refs/heads/bar &&
+	test_cmp_rev stash@{1} t-stash0 &&
+	test_cmp_rev stash@{0} t-stash1 &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = 2 actual
+'
+
+test_expect_success 'stash can import and export zero stashes' '
+	git stash clear &&
+	git stash export --to-ref refs/heads/baz &&
+	test_cmp_rev "$(test_oid empty_tree)" baz: &&
+	test_cmp_rev "$(test_oid export_base)" baz &&
+	test_must_fail git rev-parse baz^1 &&
+	git stash import baz &&
+	test_must_fail git rev-parse refs/stash
+'
+
+test_expect_success 'stash rejects invalid attempts to import commits' '
+	git stash import foo &&
+	test_must_fail git stash import HEAD 2>output &&
+	oid=$(git rev-parse HEAD) &&
+	grep "$oid is not a valid exported stash commit" output &&
+	test_cmp_rev stash@{0} t-stash0 &&
+
+	git checkout --orphan orphan &&
+	git commit-tree $(test_oid empty_tree) -p "$oid" -p "$oid^" -m "" >fake-commit &&
+	git update-ref refs/heads/orphan "$(cat fake-commit)" &&
+	oid=$(git rev-parse HEAD) &&
+	test_must_fail git stash import orphan 2>output &&
+	grep "found stash commit $oid with unexpected prefix" output &&
+	test_cmp_rev stash@{0} t-stash0 &&
+
+	git checkout --orphan orphan2 &&
+	git commit-tree $(test_oid empty_tree) -m "" >fake-commit &&
+	git update-ref refs/heads/orphan2 "$(cat fake-commit)" &&
+	oid=$(git rev-parse HEAD) &&
+	test_must_fail git stash import orphan2 2>output &&
+	grep "found root commit $oid with invalid data" output &&
+	test_cmp_rev stash@{0} t-stash0
+'
+
 test_expect_success 'stash apply should succeed with unmodified file' '
 	echo base >file &&
 	git add file &&

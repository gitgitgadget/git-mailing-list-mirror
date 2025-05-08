Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D52343AE
	for <git@vger.kernel.org>; Thu,  8 May 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747914; cv=none; b=MJp2YIMZibMg0vKcc5/O5n9xxgKNSgTjwka4gnGl7sVOFm4MN7bOU//dpJ4PXbb3ZiFS+ngfS7K+YQwBfWeWWMrMa/eMpk1VGLIap+Spi8Gu2b3L6PvvNEU1crbiYPKQhau1rSjHbnEGhOpDa3eUBboJDW+NZWDXbqJsS9vEPZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747914; c=relaxed/simple;
	bh=v9upjHm1Ukn4H9lo0vqyeScww77spoGOvuw3YEHXras=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCWunX82IGF9gY1vE0z66xOUyWqGmQIdVqp+rEP96fEJt4cne3KQh6Mgtr3vP3hxZNhgwsaD4ZXIT03yCmxPcq/VRdlZs6AJRjkaFpeLy6LfWdYcjgPCGlDgTFPO6jsiY2ozYOS/2HKjc7ZveJIXfb6NFEJSHSXXPq3X3GcRkns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=J5ig1xNv; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J5ig1xNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746747904;
	bh=v9upjHm1Ukn4H9lo0vqyeScww77spoGOvuw3YEHXras=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=J5ig1xNvW6y0Ln/XAEvTvYOAea+t1C6T40EfjJ2IHfl6S0TwQ275jZJ+OWDIX+yQn
	 CeTm4TU8j3YdEBWN+Og/lvNZmRB/urH/g9talQBdUzZdM0kbsz6tvnt6RcG4hY/P4x
	 KJBxtnpF5qKWclWDFmBFhJLvxglRMQr0Rxac8ybTjd+LZpqTgZWnTADkRmT/BPVu4H
	 PKVm/5usCuBcnXyxG1mM4NwhhhBzvzfkBEWqUlaUHD8qOpUKBINVJvKjRnJVIsIK5p
	 dFcvv5xddzNLvlvBhARHliVl/FCG7/OxHAoalHPirsg+QMsFkFYO+gu0Tr1zLxmDCr
	 46PKcx9ucx1EBphcRLAEZyfnxHnqQvPCpBGBXdH5jWAMd3+o2zlWlLApAXaGabOicT
	 WcyIkb3QUS/kIXOeCqTD7U49LXz+/0OhPbTWxyBkWU7h08jLM8u8gbn6C96qqNnq9K
	 bIQ1BwpMSaaaiZ6ncHDk55DcRZRL2hVTYAumfg5dYv301iLFtbD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 10F4A2012A;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 4/4] builtin/stash: provide a way to import stashes from a ref
Date: Thu,  8 May 2025 23:44:57 +0000
Message-ID: <20250508234458.3665894-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
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
 Documentation/git-stash.adoc |   7 +++
 builtin/stash.c              | 103 +++++++++++++++++++++++++++++++++++
 t/t3903-stash.sh             |  78 ++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

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
index 4a42126d02..d8332af401 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -60,6 +60,8 @@
 	N_("git stash create [<message>]")
 #define BUILTIN_STASH_EXPORT_USAGE \
 	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
+#define BUILTIN_STASH_IMPORT_USAGE \
+	N_("git stash import <commit>")
 #define BUILTIN_STASH_CLEAR_USAGE \
 	"git stash clear"
 
@@ -76,6 +78,7 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_CREATE_USAGE,
 	BUILTIN_STASH_STORE_USAGE,
 	BUILTIN_STASH_EXPORT_USAGE,
+	BUILTIN_STASH_IMPORT_USAGE,
 	NULL
 };
 
@@ -134,6 +137,10 @@ static const char * const git_stash_export_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_import_usage[] = {
+	BUILTIN_STASH_IMPORT_USAGE,
+	NULL
+};
 
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
@@ -143,6 +150,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
  * b_commit is set to the base commit
  * i_commit is set to the commit containing the index tree
  * u_commit is set to the commit containing the untracked files tree
+ * c_commit is set to the first parent (chain commit) when importing and is otherwise unset
  * w_tree is set to the working tree
  * b_tree is set to the base tree
  * i_tree is set to the index tree
@@ -153,6 +161,7 @@ struct stash_info {
 	struct object_id b_commit;
 	struct object_id i_commit;
 	struct object_id u_commit;
+	struct object_id c_commit;
 	struct object_id w_tree;
 	struct object_id b_tree;
 	struct object_id i_tree;
@@ -1962,6 +1971,99 @@ static int write_commit_with_parents(struct repository *r,
 	return ret;
 }
 
+static int do_import_stash(struct repository *r, const char *rev)
+{
+	struct object_id chain;
+	struct oid_array items = OID_ARRAY_INIT;
+	int res = 0;
+	int i;
+	const char *buffer = NULL;
+	struct commit *this = NULL;
+	char *msg = NULL;
+
+	if (repo_get_oid(r, rev, &chain))
+		return error(_("not a valid revision: %s"), rev);
+
+	/*
+	 * Walk the commit history, finding each stash entry, and load data into
+	 * the array.
+	 */
+	for (i = 0;; i++) {
+		struct object_id tree, oid;
+		char revision[GIT_MAX_HEXSZ + 1];
+
+		oid_to_hex_r(revision, &chain);
+
+		if (get_oidf(&tree, "%s:", revision) ||
+		    !oideq(&tree, r->hash_algo->empty_tree)) {
+			res = error(_("%s is not a valid exported stash commit"), revision);
+			goto out;
+		}
+		if (get_oidf(&chain, "%s^1", revision) ||
+		    get_oidf(&oid, "%s^2", revision))
+			break;
+		oid_array_append(&items, &oid);
+	}
+
+	/*
+	 * Now, walk each entry, adding it to the stash as a normal stash
+	 * commit.
+	 */
+	for (i = items.nr - 1; i >= 0; i--) {
+		unsigned long bufsize;
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
@@ -2118,6 +2220,7 @@ int cmd_stash(int argc,
 		OPT_SUBCOMMAND("create", &fn, create_stash),
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
 		OPT_SUBCOMMAND("export", &fn, export_stash),
+		OPT_SUBCOMMAND("import", &fn, import_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 74666ff3e4..2ab9e5d848 100755
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
@@ -1412,6 +1419,77 @@ test_expect_success 'stash --keep-index --include-untracked with empty tree' '
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
+	git stash export --to-ref bar stash@{1} stash@{0} &&
+	git stash clear &&
+	git stash import bar &&
+	test_cmp_rev stash@{1} t-stash0 &&
+	test_cmp_rev stash@{0} t-stash1 &&
+	git log --format=oneline -g refs/stash >actual &&
+	test_line_count = 2 actual
+'
+
+test_expect_success 'stash can import and export zero stashes' '
+	git stash clear &&
+	git stash export --to-ref baz &&
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
+	test_cmp_rev stash@{0} t-stash0
+'
+
 test_expect_success 'stash apply should succeed with unmodified file' '
 	echo base >file &&
 	git add file &&

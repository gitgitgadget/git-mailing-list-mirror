Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15141C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCXW1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCXW1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:27:20 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E7A15148
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1679696831; i=l.s.r@web.de;
        bh=dd1FEp5JIhQkZbFIOD1ySJo0GbJGVRDLgqDghJlwPcY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=oqiilQqm+f2acwMuhDGPP/bUqIC2gx6oPpd9DKk4zLothQs4Y3X0mgSrtYxewBU0W
         Fm5lbVG2yJihPE2NWJfuU2Q0qDth+KJPJXXxwZdRrIGZwWGeimcWqWIHad+SoE630u
         0/hae1z6f8biiFpyXagXpBPz47FoJ443rEhRrXzswPSSgnNBzg0dQyik2aih+4tRX2
         3kRVKarQOI4d/3/9tclT7JJUaXU/sIkS6mmIuAeACN0tjw9IMJLrNlPzL/aWeFL/gh
         UMdJfQprfcnGaOQhNF/e7uRT8NVWBZK0VU0+1Nz0ghuPeUOdlAB23l6kTMjxFG2vtP
         M38xAYs7lf1IA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MI3tF-1piqOu31ol-00FEOp; Fri, 24
 Mar 2023 23:27:11 +0100
Message-ID: <7c33b01b-7b2a-25fa-9a66-1e65cd12bc84@web.de>
Date:   Fri, 24 Mar 2023 23:27:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: [PATCH v2] archive: improve support for running in subdirectory
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>,
        =?UTF-8?Q?Matthias_G=c3=b6rgens?= <matthias.goergens@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqcz5lbxiq.fsf@gitster.g>
 <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de> <xmqqo7p59049.fsf@gitster.g>
 <3da35216-ca42-9759-d4f9-20451a44c231@web.de> <xmqq4jqx8q6q.fsf@gitster.g>
 <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de> <xmqqjzzly84q.fsf@gitster.g>
 <9e215e5c-0b67-0362-fd53-8c22b8d348ff@web.de>
 <e923e844-6891-76dc-e7db-4771b2d91792@web.de>
Content-Language: en-US
In-Reply-To: <e923e844-6891-76dc-e7db-4771b2d91792@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RcdNAUKq2h0kJFptuDEqcFiaXUu6Cuh/IvbrBi39enGCSKznzHk
 7jWZ0CWD51+savO5IKZFDdeKa9ATRbK26wJ6Jf4JKs1is6LD40ckhehUokCvwztRkpRfH7T
 01XMG32tzZiyw+KaHFWKxJoyDkIIWamyfsc3iaSeVmx0wc4oLiYdsZZsUuHk59Yg2yts3ij
 pCp51xQI4jPNfVjfJyjhw==
UI-OutboundReport: notjunk:1;M01:P0:xBRE1+ietrE=;Y3c0erxQKY1de90r6g1Sgu3hCL2
 jdswp2RukjvB7nRDwZGrkqjJbaxOW5mBQFhbsw28hYhJi0ty8+99u89b/v+SZOZB11Vrr6U7Z
 Lx3mYdqyEnCM4Qwsx3m8w0nCqna4e5CUpMFjHUUKG1Y9j8YbN9HTr5b3zoxUxAtFjGZPhBlvM
 L8Wyhxv8R2W8ycEG1W5ukOw/MW1sPdLLfnQTECWM4BmlJlRftEdxyZRmNb3E6ktPC1jcsGp5u
 6UDkBiwFqNH97WFA3FhY9Kre0reQJSaA8omw10jCBb1tZCcgUSs5Zq76hYn/jqZzjcFiybIo2
 Lg6fn2VXp6kOT9vlspgafp5MMJdjWsMiOTnjHNAJHj/7Z6CX22MYivl4mi4+0U1HN72KGNl+0
 PpPHacheTynG5eYLNB5FlVtNE+jBapcpA6Q/7uQzldsA2hP5Bchft/DVpDnKN680DWREYedHm
 fE0hONsJWeVqpBjb10a65jweALiTfY1SGFEEjSzE5/vWGZkQ396hPQ4qNLS+pB5v0vYI1Ptt6
 zmfTvH7dRL9uYTgMFKtNIk0pUuS2OtKxGByZtxSnPAksqZ/VQmcOy83q4MeUGhKwVwwF9rT3q
 lxX0jVkCt59uBG0isMd9RnF0u+a6ZzXnV7zv9JFZxuWldG7s6JtZP/SJz5iZyruWPZHdkMnov
 KA6fA4ZHDhf38kv4piuycSO++ZYjYsx61f6Ft6oayw9oVWZD6LfXmCHewV4L2cCeA/Z8Z53Rd
 BFDJZay/rE+ISDFtDKGNpOc6D9CWpz3SEPIrjin9JbbnfnKTyjYd5/5FnI80JoABQw55FYDIh
 fLexRJvjhVGwupa/GsyhsUPAA8Tw/s39o7H7Rb5p9bZIuRNs1FmoNuuBCbxuUKrhA1dQXy0sE
 O45DRwUngEYlB8n1+RWbTTfwgfsQh0D7AAKDln2ZiOzWNHfBjVMOcbvQ3QPFNajwI1IJMTzA2
 jGgIhz9fu+IObTh1J0fAyQiQkQw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git archive is started in a subdirectory, it archives its
corresponding tree and its child objects, only.  That is intended.  It
does that by effectively cd'ing into that tree and setting "prefix" to
the empty string.

This has unfortunate consequences, though: Attributes are anchored at
the root of the repository and git archive still applies them to
subtrees, causing mismatches.  And when checking pathspecs it cannot
tell the difference between one that doesn't match anthing or one that
matches some actual blob outside of the subdirectory, leading to a
confusing error message.

Fix that by keeping the "prefix" value and passing it to pathspec and
attribute functions, and shortening it using relative_path() for paths
written to the archive and (if --verbose is given) to stdout.

Still reject attempts to archive files outside the current directory,
but print a more specific error in that case.  Recognizing it requires a
full traversal of the subtree for each pathspec, however.  Allowing them
would be easier, but archive entry paths starting with "../" can be
problematic to extract -- e.g. bsdtar skips them by default.

Reported-by: Cristian Le <cristian.le@mpsd.mpg.de>
Reported-by: Matthias G=C3=B6rgens <matthias.goergens@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Interdiff:
  diff --git a/archive.c b/archive.c
  index c8d66169d1..a61615d180 100644
  --- a/archive.c
  +++ b/archive.c
  @@ -169,6 +169,7 @@ static int write_archive_entry(const struct object_i=
d *oid, const char *base,
   	}

   	if (args->prefix) {
  +		static struct strbuf new_path =3D STRBUF_INIT;
   		static struct strbuf buf =3D STRBUF_INIT;
   		const char *rel;

  @@ -183,8 +184,11 @@ static int write_archive_entry(const struct object_=
id *oid, const char *base,
   		if (!strcmp(rel, "./") || starts_with(rel, "../"))
   			return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;

  -		strbuf_setlen(&path, args->baselen);
  -		strbuf_addstr(&path, rel);
  +		/* rel can refer to path, so don't edit it in place */
  +		strbuf_reset(&new_path);
  +		strbuf_add(&new_path, args->base, args->baselen);
  +		strbuf_addstr(&new_path, rel);
  +		strbuf_swap(&path, &new_path);
   	}

   	if (args->verbose)

 archive.c               | 75 +++++++++++++++++++++++++++++------------
 t/t5000-tar-tree.sh     | 13 +++++++
 t/t5001-archive-attr.sh | 16 +++++++++
 3 files changed, 83 insertions(+), 21 deletions(-)

diff --git a/archive.c b/archive.c
index 1c2ca78e52..a61615d180 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -168,6 +168,29 @@ static int write_archive_entry(const struct object_id=
 *oid, const char *base,
 		args->convert =3D check_attr_export_subst(check);
 	}

+	if (args->prefix) {
+		static struct strbuf new_path =3D STRBUF_INIT;
+		static struct strbuf buf =3D STRBUF_INIT;
+		const char *rel;
+
+		rel =3D relative_path(path_without_prefix, args->prefix, &buf);
+
+		/*
+		 * We don't add an entry for the current working
+		 * directory when we are at the root; skip it also when
+		 * we're in a subdirectory or submodule.  Skip entries
+		 * higher up as well.
+		 */
+		if (!strcmp(rel, "./") || starts_with(rel, "../"))
+			return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;
+
+		/* rel can refer to path, so don't edit it in place */
+		strbuf_reset(&new_path);
+		strbuf_add(&new_path, args->base, args->baselen);
+		strbuf_addstr(&new_path, rel);
+		strbuf_swap(&path, &new_path);
+	}
+
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);

@@ -403,6 +426,27 @@ static int reject_entry(const struct object_id *oid U=
NUSED,
 	return ret;
 }

+static int reject_outside(const struct object_id *oid UNUSED,
+			  struct strbuf *base, const char *filename,
+			  unsigned mode, void *context)
+{
+	struct archiver_args *args =3D context;
+	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	int ret =3D 0;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	strbuf_addbuf(&path, base);
+	strbuf_addstr(&path, filename);
+	if (starts_with(relative_path(path.buf, args->prefix, &buf), "../"))
+		ret =3D -1;
+	strbuf_release(&buf);
+	strbuf_release(&path);
+	return ret;
+}
+
 static int path_exists(struct archiver_args *args, const char *path)
 {
 	const char *paths[] =3D { path, NULL };
@@ -410,8 +454,13 @@ static int path_exists(struct archiver_args *args, co=
nst char *path)
 	int ret;

 	ctx.args =3D args;
-	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
+	parse_pathspec(&ctx.pathspec, 0, PATHSPEC_PREFER_CWD,
+		       args->prefix, paths);
 	ctx.pathspec.recursive =3D 1;
+	if (args->prefix && read_tree(args->repo, args->tree, &ctx.pathspec,
+				      reject_outside, args))
+		die(_("pathspec '%s' matches files outside the "
+		      "current directory"), path);
 	ret =3D read_tree(args->repo, args->tree,
 			&ctx.pathspec,
 			reject_entry, &ctx);
@@ -427,9 +476,8 @@ static void parse_pathspec_arg(const char **pathspec,
 	 * Also if pathspec patterns are dependent, we're in big
 	 * trouble as we test each one separately
 	 */
-	parse_pathspec(&ar_args->pathspec, 0,
-		       PATHSPEC_PREFER_FULL,
-		       "", pathspec);
+	parse_pathspec(&ar_args->pathspec, 0, PATHSPEC_PREFER_CWD,
+		       ar_args->prefix, pathspec);
 	ar_args->pathspec.recursive =3D 1;
 	if (pathspec) {
 		while (*pathspec) {
@@ -441,8 +489,7 @@ static void parse_pathspec_arg(const char **pathspec,
 }

 static void parse_treeish_arg(const char **argv,
-		struct archiver_args *ar_args, const char *prefix,
-		int remote)
+			      struct archiver_args *ar_args, int remote)
 {
 	const char *name =3D argv[0];
 	const struct object_id *commit_oid;
@@ -481,20 +528,6 @@ static void parse_treeish_arg(const char **argv,
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));

-	if (prefix) {
-		struct object_id tree_oid;
-		unsigned short mode;
-		int err;
-
-		err =3D get_tree_entry(ar_args->repo,
-				     &tree->object.oid,
-				     prefix, &tree_oid,
-				     &mode);
-		if (err || !S_ISDIR(mode))
-			die(_("current working directory is untracked"));
-
-		tree =3D parse_tree_indirect(&tree_oid);
-	}
 	ar_args->refname =3D ref;
 	ar_args->tree =3D tree;
 	ar_args->commit_oid =3D commit_oid;
@@ -712,7 +745,7 @@ int write_archive(int argc, const char **argv, const c=
har *prefix,
 		setup_git_directory();
 	}

-	parse_treeish_arg(argv, &args, prefix, remote);
+	parse_treeish_arg(argv, &args, remote);
 	parse_pathspec_arg(argv + 1, &args);

 	rc =3D ar->write_archive(ar, &args);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 918a2fc7c6..a60ae6145e 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -433,6 +433,19 @@ test_expect_success 'catch non-matching pathspec' '
 	test_must_fail git archive -v HEAD -- "*.abc" >/dev/null
 '

+test_expect_success 'reject paths outside the current directory' '
+	test_must_fail git -C a/bin archive HEAD .. >/dev/null 2>err &&
+	grep "outside the current directory" err
+'
+
+test_expect_success 'allow pathspecs that resolve to the current director=
y' '
+	git -C a/bin archive -v HEAD ../bin >/dev/null 2>actual &&
+	cat >expect <<-\EOF &&
+	sh
+	EOF
+	test_cmp expect actual
+'
+
 # Pull the size and date of each entry in a tarfile using the system tar.
 #
 # We'll pull out only the year from the date; that avoids any question of
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 04d300eeda..0ff47a239d 100755
=2D-- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -33,6 +33,13 @@ test_expect_success 'setup' '
 	echo ignored-by-tree.d export-ignore >>.gitattributes &&
 	git add ignored-by-tree ignored-by-tree.d .gitattributes &&

+	mkdir subdir &&
+	>subdir/included &&
+	>subdir/ignored-by-subtree &&
+	>subdir/ignored-by-tree &&
+	echo ignored-by-subtree export-ignore >subdir/.gitattributes &&
+	git add subdir &&
+
 	echo ignored by worktree >ignored-by-worktree &&
 	echo ignored-by-worktree export-ignore >.gitattributes &&
 	git add ignored-by-worktree &&
@@ -93,6 +100,15 @@ test_expect_exists	archive-pathspec-wildcard/ignored-b=
y-worktree
 test_expect_missing	archive-pathspec-wildcard/excluded-by-pathspec.d
 test_expect_missing	archive-pathspec-wildcard/excluded-by-pathspec.d/file

+test_expect_success 'git -C subdir archive' '
+	git -C subdir archive HEAD >archive-subdir.tar &&
+	extract_tar_to_dir archive-subdir
+'
+
+test_expect_exists	archive-subdir/included
+test_expect_missing	archive-subdir/ignored-by-subtree
+test_expect_missing	archive-subdir/ignored-by-tree
+
 test_expect_success 'git archive with worktree attributes' '
 	git archive --worktree-attributes HEAD >worktree.tar &&
 	(mkdir worktree && cd worktree && "$TAR" xf -) <worktree.tar
=2D-
2.40.0


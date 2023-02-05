Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C644C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjBEUrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 15:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUrO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 15:47:14 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92920DBED
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 12:47:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q19so9890472edd.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5H74UX9FUNHYy14UCzkRJUyL0ZXTSMqFufgwA0NBWc=;
        b=HBEnwylXc808IKodtiOEmv+A27V+5Tk9uSEs40TxgR+K8jemS1948jQKDn8k3q22Wr
         ySn9hKphmyH+9HFcgiWyOm6Z7KoHY385zEb7ABDqby/2MVaAaRYNsqAMigIozyI+Z5Ho
         97mJiqtIe2rpODF4kNfparsLNbYvNaZYJe4gF6mRBcnfMyA9tBoAYp8QRb0XmhlzpD5w
         K4tZKVE7qM6fZ+CxRZta8mMUX9B4tsqKTPWIVaBt1XJFx90l/dizm6W5KMyZiyjMAamo
         1cl43h54rwUxNy1+spm71R0OeA9lq3usfV28LY06yKWKjc2Svu1xO4u9MEqLUHkNVHME
         Jaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5H74UX9FUNHYy14UCzkRJUyL0ZXTSMqFufgwA0NBWc=;
        b=1FXG8kuavJJaC6ODwd9cC95xlfAhdMOHWRlN4/1yVkhw2ZcVDHQrNx1Igzkfpsa3MM
         P3x8zV5EX/j7dDWe8S18zWwlHwRi7cmhALEA9glncCzKzeNHHfHMTKnT9HjhKdIr18me
         l+NDcm4QhcS+ys/hjETjGHtxSZxEzGrhiOuUzpXjV+VYhg4HD4xwRPy7SZoDisz0zegh
         I0t7Q8XnLVvugVbSJ3yeboMzHmQVnh5KX6jbFgTBtQxzTFSa75Yp1q7PwuGoHLjL57tl
         FGOkF4ytq1qY9CRrTdm6MpC6uM0J8tJ8d/U4/03/JP6f0QlKjv1eDYpl4/cNaUl1ZOlg
         lDYQ==
X-Gm-Message-State: AO0yUKWKCP0qpztnryChHzOWqBNWA/ECtU5Im74K73KkL5vLNXthEMDs
        qzKwc5v322H/kl5BIB+iM0Z+UhFnF+HIjjvt
X-Google-Smtp-Source: AK7set/h2tIaYh60J26Qa6Irc0psCdfZtpdhr/sNwLxutGLHsklh7WWsAbN/jFmO+ro0q8Qb+ndsmg==
X-Received: by 2002:a50:d081:0:b0:4aa:a4dd:aab2 with SMTP id v1-20020a50d081000000b004aaa4ddaab2mr5638089edd.11.1675630028239;
        Sun, 05 Feb 2023 12:47:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e14-20020a056402190e00b0045ce419ecffsm4236047edz.58.2023.02.05.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 12:47:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] blame-tree: add library and tests via "test-tool blame-tree"
Date:   Sun,  5 Feb 2023 21:47:03 +0100
Message-Id: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1398.g1368d6f56cf
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The "blame-tree" library allows for finding the most recent
modification to paths in a tree. It does so by expanding the tree at a
given commit, taking note of the current state of each path, and then
walking backwards through history looking for commits where each path
changed into its final sha1.

The "git blame-tree" command was first noted on the ML 2011[1], and
over the years there have been mentions of it[2][3], and whether it
could be upstreamed. The sources have been available at [4]'s
"jk/blame-tree-wip" and "jk/faster-blame-tree-wip" branches.

This change attempts to start upstreaming this command, but rather
than adding a command whose interface & semantics may be controversial
starts by exposing & testing the core of its library through a new
test helper.

An eventual "git blame-tree" command, or e.g. a new format for "git
ls-tree" to show what a path "blames" to can then be implemented with
this library.

Aside from changing the code found at [4] into a test-tool the most
notable changes here are:

* Removing the "--max-depth" changes to the diff code. We'll need
  those eventually, but it's not required for a blame of a given list
  of paths.

  As has been noted in previous on-list discussions the semantics of
  the "max-depth" changes might be controversial, so it's worthwhile
  to split those out so that they can be reviewed separately.

* Made the "blame-tree" helper take "--" before any revision options,
  for clarity. An eventual built-in command (if any) probably doesn't
  want to enforce this, but it makes it clearer in the test helper
  what's an argument for "blame-tree" itself, and what's an argument for
  the revision machinery.

* Minor updates for using C99 syntax, and "size_t" instead of "int"
  when we're iterating over types whose "nr" is that size.

* Avoid sub-shelling in the tests, use "test-tool -C .." instead.

1. https://lore.kernel.org/git/20110302164031.GA18233@sigill.intra.peff.net/
2. https://lore.kernel.org/git/20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net/
3. https://public-inbox.org/git/20130318121243.GC14789@sigill.intra.peff.net/
4. https://github.com/peff/git/
4. https://gitlab.com/gitlab-org/git/-/issues/114

Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

The range-diff here is to peff's jk/blame-tree-wip. As noted above
this is far from the full thing, but hopefully getting the basic bits
of the library (sans the max-depth question) will make the review of
subsequent bits easier.

CI & branch for this at:
https://github.com/avar/git/tree/avar-jk/blame-tree-prep

Range-diff:
1:  65cfa9c91cd < -:  ----------- within_depth: fix return for empty path
2:  fa5f0c6dbec < -:  ----------- teach tree-diff a max-depth parameter
3:  c632d45c474 < -:  ----------- combine-diff: zero memory used for callback filepairs
4:  259e04af942 ! 1:  0ea849d900b add blame-tree command [ci skip]
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    add blame-tree command [ci skip]
    +    blame-tree: add library and tests via "test-tool blame-tree"
     
    -    This command shows the most recent modification to paths in
    -    a tree. It does so by expanding the tree at a given commit,
    -    taking note of the current state of each path, and then
    -    walking backwards through history looking for commits where
    -    each path changed into its final sha1.
    +    The "blame-tree" library allows for finding the most recent
    +    modification to paths in a tree. It does so by expanding the tree at a
    +    given commit, taking note of the current state of each path, and then
    +    walking backwards through history looking for commits where each path
    +    changed into its final sha1.
     
    -    Signed-off-by: Jeff King <peff@peff.net>
    +    The "git blame-tree" command was first noted on the ML 2011[1], and
    +    over the years there have been mentions of it[2][3], and whether it
    +    could be upstreamed. The sources have been available at [4]'s
    +    "jk/blame-tree-wip" and "jk/faster-blame-tree-wip" branches.
     
    - ## .gitignore ##
    -@@
    - /git-archive
    - /git-bisect
    - /git-blame
    -+/git-blame-tree
    - /git-branch
    - /git-bugreport
    - /git-bundle
    +    This change attempts to start upstreaming this command, but rather
    +    than adding a command whose interface & semantics may be controversial
    +    starts by exposing & testing the core of its library through a new
    +    test helper.
    +
    +    An eventual "git blame-tree" command, or e.g. a new format for "git
    +    ls-tree" to show what a path "blames" to can then be implemented with
    +    this library.
    +
    +    Aside from changing the code found at [4] into a test-tool the most
    +    notable changes here are:
    +
    +    * Removing the "--max-depth" changes to the diff code. We'll need
    +      those eventually, but it's not required for a blame of a given list
    +      of paths.
    +
    +      As has been noted in previous on-list discussions the semantics of
    +      the "max-depth" changes might be controversial, so it's worthwhile
    +      to split those out so that they can be reviewed separately.
    +
    +    * Made the "blame-tree" helper take "--" before any revision options,
    +      for clarity. An eventual built-in command (if any) probably doesn't
    +      want to enforce this, but it makes it clearer in the test helper
    +      what's an argument for "blame-tree" itself, and what's an argument for
    +      the revision machinery.
    +
    +    * Minor updates for using C99 syntax, and "size_t" instead of "int"
    +      when we're iterating over types whose "nr" is that size.
    +
    +    * Avoid sub-shelling in the tests, use "test-tool -C .." instead.
    +
    +    1. https://lore.kernel.org/git/20110302164031.GA18233@sigill.intra.peff.net/
    +    2. https://lore.kernel.org/git/20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net/
    +    3. https://public-inbox.org/git/20130318121243.GC14789@sigill.intra.peff.net/
    +    4. https://github.com/peff/git/
    +    4. https://gitlab.com/gitlab-org/git/-/issues/114
    +
    +    Commit-message-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    +@@ Makefile: PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
    + 
    + TEST_BUILTINS_OBJS += test-advise.o
    + TEST_BUILTINS_OBJS += test-bitmap.o
    ++TEST_BUILTINS_OBJS += test-blame-tree.o
    + TEST_BUILTINS_OBJS += test-bloom.o
    + TEST_BUILTINS_OBJS += test-bundle-uri.o
    + TEST_BUILTINS_OBJS += test-cache-tree.o
     @@ Makefile: LIB_OBJS += archive.o
      LIB_OBJS += attr.o
      LIB_OBJS += base85.o
    @@ Makefile: LIB_OBJS += archive.o
      LIB_OBJS += blame.o
      LIB_OBJS += blob.o
      LIB_OBJS += bloom.o
    -@@ Makefile: BUILTIN_OBJS += builtin/apply.o
    - BUILTIN_OBJS += builtin/archive.o
    - BUILTIN_OBJS += builtin/bisect.o
    - BUILTIN_OBJS += builtin/blame.o
    -+BUILTIN_OBJS += builtin/blame-tree.o
    - BUILTIN_OBJS += builtin/branch.o
    - BUILTIN_OBJS += builtin/bugreport.o
    - BUILTIN_OBJS += builtin/bundle.o
     
      ## blame-tree.c (new) ##
     @@
     +#include "cache.h"
     +#include "blame-tree.h"
    ++#include "strvec.h"
    ++#include "hash.h"
     +#include "commit.h"
    -+#include "diff.h"
     +#include "diffcore.h"
    ++#include "diff.h"
    ++#include "object.h"
     +#include "revision.h"
     +#include "log-tree.h"
    -+#include "dir.h"
    ++
    ++void blame_tree_opts_release(struct blame_tree_options *bto)
    ++{
    ++	strvec_clear(&bto->args);
    ++}
     +
     +struct blame_tree_entry {
     +	struct object_id oid;
    @@ blame-tree.c (new)
     +};
     +
     +static void add_from_diff(struct diff_queue_struct *q,
    -+			  struct diff_options *opt,
    -+			  void *data)
    ++			  struct diff_options *opt, void *data)
     +{
     +	struct blame_tree *bt = data;
    -+	int i;
     +
    -+	for (i = 0; i < q->nr; i++) {
    ++	for (size_t i = 0; i < q->nr; i++) {
     +		struct diff_filepair *p = q->queue[i];
     +		struct blame_tree_entry *ent = xcalloc(1, sizeof(*ent));
    -+		struct string_list_item *it;
     +
     +		oidcpy(&ent->oid, &p->two->oid);
    -+		it = string_list_append(&bt->paths, p->two->path);
    -+		it->util = ent;
    ++		string_list_append(&bt->paths, p->two->path)->util = ent;
     +	}
     +}
     +
     +static int add_from_revs(struct blame_tree *bt)
     +{
    -+	unsigned int i;
    -+	int count = 0;
    ++	size_t count = 0;
     +	struct diff_options diffopt;
     +
     +	memcpy(&diffopt, &bt->rev.diffopt, sizeof(diffopt));
     +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
     +	diffopt.format_callback = add_from_diff;
     +	diffopt.format_callback_data = bt;
    ++	diffopt.no_free = 1;
     +
    -+	for (i = 0; i < bt->rev.pending.nr; i++) {
    ++	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
     +		struct object_array_entry *obj = bt->rev.pending.objects + i;
     +
     +		if (obj->item->flags & UNINTERESTING)
     +			continue;
     +
     +		if (count++)
    -+			return error("can only blame one tree at a time");
    -+
    -+		diff_tree_sha1(EMPTY_TREE_SHA1_BIN, obj->item->oid.hash, "", &diffopt);
    ++			return error(_("can only blame one tree at a time"));
    ++		diff_tree_oid(the_hash_algo->empty_tree, &obj->item->oid, "",
    ++			      &diffopt);
     +		diff_flush(&diffopt);
     +	}
     +
    @@ blame-tree.c (new)
     +	return 0;
     +}
     +
    -+void blame_tree_init(struct blame_tree *bt, int argc, const char **argv,
    -+		     const char *prefix)
    ++void blame_tree_init(struct blame_tree *bt,
    ++		     const struct blame_tree_options *opts)
     +{
    -+	memset(bt, 0, sizeof(*bt));
    -+	bt->paths.strdup_strings = 1;
    -+
    -+	init_revisions(&bt->rev, prefix);
    -+	bt->rev.def = "HEAD";
    ++	init_revisions(&bt->rev, opts->prefix);
    ++	bt->rev.def = oid_to_hex(&opts->oid);
     +	bt->rev.combine_merges = 1;
     +	bt->rev.show_root_diff = 1;
     +	bt->rev.boundary = 1;
     +	bt->rev.no_commit_id = 1;
     +	bt->rev.diff = 1;
    -+	DIFF_OPT_SET(&bt->rev.diffopt, RECURSIVE);
    -+	setup_revisions(argc, argv, &bt->rev, NULL);
    ++	bt->rev.diffopt.flags.recursive = opts->recursive;
    ++	setup_revisions(opts->args.nr, opts->args.v, &bt->rev, NULL);
     +
     +	if (add_from_revs(bt) < 0)
    -+		die("unable to setup blame-tree");
    ++		die(_("unable to setup blame-tree"));
     +}
     +
     +void blame_tree_release(struct blame_tree *bt)
     +{
     +	string_list_clear(&bt->paths, 1);
    ++	release_revisions(&bt->rev);
     +}
     +
    -+
     +struct blame_tree_callback_data {
     +	struct commit *commit;
     +	struct string_list *paths;
    -+	int num_interesting;
    ++	size_t num_interesting;
     +
    -+	blame_tree_callback callback;
    ++	blame_tree_fn callback;
     +	void *callback_data;
     +};
     +
    @@ blame-tree.c (new)
     +	ent = item->util;
     +	if (ent->commit)
     +		return;
    ++
     +	/*
     +	 * Is it arriving at a version of interest, or is it from a side branch
     +	 * which did not contribute to the final state?
     +	 */
    -+	if (oidcmp(oid, &ent->oid))
    ++	if (!oideq(oid, &ent->oid))
     +		return;
     +
     +	ent->commit = data->commit;
    @@ blame-tree.c (new)
     +}
     +
     +static void blame_diff(struct diff_queue_struct *q,
    -+			 struct diff_options *opt, void *cbdata)
    ++		       struct diff_options *opt, void *cbdata)
     +{
     +	struct blame_tree_callback_data *data = cbdata;
    -+	int i;
     +
    -+	for (i = 0; i < q->nr; i++) {
    ++	for (size_t i = 0; i < q->nr; i++) {
     +		struct diff_filepair *p = q->queue[i];
     +		switch (p->status) {
     +		case DIFF_STATUS_DELETED:
    @@ blame-tree.c (new)
     +	}
     +}
     +
    -+int blame_tree_run(struct blame_tree *bt, blame_tree_callback cb, void *cbdata)
    ++int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *cbdata)
     +{
     +	struct blame_tree_callback_data data;
     +
    @@ blame-tree.c (new)
     +
     +	prepare_revision_walk(&bt->rev);
     +
    -+	while (data.num_interesting > 0) {
    ++	while (data.num_interesting) {
     +		data.commit = get_revision(&bt->rev);
     +		if (!data.commit)
     +			break;
     +
     +		if (data.commit->object.flags & BOUNDARY) {
    -+			diff_tree_sha1(EMPTY_TREE_SHA1_BIN,
    -+				       data.commit->object.oid.hash,
    ++			diff_tree_oid(the_hash_algo->empty_tree,
    ++				       &data.commit->object.oid,
     +				       "", &bt->rev.diffopt);
     +			diff_flush(&bt->rev.diffopt);
    -+		}
    -+		else
    ++		} else {
     +			log_tree_commit(&bt->rev, data.commit);
    ++		}
     +	}
     +
     +	return 0;
    @@ blame-tree.h (new)
     +#ifndef BLAME_TREE_H
     +#define BLAME_TREE_H
     +
    -+#include "commit.h"
    -+#include "diff.h"
    -+#include "revision.h"
    ++#include "hash.h"
    ++#include "strvec.h"
     +#include "string-list.h"
    ++#include "revision.h"
    ++#include "commit.h"
    ++
    ++struct blame_tree_options {
    ++	struct object_id oid;
    ++	const char *prefix;
    ++	unsigned int recursive;
    ++	struct strvec args;
    ++};
    ++#define BLAME_TREE_OPTIONS_INIT(...) { \
    ++	.args = STRVEC_INIT, \
    ++	__VA_ARGS__ \
    ++}
    ++void blame_tree_opts_release(struct blame_tree_options *bto);
     +
     +struct blame_tree {
     +	struct string_list paths;
     +	struct rev_info rev;
     +};
    ++#define BLAME_TREE_INIT { \
    ++	.paths = STRING_LIST_INIT_DUP, \
    ++	.rev = REV_INFO_INIT, \
    ++}
     +
    -+void blame_tree_init(struct blame_tree *,
    -+		     int argc, const char **argv, const char *prefix);
    ++void blame_tree_init(struct blame_tree *bt,
    ++		     const struct blame_tree_options *opts);
     +void blame_tree_release(struct blame_tree *);
     +
    -+typedef void (*blame_tree_callback)(const char *path,
    -+				    const struct commit *commit,
    -+				    void *data);
    -+int blame_tree_run(struct blame_tree *,
    -+		   blame_tree_callback cb,
    -+		   void *data);
    ++typedef void (*blame_tree_fn)(const char *path, const struct commit *commit,
    ++			      void *data);
    ++int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *data);
     +
     +#endif /* BLAME_TREE_H */
     
    - ## builtin.h ##
    -@@ builtin.h: int cmd_apply(int argc, const char **argv, const char *prefix);
    - int cmd_archive(int argc, const char **argv, const char *prefix);
    - int cmd_bisect(int argc, const char **argv, const char *prefix);
    - int cmd_blame(int argc, const char **argv, const char *prefix);
    -+int cmd_blame_tree(int argc, const char **argv, const char *prefix);
    - int cmd_branch(int argc, const char **argv, const char *prefix);
    - int cmd_bugreport(int argc, const char **argv, const char *prefix);
    - int cmd_bundle(int argc, const char **argv, const char *prefix);
    -
    - ## builtin/blame-tree.c (new) ##
    + ## t/helper/test-blame-tree.c (new) ##
     @@
    -+#include "cache.h"
    ++#include "test-tool.h"
     +#include "blame-tree.h"
     +#include "quote.h"
    ++#include "config.h"
     +#include "parse-options.h"
     +
     +static void show_entry(const char *path, const struct commit *commit, void *d)
    @@ builtin/blame-tree.c (new)
     +		putchar('^');
     +	printf("%s\t", oid_to_hex(&commit->object.oid));
     +
    -+	if (bt->rev.diffopt.line_termination)
    -+		write_name_quoted(path, stdout, '\n');
    -+	else
    -+		printf("%s%c", path, '\0');
    ++	write_name_quoted(path, stdout, bt->rev.diffopt.line_termination);
     +
     +	fflush(stdout);
     +}
     +
    -+int cmd_blame_tree(int argc, const char **argv, const char *prefix)
    ++int cmd__blame_tree(int argc, const char **argv)
     +{
    -+	struct blame_tree bt;
    ++	const char *prefix = setup_git_directory();
    ++	struct blame_tree_options opts = BLAME_TREE_OPTIONS_INIT(
    ++		.prefix = prefix,
    ++		.recursive = 1,
    ++	);
    ++	struct blame_tree bt = BLAME_TREE_INIT;
    ++	struct option options[] = {
    ++		OPT_BOOL(0, "recursive", &opts.recursive,
    ++			 "recurse into to subtrees"),
    ++		OPT_END()
    ++	};
    ++	static char const* const usage[] = {
    ++		"test-tool blame-tree [--no-recursive] [-- <rev-opts>]",
    ++		NULL
    ++	};
    ++
    ++	argc = parse_options(argc, argv, prefix, options, usage,
    ++			     PARSE_OPT_KEEP_DASHDASH);
    ++
    ++	if (argc) {
    ++		if (strcmp(argv[0], "--") &&
    ++		    strcmp(argv[0], "--end-of-options"))
    ++			usage_msg_opt("need -- before <rev-opts>", usage, options);
    ++		argc--;
    ++		argv++;
    ++	}
     +
    -+	git_config(git_default_config, NULL);
    ++	if (repo_get_oid(the_repository, "HEAD", &opts.oid))
    ++		 die("unable to get HEAD");
     +
    -+	blame_tree_init(&bt, argc, argv, prefix);
    ++	strvec_push(&opts.args, "blame-tree");
    ++	if (argc)
    ++		strvec_pushv(&opts.args, argv);
    ++	blame_tree_init(&bt, &opts);
     +	if (blame_tree_run(&bt, show_entry, &bt) < 0)
     +		die("error running blame-tree traversal");
     +	blame_tree_release(&bt);
    ++	blame_tree_opts_release(&opts);
     +
     +	return 0;
     +}
     
    - ## git.c ##
    -@@ git.c: static struct cmd_struct commands[] = {
    - 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
    - 	{ "bisect", cmd_bisect, RUN_SETUP },
    - 	{ "blame", cmd_blame, RUN_SETUP },
    -+	{ "blame-tree", cmd_blame_tree, RUN_SETUP },
    - 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
    - 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
    - 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
    + ## t/helper/test-tool.c ##
    +@@ t/helper/test-tool.c: static const char * const test_tool_usage[] = {
    + static struct test_cmd cmds[] = {
    + 	{ "advise", cmd__advise_if_enabled },
    + 	{ "bitmap", cmd__bitmap },
    ++	{ "blame-tree", cmd__blame_tree },
    + 	{ "bloom", cmd__bloom },
    + 	{ "bundle-uri", cmd__bundle_uri },
    + 	{ "cache-tree", cmd__cache_tree },
    +
    + ## t/helper/test-tool.h ##
    +@@
    + 
    + int cmd__advise_if_enabled(int argc, const char **argv);
    + int cmd__bitmap(int argc, const char **argv);
    ++int cmd__blame_tree(int argc, const char **argv);
    + int cmd__bloom(int argc, const char **argv);
    + int cmd__bundle_uri(int argc, const char **argv);
    + int cmd__cache_tree(int argc, const char **argv);
     
    - ## t/t8011-blame-tree.sh (new) ##
    + ## t/t8020-blame-tree-lib.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='basic blame-tree tests'
    ++test_description='basic blame-tree library tests'
    ++
     +. ./test-lib.sh
     +
     +test_expect_success 'setup' '
    @@ t/t8011-blame-tree.sh (new)
     +'
     +
     +test_expect_success 'cannot blame two trees' '
    -+	test_must_fail git blame-tree HEAD HEAD~1
    ++	test_must_fail test-tool blame-tree HEAD HEAD~1
     +'
     +
     +check_blame() {
    ++	local indir= &&
    ++	while test $# != 0
    ++	do
    ++		case "$1" in
    ++		-C)
    ++			indir="$2"
    ++			shift
    ++			;;
    ++		*)
    ++			break
    ++			;;
    ++		esac &&
    ++		shift
    ++	done &&
    ++
     +	cat >expect &&
    -+	git blame-tree "$@" >actual &&
    -+	git name-rev --stdin --name-only --tags <actual >tmp &&
    -+	mv tmp actual &&
    -+	tr '\t' ' ' <actual >tmp &&
    -+	mv tmp actual &&
    -+	sort <actual >tmp &&
    -+	mv tmp actual &&
    ++	test_when_finished "rm -f tmp.*" &&
    ++	test-tool ${indir:+-C "$indir"} \
    ++		blame-tree "$@" >tmp.1 &&
    ++	git name-rev --annotate-stdin --name-only --tags \
    ++		<tmp.1 >tmp.2 &&
    ++	tr '\t' ' ' <tmp.2 >tmp.3 &&
    ++	sort tmp.3 >actual &&
     +	test_cmp expect actual
     +}
     +
    @@ t/t8011-blame-tree.sh (new)
     +'
     +
     +test_expect_success 'blame root' '
    -+	check_blame --max-depth=0 <<-\EOF
    ++	check_blame --no-recursive <<-\EOF
     +	1 file
     +	3 a
     +	EOF
     +'
     +
     +test_expect_success 'blame subdir' '
    -+	check_blame --max-depth=1 a <<-\EOF
    ++	check_blame -- a <<-\EOF
     +	2 a/file
    -+	3 a/b
    ++	3 a/b/file
     +	EOF
     +'
     +
     +test_expect_success 'blame from non-HEAD commit' '
    -+	check_blame --max-depth=0 HEAD^ <<-\EOF
    ++	check_blame --no-recursive -- HEAD^ <<-\EOF
     +	1 file
     +	2 a
     +	EOF
     +'
     +
    -+test_expect_success 'blame from subdir defaults to root' '(
    -+	cd a &&
    -+	check_blame --max-depth=0 <<-\EOF
    ++test_expect_success 'blame from subdir defaults to root' '
    ++	check_blame -C a --no-recursive <<-\EOF
     +	1 file
     +	3 a
     +	EOF
    -+)'
    ++'
     +
    -+test_expect_success 'blame from subdir uses relative pathspecs' '(
    -+	cd a &&
    -+	check_blame --max-depth=1 b <<-\EOF
    ++test_expect_success 'blame from subdir uses relative pathspecs' '
    ++	check_blame -C a -- b <<-\EOF
     +	3 a/b/file
     +	EOF
    -+)'
    ++'
     +
     +test_expect_success 'limit blame traversal by count' '
    -+	check_blame --max-depth=0 -1 <<-\EOF
    ++	check_blame --no-recursive -- -1 <<-\EOF
     +	3 a
     +	^2 file
     +	EOF
     +'
     +
     +test_expect_success 'limit blame traversal by commit' '
    -+	check_blame --max-depth=0 HEAD~2..HEAD <<-\EOF
    ++	check_blame --no-recursive -- HEAD~2..HEAD <<-\EOF
     +	3 a
     +	^1 file
     +	EOF
    @@ t/t8011-blame-tree.sh (new)
     +	test_commit c2 conflict &&
     +	test_must_fail git merge c1 &&
     +	test_commit resolved conflict &&
    -+	check_blame conflict <<-\EOF
    ++	check_blame -- conflict <<-\EOF
     +	resolved conflict
     +	EOF
     +'

 Makefile                   |   2 +
 blame-tree.c               | 195 +++++++++++++++++++++++++++++++++++++
 blame-tree.h               |  39 ++++++++
 t/helper/test-blame-tree.c |  62 ++++++++++++
 t/helper/test-tool.c       |   1 +
 t/helper/test-tool.h       |   1 +
 t/t8020-blame-tree-lib.sh  | 138 ++++++++++++++++++++++++++
 7 files changed, 438 insertions(+)
 create mode 100644 blame-tree.c
 create mode 100644 blame-tree.h
 create mode 100644 t/helper/test-blame-tree.c
 create mode 100755 t/t8020-blame-tree-lib.sh

diff --git a/Makefile b/Makefile
index 45bd6ac9c3e..ed82dfee8e7 100644
--- a/Makefile
+++ b/Makefile
@@ -786,6 +786,7 @@ PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-advise.o
 TEST_BUILTINS_OBJS += test-bitmap.o
+TEST_BUILTINS_OBJS += test-blame-tree.o
 TEST_BUILTINS_OBJS += test-bloom.o
 TEST_BUILTINS_OBJS += test-bundle-uri.o
 TEST_BUILTINS_OBJS += test-cache-tree.o
@@ -974,6 +975,7 @@ LIB_OBJS += archive.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += blame-tree.o
 LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
diff --git a/blame-tree.c b/blame-tree.c
new file mode 100644
index 00000000000..dc739b23bff
--- /dev/null
+++ b/blame-tree.c
@@ -0,0 +1,195 @@
+#include "cache.h"
+#include "blame-tree.h"
+#include "strvec.h"
+#include "hash.h"
+#include "commit.h"
+#include "diffcore.h"
+#include "diff.h"
+#include "object.h"
+#include "revision.h"
+#include "log-tree.h"
+
+void blame_tree_opts_release(struct blame_tree_options *bto)
+{
+	strvec_clear(&bto->args);
+}
+
+struct blame_tree_entry {
+	struct object_id oid;
+	struct commit *commit;
+};
+
+static void add_from_diff(struct diff_queue_struct *q,
+			  struct diff_options *opt, void *data)
+{
+	struct blame_tree *bt = data;
+
+	for (size_t i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		struct blame_tree_entry *ent = xcalloc(1, sizeof(*ent));
+
+		oidcpy(&ent->oid, &p->two->oid);
+		string_list_append(&bt->paths, p->two->path)->util = ent;
+	}
+}
+
+static int add_from_revs(struct blame_tree *bt)
+{
+	size_t count = 0;
+	struct diff_options diffopt;
+
+	memcpy(&diffopt, &bt->rev.diffopt, sizeof(diffopt));
+	diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	diffopt.format_callback = add_from_diff;
+	diffopt.format_callback_data = bt;
+	diffopt.no_free = 1;
+
+	for (size_t i = 0; i < bt->rev.pending.nr; i++) {
+		struct object_array_entry *obj = bt->rev.pending.objects + i;
+
+		if (obj->item->flags & UNINTERESTING)
+			continue;
+
+		if (count++)
+			return error(_("can only blame one tree at a time"));
+		diff_tree_oid(the_hash_algo->empty_tree, &obj->item->oid, "",
+			      &diffopt);
+		diff_flush(&diffopt);
+	}
+
+	string_list_sort(&bt->paths);
+	return 0;
+}
+
+void blame_tree_init(struct blame_tree *bt,
+		     const struct blame_tree_options *opts)
+{
+	init_revisions(&bt->rev, opts->prefix);
+	bt->rev.def = oid_to_hex(&opts->oid);
+	bt->rev.combine_merges = 1;
+	bt->rev.show_root_diff = 1;
+	bt->rev.boundary = 1;
+	bt->rev.no_commit_id = 1;
+	bt->rev.diff = 1;
+	bt->rev.diffopt.flags.recursive = opts->recursive;
+	setup_revisions(opts->args.nr, opts->args.v, &bt->rev, NULL);
+
+	if (add_from_revs(bt) < 0)
+		die(_("unable to setup blame-tree"));
+}
+
+void blame_tree_release(struct blame_tree *bt)
+{
+	string_list_clear(&bt->paths, 1);
+	release_revisions(&bt->rev);
+}
+
+struct blame_tree_callback_data {
+	struct commit *commit;
+	struct string_list *paths;
+	size_t num_interesting;
+
+	blame_tree_fn callback;
+	void *callback_data;
+};
+
+static void mark_path(const char *path, const struct object_id *oid,
+		      struct blame_tree_callback_data *data)
+{
+	struct string_list_item *item = string_list_lookup(data->paths, path);
+	struct blame_tree_entry *ent;
+
+	/* Is it even a path that exists in our tree? */
+	if (!item)
+		return;
+
+	/* Have we already blamed a commit? */
+	ent = item->util;
+	if (ent->commit)
+		return;
+
+	/*
+	 * Is it arriving at a version of interest, or is it from a side branch
+	 * which did not contribute to the final state?
+	 */
+	if (!oideq(oid, &ent->oid))
+		return;
+
+	ent->commit = data->commit;
+	data->num_interesting--;
+	if (data->callback)
+		data->callback(path, data->commit, data->callback_data);
+}
+
+static void blame_diff(struct diff_queue_struct *q,
+		       struct diff_options *opt, void *cbdata)
+{
+	struct blame_tree_callback_data *data = cbdata;
+
+	for (size_t i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		switch (p->status) {
+		case DIFF_STATUS_DELETED:
+			/*
+			 * There's no point in feeding a deletion, as it could
+			 * not have resulted in our current state, which
+			 * actually has the file.
+			 */
+			break;
+
+		default:
+			/*
+			 * Otherwise, we care only that we somehow arrived at
+			 * a final path/sha1 state. Note that this covers some
+			 * potentially controversial areas, including:
+			 *
+			 *  1. A rename or copy will be blamed, as it is the
+			 *     first time the content has arrived at the given
+			 *     path.
+			 *
+			 *  2. Even a non-content modification like a mode or
+			 *     type change will trigger it.
+			 *
+			 * We take the inclusive approach for now, and blame
+			 * anything which impacts the path. Options to tweak
+			 * the behavior (e.g., to "--follow" the content across
+			 * renames) can come later.
+			 */
+			mark_path(p->two->path, &p->two->oid, data);
+			break;
+		}
+	}
+}
+
+int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *cbdata)
+{
+	struct blame_tree_callback_data data;
+
+	data.paths = &bt->paths;
+	data.num_interesting = bt->paths.nr;
+	data.callback = cb;
+	data.callback_data = cbdata;
+
+	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	bt->rev.diffopt.format_callback = blame_diff;
+	bt->rev.diffopt.format_callback_data = &data;
+
+	prepare_revision_walk(&bt->rev);
+
+	while (data.num_interesting) {
+		data.commit = get_revision(&bt->rev);
+		if (!data.commit)
+			break;
+
+		if (data.commit->object.flags & BOUNDARY) {
+			diff_tree_oid(the_hash_algo->empty_tree,
+				       &data.commit->object.oid,
+				       "", &bt->rev.diffopt);
+			diff_flush(&bt->rev.diffopt);
+		} else {
+			log_tree_commit(&bt->rev, data.commit);
+		}
+	}
+
+	return 0;
+}
diff --git a/blame-tree.h b/blame-tree.h
new file mode 100644
index 00000000000..fb4ba1004e7
--- /dev/null
+++ b/blame-tree.h
@@ -0,0 +1,39 @@
+#ifndef BLAME_TREE_H
+#define BLAME_TREE_H
+
+#include "hash.h"
+#include "strvec.h"
+#include "string-list.h"
+#include "revision.h"
+#include "commit.h"
+
+struct blame_tree_options {
+	struct object_id oid;
+	const char *prefix;
+	unsigned int recursive;
+	struct strvec args;
+};
+#define BLAME_TREE_OPTIONS_INIT(...) { \
+	.args = STRVEC_INIT, \
+	__VA_ARGS__ \
+}
+void blame_tree_opts_release(struct blame_tree_options *bto);
+
+struct blame_tree {
+	struct string_list paths;
+	struct rev_info rev;
+};
+#define BLAME_TREE_INIT { \
+	.paths = STRING_LIST_INIT_DUP, \
+	.rev = REV_INFO_INIT, \
+}
+
+void blame_tree_init(struct blame_tree *bt,
+		     const struct blame_tree_options *opts);
+void blame_tree_release(struct blame_tree *);
+
+typedef void (*blame_tree_fn)(const char *path, const struct commit *commit,
+			      void *data);
+int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *data);
+
+#endif /* BLAME_TREE_H */
diff --git a/t/helper/test-blame-tree.c b/t/helper/test-blame-tree.c
new file mode 100644
index 00000000000..1ea5ff783af
--- /dev/null
+++ b/t/helper/test-blame-tree.c
@@ -0,0 +1,62 @@
+#include "test-tool.h"
+#include "blame-tree.h"
+#include "quote.h"
+#include "config.h"
+#include "parse-options.h"
+
+static void show_entry(const char *path, const struct commit *commit, void *d)
+{
+	struct blame_tree *bt = d;
+
+	if (commit->object.flags & BOUNDARY)
+		putchar('^');
+	printf("%s\t", oid_to_hex(&commit->object.oid));
+
+	write_name_quoted(path, stdout, bt->rev.diffopt.line_termination);
+
+	fflush(stdout);
+}
+
+int cmd__blame_tree(int argc, const char **argv)
+{
+	const char *prefix = setup_git_directory();
+	struct blame_tree_options opts = BLAME_TREE_OPTIONS_INIT(
+		.prefix = prefix,
+		.recursive = 1,
+	);
+	struct blame_tree bt = BLAME_TREE_INIT;
+	struct option options[] = {
+		OPT_BOOL(0, "recursive", &opts.recursive,
+			 "recurse into to subtrees"),
+		OPT_END()
+	};
+	static char const* const usage[] = {
+		"test-tool blame-tree [--no-recursive] [-- <rev-opts>]",
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (argc) {
+		if (strcmp(argv[0], "--") &&
+		    strcmp(argv[0], "--end-of-options"))
+			usage_msg_opt("need -- before <rev-opts>", usage, options);
+		argc--;
+		argv++;
+	}
+
+	if (repo_get_oid(the_repository, "HEAD", &opts.oid))
+		 die("unable to get HEAD");
+
+	strvec_push(&opts.args, "blame-tree");
+	if (argc)
+		strvec_pushv(&opts.args, argv);
+	blame_tree_init(&bt, &opts);
+	if (blame_tree_run(&bt, show_entry, &bt) < 0)
+		die("error running blame-tree traversal");
+	blame_tree_release(&bt);
+	blame_tree_opts_release(&opts);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index abe8a785eb6..8f34ff18d6f 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -12,6 +12,7 @@ static const char * const test_tool_usage[] = {
 static struct test_cmd cmds[] = {
 	{ "advise", cmd__advise_if_enabled },
 	{ "bitmap", cmd__bitmap },
+	{ "blame-tree", cmd__blame_tree },
 	{ "bloom", cmd__bloom },
 	{ "bundle-uri", cmd__bundle_uri },
 	{ "cache-tree", cmd__cache_tree },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index ea2672436c9..745a2097000 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -5,6 +5,7 @@
 
 int cmd__advise_if_enabled(int argc, const char **argv);
 int cmd__bitmap(int argc, const char **argv);
+int cmd__blame_tree(int argc, const char **argv);
 int cmd__bloom(int argc, const char **argv);
 int cmd__bundle_uri(int argc, const char **argv);
 int cmd__cache_tree(int argc, const char **argv);
diff --git a/t/t8020-blame-tree-lib.sh b/t/t8020-blame-tree-lib.sh
new file mode 100755
index 00000000000..4213c25de8b
--- /dev/null
+++ b/t/t8020-blame-tree-lib.sh
@@ -0,0 +1,138 @@
+#!/bin/sh
+
+test_description='basic blame-tree library tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1 file &&
+	mkdir a &&
+	test_commit 2 a/file &&
+	mkdir a/b &&
+	test_commit 3 a/b/file
+'
+
+test_expect_success 'cannot blame two trees' '
+	test_must_fail test-tool blame-tree HEAD HEAD~1
+'
+
+check_blame() {
+	local indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac &&
+		shift
+	done &&
+
+	cat >expect &&
+	test_when_finished "rm -f tmp.*" &&
+	test-tool ${indir:+-C "$indir"} \
+		blame-tree "$@" >tmp.1 &&
+	git name-rev --annotate-stdin --name-only --tags \
+		<tmp.1 >tmp.2 &&
+	tr '\t' ' ' <tmp.2 >tmp.3 &&
+	sort tmp.3 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'blame recursive' '
+	check_blame <<-\EOF
+	1 file
+	2 a/file
+	3 a/b/file
+	EOF
+'
+
+test_expect_success 'blame root' '
+	check_blame --no-recursive <<-\EOF
+	1 file
+	3 a
+	EOF
+'
+
+test_expect_success 'blame subdir' '
+	check_blame -- a <<-\EOF
+	2 a/file
+	3 a/b/file
+	EOF
+'
+
+test_expect_success 'blame from non-HEAD commit' '
+	check_blame --no-recursive -- HEAD^ <<-\EOF
+	1 file
+	2 a
+	EOF
+'
+
+test_expect_success 'blame from subdir defaults to root' '
+	check_blame -C a --no-recursive <<-\EOF
+	1 file
+	3 a
+	EOF
+'
+
+test_expect_success 'blame from subdir uses relative pathspecs' '
+	check_blame -C a -- b <<-\EOF
+	3 a/b/file
+	EOF
+'
+
+test_expect_success 'limit blame traversal by count' '
+	check_blame --no-recursive -- -1 <<-\EOF
+	3 a
+	^2 file
+	EOF
+'
+
+test_expect_success 'limit blame traversal by commit' '
+	check_blame --no-recursive -- HEAD~2..HEAD <<-\EOF
+	3 a
+	^1 file
+	EOF
+'
+
+test_expect_success 'only blame files in the current tree' '
+	git rm -rf a &&
+	git commit -m "remove a" &&
+	check_blame <<-\EOF
+	1 file
+	EOF
+'
+
+test_expect_success 'cross merge boundaries in blaming' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit m1 &&
+	git checkout HEAD^ &&
+	git rm -rf . &&
+	test_commit m2 &&
+	git merge m1 &&
+	check_blame <<-\EOF
+	m1 m1.t
+	m2 m2.t
+	EOF
+'
+
+test_expect_success 'blame merge for resolved conflicts' '
+	git checkout HEAD^0 &&
+	git rm -rf . &&
+	test_commit c1 conflict &&
+	git checkout HEAD^ &&
+	git rm -rf . &&
+	test_commit c2 conflict &&
+	test_must_fail git merge c1 &&
+	test_commit resolved conflict &&
+	check_blame -- conflict <<-\EOF
+	resolved conflict
+	EOF
+'
+
+test_done
-- 
2.39.1.1398.g1368d6f56cf


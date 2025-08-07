Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF731FDD
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754600001; cv=none; b=QioeqS702Er51fkoyqfF+j65GjRom6mjUCmjCEoRGCBU2sMiOOGfve2zG/54E+EsclQPX6h1BR668NyN3AY7lX3J2/25AT/5S//XQgGNWSBLfLHHHlGdswlqVGNkxHJUsCQp6G1qgfu/BE8H1p7MEiH1kaTcr2ckWNttnl+lUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754600001; c=relaxed/simple;
	bh=408ddgN15NspJsMw1KAKcAp5VCcrKd7CxowA9nZzpyY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=b9PQPisTmxm9m8g9s7nFU2hga9dq4ElGNkYPph/SSfhV09wBGgM780tNPce/C3ETFEpWtqeGoUdTzXyhdgrjW6StjaN7wzz0WER4vE1GsDfB20JioED3tPWb3JTY7drUuW5KxvzLSTDkmFMMdHlE+97Wk+perydx1uqTQ8ILqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=pkntH9QE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="pkntH9QE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754599992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBAbeCySz9TbJA/lUnTlIx4hmtgrhBPiTQRFXhDnjl8=;
	b=pkntH9QEu/lrGZMz92bJsus5SGvprLG97dSFlXNgd+kGb8vXQb9SThHitRJG3+oLZfC7rd
	nUuuylELLDHNQqApDsoPLDshdOujggId3ybd7pXGzZtvfWrLEhPEKzyln4g9peXpIeSmsL
	yYbagEuJGJYOFh2f+nyR1brTOnrxeQQ=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 0/3] Teach git-diff-tree(1) option --max-depth
Date: Thu, 07 Aug 2025 22:52:55 +0200
Message-Id: <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcSlWgC/13MQQqDMBCF4avIrDslidpgV71HcWGTsQ5UI0kIF
 sndmwrddPk/eN8OgTxTgGu1g6fEgd1SQp0qMNOwPAnZlgYlVCu0ajA6t+A8bGhpjROq1tZGdqQ
 uQkM5rZ5G3g7w3peeOETn34ef5Hf9Ud0/lSQKNFJrqjvTiPFxYxfN62zcDH3O+QOeSkcRrAAAA
 A==
X-Change-ID: 20250724-toon-max-depth-25d3c19e2607
In-Reply-To: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Please consider these patches authored by Peff. They add option
`--max-depth` to the diff machinery.

During the process to upstream the git-blame-tree(1), later named
git-last-modified(1), various times[1][2][3] the topic was raised to add
option `--max-depth` to the diff machinery. In this patch series this
change is added as a separate patch series.

The patches were originally written by Peff[4] and I'm crediting him as
the author. I've taken the patches almost verbatim from his fork on
GitHub, with some minor tweaks in the commit messages. Because only tiny
changes were made, I've kept his Signed-off-by trailers, but I can
remove if disagreed on.

The goal of the option `--max-depth` is to stop recursively traversing
the tree if the given depth is reached from the pathspec.

These patches add `max_depth` and `max_depth_valid` to `struct
diff_options`. This is different from what git-grep(1) does, which uses
`max_depth` on `struct pathspec` instead. At the moment I'm on the fence
whether this is an issue: while it probably makes sense to consolidate
them into the same structs, it does not really make sense to reuse these
the struct fields if they are used in two separate code paths.

[1]: https://lore.kernel.org/git/20130318121243.GC14789@sigill.intra.peff.net/
[2]: https://lore.kernel.org/git/20160831054201.ldlwptlmcndjmfwu@sigill.intra.peff.net/
[3]: https://lore.kernel.org/git/Y+%2FmnnJUz75yfWCN@coredump.intra.peff.net/
[4]: https://github.com/peff/git/tree/jk/diff-max-depth

---
Changes in v2:
- Added unit-tests for within_depth() in dir.c. Originally the patch
  was a oneline change by Peff, but I've added a bunch of code and
  extended the commit message, so I've set myself as the author and set
  a Based-on-patch-by trailer for Peff. I hope that's okay?
- Added support for --max-depth=-1 and extended code comments why we
  need the max_depth_valid flag. With these modification it did no
  longer feel appropriate to keep Peff's Signed-off-by trailer.
- Made die() messages translatable.
- Small tweaks to the docs.
- Added some const-correctness.
- Switched from `die("BUG: ...")` to `BUG(...)`.
- Link to v1: https://lore.kernel.org/r/20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com

---
Jeff King (2):
      combine-diff: zero memory used for callback filepairs
      diff: teach tree-diff a max-depth parameter

Toon Claes (1):
      within_depth: fix return for empty path

 Documentation/diff-options.adoc |  28 ++++++++++
 Makefile                        |   1 +
 combine-diff.c                  |   2 +-
 diff-lib.c                      |   5 ++
 diff.c                          |  24 +++++++++
 diff.h                          |   8 +++
 dir.c                           |   2 +-
 t/meson.build                   |   2 +
 t/t4072-diff-max-depth.sh       | 116 ++++++++++++++++++++++++++++++++++++++++
 t/unit-tests/u-dir.c            |  47 ++++++++++++++++
 tree-diff.c                     |  78 +++++++++++++++++++++++++--
 11 files changed, 308 insertions(+), 5 deletions(-)
---

Range-diff versus v1:

1:  b16919a12d = 1:  f551775c58 combine-diff: zero memory used for callback filepairs
2:  c67ed5edee ! 2:  739374a2f8 within_depth: fix return for empty path
    @@
      ## Metadata ##
    -Author: Jeff King <peff@peff.net>
    +Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
         within_depth: fix return for empty path
    @@ Commit message
         The within_depth() function is used to check whether pathspecs limited
         by a max-depth parameter are acceptable. It takes a path to check, a
         maximum depth, and a "base" depth. It counts the components in the
    -    path (by counting slashes), adds them to the base, and compare them to
    +    path (by counting slashes), adds them to the base, and compares them to
         the maximum.
     
         However, if the base does not have any slashes at all, we always return
    @@ Commit message
         to change that in the future, then this fix is still the correct first
         step, as the current behavior is simply inconsistent.
     
    -    Signed-off-by: Jeff King <peff@peff.net>
    +    This has the effect the function tree_entry_interesting() now behaves
    +    like following on the first example:
    +
    +      (with max_depth=0):
    +          file: yes
    +             a: no
    +        a/file: no
    +           a/b: no
    +
    +    Meaning we won't step in "a/" no more to realize all "a/*" entries are
    +    uninterested, but we stop at the tree entry itself.
    +
    +    Based-on-patch-by: Jeff King <peff@peff.net>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
    + ## Makefile ##
    +@@ Makefile: THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
    + THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
    + 
    + CLAR_TEST_SUITES += u-ctype
    ++CLAR_TEST_SUITES += u-dir
    + CLAR_TEST_SUITES += u-example-decorate
    + CLAR_TEST_SUITES += u-hash
    + CLAR_TEST_SUITES += u-hashmap
    +
      ## dir.c ##
     @@ dir.c: int within_depth(const char *name, int namelen,
      		if (depth > max_depth)
    @@ dir.c: int within_depth(const char *name, int namelen,
      }
      
      /*
    +
    + ## t/meson.build ##
    +@@
    + clar_test_suites = [
    +   'unit-tests/u-ctype.c',
    ++  'unit-tests/u-dir.c',
    +   'unit-tests/u-example-decorate.c',
    +   'unit-tests/u-hash.c',
    +   'unit-tests/u-hashmap.c',
    +
    + ## t/unit-tests/u-dir.c (new) ##
    +@@
    ++#include "unit-test.h"
    ++#include "dir.h"
    ++
    ++#define TEST_WITHIN_DEPTH(path, depth, max_depth, expect) do { \
    ++		int actual = within_depth(path, strlen(path), \
    ++					  depth, max_depth); \
    ++		if (actual != expect) \
    ++			cl_failf("path '%s' with depth '%d' and max-depth '%d': expected %d, got %d", \
    ++				 path, depth, max_depth, expect, actual); \
    ++	} while (0)
    ++
    ++void test_dir__within_depth(void)
    ++{
    ++	/* depth = 0; max_depth = 0 */
    ++	TEST_WITHIN_DEPTH("",         0, 0, 1);
    ++	TEST_WITHIN_DEPTH("file",     0, 0, 1);
    ++	TEST_WITHIN_DEPTH("a",        0, 0, 1);
    ++	TEST_WITHIN_DEPTH("a/file",   0, 0, 0);
    ++	TEST_WITHIN_DEPTH("a/b",      0, 0, 0);
    ++	TEST_WITHIN_DEPTH("a/b/file", 0, 0, 0);
    ++
    ++	/* depth = 0; max_depth = 1 */
    ++	TEST_WITHIN_DEPTH("",         0, 1, 1);
    ++	TEST_WITHIN_DEPTH("file",     0, 1, 1);
    ++	TEST_WITHIN_DEPTH("a",        0, 1, 1);
    ++	TEST_WITHIN_DEPTH("a/file",   0, 1, 1);
    ++	TEST_WITHIN_DEPTH("a/b",      0, 1, 1);
    ++	TEST_WITHIN_DEPTH("a/b/file", 0, 1, 0);
    ++
    ++	/* depth = 1; max_depth = 1 */
    ++	TEST_WITHIN_DEPTH("",         1, 1, 1);
    ++	TEST_WITHIN_DEPTH("file",     1, 1, 1);
    ++	TEST_WITHIN_DEPTH("a",        1, 1, 1);
    ++	TEST_WITHIN_DEPTH("a/file",   1, 1, 0);
    ++	TEST_WITHIN_DEPTH("a/b",      1, 1, 0);
    ++	TEST_WITHIN_DEPTH("a/b/file", 1, 1, 0);
    ++
    ++	/* depth = 1; max_depth = 0 */
    ++	TEST_WITHIN_DEPTH("",         1, 0, 0);
    ++	TEST_WITHIN_DEPTH("file",     1, 0, 0);
    ++	TEST_WITHIN_DEPTH("a",        1, 0, 0);
    ++	TEST_WITHIN_DEPTH("a/file",   1, 0, 0);
    ++	TEST_WITHIN_DEPTH("a/b",      1, 0, 0);
    ++	TEST_WITHIN_DEPTH("a/b/file", 1, 0, 0);
    ++
    ++
    ++}
3:  b3eb4863c2 ! 3:  2987dbc007 diff: teach tree-diff a max-depth parameter
    @@ Commit message
         and see the raw output for a/b/c/, but not those of a/b/c/d/
         (instead of the raw output you would see for a/b/c/d).
     
    -    Signed-off-by: Jeff King <peff@peff.net>
    +    Co-authored-by: Toon Claes <toon@iotcl.com>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## Documentation/diff-options.adoc ##
    @@ Documentation/diff-options.adoc: endif::git-format-patch[]
      	reverted with `--ita-visible-in-index`. Both options are
      	experimental and could be removed in future.
      
    -+--max-depth=<n>::
    -+
    -+	Limit diff recursion to `<n>` levels (implies `-r`). The depth
    -+	is measured from the closest pathspec. Given a tree containing
    -+	`foo/bar/baz`, the following list shows the matches generated by
    -+	each set of options:
    ++--max-depth=<depth>::
    ++	For each pathspec given on command line, descend at most `<depth>`
    ++	levels of directories. A value of `-1` means no limit.
    ++	Cannot be combined with wildcards in the pathspec.
    ++	Given a tree containing `foo/bar/baz`, the following list shows the
    ++	matches generated by each set of options:
     ++
     +--
     + - `--max-depth=0 -- foo`: `foo`
    @@ diff-lib.c: void run_diff_files(struct rev_info *revs, unsigned int option)
      	struct index_state *istate = revs->diffopt.repo->index;
      
     +	if (revs->diffopt.max_depth_valid)
    -+		die("max-depth is not supported for worktree diffs");
    ++		die(_("max-depth is not supported for worktree diffs"));
     +
      	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
      
    @@ diff-lib.c: static int diff_cache(struct rev_info *revs,
      	opts.pathspec = &revs->diffopt.pathspec;
      	opts.pathspec->recursive = 1;
     +	if (revs->diffopt.max_depth_valid)
    -+		die("max-depth is not supported for index diffs");
    ++		die(_("max-depth is not supported for index diffs"));
      
      	init_tree_desc(&t, &tree->object.oid, tree->buffer, tree->size);
      	return unpack_trees(1, &t, &opts);
    @@ diff.c: static int diff_opt_rotate_to(const struct option *opt, const char *arg,
     +	struct diff_options *options = opt->value;
     +
     +	BUG_ON_OPT_NEG(unset);
    ++
    ++	if (!git_parse_int(arg, &options->max_depth))
    ++		return error(_("invalid value for '%s': '%s'"),
    ++			     "--max-depth", arg);
    ++
     +	options->flags.recursive = 1;
    -+	options->max_depth = strtol(arg, NULL, 10);
    -+	options->max_depth_valid = 1;
    ++	options->max_depth_valid = options->max_depth >= 0;
    ++
     +	return 0;
     +}
     +
    @@ diff.h: struct diff_options {
      	int no_free;
     +
     +	/*
    -+	 * The extra "valid" flag is a slight hack. The value "0" is perfectly
    -+	 * valid for max-depth. We would normally use -1 to indicate "not set",
    -+	 * but there are many code paths which assume that assume that just
    -+	 * zero-ing out a diff_options is enough to initialize it.
    ++	 * The value '0' is a valid max-depth (for no recursion), and value '-1'
    ++	 * also (for unlimited recursion), so the extra "valid" flag is used to
    ++	 * determined whether the user specified option --max-depth.
     +	 */
     +	int max_depth;
     +	int max_depth_valid;
    @@ t/t4072-diff-max-depth.sh (new)
     +	check_one tree "$*" '' 1 file one/file one/two
     +	check_one tree "$*" '' 2 file one/file one/two/file one/two/three
     +	check_one tree "$*" '' 3 file one/file one/two/file one/two/three/file
    ++	check_one tree "$*" '' -1 file one/file one/two/file one/two/three/file
     +	check_one tree "$*" one 0 one
     +	check_one tree "$*" one 1 one/file one/two
     +	check_one tree "$*" one 2 one/file one/two/file one/two/three
    @@ t/t4072-diff-max-depth.sh (new)
     +	check_one tree "$*" one/two 0 one/two
     +	check_one tree "$*" one/two 1 one/two/file one/two/three
     +	check_one tree "$*" one/two 2 one/two/file one/two/three/file
    ++	check_one tree "$*" one/two 2 one/two/file one/two/three/file
     +	check_one tree "$*" one/two/three 0 one/two/three
     +	check_one tree "$*" one/two/three 1 one/two/three/file
     +}
    @@ t/t4072-diff-max-depth.sh (new)
     +	check_one "$@" one/two 2 one/two/file one/two/three/file
     +	check_one "$@" one/two/three 0
     +	check_one "$@" one/two/three 1 one/two/three/file
    ++
    ++	# Value '-1' for '--max-depth is the same as recursion without limit,
    ++	# and thus should always succeed.
    ++	local expect=
    ++	check_one "$@" '' -1 file one/file one/two/file one/two/three/file
     +}
     +
     +# Check as a modification...
    @@ tree-diff.c
     +		(!path[dirlen] || path[dirlen] == '/');
     +}
     +
    -+static int check_recursion_depth(struct strbuf *name,
    ++static int check_recursion_depth(const struct strbuf *name,
     +				 const struct pathspec *ps,
     +				 int max_depth)
     +{
    @@ tree-diff.c
     +	return 0;
     +}
     +
    -+static int should_recurse(struct strbuf *name, struct diff_options *opt)
    ++static int should_recurse(const struct strbuf *name, struct diff_options *opt)
     +{
     +	if (!opt->flags.recursive)
     +		return 0;
    @@ tree-diff.c
     +	 * against any internal munging.
     +	 */
     +	if (opt->pathspec.has_wildcard)
    -+		die("BUG: wildcard pathspecs are incompatible with max-depth");
    ++		BUG("wildcard pathspecs are incompatible with max-depth");
     +
     +	return check_recursion_depth(name, &opt->pathspec, opt->max_depth);
     +}


---

base-commit: 64cbe5e2e8a7b0f92c780b210e602496bd5cad0f
change-id: 20250724-toon-max-depth-25d3c19e2607

Thanks
--
Toon


Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226A1D63DD
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309391; cv=none; b=tAXxcUgvBrdFKXEsqL8ZPvFsfNL1yLHGyLkv3BVfFDVJ96iZ0JqMokY0dHlKthRKTf9DK4ynHV9KD3a5XW/G8WE6rg69vBiLgbCGtgLQfA4rgpPob/CmQckKZgU0TD/qPPt0+RTeQWJzeXjY8PWnTrHiweHg6qQ8bE11PCc3bJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309391; c=relaxed/simple;
	bh=g6dKOB60/bEaHCGuQoRYngJi3YAPRPQXQmfIb6KXdeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=o/158rlkPOMf1WCisHYS/G/y7J58ue4mezwZoGkUPJtCtVh7PeRwGRJvhEjQBdcLn+V5c8lDunv6OzcqIfPEXDSf6McftRydKFuEsYr3OvrhWkazOC1ojGbvOK4+Som1eDQ1xTIv9CYgLfb3yShd5xThLA06vMnRdrC8vH5ml0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=DMbWIxLp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="DMbWIxLp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1751309384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQBX9DrrdMbWUCPnuhBVnGZ6GO+g9IGc7W1P6MZj8PM=;
	b=DMbWIxLpxSv5BfOyoGDPHYbM6XVPi6nu0weDzIHg7KSM0hxFjsHN4dn6t44C+yQXJafPGW
	DYAEUGOjwQw7JVMf4DxHuFkYKCUxzIimMoE/gmydEn+AL6lHWAM8MrSHqTMTMM5y0V/bHf
	T6EUwzcu8XY8UeftHNI0qFvWnlIPIE8=
From: Toon Claes <toon@iotcl.com>
Subject: [PATCH RFC v3 0/3] Introduce git-last-modified(1) command
Date: Mon, 30 Jun 2025 20:49:22 +0200
Message-Id: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLcYmgC/23OsQ7CIBAG4FdpbhYDlMbWycTEB3A1DkCvlsSCA
 YKapu8uwUGHjv9d/u9uhoDeYIB9NYPHZIJxNod6U4Eepb0hMX3OwClvqGCUROcssfgk6i4nJNE
 jEqV7pXatZpoOkJsPj4N5FfUC59MRrnk4mhCdf5dLiZXVF+V8FU2MUDL0qmGqlXUn5MG4qO9b7
 abiJf4zGl6vGzwbjDIUWor8XvdvLMvyAYD8rCP/AAAA
X-Change-ID: 20250410-toon-new-blame-tree-bcdbb78c1c0f
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Derrick Stolee <stolee@gmail.com>, Toon Claes <toon@iotcl.com>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
X-Migadu-Flow: FLOW_OUT

This series adds the git-last-modified(1) subcommand. In the past the
subcommand was proposed[1] to be named git-blame-tree(1). This version
is based on the patches shared by the kind people at GitHub[2].

What is different from the series shared by GitHub:

* Renamed the subcommand from `blame-tree` to `last-modified`. There was
  some consensus[5] this name works better, so let's give it a try and
  see how this name feels.

* Patches for --max-depth are excluded. I think it's a separate topic to
  discuss and I'm not sure it needs to be part of series anyway. The
  main patch was submitted in the previous attempt[3] and if people
  consider it valuable, I'm happy to discuss that in a separate patch
  series.

* The patches in 'tb/blame-tree' at Taylor's fork[4] implements a
  caching layer. This feature reads/writes cached results in
  `.git/blame-tree/<hash>.btc`. To keep this series to a reviewable
  size, that feature is excluded from this series. I think it's better
  to submit this as a separate series.

* Squashed various commits together. Like they introduced a flag
  `--go-faster`, which later became the default and only implementation.
  That story was wrapped up in a single commit.

* Dropped the patches that attempt to increase performance for tree
  entries that have not been updated in a long time. In my testing I've
  seen both performance improvements *and* degradation with these
  changes:

  Test                                        HEAD~             HEAD
  ------------------------------------------------------------------------------------
  8020.1: top-level last-modified             4.52(4.38+0.11)   2.03(1.93+0.08) -55.1%
  8020.2: top-level recursive last-modified   5.79(5.64+0.11)   8.34(8.17+0.11) +44.0%
  8020.3: subdir last-modified                0.15(0.09+0.06)   0.19(0.14+0.06) +26.7%

  Before we include these patches, I want to make sure these changes
  have positive impact in all/most scenarios. This can happen in a
  separate series.

* The last-modified command isn't recursive by default. If you want
  recurse into subtrees, you need to pass `-r`.

* Fixed all memory leaks, and removed the use of
  USE_THE_REPOSITORY_VARIABLE.

I've set myself as the author and added Based-on-patch-by trailers to
credit the original authors. Let me know if you disagree.

Again thanks to Taylor and the people at GitHub for sharing these
patches. I hope we can work together to get this upstreamed.

[1]: https://lore.kernel.org/git/patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/Z+XJ+1L3PnC9Dyba@nand.local/
[3]: https://lore.kernel.org/git/20250326-toon-blame-tree-v1-3-4173133f3786@iotcl.com/
[4]: git@github.com:ttaylorr/git.git
[5]: https://lore.kernel.org/git/aCbBKj7O9LjO3SMK@pks.im/

--
Cheers,
Toon

Signed-off-by: Toon Claes <toon@iotcl.com>
---
Changes in v3:
- Updated benchmarks in commit messages.
- Removed the patches that attempt to increase performance for tree
  entries that have not been updated in a long time. (see above)
- Move handling failure in `last_modified_init()` to the caller.
- Sorted #include clauses lexicographically.
- Removed unneeded `commit` in `struct last_modified_entry`.
- Renamed some functions/variables and added some comments to make it
  easier to understand.
- Removed unnecessary checking of the commit-graph generation number.
- Link to v2: https://lore.kernel.org/r/20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com

Changes in v2:
- The subcommand is renamed from `blame-tree` to `last-modified`
- Documentation is added. Here we mark the command as experimental.
- Some test cases are added related to merges.
- Link to v1: https://lore.kernel.org/r/20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com

---
Toon Claes (3):
      last-modified: new subcommand to show when files were last modified
      t/perf: add last-modified perf script
      last-modified: use Bloom filters when available

 .gitignore                           |   1 +
 Documentation/git-last-modified.adoc |  49 +++++++
 Documentation/meson.build            |   1 +
 Makefile                             |   2 +
 builtin.h                            |   1 +
 builtin/last-modified.c              |  44 ++++++
 command-list.txt                     |   1 +
 git.c                                |   1 +
 last-modified.c                      | 257 +++++++++++++++++++++++++++++++++++
 last-modified.h                      |  35 +++++
 meson.build                          |   2 +
 t/meson.build                        |   2 +
 t/perf/p8020-last-modified.sh        |  21 +++
 t/t8020-last-modified.sh             | 204 +++++++++++++++++++++++++++
 14 files changed, 621 insertions(+)
---

Range-diff versus v2:

1:  e77d1d65aa ! 1:  00e0ff81d9 last-modified: new subcommand to show when files were last modified
    @@ builtin/last-modified.c (new)
     +		   const char *prefix,
     +		   struct repository *repo)
     +{
    -+	int ret = 0;
     +	struct last_modified lm;
     +
     +	repo_config(repo, git_default_config, NULL);
     +
    -+	last_modified_init(&lm, repo, prefix, argc, argv);
    ++	if (last_modified_init(&lm, repo, prefix, argc, argv))
    ++		die(_("error setting up last-modified traversal"));
    ++
     +	if (last_modified_run(&lm, show_entry, &lm) < 0)
     +		die(_("error running last-modified traversal"));
     +
     +	last_modified_release(&lm);
     +
    -+	return ret;
    ++	return 0;
     +}
     
      ## command-list.txt ##
    @@ git.c: static struct cmd_struct commands[] = {
      ## last-modified.c (new) ##
     @@
     +#include "git-compat-util.h"
    -+#include "last-modified.h"
     +#include "commit.h"
    -+#include "diffcore.h"
     +#include "diff.h"
    -+#include "object.h"
    -+#include "revision.h"
    -+#include "repository.h"
    ++#include "diffcore.h"
    ++#include "last-modified.h"
     +#include "log-tree.h"
    ++#include "object.h"
    ++#include "repository.h"
    ++#include "revision.h"
     +
     +struct last_modified_entry {
     +	struct hashmap_entry hashent;
     +	struct object_id oid;
    -+	struct commit *commit;
     +	const char path[FLEX_ARRAY];
     +};
     +
    -+static void add_from_diff(struct diff_queue_struct *q,
    -+			  struct diff_options *opt UNUSED,
    -+			  void *data)
    ++static void add_path_from_diff(struct diff_queue_struct *q,
    ++			       struct diff_options *opt UNUSED,
    ++			       void *data)
     +{
     +	struct last_modified *lm = data;
     +
    @@ last-modified.c (new)
     +	}
     +}
     +
    -+static int add_from_revs(struct last_modified *lm)
    ++static int populate_paths_from_revs(struct last_modified *lm)
     +{
    -+	size_t count = 0;
    ++	int num_interesting = 0;
     +	struct diff_options diffopt;
     +
     +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
     +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
    ++	/*
    ++	 * Use a callback to populate the paths from revs
    ++	 */
     +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
    -+	diffopt.format_callback = add_from_diff;
    ++	diffopt.format_callback = add_path_from_diff;
     +	diffopt.format_callback_data = lm;
     +
     +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
    @@ last-modified.c (new)
     +		if (obj->item->flags & UNINTERESTING)
     +			continue;
     +
    -+		if (count++)
    ++		if (num_interesting++)
     +			return error(_("can only get last-modified one tree at a time"));
     +
     +		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
     +			      &obj->item->oid, "", &diffopt);
     +		diff_flush(&diffopt);
     +	}
    -+	clear_pathspec(&diffopt.pathspec);
    ++	diff_free(&diffopt);
     +
     +	return 0;
     +}
    @@ last-modified.c (new)
     +	return strcmp(ent1->path, path ? path : ent2->path);
     +}
     +
    -+void last_modified_init(struct last_modified *lm,
    ++int last_modified_init(struct last_modified *lm,
     +		     struct repository *r,
     +		     const char *prefix,
     +		     int argc, const char **argv)
    @@ last-modified.c (new)
     +	lm->rev.no_commit_id = 1;
     +	lm->rev.diff = 1;
     +	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
    -+		die(_("unknown last-modified argument: %s"), argv[1]);
    ++		return error(_("unknown last-modified argument: %s"), argv[1]);
     +
    -+	if (add_from_revs(lm) < 0)
    -+		die(_("unable to setup last-modified"));
    ++	if (populate_paths_from_revs(lm) < 0)
    ++		return error(_("unable to setup last-modified"));
    ++
    ++	return 0;
     +}
     +
     +void last_modified_release(struct last_modified *lm)
    @@ last-modified.c (new)
     +	if (!ent)
     +		return;
     +
    -+	/* Have we already found a commit? */
    -+	if (ent->commit)
    -+		return;
    -+
     +	/*
     +	 * Is it arriving at a version of interest, or is it from a side branch
     +	 * which did not contribute to the final state?
    @@ last-modified.c (new)
     +	if (!oideq(oid, &ent->oid))
     +		return;
     +
    -+	ent->commit = data->commit;
     +	if (data->callback)
     +		data->callback(path, data->commit, data->callback_data);
     +
    @@ last-modified.c (new)
     +}
     +
     +static void last_modified_diff(struct diff_queue_struct *q,
    -+		       struct diff_options *opt UNUSED, void *cbdata)
    ++			       struct diff_options *opt UNUSED, void *cbdata)
     +{
     +	struct last_modified_callback_data *data = cbdata;
     +
    @@ last-modified.h (new)
     +#define LAST_MODIFIED_H
     +
     +#include "commit.h"
    -+#include "revision.h"
     +#include "hashmap.h"
    ++#include "revision.h"
     +
     +struct last_modified {
     +	struct hashmap paths;
     +	struct rev_info rev;
     +};
     +
    -+void last_modified_init(struct last_modified *lm,
    ++/*
    ++ * Initialize the last-modified machinery using command line arguments.
    ++ */
    ++int last_modified_init(struct last_modified *lm,
     +		     struct repository *r,
     +		     const char *prefix,
     +		     int argc, const char **argv);
    @@ last-modified.h (new)
     +typedef void (*last_modified_callback)(const char *path,
     +				    const struct commit *commit,
     +				    void *data);
    ++
    ++/*
    ++ * Run the last-modified traversal. For each path found the callback is called
    ++ * passing the path, the commit, and the cbdata.
    ++ */
     +int last_modified_run(struct last_modified *lm,
     +		   last_modified_callback cb,
     +		   void *cbdata);
    @@ t/t8020-last-modified.sh (new)
     +	EOF
     +'
     +
    ++test_expect_success 'last-modified recursive with tree' '
    ++	check_last_modified -t <<-\EOF
    ++	1 file
    ++	2 a/file
    ++	3 a
    ++	3 a/b
    ++	3 a/b/file
    ++	EOF
    ++'
    ++
     +test_expect_success 'last-modified subdir' '
     +	check_last_modified a <<-\EOF
     +	3 a
2:  a9b69bf2f1 ! 2:  dceac8196a t/perf: add last-modified perf script
    @@
      ## Metadata ##
    -Author: Jeff King <peff@peff.net>
    +Author: Toon Claes <toon@iotcl.com>
     
      ## Commit message ##
         t/perf: add last-modified perf script
    @@ Commit message
         correctness in the regular suite, so this is just about finding
         performance regressions from one version to another.
     
    +    Based-on-patch-by: Jeff King <peff@peff.net>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## t/meson.build ##
3:  ee2fe0200a ! 3:  a479ef7c40 last-modified: use Bloom filters when available
    @@ Commit message
         doesn't contain any changed paths which are interesting to us. So, we
         can avoid computing it in this case.
     
    -    This results in a substantial performance speed-up in common cases of
    -    'git last-modified'. In the kernel, here is the before and after (all
    -    times computed with best-of-five):
    +    Comparing the perf test results on git.git:
     
    -    With commit-graphs (but no Bloom filters):
    -
    -        real        0m5.133s
    -        user        0m4.942s
    -        sys 0m0.180s
    -
    -    ...and with Bloom filters:
    -
    -        real        0m0.936s
    -        user        0m0.842s
    -        sys 0m0.092s
    -
    -    These times are with my development-version of Git, so it's compiled
    -    without optimizations. Compiling instead with `-O3`, the results look
    -    even better:
    -
    -        real        0m0.754s
    -        user        0m0.661s
    -        sys 0m0.092s
    +    Test                                        HEAD~             HEAD
    +    ------------------------------------------------------------------------------------
    +    8020.1: top-level last-modified             4.49(4.34+0.11)   2.22(2.05+0.09) -50.6%
    +    8020.2: top-level recursive last-modified   5.64(5.45+0.11)   5.62(5.30+0.11) -0.4%
    +    8020.3: subdir last-modified                0.11(0.06+0.04)   0.07(0.03+0.04) -36.4%
     
    +    Based-on-patch-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Toon Claes <toon@iotcl.com>
     
      ## last-modified.c ##
     @@
    - #include "revision.h"
    - #include "repository.h"
    - #include "log-tree.h"
    -+#include "dir.h"
    -+#include "commit-graph.h"
    + #include "git-compat-util.h"
     +#include "bloom.h"
    - 
    ++#include "commit-graph.h"
    + #include "commit.h"
    + #include "diff.h"
    + #include "diffcore.h"
    ++#include "dir.h"
    + #include "last-modified.h"
    + #include "log-tree.h"
    + #include "object.h"
    +@@
      struct last_modified_entry {
      	struct hashmap_entry hashent;
      	struct object_id oid;
    - 	struct commit *commit;
     +	struct bloom_key key;
      	const char path[FLEX_ARRAY];
      };
      
    -@@ last-modified.c: static void add_from_diff(struct diff_queue_struct *q,
    +@@ last-modified.c: static void add_path_from_diff(struct diff_queue_struct *q,
      
      		FLEX_ALLOC_STR(ent, path, path);
      		oidcpy(&ent->oid, &p->two->oid);
    @@ last-modified.c: static void add_from_diff(struct diff_queue_struct *q,
      		hashmap_entry_init(&ent->hashent, strhash(ent->path));
      		hashmap_add(&lm->paths, &ent->hashent);
      	}
    -@@ last-modified.c: void last_modified_init(struct last_modified *lm,
    +@@ last-modified.c: int last_modified_init(struct last_modified *lm,
      	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
    - 		die(_("unknown last-modified argument: %s"), argv[1]);
    + 		return error(_("unknown last-modified argument: %s"), argv[1]);
      
    ++	/*
    ++	 * We're not interested in generation numbers here,
    ++	 * but calling this function to prepare the commit-graph.
    ++	 */
     +	(void)generation_numbers_enabled(lm->rev.repo);
     +	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
     +
    - 	if (add_from_revs(lm) < 0)
    - 		die(_("unable to setup last-modified"));
    - }
    + 	if (populate_paths_from_revs(lm) < 0)
    + 		return error(_("unable to setup last-modified"));
    + 
    +@@ last-modified.c: int last_modified_init(struct last_modified *lm,
      
      void last_modified_release(struct last_modified *lm)
      {
     +	struct hashmap_iter iter;
     +	struct last_modified_entry *ent;
     +
    -+	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent) {
    ++	hashmap_for_each_entry(&lm->paths, &iter, ent, hashent)
     +		clear_bloom_key(&ent->key);
    -+	}
    ++
      	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
      	release_revisions(&lm->rev);
      }
    @@ last-modified.c: static void last_modified_diff(struct diff_queue_struct *q,
     +	if (!lm->rev.bloom_filter_settings)
     +		return 1;
     +
    -+	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
    -+		return 1;
    -+
     +	filter = get_bloom_filter(lm->rev.repo, origin);
     +	if (!filter)
     +		return 1;
4:  5dc990d49a < -:  ---------- last-modified: implement faster algorithm
5:  6a5a921a41 < -:  ---------- last-modified: initialize revision machinery without walk


---

base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
change-id: 20250410-toon-new-blame-tree-bcdbb78c1c0f

Thanks
--
Toon


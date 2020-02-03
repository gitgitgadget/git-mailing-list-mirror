Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A29C35247
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4620838
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 21:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MwGVqGAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBCVR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:17:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37293 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCVR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Feb 2020 16:17:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so6356601plz.4
        for <git@vger.kernel.org>; Mon, 03 Feb 2020 13:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+Sl/su669Oib4d8pUO1we1+bPw9qpUjM6L8ksHcXp4=;
        b=MwGVqGAqXtaF5OKoDJ+Hg6LLxqXDtuScJwnhrRkf5F9dFeghYnx5hqsO/G6/YW5YjN
         SDx9j3AyJbi4ghHEFSYVPwYBxW4yrziyxsC5vG5sPG9ArWIwAvldpkdq7u3O5sWIc1xV
         nh6376f/DfvsfsMeFlLtKcdO3Oc+wOjl79yxDk34LMxpwagjv2uUy+fvO6CbKwBlCkeh
         bUFV8Qx3Xcpvl++MhCFcMmBhEbWP/xf+eHCuKc/WB+cpnU330NA40zDN6qapKb6CCnR/
         bOpcAqZ+wd8rO91fQ0/Jp+LP6FNj42AUwGGLZ4ao0fwG92kFq9SydnwTptVSzdPUA6vC
         ta6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+Sl/su669Oib4d8pUO1we1+bPw9qpUjM6L8ksHcXp4=;
        b=kfL85EUpXzVxrzsP67mfUzFWpDllUKzOVPDy14IAuuUOU3orkowJH6Cq/ldTSUzB/c
         RZ6JUO4XyPF5jdI0t0KoyB2NnWv332rQuT6Louhjw7uOYzlbAWvRgShDNq4wbi95fdXM
         uN7tX+L//ZDqcXCnO2+2v8WL6sU6+YHK4/y+2fzURcUdmyb8KBV61qwDfjyQtSx+G/cv
         SRI3RcEGhf6HZgQAXmgJPXpuapO+oq0gaALL3E5+lND6GzyPFyWFBp9ko5gPrKnp2cSA
         lyWLdLCV/tDMzv9itzg4BiJ3WffY8fKtpPmAjf0eIrSKj+FCxaXmj78BcehOuDpvFsu+
         e0Pw==
X-Gm-Message-State: APjAAAX7gaSlcQTVJon833VFwe8w3AVZhQEbTBd25n7R6+AdIwtsqcMo
        86DHICoQ1Bi4Lyx2izvIsxO9vAc3hqjYtQ==
X-Google-Smtp-Source: APXvYqy0FAXGGN+RSX2e1NzsMYDDUvbUJmWMwVXuQEDJCekHd2v9FE1CYU45qBFFtzfd238kUAkAtw==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr11869012plp.21.1580764675645;
        Mon, 03 Feb 2020 13:17:55 -0800 (PST)
Received: from localhost ([205.175.106.126])
        by smtp.gmail.com with ESMTPSA id az9sm405738pjb.3.2020.02.03.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:17:54 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:17:53 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [PATCH v2 0/5] commit-graph: use 'struct object_directory *'
 everywhere
Message-ID: <cover.1580764494.git.me@ttaylorr.com>
References: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580424766.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is a re-roll of the series in this thread to replace string-based
path comparison in 'commit-graph.c' code with raw pointer comparison of
'struct object_directory *'s.

The only thing that has changed substantially since v1 is that I swapped
the order of patches 2/6 and 4/6. What was patch 3/6 got folded into
what is now patch 2/5. This resolves an inconvenience where we had to
define a helper function in 'commit-graph.c', when it really belonged in
'builtin/commit-graph.c'.

I took a few other suggestions from Martin in what is now patch 4/5, and
noticed a few other small things along the way. A range-diff since v1 is
included below.

Thanks as always,
Taylor

Taylor Blau (5):
  t5318: don't pass non-object directory to '--object-dir'
  commit-graph.h: store an odb in 'struct write_commit_graph_context'
  commit-graph.h: store object directory in 'struct commit_graph'
  commit-graph.c: remove path normalization, comparison
  commit-graph.h: use odb in 'load_commit_graph_one_fd_st'

 Documentation/git-commit-graph.txt |   5 +-
 builtin/commit-graph.c             |  34 +++++++--
 builtin/commit.c                   |   2 +-
 builtin/fetch.c                    |   2 +-
 builtin/gc.c                       |   2 +-
 commit-graph.c                     | 115 +++++++++++++----------------
 commit-graph.h                     |  15 ++--
 t/helper/test-read-graph.c         |   8 +-
 t/t5318-commit-graph.sh            |   4 +-
 9 files changed, 100 insertions(+), 87 deletions(-)

Range-diff against v1:
1:  09ba72c85a = 1:  84a8709ad1 t5318: don't pass non-object directory to '--object-dir'
4:  9784a5db3c ! 2:  d9819cfb33 commit-graph.h: store an odb in 'struct write_commit_graph_context'
    @@ Metadata
      ## Commit message ##
         commit-graph.h: store an odb in 'struct write_commit_graph_context'

    -    In a previous patch, the 'char *object_dir' in 'struct commit_graph' was
    -    replaced with a 'struct object_directory'. This patch applies the same
    -    treatement to 'struct write_commit_graph_context', which is an
    -    intermediate step towards getting rid of all path normalization in
    -    'commit-graph.c'.
    -
    -    Instead of taking a 'char *object_dir', functions that construct a
    -    'struct write_commit_graph_context' now take a 'struct object_directory
    -    *'. Any code that needs an object directory path use '->path' instead.
    -
    -    This ensures that all calls to functions that perform path normalization
    -    are given arguments which do not themselves require normalization. This
    -    prepares those functions to drop their normalization entirely, which
    -    will occur in the subsequent patch.
    +    There are lots of places in 'commit-graph.h' where a function either has
    +    (or almost has) a full 'struct object_directory *', accesses '->path',
    +    and then throws away the rest of the struct.
    +
    +    This can cause headaches when comparing the locations of object
    +    directories across alternates (e.g., in the case of deciding if two
    +    commit-graph layers can be merged). These paths are normalized with
    +    'normalize_path_copy()' which mitigates some comparison issues, but not
    +    all [1].
    +
    +    Replace usage of 'char *object_dir' with 'odb->path' by storing a
    +    'struct object_directory *' in the 'write_commit_graph_context'
    +    structure. This is an intermediate step towards getting rid of all path
    +    normalization in 'commit-graph.c'.
    +
    +    Resolving a user-provided '--object-dir' argument now requires that we
    +    compare it to the known alternates for equality.  Prior to this patch,
    +    an unknown '--object-dir' argument would silently exit with status zero.
    +
    +    This can clearly lead to unintended behavior, such as verifying
    +    commit-graphs that aren't in a repository's own object store (or one of
    +    its alternates), or causing a typo to mask a legitimate commit-graph
    +    verification failure. Make this error non-silent by 'die()'-ing when the
    +    given '--object-dir' does not match any known alternate object store.
    +
    +    [1]: In my testing, for example, I can get one side of the commit-graph
    +    code to fill object_dir with "./objects" and the other with just
    +    "objects".

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    + ## Documentation/git-commit-graph.txt ##
    +@@ Documentation/git-commit-graph.txt: OPTIONS
    + 	file. This parameter exists to specify the location of an alternate
    + 	that only has the objects directory, not a full `.git` directory. The
    + 	commit-graph file is expected to be in the `<dir>/info` directory and
    +-	the packfiles are expected to be in `<dir>/pack`.
    ++	the packfiles are expected to be in `<dir>/pack`. If the directory
    ++	could not be made into an absolute path, or does not match any known
    ++	object directory, `git commit-graph ...` will exit with non-zero
    ++	status.
    +
    + --[no-]progress::
    + 	Turn progress on/off explicitly. If neither is specified, progress is
    +
      ## builtin/commit-graph.c ##
    +@@ builtin/commit-graph.c: static struct opts_commit_graph {
    + 	int progress;
    + } opts;
    +
    ++struct object_directory *find_odb(struct repository *r, const char *obj_dir)
    ++{
    ++	struct object_directory *odb;
    ++	char *obj_dir_real = real_pathdup(obj_dir, 1);
    ++
    ++	prepare_alt_odb(r);
    ++	for (odb = r->objects->odb; odb; odb = odb->next) {
    ++		if (!strcmp(obj_dir_real, real_path(odb->path)))
    ++			break;
    ++	}
    ++
    ++	free(obj_dir_real);
    ++
    ++	if (!odb)
    ++		die(_("could not find object directory matching %s"), obj_dir);
    ++	return odb;
    ++}
    ++
    + static int graph_verify(int argc, const char **argv)
    + {
    + 	struct commit_graph *graph = NULL;
    ++	struct object_directory *odb = NULL;
    + 	char *graph_name;
    + 	int open_ok;
    + 	int fd;
    +@@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    + 	if (opts.progress)
    + 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
    +
    +-	graph_name = get_commit_graph_filename(opts.obj_dir);
    ++	odb = find_odb(the_repository, opts.obj_dir);
    ++	graph_name = get_commit_graph_filename(odb->path);
    + 	open_ok = open_commit_graph(graph_name, &fd, &st);
    + 	if (!open_ok && errno != ENOENT)
    + 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
    +@@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    +
    + 	if (open_ok)
    + 		graph = load_commit_graph_one_fd_st(fd, &st);
    +-	 else
    +-		graph = read_commit_graph_one(the_repository, opts.obj_dir);
    ++	else
    ++		graph = read_commit_graph_one(the_repository, odb->path);
    +
    + 	/* Return failure if open_ok predicted success */
    + 	if (!graph)
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 	odb = find_odb_or_die(the_repository, opts.obj_dir);
    + {
    + 	struct string_list *pack_indexes = NULL;
    + 	struct string_list *commit_hex = NULL;
    ++	struct object_directory *odb = NULL;
    + 	struct string_list lines;
    + 	int result = 0;
    + 	enum commit_graph_write_flags flags = 0;
    +@@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    + 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
    +
    + 	read_replace_refs = 0;
    ++	odb = find_odb(the_repository, opts.obj_dir);

      	if (opts.reachable) {
    --		if (write_commit_graph_reachable(odb->path, flags, &split_opts))
    +-		if (write_commit_graph_reachable(opts.obj_dir, flags, &split_opts))
     +		if (write_commit_graph_reachable(odb, flags, &split_opts))
      			return 1;
      		return 0;
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      		UNLEAK(buf);
      	}

    --	if (write_commit_graph(odb->path,
    +-	if (write_commit_graph(opts.obj_dir,
     +	if (write_commit_graph(odb,
      			       pack_indexes,
      			       commit_hex,
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph

      	while (g && (g->num_commits <= size_mult * num_commits ||
      		    (max_commits && num_commits > max_commits))) {
    --		if (strcmp(g->odb->path, ctx->obj_dir))
    -+		if (strcmp(g->odb->path, ctx->odb->path))
    +-		if (strcmp(g->obj_dir, ctx->obj_dir))
    ++		if (strcmp(g->obj_dir, ctx->odb->path))
      			break;

      		num_commits += g->num_commits;
     @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
    - 		char *old_graph_name = get_commit_graph_filename(g->odb->path);
    + 		char *old_graph_name = get_commit_graph_filename(g->obj_dir);

      		if (!strcmp(g->filename, old_graph_name) &&
    --		    strcmp(g->odb->path, ctx->obj_dir)) {
    -+		    strcmp(g->odb->path, ctx->odb->path)) {
    +-		    strcmp(g->obj_dir, ctx->obj_dir)) {
    ++		    strcmp(g->obj_dir, ctx->odb->path)) {
      			ctx->num_commit_graphs_after = 1;
      			ctx->new_base_graph = NULL;
      		}
    @@ commit-graph.c: int write_commit_graph(const char *obj_dir,
      		ctx->oids.alloc = split_opts->max_commits;

      	if (ctx->append) {
    --		struct object_directory *odb = find_odb(ctx->r, ctx->obj_dir);
    --		prepare_commit_graph_one(ctx->r, odb);
    -+		prepare_commit_graph_one(ctx->r, ctx->odb);
    +-		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
    ++		prepare_commit_graph_one(ctx->r, ctx->odb->path);
      		if (ctx->r->objects->commit_graph)
      			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
      	}
    @@ commit-graph.c: int write_commit_graph(const char *obj_dir,
      		for (i = 0; i < ctx->num_commit_graphs_after; i++) {

      ## commit-graph.h ##
    +@@
    + #include "repository.h"
    + #include "string-list.h"
    + #include "cache.h"
    ++#include "object-store.h"
    +
    + #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
    + #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
     @@ commit-graph.h: struct split_commit_graph_opts {
       * is not compatible with the commit-graph feature, then the
       * methods will return 0 without writing a commit-graph.
2:  328884f5f6 ! 3:  5fd5cfca6e commit-graph.h: store object directory in 'struct commit_graph'
    @@ Metadata
      ## Commit message ##
         commit-graph.h: store object directory in 'struct commit_graph'

    -    There are lots of places in 'commit-graph.h' where a function either has
    -    (or almost has) a full 'struct object_directory *', accesses '->path',
    -    and then throws away the rest of the struct.
    +    In a previous patch, the 'char *object_dir' in 'struct commit_graph' was
    +    replaced with a 'struct object_directory'. This patch applies the same
    +    treatment to 'struct commit_graph', which is another intermediate step
    +    towards getting rid of all path normalization in 'commit-graph.c'.

    -    This can cause headaches when comparing the locations of object
    -    directories across alternates (e.g., in the case of deciding if two
    -    commit-graph layers can be merged). These paths are normalized with
    -    'normalize_path_copy()' which mitigates some comparison issues, but not
    -    all [1].
    +    Instead of taking a 'char *object_dir', functions that construct a
    +    'struct commit_graph' now take a 'struct object_directory *'. Any code
    +    that needs an object directory path use '->path' instead.

    -    Instead of getting rid of the 'struct object_directory *', store that
    -    insead of a 'char *odb' in 'struct commit_graph'. Once the 'struct
    -    write_commit_graph_context' has an object_directory pointer, too, this
    -    will allow calling code to replace these error-prone path comparisons
    -    with raw pointer comparisons, thereby circumventing any
    -    normalization-related errors. This will be introduced in a subsequent
    -    patch.
    -
    -    [1]: In my testing, for example, I can get one side of the commit-graph
    -    code to fill object_dir with "./objects" and the other with just
    -    "objects".
    +    This ensures that all calls to functions that perform path normalization
    +    are given arguments which do not themselves require normalization. This
    +    prepares those functions to drop their normalization entirely, which
    +    will occur in the subsequent patch.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/commit-graph.c ##
     @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    -
      	if (open_ok)
      		graph = load_commit_graph_one_fd_st(fd, &st);
    --	 else
    --		graph = read_commit_graph_one(the_repository, opts.obj_dir);
    -+	else {
    -+		struct object_directory *odb;
    -+		if ((odb = find_odb(the_repository, opts.obj_dir)))
    -+			graph = read_commit_graph_one(the_repository, odb);
    -+	}
    + 	else
    +-		graph = read_commit_graph_one(the_repository, odb->path);
    ++		graph = read_commit_graph_one(the_repository, odb);

      	/* Return failure if open_ok predicted success */
      	if (!graph)
    -@@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 	struct string_list lines;
    - 	int result = 0;
    - 	enum commit_graph_write_flags flags = 0;
    -+	struct object_directory *odb = NULL;
    -
    - 	static struct option builtin_commit_graph_write_options[] = {
    - 		OPT_STRING(0, "object-dir", &opts.obj_dir,
    -@@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
    -
    - 	read_replace_refs = 0;
    -+	odb = find_odb(the_repository, opts.obj_dir);
    -
    - 	if (opts.reachable) {
    --		if (write_commit_graph_reachable(opts.obj_dir, flags, &split_opts))
    -+		if (write_commit_graph_reachable(odb->path, flags, &split_opts))
    - 			return 1;
    - 		return 0;
    - 	}
    -@@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
    - 		UNLEAK(buf);
    - 	}
    -
    --	if (write_commit_graph(opts.obj_dir,
    -+	if (write_commit_graph(odb->path,
    - 			       pack_indexes,
    - 			       commit_hex,
    - 			       flags,
    -
    - ## builtin/commit.c ##
    -@@
    - #include "help.h"
    - #include "commit-reach.h"
    - #include "commit-graph.h"
    -+#include "object-store.h"
    -
    - static const char * const builtin_commit_usage[] = {
    - 	N_("git commit [<options>] [--] <pathspec>..."),

      ## commit-graph.c ##
    -@@ commit-graph.c: static uint8_t oid_version(void)
    - 	return 1;
    - }
    -
    -+struct object_directory *find_odb(struct repository *r, const char *obj_dir)
    -+{
    -+	struct object_directory *odb;
    -+	char *obj_dir_real = real_pathdup(obj_dir, 1);
    -+	int cmp = -1;
    -+
    -+	prepare_alt_odb(r);
    -+	for (odb = r->objects->odb; odb; odb = odb->next) {
    -+		cmp = strcmp(obj_dir_real, real_path(odb->path));
    -+		if (!cmp)
    -+			break;
    -+	}
    -+
    -+	free(obj_dir_real);
    -+
    -+	if (cmp)
    -+		odb = NULL;
    -+	return odb;
    -+}
    -+
    - static struct commit_graph *alloc_commit_graph(void)
    - {
    - 	struct commit_graph *g = xcalloc(1, sizeof(*g));
     @@ commit-graph.c: static struct commit_graph *load_commit_graph_one(const char *graph_file)
      	return g;
      }
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph

      	while (g && (g->num_commits <= size_mult * num_commits ||
      		    (max_commits && num_commits > max_commits))) {
    --		if (strcmp(g->obj_dir, ctx->obj_dir))
    -+		if (strcmp(g->odb->path, ctx->obj_dir))
    +-		if (strcmp(g->obj_dir, ctx->odb->path))
    ++		if (strcmp(g->odb->path, ctx->odb->path))
      			break;

      		num_commits += g->num_commits;
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
     +		char *old_graph_name = get_commit_graph_filename(g->odb->path);

      		if (!strcmp(g->filename, old_graph_name) &&
    --		    strcmp(g->obj_dir, ctx->obj_dir)) {
    -+		    strcmp(g->odb->path, ctx->obj_dir)) {
    +-		    strcmp(g->obj_dir, ctx->odb->path)) {
    ++		    strcmp(g->odb->path, ctx->odb->path)) {
      			ctx->num_commit_graphs_after = 1;
      			ctx->new_base_graph = NULL;
      		}
    -@@ commit-graph.c: int write_commit_graph(const char *obj_dir,
    +@@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      		ctx->oids.alloc = split_opts->max_commits;

      	if (ctx->append) {
    --		prepare_commit_graph_one(ctx->r, ctx->obj_dir);
    -+		struct object_directory *odb = find_odb(ctx->r, ctx->obj_dir);
    -+		prepare_commit_graph_one(ctx->r, odb);
    +-		prepare_commit_graph_one(ctx->r, ctx->odb->path);
    ++		prepare_commit_graph_one(ctx->r, ctx->odb);
      		if (ctx->r->objects->commit_graph)
      			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
      	}

      ## commit-graph.h ##
    -@@
    - #include "repository.h"
    - #include "string-list.h"
    - #include "cache.h"
    -+#include "object-store.h"
    -
    - #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
    - #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
    -@@ commit-graph.h: struct commit;
    - char *get_commit_graph_filename(const char *obj_dir);
    - int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
    -
    -+struct object_directory *find_odb(struct repository *r, const char *obj_dir);
    -+
    - /*
    -  * Given a commit struct, try to fill the commit struct info, including:
    -  *  1. tree object
     @@ commit-graph.h: struct commit_graph {
      	uint32_t num_commits;
      	struct object_id oid;
3:  ce884d7742 < -:  ---------- builtin/commit-graph.c: die() with unknown '--object-dir'
5:  c9b2ba46ab ! 4:  f14e95aa7e commit-graph.c: remove path normalization, comparison
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/commit-graph.c ##
    -@@ builtin/commit-graph.c: static struct object_directory *find_odb_or_die(struct repository *r,
    - static int graph_verify(int argc, const char **argv)
    - {
    - 	struct commit_graph *graph = NULL;
    -+	struct object_directory *odb = NULL;
    - 	char *graph_name;
    - 	int open_ok;
    - 	int fd;
     @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    - 	if (opts.progress)
      		flags |= COMMIT_GRAPH_WRITE_PROGRESS;

    --	graph_name = get_commit_graph_filename(opts.obj_dir);
    -+	odb = find_odb_or_die(the_repository, opts.obj_dir);
    + 	odb = find_odb(the_repository, opts.obj_dir);
    +-	graph_name = get_commit_graph_filename(odb->path);
     +	graph_name = get_commit_graph_filename(odb);
      	open_ok = open_commit_graph(graph_name, &fd, &st);
      	if (!open_ok && errno != ENOENT)
      		die_errno(_("Could not open commit-graph '%s'"), graph_name);
    -@@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv)
    -
    - 	if (open_ok)
    - 		graph = load_commit_graph_one_fd_st(fd, &st);
    --	else {
    --		struct object_directory *odb;
    --		if ((odb = find_odb_or_die(the_repository, opts.obj_dir)))
    --			graph = read_commit_graph_one(the_repository, odb);
    --	}
    -+	else
    -+		graph = read_commit_graph_one(the_repository, odb);
    -
    - 	/* Return failure if open_ok predicted success */
    - 	if (!graph)

      ## commit-graph.c ##
     @@
    @@ commit-graph.h
     +char *get_commit_graph_filename(struct object_directory *odb);
      int open_commit_graph(const char *graph_file, int *fd, struct stat *st);

    - struct object_directory *find_odb(struct repository *r, const char *obj_dir);
    + /*

      ## t/helper/test-read-graph.c ##
     @@ t/helper/test-read-graph.c: int cmd__read_graph(int argc, const char **argv)
6:  e70483f771 = 5:  aa12b7378b commit-graph.h: use odb in 'load_commit_graph_one_fd_st'
--
2.25.0.119.gaa12b7378b

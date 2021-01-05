Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41677C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078F12251F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbhAEEnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbhAEEnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:43:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C4C061793
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c5so34866407wrp.6
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b5U/lKs1go42IHvNS7dENQgNEgcymcgXpAXyxZKfWhM=;
        b=LGaUmNSLHRlcboZV9wk3TEV8v6usZ+EPZylUjK1hW7K4PEFHRMY5PJ35xxDdmumV1x
         4lkZzvttyzDUU0fhFRHheL/UwYox8JNw1Y4T0AunymSMAf0dTsPgpWFuP5pEGQsLPVBk
         7Y//ZNCAgTx+4LNOe1t/G0xkWuQ8k47iXW6awTO4KK3HSj93P392pVIQroCyQvSRoRJt
         45ehlK45ZcA6tGyenUCY/RWx4aZAOs1nNw0bjdznCuIUcjwZVNh9skQHBosiotFIqmGY
         bAN1tkQAKSB9IX2iWO/m+1dx18M/gpGTJYP6cTcYGzS3bjISgWdgy/xP5YxFZkpyfO66
         2tYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b5U/lKs1go42IHvNS7dENQgNEgcymcgXpAXyxZKfWhM=;
        b=LR8C8rNAQEtyL6n/l3KVv8K/P4om4IY7qsMOI85waA7olBshwXH5y2H3pbyHcs05tO
         PfhpuIVUPOCMWYhCqQErRZl2PIWXJJ3HBYeAhiSXXrZyY5S47BOIYPhJLMTKt9MBbfRM
         97wRT9R7mFLkiVkpxlAfWhtp3GiSwmKTLwWU+ci2tfvwsxQ33eRZuId/C4kfEHQRxObY
         TjtTQgkZ0ZAfDHzTJvURrLqWvuq2Uja0dkY+C66QX43+jFlLRpaTp4rFfgOfsWpdn6Pk
         6Uoj6sRhhednbeLnslrtHU7rFtis0KHw7Ek4LNx5dfvN325Yp7mVuzS19XLgEVP0IAPb
         gAlQ==
X-Gm-Message-State: AOAM530f7pHUHCdcoT74agiZpXWC6GSrvrrmsleKqSUGa3MNohCiJFDC
        VI0TXv4x/2aewoK56jVK7mK/KHCNCfA=
X-Google-Smtp-Source: ABdhPJz/Ib590X8pFT86IiI4KpSrrYcriLAz69s5zkT9goreOWZLPU1JWwrlZ0fuTTxg7bwrpNUcWg==
X-Received: by 2002:a05:6000:1290:: with SMTP id f16mr84508520wrx.298.1609821784620;
        Mon, 04 Jan 2021 20:43:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm89399321wrt.96.2021.01.04.20.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:04 -0800 (PST)
Message-Id: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:42:49 +0000
Subject: [PATCH v2 00/14] Remove more index compatibility macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE: this is now based on ag/merge-strategies-in-c to avoid conflicts in
'seen'. The changes in builtin/rm.c still conflict with
mt/rm-sparse-checkout, but that branch seems to be waiting for a clearer
plan on some corner cases. I thought about ejecting it, but 'rm' still uses
ce_match_stat(), so just dropping the patch gives less of a final stake at
the end of the series. (I'm still open to it, if necessary.)

I noticed that Duy's project around USE_THE_INDEX_COMPATIBILITY_MACROS has
been on pause for a while. Here is my attempt to continue that project a
little.

I started going through the builtins that still use cache_name_pos() and the
first was easy: mv and rm.

Then I hit update-index and it was a bit bigger.

My strategy for update-index was to create static globals "repo" and
"istate" that point to the_repository and the_index, respectively. Then, I
was able to remove macros one-by-one without changing method prototypes
within the file. Then, these static globals were also removed by
systematically updating the local method prototypes, plus some fancy
structure stuff for the option parsing callbacks.

I had started trying to keep everything local to the method signatures, but
I hit a snag when reaching the command-line parsing callbacks, which I could
not modify their call signature. At that point, I had something that was
already much more complicated than what I present now. Outside of the first
update-index commit, everything was a mechanical find/replace.

In total, this allows us to remove four of the compatibility macros because
they are no longer used.


Updates in V2
=============

 * newly based on ag/merge-strategies-in-c, as there were some interesting
   conflicts in buitin/update-index.c.

 * Patch to update builtin/merge-index.c was dropped as that is already
   handled in ag/merge-strategies-in-c

 * I added patches that remove the static globals that I injected to make
   the compatibility macros easy to delete. I do this in three parts.

 * Commit messages improved.

Thanks, -Stolee

Derrick Stolee (14):
  mv: remove index compatibility macros
  rm: remove compatilibity macros
  update-index: drop the_index, the_repository
  update-index: use istate->cache over active_cache
  update-index: use index->cache_nr over active_nr
  update-index: use istate->cache_changed
  update-index: use index_name_pos() over cache_name_pos()
  update-index: use remove_file_from_index()
  update-index: use add_index_entry()
  update-index: replace several compatibility macros
  update-index: remove ce_match_stat(), all macros
  update-index: reduce static globals, part 1
  update-index: reduce static globals, part 2
  update-index: remove static globals from callbacks

 Documentation/technical/racy-git.txt |   6 +-
 builtin/mv.c                         |  42 ++--
 builtin/rm.c                         |  56 ++---
 builtin/update-index.c               | 320 +++++++++++++++------------
 cache.h                              |   4 -
 5 files changed, 233 insertions(+), 195 deletions(-)


base-commit: 3da8920d38a007157ccf8e53382e5206b909dafe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-830%2Fderrickstolee%2Findex-compatibility-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-830/derrickstolee/index-compatibility-1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/830

Range-diff vs v1:

  2:  84330533d4f =  1:  5ccc464cf26 mv: remove index compatibility macros
  3:  54e167d5872 =  2:  e715c703cb8 rm: remove compatilibity macros
  4:  77f6510bb68 !  3:  4bf3c582f9d update-index: drop the_index, the_repository
     @@ Commit message
          To reduce the need for the index compatibility macros, we will replace
          their uses in update-index mechanically. This is the most interesting
          change, which creates global "repo" and "istate" pointers. The macros
     -    can then be mechanically replaced by instances that use the istate
     -    pointer instead of the version that autocompletes to use the_index.
     +    that expand to use the_index can then be mechanically replaced by
     +    references to the istate pointer.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ builtin/update-index.c: static int add_one_path(const struct cache_entry *old, c
       		discard_cache_entry(ce);
       		return -1;
      @@ builtin/update-index.c: static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
     - 		return error("Invalid path '%s'", path);
     - 
     - 	len = strlen(path);
     --	ce = make_empty_cache_entry(&the_index, len);
     -+	ce = make_empty_cache_entry(istate, len);
     - 
     - 	oidcpy(&ce->oid, oid);
     - 	memcpy(ce->name, path, len);
     + {
     + 	int res;
     + 
     +-	res = add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
     ++	res = add_to_index_cacheinfo(istate, mode, oid, path, stage,
     + 				     allow_add, allow_replace, NULL);
     + 	if (res == -1)
     + 		return res;
      @@ builtin/update-index.c: static struct cache_entry *read_one_ent(const char *which,
       	struct object_id oid;
       	struct cache_entry *ce;
  5:  cc5df3566df =  4:  4b509ba5fa2 update-index: use istate->cache over active_cache
  6:  e99b8bddb3a =  5:  6c0e019f91c update-index: use index->cache_nr over active_nr
  7:  f841500c663 =  6:  5091e2661d1 update-index: use istate->cache_changed
  8:  d2af7e21ca1 =  7:  5b14fa10a4b update-index: use index_name_pos() over cache_name_pos()
  9:  c576e2d9676 =  8:  a1a9fb01b07 update-index: use remove_file_from_index()
 10:  cf091799cae !  9:  620e300ad6b update-index: use add_index_entry()
     @@ builtin/update-index.c: static int add_one_path(const struct cache_entry *old, c
       		discard_cache_entry(ce);
       		return error("%s: cannot add to the index - missing --add option?", path);
       	}
     -@@ builtin/update-index.c: static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
     - 		ce->ce_flags |= CE_VALID;
     - 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
     - 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
     --	if (add_cache_entry(ce, option))
     -+	if (add_index_entry(istate, ce, option))
     - 		return error("%s: cannot add to the index - missing --add option?",
     - 			     path);
     - 	report("add '%s'", path);
      @@ builtin/update-index.c: static int unresolve_one(const char *path)
       	}
       
 11:  d7856e2e772 = 10:  68b26a11d77 update-index: replace several compatibility macros
 12:  8fb307c3bee ! 11:  f1cffe2b455 update-index: remove ce_match_stat(), all macros
     @@ Commit message
          update-index: remove ce_match_stat(), all macros
      
          The final index compatibility macro to remove from the update-index
     -    builtin is ce_match_state(). Further, this is the last use of that macro
     +    builtin is ce_match_stat(). Further, this is the last use of that macro
          anywhere, so it should be removed.
      
          There are some remaining references in the racy-git.txt technical
  -:  ----------- > 12:  79e267f39ec update-index: reduce static globals, part 1
  1:  68d88b651c7 ! 13:  457402b4fdc merge-index: drop index compatibility macros
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    merge-index: drop index compatibility macros
     +    update-index: reduce static globals, part 2
      
     -    Replace uses of the old macros for the_index and instead pass around a
     -    'struct index_state' pointer. This allows dropping the compatibility
     -    flag.
     +    In order to remove index compatibility macros cleanly, we relied upon
     +    static globals 'repo' and 'istate' to be pointers to the_repository and
     +    the_index, respectively. We can continue reducing the need for these
     +    static globals by modifying method prototypes to use them when
     +    necessary.
     +
     +    Move these static globals further down the file so we can identify which
     +    methods need both 'struct repository *repo' and 'struct index_state
     +    *istate' parameters. The only changes included here adjust method
     +    prototypes and their call locations.
     +
     +    The only remaining change is to remove the static globals entirely, but
     +    that requires updating the parse-opt callbacks, which need a different
     +    solution.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     - ## builtin/merge-index.c ##
     -@@
     --#define USE_THE_INDEX_COMPATIBILITY_MACROS
     - #include "builtin.h"
     - #include "run-command.h"
     + ## builtin/update-index.c ##
     +@@ builtin/update-index.c: static const char * const update_index_usage[] = {
     + static struct object_id head_oid;
     + static struct object_id merge_head_oid;
       
     -@@ builtin/merge-index.c: static const char *pgm;
     - static int one_shot, quiet;
     - static int err;
     - 
     --static int merge_entry(int pos, const char *path)
     -+static int merge_entry(struct index_state *istate,
     -+		       int pos, const char *path)
     +-static struct repository *repo;
     +-static struct index_state *istate;
     +-
     +-static struct cache_entry *read_one_ent(const char *which,
     ++static struct cache_entry *read_one_ent(struct repository *repo,
     ++					struct index_state *istate,
     ++					const char *which,
     + 					struct object_id *ent, const char *path,
     + 					int namelen, int stage)
       {
     - 	int found;
     - 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
     - 	char hexbuf[4][GIT_MAX_HEXSZ + 1];
     - 	char ownbuf[4][60];
     - 
     --	if (pos >= active_nr)
     -+	if (pos >= istate->cache_nr)
     - 		die("git merge-index: %s not in the cache", path);
     - 	found = 0;
     - 	do {
     --		const struct cache_entry *ce = active_cache[pos];
     -+		const struct cache_entry *ce = istate->cache[pos];
     - 		int stage = ce_stage(ce);
     - 
     - 		if (strcmp(ce->name, path))
     -@@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
     - 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
     - 		arguments[stage] = hexbuf[stage];
     - 		arguments[stage + 4] = ownbuf[stage];
     --	} while (++pos < active_nr);
     -+	} while (++pos < istate->cache_nr);
     - 	if (!found)
     - 		die("git merge-index: %s not in the cache", path);
     - 
     -@@ builtin/merge-index.c: static int merge_entry(int pos, const char *path)
     - 	return found;
     +@@ builtin/update-index.c: static struct cache_entry *read_one_ent(const char *which,
     + 	return ce;
       }
       
     --static void merge_one_path(const char *path)
     -+static void merge_one_path(struct index_state *istate,
     -+			   const char *path)
     +-static int unresolve_one(const char *path)
     ++static int unresolve_one(struct repository *repo,
     ++			 struct index_state *istate,
     ++			 const char *path)
       {
     --	int pos = cache_name_pos(path, strlen(path));
     -+	int pos = index_name_pos(istate, path, strlen(path));
     - 
     - 	/*
     - 	 * If it already exists in the cache as stage0, it's
     - 	 * already merged and there is nothing to do.
     + 	int namelen = strlen(path);
     + 	int pos;
     +@@ builtin/update-index.c: static int unresolve_one(const char *path)
     + 	 * stuff HEAD version in stage #2,
     + 	 * stuff MERGE_HEAD version in stage #3.
       	 */
     - 	if (pos < 0)
     --		merge_entry(-pos-1, path);
     -+		merge_entry(istate, -pos - 1, path);
     +-	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
     +-	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
     ++	ce_2 = read_one_ent(repo, istate, "our", &head_oid, path, namelen, 2);
     ++	ce_3 = read_one_ent(repo, istate, "their", &merge_head_oid, path, namelen, 3);
     + 
     + 	if (!ce_2 || !ce_3) {
     + 		ret = -1;
     +@@ builtin/update-index.c: static void read_head_pointers(void)
     + 	}
       }
       
     --static void merge_all(void)
     -+static void merge_all(struct index_state *istate)
     +-static int do_unresolve(int ac, const char **av,
     ++static int do_unresolve(struct repository *repo,
     ++			struct index_state *istate,
     ++			int ac, const char **av,
     + 			const char *prefix, int prefix_length)
       {
       	int i;
     --	for (i = 0; i < active_nr; i++) {
     --		const struct cache_entry *ce = active_cache[i];
     -+	for (i = 0; i < istate->cache_nr; i++) {
     -+		const struct cache_entry *ce = istate->cache[i];
     - 		if (!ce_stage(ce))
     - 			continue;
     --		i += merge_entry(i, ce->name)-1;
     -+		i += merge_entry(istate, i, ce->name)-1;
     +@@ builtin/update-index.c: static int do_unresolve(int ac, const char **av,
     + 	for (i = 1; i < ac; i++) {
     + 		const char *arg = av[i];
     + 		char *p = prefix_path(prefix, prefix_length, arg);
     +-		err |= unresolve_one(p);
     ++		err |= unresolve_one(repo, istate, p);
     + 		free(p);
       	}
     + 	return err;
       }
       
     - int cmd_merge_index(int argc, const char **argv, const char *prefix)
     +-static int do_reupdate(int ac, const char **av,
     ++static int do_reupdate(struct repository *repo,
     ++		       struct index_state *istate,
     ++		       int ac, const char **av,
     + 		       const char *prefix)
       {
     - 	int i, force_file = 0;
     -+	struct index_state *istate;
     + 	/* Read HEAD and run update-index on paths that are
     +@@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
     + 		if (ce_stage(ce) || !ce_path_match(istate, ce, &pathspec, NULL))
     + 			continue;
     + 		if (has_head)
     +-			old = read_one_ent(NULL, &head_oid,
     ++			old = read_one_ent(repo, istate, NULL, &head_oid,
     + 					   ce->name, ce_namelen(ce), 0);
     + 		if (old && ce->ce_mode == old->ce_mode &&
     + 		    oideq(&ce->oid, &old->oid)) {
     +@@ builtin/update-index.c: struct refresh_params {
     + 	int *has_errors;
     + };
       
     - 	/* Without this we cannot rely on waitpid() to tell
     - 	 * what happened to our children.
     -@@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
     - 	if (argc < 3)
     - 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
     ++static struct repository *repo;
     ++static struct index_state *istate;
     ++
     + static int refresh(struct refresh_params *o, unsigned int flag)
     + {
     + 	setup_work_tree();
     +@@ builtin/update-index.c: static enum parse_opt_result unresolve_callback(
     + 	BUG_ON_OPT_ARG(arg);
       
     --	read_cache();
     -+	repo_read_index(the_repository);
     -+	istate = the_repository->index;
     + 	/* consume remaining arguments. */
     +-	*has_errors = do_unresolve(ctx->argc, ctx->argv,
     +-				prefix, prefix ? strlen(prefix) : 0);
     ++	*has_errors = do_unresolve(repo, istate, ctx->argc, ctx->argv,
     ++				   prefix, prefix ? strlen(prefix) : 0);
     + 	if (*has_errors)
     + 		istate->cache_changed = 0;
     + 
     +@@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
     + 
     + 	/* consume remaining arguments. */
     + 	setup_work_tree();
     +-	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
     ++	*has_errors = do_reupdate(repo, istate, ctx->argc, ctx->argv, prefix);
     + 	if (*has_errors)
     + 		istate->cache_changed = 0;
       
     - 	i = 1;
     - 	if (!strcmp(argv[i], "-o")) {
     -@@ builtin/merge-index.c: int cmd_merge_index(int argc, const char **argv, const char *prefix)
     - 				continue;
     - 			}
     - 			if (!strcmp(arg, "-a")) {
     --				merge_all();
     -+				merge_all(istate);
     - 				continue;
     - 			}
     - 			die("git merge-index: unknown option %s", arg);
     - 		}
     --		merge_one_path(arg);
     -+		merge_one_path(istate, arg);
     - 	}
     - 	if (err && !quiet)
     - 		die("merge program failed");
  -:  ----------- > 14:  2b171a142b3 update-index: remove static globals from callbacks

-- 
gitgitgadget

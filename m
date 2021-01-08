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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE1C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CC223AAC
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbhAHUDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbhAHUDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:03:41 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C730C0612EA
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c5so10104459wrp.6
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gjv7MRU6NUYkCw8Skg5UkogEcrVIU2+m1R92LX2s7ko=;
        b=nJTUMEqrKKPhhMX1++jTFIYt1ZaS1kkplO1SnwLyQc8d/S1lru2DSwvftyR2OBR+3n
         nNFmLhCjT1jxMRZ0+yLZTM3aAmvdgPboVsoWVhAtRmlUPyvFfPPoj9rJZq5IPgrAv8bO
         3z1x6zODoouoKOjgueLCDRIARyXuuUGKVDjif8RQi6xrz6B7Y+1HVVZmuvkFSDxqCrFG
         G02G0kb52eXd2rPeNEBVHeWKhxLm8XYe9JOvf9RNazS8NmpZcv3bKLGZUehHTSIUsTAZ
         30vnbaE4p9xRrohxH61N92lTu+F0bRIqticc23aLjJ+J1TrXK0kKrFMAj+mfrQx2+OrX
         nJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gjv7MRU6NUYkCw8Skg5UkogEcrVIU2+m1R92LX2s7ko=;
        b=RMZTFQ5UGRDEMouxkmyR1wqquzXtnNVsHZmGAnIhMazOgV0RNfAONx8e/3WLA0ZdEv
         YfyEDdAyeI15bvifBsfiSwaRj6r09gYRFDamv0IWejNGh3NMYTWEKUorZtsxOYHzeRPT
         Re3k/viX237mRL+QEyPuqrhlgseWM75WIH/CwSdlTNq8ht1zhOsbgKilotWhTi2HXgfx
         fmnw37/kVaoy/ycfpMLzKMF0rLMdAO0Q4QbwU8Q3bjwWEcPS92B7n2bSVTroKMv5jk/x
         PQdcLmY+vXwROW0MsOGqSlNhohBll9joLM3649+X+N+F8JmNBYq/+dIQPYUzyifi8P11
         le5w==
X-Gm-Message-State: AOAM533fOAWEpblkj7OeNhOj4f0LZw8WgwV230PUz68zPHpbd97qf1vQ
        TvAtjXd7qAS/WDD7+ab3fQJ0AMmm7yA=
X-Google-Smtp-Source: ABdhPJwmwM9tElP5XqXewV8OtYjaZMAPuwRqOuZpO91T2eq5d/c8a9Z0bfhsH3w4acmaVfMoUWRCsA==
X-Received: by 2002:adf:c449:: with SMTP id a9mr5200768wrg.281.1610136178867;
        Fri, 08 Jan 2021 12:02:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm14810481wrv.44.2021.01.08.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:02:58 -0800 (PST)
Message-Id: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:43 +0000
Subject: [PATCH v3 00/14] Remove more index compatibility macros
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


Updates in V3
=============

 * Methods that know about the 'repo' pointer no longer also have an
   'istate' pointer and instead prefer 'repo->index'

 * This includes the callback_data struct which only has a 'repo' member, no
   'istate'.

Thanks, -Stolee

Derrick Stolee (14):
  mv: remove index compatibility macros
  rm: remove compatilibity macros
  update-index: drop the_index, the_repository
  update-index: use istate->cache over active_cache
  update-index: use istate->cache_nr over active_nr
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
 builtin/update-index.c               | 312 +++++++++++++++------------
 cache.h                              |   4 -
 5 files changed, 225 insertions(+), 195 deletions(-)


base-commit: 3da8920d38a007157ccf8e53382e5206b909dafe
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-830%2Fderrickstolee%2Findex-compatibility-1-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-830/derrickstolee/index-compatibility-1-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/830

Range-diff vs v2:

  1:  5ccc464cf26 =  1:  5ccc464cf26 mv: remove index compatibility macros
  2:  e715c703cb8 =  2:  e715c703cb8 rm: remove compatilibity macros
  3:  4bf3c582f9d !  3:  f60f34ac1f5 update-index: drop the_index, the_repository
     @@ Commit message
          that expand to use the_index can then be mechanically replaced by
          references to the istate pointer.
      
     +    We will be careful to use "repo->index" over "istate" whenever repo is
     +    needed by a method.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/update-index.c ##
     -@@ builtin/update-index.c: static int ignore_skip_worktree_entries;
     - #define UNMARK_FLAG 2
     - static struct strbuf mtime_dir = STRBUF_INIT;
     +@@ builtin/update-index.c: static int test_if_untracked_cache_is_supported(void)
     + 	return ret;
     + }
       
     -+static struct repository *repo;
      +static struct index_state *istate;
      +
     - /* Untracked cache mode */
     - enum uc_mode {
     - 	UC_UNSPECIFIED = -1,
     -@@ builtin/update-index.c: static int mark_ce_flags(const char *path, int flag, int mark)
     + static int mark_ce_flags(const char *path, int flag, int mark)
     + {
       	int namelen = strlen(path);
       	int pos = cache_name_pos(path, namelen);
       	if (0 <= pos) {
     @@ builtin/update-index.c: static int add_cacheinfo(unsigned int mode, const struct
       				     allow_add, allow_replace, NULL);
       	if (res == -1)
       		return res;
     +@@ builtin/update-index.c: static const char * const update_index_usage[] = {
     + 
     + static struct object_id head_oid;
     + static struct object_id merge_head_oid;
     ++static struct repository *repo;
     + 
     + static struct cache_entry *read_one_ent(const char *which,
     + 					struct object_id *ent, const char *path,
      @@ builtin/update-index.c: static struct cache_entry *read_one_ent(const char *which,
       	struct object_id oid;
       	struct cache_entry *ce;
     @@ builtin/update-index.c: static struct cache_entry *read_one_ent(const char *whic
       		return NULL;
       	}
      -	ce = make_empty_cache_entry(&the_index, namelen);
     -+	ce = make_empty_cache_entry(istate, namelen);
     ++	ce = make_empty_cache_entry(repo->index, namelen);
       
       	oidcpy(&ce->oid, &oid);
       	memcpy(ce->name, path, namelen);
     @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
       		char *path;
       
      -		if (ce_stage(ce) || !ce_path_match(&the_index, ce, &pathspec, NULL))
     -+		if (ce_stage(ce) || !ce_path_match(istate, ce, &pathspec, NULL))
     ++		if (ce_stage(ce) || !ce_path_match(repo->index, ce, &pathspec, NULL))
       			continue;
       		if (has_head)
       			old = read_one_ent(NULL, &head_oid,
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       
      -	the_index.updated_skipworktree = 1;
      +	istate = repo->index;
     -+	istate->updated_skipworktree = 1;
     ++	repo->index->updated_skipworktree = 1;
       
       	/*
       	 * Custom copy of parse_options() because we want to handle
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
       
      -		if (the_index.version != preferred_index_format)
     -+		if (istate->version != preferred_index_format)
     ++		if (repo->index->version != preferred_index_format)
       			active_cache_changed |= SOMETHING_CHANGED;
      -		the_index.version = preferred_index_format;
     -+		istate->version = preferred_index_format;
     ++		repo->index->version = preferred_index_format;
       	}
       
       	if (read_from_stdin) {
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       				  "enable split index"));
      -		if (the_index.split_index)
      -			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
     -+		if (istate->split_index)
     -+			istate->cache_changed |= SPLIT_INDEX_ORDERED;
     ++		if (repo->index->split_index)
     ++			repo->index->cache_changed |= SPLIT_INDEX_ORDERED;
       		else
      -			add_split_index(&the_index);
     -+			add_split_index(istate);
     ++			add_split_index(repo->index);
       	} else if (!split_index) {
       		if (git_config_get_split_index() == 1)
       			warning(_("core.splitIndex is set to true; "
       				  "remove or change it, if you really want to "
       				  "disable split index"));
      -		remove_split_index(&the_index);
     -+		remove_split_index(istate);
     ++		remove_split_index(repo->index);
       	}
       
      -	prepare_repo_settings(r);
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       				  "remove or change it, if you really want to "
       				  "disable the untracked cache"));
      -		remove_untracked_cache(&the_index);
     -+		remove_untracked_cache(istate);
     ++		remove_untracked_cache(repo->index);
       		report(_("Untracked cache disabled"));
       		break;
       	case UC_TEST:
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       				  "remove or change it, if you really want to "
       				  "enable the untracked cache"));
      -		add_untracked_cache(&the_index);
     -+		add_untracked_cache(istate);
     ++		add_untracked_cache(repo->index);
       		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
       		break;
       	default:
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       				"set it if you really want to "
       				"enable fsmonitor"));
      -		add_fsmonitor(&the_index);
     -+		add_fsmonitor(istate);
     ++		add_fsmonitor(repo->index);
       		report(_("fsmonitor enabled"));
       	} else if (!fsmonitor) {
       		if (git_config_get_fsmonitor() == 1)
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       				"remove it if you really want to "
       				"disable fsmonitor"));
      -		remove_fsmonitor(&the_index);
     -+		remove_fsmonitor(istate);
     ++		remove_fsmonitor(repo->index);
       		report(_("fsmonitor disabled"));
       	}
       
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       			unable_to_lock_die(get_index_file(), lock_error);
       		}
      -		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
     -+		if (write_locked_index(istate, &lock_file, COMMIT_LOCK))
     ++		if (write_locked_index(repo->index, &lock_file, COMMIT_LOCK))
       			die("Unable to write new index file");
       	}
       
  4:  4b509ba5fa2 !  4:  b8fcdd8b3da update-index: use istate->cache over active_cache
     @@ Metadata
       ## Commit message ##
          update-index: use istate->cache over active_cache
      
     +    Also use repo->index over istate, when possible.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/update-index.c ##
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       		pos = unmerge_cache_entry_at(pos);
       		if (pos < active_nr) {
      -			const struct cache_entry *ce = active_cache[pos];
     -+			const struct cache_entry *ce = istate->cache[pos];
     ++			const struct cache_entry *ce = repo->index->cache[pos];
       			if (ce_stage(ce) &&
       			    ce_namelen(ce) == namelen &&
       			    !memcmp(ce->name, path, namelen))
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       		pos = -pos-1;
       		if (pos < active_nr) {
      -			const struct cache_entry *ce = active_cache[pos];
     -+			const struct cache_entry *ce = istate->cache[pos];
     ++			const struct cache_entry *ce = repo->index->cache[pos];
       			if (ce_namelen(ce) == namelen &&
       			    !memcmp(ce->name, path, namelen)) {
       				fprintf(stderr,
     @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
        redo:
       	for (pos = 0; pos < active_nr; pos++) {
      -		const struct cache_entry *ce = active_cache[pos];
     -+		const struct cache_entry *ce = istate->cache[pos];
     ++		const struct cache_entry *ce = repo->index->cache[pos];
       		struct cache_entry *old = NULL;
       		int save_nr;
       		char *path;
  5:  6c0e019f91c !  5:  586371ee769 update-index: use index->cache_nr over active_nr
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    update-index: use index->cache_nr over active_nr
     +    update-index: use istate->cache_nr over active_nr
     +
     +    Also use "repo->index" over "istate" when possible.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       		/* already merged */
       		pos = unmerge_cache_entry_at(pos);
      -		if (pos < active_nr) {
     -+		if (pos < istate->cache_nr) {
     - 			const struct cache_entry *ce = istate->cache[pos];
     ++		if (pos < repo->index->cache_nr) {
     + 			const struct cache_entry *ce = repo->index->cache[pos];
       			if (ce_stage(ce) &&
       			    ce_namelen(ce) == namelen &&
      @@ builtin/update-index.c: static int unresolve_one(const char *path)
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       		 */
       		pos = -pos-1;
      -		if (pos < active_nr) {
     -+		if (pos < istate->cache_nr) {
     - 			const struct cache_entry *ce = istate->cache[pos];
     ++		if (pos < repo->index->cache_nr) {
     + 			const struct cache_entry *ce = repo->index->cache[pos];
       			if (ce_namelen(ce) == namelen &&
       			    !memcmp(ce->name, path, namelen)) {
      @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
     @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
       		has_head = 0;
        redo:
      -	for (pos = 0; pos < active_nr; pos++) {
     -+	for (pos = 0; pos < istate->cache_nr; pos++) {
     - 		const struct cache_entry *ce = istate->cache[pos];
     ++	for (pos = 0; pos < repo->index->cache_nr; pos++) {
     + 		const struct cache_entry *ce = repo->index->cache[pos];
       		struct cache_entry *old = NULL;
       		int save_nr;
      @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
     @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
       		/* Be careful.  The working tree may not have the
       		 * path anymore, in which case, under 'allow_remove',
      -		 * or worse yet 'allow_replace', active_nr may decrease.
     -+		 * or worse yet 'allow_replace', istate->cache_nr may decrease.
     ++		 * or worse yet 'allow_replace', repo->index->cache_nr may decrease.
       		 */
      -		save_nr = active_nr;
     -+		save_nr = istate->cache_nr;
     ++		save_nr = repo->index->cache_nr;
       		path = xstrdup(ce->name);
       		update_one(path);
       		free(path);
       		discard_cache_entry(old);
      -		if (save_nr != active_nr)
     -+		if (save_nr != istate->cache_nr)
     ++		if (save_nr != repo->index->cache_nr)
       			goto redo;
       	}
       	clear_pathspec(&pathspec);
  6:  5091e2661d1 !  6:  f450f43cd0d update-index: use istate->cache_changed
     @@ builtin/update-index.c: static enum parse_opt_result unresolve_callback(
       				prefix, prefix ? strlen(prefix) : 0);
       	if (*has_errors)
      -		active_cache_changed = 0;
     -+		istate->cache_changed = 0;
     ++		repo->index->cache_changed = 0;
       
       	ctx->argv += ctx->argc - 1;
       	ctx->argc = 1;
     @@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
       	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
       	if (*has_errors)
      -		active_cache_changed = 0;
     -+		istate->cache_changed = 0;
     ++		repo->index->cache_changed = 0;
       
       	ctx->argv += ctx->argc - 1;
       	ctx->argc = 1;
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
       			    INDEX_FORMAT_LB, INDEX_FORMAT_UB);
       
     - 		if (istate->version != preferred_index_format)
     + 		if (repo->index->version != preferred_index_format)
      -			active_cache_changed |= SOMETHING_CHANGED;
     -+			istate->cache_changed |= SOMETHING_CHANGED;
     - 		istate->version = preferred_index_format;
     ++			repo->index->cache_changed |= SOMETHING_CHANGED;
     + 		repo->index->version = preferred_index_format;
       	}
       
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       	}
       
      -	if (active_cache_changed || force_write) {
     -+	if (istate->cache_changed || force_write) {
     ++	if (repo->index->cache_changed || force_write) {
       		if (newfd < 0) {
       			if (refresh_args.flags & REFRESH_QUIET)
       				exit(128);
  7:  5b14fa10a4b !  7:  fc640ae6e65 update-index: use index_name_pos() over cache_name_pos()
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/update-index.c ##
     -@@ builtin/update-index.c: static int test_if_untracked_cache_is_supported(void)
     +@@ builtin/update-index.c: static struct index_state *istate;
       static int mark_ce_flags(const char *path, int flag, int mark)
       {
       	int namelen = strlen(path);
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       
       	/* See if there is such entry in the index. */
      -	pos = cache_name_pos(path, namelen);
     -+	pos = index_name_pos(istate, path, namelen);
     ++	pos = index_name_pos(repo->index, path, namelen);
       	if (0 <= pos) {
       		/* already merged */
       		pos = unmerge_cache_entry_at(pos);
  8:  a1a9fb01b07 !  8:  2eead833fba update-index: use remove_file_from_index()
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       	}
       
      -	remove_file_from_cache(path);
     -+	remove_file_from_index(istate, path);
     ++	remove_file_from_index(repo->index, path);
       	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
       		error("%s: cannot add our version to the index.", path);
       		ret = -1;
  9:  620e300ad6b !  9:  8016b089556 update-index: use add_index_entry()
     @@ builtin/update-index.c: static int add_one_path(const struct cache_entry *old, c
      @@ builtin/update-index.c: static int unresolve_one(const char *path)
       	}
       
     - 	remove_file_from_index(istate, path);
     + 	remove_file_from_index(repo->index, path);
      -	if (add_cache_entry(ce_2, ADD_CACHE_OK_TO_ADD)) {
     -+	if (add_index_entry(istate, ce_2, ADD_CACHE_OK_TO_ADD)) {
     ++	if (add_index_entry(repo->index, ce_2, ADD_CACHE_OK_TO_ADD)) {
       		error("%s: cannot add our version to the index.", path);
       		ret = -1;
       		goto free_return;
       	}
      -	if (!add_cache_entry(ce_3, ADD_CACHE_OK_TO_ADD))
     -+	if (!add_index_entry(istate, ce_3, ADD_CACHE_OK_TO_ADD))
     ++	if (!add_index_entry(repo->index, ce_3, ADD_CACHE_OK_TO_ADD))
       		return 0;
       	error("%s: cannot add their version to the index.", path);
       	ret = -1;
 10:  68b26a11d77 ! 10:  efe9fddd0a9 update-index: replace several compatibility macros
     @@ builtin/update-index.c: static void chmod_path(char flip, const char *path)
       
       	report("chmod %cx '%s'", flip, path);
      @@ builtin/update-index.c: static int unresolve_one(const char *path)
     - 	pos = index_name_pos(istate, path, namelen);
     + 	pos = index_name_pos(repo->index, path, namelen);
       	if (0 <= pos) {
       		/* already merged */
      -		pos = unmerge_cache_entry_at(pos);
     -+		pos = unmerge_index_entry_at(istate, pos);
     - 		if (pos < istate->cache_nr) {
     - 			const struct cache_entry *ce = istate->cache[pos];
     ++		pos = unmerge_index_entry_at(repo->index, pos);
     + 		if (pos < repo->index->cache_nr) {
     + 			const struct cache_entry *ce = repo->index->cache[pos];
       			if (ce_stage(ce) &&
      @@ builtin/update-index.c: struct refresh_params {
       static int refresh(struct refresh_params *o, unsigned int flag)
     @@ builtin/update-index.c: struct refresh_params {
      -	read_cache();
      -	*o->has_errors |= refresh_cache(o->flags | flag);
      +	repo_read_index(repo);
     -+	*o->has_errors |= refresh_index(istate, o->flags | flag,
     ++	*o->has_errors |= refresh_index(repo->index, o->flags | flag,
      +					NULL, NULL, NULL);
       	return 0;
       }
     @@ builtin/update-index.c: static int resolve_undo_clear_callback(const struct opti
       	BUG_ON_OPT_NEG(unset);
       	BUG_ON_OPT_ARG(arg);
      -	resolve_undo_clear();
     -+	resolve_undo_clear_index(istate);
     ++	resolve_undo_clear_index(repo->index);
       	return 0;
       }
       
 11:  f1cffe2b455 = 11:  e9d4fa613a6 update-index: remove ce_match_stat(), all macros
 12:  79e267f39ec ! 12:  4754a9214ee update-index: reduce static globals, part 1
     @@ Commit message
          static globals by modifying method prototypes to use them when
          necessary.
      
     -    Move these static globals further down in the file so we can identify
     -    which method only need to add a 'struct index_state *istate' parameter.
     -    The only changes included here adjust method prototypes and their call
     -    locations.
     +    Remove the 'istate' static global in favor of method parameters. This
     +    adjusts some callers, which either use their own 'istate' parameter or
     +    'repo->index'.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/update-index.c ##
     -@@ builtin/update-index.c: static int ignore_skip_worktree_entries;
     - #define UNMARK_FLAG 2
     - static struct strbuf mtime_dir = STRBUF_INIT;
     - 
     --static struct repository *repo;
     --static struct index_state *istate;
     --
     - /* Untracked cache mode */
     - enum uc_mode {
     - 	UC_UNSPECIFIED = -1,
      @@ builtin/update-index.c: static int test_if_untracked_cache_is_supported(void)
       	return ret;
       }
       
     +-static struct index_state *istate;
     +-
      -static int mark_ce_flags(const char *path, int flag, int mark)
      +static int mark_ce_flags(struct index_state *istate,
      +			 const char *path, int flag, int mark)
     @@ builtin/update-index.c: static void read_index_info(int nul_term_line)
       				die("git update-index: unable to update %s",
       				    path_name);
       		}
     -@@ builtin/update-index.c: static const char * const update_index_usage[] = {
     - static struct object_id head_oid;
     - static struct object_id merge_head_oid;
     - 
     -+static struct repository *repo;
     -+static struct index_state *istate;
     -+
     - static struct cache_entry *read_one_ent(const char *which,
     - 					struct object_id *ent, const char *path,
     - 					int namelen, int stage)
      @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
       		 */
     - 		save_nr = istate->cache_nr;
     + 		save_nr = repo->index->cache_nr;
       		path = xstrdup(ce->name);
      -		update_one(path);
     -+		update_one(istate, path);
     ++		update_one(repo->index, path);
       		free(path);
       		discard_cache_entry(old);
     - 		if (save_nr != istate->cache_nr)
     + 		if (save_nr != repo->index->cache_nr)
      @@ builtin/update-index.c: static enum parse_opt_result cacheinfo_callback(
       	BUG_ON_OPT_ARG(arg);
       
       	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
      -		if (add_cacheinfo(mode, &oid, path, 0))
     -+		if (add_cacheinfo(istate, mode, &oid, path, 0))
     ++		if (add_cacheinfo(repo->index, mode, &oid, path, 0))
       			die("git update-index: --cacheinfo cannot add %s", path);
       		ctx->argv++;
       		ctx->argc--;
     @@ builtin/update-index.c: static enum parse_opt_result cacheinfo_callback(
       	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
       	    get_oid_hex(*++ctx->argv, &oid) ||
      -	    add_cacheinfo(mode, &oid, *++ctx->argv, 0))
     -+	    add_cacheinfo(istate, mode, &oid, *++ctx->argv, 0))
     ++	    add_cacheinfo(repo->index, mode, &oid, *++ctx->argv, 0))
       		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
       	ctx->argc -= 3;
       	return 0;
     @@ builtin/update-index.c: static enum parse_opt_result stdin_cacheinfo_callback(
       		return error("option '%s' must be the last argument", opt->long_name);
       	allow_add = allow_replace = allow_remove = 1;
      -	read_index_info(*nul_term_line);
     -+	read_index_info(istate, *nul_term_line);
     ++	read_index_info(repo->index, *nul_term_line);
       	return 0;
       }
       
     +@@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     + 	if (entries < 0)
     + 		die("cache corrupted");
     + 
     +-	istate = repo->index;
     + 	repo->index->updated_skipworktree = 1;
     + 
     + 	/*
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
       
       			setup_work_tree();
       			p = prefix_path(prefix, prefix_length, path);
      -			update_one(p);
     -+			update_one(istate, p);
     ++			update_one(repo->index, p);
       			if (set_executable_bit)
      -				chmod_path(set_executable_bit, p);
     -+				chmod_path(istate, set_executable_bit, p);
     ++				chmod_path(repo->index, set_executable_bit, p);
       			free(p);
       			ctx.argc--;
       			ctx.argv++;
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       			}
       			p = prefix_path(prefix, prefix_length, buf.buf);
      -			update_one(p);
     -+			update_one(istate, p);
     ++			update_one(repo->index, p);
       			if (set_executable_bit)
      -				chmod_path(set_executable_bit, p);
     -+				chmod_path(istate, set_executable_bit, p);
     ++				chmod_path(repo->index, set_executable_bit, p);
       			free(p);
       		}
       		strbuf_release(&unquoted);
 13:  457402b4fdc ! 13:  a9185af4740 update-index: reduce static globals, part 2
     @@ Commit message
          static globals by modifying method prototypes to use them when
          necessary.
      
     -    Move these static globals further down the file so we can identify which
     -    methods need both 'struct repository *repo' and 'struct index_state
     -    *istate' parameters. The only changes included here adjust method
     -    prototypes and their call locations.
     +    Move the remaining 'struct repository *repo' further down the file and
     +    use method parameters to pass it around instead.
      
     -    The only remaining change is to remove the static globals entirely, but
     +    The only remaining change is to remove the static global entirely, but
          that requires updating the parse-opt callbacks, which need a different
          solution.
      
     @@ Commit message
      
       ## builtin/update-index.c ##
      @@ builtin/update-index.c: static const char * const update_index_usage[] = {
     + 
       static struct object_id head_oid;
       static struct object_id merge_head_oid;
     - 
      -static struct repository *repo;
     --static struct index_state *istate;
     --
     + 
      -static struct cache_entry *read_one_ent(const char *which,
      +static struct cache_entry *read_one_ent(struct repository *repo,
     -+					struct index_state *istate,
      +					const char *which,
       					struct object_id *ent, const char *path,
       					int namelen, int stage)
     @@ builtin/update-index.c: static struct cache_entry *read_one_ent(const char *whic
       
      -static int unresolve_one(const char *path)
      +static int unresolve_one(struct repository *repo,
     -+			 struct index_state *istate,
      +			 const char *path)
       {
       	int namelen = strlen(path);
     @@ builtin/update-index.c: static int unresolve_one(const char *path)
       	 */
      -	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
      -	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
     -+	ce_2 = read_one_ent(repo, istate, "our", &head_oid, path, namelen, 2);
     -+	ce_3 = read_one_ent(repo, istate, "their", &merge_head_oid, path, namelen, 3);
     ++	ce_2 = read_one_ent(repo, "our", &head_oid, path, namelen, 2);
     ++	ce_3 = read_one_ent(repo, "their", &merge_head_oid, path, namelen, 3);
       
       	if (!ce_2 || !ce_3) {
       		ret = -1;
     @@ builtin/update-index.c: static void read_head_pointers(void)
       
      -static int do_unresolve(int ac, const char **av,
      +static int do_unresolve(struct repository *repo,
     -+			struct index_state *istate,
      +			int ac, const char **av,
       			const char *prefix, int prefix_length)
       {
     @@ builtin/update-index.c: static int do_unresolve(int ac, const char **av,
       		const char *arg = av[i];
       		char *p = prefix_path(prefix, prefix_length, arg);
      -		err |= unresolve_one(p);
     -+		err |= unresolve_one(repo, istate, p);
     ++		err |= unresolve_one(repo, p);
       		free(p);
       	}
       	return err;
     @@ builtin/update-index.c: static int do_unresolve(int ac, const char **av,
       
      -static int do_reupdate(int ac, const char **av,
      +static int do_reupdate(struct repository *repo,
     -+		       struct index_state *istate,
      +		       int ac, const char **av,
       		       const char *prefix)
       {
       	/* Read HEAD and run update-index on paths that are
      @@ builtin/update-index.c: static int do_reupdate(int ac, const char **av,
     - 		if (ce_stage(ce) || !ce_path_match(istate, ce, &pathspec, NULL))
     + 		if (ce_stage(ce) || !ce_path_match(repo->index, ce, &pathspec, NULL))
       			continue;
       		if (has_head)
      -			old = read_one_ent(NULL, &head_oid,
     -+			old = read_one_ent(repo, istate, NULL, &head_oid,
     ++			old = read_one_ent(repo, NULL, &head_oid,
       					   ce->name, ce_namelen(ce), 0);
       		if (old && ce->ce_mode == old->ce_mode &&
       		    oideq(&ce->oid, &old->oid)) {
     @@ builtin/update-index.c: struct refresh_params {
       };
       
      +static struct repository *repo;
     -+static struct index_state *istate;
      +
       static int refresh(struct refresh_params *o, unsigned int flag)
       {
     @@ builtin/update-index.c: static enum parse_opt_result unresolve_callback(
       	/* consume remaining arguments. */
      -	*has_errors = do_unresolve(ctx->argc, ctx->argv,
      -				prefix, prefix ? strlen(prefix) : 0);
     -+	*has_errors = do_unresolve(repo, istate, ctx->argc, ctx->argv,
     ++	*has_errors = do_unresolve(repo, ctx->argc, ctx->argv,
      +				   prefix, prefix ? strlen(prefix) : 0);
       	if (*has_errors)
     - 		istate->cache_changed = 0;
     + 		repo->index->cache_changed = 0;
       
      @@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
       
       	/* consume remaining arguments. */
       	setup_work_tree();
      -	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
     -+	*has_errors = do_reupdate(repo, istate, ctx->argc, ctx->argv, prefix);
     ++	*has_errors = do_reupdate(repo, ctx->argc, ctx->argv, prefix);
       	if (*has_errors)
     - 		istate->cache_changed = 0;
     + 		repo->index->cache_changed = 0;
       
 14:  2b171a142b3 ! 14:  414ef816845 update-index: remove static globals from callbacks
     @@ Commit message
          callback value.
      
          Unify these callback methods to use a consistent 'struct callback_data'
     -    that contains 'repo' and 'istate', ready to use. This takes the place of
     +    that contains a 'repo' member, ready to use. This takes the place of
          the previous 'struct refresh_params' which served only to group the
          'flags' and 'has_errors' ints. We also collect other one-off settings,
          but only those that require access to the index or repository in their
     @@ builtin/update-index.c: static int do_reupdate(struct repository *repo,
      -struct refresh_params {
      +struct callback_data {
      +	struct repository *repo;
     -+	struct index_state *istate;
      +
       	unsigned int flags;
      -	int *has_errors;
     @@ builtin/update-index.c: static int do_reupdate(struct repository *repo,
       };
       
      -static struct repository *repo;
     --static struct index_state *istate;
      -
      -static int refresh(struct refresh_params *o, unsigned int flag)
      +static int refresh(struct callback_data *cd, unsigned int flag)
       {
       	setup_work_tree();
      -	repo_read_index(repo);
     --	*o->has_errors |= refresh_index(istate, o->flags | flag,
     +-	*o->has_errors |= refresh_index(repo->index, o->flags | flag,
      +	repo_read_index(cd->repo);
     -+	cd->has_errors |= refresh_index(cd->istate, cd->flags | flag,
     ++	cd->has_errors |= refresh_index(cd->repo->index, cd->flags | flag,
       					NULL, NULL, NULL);
       	return 0;
       }
     @@ builtin/update-index.c: static int chmod_callback(const struct option *opt,
      +	struct callback_data *cd = opt->value;
       	BUG_ON_OPT_NEG(unset);
       	BUG_ON_OPT_ARG(arg);
     --	resolve_undo_clear_index(istate);
     -+	resolve_undo_clear_index(cd->istate);
     +-	resolve_undo_clear_index(repo->index);
     ++	resolve_undo_clear_index(cd->repo->index);
       	return 0;
       }
       
     @@ builtin/update-index.c: static enum parse_opt_result cacheinfo_callback(
       	BUG_ON_OPT_ARG(arg);
       
       	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
     --		if (add_cacheinfo(istate, mode, &oid, path, 0))
     -+		if (add_cacheinfo(cd->istate, mode, &oid, path, 0))
     +-		if (add_cacheinfo(repo->index, mode, &oid, path, 0))
     ++		if (add_cacheinfo(cd->repo->index, mode, &oid, path, 0))
       			die("git update-index: --cacheinfo cannot add %s", path);
       		ctx->argv++;
       		ctx->argc--;
     @@ builtin/update-index.c: static enum parse_opt_result cacheinfo_callback(
       		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
       	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
       	    get_oid_hex(*++ctx->argv, &oid) ||
     --	    add_cacheinfo(istate, mode, &oid, *++ctx->argv, 0))
     -+	    add_cacheinfo(cd->istate, mode, &oid, *++ctx->argv, 0))
     +-	    add_cacheinfo(repo->index, mode, &oid, *++ctx->argv, 0))
     ++	    add_cacheinfo(cd->repo->index, mode, &oid, *++ctx->argv, 0))
       		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
       	ctx->argc -= 3;
       	return 0;
     @@ builtin/update-index.c: static enum parse_opt_result stdin_cacheinfo_callback(
       	if (ctx->argc != 1)
       		return error("option '%s' must be the last argument", opt->long_name);
       	allow_add = allow_replace = allow_remove = 1;
     --	read_index_info(istate, *nul_term_line);
     -+	read_index_info(cd->istate, cd->nul_term_line);
     +-	read_index_info(repo->index, *nul_term_line);
     ++	read_index_info(cd->repo->index, cd->nul_term_line);
       	return 0;
       }
       
     @@ builtin/update-index.c: static enum parse_opt_result unresolve_callback(
       	BUG_ON_OPT_ARG(arg);
       
       	/* consume remaining arguments. */
     --	*has_errors = do_unresolve(repo, istate, ctx->argc, ctx->argv,
     +-	*has_errors = do_unresolve(repo, ctx->argc, ctx->argv,
      -				   prefix, prefix ? strlen(prefix) : 0);
      -	if (*has_errors)
     --		istate->cache_changed = 0;
     -+	cd->has_errors = do_unresolve(cd->repo, cd->istate, ctx->argc, ctx->argv,
     +-		repo->index->cache_changed = 0;
     ++	cd->has_errors = do_unresolve(cd->repo, ctx->argc, ctx->argv,
      +				      prefix, prefix ? strlen(prefix) : 0);
      +	if (cd->has_errors)
     -+		cd->istate->cache_changed = 0;
     ++		cd->repo->index->cache_changed = 0;
       
       	ctx->argv += ctx->argc - 1;
       	ctx->argc = 1;
     @@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
       
       	/* consume remaining arguments. */
       	setup_work_tree();
     --	*has_errors = do_reupdate(repo, istate, ctx->argc, ctx->argv, prefix);
     +-	*has_errors = do_reupdate(repo, ctx->argc, ctx->argv, prefix);
      -	if (*has_errors)
     --		istate->cache_changed = 0;
     -+	cd->has_errors = do_reupdate(cd->repo, cd->istate,
     -+				     ctx->argc, ctx->argv, prefix);
     +-		repo->index->cache_changed = 0;
     ++	cd->has_errors = do_reupdate(cd->repo, ctx->argc, ctx->argv, prefix);
      +	if (cd->has_errors)
     -+		cd->istate->cache_changed = 0;
     ++		cd->repo->index->cache_changed = 0;
       
       	ctx->argv += ctx->argc - 1;
       	ctx->argc = 1;
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       	struct parse_opt_ctx_t ctx;
       	strbuf_getline_fn getline_fn;
       	int parseopt_state = PARSE_OPT_UNKNOWN;
     -+	struct index_state *istate;
      +
       	struct option options[] = {
      -		OPT_BIT('q', NULL, &refresh_args.flags,
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       	newfd = repo_hold_locked_index(repo, &lock_file, 0);
       	if (newfd < 0)
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     - 	if (entries < 0)
       		die("cache corrupted");
       
     --	istate = repo->index;
     + 	repo->index->updated_skipworktree = 1;
      +	cd.repo = repo;
     -+	cd.istate = istate = repo->index;
     - 	istate->updated_skipworktree = 1;
      +	cd.flags = 0;
      +	cd.has_errors = 0;
      +	cd.nul_term_line = 0;
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       		if (preferred_index_format < INDEX_FORMAT_LB ||
       		    INDEX_FORMAT_UB < preferred_index_format)
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
     - 		istate->version = preferred_index_format;
     + 		repo->index->version = preferred_index_format;
       	}
       
      -	if (read_from_stdin) {
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       					die("line is badly quoted");
      @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const char *prefix)
       
     - 	if (istate->cache_changed || force_write) {
     + 	if (repo->index->cache_changed || force_write) {
       		if (newfd < 0) {
      -			if (refresh_args.flags & REFRESH_QUIET)
      +			if (cd.flags & REFRESH_QUIET)

-- 
gitgitgadget

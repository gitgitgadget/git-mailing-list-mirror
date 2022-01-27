Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A296C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbiA0QXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiA0QXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E5C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e2so5800387wra.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9oR+m8SE8z8MPHNmrD50iT4rJLrwxn30It5Adu9u2w=;
        b=Xe2YS5uJfqkm0alYW/PTslyhAXZFqVXPREX5G8ZhcQH0YcVWgzLnpcCbdboGJQJdFa
         ZmQmNP6W5hf+p9OGtnn9lmEGew0htyuwOwqOCHbLGUeYoCrVuan9BINQeyb+sLXX0hpQ
         icbJvGamzMcNZV09oDX1vUzPfRHaN1eSPIf9afdkht96esG5t+whzcu76LhFYkMEtc08
         Kg7R/IkeefdsbyPcZSspm0b+I3YKDDx03EaTa4L3HzRrUesUcdiFc5VM1b+e+plr0zz4
         +cjSb0T49FVwCdIWfPk4wq7xA+JNz4wdK3SfZlITrGDV13Ynwb49QTrNjxVaIN7UU9tO
         Lqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9oR+m8SE8z8MPHNmrD50iT4rJLrwxn30It5Adu9u2w=;
        b=SnADV8cxLukwK63lQJ1SIvh/CPBclwFVxLjoqmvWIyPFzhzk8c5cJU9Bp956fBPiQs
         dluCXyoWuYSKdhvZYvYcnYzlBw+/4/pxApC3RUMLhWpB/uqYfCrnsljyKW3FZOkk/4FX
         QCUllzp3G4DJttvFc5ce0ap7oG77yrlaHRnQyG38pFoHCoygQcR7fhmzMnZv3rDD1PHw
         jSsZMdM/Frt4lPKX/EcaF4YLghyT+RpleIcktkRM2sm6o9pO9nkFFYDuniDzwK4o2oWn
         BUZXjyviVWRX1m3TQ6TX57eG28McqC5kE8+r9GkJsWX6IJvfrmFMh4iDheHFwmpauXb3
         8pwA==
X-Gm-Message-State: AOAM531PXrg96T1iQbh3Wo9PJ2E2J1EIEaY1VrdYmte3RYNgF/Pw1QpW
        +XPsn13VM9wR533Ash/FUB4Iu3X/KiN4iA==
X-Google-Smtp-Source: ABdhPJzhFmGqPaTqHdSkGjgqDJS0RcpYzygoCwIM7Fyhi2zOQIgNBqvXhG4PUAzPZL1+tv1VKA3d+A==
X-Received: by 2002:a5d:4703:: with SMTP id y3mr3778596wrq.277.1643300581076;
        Thu, 27 Jan 2022 08:23:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] submodule: convert the rest of 'update' to C
Date:   Thu, 27 Jan 2022 17:22:49 +0100
Message-Id: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series rewrites "git submodule update" in C. It's a rebased and
re-rolled version of v3[1] submitted back in October. Per [2] the
author doesn't have time to push it forward now.

There was discussion in the thread at [2] about the interaction
between this and es/superproject-aware-submodules.

Per [3] I think it would be better to get this in first, as the big
outstanding question about the superproject aware submodules[3] was
whether it was an optimization or not. It's currently an optimization,
but whether it's needed is muddied by "git-submodule.sh" being a
shellscript and invoking "git rev-parse" in a loop, which a version
rebased on this could do in C.

Per the v3 CL of this series[1] there is a C version of the required
code for es/superproject-aware-submodules, but when I tried to rebase
it it failed because it's based on an older version of
es/superproject-aware-submodules which linked to the .git dir rather
than the working tree.

I.e. the C code[4] produces "../.git" in the tests, but we're
expecting "../..". I couldn't find the right API to get that path from
path.c et al, but it's presumably easy for someone more familiar with
it.

As for changes in this v4:

 * Rebased on master, it didn't compile due to my changes to the
   refs_resolve_ref_unsafe() API.

 * There was some back & forth about large patches v.s. split-up
   commits in previous iterations. This version squashes several
   patches together, because I thought a rename/add/removal of code
   that's all related (and really can only be done as one logical step
   without a major rewrite) was easier to look at than having to jump
   back and forth in the series.

   The resulting diff is large, but I think it's better than looking
   at it piecemeal. You can see what new code replaces what old code.

 * There's new formatting-only changes in [56]/7 that I added to make
   the 7/7 diff a tad smaller.

   The gitster/ar/submodule-update~3..gitster/ar/submodule-update diff
   (the real meat of the series) is "402 insertions(+), 422
   deletions(-)", and 7/7 here is "389 insertions(+), 418
   deletions(-)".

   So it's not much, but thaht churn before 7/7 makes the big change a
   bit logical change at the end easier to reason about.

 * I fixed a strbuf and string_list memory leak in the new code, and
   simplified one codepath that freed correctly, but could use a "goto
   cleanup" pattern to do away with duplication.

   There's still a *lot* of memory leaks in
   builtin/submodule--helper.c, but they're all (well, to the extent
   that I can extract signal from the noise) in existing code, or in
   generic APIs that uses which leak.

1. https://lore.kernel.org/git/20211013051805.45662-1-raykar.ath@gmail.com/
2. https://lore.kernel.org/git/CADi-XoThCqfvPnBd0p6yAhrtotK_3z2pQQMugWPsYpHLbXge7w@mail.gmail.com/
3. https://lore.kernel.org/git/211203.86o85xqw7o.gmgdl@evledraar.gmail.com/
4. https://github.com/tfidfwastaken/git/blob/a74aaf2540c536970f2541d3042c825f82a69770/builtin/submodule--helper.c#L2922-L2930

Atharva Raykar (6):
  submodule--helper: get remote names from any repository
  submodule--helper: refactor get_submodule_displaypath()
  submodule--helper: allow setting superprefix for init_submodule()
  submodule--helper: run update using child process struct
  builtin/submodule--helper.c: reformat designated initializers
  submodule: move core cmd_update() logic to C

Ævar Arnfjörð Bjarmason (1):
  builtin/submodule--helper.c: rename "suc" variable to "opt"

 builtin/submodule--helper.c | 758 +++++++++++++++++++++---------------
 git-submodule.sh            | 145 +------
 2 files changed, 449 insertions(+), 454 deletions(-)

Range-diff against v3:
 1:  775f7c01ddb <  -:  ----------- submodule--helper: split up ensure_core_worktree()
 2:  fe3d30c1160 !  1:  1a0b1323cd7 submodule--helper: get remote names from any repository
    @@ Commit message
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@
    @@ builtin/submodule--helper.c: static char *get_default_remote(void)
     +{
     +	const char *refname;
     +	struct repository subrepo;
    ++	int ignore_errno;
     +
     +	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
    -+					  "HEAD", 0, NULL, NULL);
    ++					  "HEAD", 0, NULL, NULL,
    ++					  &ignore_errno);
     +	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
     +	return repo_get_default_remote(&subrepo, refname);
     +}
 3:  8085571a7cb <  -:  ----------- submodule--helper: rename helpers for update-clone
 4:  18c551543ed !  2:  7e2df3ff220 submodule--helper: refactor get_submodule_displaypath()
    @@ Commit message
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 5:  2be0453750a !  3:  f31fd72fba2 submodule--helper: allow setting superprefix for init_submodule()
    @@ Commit message
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
    @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **ar
     +	const char *superprefix;
      	unsigned int flags;
      };
    --#define INIT_CB_INIT { NULL, 0 }
    -+#define INIT_CB_INIT { 0 }
    + #define INIT_CB_INIT { 0 }
      
      static void init_submodule(const char *path, const char *prefix,
     -			   unsigned int flags)
 6:  a882b53177d !  4:  76c5a826a80 submodule--helper: run update using child process struct
    @@ Commit message
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 -:  ----------- >  5:  29aa2fc0851 builtin/submodule--helper.c: reformat designated initializers
 -:  ----------- >  6:  d3ad6e7a351 builtin/submodule--helper.c: rename "suc" variable to "opt"
 7:  3092469f380 !  7:  02954603763 submodule: move core cmd_update() logic to C
    @@ Commit message
         `submodule--helper update`, with a modified `--recursive-prefix` and
         `--prefix` parameter.
     
    -    We also introduce `update_submodules()` and `update_submodule()` which
    -    are quite similar to `update_clone_submodules()` and
    -    `update_clone_submodule()`, and will supersede them.
    +    We also introduce `update_submodules2()` and `update_submodule2()`
    +    which will supersede `update_submodules()` and `update_submodule()`.
     
         When the `--init` flag is passed to the subcommand, we do not spawn a
         new subprocess and call `submodule--helper init` on the submodule paths,
    @@ Commit message
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    +@@ builtin/submodule--helper.c: static char *get_default_remote(void)
    + 	return repo_get_default_remote(the_repository, refname);
    + }
    + 
    +-static int print_default_remote(int argc, const char **argv, const char *prefix)
    +-{
    +-	char *remote;
    +-
    +-	if (argc != 1)
    +-		die(_("submodule--helper print-default-remote takes no arguments"));
    +-
    +-	remote = get_default_remote();
    +-	if (remote)
    +-		printf("%s\n", remote);
    +-
    +-	free(remote);
    +-	return 0;
    +-}
    +-
    + static int starts_with_dot_slash(const char *str)
    + {
    + 	return str[0] == '.' && is_dir_sep(str[1]);
    +@@ builtin/submodule--helper.c: static void determine_submodule_update_strategy(struct repository *r,
    + 	free(key);
    + }
    + 
    +-static int module_update_module_mode(int argc, const char **argv, const char *prefix)
    +-{
    +-	const char *path, *update = NULL;
    +-	int just_cloned;
    +-	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
    +-
    +-	if (argc < 3 || argc > 4)
    +-		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
    +-
    +-	just_cloned = git_config_int("just_cloned", argv[1]);
    +-	path = argv[2];
    +-
    +-	if (argc == 4)
    +-		update = argv[3];
    +-
    +-	determine_submodule_update_strategy(the_repository,
    +-					    just_cloned, path, update,
    +-					    &update_strategy);
    +-	fputs(submodule_strategy_to_string(&update_strategy), stdout);
    +-
    +-	return 0;
    +-}
    +-
    + struct update_clone_data {
    + 	const struct submodule *sub;
    + 	struct object_id oid;
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	const char *prefix;
      	int single_branch;
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	const char *displaypath;
      	struct object_id oid;
      	struct object_id suboid;
    --	struct submodule_update_strategy update_strategy;
    + 	struct submodule_update_strategy update_strategy;
     +	int max_jobs;
      	int depth;
    +-	unsigned int force: 1;
    +-	unsigned int quiet: 1;
    +-	unsigned int nofetch: 1;
    +-	unsigned int just_cloned: 1;
     +	int recommend_shallow;
     +	int single_branch;
    -+	unsigned int init: 1;
    - 	unsigned int force: 1;
    - 	unsigned int quiet: 1;
    - 	unsigned int nofetch: 1;
    --	unsigned int just_cloned: 1;
    -+	unsigned int remote: 1;
    -+	unsigned int recursive: 1;
    -+	unsigned int progress: 1;
    -+	unsigned int dissociate: 1;
    -+	unsigned int require_init: 1;
    -+	unsigned warn_if_uninitialized : 1;
    -+	unsigned int just_cloned : 1;
    -+	struct submodule_update_strategy update_strategy;
    ++	unsigned int init;
    ++	unsigned int force;
    ++	unsigned int quiet;
    ++	unsigned int nofetch;
    ++	unsigned int remote;
    ++	unsigned int recursive;
    ++	unsigned int progress;
    ++	unsigned int dissociate;
    ++	unsigned int require_init;
    ++	unsigned warn_if_uninitialized ;
    ++	unsigned int just_cloned ;
     +	struct string_list references;
     +	struct module_list list;
      };
    --#define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
    -+#define UPDATE_DATA_INIT { \
    + #define UPDATE_DATA_INIT { \
     +	.list = MODULE_LIST_INIT, \
    -+	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
    + 	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
     +	.recommend_shallow = -1, \
     +	.references = STRING_LIST_INIT_DUP, \
     +	.single_branch = -1, \
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
     +		for_each_string_list_item(item, &update_data->references)
     +			string_list_append(&suc->references, item->string);
     +	}
    -+}
    + }
      
      static void next_submodule_warn_missing(struct submodule_update_clone *suc,
    - 		struct strbuf *out, const char *displaypath)
     @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
      	return run_command(&cp);
      }
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
     +		}
     +
     +		/* the command failed, but update must continue */
    -+		string_list_append(err, out.buf);
    ++		string_list_append_nodup(err, strbuf_detach(&out, NULL));
     +		return 1;
     +	}
     +
    @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *u
     -		    submodule_strategy_to_string(&ud->update_strategy));
      	}
      
    ++	strbuf_release(&out);
      	return 0;
      }
      
     -static int do_run_update_procedure(struct update_data *ud)
    -+static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
    ++static int run_update_procedure(struct update_data *ud, struct string_list *err)
      {
      	int subforce = is_null_oid(&ud->suboid) || ud->force;
      
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_da
      	}
      
     -	return run_update_command(ud, subforce);
    +-}
    +-
    +-static void update_submodule(struct update_clone_data *ucd)
    +-{
    +-	fprintf(stdout, "dummy %s %d\t%s\n",
    +-		oid_to_hex(&ucd->oid),
    +-		ucd->just_cloned,
    +-		ucd->sub->path);
    +-}
    +-
    +-static int update_submodules(struct submodule_update_clone *suc)
    +-{
    +-	int i;
    +-
    +-	run_processes_parallel_tr2(suc->max_jobs, update_clone_get_next_task,
    +-				   update_clone_start_failure,
    +-				   update_clone_task_finished, suc, "submodule",
    +-				   "parallel/update");
    +-
    +-	/*
    +-	 * We saved the output and put it out all at once now.
    +-	 * That means:
    +-	 * - the listener does not have to interleave their (checkout)
    +-	 *   work with our fetching.  The writes involved in a
    +-	 *   checkout involve more straightforward sequential I/O.
    +-	 * - the listener can avoid doing any work if fetching failed.
    +-	 */
    +-	if (suc->quickstop)
    +-		return 1;
    +-
    +-	for (i = 0; i < suc->update_clone_nr; i++)
    +-		update_submodule(&suc->update_clone[i]);
    +-
    +-	return 0;
    +-}
    +-
    +-static int update_clone(int argc, const char **argv, const char *prefix)
    +-{
    +-	const char *update = NULL;
    +-	struct pathspec pathspec;
    +-	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
    +-
    +-	struct option module_update_clone_options[] = {
    +-		OPT_STRING(0, "prefix", &prefix,
    +-			   N_("path"),
    +-			   N_("path into the working tree")),
    +-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
    +-			   N_("path"),
    +-			   N_("path into the working tree, across nested "
    +-			      "submodule boundaries")),
    +-		OPT_STRING(0, "update", &update,
    +-			   N_("string"),
    +-			   N_("rebase, merge, checkout or none")),
    +-		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
    +-			   N_("reference repository")),
    +-		OPT_BOOL(0, "dissociate", &opt.dissociate,
    +-			   N_("use --reference only while cloning")),
    +-		OPT_STRING(0, "depth", &opt.depth, "<depth>",
    +-			   N_("create a shallow clone truncated to the "
    +-			      "specified number of revisions")),
    +-		OPT_INTEGER('j', "jobs", &opt.max_jobs,
    +-			    N_("parallel jobs")),
    +-		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
    +-			    N_("whether the initial clone should follow the shallow recommendation")),
    +-		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
    +-		OPT_BOOL(0, "progress", &opt.progress,
    +-			    N_("force cloning progress")),
    +-		OPT_BOOL(0, "require-init", &opt.require_init,
    +-			   N_("disallow cloning into non-empty directory")),
    +-		OPT_BOOL(0, "single-branch", &opt.single_branch,
    +-			 N_("clone only one branch, HEAD or --branch")),
    +-		OPT_END()
    +-	};
    +-
    +-	const char *const git_submodule_helper_usage[] = {
    +-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
    +-		NULL
    +-	};
    +-	opt.prefix = prefix;
    +-
    +-	update_clone_config_from_gitmodules(&opt.max_jobs);
    +-	git_config(git_update_clone_config, &opt.max_jobs);
    +-
    +-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
    +-			     git_submodule_helper_usage, 0);
    +-
    +-	if (update)
    +-		if (parse_submodule_update_strategy(update, &opt.update) < 0)
    +-			die(_("bad value for update parameter"));
    +-
    +-	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
    +-		return 1;
    +-
    +-	if (pathspec.nr)
    +-		opt.warn_if_uninitialized = 1;
    +-
    +-	return update_submodules(&opt);
    +-}
    +-
    +-static int run_update_procedure(int argc, const char **argv, const char *prefix)
    +-{
    +-	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
    +-	char *prefixed_path, *update = NULL;
    +-	struct update_data update_data = UPDATE_DATA_INIT;
    +-
    +-	struct option options[] = {
    +-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
    +-		OPT__FORCE(&force, N_("force checkout updates"), 0),
    +-		OPT_BOOL('N', "no-fetch", &nofetch,
    +-			 N_("don't fetch new objects from the remote site")),
    +-		OPT_BOOL(0, "just-cloned", &just_cloned,
    +-			 N_("overrides update mode in case the repository is a fresh clone")),
    +-		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch")),
    +-		OPT_STRING(0, "prefix", &prefix,
    +-			   N_("path"),
    +-			   N_("path into the working tree")),
    +-		OPT_STRING(0, "update", &update,
    +-			   N_("string"),
    +-			   N_("rebase, merge, checkout or none")),
    +-		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix, N_("path"),
    +-			   N_("path into the working tree, across nested "
    +-			      "submodule boundaries")),
    +-		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
    +-			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
    +-			       parse_opt_object_id),
    +-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
    +-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
    +-			       parse_opt_object_id),
    +-		OPT_END()
    +-	};
    +-
    +-	const char *const usage[] = {
    +-		N_("git submodule--helper run-update-procedure [<options>] <path>"),
    +-		NULL
    +-	};
    +-
    +-	argc = parse_options(argc, argv, prefix, options, usage, 0);
    +-
    +-	if (argc != 1)
    +-		usage_with_options(usage, options);
    +-
    +-	update_data.force = !!force;
    +-	update_data.quiet = !!quiet;
    +-	update_data.nofetch = !!nofetch;
    +-	update_data.just_cloned = !!just_cloned;
    +-	update_data.sm_path = argv[0];
    +-
    +-	if (update_data.recursive_prefix)
    +-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
    +-	else
    +-		prefixed_path = xstrdup(update_data.sm_path);
    +-
    +-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
    +-
    +-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
    +-					    update_data.sm_path, update,
    +-					    &update_data.update_strategy);
    +-
    +-	free(prefixed_path);
    +-
    +-	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
    +-		return do_run_update_procedure(&update_data);
    +-
    +-	return 3;
    +-}
    +-
    +-static int resolve_relative_path(int argc, const char **argv, const char *prefix)
    +-{
    +-	struct strbuf sb = STRBUF_INIT;
    +-	if (argc != 3)
    +-		die("submodule--helper relative-path takes exactly 2 arguments, got %d", argc);
    +-
    +-	printf("%s", relative_path(argv[1], argv[2], &sb));
    +-	strbuf_release(&sb);
    +-	return 0;
     +	return run_update_command(ud, subforce, err);
      }
      
    - static void update_clone_submodule(struct update_clone_data *ucd)
    -@@ builtin/submodule--helper.c: static int run_update_procedure(int argc, const char **argv, const char *prefix)
    - 	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
    - 	char *prefixed_path, *update = NULL;
    - 	struct update_data update_data = UPDATE_DATA_INIT;
    -+	struct string_list err = STRING_LIST_INIT_DUP;
    + static const char *remote_submodule_branch(const char *path)
    +@@ builtin/submodule--helper.c: static int push_check(int argc, const char **argv, const char *prefix)
    + 	return 0;
    + }
      
    - 	struct option options[] = {
    - 		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
    -@@ builtin/submodule--helper.c: static int run_update_procedure(int argc, const char **argv, const char *prefix)
    - 	free(prefixed_path);
    +-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
    ++static void ensure_core_worktree(const char *path)
    + {
    +-	const char *path;
    + 	const char *cw;
    + 	struct repository subrepo;
      
    - 	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
    --		return do_run_update_procedure(&update_data);
    -+		return do_run_update_procedure(&update_data, &err);
    +-	if (argc != 2)
    +-		BUG("submodule--helper ensure-core-worktree <path>");
    +-
    +-	path = argv[1];
    +-
    + 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
    + 		die(_("could not get a repository handle for submodule '%s'"), path);
      
    - 	return 3;
    +@@ builtin/submodule--helper.c: static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
    + 		free(abs_path);
    + 		strbuf_release(&sb);
    + 	}
    +-
    +-	return 0;
      }
    + 
    + static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
     @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char **argv, const char *prefix)
      	return !!ret;
      }
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +	char *prefixed_path;
     +	struct string_list err = STRING_LIST_INIT_DUP;
     +
    -+	do_ensure_core_worktree(update_data->sm_path);
    ++	ensure_core_worktree(update_data->sm_path);
     +
     +	if (update_data->recursive_prefix)
     +		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
     +
     +		if (!update_data->nofetch) {
    -+			if(fetch_in_submodule(update_data->sm_path, update_data->depth,
    ++			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
     +					      0, NULL))
     +				die(_("Unable to fetch in submodule path '%s'"),
     +				    update_data->sm_path);
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +	}
     +
     +	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
    -+		if (do_run_update_procedure(update_data, &err))
    ++		if (run_update_procedure(update_data, &err))
     +			return 1;
     +
     +	if (update_data->recursive) {
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		struct string_list_item *item;
     +		for_each_string_list_item(item, &err)
     +			fputs(item->string, stderr);
    ++		string_list_clear(&err, 0);
     +		return 1;
     +	}
     +
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +	 * - the listener can avoid doing any work if fetching failed.
     +	 */
     +	if (suc.quickstop) {
    -+		string_list_clear(&update_data->references, 0);
    -+		return 1;
    ++		res = 1;
    ++		goto cleanup;
     +	}
     +
     +	for (i = 0; i < suc.update_clone_nr; i++) {
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +			res = 1;
     +	}
     +
    ++cleanup:
     +	string_list_clear(&update_data->references, 0);
     +	return res;
     +}
     +
     +static int module_update(int argc, const char **argv, const char *prefix)
     +{
    -+	int init = 0, force = 0, quiet = 0, nofetch = 0;
    -+	int remote = 0, recursive = 0, dissociate = 0;
    -+	int progress = 0, require_init = 0;
     +	const char *update = NULL;
     +	struct pathspec pathspec;
    -+	struct update_data update_data = UPDATE_DATA_INIT;
    ++	struct update_data opt = UPDATE_DATA_INIT;
     +
     +	struct option module_update_clone_options[] = {
    -+		OPT__FORCE(&force, N_("force checkout updates"), 0),
    -+		OPT_BOOL(0, "init", &init,
    ++		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
    ++		OPT_BOOL(0, "init", &opt.init,
     +			 N_("initialize uninitialized submodules before update")),
    -+		OPT_BOOL(0, "remote", &remote,
    ++		OPT_BOOL(0, "remote", &opt.remote,
     +			 N_("use SHA-1 of submodule's remote tracking branch")),
    -+		OPT_BOOL(0, "recursive", &recursive,
    ++		OPT_BOOL(0, "recursive", &opt.recursive,
     +			 N_("traverse submodules recursively")),
    -+		OPT_BOOL('N', "no-fetch", &nofetch,
    ++		OPT_BOOL('N', "no-fetch", &opt.nofetch,
     +			 N_("don't fetch new objects from the remote site")),
    -+		OPT_STRING(0, "prefix", &prefix,
    ++		OPT_STRING(0, "prefix", &opt.prefix,
     +			   N_("path"),
     +			   N_("path into the working tree")),
    -+		OPT_STRING(0, "recursive-prefix", &update_data.recursive_prefix,
    ++		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
     +			   N_("path"),
     +			   N_("path into the working tree, across nested "
     +			      "submodule boundaries")),
     +		OPT_STRING(0, "update", &update,
     +			   N_("string"),
     +			   N_("rebase, merge, checkout or none")),
    -+		OPT_STRING_LIST(0, "reference", &update_data.references, N_("repo"),
    ++		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
     +				N_("reference repository")),
    -+		OPT_BOOL(0, "dissociate", &dissociate,
    ++		OPT_BOOL(0, "dissociate", &opt.dissociate,
     +			 N_("use --reference only while cloning")),
    -+		OPT_INTEGER(0, "depth", &update_data.depth,
    ++		OPT_INTEGER(0, "depth", &opt.depth,
     +			    N_("create a shallow clone truncated to the "
     +			       "specified number of revisions")),
    -+		OPT_INTEGER('j', "jobs", &update_data.max_jobs,
    ++		OPT_INTEGER('j', "jobs", &opt.max_jobs,
     +			    N_("parallel jobs")),
    -+		OPT_BOOL(0, "recommend-shallow", &update_data.recommend_shallow,
    ++		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
     +			 N_("whether the initial clone should follow the shallow recommendation")),
    -+		OPT__QUIET(&quiet, N_("don't print cloning progress")),
    -+		OPT_BOOL(0, "progress", &progress,
    ++		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
    ++		OPT_BOOL(0, "progress", &opt.progress,
     +			 N_("force cloning progress")),
    -+		OPT_BOOL(0, "require-init", &require_init,
    ++		OPT_BOOL(0, "require-init", &opt.require_init,
     +			 N_("disallow cloning into non-empty directory")),
    -+		OPT_BOOL(0, "single-branch", &update_data.single_branch,
    ++		OPT_BOOL(0, "single-branch", &opt.single_branch,
     +			 N_("clone only one branch, HEAD or --branch")),
     +		OPT_END()
     +	};
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		NULL
     +	};
     +
    -+	update_clone_config_from_gitmodules(&update_data.max_jobs);
    -+	git_config(git_update_clone_config, &update_data.max_jobs);
    ++	update_clone_config_from_gitmodules(&opt.max_jobs);
    ++	git_config(git_update_clone_config, &opt.max_jobs);
     +
     +	argc = parse_options(argc, argv, prefix, module_update_clone_options,
     +			     git_submodule_helper_usage, 0);
    -+	update_data.prefix = prefix;
    -+
    -+	update_data.force = !!force;
    -+	update_data.quiet = !!quiet;
    -+	update_data.nofetch = !!nofetch;
    -+	update_data.init = !!init;
    -+	update_data.require_init = !!require_init;
    -+	update_data.remote = !!remote;
    -+	update_data.recursive = !!recursive;
    -+	update_data.progress = !!progress;
    -+	update_data.dissociate = !!dissociate;
    -+	oidcpy(&update_data.oid, null_oid());
    -+	oidcpy(&update_data.suboid, null_oid());
    ++	oidcpy(&opt.oid, null_oid());
    ++	oidcpy(&opt.suboid, null_oid());
     +
     +	if (update)
     +		if (parse_submodule_update_strategy(update,
    -+						    &update_data.update_strategy) < 0)
    ++						    &opt.update_strategy) < 0)
     +			die(_("bad value for update parameter"));
     +
    -+	if (module_list_compute(argc, argv, prefix, &pathspec, &update_data.list) < 0)
    ++	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
     +		return 1;
     +
     +	if (pathspec.nr)
    -+		update_data.warn_if_uninitialized = 1;
    ++		opt.warn_if_uninitialized = 1;
     +
    -+	if (update_data.init) {
    ++	if (opt.init) {
     +		struct module_list list = MODULE_LIST_INIT;
     +		struct init_cb info = INIT_CB_INIT;
     +
    -+		if (module_list_compute(argc, argv, update_data.prefix,
    ++		if (module_list_compute(argc, argv, opt.prefix,
     +					&pathspec, &list) < 0)
     +			return 1;
     +
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		if (!argc && git_config_get_value_multi("submodule.active"))
     +			module_list_active(&list);
     +
    -+		info.prefix = update_data.prefix;
    -+		info.superprefix = update_data.recursive_prefix;
    -+		if (update_data.quiet)
    ++		info.prefix = opt.prefix;
    ++		info.superprefix = opt.recursive_prefix;
    ++		if (opt.quiet)
     +			info.flags |= OPT_QUIET;
     +
     +		for_each_listed_submodule(&list, init_submodule_cb, &info);
     +	}
     +
    -+	return update_submodules(&update_data);
    ++	return update_submodules(&opt);
     +}
     +
      struct add_data {
      	const char *prefix;
      	const char *branch;
    -@@ builtin/submodule--helper.c: static int module_add(int argc, const char **argv, const char *prefix)
    - 	return 0;
    - }
    - 
    -+
    - #define SUPPORT_SUPER_PREFIX (1<<0)
    - 
    - struct cmd_struct {
     @@ builtin/submodule--helper.c: static struct cmd_struct commands[] = {
      	{"name", module_name, 0},
      	{"clone", module_clone, 0},
      	{"add", module_add, SUPPORT_SUPER_PREFIX},
    +-	{"update-module-mode", module_update_module_mode, 0},
    +-	{"update-clone", update_clone, 0},
    +-	{"run-update-procedure", run_update_procedure, 0},
    +-	{"ensure-core-worktree", ensure_core_worktree, 0},
    +-	{"relative-path", resolve_relative_path, 0},
     +	{"update", module_update, 0},
    - 	{"update-module-mode", module_update_module_mode, 0},
    - 	{"update-clone", update_clone, 0},
    - 	{"run-update-procedure", run_update_procedure, 0},
    + 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
    + 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
    + 	{"init", module_init, SUPPORT_SUPER_PREFIX},
    + 	{"status", module_status, SUPPORT_SUPER_PREFIX},
    +-	{"print-default-remote", print_default_remote, 0},
    + 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
    + 	{"deinit", module_deinit, 0},
    + 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
     
      ## git-submodule.sh ##
     @@ git-submodule.sh: cmd_deinit()
 8:  cee4beb7abe <  -:  ----------- submodule--helper: remove unused helpers
 9:  2194c1729f1 <  -:  ----------- submodule--helper: rename helper functions
-- 
2.35.0.894.g563b84683b9


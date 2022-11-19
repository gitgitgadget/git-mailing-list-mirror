Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B7AC43217
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiKSMlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiKSMlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:37 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A46DFF6
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:34 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so19214774ejh.0
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/m4hX0oI9ors/s9OdsgvgRK22WEE3wmD3+lHBIlSNM=;
        b=LyZqMDuABjarFN6icauMz5AqWzP8re0Vy6uBYzxhELIc6MosrC67yomGUYHQYKUZ1V
         oJ5kz+r2JeQAKUVL8vkahYTJP0xUKsOmN8eV8XQ5MQyNho/aaD4gQRbYNhiH2eVBpm9b
         iSS1+/m+qhof646FnoceXS9/istmIyZmBCA2+Of1MrKxIKSRcjYnvAiNxm05KwV3nS9b
         1MTaDeO3zNQLHBTWpTp06jzrUKRsCo+AbPCRxx7sKazFwiwCIH9wrCr8VF+B7BMSltG/
         7WXvdoD3QqKZfMeDLxVJ8y2qr+3cVUpXy3kvBo1zdMyvcNOGqshVcvgEP97Q7ItIcmDI
         FFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/m4hX0oI9ors/s9OdsgvgRK22WEE3wmD3+lHBIlSNM=;
        b=z3gOCzKDfD/mEFnzRG6fQUKlSdfxDNy56VOTMJM9KOka3lAlHmFPKL+vWOvXqd5V97
         xBvhJ7OaImXBc7jx9S19H3Bh6Qn5TOq/QLFhQg2jfP7YilGc6Q0+uO9JhpItRnfQvgAy
         z0iPfC1h3KtfB6HrwBFjAzZiHov4VoCND6q3YnzkW9EZMPctvifaQlNaPZqKuguYxM9a
         YKqpbtVuvTpeFlzDplFwHa20XQ8D2epYICpLBFKaJgN1UAXmSsTufjrH9R7IMrJaVbA4
         5/9922b/nxD1B1tEjOX9IvC1zkrrTlLqY7RrEQt0q33QeimUq5Mylq+OhrI9YxQardAe
         /icQ==
X-Gm-Message-State: ANoB5pmGIR8EiA3eyCjtSYvu7r3bG/Gm2pBDW41pFWW3d3g9dBeqAH/J
        acB/Dg82sx+5tmFPe4sZNqWO0fJ2wZGBcQ==
X-Google-Smtp-Source: AA0mqf4yGu0Q2mo+kXEjrMt30tQ9BlqiIv6wb0uRLCW6JwiIXOZewjJQfskYHSC3KMaR9DspWACN/Q==
X-Received: by 2002:a17:906:a40c:b0:7ae:180e:9b53 with SMTP id l12-20020a170906a40c00b007ae180e9b53mr9496104ejz.206.1668861692122;
        Sat, 19 Nov 2022 04:41:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] Get rid of "git --super-prefix"
Date:   Sat, 19 Nov 2022 13:41:19 +0100
Message-Id: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Summary

What's "--super-prefix"? The "git" command takes an "internal use
only" "--super-prefix" option, which is used to inform processes
invoked in submodules what the path prefix to the invoking
superproject is.

This is so so that e.g. "git submodule absorbgitdirs" can report
"sub-1/sub-2", instead of "sub-2" when being invoked in the "sub-1"
submodule.

For this the "--super-prefix" facility has been doing a
setenv("GIT_INTERNAL_SUPER_PREFIX", "sub-1/") as soon as it got the
"--supre-prefix=sub-1/". We'd then pass that along via the environment
when invoking the sub-process.

As this series shows we don't need such a hands-off global facility to
do this, we can instead just pass the relevant context directly in
each command. E.g. "git submodule absorbgitdirs" can pass the path to
the "git submodule absorbgitdirs" sub-process it's about to invoke.

= Relation to other submissions

This is on top of "ab/submodule-helper-prep-only" and
"ab/submodule-no-abspath", buth currently in "next".

= Changes since v2:

* Fixes for test_when_finished() in test setup, and got rid of
  redundant test_config_global.

* There's a new 2/9, which passes along get_super_prefix() as a
  parameter. This allows us to gradually replace it, and drop the
  *_sp() variants of functions that the previous version introduced,
  and it adds "super_prefix" to the absorb_git_dir_into_superproject()
  call in submodule_move_head(), which as Glen noticed I'd missed

* Squashed the "deinit" change into that 2/9.

* Explain why we keep the "fsmonitor" test bits that we do.

* Dropped the new "git branch" output tests, turns out I was just
  wrong, and was conflating it with the subsequent read-tree
  invocation...

So, this should address all outstanding feedbakc, unless I've missed
something.

The one loose end here is that I still have no idea if you can invoke
get "read-tree" to invoke that submodule_move_head() in such a way as
to have the "super_prefix" used, I've failed to come up with a test
case for that.

But for the purposes of this topic it doesn't really matter. In 8/10
we'll start passing the new "--super-prefix" that "read-tree" gets
down to that function. At worst we're handing it to it redundantly,
but that was the case before too.

So we can leave potentially turning that into a "NULL" for some other
time, for now providing the "super_prefix" is harmless, and guarantees
that we avoid any regression in that area from not providing it, in
case I've missed a way to have it matter in that case.

= CI & fetch URL

Passing at: https://github.com/avar/git/tree/avar/nuke-global-super-prefix-use-local-3

Glen Choo (1):
  read-tree + fetch tests: test failing "--super-prefix" interaction

Ævar Arnfjörð Bjarmason (8):
  submodule.c & submodule--helper: pass along "super_prefix" param
  submodule--helper: don't use global --super-prefix in "absorbgitdirs"
  submodule--helper: convert "foreach" to its own "--super-prefix"
  submodule--helper: convert "sync" to its own "--super-prefix"
  submodule--helper: convert "status" to its own "--super-prefix"
  submodule--helper: convert "{update,clone}" to their own
    "--super-prefix"
  read-tree: add "--super-prefix" option, eliminate global
  fetch: rename "--submodule-prefix" to "--super-prefix"

 Documentation/fetch-options.txt |  5 --
 Documentation/git.txt           |  8 +--
 builtin.h                       |  4 --
 builtin/checkout.c              |  2 +-
 builtin/fetch.c                 |  7 ++-
 builtin/read-tree.c             |  1 +
 builtin/rm.c                    |  2 +-
 builtin/submodule--helper.c     | 87 ++++++++++++++++++---------------
 cache.h                         |  2 -
 entry.c                         | 12 ++---
 entry.h                         |  6 ++-
 environment.c                   | 13 -----
 git.c                           | 41 +++-------------
 parse-options.h                 |  4 ++
 submodule.c                     | 73 +++++++++++++--------------
 submodule.h                     |  8 +--
 t/t1001-read-tree-m-2way.sh     |  2 +-
 t/t5616-partial-clone.sh        | 43 ++++++++++++++++
 t/t7527-builtin-fsmonitor.sh    | 33 +++----------
 unpack-trees.c                  | 23 +++++----
 unpack-trees.h                  |  1 +
 21 files changed, 180 insertions(+), 197 deletions(-)

Range-diff against v2:
 1:  1114a4ff666 !  1:  c930fc38356 read-tree + fetch tests: test failing "--super-prefix" interaction
    @@ t/t5616-partial-clone.sh: test_expect_success 'repack does not loosen promisor o
     +	# setup
     +	test_config_global protocol.file.allow always &&
     +
    ++	test_when_finished "rm -rf src-sub" &&
     +	git init src-sub &&
     +	git -C src-sub config uploadpack.allowfilter 1 &&
     +	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
    @@ t/t5616-partial-clone.sh: test_expect_success 'repack does not loosen promisor o
     +	git -C src-sub commit -m "submodule two" &&
     +	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
     +
    ++	test_when_finished "rm -rf src-super" &&
     +	git init src-super &&
     +	git -C src-super config uploadpack.allowfilter 1 &&
     +	git -C src-super config uploadpack.allowanysha1inwant 1 &&
    @@ t/t5616-partial-clone.sh: test_expect_success 'repack does not loosen promisor o
     +	git -C src-super commit -m "superproject two" &&
     +
     +	# the fetch
    -+	test_when_finished "rm -rf src-super src-sub client" &&
    -+
    -+	test_config_global protocol.file.allow always &&
    ++	test_when_finished "rm -rf client" &&
     +	git clone --filter=blob:none --also-filter-submodules \
     +		--recurse-submodules "file://$(pwd)/src-super" client &&
     +
 3:  a7a1f9487dc !  2:  2e4a2236898 submodule--helper: "deinit" has never used "--super-prefix"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: "deinit" has never used "--super-prefix"
    +    submodule.c & submodule--helper: pass along "super_prefix" param
     
    -    The "deinit_submodule()" function has never been able to use the "git
    -    --super-prefix". It will call "absorb_git_dir_into_superproject()",
    -    but it will only do so from the top-level project.
    +    Start passing the "super_prefix" along as a parameter to
    +    get_submodule_displaypath() and absorb_git_dir_into_superproject(),
    +    rather than get the value directly as a global.
     
    -    If "absorbgitdirs" recurses it will use the "path" passed to
    -    "absorb_git_dir_into_superproject()" in "deinit_submodule()" as its
    -    starting "--super-prefix".
    +    This is in preparation for subsequent commits, where we'll gradually
    +    phase out get_super_prefix() for an alternative way of getting the
    +    "super_prefix".
     
    -    So, let's introduce a "get_submodule_displaypath_sp()" helper, and
    -    make our existing "get_submodule_displaypath()" a wrapper for it. In a
    -    subsequent commit the wrapper will be going away, as the rest of the
    -    commands here will stop using the global "get_super_prefix()".
    +    Most of the users of this get a get_super_prefix() value, either
    +    directly or by indirection. The exceptions are:
    +
    +    - builtin/rm.c: Doesn't declare SUPPORT_SUPER_PREFIX, so we'd have
    +      died if this was provided, so it's safe to passs "NULL".
    +
    +    - deinit_submodule(): The "deinit_submodule()" function has never been
    +      able to use the "git -super-prefix". It will call
    +      "absorb_git_dir_into_superproject()", but it will only do so from the
    +      top-level project.
    +
    +      If "absorbgitdirs" recurses it will use the "path" passed to
    +      "absorb_git_dir_into_superproject()" in "deinit_submodule()" as its
    +      starting "--super-prefix". So we can safely remove the
    +      get_super_prefix() call here, and pass NULL instead.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## builtin/rm.c ##
    +@@ builtin/rm.c: static void submodules_absorb_gitdir_if_needed(void)
    + 			continue;
    + 
    + 		if (!submodule_uses_gitfile(name))
    +-			absorb_git_dir_into_superproject(name);
    ++			absorb_git_dir_into_superproject(name, NULL);
    + 	}
    + }
    + 
    +
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static char *resolve_relative_url(const char *rel_url, const char *up_path, int
      }
      
      /* the result should be freed by the caller. */
     -static char *get_submodule_displaypath(const char *path, const char *prefix)
    -+static char *get_submodule_displaypath_sp(const char *path, const char *prefix,
    -+					  const char *super_prefix)
    ++static char *get_submodule_displaypath(const char *path, const char *prefix,
    ++				       const char *super_prefix)
      {
     -	const char *super_prefix = get_super_prefix();
     -
      	if (prefix && super_prefix) {
      		BUG("cannot have prefix '%s' and superprefix '%s'",
      		    prefix, super_prefix);
    -@@ builtin/submodule--helper.c: static char *get_submodule_displaypath(const char *path, const char *prefix)
    +@@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
    + 	struct child_process cp = CHILD_PROCESS_INIT;
    + 	char *displaypath;
    + 
    +-	displaypath = get_submodule_displaypath(path, info->prefix);
    ++	displaypath = get_submodule_displaypath(path, info->prefix,
    ++						get_super_prefix());
    + 
    + 	sub = submodule_from_path(the_repository, null_oid(), path);
    + 
    +@@ builtin/submodule--helper.c: static void init_submodule(const char *path, const char *prefix,
    + 	const char *upd;
    + 	char *url = NULL, *displaypath;
    + 
    +-	displaypath = get_submodule_displaypath(path, prefix);
    ++	displaypath = get_submodule_displaypath(path, prefix,
    ++						get_super_prefix());
    + 
    + 	sub = submodule_from_path(the_repository, null_oid(), path);
    + 
    +@@ builtin/submodule--helper.c: static void status_submodule(const char *path, const struct object_id *ce_oid,
    + 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
    + 		      path);
    + 
    +-	displaypath = get_submodule_displaypath(path, prefix);
    ++	displaypath = get_submodule_displaypath(path, prefix,
    ++						get_super_prefix());
    + 
    + 	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
    + 		print_status(flags, 'U', path, null_oid(), displaypath);
    +@@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summary_cb *info,
    + 		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
      	}
    - }
      
    -+static char *get_submodule_displaypath(const char *path, const char *prefix)
    -+{
    -+	const char *super_prefix = get_super_prefix();
    -+
    -+	return get_submodule_displaypath_sp(path, prefix, super_prefix);
    -+}
    -+
    - static char *compute_rev_name(const char *sub_path, const char* object_id)
    - {
    - 	struct strbuf sb = STRBUF_INIT;
    +-	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
    ++	displaypath = get_submodule_displaypath(p->sm_path, info->prefix,
    ++						get_super_prefix());
    + 
    + 	if (!missing_src && !missing_dst) {
    + 		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
    +@@ builtin/submodule--helper.c: static void sync_submodule(const char *path, const char *prefix,
    + 		super_config_url = xstrdup("");
    + 	}
    + 
    +-	displaypath = get_submodule_displaypath(path, prefix);
    ++	displaypath = get_submodule_displaypath(path, prefix,
    ++						get_super_prefix());
    + 
    + 	if (!(flags & OPT_QUIET))
    + 		printf(_("Synchronizing submodule url for '%s'\n"),
     @@ builtin/submodule--helper.c: static void deinit_submodule(const char *path, const char *prefix,
      	if (!sub || !sub->name)
      		goto cleanup;
      
     -	displaypath = get_submodule_displaypath(path, prefix);
    -+	displaypath = get_submodule_displaypath_sp(path, prefix, NULL);
    ++	displaypath = get_submodule_displaypath(path, prefix, NULL);
      
      	/* remove the submodule work tree (unless the user already did it) */
      	if (is_directory(path)) {
    +@@ builtin/submodule--helper.c: static void deinit_submodule(const char *path, const char *prefix,
    + 					  ".git file by using absorbgitdirs."),
    + 					displaypath);
    + 
    +-			absorb_git_dir_into_superproject(path);
    ++			absorb_git_dir_into_superproject(path, NULL);
    + 
    + 		}
    + 
    +@@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
    + 	enum submodule_update_type update_type;
    + 	char *key;
    + 	const struct update_data *ud = suc->update_data;
    +-	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
    ++	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix,
    ++						      get_super_prefix());
    + 	struct strbuf sb = STRBUF_INIT;
    + 	int needs_cloning = 0;
    + 	int need_free_url = 0;
    +@@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
    + 			goto fail;
    + 
    + 		update_data->displaypath = get_submodule_displaypath(
    +-			update_data->sm_path, update_data->prefix);
    ++			update_data->sm_path, update_data->prefix,
    ++			get_super_prefix());
    + 		code = update_submodule(update_data);
    + 		FREE_AND_NULL(update_data->displaypath);
    + fail:
    +@@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
    + 	int i;
    + 	struct pathspec pathspec = { 0 };
    + 	struct module_list list = MODULE_LIST_INIT;
    ++	const char *super_prefix;
    + 	struct option embed_gitdir_options[] = {
    + 		OPT_END()
    + 	};
    +@@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
    + 	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
    + 		goto cleanup;
    + 
    ++	super_prefix = get_super_prefix();
    + 	for (i = 0; i < list.nr; i++)
    +-		absorb_git_dir_into_superproject(list.entries[i]->name);
    ++		absorb_git_dir_into_superproject(list.entries[i]->name,
    ++						 super_prefix);
    + 
    + 	ret = 0;
    + cleanup:
    +
    + ## submodule.c ##
    +@@ submodule.c: int submodule_move_head(const char *path,
    + 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
    + 		if (old_head) {
    + 			if (!submodule_uses_gitfile(path))
    +-				absorb_git_dir_into_superproject(path);
    ++				absorb_git_dir_into_superproject(path,
    ++								 get_super_prefix());
    + 		} else {
    + 			struct strbuf gitdir = STRBUF_INIT;
    + 			submodule_name_to_gitdir(&gitdir, the_repository,
    +@@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path)
    + 	strbuf_release(&new_gitdir);
    + }
    + 
    +-static void absorb_git_dir_into_superproject_recurse(const char *path)
    ++static void absorb_git_dir_into_superproject_recurse(const char *path,
    ++						     const char *super_prefix)
    + {
    + 
    + 	struct child_process cp = CHILD_PROCESS_INIT;
    +@@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *path)
    + 	cp.dir = path;
    + 	cp.git_cmd = 1;
    + 	cp.no_stdin = 1;
    +-	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
    +-		     get_super_prefix_or_empty(), path);
    ++	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
    ++		     super_prefix : "", path);
    + 	strvec_pushl(&cp.args, "submodule--helper",
    + 		     "absorbgitdirs", NULL);
    + 	prepare_submodule_repo_env(&cp.env);
    +@@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *path)
    +  * having its git directory within the working tree to the git dir nested
    +  * in its superprojects git dir under modules/.
    +  */
    +-void absorb_git_dir_into_superproject(const char *path)
    ++void absorb_git_dir_into_superproject(const char *path,
    ++				      const char *super_prefix)
    + {
    + 	int err_code;
    + 	const char *sub_git_dir;
    +@@ submodule.c: void absorb_git_dir_into_superproject(const char *path)
    + 	}
    + 	strbuf_release(&gitdir);
    + 
    +-	absorb_git_dir_into_superproject_recurse(path);
    ++	absorb_git_dir_into_superproject_recurse(path, super_prefix);
    + }
    + 
    + int get_superproject_working_tree(struct strbuf *buf)
    +
    + ## submodule.h ##
    +@@ submodule.h: void submodule_unset_core_worktree(const struct submodule *sub);
    +  */
    + void prepare_submodule_repo_env(struct strvec *env);
    + 
    +-void absorb_git_dir_into_superproject(const char *path);
    ++void absorb_git_dir_into_superproject(const char *path,
    ++				      const char *super_prefix);
    + 
    + /*
    +  * Return the absolute path of the working tree of the superproject, which this
 2:  5a35f7b75b3 !  3:  6e10a47c60a submodule--helper: don't use global --super-prefix in "absorbgitdirs"
    @@ Commit message
         stone makes such an eventual change easier, as we'll need to deal with
         less global state at that point.
     
    -    The "fsmonitor--daemon" test adjusted here was added in [3]. The
    -    comment added in that commit has been out-of-date from the beginning,
    -    and the "have_t2_error_event()" was being overly specific in testing
    -    for a bug that we *don't* have. Let's instead test for the stdout and
    -    stderr that we *do have*.
    +    The "fsmonitor--daemon" test adjusted here was added in [3]. To assert
    +    that it didn't run into the "--super-prefix" message it was asserting
    +    the output it didn't have. Let's instead assert the full output that
    +    we *do* have, which we can do here as this is based on a change[4] to
    +    make it predictable (until [4] it contained absolute paths).
    +
    +    We could also remove the test entirely (as [5] did), but even though
    +    the initial reason for having it is gone we're still getting some
    +    marginal benefit from testing the "fsmonitor" and "submodule
    +    absorbgitdirs" interaction, so let's keep it.
    +
    +    The change here to have either a NULL or non-"" string as a
    +    "super_prefix" instead of the previous arrangement of "" or non-"" is
    +    somewhat arbitrary. We could also decide to never have to check for
    +    NULL.
    +
    +    As we'll be changing the rest of the "git --super-prefix" users to the
    +    same pattern, leaving them all consistent makes sense. Why not pick ""
    +    over NULL? Because that's how the "prefix" works[6], and having
    +    "prefix" and "super_prefix" work the same way will be less
    +    confusing. That "prefix" picked NULL instead of "" is itself
    +    arbitrary, but as it's easy to make this small bit of our overall API
    +    consistent, let's go with that.
     
         1. 74866d75793 (git: make super-prefix option, 2016-10-07)
         2. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
            2022-05-26)
         3. 53fcfbc84f6 (fsmonitor--daemon: allow --super-prefix argument,
            2022-05-26)
    +    4. https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/
    +    5. https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com/
    +    6. 9725c8dda20 (built-ins: trust the "prefix" from run_builtin(),
    +       2022-02-16)
     
         Signed-off-by: Glen Choo <chooglen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **a
      	int i;
      	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
    +-	const char *super_prefix;
     +	const char *super_prefix = NULL;
      	struct option embed_gitdir_options[] = {
     +		OPT__SUPER_PREFIX(&super_prefix),
    @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **a
      	};
      	const char *const git_submodule_helper_usage[] = {
     @@ builtin/submodule--helper.c: static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
    + 	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
      		goto cleanup;
      
    +-	super_prefix = get_super_prefix();
      	for (i = 0; i < list.nr; i++)
    --		absorb_git_dir_into_superproject(list.entries[i]->name);
    -+		absorb_git_dir_into_superproject_sp(list.entries[i]->name,
    -+						    super_prefix);
    - 
    - 	ret = 0;
    - cleanup:
    + 		absorb_git_dir_into_superproject(list.entries[i]->name,
    + 						 super_prefix);
     @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
      
      	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *p
      		off++;
      	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
     -		get_super_prefix_or_empty(), path,
    -+		(super_prefix ? super_prefix : ""), path,
    ++		super_prefix ? super_prefix : "", path,
      		real_old_git_dir + off, real_new_git_dir + off);
      
      	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
    -@@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *path)
    - 	strbuf_release(&new_gitdir);
    - }
    - 
    --static void absorb_git_dir_into_superproject_recurse(const char *path)
    -+static void absorb_git_dir_into_superproject_recurse(const char *path,
    -+						     const char *super_prefix)
    - {
    - 
    - 	struct child_process cp = CHILD_PROCESS_INIT;
    -@@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *path)
    +@@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *path,
      	cp.dir = path;
      	cp.git_cmd = 1;
      	cp.no_stdin = 1;
    --	strvec_pushf(&cp.args, "--super-prefix=%s%s/",
    --		     get_super_prefix_or_empty(), path);
    +-	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
    +-		     super_prefix : "", path);
      	strvec_pushl(&cp.args, "submodule--helper",
      		     "absorbgitdirs", NULL);
     +	strvec_pushf(&cp.args, "--super-prefix=%s%s/", super_prefix ?
    @@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *pa
      	prepare_submodule_repo_env(&cp.env);
      	if (run_command(&cp))
      		die(_("could not recurse into submodule '%s'"), path);
    -@@ submodule.c: static void absorb_git_dir_into_superproject_recurse(const char *path)
    -  * having its git directory within the working tree to the git dir nested
    -  * in its superprojects git dir under modules/.
    -  */
    --void absorb_git_dir_into_superproject(const char *path)
    -+void absorb_git_dir_into_superproject_sp(const char *path,
    -+					 const char *super_prefix)
    - {
    - 	int err_code;
    - 	const char *sub_git_dir;
    -@@ submodule.c: void absorb_git_dir_into_superproject(const char *path)
    +@@ submodule.c: void absorb_git_dir_into_superproject(const char *path,
      		char *real_common_git_dir = real_pathdup(get_git_common_dir(), 1);
      
      		if (!starts_with(real_sub_git_dir, real_common_git_dir))
    @@ submodule.c: void absorb_git_dir_into_superproject(const char *path)
      
      		free(real_sub_git_dir);
      		free(real_common_git_dir);
    - 	}
    - 	strbuf_release(&gitdir);
    - 
    --	absorb_git_dir_into_superproject_recurse(path);
    -+	absorb_git_dir_into_superproject_recurse(path, super_prefix);
    - }
    - 
    - int get_superproject_working_tree(struct strbuf *buf)
    -
    - ## submodule.h ##
    -@@ submodule.h: void submodule_unset_core_worktree(const struct submodule *sub);
    -  */
    - void prepare_submodule_repo_env(struct strvec *env);
    - 
    --void absorb_git_dir_into_superproject(const char *path);
    -+void absorb_git_dir_into_superproject_sp(const char *path,
    -+					 const char *super_prefix);
    -+static inline void absorb_git_dir_into_superproject(const char *path)
    -+{
    -+	absorb_git_dir_into_superproject_sp(path, NULL);
    -+}
    - 
    - /*
    -  * Return the absolute path of the working tree of the superproject, which this
     
      ## t/t7527-builtin-fsmonitor.sh ##
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
 4:  935d8070834 !  4:  da86eb3b867 submodule--helper: convert "foreach" to its own "--super-prefix"
    @@ builtin/submodule--helper.c: struct foreach_cb {
      	int recursive;
      };
     @@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
    - 	struct child_process cp = CHILD_PROCESS_INIT;
      	char *displaypath;
      
    --	displaypath = get_submodule_displaypath(path, info->prefix);
    -+	displaypath = get_submodule_displaypath_sp(path, info->prefix,
    -+						   info->super_prefix);
    + 	displaypath = get_submodule_displaypath(path, info->prefix,
    +-						get_super_prefix());
    ++						info->super_prefix);
      
      	sub = submodule_from_path(the_repository, null_oid(), path);
      
    @@ builtin/submodule--helper.c: static void runcommand_in_submodule_cb(const struct
      		if (info->quiet)
      			strvec_push(&cpr.args, "--quiet");
     @@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
    - 	struct foreach_cb info = FOREACH_CB_INIT;
      	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
    -+	const char *super_prefix = NULL;
      	struct option module_foreach_options[] = {
    -+		OPT__SUPER_PREFIX(&super_prefix),
    ++		OPT__SUPER_PREFIX(&info.super_prefix),
      		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
      		OPT_BOOL(0, "recursive", &info.recursive,
      			 N_("recurse into nested submodules")),
    -@@ builtin/submodule--helper.c: static int module_foreach(int argc, const char **argv, const char *prefix)
    - 	info.argc = argc;
    - 	info.argv = argv;
    - 	info.prefix = prefix;
    -+	info.super_prefix = super_prefix;
    - 
    - 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
    - 
     @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
      	subcmd = argv[0];
      
 5:  933c752513d !  5:  2eb583148a6 submodule--helper: convert "sync" to its own "--super-prefix"
    @@ builtin/submodule--helper.c: static void sync_submodule(const char *path, const
      		super_config_url = xstrdup("");
      	}
      
    --	displaypath = get_submodule_displaypath(path, prefix);
    -+	displaypath = get_submodule_displaypath_sp(path, prefix, super_prefix);
    +-	displaypath = get_submodule_displaypath(path, prefix,
    +-						get_super_prefix());
    ++	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
      
      	if (!(flags & OPT_QUIET))
      		printf(_("Synchronizing submodule url for '%s'\n"),
    @@ builtin/submodule--helper.c: static void sync_submodule_cb(const struct cache_en
      
      static int module_sync(int argc, const char **argv, const char *prefix)
     @@ builtin/submodule--helper.c: static int module_sync(int argc, const char **argv, const char *prefix)
    - 	struct module_list list = MODULE_LIST_INIT;
      	int quiet = 0;
      	int recursive = 0;
    -+	const char *super_prefix = NULL;
      	struct option module_sync_options[] = {
    -+		OPT__SUPER_PREFIX(&super_prefix),
    ++		OPT__SUPER_PREFIX(&info.super_prefix),
      		OPT__QUIET(&quiet, N_("suppress output of synchronizing submodule url")),
      		OPT_BOOL(0, "recursive", &recursive,
      			N_("recurse into nested submodules")),
    -@@ builtin/submodule--helper.c: static int module_sync(int argc, const char **argv, const char *prefix)
    - 		goto cleanup;
    - 
    - 	info.prefix = prefix;
    -+	info.super_prefix = super_prefix;
    - 	if (quiet)
    - 		info.flags |= OPT_QUIET;
    - 	if (recursive)
     @@ builtin/submodule--helper.c: static int module_set_url(int argc, const char **argv, const char *prefix)
      	config_name = xstrfmt("submodule.%s.url", path);
      
 6:  67273f729e0 !  6:  8d8925c7e1f submodule--helper: convert "status" to its own "--super-prefix"
    @@ builtin/submodule--helper.c: static void status_submodule(const char *path, cons
      		die(_("no submodule mapping found in .gitmodules for path '%s'"),
      		      path);
      
    --	displaypath = get_submodule_displaypath(path, prefix);
    -+	displaypath = get_submodule_displaypath_sp(path, prefix, super_prefix);
    +-	displaypath = get_submodule_displaypath(path, prefix,
    +-						get_super_prefix());
    ++	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
      
      	if ((CE_STAGEMASK & ce_flags) >> CE_STAGESHIFT) {
      		print_status(flags, 'U', path, null_oid(), displaypath);
    @@ builtin/submodule--helper.c: static void status_submodule_cb(const struct cache_
      
      static int module_status(int argc, const char **argv, const char *prefix)
     @@ builtin/submodule--helper.c: static int module_status(int argc, const char **argv, const char *prefix)
    - 	struct pathspec pathspec = { 0 };
      	struct module_list list = MODULE_LIST_INIT;
      	int quiet = 0;
    -+	const char *super_prefix = NULL;
      	struct option module_status_options[] = {
    -+		OPT__SUPER_PREFIX(&super_prefix),
    ++		OPT__SUPER_PREFIX(&info.super_prefix),
      		OPT__QUIET(&quiet, N_("suppress submodule status output")),
      		OPT_BIT(0, "cached", &info.flags, N_("use commit stored in the index instead of the one stored in the submodule HEAD"), OPT_CACHED),
      		OPT_BIT(0, "recursive", &info.flags, N_("recurse into nested submodules"), OPT_RECURSIVE),
    -@@ builtin/submodule--helper.c: static int module_status(int argc, const char **argv, const char *prefix)
    - 		goto cleanup;
    - 
    - 	info.prefix = prefix;
    -+	info.super_prefix = super_prefix;
    - 	if (quiet)
    - 		info.flags |= OPT_QUIET;
    - 
     @@ builtin/submodule--helper.c: int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
      	subcmd = argv[0];
      
 7:  eaa73f5b1e4 !  7:  754a7489aa5 submodule--helper: convert "{update,clone}" to their own "--super-prefix"
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static char *get_submodule_displaypath_sp(const char *path, const char *prefix,
    - 	}
    - }
    - 
    --static char *get_submodule_displaypath(const char *path, const char *prefix)
    --{
    --	const char *super_prefix = get_super_prefix();
    --
    --	return get_submodule_displaypath_sp(path, prefix, super_prefix);
    --}
    --
    - static char *compute_rev_name(const char *sub_path, const char* object_id)
    - {
    - 	struct strbuf sb = STRBUF_INIT;
     @@ builtin/submodule--helper.c: static int starts_with_dot_dot_slash(const char *const path)
      
      struct init_cb {
    @@ builtin/submodule--helper.c: static void init_submodule(const char *path, const
      	const char *upd;
      	char *url = NULL, *displaypath;
      
    --	displaypath = get_submodule_displaypath(path, prefix);
    -+	displaypath = get_submodule_displaypath_sp(path, prefix, super_prefix);
    +-	displaypath = get_submodule_displaypath(path, prefix,
    +-						get_super_prefix());
    ++	displaypath = get_submodule_displaypath(path, prefix, super_prefix);
      
      	sub = submodule_from_path(the_repository, null_oid(), path);
      
    @@ builtin/submodule--helper.c: struct summary_cb {
      	unsigned int for_status: 1;
      	unsigned int files: 1;
     @@ builtin/submodule--helper.c: static void generate_submodule_summary(struct summary_cb *info,
    - 		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
      	}
      
    --	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
    -+	displaypath = get_submodule_displaypath_sp(p->sm_path, info->prefix,
    -+						   info->super_prefix);
    + 	displaypath = get_submodule_displaypath(p->sm_path, info->prefix,
    +-						get_super_prefix());
    ++						info->super_prefix);
      
      	if (!missing_src && !missing_dst) {
      		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
    @@ builtin/submodule--helper.c: static void submodule_update_clone_release(struct s
      	enum submodule_update_type update_default;
      	struct object_id suboid;
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
    - 	enum submodule_update_type update_type;
      	char *key;
      	const struct update_data *ud = suc->update_data;
    --	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
    -+	char *displaypath = get_submodule_displaypath_sp(ce->name, ud->prefix,
    -+							 ud->super_prefix);
    + 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix,
    +-						      get_super_prefix());
    ++						      ud->super_prefix);
      	struct strbuf sb = STRBUF_INIT;
      	int needs_cloning = 0;
      	int need_free_url = 0;
    @@ builtin/submodule--helper.c: static void update_data_to_args(const struct update
      	if (update_data->quiet)
      		strvec_push(args, "--quiet");
     @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
    - 		if (code)
    - 			goto fail;
      
    --		update_data->displaypath = get_submodule_displaypath(
    --			update_data->sm_path, update_data->prefix);
    -+		update_data->displaypath = get_submodule_displaypath_sp(
    -+			update_data->sm_path, update_data->prefix,
    + 		update_data->displaypath = get_submodule_displaypath(
    + 			update_data->sm_path, update_data->prefix,
    +-			get_super_prefix());
     +			update_data->super_prefix);
      		code = update_submodule(update_data);
      		FREE_AND_NULL(update_data->displaypath);
      fail:
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
    - 	struct list_objects_filter_options filter_options =
      		LIST_OBJECTS_FILTER_INIT;
      	int ret;
    -+	const char *super_prefix = NULL;
      	struct option module_update_options[] = {
    -+		OPT__SUPER_PREFIX(&super_prefix),
    ++		OPT__SUPER_PREFIX(&opt.super_prefix),
      		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
      		OPT_BOOL(0, "init", &opt.init,
      			 N_("initialize uninitialized submodules before update")),
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
    - 
    - 	opt.filter_options = &filter_options;
    - 	opt.prefix = prefix;
    -+	opt.super_prefix = super_prefix;
    - 
    - 	if (opt.update_default)
    - 		opt.update_strategy.type = opt.update_default;
    -@@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
      			module_list_active(&list);
      
      		info.prefix = opt.prefix;
    -+		info.super_prefix = super_prefix;
    ++		info.super_prefix = opt.super_prefix;
      		if (opt.quiet)
      			info.flags |= OPT_QUIET;
      
 8:  172b5865811 <  -:  ----------- submodule tests: test "git branch -t" output and stderr
 9:  9fdeab60773 !  8:  f952fa3d01f read-tree: add "--super-prefix" option, eliminate global
    @@ submodule.c: static void submodule_reset_index(const char *path)
      {
      	int ret = 0;
      	struct child_process cp = CHILD_PROCESS_INIT;
    +@@ submodule.c: int submodule_move_head(const char *path,
    + 		if (old_head) {
    + 			if (!submodule_uses_gitfile(path))
    + 				absorb_git_dir_into_superproject(path,
    +-								 get_super_prefix());
    ++								 super_prefix);
    + 		} else {
    + 			struct strbuf gitdir = STRBUF_INIT;
    + 			submodule_name_to_gitdir(&gitdir, the_repository,
     @@ submodule.c: int submodule_move_head(const char *path,
      			strbuf_release(&gitdir);
      
10:  100ba36dfb7 =  9:  1aa4019527a fetch: rename "--submodule-prefix" to "--super-prefix"
-- 
2.38.0.1509.g9445af83948


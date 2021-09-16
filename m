Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB27C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE0961108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhIPKeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhIPKeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2451C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m21-20020a17090a859500b00197688449c4so4460980pjn.0
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdnQAS3l6L4p4PsNtt5n0N4FWSGS6auvobaXHOlE0Gc=;
        b=OizbJ7XpofvX6Dcjn+2PrlpnCKyDaxLtvvT2qnOi3pRL3eJ7gcdYeyfZybBnoL1XZG
         1/IGikEnfJnw+T9n29gzFqM7B5lKJEUq31hZI/L00bo/9M0cOj2KjqowEQ9+qOIl9Zsh
         FRG9NPz44QBI+d77NhBhDXfqFG7rBth4bIg7Y1qJQV7wMCEpwDv1cy6FKEHiN9KfwFsY
         5XkMASJhVXxkxfH9f/qCX0A8D5RTlIvJGEfyauGNCxZbRNq7ji7wQO3gVvFEvSwVOpQA
         sobhJGxzFqsGbTU/eylks6heNZ8mSBlP57zWy+1kCqqKU4jj4wHs8iKWBFZZtENZ5zZs
         lHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdnQAS3l6L4p4PsNtt5n0N4FWSGS6auvobaXHOlE0Gc=;
        b=YF8g46vnqYQf+DOKKd4MyNGMmxywJqSvTGdJliF1xgk7YQHrG4n+WueqSFptBMYp4S
         PBaAX4bkk8nI3hD1F7omojZRHFhBHI3Kwx9hKM8/iPH/rAkYKlb5iox1N3yBy+Ey0hPo
         Xtbfrx0iXdrXxqy03EK3khxP0ltJMFgCeNkAms3PQOqwQ1PjS81AI6BjyMjMcAG0kl82
         HmwgLG5omtGWdq2d6cbWtZxS9VpRvQHSOCRWRp39b862zAnCPdBjWv6R6xC4hICetviX
         S8dkwxNzEp+3P/4UZfk02My3SwojYX0Xz8Z++7vb6yuTJ23BCY+SNTci2jsTQFZraFy2
         y13w==
X-Gm-Message-State: AOAM532/3DxXiBj63pDXtgyD2XOd/nw00oXLrrzjJbKHxJoiTXIQTto4
        B26A5JF6XSValnQk2yH01Ec=
X-Google-Smtp-Source: ABdhPJyBQ/c3dwQr5ojtqc31RxosttxHLJVDQGV+wNtPMU6c8FGx47tzJfT/OqVSHmlLwZwmKnqYOw==
X-Received: by 2002:a17:90a:16:: with SMTP id 22mr14245001pja.25.1631788382130;
        Thu, 16 Sep 2021 03:33:02 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:01 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 0/8] submodule: convert the rest of 'update' to C
Date:   Thu, 16 Sep 2021 16:02:33 +0530
Message-Id: <20210916103241.62376-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: This series uses ar/submodule-run-update-procedure, which is now part of
'next'. [1]

Since v1:
  I have incorporated Ævar's suggestions, and attempted to make this easier to
  review.

This series builds upon the previous conversion work on 'submodule update' and
moves out all of that shell logic in 'git-submodule.sh' into
'builtin/submodule--helper.c'. Even though this patch series looks a bit long, a
lot of it is preparatory patches and cleanup of unused functions that result
from this conversion. The real action happens at [5/8].

As with the other series, the goal is to be a faithful conversion, with no
change in behaviour.

This would be the last command whose logic would be moved into C, other than
'submodule add', whose patches have been sent already.

After this works out, we can invert the shell-C relationship and make
'submodule' a proper C builtin.

Fetch-it-Via:
git fetch https://github.com/tfidfwastaken/git submodule-update-list-2

[1] https://lore.kernel.org/git/20210824140609.1496-1-raykar.ath@gmail.com/

Atharva Raykar (8):
  submodule--helper: split up ensure_core_worktree()
  submodule--helper: get remote names from any repository
  submodule--helper: rename helpers for update-clone
  submodule--helper: refactor get_submodule_displaypath()
  submodule: move core cmd_update() logic to C
  submodule--helper: remove update-clone subcommand
  submodule--helper: remove unused helpers
  submodule--helper: rename helper functions

 builtin/submodule--helper.c | 767 +++++++++++++++++++++---------------
 git-submodule.sh            | 145 +------
 2 files changed, 458 insertions(+), 454 deletions(-)

Range-diff against v1:
 1:  2cfdc0e10a <  -:  ---------- submodule--helper: get remote names from any repository
 -:  ---------- >  1:  f83a5b7f34 submodule--helper: split up ensure_core_worktree()
 2:  be83ba7fdb !  2:  7f4e24ce25 submodule--helper: introduce get_default_remote_submodule()
    @@ Metadata
     Author: Atharva Raykar <raykar.ath@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: introduce get_default_remote_submodule()
    +    submodule--helper: get remote names from any repository
     
    -    Before 8ef1d2b549 (submodule--helper: get remote names from any
    -    repository, 2021-07-20), it was not possible to directly retrieve a
    -    submodule's remote name within the same process, because
    -    `get_default_remote()` used only knew about the current repository.
    +    `get_default_remote()` retrieves the name of a remote by resolving the
    +    refs from of the current repository's ref store.
    +
    +    Thus in order to use it for retrieving the remote name of a submodule,
    +    we have to start a new subprocess which runs from the submodule
    +    directory.
    +
    +    Let's instead introduce a function called `repo_get_default_remote()`
    +    which takes any repository object and retrieves the remote accordingly.
    +
    +    `get_default_remote()` is then defined as a call to
    +    `repo_get_default_remote()` with 'the_repository' passed to it.
     
         Now that we have `repo_get_default_remote()`, we no longer have to start
         a subprocess that called `submodule--helper get-default-remote` from
         within the submodule directory.
     
    -    Let's make a function called `get_default_remote_submodule()` which
    +    So let's make a function called `get_default_remote_submodule()` which
         takes a submodule path, and returns the default remote for that
         submodule, all within the same process.
     
    @@ Commit message
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static char *repo_get_default_remote(struct repository *repo, const char *refnam
    +@@
    + typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
    + 				  void *cb_data);
    + 
    +-static char *get_default_remote(void)
    ++static char *repo_get_default_remote(struct repository *repo, const char *refname)
    + {
    + 	char *dest = NULL, *ret;
    + 	struct strbuf sb = STRBUF_INIT;
    +-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
    + 
    + 	if (!refname)
    + 		die(_("No such ref: %s"), "HEAD");
    +@@ builtin/submodule--helper.c: static char *get_default_remote(void)
    + 		die(_("Expecting a full ref name, got %s"), refname);
    + 
    + 	strbuf_addf(&sb, "branch.%s.remote", refname);
    +-	if (git_config_get_string(sb.buf, &dest))
    ++	if (repo_config_get_string(repo, sb.buf, &dest))
    + 		ret = xstrdup("origin");
    + 	else
    + 		ret = dest;
    +@@ builtin/submodule--helper.c: static char *get_default_remote(void)
      	return ret;
      }
      
    @@ builtin/submodule--helper.c: static char *repo_get_default_remote(struct reposit
     +	return repo_get_default_remote(&subrepo, refname);
     +}
     +
    - static char *get_default_remote(void)
    ++static char *get_default_remote(void)
    ++{
    ++	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
    ++	return repo_get_default_remote(the_repository, refname);
    ++}
    ++
    + static int print_default_remote(int argc, const char **argv, const char *prefix)
      {
    - 	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
    + 	char *remote;
     @@ builtin/submodule--helper.c: static void sync_submodule(const char *path, const char *prefix,
      	char *remote_key = NULL;
      	char *sub_origin_url, *super_config_url, *displaypath;
 3:  8981b2c4c5 =  3:  390596ee7c submodule--helper: rename helpers for update-clone
 4:  420d792f99 =  4:  2a2ddcac91 submodule--helper: refactor get_submodule_displaypath()
 5:  6c4696b70a !  5:  832020a290 submodule: move core cmd_update() logic to C
    @@ Commit message
         `init_submodule()`, which will now also take an explicit 'superprefix'
         argument.
     
    +    While we are at it, we also remove the fetch_in_submodule() shell
    +    function since it is no longer used anywhere.
    +
         [1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com/
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
    @@ builtin/submodule--helper.c: static char *compute_submodule_clone_url(const char
      	unsigned int flags;
      };
     -#define INIT_CB_INIT { NULL, 0 }
    -+#define INIT_CB_INIT { NULL, NULL, 0 }
    ++#define INIT_CB_INIT { 0 }
      
      static void init_submodule(const char *path, const char *prefix,
     -			   unsigned int flags)
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +	 *   checkout involve more straightforward sequential I/O.
     +	 * - the listener can avoid doing any work if fetching failed.
     +	 */
    -+	if (suc.quickstop)
    ++	if (suc.quickstop) {
    ++		string_list_clear(&update_data->references, 0);
     +		return 1;
    ++	}
     +
     +	for (i = 0; i < suc.update_clone_nr; i++) {
     +		struct update_clone_data ucd = suc.update_clone[i];
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +			res = 1;
     +	}
     +
    ++	string_list_clear(&update_data->references, 0);
     +	return res;
     +}
     +
    @@ builtin/submodule--helper.c: static struct cmd_struct commands[] = {
      	{"run-update-procedure", run_update_procedure, 0},
     
      ## git-submodule.sh ##
    +@@ git-submodule.sh: cmd_deinit()
    + 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
    + }
    + 
    +-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
    +-# Because arguments are positional, use an empty string to omit <depth>
    +-# but include <sha1>.
    +-fetch_in_submodule () (
    +-	sanitize_submodule_env &&
    +-	cd "$1" &&
    +-	if test $# -eq 3
    +-	then
    +-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
    +-	else
    +-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
    +-	fi
    +-)
    +-
    + #
    + # Update each submodule path to correct revision, using clone and checkout as needed
    + #
     @@ git-submodule.sh: cmd_update()
      		shift
      	done
 6:  524ae77c3f <  -:  ---------- submodule: remove fetch_in_submodule shell function
 7:  ea56f7319a =  6:  fb3fa8174a submodule--helper: remove update-clone subcommand
 8:  10a62172a2 <  -:  ---------- submodule--helper: remove update-module-mode subcommand
 9:  dbbe5d3f53 <  -:  ---------- submodule--helper: remove shell interface to ensure_core_worktree()
10:  a015af3a16 <  -:  ---------- submodule--helper: remove print-default-remote subcommand
11:  f5a7ba1405 <  -:  ---------- submodule--helper: remove relative-path subcommand
12:  9f54eb5972 !  7:  364f72f870 submodule--helper: remove run-update-procedure subcommand
    @@ Metadata
     Author: Atharva Raykar <raykar.ath@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: remove run-update-procedure subcommand
    +    submodule--helper: remove unused helpers
     
    -    The subcommand 'submodule--helper run-update-procedure' is no longer
    -    needed after the conversion of the bulk of 'update' to C.
    -
    -    While we are at it, let's rename 'do_run_update_procedure()' to
    -    'run_update_procedure()' to reflect the fact that it is no longer a
    -    utility function meant to be wrapped in another function.
    +    These helpers were useful back when 'submodule update' had most of its
    +    logic in shell. Now that they will never be invoked, let us remove them.
     
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Shourya Shukla <periperidip@gmail.com>
         Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce, struct strin
    - 	return 0;
    +@@ builtin/submodule--helper.c: static char *get_default_remote(void)
    + 	return repo_get_default_remote(the_repository, refname);
      }
      
    --static int do_run_update_procedure(struct update_data *ud, struct string_list *err)
    -+static int run_update_procedure(struct update_data *ud, struct string_list *err)
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
      {
    - 	int subforce = is_null_oid(&ud->suboid) || ud->force;
    + 	return str[0] == '.' && is_dir_sep(str[1]);
    +@@ builtin/submodule--helper.c: static void determine_submodule_update_strategy(struct repository *r,
    + 	free(key);
    + }
      
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
     @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_data *ud, struct string_list *e
      	return run_update_command(ud, subforce, err);
      }
    @@ builtin/submodule--helper.c: static int do_run_update_procedure(struct update_da
     -
     -	return 3;
     -}
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
    +-}
     -
      static const char *remote_submodule_branch(const char *path)
      {
      	const struct submodule *sub;
    -@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    +@@ builtin/submodule--helper.c: static void do_ensure_core_worktree(const char *path)
      	}
    + }
      
    - 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
    --		if (do_run_update_procedure(update_data, &err))
    -+		if (run_update_procedure(update_data, &err))
    - 			return 1;
    - 
    - 	if (update_data->recursive) {
    +-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
    +-{
    +-	const char *path;
    +-
    +-	if (argc != 2)
    +-		BUG("submodule--helper ensure-core-worktree <path>");
    +-
    +-	path = argv[1];
    +-	do_ensure_core_worktree(path);
    +-
    +-	return 0;
    +-}
    +-
    + static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
    + {
    + 	int i;
     @@ builtin/submodule--helper.c: static struct cmd_struct commands[] = {
      	{"clone", module_clone, 0},
      	{"add-clone", add_clone, 0},
      	{"update", module_update, 0},
    +-	{"update-module-mode", module_update_module_mode, 0},
     -	{"run-update-procedure", run_update_procedure, 0},
    +-	{"ensure-core-worktree", ensure_core_worktree, 0},
    +-	{"relative-path", resolve_relative_path, 0},
      	{"resolve-relative-url", resolve_relative_url, 0},
      	{"resolve-relative-url-test", resolve_relative_url_test, 0},
      	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
    + 	{"init", module_init, SUPPORT_SUPER_PREFIX},
    + 	{"status", module_status, SUPPORT_SUPER_PREFIX},
    +-	{"print-default-remote", print_default_remote, 0},
    + 	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
    + 	{"deinit", module_deinit, 0},
    + 	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
 -:  ---------- >  8:  ca48dd452c submodule--helper: rename helper functions
-- 
2.32.0


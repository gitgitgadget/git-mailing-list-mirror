Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C9C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiHBPqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHBPqV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F2B7F6
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c22so7413576wmr.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=VY95nReYTj8Fe9Lf6OEU2n0sGKwPuDL7i/SJli5lVLg=;
        b=on1SzCfrwA8oY+v+bRxdBQUIcKVQL59R92x9lLtkcJTCGoLBw9TpfsUU3+5OcP4zzx
         FfbruywyntZo8UTk8QMdTOKyDda6dvBGz4uMnm3OsYJo3GupMKG4MrvzU8clgQV4z+2z
         gOcZIs+yPG12GTBOU7OwzthXJhFdIE2lixjWJzQfQYcjvc2qgFtnYNcFnBxNAN/+xHTQ
         NPm34Pat4Y+m6bbgadpNUFcfzo4EAcc2qwBRjO5svALEG+e9i+sfKbFTzx834WQrSlA8
         niebK5Aaq3VDwC+NmtwwPfr+PT/DTZECKlCLrjdp5aJExqfk7uU+g/PwGn1WiXNRPHAk
         TArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=VY95nReYTj8Fe9Lf6OEU2n0sGKwPuDL7i/SJli5lVLg=;
        b=JbicSBZ1ufhqjoxnDlQG6gJGcfxtWuqEUQYWa+g+BbgVLQSQFmvX+kd6zX2GwJJKxq
         pVEK4LrEBet5xFcpW8Eb6Fma2GRhheCsxAakWuZLy0PF/JCk7+OoriQ2MZwPrenGb8yl
         HGtcwGLOiNPxLu+6MFlKfnAkOIsA5CiWm3PTqfQqJ8JIpj2leQtSKo39inEasZ1JpbW6
         QVd17g7DsCRDrw4Q5CcaI1sE/aX9iSyd1sPqy3dXhc1t2RcP0yzv+FMVqVAIdHClHEkj
         dArpglV+QScizUyhARI8Zhx0yBpMK3bDMcBwBB57Go5g7Y68TvNou/tO+FxteZ9hYvA1
         YB/g==
X-Gm-Message-State: ACgBeo1vXADBTdfB6qod/wJ/qO3cGXjMGFUCxoNhryNhciLqDZSQfS6U
        H76a8htWGhJVn7QffiV251Sex6zVYg6WDg==
X-Google-Smtp-Source: AA6agR5+/Hc3onpTBjPsxyflt1SnIhoof27XhLV4lE1XqQKPpWxpDpdJZXcgr+wrl/+kYZh1XEJ4Ow==
X-Received: by 2002:a05:600c:198f:b0:3a3:2dd5:8e35 with SMTP id t15-20020a05600c198f00b003a32dd58e35mr45603wmq.121.1659455177159;
        Tue, 02 Aug 2022 08:46:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/28] submodule--helper: add tests, rm dead code, refactor & leak prep
Date:   Tue,  2 Aug 2022 17:45:44 +0200
Message-Id: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a "prep" series for the meaty leak fixes for
submodule--helper, see [1] (which will be re-rolled on top of this
v2).

Change since v1:

 * This hopefully addresses all of Glen's comments on v1.

 * The "libification" of "update" suggested in [2] is (almost)
   complete here. See 27/28 for the "almost". This is why the series
   grew from 20 to 28 patches.

   There's a lot of incremental "showing work" here.

 * The "goto cleanup" in update_submodule() change is gone, it's
   needed for the current v4 of the follow-up, but I'll submit a
   re-roll which solves that problem in a cleaner way.

   For this series it means we can end up with just a "return
   die_message(...)" rather than "ret = die_message(...); goto
   cleanup" in that code, which is a lot less verbose.

 * Various other small changes, see the range-diff below.

A CI run for this & branch is at [3].

1. https://lore.kernel.org/git/cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com/
2. https://lore.kernel.org/git/kl6lilnfr22i.fsf@chooglen-macbookpro.roam.corp.google.com/
3. https://github.com/avar/git/tree/avar/submodule--helper-cleanup-and-tests-2

Glen Choo (2):
  submodule--helper: add "const" to copy of "update_data"
  submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Ævar Arnfjörð Bjarmason (26):
  submodule tests: test usage behavior
  submodule tests: test for "add <repository> <abs-path>"
  submodule--helper: remove unused "name" helper
  submodule--helper: remove unused "list" helper
  test-tool submodule-config: remove unused "--url" handling
  submodule--helper: move "is-active" to a test-tool
  submodule--helper: move "check-name" to a test-tool
  submodule--helper: move "resolve-relative-url-test" to a test-tool
  submodule--helper style: don't separate declared variables with \n\n
  submodule--helper style: add \n\n after variable declarations
  submodule--helper: replace memset() with { 0 }-initialization
  submodule--helper: use xstrfmt() in clone_submodule()
  submodule--helper: move "sb" in clone_submodule() to its own scope
  submodule--helper: pass a "const struct module_clone_data" to
    clone_submodule()
  submodule--helper: don't redundantly check "else if (res)"
  submodule--helper: rename "int res" to "int ret"
  submodule--helper: return "ret", not "1" from update_submodule()
  submodule--helper: add missing braces to "else" arm
  submodule--helper: don't call submodule_strategy_to_string() in BUG()
  submodule--helper: move submodule_strategy_to_string() to only user
  submodule--helper: use "code" in run_update_command()
  submodule--helper: don't exit() on failure, return
  submodule--helper: libify determine_submodule_update_strategy()
  submodule--helper: libify "must_die_on_failure" code paths
  submodule--helper: libify "must_die_on_failure" code paths (for die)
  submodule--helper: fix bad config API usage

 Makefile                         |   1 +
 builtin/submodule--helper.c      | 451 +++++++++++++------------------
 submodule.c                      |  21 --
 submodule.h                      |   1 -
 t/helper/test-submodule-config.c |  11 +-
 t/helper/test-submodule.c        | 146 ++++++++++
 t/helper/test-tool-utils.h       |   9 +
 t/helper/test-tool.c             |   7 +-
 t/helper/test-tool.h             |   1 +
 t/t0060-path-utils.sh            |   2 +-
 t/t7400-submodule-basic.sh       |  56 ++--
 t/t7406-submodule-update.sh      |   2 +-
 t/t7413-submodule-is-active.sh   |  35 +--
 t/t7450-bad-git-dotfiles.sh      |   2 +-
 14 files changed, 403 insertions(+), 342 deletions(-)
 create mode 100644 t/helper/test-submodule.c
 create mode 100644 t/helper/test-tool-utils.h

Range-diff against v1:
 1:  84b05bda016 !  1:  daa5d3f9962 submodule tests: test usage behavior
    @@ Commit message
         subsequent eventual behavior change will become clear.
     
         For "--" this follows up on 68cabbfda36 (submodule: document default
    -    behavior, 2019-02-15) and tests that when "status" isn't supplied we
    -    don't support the "--" delimiter. There's no intrinsically good reason
    -    not to support that. We behave this way due to edge cases in
    +    behavior, 2019-02-15) and tests that "status" doesn't don't support
    +    the "--" delimiter. There's no intrinsically good reason not to
    +    support that. We behave this way due to edge cases in
         git-submodule.sh's implementation, but as with "-h" let's assert our
         current long-standing behavior for now.
     
 2:  9671169e348 =  2:  9d920326df3 submodule tests: test for "add <repository> <abs-path>"
 3:  7aa9c14251b =  3:  d981db49fa1 submodule--helper: remove unused "name" helper
 4:  27df2efe718 =  4:  6f78f9c9274 submodule--helper: remove unused "list" helper
 5:  9fe8deb165a =  5:  43902201701 test-tool submodule-config: remove unused "--url" handling
 6:  8e4d2b09d56 !  6:  e2a8bb0a28e submodule--helper: move "is-active" to a test-tool
    @@ t/t7413-submodule-is-active.sh
     -This test verifies that `git submodue--helper is-active` correctly identifies
     +This test verifies that `test-tool submodule is-active` correctly identifies
      submodules which are "active" and interesting to the user.
    ++
    ++This is a unit test of the submodule.c is_submodule_active() function,
    ++which is also indirectly tested elsewhere.
      '
      
    + . ./test-lib.sh
     @@ t/t7413-submodule-is-active.sh: test_expect_success 'setup' '
      '
      
 7:  a2f3d812815 !  7:  b209532eb17 submodule--helper: move "check-name" to a test-tool
    @@ Commit message
         a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
         2021-08-10) it has only been used by this test, not git-submodule.sh.
     
    +    As noted with its introduction in 0383bbb9015 (submodule-config:
    +    verify submodule names as paths, 2018-04-30) the intent of
    +    t7450-bad-git-dotfiles.sh has always been to unit test the
    +    check_submodule_name() function.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 8:  8188657cdfa !  8:  de49f31dab0 submodule--helper: move "resolve-relative-url-test" to a test-tool
    @@ Commit message
         resolve_relative_url from shell to C, 2016-04-15) for its original
         addition.
     
    +    Perhaps it would make sense to drop this code entirely, as we feel
    +    that we've got enough indirect test coverage, but let's leave that
    +    question to a possible follow-up change. For now let's keep the test
    +    coverage this gives us.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
 9:  79a47f9b94d =  9:  b0238f699ce submodule--helper style: don't separate declared variables with \n\n
10:  5e13080f894 = 10:  5f5e68a868b submodule--helper style: add \n\n after variable declarations
11:  dc5ac924496 = 11:  72dcf19e1c4 submodule--helper: replace memset() with { 0 }-initialization
12:  08cc9ce2e24 ! 12:  e5e267dccd5 submodule--helper: convert a strbuf_detach() to xstrfmt()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: convert a strbuf_detach() to xstrfmt()
    +    submodule--helper: use xstrfmt() in clone_submodule()
     
    -    Convert a case where we had no reason to use a "struct strbuf" to use
    -    an xstrfmt(). This code was added along with other uses of "struct
    +    Use xstrfmt() in clone_submodule() instead of a "struct strbuf" in two
    +    cases where we weren't getting anything out of using the "struct
    +    strbuf".
    +
    +    This changes code that was was added along with other uses of "struct
         strbuf" in this function in ee8838d1577 (submodule: rewrite
         `module_clone` shell function in C, 2015-09-08).
     
    @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data
      
      	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
      		die(_("refusing to create/use '%s' in another submodule's "
    +@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    + 			die(_("clone of '%s' into submodule path '%s' failed"),
    + 			    clone_data->url, clone_data->path);
    + 	} else {
    ++		char *path;
    ++
    + 		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
    + 		    !is_empty_dir(clone_data->path))
    + 			die(_("directory not empty: '%s'"), clone_data->path);
    + 		if (safe_create_leading_directories_const(clone_data->path) < 0)
    + 			die(_("could not create directory '%s'"), clone_data->path);
    +-		strbuf_addf(&sb, "%s/index", sm_gitdir);
    +-		unlink_or_warn(sb.buf);
    +-		strbuf_reset(&sb);
    ++		path = xstrfmt("%s/index", sm_gitdir);
    ++		unlink_or_warn(path);
    ++		free(path);
    + 	}
    + 
    + 	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
13:  afe34d8b73b ! 13:  91558745e2e submodule--helper: stop conflating "sb" in clone_submodule()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: stop conflating "sb" in clone_submodule()
    +    submodule--helper: move "sb" in clone_submodule() to its own scope
     
    -    Refactor the two uses of a "struct strbuf sb" such that each of them
    -    exists in its own scope. This makes the control flow clearer.
    +    Refactor the only remaining use of a "struct strbuf sb" in
    +    clone_submodule() to live in its own scope. This makes the code
    +    clearer by limiting its lifetime.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/submodule--helper.c: static void prepare_possible_alternates(const char
      
      	if (!is_absolute_path(clone_data->path))
      		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
    -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    - 			die(_("clone of '%s' into submodule path '%s' failed"),
    - 			    clone_data->url, clone_data->path);
    - 	} else {
    -+		struct strbuf sb = STRBUF_INIT;
    -+
    - 		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
    - 		    !is_empty_dir(clone_data->path))
    - 			die(_("directory not empty: '%s'"), clone_data->path);
    -@@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
    - 			die(_("could not create directory '%s'"), clone_data->path);
    - 		strbuf_addf(&sb, "%s/index", sm_gitdir);
    - 		unlink_or_warn(sb.buf);
    --		strbuf_reset(&sb);
    -+		strbuf_release(&sb);
    - 	}
    - 
    - 	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
     @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data *clone_data)
      	free(sm_alternate);
      	free(error_strategy);
14:  b364f3200d8 ! 14:  866b8397a59 submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
    @@ Commit message
         This new "struct string_list" still leaks memory, just as the "struct
         module_clone_data" did before. let's not fix that for now, to fix that
         we'll need to add some "goto cleanup" to the relevant code. That will
    -    be done in a follow-up commits, at that point it'll be easier to fix
    -    the memory leak.
    +    eventually be done in follow-up commits, this change makes it easier
    +    to fix the memory leak.
     
         The scope of the new "reference" variable in add_submodule() could be
         narrowed to the "else" block, but as we'll eventually free it with a
    @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data
     -			    clone_data->url, clone_data->path);
     +			    clone_data->url, clone_data_path);
      	} else {
    - 		struct strbuf sb = STRBUF_INIT;
    + 		char *path;
      
     -		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
     -		    !is_empty_dir(clone_data->path))
    @@ builtin/submodule--helper.c: static int clone_submodule(struct module_clone_data
     +			die(_("directory not empty: '%s'"), clone_data_path);
     +		if (safe_create_leading_directories_const(clone_data_path) < 0)
     +			die(_("could not create directory '%s'"), clone_data_path);
    - 		strbuf_addf(&sb, "%s/index", sm_gitdir);
    - 		unlink_or_warn(sb.buf);
    - 		strbuf_release(&sb);
    + 		path = xstrfmt("%s/index", sm_gitdir);
    + 		unlink_or_warn(path);
    + 		free(path);
      	}
      
     -	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
15:  e319f4edc54 = 15:  1ff380ec7b5 submodule--helper: add "const" to copy of "update_data"
16:  68202100d9a = 16:  d3a7e646adc submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
 -:  ----------- > 17:  23eb07176d9 submodule--helper: don't redundantly check "else if (res)"
17:  e8aacb55a18 ! 18:  78f74df6d5e submodule--helper: rename "int res" to "int ret"
    @@ Commit message
         cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
         in the rest of this file.
     
    -    Eventual follow-up commits will change this code to a "goto cleanup"
    -    pattern, let's have the post image look consistent with the rest.
    +    Eventual follow-up commits will change the code in update_submodule()
    +    to a "goto cleanup" pattern, let's have the post image look consistent
    +    with the rest. For update_submodules() let's also use a "ret" for
    +    consistency, that use was also added in b3c5f5cb048. We'll be
    +    modifying that codepath in subsequent commits.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      			    update_data->displaypath);
     -		if (res == 128)
     -			exit(res);
    --		else if (res)
     +		if (ret == 128)
     +			exit(ret);
    -+		else if (ret)
    - 			return 1;
    + 		return 1;
      	}
      
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    + 
    + static int update_submodules(struct update_data *update_data)
    + {
    +-	int i, res = 0;
    ++	int i, ret = 0;
    + 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
    + 
    + 	suc.update_data = update_data;
    +@@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
    + 	 * - the listener can avoid doing any work if fetching failed.
    + 	 */
    + 	if (suc.quickstop) {
    +-		res = 1;
    ++		ret = 1;
    + 		goto cleanup;
    + 	}
    + 
    +@@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
    + 		update_data->sm_path = ucd.sub->path;
    + 
    + 		if (update_submodule(update_data))
    +-			res = 1;
    ++			ret = 1;
    + 	}
    + 
    + cleanup:
    + 	string_list_clear(&update_data->references, 0);
    +-	return res;
    ++	return ret;
    + }
    + 
    + static int module_update(int argc, const char **argv, const char *prefix)
18:  41fb22d8549 <  -:  ----------- submodule--helper: add skeleton "goto cleanup" to update_submodule()
 -:  ----------- > 19:  f0258e37ebe submodule--helper: return "ret", not "1" from update_submodule()
 -:  ----------- > 20:  70f030cca4e submodule--helper: add missing braces to "else" arm
 -:  ----------- > 21:  bce1a014a2f submodule--helper: don't call submodule_strategy_to_string() in BUG()
 -:  ----------- > 22:  98c3e562c82 submodule--helper: move submodule_strategy_to_string() to only user
 -:  ----------- > 23:  db2d2fb5a21 submodule--helper: use "code" in run_update_command()
19:  5a26c9428be ! 24:  d33260487bd submodule--helper: don't exit() on failure, return
    @@ builtin/submodule--helper.c: static int fetch_in_submodule(const char *module_pa
      
     -static int run_update_command(struct update_data *ud, int subforce)
     +static int run_update_command(struct update_data *ud, int subforce,
    -+			      int *must_die_on_failurep)
    ++			      int *must_die_on_failure)
      {
      	struct child_process cp = CHILD_PROCESS_INIT;
      	char *oid = oid_to_hex(&ud->oid);
     @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
    - 			BUG("unexpected update strategy type: %s",
    - 			    submodule_strategy_to_string(&ud->update_strategy));
      		}
    --		if (must_die_on_failure)
    --			exit(128);
    -+		if (must_die_on_failure) {
    -+			*must_die_on_failurep = 1;
    -+			return 128;
    -+		}
    - 
    - 		/* the command failed, but update must continue */
    - 		return 1;
    + 
    + 		if (ret == 128)
    +-			exit(ret);
    ++			*must_die_on_failure = 1;
    + 		return ret;
    + 	}
    + 
     @@ builtin/submodule--helper.c: static int run_update_command(struct update_data *ud, int subforce)
      	return 0;
      }
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data
     +static int update_submodule(struct update_data *update_data,
     +			    int *must_die_on_failure)
      {
    - 	int ret = 1;
    + 	ensure_core_worktree(update_data->sm_path);
      
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    + 		free(remote_ref);
      	}
      
    - 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
    +-	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
     -		if (run_update_procedure(update_data))
    ++	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force) {
    ++		int ret;
    ++
     +		ret = run_update_procedure(update_data, must_die_on_failure);
    -+		if (ret && *must_die_on_failure) {
    -+			goto cleanup;
    -+		} else if (ret) {
    -+			ret = 1;
    - 			goto cleanup;
    -+		}
    - 	}
    ++		if (*must_die_on_failure)
    ++			return ret;
    ++		if (ret)
    + 			return 1;
    ++	}
      
      	if (update_data->recursive) {
    + 		struct child_process cp = CHILD_PROCESS_INIT;
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
      		die_message(_("Failed to recurse into submodule path '%s'"),
      			    update_data->displaypath);
    - 		if (ret == 128) {
    + 		if (ret == 128)
     -			exit(ret);
     +			*must_die_on_failure = 1;
    -+			goto cleanup;
    - 		} else if (ret) {
    - 			ret = 1;
    - 			goto cleanup;
    + 		return ret;
    + 	}
    + 
     @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *update_data)
      
      	for (i = 0; i < suc.update_clone_nr; i++) {
      		struct update_clone_data ucd = suc.update_clone[i];
    -+		int code;
     +		int must_die_on_failure = 0;
    ++		int code;
      
      		oidcpy(&update_data->oid, &ucd.oid);
      		update_data->just_cloned = ucd.just_cloned;
      		update_data->sm_path = ucd.sub->path;
      
     -		if (update_submodule(update_data))
    --			res = 1;
     +		code = update_submodule(update_data, &must_die_on_failure);
     +		if (code)
    -+			res = code;
    ++			ret = code;
     +		if (must_die_on_failure)
     +			goto cleanup;
    ++		else if (code)
    + 			ret = 1;
      	}
      
    - cleanup:
 -:  ----------- > 25:  9981a75d7e8 submodule--helper: libify determine_submodule_update_strategy()
 -:  ----------- > 26:  b48705c6cc0 submodule--helper: libify "must_die_on_failure" code paths
 -:  ----------- > 27:  93cd1ccde54 submodule--helper: libify "must_die_on_failure" code paths (for die)
20:  579560cb9a8 = 28:  6160a1ab250 submodule--helper: fix bad config API usage
-- 
2.37.1.1233.ge8b09efaedc


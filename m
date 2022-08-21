Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D03C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiHUN6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUN6a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEFCDFAD
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso6402196wmh.5
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Fza/MEzdXf9upqF8+dsYkMgA7G/iOlzZn7U5Xlx6UUE=;
        b=IFHJcnzWEM15VBONC9w1SIswD9tiPrYghW+vUi/C2yym48IAJ8whKO689aoAiCdw+M
         k8EfHN1IlCVJDEBLsXrjNH+utk7LaLfHdlOjYB6s01B6npImfOHBTJ0qDVmn2H4eIRxm
         SY6WHZ0u8sw9H0U8WBWc5F+4p4eVBQoM8a7TyXj6WBspNBaP9z3KFfukeXFVk7y9hsZb
         FNPdmvW4ViD0PH0gSDVpBfqwwfSjfI7FqaA6Ik1ynPTTgtaRXp+cQ5fwGMjokZFWvLwx
         syRPaJsIUMGa3QEE7OoJ6OSp6UxRS3NbcnPUk/wQ9e4MJ6Pglb3Jp11WhFgTwvYkPpfd
         ujpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Fza/MEzdXf9upqF8+dsYkMgA7G/iOlzZn7U5Xlx6UUE=;
        b=h6wcTl96nYd4RFoLMUWZPtV4dhveD4Gl+mtdaA5UUdePyOBSWq17symGOAw0E0vHTy
         1Rgrudv/tGQ1vUSGSB0LiV9os44USSDEluhaNuDJkS56E475qmHEXNccUFZEg6QYwXqt
         iUlCGqYBZV3yaAfhb/DB2JukYk3sgBUSBchKtiLQKAKu9qoxizhNUtOE5pFoJPKl4+Mp
         93S8uUDWfnsILCA781+mqBiVL3EAJZyK/FwdE4AAT+E38P1figVWNXsNISxqVEWmkbnF
         CTo/2/rGKH9DqYnbZGKs6LiZ627A/IgYSbx6EzqgeXO/fOt9B3ckachI4NL4FXU0S0p2
         xeEA==
X-Gm-Message-State: ACgBeo3v/9uucw+BqBZHaXw0bR79HYeFsAPb/6NKoEvvWjvAdfpduwGC
        vl8EiXBLGeHjw3JjdEqsd+YOYnGYJ3B3RQ==
X-Google-Smtp-Source: AA6agR7ovHGesKK9f+bGEewvuEYoYcGZs9cqaEhTQ89zXqdLWdCe3JYWCNLRCQa4SwiKDgabp61SZA==
X-Received: by 2002:a7b:ce05:0:b0:3a5:c069:25b3 with SMTP id m5-20020a7bce05000000b003a5c06925b3mr9758337wmc.87.1661090305071;
        Sun, 21 Aug 2022 06:58:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/32] submodule--helper: add tests, rm dead code, refactor & leak prep
Date:   Sun, 21 Aug 2022 15:57:09 +0200
Message-Id: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
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
v3). The v6 re-roll will be at [2].

Changes since v2:

 * Clarified 1/* commit message.
 * 22/*: keep the "to string" API function in submodule.[ch], as
   suggested by Glen.
 * 24/*: Minor change to existing comment obsoleted by the code change.
 * 26-31/*: Do the full libification suggested by Glen, instead of
   leaving it for later. As a result we don't need to pass up the
   "must_die_on_failure", and some parts of the soon-to-be-rerolled
   "leak" series[1] will be better as a result.

1. https://lore.kernel.org/git/cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com

Glen Choo (2):
  submodule--helper: add "const" to copy of "update_data"
  submodule--helper: refactor "errmsg_str" to be a "struct strbuf"

Ævar Arnfjörð Bjarmason (30):
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
  submodule--helper: add "const" to passed "module_clone_data"
  submodule--helper: don't redundantly check "else if (res)"
  submodule--helper: rename "int res" to "int ret"
  submodule--helper: return "ret", not "1" from update_submodule()
  submodule--helper: add missing braces to "else" arm
  submodule--helper: don't call submodule_strategy_to_string() in BUG()
  submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string()
  submodule--helper: use "code" in run_update_command()
  submodule--helper: don't exit() on failure, return
  submodule--helper: libify determine_submodule_update_strategy()
  submodule--helper: libify "must_die_on_failure" code paths
  submodule--helper update: don't override 'checkout' exit code
  submodule--helper: libify "must_die_on_failure" code paths (for die)
  submodule--helper: check repo{_submodule,}_init() return values
  submodule--helper: libify more "die" paths for module_update()
  submodule--helper: libify even more "die" paths for module_update()
  submodule--helper: fix bad config API usage

 Makefile                         |   1 +
 builtin/submodule--helper.c      | 534 ++++++++++++++-----------------
 git-compat-util.h                |   3 +
 repository.h                     |   3 +
 submodule.c                      |  12 +-
 submodule.h                      |   2 +-
 t/helper/test-submodule-config.c |  11 +-
 t/helper/test-submodule.c        | 146 +++++++++
 t/helper/test-tool-utils.h       |   9 +
 t/helper/test-tool.c             |   7 +-
 t/helper/test-tool.h             |   1 +
 t/t0060-path-utils.sh            |   2 +-
 t/t7400-submodule-basic.sh       |  56 ++--
 t/t7406-submodule-update.sh      |   2 +-
 t/t7413-submodule-is-active.sh   |  35 +-
 t/t7450-bad-git-dotfiles.sh      |   2 +-
 16 files changed, 460 insertions(+), 366 deletions(-)
 create mode 100644 t/helper/test-submodule.c
 create mode 100644 t/helper/test-tool-utils.h

Range-diff against v2:
 1:  daa5d3f9962 !  1:  77586985ab3 submodule tests: test usage behavior
    @@ Commit message
         subsequent eventual behavior change will become clear.
     
         For "--" this follows up on 68cabbfda36 (submodule: document default
    -    behavior, 2019-02-15) and tests that "status" doesn't don't support
    +    behavior, 2019-02-15) and tests that "status" doesn't support
         the "--" delimiter. There's no intrinsically good reason not to
         support that. We behave this way due to edge cases in
         git-submodule.sh's implementation, but as with "-h" let's assert our
    @@ Commit message
         doesn't seem to be a reason not to support it alongside "--quiet" and
         "--cached", but let's likewise assert our existing behavior for now.
     
    +    I.e. as long as "status" is optional it would make sense to support
    +    all of its options when it's omitted, but we only do that with
    +    "--quiet" and "--cached", and curiously omit "--recursive".
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t7400-submodule-basic.sh ##
 2:  9d920326df3 =  2:  7425f0025da submodule tests: test for "add <repository> <abs-path>"
 3:  d981db49fa1 =  3:  1be48c0b22f submodule--helper: remove unused "name" helper
 4:  6f78f9c9274 =  4:  10189ba3da7 submodule--helper: remove unused "list" helper
 5:  43902201701 =  5:  ef66dfcd45f test-tool submodule-config: remove unused "--url" handling
 6:  e2a8bb0a28e =  6:  4727fbb4b64 submodule--helper: move "is-active" to a test-tool
 7:  b209532eb17 =  7:  9c644460b1d submodule--helper: move "check-name" to a test-tool
 8:  de49f31dab0 =  8:  03c8383b8e7 submodule--helper: move "resolve-relative-url-test" to a test-tool
 9:  b0238f699ce =  9:  b1eaa6a796b submodule--helper style: don't separate declared variables with \n\n
10:  5f5e68a868b = 10:  fd7fbe08536 submodule--helper style: add \n\n after variable declarations
11:  72dcf19e1c4 = 11:  356f07db436 submodule--helper: replace memset() with { 0 }-initialization
12:  e5e267dccd5 = 12:  241ac5c7eee submodule--helper: use xstrfmt() in clone_submodule()
13:  91558745e2e = 13:  f2f412f50c1 submodule--helper: move "sb" in clone_submodule() to its own scope
14:  866b8397a59 ! 14:  ad7848067a9 submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
    +    submodule--helper: add "const" to passed "module_clone_data"
     
         Add "const" to the "struct module_clone_data" that we pass to
         clone_submodule(), which makes the ownership clear, and stops us from
15:  1ff380ec7b5 = 15:  ab283479b92 submodule--helper: add "const" to copy of "update_data"
16:  d3a7e646adc = 16:  ab0fd2c60f0 submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
17:  23eb07176d9 = 17:  fa2417c7a17 submodule--helper: don't redundantly check "else if (res)"
18:  78f74df6d5e = 18:  be1ffbf2e26 submodule--helper: rename "int res" to "int ret"
19:  f0258e37ebe = 19:  92e17c37839 submodule--helper: return "ret", not "1" from update_submodule()
20:  70f030cca4e = 20:  55e3ea5f9dd submodule--helper: add missing braces to "else" arm
21:  bce1a014a2f = 21:  2bb45302392 submodule--helper: don't call submodule_strategy_to_string() in BUG()
22:  98c3e562c82 ! 22:  0131c197427 submodule--helper: move submodule_strategy_to_string() to only user
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    submodule--helper: move submodule_strategy_to_string() to only user
    +    submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string()
     
    -    Move the submodule_strategy_to_string() function added in
    -    3604242f080 (submodule: port init from shell to C, 2016-04-15) to its
    -    only user.
    +    Change the submodule_strategy_to_string() function added in
    +    3604242f080 (submodule: port init from shell to C, 2016-04-15) to
    +    really return a "const char *". In the "SM_UPDATE_COMMAND" case it
    +    would return a strbuf_detach().
     
    -    This function would return NULL on SM_UPDATE_UNSPECIFIED, so it wasn't
    -    safe to xstrdup() its return value in the general case, or to use it
    -    in a sprintf() format as the code removed in the preceding commit did.
    +    Furthermore, this function would return NULL on SM_UPDATE_UNSPECIFIED,
    +    so it wasn't safe to xstrdup() its return value in the general case,
    +    or to use it in a sprintf() format as the code removed in the
    +    preceding commit did.
     
         But its callers would never call it with either SM_UPDATE_UNSPECIFIED
    -    or SM_UPDATE_COMMAND. Let's move it to a "static" helper, and have its
    -    functionality reflect how it's used, and BUG() out on the rest.
    +    or SM_UPDATE_COMMAND. Let's have its behavior reflect how its only
    +    user expects it to behave, and BUG() out on the rest.
     
         By doing this we can also stop needlessly xstrdup()-ing and free()-ing
         the memory for the config we're setting. We can instead always use
         constant strings. We can also use the *_tmp() variant of
         git_config_get_string().
     
    +    Let's also rename this submodule_strategy_to_string() function to
    +    submodule_update_type_to_string(). Now that it's only tasked with
    +    returning a string version of the "enum submodule_update_type type".
    +    Before it would look at the "command" field in "struct
    +    submodule_update_strategy".
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    -@@ builtin/submodule--helper.c: struct init_cb {
    - };
    - #define INIT_CB_INIT { 0 }
    - 
    -+static const char *submodule_strategy_to_string(enum submodule_update_type type)
    -+{
    -+	switch (type) {
    -+	case SM_UPDATE_CHECKOUT:
    -+		return "checkout";
    -+	case SM_UPDATE_MERGE:
    -+		return "merge";
    -+	case SM_UPDATE_REBASE:
    -+		return "rebase";
    -+	case SM_UPDATE_NONE:
    -+		return "none";
    -+	case SM_UPDATE_UNSPECIFIED:
    -+	case SM_UPDATE_COMMAND:
    -+		BUG("init_submodule() should handle type %d", type);
    -+	default:
    -+		BUG("unexpected update strategy type: %d", type);
    -+	}
    -+}
    -+
    - static void init_submodule(const char *path, const char *prefix,
    - 			   unsigned int flags)
    +@@ builtin/submodule--helper.c: static void init_submodule(const char *path, const char *prefix,
      {
      	const struct submodule *sub;
      	struct strbuf sb = STRBUF_INIT;
    @@ builtin/submodule--helper.c: static void init_submodule(const char *path, const
     +			upd = "none";
      		} else {
     -			upd = xstrdup(submodule_strategy_to_string(&sub->update_strategy));
    -+			upd = submodule_strategy_to_string(sub->update_strategy.type);
    ++			upd = submodule_update_type_to_string(sub->update_strategy.type);
      		}
      
      		if (git_config_set_gently(sb.buf, upd))
    @@ submodule.c: int parse_submodule_update_strategy(const char *value,
      }
      
     -const char *submodule_strategy_to_string(const struct submodule_update_strategy *s)
    --{
    ++const char *submodule_update_type_to_string(enum submodule_update_type type)
    + {
     -	struct strbuf sb = STRBUF_INIT;
     -	switch (s->type) {
    --	case SM_UPDATE_CHECKOUT:
    --		return "checkout";
    --	case SM_UPDATE_MERGE:
    --		return "merge";
    --	case SM_UPDATE_REBASE:
    --		return "rebase";
    --	case SM_UPDATE_NONE:
    --		return "none";
    --	case SM_UPDATE_UNSPECIFIED:
    ++	switch (type) {
    + 	case SM_UPDATE_CHECKOUT:
    + 		return "checkout";
    + 	case SM_UPDATE_MERGE:
    +@@ submodule.c: const char *submodule_strategy_to_string(const struct submodule_update_strategy
    + 	case SM_UPDATE_NONE:
    + 		return "none";
    + 	case SM_UPDATE_UNSPECIFIED:
     -		return NULL;
    --	case SM_UPDATE_COMMAND:
    + 	case SM_UPDATE_COMMAND:
     -		strbuf_addf(&sb, "!%s", s->command);
     -		return strbuf_detach(&sb, NULL);
    --	}
    ++		BUG("init_submodule() should handle type %d", type);
    ++	default:
    ++		BUG("unexpected update strategy type: %d", type);
    + 	}
     -	return NULL;
    --}
    --
    + }
    + 
      void handle_ignore_submodules_arg(struct diff_options *diffopt,
    - 				  const char *arg)
    - {
     
      ## submodule.h ##
     @@ submodule.h: void die_path_inside_submodule(struct index_state *istate,
    @@ submodule.h: void die_path_inside_submodule(struct index_state *istate,
      int parse_submodule_update_strategy(const char *value,
      				    struct submodule_update_strategy *dst);
     -const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
    ++const char *submodule_update_type_to_string(enum submodule_update_type type);
      void handle_ignore_submodules_arg(struct diff_options *, const char *);
      void show_submodule_diff_summary(struct diff_options *o, const char *path,
      			    struct object_id *one, struct object_id *two,
23:  db2d2fb5a21 = 23:  6cac6cb2fa6 submodule--helper: use "code" in run_update_command()
24:  d33260487bd ! 24:  6d56f671c7a submodule--helper: don't exit() on failure, return
    @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      	if (update_data->recursive) {
      		struct child_process cp = CHILD_PROCESS_INIT;
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    + 		prepare_submodule_repo_env(&cp.env);
    + 		update_data_to_args(&next, &cp.args);
    + 
    +-		/* die() if child process die()'d */
    + 		ret = run_command(&cp);
    + 		if (!ret)
    + 			return 0;
      		die_message(_("Failed to recurse into submodule path '%s'"),
      			    update_data->displaypath);
      		if (ret == 128)
25:  9981a75d7e8 = 25:  dfd5c8bcd61 submodule--helper: libify determine_submodule_update_strategy()
26:  b48705c6cc0 ! 26:  da1a07afd25 submodule--helper: libify "must_die_on_failure" code paths
    @@ Commit message
         after having gone through the various codepaths that we were only
         returning 128 if we meant to early abort.
     
    +    In update_submodules() we'll for now set any non-zero non-128 exit
    +    codes to "1", but will start ferrying up the exit code as-is in a
    +    subsequent commit.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    @@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data
      {
      	int ret;
      
    +@@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
    + 						  update_data->sm_path,
    + 						  update_data->update_default,
    + 						  &update_data->update_strategy);
    +-	if (ret) {
    +-		*must_die_on_failure = 1;
    ++	if (ret)
    + 		return ret;
    +-	}
    + 
    + 	if (update_data->just_cloned)
    + 		oidcpy(&update_data->suboid, null_oid());
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
      	}
      
    @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      
      	if (update_data->recursive) {
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data,
    + 		update_data_to_args(&next, &cp.args);
      
    - 		/* die() if child process die()'d */
      		ret = run_command(&cp);
     -		if (!ret)
     -			return 0;
    @@ builtin/submodule--helper.c: static int update_submodules(struct update_data *up
      		update_data->sm_path = ucd.sub->path;
      
     -		code = update_submodule(update_data, &must_die_on_failure);
    -+		code = update_submodule(update_data);
    - 		if (code)
    - 			ret = code;
    +-		if (code)
    +-			ret = code;
     -		if (must_die_on_failure)
    -+		if (code == 128)
    ++		code = update_submodule(update_data);
    ++		if (!code)
    ++			continue;
    ++		ret = code;
    ++		if (ret == 128)
      			goto cleanup;
    - 		else if (code)
    - 			ret = 1;
    +-		else if (code)
    +-			ret = 1;
    ++		ret = 1;
    + 	}
    + 
    + cleanup:
 -:  ----------- > 27:  2795a3738c8 submodule--helper update: don't override 'checkout' exit code
27:  93cd1ccde54 ! 28:  6d9bccb34c3 submodule--helper: libify "must_die_on_failure" code paths (for die)
    @@ Commit message
                 const char *branch = remote_submodule_branch(update_data->sm_path);
     
         But as that code is used by other callers than the "update" code let's
    -    leave converting it for now.
    +    leave converting it for a subsequent commit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *upd
      	update_data->displaypath = get_submodule_displaypath(
      		update_data->sm_path, update_data->prefix);
     @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
    - 						  update_data->sm_path,
    - 						  update_data->update_default,
    - 						  &update_data->update_strategy);
    --	if (ret) {
    --		*must_die_on_failure = 1;
    -+	if (ret)
    - 		return ret;
    --	}
    - 
      	if (update_data->just_cloned)
      		oidcpy(&update_data->suboid, null_oid());
      	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
 -:  ----------- > 29:  d4b55f07a30 submodule--helper: check repo{_submodule,}_init() return values
 -:  ----------- > 30:  15c2490a978 submodule--helper: libify more "die" paths for module_update()
 -:  ----------- > 31:  1694ccfe882 submodule--helper: libify even more "die" paths for module_update()
28:  6160a1ab250 = 32:  d133402462f submodule--helper: fix bad config API usage
-- 
2.37.2.1279.g64dec4e13cf


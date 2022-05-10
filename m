Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03126C433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiEJT14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiEJTZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:25:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2012701BB
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:25:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bg25so10774018wmb.4
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PQKLYpRGBpiioy37NOvXxduBdisdepIbbpYIY88pVco=;
        b=koK5IqcRdCsnc6aaTi7nJy2wDQvdnEC5WuZbIWa/pnIuJYTuWRiw1Ply+UhRyuCX9g
         UPiMgTVwmReB7awyhVcGSXhoJQhFwNVhBCcCVMnoyoUTGclN8nT8bQ63UXklZHUoT+Os
         3XG3S0I9hjrVIOo4ZxGsIF8dF3l23ZR1UcqctaoVG/RiUILI4TVbGoYW0eHx3yr0rL49
         EH87HRmmzu/i4tfsRtigziikAXsYdh9BTehFrdrtEGmGR8Flfqi1uY9VhmOCNDoxMIvk
         Pn1BcDG0t7U5FavD/OQoFHo8qYIFmZRp5s5CT6IEiu7bZlnEyqG1Wby2OnSGixl+B3Mw
         RoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PQKLYpRGBpiioy37NOvXxduBdisdepIbbpYIY88pVco=;
        b=0TrYEhL8Gblq7iDnKqyOLopF+nIfaGznqIotV6AV/AWvmRX7D3fE7uz+uFCRZKSRTY
         e7S11jx82tE3bqNVCbovHqkvGpBxaw80+ogl4a131CHTvJMwZFvQURr5bxrHAvqc9XzH
         Vir1iaaN7YFyzgSTaoBnhT0zfuy8Trs2pHCZIoF+ok2KATko7h/51g/1QQ+6/EBGVUzH
         Qg83DOHiv+5HaJf2fdXzfKOMbJVmsGfGH3B7e2P2eKCitQOAeI0BN5MXQg3KO4arzCjB
         FWahiaj9kz33jcxHoPU6/8jde7c1QohlqS2IRP6EH74MSQLQGkNq4tZcgC3oE5v43dsU
         KUBA==
X-Gm-Message-State: AOAM531xky3qjIIgpA3mhlxfm78J3Scej3duu9yLhVVHRsYUHnj04gw6
        2UVZ3EbgLwqpF56bf8TrigKH4XTQhSQ=
X-Google-Smtp-Source: ABdhPJxvrQYCx6pI0jycWaYsufhHHhg4+0tGyuWM9VBIL+JUeuErAysRML2oyRWsemYIGlPq+cEROA==
X-Received: by 2002:a7b:cf0a:0:b0:394:7bf:66c7 with SMTP id l10-20020a7bcf0a000000b0039407bf66c7mr1434483wmg.52.1652210749422;
        Tue, 10 May 2022 12:25:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a056000170d00b0020c5253d911sm14836572wrc.93.2022.05.10.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:25:48 -0700 (PDT)
Message-Id: <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:25:47 +0000
Subject: [PATCH v2] pull: only pass '--recurse-submodules' to subcommands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Fix a bug in "git pull" where `submodule.recurse` is preferred over
`fetch.recurseSubmodules` when performing a fetch
(Documentation/config/fetch.txt says that `fetch.recurseSubmodules`
should be preferred.). Do this by passing the value of the
"--recurse-submodules" CLI option to the underlying fetch, instead of
passing a value that combines the CLI option and config variables.

In other words, this bug occurred because builtin/pull.c is conflating
two similar-sounding, but different concepts:

- Whether "git pull" itself should care about submodules e.g. whether it
  should update the submodule worktrees after performing a merge.
- The value of "--recurse-submodules" to pass to the underlying "git
  fetch".

Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
invoked with "--recurse-submodules[=value]", overriding the value of
`fetch.recurseSubmodules`.

An alternative (and more obvious) approach to fix the bug would be to
teach "git pull" to understand `fetch.recurseSubmodules`, but the
proposed solution works better because:

- We don't maintain two identical config-parsing implementions in "git
  pull" and "git fetch".
- It works better with other commands invoked by "git pull" e.g. "git
  merge" won't accidentally respect `fetch.recurseSubmodules`.

Reported-by: Huang Zou <huang.zou@schrodinger.com>
Helped-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
    pull: only pass '--recurse-submodules' to subcommands
    
    Thanks for the debugging help :)
    
    Changes since v1:
    
     * add a test that actually tests the precedence of the config values
       * I've kept the previous test; it has always worked, but it still
         seems like a useful smoke test
     * reworded the commit message slightly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1262%2Fchooglen%2Fpull%2Ffetch-recurse-submodules-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1262/chooglen/pull/fetch-recurse-submodules-v2
Pull-Request: https://github.com/git/git/pull/1262

Range-diff vs v1:

 1:  caad7092826 ! 1:  ba08e10b759 pull: only pass '--recurse-submodules' to subcommands
     @@ Commit message
          pull: only pass '--recurse-submodules' to subcommands
      
          Fix a bug in "git pull" where `submodule.recurse` is preferred over
     -    `fetch.recurseSubmodules` (Documentation/config/fetch.txt says that
     -    `fetch.recurseSubmodules` should be preferred.). Do this by passing the
     -    value of the "--recurse-submodules" CLI option to the underlying fetch,
     -    instead of passing a value that combines the CLI option and config
     -    variables.
     +    `fetch.recurseSubmodules` when performing a fetch
     +    (Documentation/config/fetch.txt says that `fetch.recurseSubmodules`
     +    should be preferred.). Do this by passing the value of the
     +    "--recurse-submodules" CLI option to the underlying fetch, instead of
     +    passing a value that combines the CLI option and config variables.
      
          In other words, this bug occurred because builtin/pull.c is conflating
          two similar-sounding, but different concepts:
     @@ Commit message
            fetch".
      
          Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
     -    invoked with "--recurse-submodules", overriding the value of
     +    invoked with "--recurse-submodules[=value]", overriding the value of
          `fetch.recurseSubmodules`.
      
          An alternative (and more obvious) approach to fix the bug would be to
     @@ t/t5572-pull-submodule.sh: test_expect_success " --[no-]recurse-submodule and su
       
      +test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
      +	test_commit -C child merge_strategy_5 &&
     -+	git -C parent submodule update --remote &&
     -+	git -C parent add sub &&
     -+	git -C parent commit -m "update submodule" &&
     ++	# Omit the parent commit, otherwise this passes with the
     ++	# default "pull" behavior.
      +
      +	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
      +	# Check that the submodule commit was fetched
     -+	sub_oid=$(git -C super rev-parse FETCH_HEAD:sub) &&
     ++	sub_oid=$(git -C child rev-parse HEAD) &&
      +	git -C super/sub cat-file -e $sub_oid &&
      +	# Check that the submodule worktree did not update
      +	! test_path_is_file super/sub/merge_strategy_5.t
      +'
     ++
     ++test_expect_success "fetch.recurseSubmodules takes precedence over submodule.recurse" '
     ++	test_commit -C child merge_strategy_6 &&
     ++	# Omit the parent commit, otherwise this passes with the
     ++	# default "pull" behavior.
     ++
     ++	git -C super -c submodule.recurse=false -c fetch.recursesubmodules=true pull --no-rebase &&
     ++	# Check that the submodule commit was fetched
     ++	sub_oid=$(git -C child rev-parse HEAD) &&
     ++	git -C super/sub cat-file -e $sub_oid &&
     ++	# Check that the submodule worktree did not update
     ++	! test_path_is_file super/sub/merge_strategy_6.t
     ++'
      +
       test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
       	# This tests the following scenario :


 builtin/pull.c            | 10 +++++++---
 t/t5572-pull-submodule.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4d667abc19d..01155ba67b2 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -72,6 +72,7 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static char *opt_progress;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
@@ -120,7 +121,7 @@ static struct option pull_options[] = {
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
 	OPT_CALLBACK_F(0, "recurse-submodules",
-		   &recurse_submodules, N_("on-demand"),
+		   &recurse_submodules_cli, N_("on-demand"),
 		   N_("control for recursive fetching of submodules"),
 		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 
@@ -536,8 +537,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		strvec_push(&args, opt_tags);
 	if (opt_prune)
 		strvec_push(&args, opt_prune);
-	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
-		switch (recurse_submodules) {
+	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
+		switch (recurse_submodules_cli) {
 		case RECURSE_SUBMODULES_ON:
 			strvec_push(&args, "--recurse-submodules=on");
 			break;
@@ -1001,6 +1002,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
 
+	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
+		recurse_submodules = recurse_submodules_cli;
+
 	if (cleanup_arg)
 		/*
 		 * this only checks the validity of cleanup_arg; we don't need
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index fa6b4cca65c..a35396fadf5 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -107,6 +107,32 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
 	test_path_is_file super/sub/merge_strategy_4.t
 '
 
+test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
+	test_commit -C child merge_strategy_5 &&
+	# Omit the parent commit, otherwise this passes with the
+	# default "pull" behavior.
+
+	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
+	# Check that the submodule commit was fetched
+	sub_oid=$(git -C child rev-parse HEAD) &&
+	git -C super/sub cat-file -e $sub_oid &&
+	# Check that the submodule worktree did not update
+	! test_path_is_file super/sub/merge_strategy_5.t
+'
+
+test_expect_success "fetch.recurseSubmodules takes precedence over submodule.recurse" '
+	test_commit -C child merge_strategy_6 &&
+	# Omit the parent commit, otherwise this passes with the
+	# default "pull" behavior.
+
+	git -C super -c submodule.recurse=false -c fetch.recursesubmodules=true pull --no-rebase &&
+	# Check that the submodule commit was fetched
+	sub_oid=$(git -C child rev-parse HEAD) &&
+	git -C super/sub cat-file -e $sub_oid &&
+	# Check that the submodule worktree did not update
+	! test_path_is_file super/sub/merge_strategy_6.t
+'
+
 test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
 	# This tests the following scenario :
 	# - local submodule has new commits

base-commit: e8005e4871f130c4e402ddca2032c111252f070a
-- 
gitgitgadget

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F81C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 23:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbiEIXbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 19:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiEIXbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 19:31:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C08CE7327
        for <git@vger.kernel.org>; Mon,  9 May 2022 16:27:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d5so21455996wrb.6
        for <git@vger.kernel.org>; Mon, 09 May 2022 16:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=yfO8LVXam42Gh4pI+FGUuHSugJMGgVu/+EUL2M5evrg=;
        b=QLVidS9jZeS2OUKTZCN/08L6+yD32slfLpmNbKCISEkdCxl8PJ7rKNUeIQNKb/I+/w
         ofVAJ51yWFWTEWr271L4whbYZgI3ioVt8n6eaCAp9W5G4WruKSVcTLFCAaMKQr4B39Ls
         +L3uKv+QLKG1BJtdWdX/JnuNNSWOOfs8OhVipSiDduqTz7qhvfBbDBYbjFWjb6GvUK0C
         ABInzN/jAG/G+3I4IB+RWemyBX0ClgaPyKuWyYLKF/HJB029ISH7sBMgqaRODPL5DAA2
         9uceNkZvZL1SlEzK0Kx3gaajB13iZh37PvIIa0huYJNVlwst0DimoOYjC2otIBFsrZjC
         eehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yfO8LVXam42Gh4pI+FGUuHSugJMGgVu/+EUL2M5evrg=;
        b=47jX/FcrYbIFBZd/7bM8Tran89fIAsRkd5DVLwiM8sDPTuJGIINcie1iSSocUoGx06
         X3zAK4F0aEWOVUoCLE0fuETHF20xxVgRD6nFVFUaxEyyChvztIGT2oUqqlv8jBFQd8D8
         cwLW/tRbjzhvjh6U27PpqkqCBI6I8wYsEl+6BoKE/FwWn4HfieCLB0qjkfP9+WOHyl4K
         QmyDcfzoMX3Mxi6SWH2fn9dfTE8825BtYwy29S9rRJAPntZMCsmYB91FSAzsgyUPF/18
         w4PzrmGhYR2lqj/nhFZ2PdL7kyWvQq4FUenwte7xNAfnwwuNlU93zF+MBFINoTQ0SI0x
         5Ypg==
X-Gm-Message-State: AOAM5322BZy8+V3FFSt5RAGmJTnP3RTBdq9eksZkV8d6N6UoDdBohUq4
        Jd43E11oH+YKrXzgDIZqdJBeDsow1Xc=
X-Google-Smtp-Source: ABdhPJyP1V0nu8ZtdJUb7sjZRAMy4Ty3cguCB8BOr4OMqQ25EdwJ+a2hvtWvJmSeR3dJlPat159zEA==
X-Received: by 2002:a5d:6d04:0:b0:20c:52de:9ce4 with SMTP id e4-20020a5d6d04000000b0020c52de9ce4mr17171839wrq.572.1652138855726;
        Mon, 09 May 2022 16:27:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4748000000b0020c5253d8fbsm11933945wrs.71.2022.05.09.16.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:27:35 -0700 (PDT)
Message-Id: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 May 2022 23:27:34 +0000
Subject: [PATCH] pull: only pass '--recurse-submodules' to subcommands
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
`fetch.recurseSubmodules` (Documentation/config/fetch.txt says that
`fetch.recurseSubmodules` should be preferred.). Do this by passing the
value of the "--recurse-submodules" CLI option to the underlying fetch,
instead of passing a value that combines the CLI option and config
variables.

In other words, this bug occurred because builtin/pull.c is conflating
two similar-sounding, but different concepts:

- Whether "git pull" itself should care about submodules e.g. whether it
  should update the submodule worktrees after performing a merge.
- The value of "--recurse-submodules" to pass to the underlying "git
  fetch".

Thus, when `submodule.recurse` is set, the underlying "git fetch" gets
invoked with "--recurse-submodules", overriding the value of
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
    
    Thanks Huang Zou for the report [1], and Philippe Blain for the initial
    investigation.
    
    This patch fixes the original bug, but not in the 'obvious' way of
    teaching "git pull" to parse fetch.recurseSubmodules. Instead, "git
    pull" now propagates its value of "--recurse-submodules" to "git fetch"
    (ignoring any config values), and leaves the config parsing to "git
    fetch".
    
    I think this works better because we get a nice separation of "config
    that git pull cares about" and "config that its subprocess care about",
    and as a result:
    
     * We don't maintain two identical config-parsing implementations in
       "git pull" and "git fetch".
     * It works better with other commands invoked by "git pull" e.g. "git
       merge" won't accidentally respect fetch.recurseSubmodules.
    
    PS I'm having a hard time writing today, let me know how the commit
    message/cover letter can be improved :)
    
    [1]
    https://lore.kernel.org/git/CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com
    
    In-Reply-To:
    CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1262%2Fchooglen%2Fpull%2Ffetch-recurse-submodules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1262/chooglen/pull/fetch-recurse-submodules-v1
Pull-Request: https://github.com/git/git/pull/1262

 builtin/pull.c            | 10 +++++++---
 t/t5572-pull-submodule.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

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
index fa6b4cca65c..65aaa7927fb 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -107,6 +107,20 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
 	test_path_is_file super/sub/merge_strategy_4.t
 '
 
+test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
+	test_commit -C child merge_strategy_5 &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super -c fetch.recursesubmodules=true pull --no-rebase &&
+	# Check that the submodule commit was fetched
+	sub_oid=$(git -C super rev-parse FETCH_HEAD:sub) &&
+	git -C super/sub cat-file -e $sub_oid &&
+	# Check that the submodule worktree did not update
+	! test_path_is_file super/sub/merge_strategy_5.t
+'
+
 test_expect_success 'pull --rebase --recurse-submodules (remote superproject submodule changes, local submodule changes)' '
 	# This tests the following scenario :
 	# - local submodule has new commits

base-commit: e8005e4871f130c4e402ddca2032c111252f070a
-- 
gitgitgadget

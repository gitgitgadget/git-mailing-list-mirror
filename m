Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A61C4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58CE206A1
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 11:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ckHylp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgJDLUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgJDLSd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 07:18:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B444C0613D0
        for <git@vger.kernel.org>; Sun,  4 Oct 2020 04:18:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so4616457pff.6
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vkunGs/rQFjMIkke4JOInDJ7G45d31g1bCGBMMEE3jg=;
        b=e+ckHylpWB9orqs3T9b8E2zC/lidh/WS8iNYvcovqDb4awcVCiLcWJdCINXmT9mipB
         5qqqhOrUGSWAMB2dhI2VX8C1XIOL9L8rqwDscP6VetQwlL63/w2Rx7gDxYJj4iei/BN1
         aWi6WEV5f+IMWVHlKe9o0EV14CcABo5b13assUw6SF4/5LWJg7X2aqzo4XdIZThg1LAt
         vY7+HSeTND2rly1pl3JnMDhUb52mO95YfDRXSWMP64Ui/YIbqRyPuPAT+RiS7hAQF6rg
         XppI+eIuCWt85SGYFUAqDM2UVV6kNuwlXQLeLDo4PmpgRnzQimCyzLgSYDPTkI/gpK2k
         qm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vkunGs/rQFjMIkke4JOInDJ7G45d31g1bCGBMMEE3jg=;
        b=hp/dWZA3sA56tHjdL81boc7vbpQkFASLkJwnJHu1gqeMSUfiGP9drRM8VN3OOsmwBp
         +sheTR+owJblXOXOz1N2o4NWCep0UfN6VTgtoCVemNjEzjjXfXSLN55w1/YG1zTE51m+
         jg9ARZVEwX2QDUe+utaJMxN8kFfAUwyiZ56LnNAZ4Snzq86016Ujo3hZM4YLBu5btszq
         mTz/RgGXGpa8hn2tIRs0QXuLIMVTywDxCJLS4W68Y8rQPOPYAKhWDujdAeghgaTSi0zc
         nXz6EOs257m4DTMnUd7933AcFkV1xbkk5Eu7sHLFo1M5y0zmcaFVn46qoufcLk1HhwUc
         tUSQ==
X-Gm-Message-State: AOAM532grrt99xZcf9EkgXF/L8NY0pg4jnfI92PfTz1wx5rhxCEXf/n/
        DsRWqAMnPx7e/LJKuS8c5hGO0C0qqM0=
X-Google-Smtp-Source: ABdhPJye1qDKHrEXA5vnbcmjH2RgU81siFSHn2M5iY5E5z6os7TWV7EjlG1axWNG4XckWG4KbxPOYw==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr9665973pgr.20.1601810312557;
        Sun, 04 Oct 2020 04:18:32 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id 78sm4298162pfz.211.2020.10.04.04.18.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 04:18:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] checkout: learn to respect checkout.guess
Date:   Sun,  4 Oct 2020 04:18:24 -0700
Message-Id: <8172602f6f1bbdfe39c8a1219dd3b9a222eb65fa.1601810233.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1601810233.git.liu.denton@gmail.com>
References: <cover.1601810233.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current behavior of git checkout/switch is that --guess is currently
enabled by default. However, some users may not wish for this to happen
automatically. Instead of forcing users to specify --no-guess manually
each time, teach these commands the checkout.guess configuration
variable that gives users the option to set a default behavior.

Teach the completion script to recognize the new config variable and
disable DWIM logic if it is set to false.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/checkout.txt      |  5 +++
 Documentation/git-checkout.txt         |  3 ++
 Documentation/git-switch.txt           |  3 ++
 builtin/checkout.c                     |  7 +++-
 contrib/completion/git-completion.bash | 15 ++++++--
 t/t2024-checkout-dwim.sh               | 11 ++++++
 t/t2060-switch.sh                      |  5 ++-
 t/t9902-completion.sh                  | 52 ++++++++++++++++++++++++++
 8 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index e3684a5459..2cddf7b4b4 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -16,3 +16,8 @@ will checkout the `<something>` branch on another remote,
 and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
+
+checkout.guess::
+	Provides the default value for the `--guess` or `--no-guess`
+	option in `git checkout` and `git switch`. See
+	linkgit:git-switch[1] and linkgit:git-checkout[1].
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index afa5c11fd3..28f656d04e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -193,6 +193,9 @@ branches from there if `<branch>` is ambiguous but exists on the
 linkgit:git-config[1].
 +
 Use `--no-guess` to disable this.
++
+The default behavior can be set via the `checkout.guess` configuration
+variable.
 
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 3759c3a265..5c438cd505 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -103,6 +103,9 @@ ambiguous but exists on the 'origin' remote. See also
 `checkout.defaultRemote` in linkgit:git-config[1].
 +
 `--guess` is the default behavior. Use `--no-guess` to disable it.
++
+The default behavior can be set via the `checkout.guess` configuration
+variable.
 
 -f::
 --force::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0951f8fee5..0c0394a0d6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1093,11 +1093,16 @@ static int switch_branches(const struct checkout_opts *opts,
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
+	struct checkout_opts *opts = cb;
+
 	if (!strcmp(var, "diff.ignoresubmodules")) {
-		struct checkout_opts *opts = cb;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
+	if (!strcmp(var, "checkout.guess")) {
+		opts->dwim_new_local_branch = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "submodule."))
 		return git_default_submodule_config(var, value, NULL);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8be4a0316e..45ecbb9849 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1470,11 +1470,12 @@ _git_bundle ()
 # To decide between the following rules in priority order
 # 1) the last provided of "--guess" or "--no-guess" explicitly enable or
 #    disable completion of DWIM logic respectively.
-# 2) If the --no-track option is provided, take this as a hint to disable the
+# 2) If checkout.guess is false, disable completion of DWIM logic.
+# 3) If the --no-track option is provided, take this as a hint to disable the
 #    DWIM completion logic
-# 3) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
+# 4) If GIT_COMPLETION_CHECKOUT_NO_GUESS is set, disable the DWIM completion
 #    logic, as requested by the user.
-# 4) Enable DWIM logic otherwise.
+# 5) Enable DWIM logic otherwise.
 #
 __git_checkout_default_dwim_mode ()
 {
@@ -1485,11 +1486,17 @@ __git_checkout_default_dwim_mode ()
 	fi
 
 	# --no-track disables DWIM, but with lower priority than
-	# --guess/--no-guess
+	# --guess/--no-guess/checkout.guess
 	if [ -n "$(__git_find_on_cmdline "--no-track")" ]; then
 		dwim_opt=""
 	fi
 
+	# checkout.guess = false disables DWIM, but with lower priority than
+	# --guess/--no-guess
+	if [ "$(__git config --type=bool checkout.guess)" = "false" ]; then
+		dwim_opt=""
+	fi
+
 	# Find the last provided --guess or --no-guess
 	last_option="$(__git_find_last_on_cmdline "--guess --no-guess")"
 	case "$last_option" in
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index accfa9aa4b..a4f8d3a67e 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -166,6 +166,17 @@ test_expect_success '--no-guess suppresses branch auto-vivification' '
 	test_branch master
 '
 
+test_expect_success 'checkout.guess = false suppresses branch auto-vivification' '
+	git checkout -B master &&
+	status_uno_is_clean &&
+	test_might_fail git branch -D bar &&
+
+	test_config checkout.guess false &&
+	test_must_fail git checkout bar &&
+	test_must_fail git rev-parse --verify refs/heads/bar &&
+	test_branch master
+'
+
 test_expect_success 'setup more remotes with unconventional refspecs' '
 	git checkout -B master &&
 	status_uno_is_clean &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 2c1b8c0d6d..68c9101b02 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -85,9 +85,12 @@ test_expect_success 'switching ignores file of same branch name' '
 	test_cmp expected actual
 '
 
-test_expect_success 'guess and create branch ' '
+test_expect_success 'guess and create branch' '
 	test_when_finished git switch master &&
 	test_must_fail git switch --no-guess foo &&
+	test_config checkout.guess false &&
+	test_must_fail git switch foo &&
+	test_config checkout.guess true &&
 	git switch foo &&
 	echo refs/heads/foo >expected &&
 	git symbolic-ref HEAD >actual &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 8425b9a531..2b469a71ca 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1360,6 +1360,58 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	EOF
 '
 
+test_expect_success 'git checkout - with checkout.guess = false, only completes refs' '
+	test_config checkout.guess false &&
+	test_completion "git checkout " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - with checkout.guess = true, completes refs and unique remote branches for DWIM' '
+	test_config checkout.guess true &&
+	test_completion "git checkout " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --guess overrides previous checkout.guess = false, complete refs and unique remote branches for DWIM' '
+	test_config checkout.guess false &&
+	test_completion "git checkout --guess " <<-\EOF
+	HEAD Z
+	branch-in-other Z
+	master Z
+	master-in-other Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
+test_expect_success 'git checkout - a later --no-guess overrides previous checkout.guess = true, complete only refs' '
+	test_config checkout.guess true &&
+	test_completion "git checkout --no-guess " <<-\EOF
+	HEAD Z
+	master Z
+	matching-branch Z
+	matching-tag Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	EOF
+'
+
 test_expect_success 'git switch - with --detach, complete all references' '
 	test_completion "git switch --detach " <<-\EOF
 	HEAD Z
-- 
2.28.0.942.g77c4c6094c


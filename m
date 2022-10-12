Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F58C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 15:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJLP74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJLP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 11:59:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A86FD15
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:59:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1518629wmb.5
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=smZk8uToupx+6cBru9fJQuhSzlT2lYx5N4fJxaE6yhs=;
        b=Gp/TibOXZjxqKDXefFRSMTPl8N3B+NaH7tIpq8zE0kNC1HfrGkOzLOYc6a+F7/Bq11
         jEWz4IpTmCROXYxmiGS839C9jWih4x+KEt3k/UFgJmV5YWl7ClNpQqqO9tBdoqrOS0EP
         nZCECmZBrGe8m/zXNcvVXGxGM7HisYRtlsvITVIds2wuiO5p4xWA3N/i6q411/iJsPgO
         upZJ5hiNMesunH0WuRV1wozOMft6wwPv1iJvMClAT4F0DDZW8MOepfrpIw32TvidrXnC
         a/hrMvljJLUneWONylBzpxS3gxqlCivHs3GratDDfvT/38PeKIyVnKzmBkwEtEOeS3yA
         vqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smZk8uToupx+6cBru9fJQuhSzlT2lYx5N4fJxaE6yhs=;
        b=67wfvQiozaKaRAKoNi80aD5T/hI1rXLQbRMNMVIc7s+w8rvHyhvrQY5XvC1ks81B0j
         TlIUHgky3bwBCNUEop89pqRHeCOfCZXeQ6ZLG5RYoP9tBdzpBzOckmf4S+/mKW633o7/
         FFuKttpqVKstN5xseHDlQsBw3wgwOF7l0LGWa6Sfm/jNbI0iK+6CZRgRti2pcAcjWUyl
         wdzbnj1fkyjtGNKZa4VFOjYzzbHQE2CZVbbhdqbASg7fpupWnXqg3FVNg1/WQFWy1jd4
         0p+2R09R4omgYnDAizG8EH/lpVaABsPAr8b8g5aDrAa2AkJGo7s32eIVFweAfcYBRYK1
         mWlQ==
X-Gm-Message-State: ACrzQf1WrJMb1dxELsxfBFiqKm1OecRVvWnDDSOKniUMUYw5y7PnmvPW
        iLYxDkTp/9sHU6GLYZscllSs7b/QaPE=
X-Google-Smtp-Source: AMsMyM7G6dc1w+aefleoCehM7yxzWEpDlowtqs4HYkwyk4pXe8LvpgeRH5UOe0itMalotdnQZoCMzQ==
X-Received: by 2002:a1c:2507:0:b0:3b3:3681:f774 with SMTP id l7-20020a1c2507000000b003b33681f774mr3392891wml.134.1665590390783;
        Wed, 12 Oct 2022 08:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d52ca000000b0022cd6e852a2sm86873wrv.45.2022.10.12.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:59:49 -0700 (PDT)
Message-Id: <pull.1381.git.1665590389045.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 15:59:48 +0000
Subject: [PATCH] mergetool: new config guiDefault supports auto-toggling gui
 by DISPLAY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

When no merge.tool or diff.tool is configured or manually selected, the
selection of a default tool is sensitive to the DISPLAY variable; in a
GUI session a gui-specific tool will be proposed if found, and
otherwise a terminal-based one. This "GUI-optimizing" behavior is
important because a GUI can make a huge difference to a user's ability
to understand and correctly complete a non-trivial conflicting merge.

Some time ago the merge.guitool and diff.guitool config options were
introduced to enable users to configure both a GUI tool, and a non-GUI
tool (with fallback if no GUI tool configured), in the same environment.

Unfortunately, the --gui argument introduced to support the selection of
the guitool is still explicit. When using configured tools, there is no
equivalent of the no-tool-configured "propose a GUI tool if we are in a GUI
environment" behavior.

Introduce new configuration options, difftool.guiDefault and
mergetool.guiDefault, supporting a special value "auto" which causes the
corresponding tool or guitool to be selected depending on the presence of a
non-empty DISPLAY value. Also support "true" to say "default to the guitool
(unless --no-gui is passed on the commandline)", and "false" as the previous
default behavior when these new configuration options are not specified.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    RFC: mergetool: new config guiDefault supports auto-toggling gui by
    DISPLAY
    
    I'm confortable that with this patch we do the right thing, but I'm not
    sure about a couple of specific code patterns and implementation
    choices:
    
     * In difftool.c, I added a new enum and arg validation function, but
       didn't know where in the file to place them. Is there any guidance on
       this that I missed?
    
     * In git-mergetool--lib.sh, I used an awkward "tr" call to make the
       config value case-insensitive (to support "Auto" for example); Would
       relying on bash 4's case conversion support be better?
    
     * In git-mergetool--lib.sh the way I implemented the "auto" special
       value means that if you put an arbitrary value in the config, eg the
       typo "uato", you get an error about it being an invalid boolean
       config value; is that OK? Is there a better way to handle "boolean or
       special value" config validation? Are there any examples?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1381%2FTaoK%2Ftao-mergetool-autogui-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1381/TaoK/tao-mergetool-autogui-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1381

 Documentation/config/difftool.txt  |  7 +++++
 Documentation/config/mergetool.txt |  7 +++++
 Documentation/git-difftool.txt     | 10 +++++---
 Documentation/git-mergetool.txt    |  9 ++++---
 builtin/difftool.c                 | 40 ++++++++++++++++++++++++-----
 git-mergetool--lib.sh              | 26 +++++++++++++++++++
 git-mergetool.sh                   |  2 +-
 t/t7610-mergetool.sh               | 39 ++++++++++++++++++++++++++++
 t/t7800-difftool.sh                | 41 ++++++++++++++++++++++++++++++
 9 files changed, 165 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
index a3f82112102..8c2f7460be4 100644
--- a/Documentation/config/difftool.txt
+++ b/Documentation/config/difftool.txt
@@ -34,3 +34,10 @@ See the `--trust-exit-code` option in linkgit:git-difftool[1] for more details.
 
 difftool.prompt::
 	Prompt before each invocation of the diff tool.
+
+difftool.guiDefault::
+	Set 'true' to use the diff.guitool by default (equivalent to specifying
+	the "--gui" argument), or "auto" to select diff.guitool or diff.tool
+	depending on the presence of a DISPLAY environment variable value. The
+	default is 'false', where the "--gui" argument must be provided
+	explicitly for the diff.guitool to be used.
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 90b38097002..bc1a85abc95 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -85,3 +85,10 @@ mergetool.writeToTemp::
 
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
+
+mergetool.guiDefault::
+	Set 'true' to use the merge.guitool by default (equivalent to
+	specifying the "--gui" argument), or "auto" to select merge.guitool
+	or merge.tool depending on the presence of a DISPLAY environment
+	variable value. The default is 'false', where the "--gui" argument
+	must be provided explicitly for the merge.guitool to be used.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 9d14c3c9f09..a09dfb072d5 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -97,10 +97,12 @@ instead.  `--no-symlinks` is the default on Windows.
 --[no-]gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
-	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
-	option can be used to override this setting. If `diff.guitool`
-	is not set, we will fallback in the order of `merge.guitool`,
-	`diff.tool`, `merge.tool` until a tool is found.
+	`diff.guitool` variable instead of `diff.tool`. This may be
+	autoselected using the configuration variable
+	`difftool.guiDefault`. The `--no-gui` option can be used to
+	override these settings. If `diff.guitool` is not set, we will
+	fallback in the order of `merge.guitool`, `diff.tool`,
+	`merge.tool` until a tool is found.
 
 --[no-]trust-exit-code::
 	'git-difftool' invokes a diff tool individually on each file.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index c44e205629b..07535f6576e 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -85,12 +85,13 @@ success of the resolution after the custom tool has exited.
 	the default merge tool will be read from the configured
 	`merge.guitool` variable instead of `merge.tool`. If
 	`merge.guitool` is not set, we will fallback to the tool
-	configured under `merge.tool`.
+	configured under `merge.tool`. This may be autoselected using
+	the configuration variable `mergetool.guiDefault`.
 
 --no-gui::
-	This overrides a previous `-g` or `--gui` setting and reads the
-	default merge tool will be read from the configured `merge.tool`
-	variable.
+	This overrides a previous `-g` or `--gui` setting or
+	`mergetool.guiDefault` configuration and reads the default merge
+	tool from the configured `merge.tool` variable.
 
 -O<orderfile>::
 	Process files in the order specified in the
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4b10ad1a369..2a7d5ec5f42 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -680,14 +680,37 @@ static int run_file_diff(int prompt, const char *prefix,
 	return run_command(child);
 }
 
+enum difftool_gui_mode {
+	GUI_DISABLED = -1,
+	GUI_BY_CONFIG = 0,
+	GUI_ENABLED = 1
+};
+
+static int difftool_opt_gui(const struct option *opt,
+			      const char *optarg, int unset)
+{
+	enum difftool_gui_mode *mode;
+	mode = opt->value;
+
+	BUG_ON_OPT_ARG(optarg);
+
+	if (unset)
+		*mode = GUI_DISABLED;
+	else
+		*mode = GUI_ENABLED;
+	return 0;
+}
+
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
-	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0, no_index = 0;
+	int dir_diff = 0, prompt = -1, symlinks = 0, tool_help = 0,
+	    no_index = 0;
+	enum difftool_gui_mode gui_mode;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
-		OPT_BOOL('g', "gui", &use_gui_tool,
-			 N_("use `diff.guitool` instead of `diff.tool`")),
+		OPT_CALLBACK_F('g', "gui", &gui_mode, NULL,
+			       N_("use `diff.guitool` instead of `diff.tool`"),
+			       PARSE_OPT_NOARG, difftool_opt_gui),
 		OPT_BOOL('d', "dir-diff", &dir_diff,
 			 N_("perform a full-directory diff")),
 		OPT_SET_INT_F('y', "no-prompt", &prompt,
@@ -732,13 +755,16 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
-	die_for_incompatible_opt3(use_gui_tool, "--gui",
+	die_for_incompatible_opt3(gui_mode == GUI_ENABLED, "--gui",
 				  !!difftool_cmd, "--tool",
 				  !!extcmd, "--extcmd");
 
-	if (use_gui_tool)
+	if (gui_mode == GUI_ENABLED)
 		setenv("GIT_MERGETOOL_GUI", "true", 1);
-	else if (difftool_cmd) {
+	else if (gui_mode == GUI_DISABLED)
+		setenv("GIT_MERGETOOL_GUI", "false", 1);
+
+	if (difftool_cmd) {
 		if (*difftool_cmd)
 			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);
 		else
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9f99201bcca..8dbd04e5c5c 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -97,7 +97,33 @@ merge_mode () {
 	test "$TOOL_MODE" = merge
 }
 
+get_gui_default () {
+	if diff_mode
+	then
+		GUI_DEFAULT_KEY="difftool.guiDefault"
+	else
+		GUI_DEFAULT_KEY="mergetool.guiDefault"
+	fi
+	GUI_DEFAULT_CONFIG_LCASE=$(git config --default false --get $GUI_DEFAULT_KEY  | tr '[:upper:]' '[:lower:]')
+	if [ "$GUI_DEFAULT_CONFIG_LCASE" = "auto" ]
+	then
+		if [ -n "$DISPLAY" ]
+		then
+			GUI_DEFAULT=true
+		else
+			GUI_DEFAULT=false
+		fi
+	else
+		GUI_DEFAULT=$(git config --default false --bool --get $GUI_DEFAULT_KEY)
+	fi
+	echo $GUI_DEFAULT
+}
+
 gui_mode () {
+	if [ -z "$GIT_MERGETOOL_GUI" ]
+	then
+		GIT_MERGETOOL_GUI=$(get_gui_default)
+	fi
 	test "$GIT_MERGETOOL_GUI" = true
 }
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index f751d9cfe20..f510ff9ea70 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -451,7 +451,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
-	GIT_MERGETOOL_GUI=false
+	GIT_MERGETOOL_GUI=
 	guessed_merge_tool=false
 	orderfile=
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 8cc64729adb..3a807fd681c 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -860,4 +860,43 @@ test_expect_success 'mergetool hideResolved' '
 	git commit -m "test resolved with mergetool"
 '
 
+test_expect_success 'mergetool with guiDefault' '
+	test_config merge.guitool myguitool &&
+	test_config mergetool.myguitool.cmd "(printf \"gui \" && cat \"\$REMOTE\") >\"\$MERGED\"" &&
+	test_config mergetool.myguitool.trustExitCode true &&
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge main &&
+
+	test_config mergetool.guiDefault auto &&
+	DISPLAY=SOMETHING && export DISPLAY &&
+	yes "" | git mergetool both &&
+	yes "" | git mergetool file1 file1 &&
+
+	DISPLAY= && export DISPLAY &&
+	yes "" | git mergetool file2 "spaced name" &&
+
+	test_config mergetool.guiDefault true &&
+	yes "" | git mergetool subdir/file3 &&
+
+	yes "d" | git mergetool file11 &&
+	yes "d" | git mergetool file12 &&
+	yes "l" | git mergetool submod &&
+
+
+	echo "gui main updated" >expect &&
+	test_cmp expect file1 &&
+
+	echo "main new" >expect &&
+	test_cmp expect file2 &&
+
+	echo "gui main new sub" >expect &&
+	test_cmp expect subdir/file3 &&
+
+	echo "branch1 submodule" >expect &&
+	test_cmp expect submod/bar &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_done
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 096456292c0..ef785c55747 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -155,6 +155,47 @@ test_expect_success 'difftool honors --gui' '
 	test_cmp expect actual
 '
 
+test_expect_success 'difftool with guiDefault auto selects gui tool when there is DISPLAY' '
+	difftool_test_setup &&
+	test_config merge.tool bogus-tool &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
+	test_config difftool.guiDefault auto &&
+	DISPLAY=SOMETHING && export DISPLAY &&
+
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'difftool with guiDefault auto selects regular tool when no DISPLAY' '
+	difftool_test_setup &&
+	test_config diff.guitool bogus-tool &&
+	test_config diff.tool test-tool &&
+	test_config difftool.guiDefault auto &&
+	DISPLAY= && export DISPLAY &&
+
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'difftool with guiDefault true selects gui tool' '
+	difftool_test_setup &&
+	test_config diff.tool bogus-tool &&
+	test_config diff.guitool test-tool &&
+	test_config difftool.guiDefault true &&
+
+	DISPLAY= && export DISPLAY &&
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual &&
+
+	DISPLAY=Something && export DISPLAY &&
+	echo branch >expect &&
+	git difftool --no-prompt branch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'difftool --gui last setting wins' '
 	difftool_test_setup &&
 	: >expect &&

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget

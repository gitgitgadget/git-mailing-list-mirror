Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3DC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24D6212CC
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvYdIvMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgJGV4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgJGV4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 17:56:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C5C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 14:56:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so4030973wmd.5
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N2hpXOKXJrx0YwPZYQfwv5vecH2ViW9T8K4fCpJaW9Y=;
        b=IvYdIvMcBrVTsTGUBty2HVLHzvmLe7taP+UN6vCHwZk43uYaEr9FCNpgvuoVvTkchN
         VA5KLcIev1j2467eEahl846goFV9ddF/3NvWms+tZDf5tdKJIGJUD+wAoE7YUtvN/H2c
         BPKgORG6JiHcaAt2WPCHOpq2ufmpNumKebz4zRotDnBwGLwQ/U06RQC9l5nsSRaD5Jpd
         GW0q7VNetV0bVW+LPQ5oCaWLHMNCg56e2b7Grtc2lYiFAbrN81JVCnQLr9Rd/CR3szbi
         9hmeoeInK6KSG8WW25KHfcOAlwBL7F/CoLO6YRhlmL3c87LDmLC2K9pX/dWzzeZLhJZc
         z2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N2hpXOKXJrx0YwPZYQfwv5vecH2ViW9T8K4fCpJaW9Y=;
        b=Hn5PBHpKJe+mTG4hXDjSceAZ1j5RnwRgma6bsaluhCn45mrFWImpY+Imnjg4asje4i
         W6MwBt2kU4D2c0rZK3L4+w04K3VhYuJQw8MID3mwr0Xc84mg7St9enKWw1QhuiANd9Hh
         A0qbJZtz7OKRtp8Y4vUpAMjCGfTQZnVvn3bt7h7PtYXfym4/JejKIXytmjoyLMcw/JmL
         o5mFwzKEJeQ1eko6hsn71GnBsIn5UK/xLQKThiuqGwqTajFhgzS/rCPsHd+NEixAN+i7
         CTp+mVR+yBJ7G7Gr/IYYRzv6aGnCRtM8ZlzSwlEI2Ez5pxOADSWs6lIXMFkz2SoXFgzm
         8jVQ==
X-Gm-Message-State: AOAM531A1gc5bowsJmeDoYCGQzGnrjmGrQzl5WLXn9NFT05zGyE0X1FM
        hRDn/VvA+LXAcHq4MHzAu64a42wDf7M=
X-Google-Smtp-Source: ABdhPJzlhSHl8/Dyw9YNaoaTbOFWSIUcI7UPOfBFNjpG1U42PsSgaj/ZVHafDFcAMSu+eyCgbFFdKg==
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr5510072wma.11.1602107812675;
        Wed, 07 Oct 2020 14:56:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 76sm4304716wma.42.2020.10.07.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 14:56:52 -0700 (PDT)
Message-Id: <pull.745.v2.git.1602107811507.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.git.1602074589460.gitgitgadget@gmail.com>
References: <pull.745.git.1602074589460.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 21:56:51 +0000
Subject: [PATCH v2] help: do not expect built-in commands to be hardlinked
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When building with SKIP_DASHED_BUILT_INS=YesPlease, the built-in
commands are no longer present in the `PATH` as hardlinks to `git`.

As a consequence, `load_command_list()` needs to be taught to find the
names of the built-in commands from elsewhere.

This only affected the output of `git --list-cmds=main`, but not the
output of `git help -a` because the latter includes the built-in
commands by virtue of them being listed in command-list.txt.

The bug was detected via a patch series that turns the merge strategies
included in Git into built-in commands: `git merge -s help` relies on
`load_command_list()` to determine the list of available merge
strategies.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix the command list with SKIP_DASHED_BUILT_INS=YesPlease
    
    In a recent patch series
    [https://lore.kernel.org/git/20201005122646.27994-12-alban.gruin@gmail.com/#r]
    , the merge strategies were converted into built-ins, which is good.
    
    Together with the change where we stop hard-linking the built-in
    commands in CI builds, this broke t9902.199.
    
    The actual root cause is that git merge -s help relies on 
    load_command_list() to find all available Git commands, and that
    function expected to find the built-in commands to on the PATH.
    
    Changes since v1:
    
     * Clarified the prefix skipping.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-745%2Fdscho%2Falways-include-builtins-in-commands-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-745/dscho/always-include-builtins-in-commands-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/745

Range-diff vs v1:

 1:  74adb00d59 ! 1:  c36a97f436 help: do not expect built-in commands to be hardlinked
     @@ git.c: static void list_builtins(struct string_list *out, unsigned int exclude_o
      +	const char *name;
      +	int i;
      +
     ++	/*
     ++	 * Callers can ask for a subset of the commands based on a certain
     ++	 * prefix, which is then dropped from the added names. The names in
     ++	 * the `commands[]` array do not have the `git-` prefix, though,
     ++	 * therefore we must expect the `prefix` to at least start with `git-`.
     ++	 */
      +	if (!skip_prefix(prefix, "git-", &prefix))
     -+		return;
     ++		BUG("prefix '%s' must start with 'git-'", prefix);
      +
      +	for (i = 0; i < ARRAY_SIZE(commands); i++)
      +		if (skip_prefix(commands[i].cmd, prefix, &name))


 git.c  | 19 +++++++++++++++++++
 help.c |  2 ++
 help.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/git.c b/git.c
index d51fb5d2bf..48fc81b92f 100644
--- a/git.c
+++ b/git.c
@@ -641,6 +641,25 @@ static void list_builtins(struct string_list *out, unsigned int exclude_option)
 	}
 }
 
+void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
+{
+	const char *name;
+	int i;
+
+	/*
+	 * Callers can ask for a subset of the commands based on a certain
+	 * prefix, which is then dropped from the added names. The names in
+	 * the `commands[]` array do not have the `git-` prefix, though,
+	 * therefore we must expect the `prefix` to at least start with `git-`.
+	 */
+	if (!skip_prefix(prefix, "git-", &prefix))
+		BUG("prefix '%s' must start with 'git-'", prefix);
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		if (skip_prefix(commands[i].cmd, prefix, &name))
+			add_cmdname(cmds, name, strlen(name));
+}
+
 #ifdef STRIP_EXTENSION
 static void strip_extension(const char **argv)
 {
diff --git a/help.c b/help.c
index 4e2468a44d..919cbb9206 100644
--- a/help.c
+++ b/help.c
@@ -263,6 +263,8 @@ void load_command_list(const char *prefix,
 	const char *env_path = getenv("PATH");
 	const char *exec_path = git_exec_path();
 
+	load_builtin_commands(prefix, main_cmds);
+
 	if (exec_path) {
 		list_commands_in_dir(main_cmds, exec_path, prefix);
 		QSORT(main_cmds->names, main_cmds->cnt, cmdname_compare);
diff --git a/help.h b/help.h
index dc02458855..5871e93ba2 100644
--- a/help.h
+++ b/help.h
@@ -32,6 +32,7 @@ const char *help_unknown_cmd(const char *cmd);
 void load_command_list(const char *prefix,
 		       struct cmdnames *main_cmds,
 		       struct cmdnames *other_cmds);
+void load_builtin_commands(const char *prefix, struct cmdnames *cmds);
 void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);

base-commit: 8f7759d2c8c13716bfdb9ae602414fd987787e8d
-- 
gitgitgadget

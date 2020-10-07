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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5502CC4363D
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E180320789
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 12:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOs9VXv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgJGMnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgJGMnN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 08:43:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E300C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 05:43:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so1689315wrm.13
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ODBd41vwUrYguDDsT2Tb/KlxGsAhCQDRcrTG8VjdzDI=;
        b=DOs9VXv+BHboebsh8ZFtlaCHprLtIl4gcgp/YD8eDgRUEoFnV/TL9bUiWV9m/E7+k2
         Je2253nr+8GGul6JlnjNDdjkvWmxvRrXcmjyanNQPKk9jPT2OYPWMRPlcNIK2qAm/tun
         Jjvor/CmDmgjl1nU0XZ0u7Vg6dsw7foqYYdg5054UQO2LNSlMIn3ThDY9HI37F0VZ9yz
         W27d3r9YSyFZ2UzCkSbNlC/228Br3bXeKbr0mad1jbCF0Z9mC/UfDEqFvsmnE87xB3p0
         cuNnJsUewwQfw4MbKzu2K5XJ6THl0ukrM71PFjwzUWwBytCcbIQNREVI4FqExdZ4ffcS
         0oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ODBd41vwUrYguDDsT2Tb/KlxGsAhCQDRcrTG8VjdzDI=;
        b=FfU/DgSjZbq1Jst+6pn3SzbW1HYImVBHNdJnY28NDoBGv6+Q1vIyUvdZcdAhfHR8fn
         V3+5G0fMv9lsHx8fglYSX30I8O6lEa7pNhdMslff7YbenjF37pZ+8ObdiOc1Q01fluGg
         980ZsspXnbFuCyMymdBXenf/WEq08ZZFn8NBbOzvjekwlglfrsKnHj1vCs384TV1TLcO
         TiekEaObSsiX7rohbYoCRh4EZK3tD0TyO7M9d31qHHgzrd5wvZCGLvXkHBfLlAsj9EEV
         Z3XogwsQiORGRiaKwuk7AEgtpI5937stQFIm1+nqIE00s/+igr+wCSlQ84CnfIF3m4An
         HYQg==
X-Gm-Message-State: AOAM533q8wQRInGVDpZ1SDRgP8cGUxIzSTiXSViqlbdRT2MuLJKjqkLA
        OLyiHUWlO8FMZAKvSpbA1p/F18/3FYA=
X-Google-Smtp-Source: ABdhPJzGIFYzbSBOzZ5nL1J9GdBnQmscsNu4cBT8SjDn1Oj2JvjpSet5PG+mJntFImoH0TstoegNwA==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr3244163wrp.286.1602074591493;
        Wed, 07 Oct 2020 05:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q10sm2772323wrp.83.2020.10.07.05.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:43:10 -0700 (PDT)
Message-Id: <pull.745.git.1602074589460.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Oct 2020 12:43:09 +0000
Subject: [PATCH] help: do not expect built-in commands to be hardlinked
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
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
    function had the long-standing bug that it expects the built-in commands
    to be available in the PATH.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-745%2Fdscho%2Falways-include-builtins-in-commands-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-745/dscho/always-include-builtins-in-commands-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/745

 git.c  | 13 +++++++++++++
 help.c |  2 ++
 help.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/git.c b/git.c
index d51fb5d2bf..a6224badce 100644
--- a/git.c
+++ b/git.c
@@ -641,6 +641,19 @@ static void list_builtins(struct string_list *out, unsigned int exclude_option)
 	}
 }
 
+void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
+{
+	const char *name;
+	int i;
+
+	if (!skip_prefix(prefix, "git-", &prefix))
+		return;
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

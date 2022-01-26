Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D22CC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiAZLPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240574AbiAZLPc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 06:15:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF84C061748
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:15:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k18so25136447wrg.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=WZZgqP8vsOM0ZwCwqFtht9DnabIP0nvY1EHM0yKPqxo=;
        b=lbr6bkzkT2R03ffPtxqQALhnT6Wc/f7mR0z/Y0ZeIm0o2o/zFUtU4rVC3rur5FkbCZ
         QCQYcxgc21r6JNF2LhA1rO4Q0Y5Txc4VHFr8hDmFdS5GF/K6x9NV1dxhZMIx7fRFuQSR
         ZkYCNrfBn9f9DK4TjgjKOkmyPiOeYKu7DhGiJWQ/1mm4tdkLuKZ3u7ZIW72onshLE1/F
         NgqfQF3SLvbT1YfogVKh6UNZo76thfNQBwnHtnInJ0aeUbXkNxTIm/L08os1yBUqI71Q
         wVRrA0IYiDKcgerDnnfWqsUvIW0idaaG+yS5Ik6xIiBKOywHkhPIYnVEWsPtIklLaFFY
         fcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WZZgqP8vsOM0ZwCwqFtht9DnabIP0nvY1EHM0yKPqxo=;
        b=DQJcC8qZ/05rdUF+mjv+dVwDs9fzDbyW4PPF6Q5nkF8c+7p6c7TyMZO2QX4i4ZgcNE
         GYmC/U/zmTSN2vn6bMsZa/DOlvNUvltBemelOW7Leh75zqj43bL1hh7yWzHYeWWrk3Tp
         NheF+Hc0N68cL/bUP2Iuy42D977b7yB+z/17ko2AwzHif9jRgSaLgcfS7xQcPIs8L0EN
         4qliU4vQmXdXWOF7Wz7EXmbRWtAvcBpt4MWxowYa6iIprlpJnAFglsZZwk0lnx8w/ViZ
         4b0GRaQRZ3CwxaCisj0J5Yn2bXhP6Tcj34zwbeumXpOn1i1YyjBQqzSG3odcJ/0Anzzy
         kEjg==
X-Gm-Message-State: AOAM531eV3GKEyvmf5K/5/5Z3j3BhII+Gv0fbcqRFs/LJ4APLA7HtRw5
        EZ6+H8uz+jyCn+TDf3yBsWh7VMNz1mE=
X-Google-Smtp-Source: ABdhPJz0UJnK5b55PyumE8JV4hQNOvetCB26patM9ay25huykb0o8mHvB+4UH0rPjrvb7cqyyxHu0w==
X-Received: by 2002:adf:ce07:: with SMTP id p7mr22061026wrn.329.1643195730664;
        Wed, 26 Jan 2022 03:15:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg23sm3692488wmb.5.2022.01.26.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:15:30 -0800 (PST)
Message-Id: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 11:15:29 +0000
Subject: [PATCH] scalar: accept -C and -c options before the subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `git` executable has these two very useful options:

-C <directory>:
	switch to the specified directory before performing any actions

-c <key>=<value>:
	temporarily configure this setting for the duration of the
	specified scalar subcommand

With this commit, we teach the `scalar` executable the same trick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    scalar: accept -C and -c options
    
    This makes the scalar command a bit more handy by offering the same -c
    <key>=<value> and -C <directory> options as the git command.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1130%2Fdscho%2Fscalar-c-and-C-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1130/dscho/scalar-c-and-C-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1130

 contrib/scalar/scalar.c   | 22 +++++++++++++++++++++-
 contrib/scalar/scalar.txt | 10 ++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..7db2a97416e 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -808,6 +808,25 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf scalar_usage = STRBUF_INIT;
 	int i;
 
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "-C")) {
+			if (argc < 3)
+				die(_("-C requires a <directory>"));
+			if (chdir(argv[2]) < 0)
+				die_errno(_("could not change to '%s'"),
+					  argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else if (!strcmp(argv[1], "-c")) {
+			if (argc < 3)
+				die(_("-c requires a <key>=<value> argument"));
+			git_config_push_parameter(argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else
+			break;
+	}
+
 	if (argc > 1) {
 		argv++;
 		argc--;
@@ -818,7 +837,8 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	strbuf_addstr(&scalar_usage,
-		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+		      N_("scalar [-C <directory>] [-c <key>=<value>] "
+			 "<command> [<options>]\n\nCommands:\n"));
 	for (i = 0; builtins[i].name; i++)
 		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index f416d637289..cf4e5b889cc 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -36,6 +36,16 @@ The `scalar` command implements various subcommands, and different options
 depending on the subcommand. With the exception of `clone`, `list` and
 `reconfigure --all`, all subcommands expect to be run in an enlistment.
 
+The following options can be specified _before_ the subcommand:
+
+-C <directory>::
+	Before running the subcommand, change the working directory. This
+	option imitates the same option of linkgit:git[1].
+
+-c <key>=<value>::
+	For the duration of running the specified subcommand, configure this
+	setting. This option imitates the same option of linkgit:git[1].
+
 COMMANDS
 --------
 

base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
-- 
gitgitgadget

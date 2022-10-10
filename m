Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888C8C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJJQSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJJQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:18:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D3817E04
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:18:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h126-20020a1c2184000000b003c6bf423c71so499984wmh.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcZCWCsXreMmq7Q15BqRKQyZFiVgSR+O63eix0hY62k=;
        b=dBVq7GgOLvWvDco5lRHLQmypGclYqQ3e8KCMtFvtLGe7xvQBdxYES4kjlW/Cokq0/+
         IzOUWbw2HgulALLrYtbdiBKmAVc6igtY9jQOmWymrnBam7ZR4/i1PpI/4JpGkTxfuf7G
         fUQgkiV4JtCfuSf3B2ggGVJkc2HTM1PcMV8Ww0hPYP1CDWtOhVO3URDDkTl/lhofiv7/
         MlgXDaW+3aLLS5zppq+pPzRf7DF7T1yiHOV2tVw7qRyv/cGVJGu1Jb76/L2nd7z/H9VD
         hiSZx5tQNabMZU9rAtbb6X2pLRxAw4kBVY/7MhmxfeGx6qE/V03uUKf+XQLzAkkU9MNI
         iwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcZCWCsXreMmq7Q15BqRKQyZFiVgSR+O63eix0hY62k=;
        b=LM4zI29tWZsyJAUKZf4tLqYFAHj1Ju8G+2HjedDPbbVK4ASOHfN16leVjKA3HeAeLK
         DwPhBO9jfUQdVp2wXwnKP3q6y/nglv0DkSj6Ep9D0DbX0XdNMY7hZBYt8VEiEEGnSoSI
         d+TfOpcDj68hhVE1Ddy6TmqOhTGGp/F2SVspNKmiXO+e0mQ/r4B7jKuK1o6iVUBrI9l5
         xh0SGMQINyK4/SB7ornGH/rbMzzDsyjTToPNOJ8YIGCLkoYZ+ANp/AYLJx264dOPm5gD
         ZohlzttWuiwhoWr0TydJpuk2zH+zgtzqnFluyVujK+WeleE8B16dkrVivYTeEKv0HVjM
         FIjg==
X-Gm-Message-State: ACrzQf1EeS5i4b66pYubYaKi2Hlm49RKZ3wPl06FjVavCNBdAQxufkEB
        Brb4ABWiJWZJpkshjy6ZIST4LXIyI+s=
X-Google-Smtp-Source: AMsMyM4fbiV4+/tnO5ZAstXFBlhZhpIpNWPQUbS+qyGDC4MNJRLZEFaRb/nTIqMRQDtZzyy7TMoPIA==
X-Received: by 2002:a05:600c:1e88:b0:3c3:ecf:ce3e with SMTP id be8-20020a05600c1e8800b003c30ecfce3emr12056486wmb.15.1665418678582;
        Mon, 10 Oct 2022 09:17:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d49cf000000b0022dc6e76bbdsm9319668wrs.46.2022.10.10.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:17:58 -0700 (PDT)
Message-Id: <pull.1357.git.git.1665418677535.gitgitgadget@gmail.com>
From:   "Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:17:57 +0000
Subject: [PATCH] git.c: fix, stop passing options after --help
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Daniel Sonbolian <dsal3389@gmail.com>,
        Daniel Sonbolian <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Sonbolian <dsal3389@gmail.com>

Since commit c6b6d9f7d8a when passing --help option
to a Git command, we try to open that command man page, we
do it for both commands and concepts, it is done by
converting the entered command to a help command
for the given Git command, for example:

	"git commit --help -i" into "git help --exclude-guides commit -i"

But the options after --help option are also
passed to the new command (-i option from the example)
which can lead to unexpected output, because the
help command will try to execute those extra options.

This fixed by building the argv statically, meaning
instead of switching places between argv arguments and then
passing all the arguments to a new memory vector that will
later be used as the new argv, we directly passing that
memory vector only the required arguments and in the
correct order, after that we also updating the
argc to a static number:

	strvec_push(&args, "help");  // argv[0]
	strvec_push(&args, "--exclude-guides");  // argv[1]
	strvec_push(&args, argv[0]);  // argv[2]
	argv = args.v;
	argc = 3;  // update based on the amount of pushs we did

Now no matter how many arguments we pass after
the --help, the results will always stay the same:

	"git commit --help foo-hello-world"
	"git commit --help pull -i -f"
	"git commit --help -i"
	|
	v
	"git help --exclude-guides commit"

Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
---
    git.c: fix, passing options after --help
    
    Since commit c6b6d9f7d8a when passing --help option to a Git command, we
    try to open that command man page, we do it for both commands and
    concepts, it is done by converting the entered command to a help command
    for the given Git command, for example:
    
    "git commit --help -i" into "git help --exclude-guides commit -i"
    
    
    But the options after --help option are also passed to the new command
    (-i option from the example) which can lead to unexpected output,
    because the help command will try to execute those extra options.
    
    This fixed by building the argv statically, meaning instead of switching
    places between argv arguments and then passing all the arguments to a
    new memory vector that will later be used as the new argv, we directly
    passing that memory vector only the required arguments and in the
    correct order, after that we also updating the argc to a static number:
    
    strvec_push(&args, "help");  // argv[0]
    strvec_push(&args, "--exclude-guides");  // argv[1]
    strvec_push(&args, argv[0]);  // argv[2]
    argv = args.v;
    argc = 3;  // update based on the amount of pushs we did
    
    
    Now no matter how many arguments we pass after the --help, the results
    will always stay the same:
    
    "git commit --help foo-hello-world"
    "git commit --help pull -i -f"
    "git commit --help -i"
    |
    v
    "git help --exclude-guides commit"
    
    
    Signed-off-by: Daniel Sonbolian dsal3389@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1357%2Fdsal3389%2Fcmd-help-tweaks-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1357/dsal3389/cmd-help-tweaks-v1
Pull-Request: https://github.com/git/git/pull/1357

 git.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/git.c b/git.c
index da411c53822..75dcefa534d 100644
--- a/git.c
+++ b/git.c
@@ -697,25 +697,19 @@ static void handle_builtin(int argc, const char **argv)
 	struct cmd_struct *builtin;
 
 	strip_extension(argv);
-	cmd = argv[0];
 
 	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
 	if (argc > 1 && !strcmp(argv[1], "--help")) {
-		int i;
-
-		argv[1] = argv[0];
-		argv[0] = cmd = "help";
-
-		for (i = 0; i < argc; i++) {
-			strvec_push(&args, argv[i]);
-			if (!i)
-				strvec_push(&args, "--exclude-guides");
-		}
+		strvec_push(&args, "help");
+		strvec_push(&args, "--exclude-guides");
+		strvec_push(&args, argv[0]);
 
-		argc++;
 		argv = args.v;
+		argc = 3;
 	}
 
+	cmd = argv[0];
+
 	builtin = get_builtin(cmd);
 	if (builtin)
 		exit(run_builtin(builtin, argc, argv));

base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
-- 
gitgitgadget

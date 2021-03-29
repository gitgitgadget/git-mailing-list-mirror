Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8EDC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D133161585
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhC2Wet (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbhC2Wd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:33:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BAC061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 15:33:56 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 12so7336794wmf.5
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=5pl5S8h6zmMTH4z5C1g57tQ+dYe+dqzhS4o5gj70idc=;
        b=oEioaQu6db2PNzNdSkUKiCbZSESmoR9vHdzHYtcPw2VJlwEdu/iu/1Oh6z5soCAacl
         3WoXfX14NFdx7x398UbiQFC19jocDDIc9aPG3YBT19RA0v3hPFQXv2CaFxWDtdg35+Iq
         3i2LHM7QBW4ksPSmPosglP+k2XxAm41fISRrlBsRzbli5YQbL37ZO+OXxq4LIl9b76ll
         14miYJPO0SZkMbuMrmjtJrdUuMtUlk2Utn488QDRgQJGzdz89+o+0qqQyHj04G8ximGR
         E2Zxv4h+ArVad12AUHyoucl1PbMlOOV11mATvFyStHaWUBez8hx6v+qQVGF9dRzwkirC
         v7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5pl5S8h6zmMTH4z5C1g57tQ+dYe+dqzhS4o5gj70idc=;
        b=Ppq959dwOiUjtCQomVSKamV/f70MhtktZnJ04XK5Yk7gHx5gBzPc/kMr5IqGOgHydw
         0iNz/rZ/q7GOfYxZUvKG4a9v9aJWuljRVsVKC5xCZsBPE63IULL5K9th/Ebm07JCcrLZ
         i78rbj87i70jm15iooqv7ejVvgweS+2zsHiOm5CsbDUEMce/yQaKkr/iQ9MBYxuFjwUb
         tlEhtS4lx/DqB5isgxRkJB0wJDFZM8lu8osQGWZoRYJdk/ULeLxuu9GG7nl8WR9TbNd1
         VnF2OONFW73Hb6UPFLFchG5n3OmoFx+jcRRWVwjqZtT+1fHeU2qIV0lke/4XehqTRoVc
         KwDg==
X-Gm-Message-State: AOAM531Ld5TBkuMoheI5KaC6o5CTEm4WhezxAIArHRyhdGmelPc8WzGJ
        pbTffP9stmF9jOjosCGk/X3l+Sgeg/M=
X-Google-Smtp-Source: ABdhPJxFXLr45Lp5bXZr064EPFBhFYSBH+SDfhT9/j/383wLQvpmT29I6TMzqw44ePmm8Rb3E1fV1g==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr1048147wml.31.1617057234987;
        Mon, 29 Mar 2021 15:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j136sm836085wmj.35.2021.03.29.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 15:33:54 -0700 (PDT)
Message-Id: <pull.922.git.1617057233885.gitgitgadget@gmail.com>
From:   "Dmitry Torilov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 22:33:53 +0000
Subject: [PATCH] chore: use prefix from startup_info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Dmitry Torilov <d.torilov@gmail.com>,
        Dmitry Torilov <d.torilov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dmitry Torilov <d.torilov@gmail.com>

trace.h: update trace_repo_setup signature
trace.c: update trace_repo_setup implementation
git.c: update trace_repo_setup usage

Signed-off-by: Dmitry Torilov <d.torilov@gmail.com>
---
    [PATCH] trace: use prefix from startup_info
    
    trace.h: update trace_repo_setup signature trace.c: update
    trace_repo_setup implementation git.c: update trace_repo_setup usage
    
    I'm new to git, I want to try to make a test contribution.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-922%2Ftorilov%2Ftrace_repo_setup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-922/torilov/trace_repo_setup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/922

 git.c   | 3 ++-
 trace.c | 4 ++--
 trace.h | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 9bc077a025cb..310cf54e08f6 100644
--- a/git.c
+++ b/git.c
@@ -424,6 +424,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
 		prefix = precompose_argv_prefix(argc, argv, prefix);
+		startup_info->prefix = prefix;
 		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
@@ -432,7 +433,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
 		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
+			trace_repo_setup();
 	}
 	commit_pager_choice();
 
diff --git a/trace.c b/trace.c
index f726686fd92f..4c6414683414 100644
--- a/trace.c
+++ b/trace.c
@@ -367,9 +367,9 @@ static const char *quote_crnl(const char *path)
 	return new_path.buf;
 }
 
-/* FIXME: move prefix to startup_info struct and get rid of this arg */
-void trace_repo_setup(const char *prefix)
+void trace_repo_setup(void)
 {
+	const char *prefix = startup_info->prefix;
 	const char *git_work_tree;
 	char *cwd;
 
diff --git a/trace.h b/trace.h
index 0dbbad0e41cb..844b3ce47d2b 100644
--- a/trace.h
+++ b/trace.h
@@ -93,7 +93,7 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-void trace_repo_setup(const char *prefix);
+void trace_repo_setup(void);
 
 /**
  * Checks whether the trace key is enabled. Used to prevent expensive

base-commit: 84d06cdc06389ae7c462434cb7b1db0980f63860
-- 
gitgitgadget

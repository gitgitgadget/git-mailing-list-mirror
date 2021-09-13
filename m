Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6323DC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435F361027
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhIMDq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238423AbhIMDq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 23:46:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585BC061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:41 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso5853267wmb.2
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eY7hWSNSEDzM9zTx+6Te8+LTHa2wP+SVnhxSnSDFJc=;
        b=Wz3Av+WdpSYAxEpJXAhuvtTvwpp9qDpDR6c/zuwPPbmCWvlORrTh6cLs+LlnA4S8RT
         t2CvcL1Et1x4pdWW8xwyoXQoaPQkVkTjStDyjlQjE0T5rUDencq2bN4wcDG9UqV84JFM
         GjJ+M1BKbEU3AC/UvQIfw9FRvfy276kc+KdQ2pPhsqR6oV0efP4C/3eX9seQFl5Jh2jc
         1gGbFZZNyHDQ061BC13FfJO5nBdAKolVzZg58egmlzYCJLSvWQojUiqZeN60sZ6RrnKa
         mg6Mymg1JL3SliVQP/Vs43zW2UvXSQcyzq5fHXGwcN7Vjbsqm+ofaQ1LDXGhUHGM0OYK
         5YYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eY7hWSNSEDzM9zTx+6Te8+LTHa2wP+SVnhxSnSDFJc=;
        b=sKm9T9kfBRIWYposkDjU17VUyq7lUis9dYZGBcAnMqEknbC66iB1/57caisl1ZYakM
         Wbe+6AuRqu41teLAPKEA2qk3Nj9NTSQOiJxw1Nbw9Pc16qF8gpTVxKCfsOCDtPc88NJk
         FMgWbTyXxTVy0zn5rK9NRY+Rq5BLYcXXsOHe9VCuQky8ruP2eQPNyFXjArVGVVySZ873
         1sPrB0VsSTZ3o9fBcCrH320+Wv48AbLxLYNYdtmln6oiarwLksinSVd+xWyduF9dKf11
         PIcKrpOcI3AgORfh6wdCO8d++WcO4jzzb+e9hUHa9f67mxPrFVIhNsIl7vk43LmeDPQ5
         dJ+g==
X-Gm-Message-State: AOAM531GHDzj4YtltMotLjLirIKRxo/lnJTtB68gMmG4Hypj1MundgFx
        uUXRAicZ0l6r3AIPwqGqrsicVjwHZ1XXSg==
X-Google-Smtp-Source: ABdhPJzfIhb3mRC1Nf6ea8q8HowaCbojzMruk9KUY73N7qqaLPR72wtCqGXxcWlwFWJYJbfT1eHYXg==
X-Received: by 2002:a7b:c052:: with SMTP id u18mr9034900wmc.105.1631504740094;
        Sun, 12 Sep 2021 20:45:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm6631472wrc.16.2021.09.12.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:45:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] difftool: prepare "diff" cmdline in cmd_difftool()
Date:   Mon, 13 Sep 2021 05:35:38 +0200
Message-Id: <patch-v2-2.4-1c2794115c7-20210913T033204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.999.ga5f89b684e9
In-Reply-To: <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We call into either run_dir_diff() or run_file_diff(), each of which
sets up a child argv starting with "diff" and some hard-coded options
(depending on which mode we're using). Let's extract that logic into the
caller, which will make it easier to modify the options for cases which
affect both functions.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 9f08a8f3fd2..f8fcc67640f 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -331,7 +331,6 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 }
 
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
-			int argc, const char **argv,
 			struct child_process *child)
 {
 	char tmpdir[PATH_MAX];
@@ -393,10 +392,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	child->clean_on_exit = 1;
 	child->dir = prefix;
 	child->out = -1;
-	strvec_pushl(&child->args, "diff", "--raw", "--no-abbrev", "-z",
-		     NULL);
-	for (i = 0; i < argc; i++)
-		strvec_push(&child->args, argv[i]);
 	if (start_command(child))
 		die("could not obtain raw diff");
 	fp = xfdopen(child->out, "r");
@@ -683,7 +678,6 @@ static int run_file_diff(int prompt, const char *prefix,
 		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
 
 
-	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
 	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
@@ -769,7 +763,12 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	 * will invoke a separate instance of 'git-difftool--helper' for
 	 * each file that changed.
 	 */
+	strvec_push(&child.args, "diff");
+	if (dir_diff)
+		strvec_pushl(&child.args, "--raw", "--no-abbrev", "-z", NULL);
+	strvec_pushv(&child.args, argv);
+
 	if (dir_diff)
-		return run_dir_diff(extcmd, symlinks, prefix, argc, argv, &child);
-	return run_file_diff(prompt, prefix, argc, argv);
+		return run_dir_diff(extcmd, symlinks, prefix, &child);
+	return run_file_diff(prompt, prefix, child.args.nr, child.args.v);
 }
-- 
2.33.0.999.ga5f89b684e9


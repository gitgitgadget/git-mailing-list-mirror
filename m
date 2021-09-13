Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F9C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3368560F6D
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 03:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhIMDq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 23:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbhIMDq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 23:46:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF30C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m9so12367772wrb.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7dm3dW3T1dZXmNkSAf2F7eqEB3ZH1aj6jR+HCuIkobU=;
        b=ZokyLigoNsb//ZhfFw7JTI3vmszy4ddCAbgNe9g+iKWzSt0VVMJx6FqHPNsH/GtBhU
         fSBcc5mn4vSoYxQ/4GfMmesi7jfl9+VyWCPMuNyJGhcQQlZulA1AflOy59PiEWb9drJd
         5frHI3AUo3R1knXz9QhLfSJICeX38OMvrbulRTwvrSIvLPR6r0c4psDVs88uT6mCMJHh
         FF7hZLEWVkc/yD6lXCvp1KLSfN9Lekgso4tqOd8npkAimrhuwVprBaKb0NafVQ4kkVBX
         crSnRW3qjLvzS49KIEfM4ViMjrDXfkdcdg35smkzK7HFwViN4nkYm32lZ0bRUd8lrbyb
         ra9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7dm3dW3T1dZXmNkSAf2F7eqEB3ZH1aj6jR+HCuIkobU=;
        b=AU53wQgHneusadVX51yjHZ/XGVGDmDUkrtptUm1hA+VZPTrf/eQWXvhZudq+9zDF/R
         ExI66A5iTmWmJedRP+DMCvxHHJCMC/KB8rKRUxHkBsdwzxdSw5XYdFCHgWuy6qaPidjB
         Ws+vDo6/lWWLurwIYS2BfberXznUDKfsihy+7WvTHcf5e7pr7RGwmoDTnLOzHcBlLCHW
         cGcWYjqfLvMOu2OizSugoFHYzv2FduIEPCxzDwnMQucw+SUR/kVuWD5Dn7cfKxtCPyf/
         ULY2f/E/CTiKeFSPs1C6Szgj2Ed12PkN3TelUqLTzAtKPuvSSCPIi60y05WdELtGwFts
         Qj/w==
X-Gm-Message-State: AOAM531fs8uhi+nFIjDc6cnE9cmFNoOTgt7R0sF3m10bgdcJEoUppxDt
        1zjgZLuCPtqS/LWJ0APUOjAqKK2wr5zveg==
X-Google-Smtp-Source: ABdhPJy7PLob0UQnyxMjp469kbaIafCRBPRU8dRvXSASftrL21Iu+krzEDYN4TPtgWKc34qElVAb8A==
X-Received: by 2002:adf:d193:: with SMTP id v19mr10335956wrc.377.1631504739319;
        Sun, 12 Sep 2021 20:45:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o10sm6631472wrc.16.2021.09.12.20.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 20:45:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] difftool: prepare "struct child_process" in cmd_difftool()
Date:   Mon, 13 Sep 2021 05:35:37 +0200
Message-Id: <patch-v2-1.4-f57c6c9b069-20210913T033204Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.999.ga5f89b684e9
In-Reply-To: <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210913T033204Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the preparation of the "struct child_process" from run_dir_diff()
to its only caller, cmd_difftool(). This is in preparation for
migrating run_file_diff() to using the run_command() API directly, and
to move more of the shared setup of the two to cmd_difftool().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6a9242a8032..9f08a8f3fd2 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -331,7 +331,8 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 }
 
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
-			int argc, const char **argv)
+			int argc, const char **argv,
+			struct child_process *child)
 {
 	char tmpdir[PATH_MAX];
 	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
@@ -352,7 +353,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct index_state wtindex;
 	struct checkout lstate, rstate;
 	int rc, flags = RUN_GIT_CMD, err = 0;
-	struct child_process child = CHILD_PROCESS_INIT;
 	const char *helper_argv[] = { "difftool--helper", NULL, NULL, NULL };
 	struct hashmap wt_modified, tmp_modified;
 	int indices_loaded = 0;
@@ -387,19 +387,19 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	rdir_len = rdir.len;
 	wtdir_len = wtdir.len;
 
-	child.no_stdin = 1;
-	child.git_cmd = 1;
-	child.use_shell = 0;
-	child.clean_on_exit = 1;
-	child.dir = prefix;
-	child.out = -1;
-	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
+	child->no_stdin = 1;
+	child->git_cmd = 1;
+	child->use_shell = 0;
+	child->clean_on_exit = 1;
+	child->dir = prefix;
+	child->out = -1;
+	strvec_pushl(&child->args, "diff", "--raw", "--no-abbrev", "-z",
 		     NULL);
 	for (i = 0; i < argc; i++)
-		strvec_push(&child.args, argv[i]);
-	if (start_command(&child))
+		strvec_push(&child->args, argv[i]);
+	if (start_command(child))
 		die("could not obtain raw diff");
-	fp = xfdopen(child.out, "r");
+	fp = xfdopen(child->out, "r");
 
 	/* Build index info for left and right sides of the diff */
 	i = 0;
@@ -525,7 +525,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 
 	fclose(fp);
 	fp = NULL;
-	if (finish_command(&child)) {
+	if (finish_command(child)) {
 		ret = error("error occurred running diff --raw");
 		goto finish;
 	}
@@ -719,6 +719,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
 		OPT_END()
 	};
+	struct child_process child = CHILD_PROCESS_INIT;
 
 	git_config(difftool_config, NULL);
 	symlinks = has_symlinks;
@@ -769,6 +770,6 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	 * each file that changed.
 	 */
 	if (dir_diff)
-		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
+		return run_dir_diff(extcmd, symlinks, prefix, argc, argv, &child);
 	return run_file_diff(prompt, prefix, argc, argv);
 }
-- 
2.33.0.999.ga5f89b684e9


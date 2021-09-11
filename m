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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1943C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AAC6611BF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 18:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhIKSWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 14:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhIKSWa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 14:22:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354ABC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:21:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so1650086wru.6
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gLotw8gxvrFbZNQXfCl7YxiQs4PhvLsA0U9QKkVUr0=;
        b=oiaLtPCHnvNdw5x9KUIhQ1theuKMibd4iZEVARvvTOkEM4b7N699DM+pTZ5QLe2mdE
         58uG06r/Np/0YpsdPsegH3QzKCsB1jP/0cvyaci+r+7jd/z1vRELDt4qqMB4HC5+SHOu
         QkQmtVUj+nBkDW38xOVco6UwXtV8UmsWSkv9+lrPTnUr8o5HuDLPYXAa5hSn7OWfmqjY
         smj7TObLK5IOaAlIMK/l14qRdzkW11O/cIIH42hHDPa9dT4yCE/vgzItfoO+L76Mc2rQ
         cHT0STvEOmlLnA4ajvbsPk9A9aI/m5FVuGKX22GSV/aUSz5EK5lEeiEe2WhK0DvPxncv
         mHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gLotw8gxvrFbZNQXfCl7YxiQs4PhvLsA0U9QKkVUr0=;
        b=HPcAdAzoCtRi+GOnjCDHADspPWk94cH/aaH+K2v7APfjAmcohyV/mhQX7wmn9cMtfv
         IPFTmclZJrILcBGvoKP2ClAGZaARzQzAW57FhTquRoLrDlirtfLXYGyNgRl0c7xUN+GS
         ZM5XIhWSzD113geQtaMHM+V2WiyFGQ6rTv9crQy29j1BUnafjxxH6boP69+J+Et3TpNt
         HXCScmsdXvtIzyUYPGEbErbM8ONTrz3mngyJ3KqlxpnB6Dl/MKzbxZeoHo0ens8nhlqc
         6hePlNWvicpQWTnG4NED+AV2HXUVHU+VU/uq3en4ZtdTXboehe70YmOH8a7T7DPAHzWU
         sh3Q==
X-Gm-Message-State: AOAM532vZmgGYJy3NFJWmgc28OPz+nYS0ZNJrq1SDMvZLVZBjKKXH7n7
        HIwGSQYQuoNrB16GuGvJzl1E/07+QR/jDA==
X-Google-Smtp-Source: ABdhPJykHepdA7XEiCDs/i24/Cut6Qf7JAPd/SruWvuXNEtAkHzelWgNHmVf6aU1ql3hOrMDDPY3qg==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr4157881wrh.356.1631384475508;
        Sat, 11 Sep 2021 11:21:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l10sm2491959wrg.50.2021.09.11.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 11:21:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] difftool: use "struct strvec" API in run_{dir,file}_diff()
Date:   Sat, 11 Sep 2021 20:21:11 +0200
Message-Id: <patch-1.2-e7481eb0c0c-20210911T182009Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The underlying run_command() API can take either the "struct strvec
args", or a "const char **argv". Let's move to the former to use the
more "native" version of run_command() in both of these functions.

This change probably isn't worth in on its own, but sets us up to
simplify API use even more in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6a9242a8032..e656514bcac 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -331,7 +331,7 @@ static int checkout_path(unsigned mode, struct object_id *oid,
 }
 
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
-			int argc, const char **argv)
+			struct strvec *args)
 {
 	char tmpdir[PATH_MAX];
 	struct strbuf info = STRBUF_INIT, lpath = STRBUF_INIT;
@@ -393,10 +393,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	child.clean_on_exit = 1;
 	child.dir = prefix;
 	child.out = -1;
-	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
-		     NULL);
-	for (i = 0; i < argc; i++)
-		strvec_push(&child.args, argv[i]);
+	child.argv = args->v;
+
 	if (start_command(&child))
 		die("could not obtain raw diff");
 	fp = xfdopen(child.out, "r");
@@ -663,30 +661,30 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	strbuf_release(&rdir);
 	strbuf_release(&wtdir);
 	strbuf_release(&buf);
+	strvec_clear(args);
 
 	return ret;
 }
 
-static int run_file_diff(int prompt, const char *prefix,
-			 int argc, const char **argv)
+static int run_file_diff(int prompt, const char *prefix, struct strvec *args)
 {
-	struct strvec args = STRVEC_INIT;
-	const char *env[] = {
-		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
-		NULL
-	};
-	int i;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	int ret;
 
+	strvec_pushl(&cmd.env_array, "GIT_PAGER=",
+		     "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL);
 	if (prompt > 0)
-		env[2] = "GIT_DIFFTOOL_PROMPT=true";
+		strvec_push(&cmd.env_array, "GIT_DIFFTOOL_PROMPT=true");
 	else if (!prompt)
-		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
+		strvec_push(&cmd.env_array, "GIT_DIFFTOOL_NO_PROMPT=true");
 
+	cmd.git_cmd = 1;
+	cmd.dir = prefix;
+	cmd.argv = args->v;
 
-	strvec_push(&args, "diff");
-	for (i = 0; i < argc; i++)
-		strvec_push(&args, argv[i]);
-	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
+	ret = run_command(&cmd);
+	strvec_clear(args);
+	return ret;
 }
 
 int cmd_difftool(int argc, const char **argv, const char *prefix)
@@ -719,6 +717,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
 		OPT_END()
 	};
+	struct strvec args = STRVEC_INIT;
 
 	git_config(difftool_config, NULL);
 	symlinks = has_symlinks;
@@ -768,7 +767,12 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	 * will invoke a separate instance of 'git-difftool--helper' for
 	 * each file that changed.
 	 */
+	strvec_push(&args, "diff");
+	if (dir_diff)
+		strvec_pushl(&args, "--raw", "--no-abbrev", "-z", NULL);
+	strvec_pushv(&args, argv);
+
 	if (dir_diff)
-		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
-	return run_file_diff(prompt, prefix, argc, argv);
+		return run_dir_diff(extcmd, symlinks, prefix, &args);
+	return run_file_diff(prompt, prefix, &args);
 }
-- 
2.33.0.995.ga5ea46173a2


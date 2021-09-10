Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AA1C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58C761100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhIJLbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhIJLba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:31:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7918C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so1388284wra.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptltSDCTtcLfQ+U8xcSudHvONAbaGZzTt/hw9/KbJ+s=;
        b=XvIsl8SMIA0lnVx/Y8LPtm7nbK+SBGYaU0bpcTmdQ/zZZqgku4pcog/yWRn3FdLae3
         tR3H0OPca0KPSggxB28VVLUfAaAiNFWKCWgYnvkg4eMY+bz51LwFW8qdVQ7j+8Aw65dK
         IP1SAsYvhl2qGmgJPc18eTcUKpDii/mpT353S1b4Fz7b1rB16IUH6SzENz3qx02aCrqR
         qp1mXHx2OHX6YCP81kzLQdNOMcR0lIruEz241NxYXHdXGCEeBsRYnYKYrvTQj1ex9+9Z
         sulBtNNh756szAWCvi7BQWFdjVRhWmSbA4k1odcFNN1NwwKUkXdod/Dg17rRaCY9t94/
         tDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptltSDCTtcLfQ+U8xcSudHvONAbaGZzTt/hw9/KbJ+s=;
        b=F3UIPABF+ETv7JV+kJhDrLvt4xDPRmOS4ZRshXKbhrIyn1xdtYfKipX3Sqj8JLMD6q
         xlMBlG+EKu4vXcz0fSAoR7ARFcT7+RfP0hvk6qO6Opsmq2A/2x/JvZYlcjaXViVxzdjo
         re3UHgTRhGl5eAcVQxtgY6h2ZgYUusChmTmas/2+cJgI/iNM0/6+tFpScrPhnqnUlh0R
         afpRtEgmcAwSaFMAuxcV5FNpA6qCtw+bEJv8LqbZT2uW0ssPQKOz2ayig7G+g9qwKW6U
         17KA6w0Hnb1/6bLaB7MfMSlUB05mxqz3G08fhMLXS/vXh7Y/zrZEeB0X8yyA9ZxzrS4k
         7MeA==
X-Gm-Message-State: AOAM5331UOZsaQ930D9hW4RkF6lzD2hvraD5kil9CRloi7EbkgKcDj7m
        cc9kH9CXHkfh8d1SqnIG8gG+avnwlBrTjQ==
X-Google-Smtp-Source: ABdhPJx0RCldQvd4QAyejieectHMUzkgLQqYUac9xentRUQrh55ptNz95kjbr+UVc9LuCMLODKtgfg==
X-Received: by 2002:adf:906a:: with SMTP id h97mr903250wrh.220.1631273418062;
        Fri, 10 Sep 2021 04:30:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4103278wmp.1.2021.09.10.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:30:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] help: correct logic error in combining --all and --config
Date:   Fri, 10 Sep 2021 13:28:45 +0200
Message-Id: <patch-v2-4.5-32d73d5273c-20210910T112545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in the --config option that's been there ever since its
introduction in 3ac68a93fd2 (help: add --config to list all available
config, 2018-05-26). Die when --all and --config are combined,
combining them doesn't make sense.

The code for the --config option when combined with an earlier
refactoring done to support the --guide option in
65f98358c0c (builtin/help.c: add --guide option, 2013-04-02) would
cause us to take the "--all" branch early and ignore the --config
option.

Let's instead list these as incompatible, both in the synopsis and
help output, and enforce it in the code itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt |  1 +
 builtin/help.c             | 37 +++++++++++++++++++++++++++----------
 t/t0012-help.sh            |  7 ++++++-
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index cb8e3d4da9e..96d5f598b4b 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git help' [-a|--all [--[no-]verbose]]
 	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
 'git help' [-g|--guides]
+'git help' [-c|--config]
 
 DESCRIPTION
 -----------
diff --git a/builtin/help.c b/builtin/help.c
index 51b18c291d8..05ba2cbe380 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -62,6 +62,7 @@ static const char * const builtin_help_usage[] = {
 	N_("git help [-a|--all] [--[no-]verbose]]\n"
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
+	N_("git help [-c|--config]"),
 	NULL
 };
 
@@ -548,18 +549,34 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	enum help_format parsed_help_format;
 	const char *page;
+	int need_config = 0;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
+	/* Incompatible options */
+	if (show_all && show_config)
+		usage_msg_opt(_("--config and --all cannot be combined"),
+			      builtin_help_usage, builtin_help_options);
+
+	if (show_config && show_guides)
+		usage_msg_opt(_("--config and --guides cannot be combined"),
+			      builtin_help_usage, builtin_help_options);
+
 	/* Options that take no further arguments */
+	if (argc && show_config)
+		usage_msg_opt(_("--config cannot be combined with command or guide names"),
+			      builtin_help_usage, builtin_help_options);
 	if (argc && show_guides)
-		usage_msg_opt(_("--guides cannot be combined with other options"),
+		usage_msg_opt(_("--guides cannot be combined with command or guide names"),
 			      builtin_help_usage, builtin_help_options);
 
-	if (show_all) {
+	need_config = show_all || show_config;
+	if (need_config)
 		git_config(git_help_config, NULL);
+
+	if (show_all) {
 		if (verbose) {
 			setup_pager();
 			list_all_cmds_help();
@@ -570,6 +587,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		list_commands(colopts, &main_cmds, &other_cmds);
 	}
 
+	if (show_guides)
+		list_guides_help();
+
+	if (show_all || show_guides) {
+		printf("%s\n", _(git_more_info_string));
+		return 0;
+	}
+
 	if (show_config) {
 		int for_human = show_config == 1;
 
@@ -583,14 +608,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (show_guides)
-		list_guides_help();
-
-	if (show_all || show_guides) {
-		printf("%s\n", _(git_more_info_string));
-		return 0;
-	}
-
 	if (!argv[0]) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 595bf81f133..cbc9b64f79f 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -35,7 +35,12 @@ test_expect_success 'basic help commands' '
 '
 
 test_expect_success 'invalid usage' '
-	test_expect_code 129 git help -g git-add
+	test_expect_code 129 git help -g git-add &&
+	test_expect_code 129 git help -c git-add &&
+	test_expect_code 129 git help -g git-add &&
+
+	test_expect_code 129 git help -a -c &&
+	test_expect_code 129 git help -g -c
 '
 
 test_expect_success "works for commands and guides by default" '
-- 
2.33.0.873.g125ff7b9940


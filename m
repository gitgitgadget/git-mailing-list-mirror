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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8866361100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbhIHPZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352008AbhIHPZk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B73C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q26so3865885wrc.7
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6PlMg7VzgYa625bIaTA+7GKpto1SMiOt57OduwRSVs=;
        b=pQltzwgSkHcM8WlLNOggci0mQGnsAE2zE6Es/pBAy/GbfOHe9+wQxZdGoiC6fOticW
         V7Du8V07v6yNxJLeD7oxbPeiLrjhloWUBKlfxC66RZM021B5IkrWKAlArZyv2/34u4fX
         ufd0xZd5llf1eCm24JKixVuXO2YmOiGTqn/azhYtLEB62Je0cbH9KC2QzzAaw8X+0O+i
         a/DvUvdYcxwmYOV/njAvcFxL/8QzuSYvGm2SCcwSaz4TNBrqRvbvL+WO9bQcX7S5MaSf
         EmNeF+7sLbsEn/MacV7sKbxk3xspk59ifaEnJU+gubGOq3oSE6/D9O8QlTsIf/IrHHUT
         3m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6PlMg7VzgYa625bIaTA+7GKpto1SMiOt57OduwRSVs=;
        b=5S3cpsc7npzEVvtj2oIgMpcNLCGzxrBfNRmY6h/qxP78NS+9MTNJwvjmvVELDMRahh
         sM2idJbZF5lFCG4dBF9n32w4q5GWgjUg5GgfG0LLLq3FulsKl3LmaVQRi8MFzEK2Yxwq
         FOUWs24yhVtStfURTkUFDA41IIQRa00UkYOrgvLMhSWZp6eaeNfg+AvIUTcPbh/euDYx
         cWq0tNFZRAC9OLElznmV1Z+0AQnGn/738xxw/3lZhh72Q5nwfF1Ytd/DMhIEorS0w48i
         VATiS37FWZyO2Rj5t+4KE2xdRDLcxM/pmfspGXcOyizMWMPlyGRKa/pvslt47+WGTd+A
         +N+A==
X-Gm-Message-State: AOAM532WdzZ3m2heTnVmt0KJUBhwMd0ENt/ihtJMiN9Z+Q+EUsNRY0Up
        ztCxztjPMD7Ex+T/GvvIrGYlGI/y+8XVTg==
X-Google-Smtp-Source: ABdhPJyM1EAanUUAlBYIAsYojaLAAGuLuaFc+s0Tp1n16lFps5UAzCTF1Hm6jGuESudvRiDt7mmLug==
X-Received: by 2002:adf:eb81:: with SMTP id t1mr2828948wrn.245.1631114670772;
        Wed, 08 Sep 2021 08:24:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] help: correct logic error in combining --all and --config
Date:   Wed,  8 Sep 2021 17:24:21 +0200
Message-Id: <patch-5.6-bcc640d32a1-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
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
 builtin/help.c             | 27 ++++++++++++++++++---------
 t/t0012-help.sh            |  5 ++++-
 3 files changed, 23 insertions(+), 10 deletions(-)

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
index 0737b22069b..83f71d6765e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -62,6 +62,7 @@ static const char * const builtin_help_usage[] = {
 	N_("git help [-a|--all] [--[no-]verbose]]\n"
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
+	N_("git help [-c|--config]"),
 	NULL
 };
 
@@ -549,18 +550,26 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	enum help_format parsed_help_format;
 	const char *page;
 	int standalone = 0;
+	int need_config = 0;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
+	/* Incompatible options */
+	if (show_all + !!show_config + show_guides > 1)
+		usage_with_options(builtin_help_usage, builtin_help_options);
+
 	/* Options that take no further arguments */
 	standalone = show_config || show_guides;
 	if (standalone && argc)
 		usage_with_options(builtin_help_usage, builtin_help_options);
 
-	if (show_all) {
+	need_config = show_all || show_config;
+	if (need_config)
 		git_config(git_help_config, NULL);
+
+	if (show_all) {
 		if (verbose) {
 			setup_pager();
 			list_all_cmds_help();
@@ -571,6 +580,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
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
 
@@ -583,14 +600,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (show_guides)
-		list_guides_help();
-
-	if (show_all || standalone) {
-		printf("%s\n", _(git_more_info_string));
-		return 0;
-	}
-
 	if (!argv[0]) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 94d1f481c8b..68e7f57470e 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -36,7 +36,10 @@ test_expect_success 'basic help commands' '
 
 test_expect_success 'invalid usage' '
 	test_expect_code 129 git help -c git-add &&
-	test_expect_code 129 git help -g git-add
+	test_expect_code 129 git help -g git-add &&
+
+	test_expect_code 129 git help -a -c &&
+	test_expect_code 129 git help -g -c
 '
 
 test_expect_success "works for commands and guides by default" '
-- 
2.33.0.825.g2bf60429931


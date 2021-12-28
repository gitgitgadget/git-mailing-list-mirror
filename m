Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF66C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhL1Pg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhL1PgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C40C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so2348410wrg.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lF2V3y1ce2j1p4g0q/n35h27E4TdO+XscDSy3phloXM=;
        b=nUNHKajk9o3UbKzA4wjWhlXvp0Y15KUzImCaE4INNsfNL7pB43GZLODV9DZQxZXU3y
         B17QYS7R3AOG4WPjw/tHqMyAQDUYs5FNW/Ipg46zCll4PUFW4Cgh4yMzfv29uepIFYOD
         WDY9+piASVPnUqHXNpyRzQWueONq65P07edWZYAaer1bQMi5teQ7S52ih8Y1afLE1VN5
         3rFJvXKuoyl9HfsIpEWNVq4LWQVK/i/0Ctm65rfW4NXNRBa0dY4rjnunGim3AZkNp0Nq
         yE4fqdf476watfZu1aGTSFCM6bAL52JRtbKBVhXFkezy8yJ6PJjLMz35T3Pw+dAlRUm9
         GZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lF2V3y1ce2j1p4g0q/n35h27E4TdO+XscDSy3phloXM=;
        b=ImHiys9WaS+R15pRUHiSBvChBdBp21GV4zPY7a983o7niC+6P+i//v0UGeheN+J9d+
         Ds1lJd50wE1l22uIbWcULGUFEPceqISLhv5+y3KptXQkfqG8xObktwjZ5//QVb5QUbSo
         jyCiHuJRySd6qeav8KP/vFtF98LkbHobpx4cZj1B5/cxH+UXeSYzvOOZOrN99KFaTAO/
         qJIP8Toey6Lr1YloStQXex9jch6nQzB8c1vX+xqMNknnm7dIms8KkE4lrd9HYYRnF3fd
         3ZosE0+DEld+7eBE88QWnV8q22kX6tDavcLc4YqALb5f95uqzRaOz05Zsw9vUOCsmVeq
         1YMg==
X-Gm-Message-State: AOAM530c3eUCTKfV6Q01M3a1o6mPz+vZkN7Fyqa7saxGPHbB6JT6ytt9
        Pe1YTD0WLSG4/qIT4/zdpC/cEgBmxkMcx0jZ
X-Google-Smtp-Source: ABdhPJxXf6LVsjHmVU/ylnrX6KoMXDFSzJk6gnh39dQFQuF4To9SyvkDcQE2DENFtdUNb9wRBA6H3g==
X-Received: by 2002:a5d:6d8e:: with SMTP id l14mr16839109wrs.507.1640705783057;
        Tue, 28 Dec 2021 07:36:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/7] help: error if [-a|-g|-c] and [-i|-m|-w] are combined
Date:   Tue, 28 Dec 2021 16:35:10 +0100
Message-Id: <patch-5.7-12ff152bd57-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more sanity checking to "git help" usage by erroring out if these
man viewer options are combined with incompatible command-modes that
will never use these documentation viewers.

This continues the work started in d35d03cf93e (help: simplify by
moving to OPT_CMDMODE(), 2021-09-22) of adding more sanity checking to
"git help". Doing this allows us to clarify the "SYNOPSIS" in the
documentation, and the "git help -h" output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt |  2 +-
 builtin/help.c             | 20 ++++++++++++++++++--
 t/t0012-help.sh            | 10 ++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index cf1d53e9499..61d52d30f6c 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all] [--[no-]verbose]
-	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
+'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
 
diff --git a/builtin/help.c b/builtin/help.c
index d387131dd83..125f50f1bb0 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -75,8 +75,8 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [-a|--all] [--[no-]verbose]]\n"
-	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
+	N_("git help [-a|--all] [--[no-]verbose]]"),
+	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
 	NULL
@@ -581,6 +581,13 @@ static void no_extra_argc(int argc)
 			      builtin_help_usage, builtin_help_options);
 }
 
+static void no_format(void)
+{
+	if (help_format != HELP_FORMAT_NONE)
+		usage_msg_opt(_("[-a|--all] cannot be combined with [[-i|--info] [-m|--man] [-w|--web]]"),
+			      builtin_help_usage, builtin_help_options);
+}
+
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
@@ -593,6 +600,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	switch (cmd_mode) {
 	case HELP_ACTION_ALL:
+		no_format();
 		if (verbose) {
 			setup_pager();
 			list_all_cmds_help();
@@ -605,19 +613,27 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		break;
 	case HELP_ACTION_GUIDES:
 		no_extra_argc(argc);
+		no_format();
+
 		list_guides_help();
 		printf("%s\n", _(git_more_info_string));
 		return 0;
 	case HELP_ACTION_CONFIG_FOR_COMPLETION:
 		no_extra_argc(argc);
+		no_format();
+
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		no_extra_argc(argc);
+		no_format();
+
 		list_config_help(SHOW_CONFIG_SECTIONS);
 		return 0;
 	case HELP_ACTION_CONFIG:
 		no_extra_argc(argc);
+		no_format();
+
 		setup_pager();
 		list_config_help(SHOW_CONFIG_HUMAN);
 		printf("\n%s\n", _("'git help config' for more information"));
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 6ac293c19ed..a8c603abd44 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -46,6 +46,16 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help --config-sections-for-completion add
 '
 
+for opt in '-a' '-g' '-c' '--config-for-completion' '--config-sections-for-completion'
+do
+	test_expect_success "invalid usage of '$opt' with [-i|-m|-w]" '
+		git help $opt &&
+		test_expect_code 129 git help $opt -i &&
+		test_expect_code 129 git help $opt -m &&
+		test_expect_code 129 git help $opt -w
+	'
+done
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.34.1.1257.g2af47340c7b


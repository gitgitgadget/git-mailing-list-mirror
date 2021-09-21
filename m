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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F4C4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D060161050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhIUWm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhIUWmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17433C061575
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so1175781wrq.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6gSCAofFwqEn3MwV0bA+1+330h16rCZX8cQ3IZFGgw=;
        b=Io4JaMmWLF3tp5OgFqKE62+KycWxBP0YYRkhiNSfqx2PcCOtWmz/o4qdh9ZWJc077x
         4V9Xdeo8jTniH5F7W0/NeA73t6m6V7DGtuZbz/w1mjo54xah9qLenf+su6dzpQRct97F
         t+vvFAJ5YGoUG7ux5nt7wBr4QhjKoIhXvYjuiEiBLigewW1GvN39oQX+Lo2W36MPM3GB
         57GkIBm/K/w58qxNtigfEHvgzGmhOt89nnKDkCHQKYymx6ckH7DksHe/X7nCof6TH5B4
         Ly0CJsQoV4C2G/JOnKlL224qgd9n9nnURAsd6SRurwEI/njc7mgLsPvuwkFCHWg9vp47
         /9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6gSCAofFwqEn3MwV0bA+1+330h16rCZX8cQ3IZFGgw=;
        b=B3gndyHfxaEOOSsh6i9JkiSxp13NSdbGQ/GDKk2hIbWuiA2w7m0jwhMSHxP5ZOHAAp
         VYcLPcqLXUQ4OPxtssxdshQ+PD0MeoZUr3DWjEuaOh75+2Rsl1sbvfMvA3xPFEcZde+p
         n3/QmudVxUng0D5I64dnxoinrINNVNJOKVLKvA2/ajHRigJQAspntYW75AjijoBQ/QOC
         DEog8NXMe9wWMEmOQp/UR3h5Yzv+/qcFjAEz07IrXG1lX76AmBb8TcauzXkx4FcclirR
         EOy6/Mt1ikA25Pm2RADPTM/A8SS2gg1Cd71U27i7WICis4gSRTwXHegXzQfaX6KkqtPX
         GvLQ==
X-Gm-Message-State: AOAM5309hg5nJ255Uzrx6huEQwaXSm+TuEMHLytdPygLbiWtRg3FpWk1
        cFE1juhqZEhd+EgwxraX6xlN5XpSOzwh0g==
X-Google-Smtp-Source: ABdhPJwJ+qmCbWUaLbqC7XeQI0NnJ97pLOFZPyN7pSiGdQbglbdOqy/Prr2SwjSLEb4GMut35y2IZw==
X-Received: by 2002:a05:600c:1553:: with SMTP id f19mr7106547wmg.66.1632264054284;
        Tue, 21 Sep 2021 15:40:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:53 -0700 (PDT)
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
Subject: [PATCH v3 9/9] help: move column config discovery to help.c library
Date:   Wed, 22 Sep 2021 00:40:39 +0200
Message-Id: <patch-v3-9.9-29ee7cf375b-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a git_config() call was added in dbfae689690 (help: reuse
print_columns() for help -a, 2012-04-13) to read the column config
we'd always use the resulting "colopts" variable.

Then in 63eae83f8f3 (help: add "-a --verbose" to list all commands
with synopsis, 2018-05-20) we started only using the "colopts" config
under "--all" if "--no-verbose" was also given, but the "git_config()"
call was not moved inside the "verbose" branch of the code.

This change effectively does that, we'll only call list_commands()
under "--all --no-verbose", so let's have it look up the config it
needs. See 26c7d067832 (help -a: improve and make --verbose default, 2018-09-29) for another case in help.c where we look up config.

The get_colopts() function is named for consistency with the existing
get_alias() function added in 26c7d067832.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c |  7 +------
 help.c         | 16 ++++++++++++++--
 help.h         |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 9a255a9aee6..0a40d8cf094 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -7,7 +7,6 @@
 #include "exec-cmd.h"
 #include "parse-options.h"
 #include "run-command.h"
-#include "column.h"
 #include "config-list.h"
 #include "help.h"
 #include "alias.h"
@@ -50,7 +49,6 @@ static enum help_action {
 
 static const char *html_path;
 static int verbose = 1;
-static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
 static struct option builtin_help_options[] = {
@@ -384,8 +382,6 @@ static int add_man_viewer_info(const char *var, const char *value)
 
 static int git_help_config(const char *var, const char *value, void *cb)
 {
-	if (starts_with(var, "column."))
-		return git_column_config(var, value, "help", &colopts);
 	if (!strcmp(var, "help.format")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -595,7 +591,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	switch (cmd_mode) {
 	case HELP_ACTION_ALL:
-		git_config(git_help_config, NULL);
 		if (verbose) {
 			setup_pager();
 			list_all_cmds_help();
@@ -603,7 +598,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		}
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		load_command_list("git-", &main_cmds, &other_cmds);
-		list_commands(colopts, &main_cmds, &other_cmds);
+		list_commands(&main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
 		break;
 	case HELP_ACTION_GUIDES:
diff --git a/help.c b/help.c
index be2fa642415..973e47cdc30 100644
--- a/help.c
+++ b/help.c
@@ -293,9 +293,21 @@ void load_command_list(const char *prefix,
 	exclude_cmds(other_cmds, main_cmds);
 }
 
-void list_commands(unsigned int colopts,
-		   struct cmdnames *main_cmds, struct cmdnames *other_cmds)
+static int get_colopts(const char *var, const char *value, void *data)
 {
+	unsigned int *colopts = data;
+
+	if (starts_with(var, "column."))
+		return git_column_config(var, value, "help", colopts);
+
+	return 0;
+}
+
+void list_commands(struct cmdnames *main_cmds, struct cmdnames *other_cmds)
+{
+	unsigned int colopts = 0;
+	git_config(get_colopts, &colopts);
+
 	if (main_cmds->cnt) {
 		const char *exec_path = git_exec_path();
 		printf_ln(_("available git commands in '%s'"), exec_path);
diff --git a/help.h b/help.h
index 5871e93ba2d..9d383f1a0b2 100644
--- a/help.h
+++ b/help.h
@@ -37,7 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
 int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+void list_commands(struct cmdnames *main_cmds, struct cmdnames *other_cmds);
 void get_version_info(struct strbuf *buf, int show_build_options);
 
 /*
-- 
2.33.0.1098.gf02a64c1a2d


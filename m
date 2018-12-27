Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830F1211BC
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeL0P4a (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41078 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeL0P43 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so12939323lfj.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gLdF5h7tDbN4ZmeD3YbmvkF14vugxwX36anj2TBgPs=;
        b=AFo5r+492hGm5+wii5e7/PK22LmyuxCM58EBfckBTck4BiWizI9bRrKFtZcmpuZdTp
         0QK3tC0gtiZ2GNfbiJmw+hVvDGnlpkTomaaf7Yw9FLqDm28jnTeX97lDiBXXlXuJD9rK
         0OV2nJLgSHJcOltY3Am/OdWtJDzFJsOQ2wg7QW4fclK924y607PsnkWNePeJoOEhSna1
         9W657lYLbmc50AW2m8VCpXpy3Mqp24dLpZRhOU+RSBt5p2PIVuzmIRYWetGScOl0fiDr
         l5TcQunr0iH90krGQI+rbhWkmhG3JOuZt7QQ+NF8K1sjLCWClWLHqjzYXf8bdbm1vbcN
         7dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gLdF5h7tDbN4ZmeD3YbmvkF14vugxwX36anj2TBgPs=;
        b=frKEgBVFB7K4cgMetbvqKHJeORFDFvJRrMd6WTW1u4oVw6/BJHrprdxX/jMqBBT188
         UAQ6rhG8sqhVclne0NxFJAYm5ASvwSq33h1B1vZpd0GjeIWN+pLpreC3sfQUuXWdpxLp
         YNnaTdcqjhnslcAAhHg7Prze/V+un09k0FpUzS0ctx9GDEvFvdD2dU8GlhO1Tep3n3UL
         gGgp+vHhcJ4SPVC50gyAomezoyJkzVbVf2GcBMjxALjDJuBO5rKP5jPtzZkIh7dY/fv6
         YYy8P/ckmqhZTFLTHfDWLOZFqCNS9ehWd2lec5oDbOfiyZOe3jL+7BidkQ1iJWQAbNrt
         /cvQ==
X-Gm-Message-State: AA+aEWaPooREoBRkNUkg1i0glEW5E28EixpFXN3IHUPJDsdr2NWzyW3d
        WZ9lIc6O/wz+uqITWwiGWgnHs52a
X-Google-Smtp-Source: AFSGD/UF1y8w/vMHBZwQlIVjpBc9CAJw6LHQj82B3ey0KCtrCDKrGl8RAKsraHQdOm553YJS4r/d1A==
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr11866518lfd.74.1545926186711;
        Thu, 27 Dec 2018 07:56:26 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:25 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/6] config: factor out set_config_source_file()
Date:   Thu, 27 Dec 2018 16:56:10 +0100
Message-Id: <20181227155611.10585-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227155611.10585-1-pclouds@gmail.com>
References: <20181227155611.10585-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch, "config" is taught to move some config variables
from one file to another. We need to specify two locations, source and
destination, and the plan is reusing the same --global/--local/...
option. Factor this code out for reuse later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c | 113 +++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 54 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c22d25de12..61a6a5a0e1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -71,6 +71,64 @@ static int show_origin;
 
 static NORETURN void usage_builtin_config(void);
 
+static void set_config_source_file(void)
+{
+	int nongit = !startup_info->have_repository;
+
+	if (use_global_config + use_system_config + use_local_config +
+	    use_worktree_config +
+	    !!given_config_source.file + !!given_config_source.blob > 1)
+		die(_("only one config file at a time"));
+
+	if (use_local_config && nongit)
+		die(_("--local can only be used inside a git repository"));
+
+	if (given_config_source.blob && nongit)
+		die(_("--blob can only be used inside a git repository"));
+
+	if (given_config_source.file &&
+			!strcmp(given_config_source.file, "-")) {
+		given_config_source.file = NULL;
+		given_config_source.use_stdin = 1;
+	}
+
+	if (use_global_config) {
+		char *user_config = expand_user_path("~/.gitconfig", 0);
+		char *xdg_config = xdg_config_home("config");
+
+		if (!user_config)
+			/*
+			 * It is unknown if HOME/.gitconfig exists, so
+			 * we do not know if we should write to XDG
+			 * location; error out even if XDG_CONFIG_HOME
+			 * is set and points at a sane location.
+			 */
+			die(_("$HOME not set"));
+
+		if (access_or_warn(user_config, R_OK, 0) &&
+		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
+			given_config_source.file = xdg_config;
+			free(user_config);
+		} else {
+			given_config_source.file = user_config;
+			free(xdg_config);
+		}
+	}
+	else if (use_system_config)
+		given_config_source.file = git_etc_gitconfig();
+	else if (use_local_config)
+		given_config_source.file = git_pathdup("config");
+	else if (use_worktree_config) {
+		given_config_source.file = get_worktree_config(the_repository);
+		if (!given_config_source.file)
+			die(_("--worktree cannot be used with multiple "
+			      "working trees unless the config\n"
+			      "extension worktreeConfig is enabled. "
+			      "Please read \"CONFIGURATION FILE\"\n"
+			      "section in \"git help worktree\" for details"));
+	}
+}
+
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
@@ -604,60 +662,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (use_global_config + use_system_config + use_local_config +
-	    use_worktree_config +
-	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error(_("only one config file at a time"));
-		usage_builtin_config();
-	}
-
-	if (use_local_config && nongit)
-		die(_("--local can only be used inside a git repository"));
-
-	if (given_config_source.blob && nongit)
-		die(_("--blob can only be used inside a git repository"));
-
-	if (given_config_source.file &&
-			!strcmp(given_config_source.file, "-")) {
-		given_config_source.file = NULL;
-		given_config_source.use_stdin = 1;
-	}
-
-	if (use_global_config) {
-		char *user_config = expand_user_path("~/.gitconfig", 0);
-		char *xdg_config = xdg_config_home("config");
-
-		if (!user_config)
-			/*
-			 * It is unknown if HOME/.gitconfig exists, so
-			 * we do not know if we should write to XDG
-			 * location; error out even if XDG_CONFIG_HOME
-			 * is set and points at a sane location.
-			 */
-			die(_("$HOME not set"));
-
-		if (access_or_warn(user_config, R_OK, 0) &&
-		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
-			given_config_source.file = xdg_config;
-			free(user_config);
-		} else {
-			given_config_source.file = user_config;
-			free(xdg_config);
-		}
-	}
-	else if (use_system_config)
-		given_config_source.file = git_etc_gitconfig();
-	else if (use_local_config)
-		given_config_source.file = git_pathdup("config");
-	else if (use_worktree_config) {
-		given_config_source.file = get_worktree_config(the_repository);
-		if (!given_config_source.file)
-			die(_("--worktree cannot be used with multiple "
-			      "working trees unless the config\n"
-			      "extension worktreeConfig is enabled. "
-			      "Please read \"CONFIGURATION FILE\"\n"
-			      "section in \"git help worktree\" for details"));
-	}
+	set_config_source_file();
 
 	if (respect_includes_opt == -1)
 		config_options.respect_includes = !given_config_source.file;
-- 
2.20.0.482.g66447595a7


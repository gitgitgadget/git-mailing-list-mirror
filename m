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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1171C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCBD6113C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbhERNWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhERNWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:22:19 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A62C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:21:02 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g7-20020a9d12870000b0290328b1342b73so742860otg.9
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYsVnmt9H+4tgE4S6sUaN0SHVKIx4P4qubHbXIlAj+8=;
        b=pqCQnucZ3OywLJ3nJKdkiRq5Kk+1Bmra1OEyoRjWHa+QsxB3vlPSfZOw2KaAZbgmGm
         wLwBlNZmlnHEOvwbrwau6EANwXfaVEcI+PPqWU3dOPndWsWag6wM2uXVVnfqT24NUqk1
         APvkDgVIneUtCaPO6sTKAJrToML77LasQKDui5/hT7ZO2N8EPtEXcl3xUz/pQkUa/ez3
         qzD/VFxWHWLuxqfHsMEAWHHLH9ig2qgARDpWPrZsLIEA1en343xSnSnErZZJApVA63ZV
         Y+N4piYuIlhL4VC4kgm2lFVq/Qf4MxivMQLkc4YvabjAL+LgmCOGG0pauwtrYUfbq5+9
         KJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iYsVnmt9H+4tgE4S6sUaN0SHVKIx4P4qubHbXIlAj+8=;
        b=tSHJ2bmfgSUD+6iFTDRhU+KxtxMbGhS8CEbgjUMRLdueFazRBYXshQbiKbIYDlDhDJ
         Mk05iaV+dByzSmhVsQ7zOJlptAba2mRv6SBpufmbZC9iSd/nx4V1cEOwmMZVA2FFk50d
         AHwmBV2aFBmu1D3dK2jI2605p2XXrecMvZJALuuonAv0BqyWeClTz01q7qCsCoN/ZwYD
         fzQNfs4Xf1NtgjLBYf/HuOuPlsS0CS8GaEQsEXY9k/uxmHHOk3Ut1jk7wZscoLPXz/G0
         YwZajlE9CC+QyS39DZO3WnrT9JLVbSmTpxAYKkSzlPBOf0Wh3xSqhBgICWidOCw+A9Hy
         O1eQ==
X-Gm-Message-State: AOAM533NFvn+bKtlOm2QYj7+7sUh69+ayak9um68yv3YV73jf0zWKiRF
        UMmRbsa4VvQGbV54D7sE663dhmzd8HoKGw==
X-Google-Smtp-Source: ABdhPJzG0yDL2CUVgWMib7fnSbnN90Dpku/gs1SkNoFzVop+/hcV6XW3qktwS9qz21OXdrp/sl2ojA==
X-Received: by 2002:a9d:5a4:: with SMTP id 33mr4268645otd.328.1621344061067;
        Tue, 18 May 2021 06:21:01 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id a23sm3853191otf.47.2021.05.18.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 06:21:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] help: colorize man pages
Date:   Tue, 18 May 2021 08:20:56 -0500
Message-Id: <20210518132056.2003135-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our man pages don't contain many useful colors (just blue links),
moreover, many people have groff SGR disabled, so they don't see any
colors with man pages.

We can set LESS_TERMCAP variables to render bold and underlined text
with colors in the pager; a common trick[1].

Bold is rendered as red, underlined as blue, and standout (messages and
highlighted search) as inverse magenta.

This only works when the pager is less.

If the user already has LESS_TERMCAP variables set in his/her
environment, those are respected and not overwritten.

A new color configuration is added: `color.man`, otherwise `color.ui` is
respected, and in addition color.pager needs to turned on.

Normally check_auto_color() would check the value of `color.pager`, but
in this particular case it's not git the one executing the pager, but
man. Therefore we need to check pager_use_color ourselves.

[1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
Range-diff against v1:
1:  a943dedab8 ! 1:  9e34a49fa9 help: colorize man pages
    @@ Commit message
         Bold is rendered as red, underlined as blue, and standout (messages and
         highlighted search) as inverse magenta.
     
    -    This only works when the pager is less, and the color.pager
    -    configuration is enabled, as well as color.ui.
    +    This only works when the pager is less.
    +
    +    If the user already has LESS_TERMCAP variables set in his/her
    +    environment, those are respected and not overwritten.
    +
    +    A new color configuration is added: `color.man`, otherwise `color.ui` is
    +    respected, and in addition color.pager needs to turned on.
    +
    +    Normally check_auto_color() would check the value of `color.pager`, but
    +    in this particular case it's not git the one executing the pager, but
    +    man. Therefore we need to check pager_use_color ourselves.
     
         [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
     
    +    Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Comments-by: Jeff King <peff@peff.net>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
    + ## Documentation/config/color.txt ##
    +@@ Documentation/config/color.txt: color.interactive.<slot>::
    + 	or `error`, for four distinct types of normal output from
    + 	interactive commands.
    + 
    ++color.man::
    ++	When set to `always`, always colorize the man pages. When `false`
    ++	(or `never`), never.  When set to `true` or `auto`, use color only
    ++	when the output is written to the terminal. If unset, then the
    ++	value of `color.ui` is used (`auto` by default).
    ++
    + color.pager::
    + 	A boolean to enable/disable colored output when the pager is in
    + 	use (default is true).
    +
      ## builtin/help.c ##
     @@
      #include "config-list.h"
    @@ builtin/help.c
      
      #ifndef DEFAULT_HELP_FORMAT
      #define DEFAULT_HELP_FORMAT "man"
    +@@ builtin/help.c: static int verbose = 1;
    + static unsigned int colopts;
    + static enum help_format help_format = HELP_FORMAT_NONE;
    + static int exclude_guides;
    ++static int man_color = GIT_COLOR_UNKNOWN;
    + static struct option builtin_help_options[] = {
    + 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
    + 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
     @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *page)
      	}
      }
      
     +static void colorize_man(void)
     +{
    -+	if (!pager_use_color || !want_color(GIT_COLOR_UNKNOWN))
    ++	if (!want_color(man_color) || !pager_use_color)
     +		return;
     +
     +	/* Disable groff colors */
    @@ builtin/help.c: static void exec_man_man(const char *path, const char *page)
      	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
      	warning(_("failed to exec '%s'"), cmd);
     @@ builtin/help.c: static int git_help_config(const char *var, const char *value, void *cb)
    + 	}
      	if (starts_with(var, "man."))
      		return add_man_viewer_info(var, value);
    ++	if (!strcmp(var, "color.man")) {
    ++		man_color = git_config_colorbool(var, value);
    ++		return 0;
    ++	}
      
     -	return git_default_config(var, value, cb);
     +	return git_color_default_config(var, value, cb);

 Documentation/config/color.txt |  6 ++++++
 builtin/help.c                 | 32 +++++++++++++++++++++++++++++++-
 color.h                        |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index d5daacb13a..02019a612c 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -126,6 +126,12 @@ color.interactive.<slot>::
 	or `error`, for four distinct types of normal output from
 	interactive commands.
 
+color.man::
+	When set to `always`, always colorize the man pages. When `false`
+	(or `never`), never.  When set to `true` or `auto`, use color only
+	when the output is written to the terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/builtin/help.c b/builtin/help.c
index bb339f0fc8..05c758ca1b 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -11,6 +11,7 @@
 #include "config-list.h"
 #include "help.h"
 #include "alias.h"
+#include "color.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
@@ -43,6 +44,7 @@ static int verbose = 1;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static int exclude_guides;
+static int man_color = GIT_COLOR_UNKNOWN;
 static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
@@ -253,10 +255,33 @@ static void exec_man_konqueror(const char *path, const char *page)
 	}
 }
 
+static void colorize_man(void)
+{
+	if (!want_color(man_color) || !pager_use_color)
+		return;
+
+	/* Disable groff colors */
+	setenv("GROFF_NO_SGR", "1", 0);
+
+	/* Bold */
+	setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
+	setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
+
+	/* Underline */
+	setenv("LESS_TERMCAP_us", GIT_COLOR_BLUE GIT_COLOR_UNDERLINE, 0);
+	setenv("LESS_TERMCAP_ue", GIT_COLOR_RESET, 0);
+
+	/* Standout */
+	setenv("LESS_TERMCAP_so", GIT_COLOR_MAGENTA GIT_COLOR_REVERSE, 0);
+	setenv("LESS_TERMCAP_se", GIT_COLOR_RESET, 0);
+}
+
 static void exec_man_man(const char *path, const char *page)
 {
 	if (!path)
 		path = "man";
+
+	colorize_man();
 	execlp(path, "man", page, (char *)NULL);
 	warning_errno(_("failed to exec '%s'"), path);
 }
@@ -264,6 +289,7 @@ static void exec_man_man(const char *path, const char *page)
 static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
+	colorize_man();
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
 	warning(_("failed to exec '%s'"), cmd);
@@ -371,8 +397,12 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	}
 	if (starts_with(var, "man."))
 		return add_man_viewer_info(var, value);
+	if (!strcmp(var, "color.man")) {
+		man_color = git_config_colorbool(var, value);
+		return 0;
+	}
 
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static struct cmdnames main_cmds, other_cmds;
diff --git a/color.h b/color.h
index 98894d6a17..d012add4e8 100644
--- a/color.h
+++ b/color.h
@@ -51,6 +51,7 @@ struct strbuf;
 #define GIT_COLOR_FAINT		"\033[2m"
 #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
 #define GIT_COLOR_REVERSE	"\033[7m"
+#define GIT_COLOR_UNDERLINE	"\033[4m"
 
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
-- 
2.31.1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B7EC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA6061355
	for <git@archiver.kernel.org>; Tue, 18 May 2021 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbhERUtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbhERUth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 16:49:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5FBC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 13:48:17 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w127so7238746oig.12
        for <git@vger.kernel.org>; Tue, 18 May 2021 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OoVWdLhsxjDprsGe6pZ2gib0jw1vAHZUYB7RE3r8iw=;
        b=YDVHX/7zbYaGXqMC20XPc27E17+CpfB+qislcxGYXrFlCLcY7kprz5dYAkSwuiETbl
         BXUENUTrEej2X5KoXzihkiqirs2ZO9JWcmTs3HQcxhhwssjRpOoObfT9LWnbfG/axjqI
         j22sINhjx6gsj9JXOZYf1yKQUrmPOsx2/fI5twpHzIf0At0/iptGTY6zPRYhfLyFjuxh
         Srn0fD9u9WbujCtSIKIEq6XF8vkWUiYes5Vich3AwoJ0yoG0s/uoHNnvVqOCrpmsluET
         xBKXYOAmKWQD4Hq9+FH/jbpSZQ7QU68SRnEnIwKIEZk96j2ptHRNQFDSEU9iUc5HjiCP
         7dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OoVWdLhsxjDprsGe6pZ2gib0jw1vAHZUYB7RE3r8iw=;
        b=iEVnTPwgtJRQiXLvmRiIi+fVWxbJqjNTFV+aF9K6ziuO4Gti7HNxOOme+MuScRssUB
         jKS3zJmhl48Aq6p+WcfQRa7tmwJrdahm9rzDw6tCg3kqvmDjRir+0hnpuAyJbIRZTzdB
         nOgtBoy5Sek32nbpIaneyQkR2/KBtOPKPAhqkx+jmcJ/s+5YZ8KtO9X79F/Z9lq45BlB
         Xq5+qABF6Fk2YKWpMSHoCKsDjmD1oJDV9shXGTMh5i40JdfOvQvF0LwHo3btpZND7jjV
         1ijJY/3hOVAZKMxgRUPKawVijMbvq47UKBayUv0Nj0RNckV5U48M4/6RkxNDrZrtNMje
         CH8A==
X-Gm-Message-State: AOAM531CqAeZA7Ep+akbEZwJjYCLENrBr8ZUmqCOMTz/D6NilLMUxph9
        kc1+Tx0HBPpxj91xALxGjg+2saiI4y3Tpw==
X-Google-Smtp-Source: ABdhPJxPypGFg1ZPJlbJ4C0H8Bbrqmjvs1Vi9gLoimqMmXzvhlLpaIhNfWFO8YrU8O5hfgK4xZ2WlA==
X-Received: by 2002:aca:385:: with SMTP id 127mr4910960oid.143.1621370896771;
        Tue, 18 May 2021 13:48:16 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i2sm3977954oto.66.2021.05.18.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:48:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] help: colorize man pages
Date:   Tue, 18 May 2021 15:47:51 -0500
Message-Id: <20210518204751.13836-1-felipe.contreras@gmail.com>
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

A new color configuration is added: `color.man` for the people that want
to turn this feature off, otherwise `color.ui` is respected, and in
addition color.pager needs to be turned on.

Normally check_auto_color() would check the value of `color.pager`, but
in this particular case it's not git the one executing the pager, but
man. Therefore we need to check pager_use_color ourselves.

Also, unlike other color.* configurations, color.man=always does not
make any sense; git help is always run for a tty (it would be very
strange for a user to do `git help $page > output`, but in fact, that
works automatically [probably thanks to less being smart], we don't even
need to check if stdout is a tty, but just to be consistent we do). So
it's simply a boolean in our case.

So in order for this to have an effect:

 1. The user must use less
 2. Not have the same LESS_TERMCAP variables set
 3. Have color.ui enabled
 4. Have color.pager enabled
 5. Not have color.man disabled
 6. Run git with stdout on a tty

Otherwise the current behavior remains.

[1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
Range-diff against v2:
1:  9e34a49fa9 ! 1:  db93bf432b help: colorize man pages
    @@ Commit message
         If the user already has LESS_TERMCAP variables set in his/her
         environment, those are respected and not overwritten.
     
    -    A new color configuration is added: `color.man`, otherwise `color.ui` is
    -    respected, and in addition color.pager needs to turned on.
    +    A new color configuration is added: `color.man` for the people that want
    +    to turn this feature off, otherwise `color.ui` is respected, and in
    +    addition color.pager needs to be turned on.
     
         Normally check_auto_color() would check the value of `color.pager`, but
         in this particular case it's not git the one executing the pager, but
         man. Therefore we need to check pager_use_color ourselves.
     
    +    Also, unlike other color.* configurations, color.man=always does not
    +    make any sense; git help is always run for a tty (it would be very
    +    strange for a user to do `git help $page > output`, but in fact, that
    +    works automatically [probably thanks to less being smart], we don't even
    +    need to check if stdout is a tty, but just to be consistent we do). So
    +    it's simply a boolean in our case.
    +
    +    So in order for this to have an effect:
    +
    +     1. The user must use less
    +     2. Not have the same LESS_TERMCAP variables set
    +     3. Have color.ui enabled
    +     4. Have color.pager enabled
    +     5. Not have color.man disabled
    +     6. Run git with stdout on a tty
    +
    +    Otherwise the current behavior remains.
    +
         [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
     
         Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ Documentation/config/color.txt: color.interactive.<slot>::
      	interactive commands.
      
     +color.man::
    -+	When set to `always`, always colorize the man pages. When `false`
    -+	(or `never`), never.  When set to `true` or `auto`, use color only
    -+	when the output is written to the terminal. If unset, then the
    -+	value of `color.ui` is used (`auto` by default).
    ++	This flag can be used to disable the automatic colorizaton of man
    ++	pages when using the less pager. It's activated only when color.ui
    ++	allows it, and also when color.pager is on. (`true` by default).
     +
      color.pager::
      	A boolean to enable/disable colored output when the pager is in
    @@ builtin/help.c: static int verbose = 1;
      static unsigned int colopts;
      static enum help_format help_format = HELP_FORMAT_NONE;
      static int exclude_guides;
    -+static int man_color = GIT_COLOR_UNKNOWN;
    ++static int man_color = 1;
      static struct option builtin_help_options[] = {
      	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
      	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
    @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
      
     +static void colorize_man(void)
     +{
    -+	if (!want_color(man_color) || !pager_use_color)
    ++	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
     +		return;
     +
     +	/* Disable groff colors */
    @@ builtin/help.c: static int git_help_config(const char *var, const char *value, v
      	if (starts_with(var, "man."))
      		return add_man_viewer_info(var, value);
     +	if (!strcmp(var, "color.man")) {
    -+		man_color = git_config_colorbool(var, value);
    ++		man_color = git_config_bool(var, value);
     +		return 0;
     +	}
      

 Documentation/config/color.txt |  5 +++++
 builtin/help.c                 | 32 +++++++++++++++++++++++++++++++-
 color.h                        |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index d5daacb13a..11278b7f72 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -126,6 +126,11 @@ color.interactive.<slot>::
 	or `error`, for four distinct types of normal output from
 	interactive commands.
 
+color.man::
+	This flag can be used to disable the automatic colorizaton of man
+	pages when using the less pager. It's activated only when color.ui
+	allows it, and also when color.pager is on. (`true` by default).
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/builtin/help.c b/builtin/help.c
index bb339f0fc8..9025e9a56a 100644
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
+static int man_color = 1;
 static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
@@ -253,10 +255,33 @@ static void exec_man_konqueror(const char *path, const char *page)
 	}
 }
 
+static void colorize_man(void)
+{
+	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
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
+		man_color = git_config_bool(var, value);
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


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D6FC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 04:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7861040
	for <git@archiver.kernel.org>; Thu, 20 May 2021 04:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhETEIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 00:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhETEIy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 00:08:54 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5577C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 21:07:32 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso13728854otn.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 21:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8brM3WYP+X8NSbIzFA+4DYhtpJXKCdyXjYjfOiVKiE=;
        b=XAMn/WjhuW5DVaB9JBaXA+Kjvs7fKoa6wXBQ32ckKuyRSjSFG7Bzri+O9kkNz5nR8w
         7FqT7jfcRZ7QDmtDKfIS8sms/F/Apul+7z3GNW/p2HyEX84XdnfLwCLexDtdrbAsvQf4
         InJavD/bFXMkQrUYf28ggPD5kJfRvTNy+td7yZTqxcvxnbRolb2Kt5QvOvu0tJvOBvVU
         FwuTpB59jCFpvjueYOhKtjhkxl0bRhj0+7NV/Z6n2m+o5lN0PeJcsAsRdYxeppAuiKpW
         G+yTca836XNObArFNJPcbRIK30lSJudTWoQhug9nYa4J9bFtSODCD2qDbVBcgCpCsesa
         LTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8brM3WYP+X8NSbIzFA+4DYhtpJXKCdyXjYjfOiVKiE=;
        b=AWH5w3H6WUB9XHvTgsT1RoHWN73n1QsGINuOr+UjYsg0UF8m6xt8BMYEfJeiSfI95U
         sFY2HkF9S4AGpF/eW6SLHr7DdWlgH7r5ZB2tn7fTQvFy3/4neKAcVeENj4cvpUc7oWo1
         iT3+p7mFE3MyeXrFqdfxKvXj7ChiLujVsVuoQtHArwdVToXkGrFCdV4lnUwgUoGniJYO
         xCiKXOxSrKw3uYT1vaMVyJs6/gADctsFnroghywZFx3iWU1nqARMgJYIn0oBFItztW+W
         37dNbGJfY3rgHdvxB2aqeXSqkrvuzdt0soHZxSeOA58fXx7cW437Ufy6yG1KcFPnCs6O
         EF6A==
X-Gm-Message-State: AOAM530PctS79PRrilrWUcu4UQZtZFX1mxGZMwrlkXBx45NdPmyc2myU
        D48/Jlp5vJWoAQlJEa0w1rcN62g5cy7GIQ==
X-Google-Smtp-Source: ABdhPJyoj5rici9X9lqmAPcSpSuL13XAaRONOPyBuTAJLxg1RyOotiVk4+IwoakWBhmaMTMtfZXjrQ==
X-Received: by 2002:a9d:6548:: with SMTP id q8mr2344195otl.311.1621483651734;
        Wed, 19 May 2021 21:07:31 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id e21sm350701oii.23.2021.05.19.21.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 21:07:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Leah Neukirchen <leah@vuxu.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4] help: colorize man pages
Date:   Wed, 19 May 2021 23:07:25 -0500
Message-Id: <20210520040725.133848-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already colorize tools traditionally not colorized by default, like
diff and grep. Let's do the same for man.

Our man pages don't contain many useful colors (just blue links),
moreover, many people have groff SGR disabled, so they don't see any
colors with man pages.

We can set the LESS variable to render bold, underlined, and standout
text with colors in the less pager.

Bold is rendered as red, underlined as blue, and standout (prompt and
highlighted search) as inverse magenta.

Obviously this only works when the less pager is used.

If the user has already set the LESS variable in his/her environment,
that is respected, and nothing changes.

A new color configuration is added: `color.man` for the people that want
to turn this feature off, otherwise `color.ui` is respected.
Additionally, if color.pager is not enabled, this is disregarded.

Normally check_auto_color() would check the value of `color.pager`, but
in this particular case it's not git the one executing the pager, but
man. Therefore we need to check pager_use_color ourselves.

Also--unlike other color.* configurations--color.man=always does not
make any sense here; `git help` is always run for a tty (it would be very
strange for a user to do `git help $page > output`, but in fact, that
works automatically [probably thanks to less being smart], we don't even
need to check if stdout is a tty, but just to be consistent we do). So
it's simply a boolean in our case.

Moreover, just to be painstakingly comprehensive with people who have
color-aversion; we honour NO_COLOR [1].

So, in order for this change to have any effect:

 1. The user must use less
 2. Not have the LESS variable set
 3. Have color.ui enabled
 4. Not have color.pager disabled
 5. Not have color.man disabled
 6. Not have NO_COLOR set
 7. Not have git with stdout directed to a file

Fortunately the vast majority of our users meet all of the above, and
anybody who doesn't would not be affected negatively (plus very likely
comprises a very tiny minority).

[1] https://no-color.org/

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
Range-diff against v3:
1:  db93bf432b ! 1:  7249785014 help: colorize man pages
    @@ Metadata
      ## Commit message ##
         help: colorize man pages
     
    +    We already colorize tools traditionally not colorized by default, like
    +    diff and grep. Let's do the same for man.
    +
         Our man pages don't contain many useful colors (just blue links),
         moreover, many people have groff SGR disabled, so they don't see any
         colors with man pages.
     
    -    We can set LESS_TERMCAP variables to render bold and underlined text
    -    with colors in the pager; a common trick[1].
    +    We can set the LESS variable to render bold, underlined, and standout
    +    text with colors in the less pager.
     
    -    Bold is rendered as red, underlined as blue, and standout (messages and
    +    Bold is rendered as red, underlined as blue, and standout (prompt and
         highlighted search) as inverse magenta.
     
    -    This only works when the pager is less.
    +    Obviously this only works when the less pager is used.
     
    -    If the user already has LESS_TERMCAP variables set in his/her
    -    environment, those are respected and not overwritten.
    +    If the user has already set the LESS variable in his/her environment,
    +    that is respected, and nothing changes.
     
         A new color configuration is added: `color.man` for the people that want
    -    to turn this feature off, otherwise `color.ui` is respected, and in
    -    addition color.pager needs to be turned on.
    +    to turn this feature off, otherwise `color.ui` is respected.
    +    Additionally, if color.pager is not enabled, this is disregarded.
     
         Normally check_auto_color() would check the value of `color.pager`, but
         in this particular case it's not git the one executing the pager, but
         man. Therefore we need to check pager_use_color ourselves.
     
    -    Also, unlike other color.* configurations, color.man=always does not
    -    make any sense; git help is always run for a tty (it would be very
    +    Also--unlike other color.* configurations--color.man=always does not
    +    make any sense here; `git help` is always run for a tty (it would be very
         strange for a user to do `git help $page > output`, but in fact, that
         works automatically [probably thanks to less being smart], we don't even
         need to check if stdout is a tty, but just to be consistent we do). So
         it's simply a boolean in our case.
     
    -    So in order for this to have an effect:
    +    Moreover, just to be painstakingly comprehensive with people who have
    +    color-aversion; we honour NO_COLOR [1].
    +
    +    So, in order for this change to have any effect:
     
          1. The user must use less
    -     2. Not have the same LESS_TERMCAP variables set
    +     2. Not have the LESS variable set
          3. Have color.ui enabled
    -     4. Have color.pager enabled
    +     4. Not have color.pager disabled
          5. Not have color.man disabled
    -     6. Run git with stdout on a tty
    +     6. Not have NO_COLOR set
    +     7. Not have git with stdout directed to a file
     
    -    Otherwise the current behavior remains.
    +    Fortunately the vast majority of our users meet all of the above, and
    +    anybody who doesn't would not be affected negatively (plus very likely
    +    comprises a very tiny minority).
     
    -    [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
    +    [1] https://no-color.org/
     
         Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Comments-by: Jeff King <peff@peff.net>
    @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
     +	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
     +		return;
     +
    ++	/* See: https://no-color.org/ */
    ++	if (getenv("NO_COLOR"))
    ++		return;
    ++
     +	/* Disable groff colors */
     +	setenv("GROFF_NO_SGR", "1", 0);
     +
    -+	/* Bold */
    -+	setenv("LESS_TERMCAP_md", GIT_COLOR_BOLD_RED, 0);
    -+	setenv("LESS_TERMCAP_me", GIT_COLOR_RESET, 0);
    -+
    -+	/* Underline */
    -+	setenv("LESS_TERMCAP_us", GIT_COLOR_BLUE GIT_COLOR_UNDERLINE, 0);
    -+	setenv("LESS_TERMCAP_ue", GIT_COLOR_RESET, 0);
    -+
    -+	/* Standout */
    -+	setenv("LESS_TERMCAP_so", GIT_COLOR_MAGENTA GIT_COLOR_REVERSE, 0);
    -+	setenv("LESS_TERMCAP_se", GIT_COLOR_RESET, 0);
    ++	/* Add red to bold, blue to underline, and magenta to standout */
    ++	/* No visual information is lost */
    ++	setenv("LESS", "Dd+r$Du+b$Ds", 0);
     +}
     +
      static void exec_man_man(const char *path, const char *page)
    @@ builtin/help.c: static int git_help_config(const char *var, const char *value, v
      }
      
      static struct cmdnames main_cmds, other_cmds;
    -
    - ## color.h ##
    -@@ color.h: struct strbuf;
    - #define GIT_COLOR_FAINT		"\033[2m"
    - #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
    - #define GIT_COLOR_REVERSE	"\033[7m"
    -+#define GIT_COLOR_UNDERLINE	"\033[4m"
    - 
    - /* A special value meaning "no color selected" */
    - #define GIT_COLOR_NIL "NIL"

 Documentation/config/color.txt |  5 +++++
 builtin/help.c                 | 28 +++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

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
index bb339f0fc8..298d97cc39 100644
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
@@ -253,10 +255,29 @@ static void exec_man_konqueror(const char *path, const char *page)
 	}
 }
 
+static void colorize_man(void)
+{
+	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
+		return;
+
+	/* See: https://no-color.org/ */
+	if (getenv("NO_COLOR"))
+		return;
+
+	/* Disable groff colors */
+	setenv("GROFF_NO_SGR", "1", 0);
+
+	/* Add red to bold, blue to underline, and magenta to standout */
+	/* No visual information is lost */
+	setenv("LESS", "Dd+r$Du+b$Ds", 0);
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
@@ -264,6 +285,7 @@ static void exec_man_man(const char *path, const char *page)
 static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
+	colorize_man();
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
 	warning(_("failed to exec '%s'"), cmd);
@@ -371,8 +393,12 @@ static int git_help_config(const char *var, const char *value, void *cb)
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
-- 
2.31.1


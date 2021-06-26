Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D5C2B9F4
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 02:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F096194F
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 02:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFZCxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 22:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFZCxH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 22:53:07 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A812C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 19:50:45 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 22so7680818oix.10
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 19:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJvEZx/0Y3AJ6Dk1+CkaVM/sTLnqrnJt5+4Vqxp/03A=;
        b=mFUPm077QAP/B+TkEsxEAtw13yMM7ZlBgbSeS4EYwiohKV0qo4N5BLNscHKzGxJOiy
         +4aCKKDEC6/puxaVZ3kkkbhqonb/Y/mrYWMtKPqTFGIlYxGvH6bHvYwBVoabQqQhvaW3
         ztmbjqKrpU1+N+vaG+atPkeGJuyuJDZjrL+ZfMcOJ3TVuWuNxmex7oY1wbqbZ24L0r9L
         dJg7kgMr0ANA2qf9KSMZa2+37GyXjHDK8nd4rMuHILSdSTpcEdkI8CPfCc+V6tv42t1D
         W8ov7tdDt0NhJxqvC92F8OePDWYnj2LSZJdXZ8t4cOth2K68rd5Vca1YToPd88qX6pdZ
         +1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJvEZx/0Y3AJ6Dk1+CkaVM/sTLnqrnJt5+4Vqxp/03A=;
        b=rCqKRFiRgmURP41UbL+IPYgzX5dzaDH7Qvb9SDwDR7klXnI/OpiYGXKHX0joFQH+Qj
         XX0mCTVNE/ZrB/20BWBM2DrZ4JrsC59D+bRmPJ434/FHGu5waLJQDcB07B2sJ4CcPxj3
         oLKaITqzTAZRf2jO9Fp8Uos3rLM2N4x/W4+pVjoGYtBfSLcewhOrLUXRjgRmM3bAybQF
         dPtql1ZHZ9azkVzcTUtVabLNCuNF3yVwinnle6VS4ij6yBAfff3vfWzWDAtNnD7LvoJ9
         vgXNZkWbkZwlWJsvbi0HexJqPNp2nd3h5bfPQEqpWRiuPpI86gM5ktalp8FcunNl7mJv
         Gqmw==
X-Gm-Message-State: AOAM530eOuAj/UNy6GBroAqLJt+7BvKQqVaEd3jj5pJY8LbFCLKlxZwg
        24PEbUs0evT0BNq/mNLi4pdsmkI7l402yg==
X-Google-Smtp-Source: ABdhPJxyEBDJbtEN+hHOwYudyCRdVhu+uyn25SKFQ99lFr8zxfZU09VJonPh4fXa8Nv2C8fNmzs9UA==
X-Received: by 2002:aca:b1d6:: with SMTP id a205mr6001754oif.41.1624675844311;
        Fri, 25 Jun 2021 19:50:44 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y7sm1672923oix.36.2021.06.25.19.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 19:50:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8] help: add option to colorize man pages under less
Date:   Fri, 25 Jun 2021 21:50:40 -0500
Message-Id: <20210626025040.104428-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210523054454.1188757-1-felipe.contreras@gmail.com>
References: <20210523054454.1188757-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already colorize tools traditionally not colorized by default--like
diff and grep. Let's do the same for man, but only if `color.man` is
explicitly set to "true".

Unlike other `color.*` output, this colorization is not enabled when
`color.ui` is true; the user needs to explicitly set the
`color.man` variable to `true.

When it was proposed to treat `color.man` like any other `color.*`
variable, some thought that git opting to add color for an external
program such as man(1) was a step too far [1]--even if the user invoked
it via the "git help <topic>" wrapper. So let's make this explicitly
opt-in for now.

As noted in the documentation we're leaving ourselves an out to turn
this on by default in the future, for example putting it under the
feature.experimental umbrella. We probably won't, but let's not promise
users that `color.man` will forever be a special-case.

As for what this actually does, the effect of having this enabled is
that a documentation blurb like (some parts elided with "[...]"):

	NAME
	----
	git-config - Get and set [...]

	SYNOPSIS
	--------
	[...]
	'git config' [<file-option>] [...]
	[...]
	The `--type=<type>` option instructs 'git config' to ensure [...]

Will have "NAME" and "SYNOPSIS" shown as RED BOLD instead of BOLD,
"git config" and other '-quoted parts in BLUE UNDERLINE instead of
UNDERLINE, and `--type=<type>` and other `-quoted parts in RED BOLD
instead of BOLD. The "standout" setting is then used for the user's
own search bar (invoked with "/") and prompt. See [2] for more
examples

Normally check_auto_color() would check the value of `color.pager`, but
in this particular case it's not git the one executing the pager, but
man. Therefore we need to check pager_use_color ourselves.

We do not need to support `color.man` being set to `always`; the `git
help` command is always run for a tty (it would be very strange for a
user to do `git help $page > output`, but in fact, that works anyway,
we don't even need to check if stdout is a tty, but just to be
consistent we do). So it's simply a boolean in our case.

So, in order for this change to have any effect:

 1. color.man=true must be set in the config
 2. The user must use less
 3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with overwrite=0)
 4. Not have color.pager disabled
 5. Not have git with stdout directed to a file

1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This a reroll of Ævar's v7 with comments from Jeff King so that
color.ui=never doesn't disable color.man, and the documentation was
updated accordingly.

Additinally I removed one call to colorize_man() in exec_man_cmd() which
is not meant for the man command (although it could be used for that).

Plus a bunch of style changes to the commit message.

Range-diff against v7:
1:  167f5c8b39 ! 1:  1b3f7ee1aa help: colorize man pages if man.color=true under less(1)
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    help: colorize man pages if man.color=true under less(1)
    +    help: add option to colorize man pages under less
     
    -    We already colorize tools traditionally not colorized by default, like
    +    We already colorize tools traditionally not colorized by default--like
         diff and grep. Let's do the same for man, but only if `color.man` is
         explicitly set to "true".
     
    -    Unlike other `color.*` output this colorization is not enabled by
    -    `color.ui` being true, the user needs to explicitly set the
    +    Unlike other `color.*` output, this colorization is not enabled when
    +    `color.ui` is true; the user needs to explicitly set the
         `color.man` variable to `true.
     
         When it was proposed to treat `color.man` like any other `color.*`
    -    variable some thought that git opting in coloring for an external
    -    program such as man(1) was a step too far[1], even if the user invoked
    -    it via the "git help <topic>" wrapper.
    +    variable, some thought that git opting to add color for an external
    +    program such as man(1) was a step too far [1]--even if the user invoked
    +    it via the "git help <topic>" wrapper. So let's make this explicitly
    +    opt-in for now.
     
    -    So let's make this explicitly opt-in for now. As noted in the
    -    documentation we're leaving ourselves an out to turn this on by
    -    default in the future, or e.g. putting it under the
    -    feature.experimental umbrella. We probably won't, but let's not
    -    promise users that `color.man` will forever be a special-case.
    +    As noted in the documentation we're leaving ourselves an out to turn
    +    this on by default in the future, for example putting it under the
    +    feature.experimental umbrella. We probably won't, but let's not promise
    +    users that `color.man` will forever be a special-case.
     
    -    As for what this actually does the effect of having this enabled is
    +    As for what this actually does, the effect of having this enabled is
         that a documentation blurb like (some parts elided with "[...]"):
     
                 NAME
    @@ Commit message
                 [...]
                 The `--type=<type>` option instructs 'git config' to ensure [...]
     
    -    Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
    -    config" and other '-quoted parts in BLUE UNDERLINE instead of
    +    Will have "NAME" and "SYNOPSIS" shown as RED BOLD instead of BOLD,
    +    "git config" and other '-quoted parts in BLUE UNDERLINE instead of
         UNDERLINE, and `--type=<type>` and other `-quoted parts in RED BOLD
    -    instead of BOLD. The "Standout" setting is then used for the user's
    +    instead of BOLD. The "standout" setting is then used for the user's
         own search bar (invoked with "/") and prompt. See [2] for more
         examples
     
    @@ Commit message
         in this particular case it's not git the one executing the pager, but
         man. Therefore we need to check pager_use_color ourselves.
     
    -    We do not need to support `color.man` being set to `always`; The `git
    +    We do not need to support `color.man` being set to `always`; the `git
         help` command is always run for a tty (it would be very strange for a
         user to do `git help $page > output`, but in fact, that works anyway,
         we don't even need to check if stdout is a tty, but just to be
    @@ Commit message
          1. color.man=true must be set in the config
          2. The user must use less
          3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with overwrite=0)
    -     4. Have color.ui enabled
    -     5. Not have color.pager disabled
    -     6. Not have git with stdout directed to a file
    +     4. Not have color.pager disabled
    +     5. Not have git with stdout directed to a file
     
         1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
         2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
     
         Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Documentation/config/color.txt ##
     @@ Documentation/config/color.txt: color.interactive.<slot>::
    @@ Documentation/config/color.txt: color.interactive.<slot>::
      	interactive commands.
      
     +color.man::
    -+	This flag can be used to enable the automatic colorizaton of man
    ++	This flag can be used to enable the automatic colorization of man
     +	pages when using the less pager, `false` by default. When set to
    -+	`true` it's activated only when `color.ui` allows it, and if
    -+	`color.pager` enable (which it is by default).
    ++	`true` it's activated only if `color.pager` is enabled (which it
    ++	is by default).
     +
      color.pager::
      	A boolean to specify whether `auto` color modes should colorize
    @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
      
     +static void colorize_man(void)
     +{
    -+	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
    ++	if (!man_color || !pager_use_color)
     +		return;
     +
     +	/* Disable groff colors */
    @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
      	execlp(path, "man", page, (char *)NULL);
      	warning_errno(_("failed to exec '%s'"), path);
      }
    -@@ builtin/help.c: static void exec_man_man(const char *path, const char *page)
    - static void exec_man_cmd(const char *cmd, const char *page)
    - {
    - 	struct strbuf shell_cmd = STRBUF_INIT;
    -+	colorize_man();
    - 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
    - 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
    - 	warning(_("failed to exec '%s'"), cmd);
     @@ builtin/help.c: static int git_help_config(const char *var, const char *value, void *cb)
      	}
      	if (starts_with(var, "man."))

 Documentation/config/color.txt | 11 +++++++++++
 builtin/help.c                 | 31 ++++++++++++++++++++++++++++++-
 color.h                        |  1 +
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index e05d520a86..8511af1f1d 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -126,6 +126,12 @@ color.interactive.<slot>::
 	or `error`, for four distinct types of normal output from
 	interactive commands.
 
+color.man::
+	This flag can be used to enable the automatic colorization of man
+	pages when using the less pager, `false` by default. When set to
+	`true` it's activated only if `color.pager` is enabled (which it
+	is by default).
+
 color.pager::
 	A boolean to specify whether `auto` color modes should colorize
 	output going to the pager. Defaults to true; set this to false
@@ -200,3 +206,8 @@ color.ui::
 	output not intended for machine consumption to use color, to
 	`true` or `auto` (this is the default since Git 1.8.4) if you
 	want such output to use color when written to the terminal.
++
+When set to `true` certain other `color.*` variables may still not be
+turned on unless explicitly enabled. Currently this only applies to
+`color.man`, see above. Such opt-in variables may be moved under the
+default `color.ui` umbrella in the future.
diff --git a/builtin/help.c b/builtin/help.c
index bb339f0fc8..150dd05fdb 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -11,6 +11,7 @@
 #include "config-list.h"
 #include "help.h"
 #include "alias.h"
+#include "color.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
@@ -34,6 +35,7 @@ enum help_format {
 	HELP_FORMAT_WEB
 };
 
+static int man_color;
 static const char *html_path;
 
 static int show_all = 0;
@@ -253,10 +255,33 @@ static void exec_man_konqueror(const char *path, const char *page)
 	}
 }
 
+static void colorize_man(void)
+{
+	if (!man_color || !pager_use_color)
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
+	setenv("LESS_TERMCAP_so", GIT_COLOR_CYAN GIT_COLOR_REVERSE, 0);
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
@@ -371,8 +396,12 @@ static int git_help_config(const char *var, const char *value, void *cb)
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
2.32.0


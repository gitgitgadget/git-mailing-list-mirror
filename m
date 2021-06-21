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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71254C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 08:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475B761151
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 08:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhFUIgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUIgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 04:36:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16804C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 01:34:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso10422373wms.0
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbFPoChe3uYAoNNUYl9rfy6zmaR3/xkETG+2mrXkCfI=;
        b=ajPExNP4JWlyasiD0LZ6pfNDBBHr7dGS/BMGBatlydWGgj8pxvq/OWlEYtwtTmg478
         sQ7PB54gUdQp8dAvqNeiRp2MxmLwyf+vvLTXfzqr5mQY4a86/rFyyYI7zZMLV5nc9XLz
         662jLOK/nHs0gipCIzNz+QbH2+vUVerAvaN/NqF7Y9y2PvAbW9S2yPKwZvkr7BB/gVIj
         0MRwzZdDFXB2mFOZEsTEIxv7/fQY7DLYgi+6gC9Zzmk5lXNTes94g6K6hxNXhkf8NMc1
         FtTSahebJBDDWPBo5K+ZWWVuXh9UJlDTI6WyNTd/IYbXF309MKq10SWRNz3fmaYnSoBl
         BdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbFPoChe3uYAoNNUYl9rfy6zmaR3/xkETG+2mrXkCfI=;
        b=db7He8LvW0+cQ/mejp3uDX5ZoHTyeSLFzF66u+TSo7bu0ZPEg5I0YyS239fTYATfV9
         MvdatyROnUULdEBBjeXSTLID+LB0Mo1qhtToPrVtTztX1Xnxw+RRowVgr4l4h8N9z1lA
         affB6YVxlR7ULqYFVVphd+FPNirUbLjJIl3GUsXRqa1ayoAzIqWg9jwpVyIDeWTJjjjx
         wGdCZe4WlmmNOvub2l/Js+Cie7xClF+1ZwA3b9t+3kuklwL+nB+Cxe0k6XSrHlDBow9F
         WhpeliBhVal8F8mmiSlFcxeG/YEGG6CWwCQk27/4N/NILAb7gZbGFnK0o6dow4w8zDhx
         N93A==
X-Gm-Message-State: AOAM531bxUZ9sAUQoaFngYhYHqJP1UvDNoqSsExohJOqEOZ5WhwXjPxv
        2udALs1jcbHMH0S0S0qo5umsNg5KMLLUUA==
X-Google-Smtp-Source: ABdhPJwhI53Vh7V1lW41laAgIIRDQ3XcdULVYEgtT9NzDuO5PrR8mvHQBGCxkIjHVhvVRGLANdXy3A==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr25522338wmh.8.1624264447394;
        Mon, 21 Jun 2021 01:34:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c18sm6372464wrt.83.2021.06.21.01.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 01:34:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7] help: colorize man pages if man.color=true under less(1)
Date:   Mon, 21 Jun 2021 10:34:00 +0200
Message-Id: <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g672d808136f
In-Reply-To: <xmqq4ke8pig9.fsf@gitster.g>
References: <xmqq4ke8pig9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Felipe Contreras <felipe.contreras@gmail.com>

We already colorize tools traditionally not colorized by default, like
diff and grep. Let's do the same for man, but only if `color.man` is
explicitly set to "true".

Unlike other `color.*` output this colorization is not enabled by
`color.ui` being true, the user needs to explicitly set the
`color.man` variable to `true.

When it was proposed to treat `color.man` like any other `color.*`
variable some thought that git opting in coloring for an external
program such as man(1) was a step too far[1], even if the user invoked
it via the "git help <topic>" wrapper.

So let's make this explicitly opt-in for now. As noted in the
documentation we're leaving ourselves an out to turn this on by
default in the future, or e.g. putting it under the
feature.experimental umbrella. We probably won't, but let's not
promise users that `color.man` will forever be a special-case.

As for what this actually does the effect of having this enabled is
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

Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
config" and other '-quoted parts in BLUE UNDERLINE instead of
UNDERLINE, and `--type=<type>` and other `-quoted parts in RED BOLD
instead of BOLD. The "Standout" setting is then used for the user's
own search bar (invoked with "/") and prompt. See [2] for more
examples

Normally check_auto_color() would check the value of `color.pager`, but
in this particular case it's not git the one executing the pager, but
man. Therefore we need to check pager_use_color ourselves.

We do not need to support `color.man` being set to `always`; The `git
help` command is always run for a tty (it would be very strange for a
user to do `git help $page > output`, but in fact, that works anyway,
we don't even need to check if stdout is a tty, but just to be
consistent we do). So it's simply a boolean in our case.

So, in order for this change to have any effect:

 1. color.man=true must be set in the config
 2. The user must use less
 3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with overwrite=0)
 4. Have color.ui enabled
 5. Not have color.pager disabled
 6. Not have git with stdout directed to a file

1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Jun 08 2021, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> I've been running with this on my personal git build since May 26th. I
>> haven't had any issues with it, and I like the new coloring.
>> ...
>> I think this is a good example of a change that we're better off just
>> merging down and then reverting if the wider audience of git users hates
>> it, rather than trying to come to some perfect consensus here
>> on-list.
>
> My impression was tht we already had a rough consensus here on-list
> that it may be good to educate users who like this "new coloring"
> like you do to configure their "less", so that they consistently get
> the "new coloring" they like whether they are doing "git help git",
> "man git", or even "man ls", and the approach the posted patch takes
> will not help (it only affects "git help git" among these).
>
> I'd rather not to take it.

Fair enough, here's a version I think you and others will find
acceptable then. It allows users like me who like this to explicitly
opt-in via color.man=true.

I also took the liberty of making some changes to the commit message
to reword it for this new behavior, and to show an example of the sort
of colors that change with this patch.

The only change to the patch itself is that now color_man is set to 0
by default, not 1. I also moved its declaration so that it's with the
one other config variable, insted of with the other command-line
options to "git help".

Range-diff against v6:
1:  e021ca1da21 ! 1:  a950ef49e28 help: colorize man pages
    @@ Metadata
     Author: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## Commit message ##
    -    help: colorize man pages
    +    help: colorize man pages if man.color=true under less(1)
     
         We already colorize tools traditionally not colorized by default, like
    -    diff and grep. Let's do the same for man.
    -
    -    Our man pages don't contain many useful colors (just blue links),
    -    moreover, many people have groff SGR disabled, so they don't see any
    -    colors with man pages.
    -
    -    We can set LESS_TERMCAP variables to render bold and underlined text
    -    with colors in the pager; a common trick[1].
    -
    -    Bold is rendered as red, underlined as blue, and standout (prompt and
    -    highlighted search) as inverse cyan.
    -
    -    Obviously this only works when the less pager is used.
    -
    -    If the user already has LESS_TERMCAP variables set in his/her
    -    environment, those are respected and nothing changes.
    -
    -    A new color configuration is added: `color.man` for the people that want
    -    to turn this feature off, otherwise `color.ui` is respected.
    -    Additionally, if color.pager is not enabled, this is disregarded.
    +    diff and grep. Let's do the same for man, but only if `color.man` is
    +    explicitly set to "true".
    +
    +    Unlike other `color.*` output this colorization is not enabled by
    +    `color.ui` being true, the user needs to explicitly set the
    +    `color.man` variable to `true.
    +
    +    When it was proposed to treat `color.man` like any other `color.*`
    +    variable some thought that git opting in coloring for an external
    +    program such as man(1) was a step too far[1], even if the user invoked
    +    it via the "git help <topic>" wrapper.
    +
    +    So let's make this explicitly opt-in for now. As noted in the
    +    documentation we're leaving ourselves an out to turn this on by
    +    default in the future, or e.g. putting it under the
    +    feature.experimental umbrella. We probably won't, but let's not
    +    promise users that `color.man` will forever be a special-case.
    +
    +    As for what this actually does the effect of having this enabled is
    +    that a documentation blurb like (some parts elided with "[...]"):
    +
    +            NAME
    +            ----
    +            git-config - Get and set [...]
    +
    +            SYNOPSIS
    +            --------
    +            [...]
    +            'git config' [<file-option>] [...]
    +            [...]
    +            The `--type=<type>` option instructs 'git config' to ensure [...]
    +
    +    Will have "NAME" and "SECTION" shown as BOLD RED instead of BOLD, "git
    +    config" and other '-quoted parts in BLUE UNDERLINE instead of
    +    UNDERLINE, and `--type=<type>` and other `-quoted parts in RED BOLD
    +    instead of BOLD. The "Standout" setting is then used for the user's
    +    own search bar (invoked with "/") and prompt. See [2] for more
    +    examples
     
         Normally check_auto_color() would check the value of `color.pager`, but
         in this particular case it's not git the one executing the pager, but
         man. Therefore we need to check pager_use_color ourselves.
     
    -    Also--unlike other color.* configurations--color.man=always does not
    -    make any sense here; `git help` is always run for a tty (it would be very
    -    strange for a user to do `git help $page > output`, but in fact, that
    -    works anyway, we don't even need to check if stdout is a tty, but just
    -    to be consistent we do). So it's simply a boolean in our case.
    +    We do not need to support `color.man` being set to `always`; The `git
    +    help` command is always run for a tty (it would be very strange for a
    +    user to do `git help $page > output`, but in fact, that works anyway,
    +    we don't even need to check if stdout is a tty, but just to be
    +    consistent we do). So it's simply a boolean in our case.
     
         So, in order for this change to have any effect:
     
    -     1. The user must use less
    -     2. Not have the same LESS_TERMCAP variables set
    -     3. Have color.ui enabled
    -     4. Not have color.pager disabled
    -     5. Not have color.man disabled
    -     7. Not have git with stdout directed to a file
    -
    -    Fortunately the vast majority of our users meet all of the above, and
    -    anybody who doesn't would not be affected negatively (plus very likely
    -    comprises a very tiny minority).
    +     1. color.man=true must be set in the config
    +     2. The user must use less
    +     3. Not have the same LESS_TERMCAP variables set (we call setenv(3) with overwrite=0)
    +     4. Have color.ui enabled
    +     5. Not have color.pager disabled
    +     6. Not have git with stdout directed to a file
     
    -    [1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
    +    1. https://lore.kernel.org/git/87tun1qp91.fsf@evledraar.gmail.com/
    +    2. https://unix.stackexchange.com/questions/119/colors-in-man-pages/147
     
         Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -    Phillip Wood <phillip.wood123@gmail.com>
    -    Comments-by: Jeff King <peff@peff.net>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/color.txt ##
     @@ Documentation/config/color.txt: color.interactive.<slot>::
    @@ Documentation/config/color.txt: color.interactive.<slot>::
      	interactive commands.
      
     +color.man::
    -+	This flag can be used to disable the automatic colorizaton of man
    -+	pages when using the less pager. It's activated only when color.ui
    -+	allows it, and also when color.pager is on. (`true` by default).
    ++	This flag can be used to enable the automatic colorizaton of man
    ++	pages when using the less pager, `false` by default. When set to
    ++	`true` it's activated only when `color.ui` allows it, and if
    ++	`color.pager` enable (which it is by default).
     +
      color.pager::
    - 	A boolean to enable/disable colored output when the pager is in
    - 	use (default is true).
    + 	A boolean to specify whether `auto` color modes should colorize
    + 	output going to the pager. Defaults to true; set this to false
    +@@ Documentation/config/color.txt: color.ui::
    + 	output not intended for machine consumption to use color, to
    + 	`true` or `auto` (this is the default since Git 1.8.4) if you
    + 	want such output to use color when written to the terminal.
    +++
    ++When set to `true` certain other `color.*` variables may still not be
    ++turned on unless explicitly enabled. Currently this only applies to
    ++`color.man`, see above. Such opt-in variables may be moved under the
    ++default `color.ui` umbrella in the future.
     
      ## builtin/help.c ##
     @@
    @@ builtin/help.c
      
      #ifndef DEFAULT_HELP_FORMAT
      #define DEFAULT_HELP_FORMAT "man"
    -@@ builtin/help.c: static int verbose = 1;
    - static unsigned int colopts;
    - static enum help_format help_format = HELP_FORMAT_NONE;
    - static int exclude_guides;
    -+static int man_color = 1;
    - static struct option builtin_help_options[] = {
    - 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
    - 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
    +@@ builtin/help.c: enum help_format {
    + 	HELP_FORMAT_WEB
    + };
    + 
    ++static int man_color;
    + static const char *html_path;
    + 
    + static int show_all = 0;
     @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *page)
      	}
      }

 Documentation/config/color.txt | 11 +++++++++++
 builtin/help.c                 | 32 +++++++++++++++++++++++++++++++-
 color.h                        |  1 +
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index e05d520a867..2f12ae3386d 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -126,6 +126,12 @@ color.interactive.<slot>::
 	or `error`, for four distinct types of normal output from
 	interactive commands.
 
+color.man::
+	This flag can be used to enable the automatic colorizaton of man
+	pages when using the less pager, `false` by default. When set to
+	`true` it's activated only when `color.ui` allows it, and if
+	`color.pager` enable (which it is by default).
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
index bb339f0fc80..c607da88d78 100644
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
index 98894d6a175..d012add4e8a 100644
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
2.32.0.599.g672d808136f


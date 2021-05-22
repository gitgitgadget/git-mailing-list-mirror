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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED6C04FF3
	for <git@archiver.kernel.org>; Sat, 22 May 2021 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43416613EE
	for <git@archiver.kernel.org>; Sat, 22 May 2021 01:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhEVBSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 21:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhEVBSp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 21:18:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271FDC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 18:17:22 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y76so12136452oia.6
        for <git@vger.kernel.org>; Fri, 21 May 2021 18:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bbb8BL2T6hfgWYH7NPMOU2+OR1XMI7rwM6mwwOtF5tI=;
        b=UMqVj6ltGYyk90294T729vrjSwUcgEsadF6Mr01aAgAqglExD5t4svha+yzIFGjwPK
         p2cfGbuR0/thAiNrZ2F2DRV5BssNVPa2YgMVrnFPdAcx1UA1hvgfMJrIzCgiCN4Cns9d
         qkp9aZtqgPX+T/2oLd6oJALOHoVi8+roe4elJKOQQmQKVpn1V8cbDtRznb3qr0sxCNXW
         0d4MUzPkQqQKQVn/YBZSwonEdlxk04ABWSZhZkzuOkB3XqWX1ttCn6atNFRi8GTENv0N
         uAWX38qn75jWWCnXImIPZV5Y8jpSZxafauNKesnLHaVpDSVlmkMeLjgRje2Z57Fmm447
         P1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bbb8BL2T6hfgWYH7NPMOU2+OR1XMI7rwM6mwwOtF5tI=;
        b=B6wReTZ4Y4qcmvTzGyFaKOSH24Uzjk6hlhe3rV6QoN48ogogTYwFTpfd4FWPKeWQtp
         xEyZMLR58gz7LG99DA3/MUlCAjn62tMVBd+xSZMY33eVSCcQr9M6s1kKALH96AziYkvM
         dOEy0GzpOSxJxirapQ4bkABrY0rHUeE+jVZt8wmtviPzH0YJzZpAhGiGZ9xegzRtDV9G
         SOvTqVe76cxm/TxZVwPPcitPV4lJKBrE71L6gQJ13iwzCxpj/3VZKSEuum6j5Xmp55Kh
         o93gdjgLHqeCOwWe760xaS6FledB+YE9AC9Sg+PwT04VQISBXQGZgkZLxFLR6Laou/Mw
         vXdQ==
X-Gm-Message-State: AOAM5300hAwb+r9sMST84eCdfXz3Ed76dhSIDq9EluJQvupsmv5X+lTc
        8CDE3b1hK32gaMCT/Lu+MTmSnFsoVYH2uA==
X-Google-Smtp-Source: ABdhPJzTy9VfWssfKr8x9yIVGDnhBHxenEvquuJJ1iUurny+VuFDcS1HFZRvNrbTGyMQiSsqoiMnZg==
X-Received: by 2002:aca:4ed4:: with SMTP id c203mr4120641oib.51.1621646240893;
        Fri, 21 May 2021 18:17:20 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id v18sm1502015oos.23.2021.05.21.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 18:17:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5] help: colorize man pages
Date:   Fri, 21 May 2021 20:17:18 -0500
Message-Id: <20210522011718.541986-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
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
that is respected, and nothing changes. The same if any LESS_TERMCAP_*
variables are set.

A new color configuration is added: `color.man` for the people that want
to turn this feature off, otherwise `color.ui` is respected.
Additionally, if color.pager is not enabled, this is disregarded.

Normally check_auto_color() would check the value of `color.pager`, but
in this particular case it's not git the one executing the pager, but
man. Therefore we need to check pager_use_color ourselves.

Also--unlike other color.* configurations--color.man=always does not
make any sense here; `git help` is always run for a tty (it would be very
strange for a user to do `git help $page > output`, but in fact, that
works anyway, we don't even need to check if stdout is a tty, but just
to be consistent we do). So it's simply a boolean in our case.

So, in order for this change to have any effect:

 1. The user must use less
 2. Not have the LESS variable set
 3. Have color.ui enabled
 4. Not have color.pager disabled
 5. Not have color.man disabled
 7. Not have git with stdout directed to a file

Fortunately the vast majority of our users meet all of the above, and
anybody who doesn't would not be affected negatively (plus very likely
comprises a very tiny minority).

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Comments-by: Phillip Wood <phillip.wood123@gmail.com>
Comments-by: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I removed the NO_COLOR check (seems to be contentious, and can be added
later anyway), and added check to make sure the user has no
LESS_TERMCAP_* variables set.

I also fixed the missing color for standout.

Range-diff against v4:
1:  7249785014 ! 1:  a1190a1c67 help: colorize man pages
    @@ Commit message
         Obviously this only works when the less pager is used.
     
         If the user has already set the LESS variable in his/her environment,
    -    that is respected, and nothing changes.
    +    that is respected, and nothing changes. The same if any LESS_TERMCAP_*
    +    variables are set.
     
         A new color configuration is added: `color.man` for the people that want
         to turn this feature off, otherwise `color.ui` is respected.
    @@ Commit message
         Also--unlike other color.* configurations--color.man=always does not
         make any sense here; `git help` is always run for a tty (it would be very
         strange for a user to do `git help $page > output`, but in fact, that
    -    works automatically [probably thanks to less being smart], we don't even
    -    need to check if stdout is a tty, but just to be consistent we do). So
    -    it's simply a boolean in our case.
    -
    -    Moreover, just to be painstakingly comprehensive with people who have
    -    color-aversion; we honour NO_COLOR [1].
    +    works anyway, we don't even need to check if stdout is a tty, but just
    +    to be consistent we do). So it's simply a boolean in our case.
     
         So, in order for this change to have any effect:
     
    @@ Commit message
          3. Have color.ui enabled
          4. Not have color.pager disabled
          5. Not have color.man disabled
    -     6. Not have NO_COLOR set
          7. Not have git with stdout directed to a file
     
         Fortunately the vast majority of our users meet all of the above, and
         anybody who doesn't would not be affected negatively (plus very likely
         comprises a very tiny minority).
     
    -    [1] https://no-color.org/
    -
         Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Comments-by: Jeff King <peff@peff.net>
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    @@ builtin/help.c: static void exec_man_konqueror(const char *path, const char *pag
     +	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
     +		return;
     +
    -+	/* See: https://no-color.org/ */
    -+	if (getenv("NO_COLOR"))
    ++	/* User already has configured less colors */
    ++	if (getenv("LESS_TERMCAP_md") ||
    ++		getenv("LESS_TERMCAP_us") ||
    ++		getenv("LESS_TERMCAP_so")) {
     +		return;
    ++	}
     +
     +	/* Disable groff colors */
     +	setenv("GROFF_NO_SGR", "1", 0);
     +
     +	/* Add red to bold, blue to underline, and magenta to standout */
     +	/* No visual information is lost */
    -+	setenv("LESS", "Dd+r$Du+b$Ds", 0);
    ++	setenv("LESS", "Dd+r$Du+b$Ds+m", 0);
     +}
     +
      static void exec_man_man(const char *path, const char *page)

 Documentation/config/color.txt |  5 +++++
 builtin/help.c                 | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

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
index bb339f0fc8..f64b1a5aa5 100644
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
@@ -253,10 +255,32 @@ static void exec_man_konqueror(const char *path, const char *page)
 	}
 }
 
+static void colorize_man(void)
+{
+	if (!man_color || !want_color(GIT_COLOR_UNKNOWN) || !pager_use_color)
+		return;
+
+	/* User already has configured less colors */
+	if (getenv("LESS_TERMCAP_md") ||
+		getenv("LESS_TERMCAP_us") ||
+		getenv("LESS_TERMCAP_so")) {
+		return;
+	}
+
+	/* Disable groff colors */
+	setenv("GROFF_NO_SGR", "1", 0);
+
+	/* Add red to bold, blue to underline, and magenta to standout */
+	/* No visual information is lost */
+	setenv("LESS", "Dd+r$Du+b$Ds+m", 0);
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
@@ -264,6 +288,7 @@ static void exec_man_man(const char *path, const char *page)
 static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
+	colorize_man();
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
 	warning(_("failed to exec '%s'"), cmd);
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
-- 
2.32.0.rc0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D1C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB19761369
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbhERBDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239943AbhERBDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 21:03:24 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF59C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:02:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u11so8242815oiv.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onuT80Z8rslHHmu52VX7Rihjufi4kIlOBgC6DdjHqtU=;
        b=F71wPCxpPdjfQWNC13z2nWqTRHSTJmmsWUKrH/gTVFNFqPeXt5O6rInvq0S/5WeKh4
         a32soD/ghXh2Xi/CRjGtGCSIoVgF7D+NvVxHzSLJaydiBHzThCqwQh0IcSPjv0JoPaQY
         G0vj4i1NBTTI3zL1gFGzJaYYOzKE4Ph8h5rFU3dBZn7mwXPbE/Z4MkEQ001dEJHE8ry+
         fH1MOPZIAmcKQVdZUwDtG6UvRvHKR2LCh2HCeaVxzbE5mCOkbg9gR21P4uw4Eu6UB5ru
         B5KV5H7nsSUsyHyBuTGaAMc0EuyT5tg73lYMzqe9/OAELmWLrCJcVBxIe3k6jGgKtTuA
         iAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onuT80Z8rslHHmu52VX7Rihjufi4kIlOBgC6DdjHqtU=;
        b=S8kXc5vh9s49TCX3iAksOGoTxgwAeVpKo1hN0e3vqR2bWM815OmwIY/1lqJVwURda2
         jvu/Or7RcOtryEqncHZmzdbh+V6ueu18tBr0MU3fDR0TdtlPVIg5By3OVvqLcYCqsRb1
         Ozz/rnpnYIQxfTD+KqFlFidMvKpHUzqpRdJjJV/oBkKjGg2B3h5yuipFuR+6B7wH0s0K
         PL4hqvxrnVvWp+ytH87B7fWzC5SLwW2utdANcH29/CM+80ur1bFh5JEALgiscnv1FWe7
         Z5CsaA4Vi/0K3NK1n3KvoV8lFDRDRLMtGi3y4ktUlLwQKa8vpbmS2G54biYIQa7TVqXs
         bU0g==
X-Gm-Message-State: AOAM530Wb0lYKSxt2wWrPOWZHOxfmgpjJAe0k366eZrrbReAUYRTJRK2
        sKBIyNb37Rru7/ZDIu7prMbILfObRhw8Tg==
X-Google-Smtp-Source: ABdhPJyrNViKzxd3i/NSNJ2efKgqAkzcOiip9Jcwi1MDgzYamy00kKey5X1eTa7whuKrq4xFnx3m1g==
X-Received: by 2002:aca:1205:: with SMTP id 5mr426767ois.6.1621299725135;
        Mon, 17 May 2021 18:02:05 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x30sm3576539ott.41.2021.05.17.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 18:02:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] help: colorize man pages
Date:   Mon, 17 May 2021 20:01:21 -0500
Message-Id: <20210518010121.1350327-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
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

This only works when the pager is less, and the color.pager
configuration is enabled, as well as color.ui.

[1] https://unix.stackexchange.com/questions/119/colors-in-man-pages/147

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/help.c | 27 ++++++++++++++++++++++++++-
 color.h        |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index bb339f0fc8..0119e833a8 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -11,6 +11,7 @@
 #include "config-list.h"
 #include "help.h"
 #include "alias.h"
+#include "color.h"
 
 #ifndef DEFAULT_HELP_FORMAT
 #define DEFAULT_HELP_FORMAT "man"
@@ -253,10 +254,33 @@ static void exec_man_konqueror(const char *path, const char *page)
 	}
 }
 
+static void colorize_man(void)
+{
+	if (!pager_use_color || !want_color(GIT_COLOR_UNKNOWN))
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
@@ -264,6 +288,7 @@ static void exec_man_man(const char *path, const char *page)
 static void exec_man_cmd(const char *cmd, const char *page)
 {
 	struct strbuf shell_cmd = STRBUF_INIT;
+	colorize_man();
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);
 	warning(_("failed to exec '%s'"), cmd);
@@ -372,7 +397,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "man."))
 		return add_man_viewer_info(var, value);
 
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


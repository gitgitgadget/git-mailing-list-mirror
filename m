Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C60CEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjF0Tx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjF0TxU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D685D2716
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b7fd27e107so12697355ad.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895595; x=1690487595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgO53NfzPnoedZITujD9udrpcJdfIMWANeDb3IGDuBQ=;
        b=AKMUea7BBF90KUBhDSsrXgVympAbQrMZA5UOOwzLssPOuckO4mQIWIRtbDsHLmQU3t
         1UXDGktPdEZ1GKy4CQkkqjw/0YBIPYLFkQpNOCr++qmGlzRGdI6s26jrQfZAYV30YHli
         65Cl0PtUIrgC4uSbSMlHfU9SDLjyolJpdnWqN5ZXkvEEqRHCbMd1MAhrFf3PdoASEtCl
         7iCJQXYMfA3zVfbV4fEdMHAIQu6VfTm3aNBmuSM2Ah+DgKp25TZg8vhS3R+N7c4+h8JD
         J6CPamicT6chg9/g+UGgNe6I5xdq8GEX/nF7yfVhSSHC1qqUNOE7JxuxbWOgo5a4IWVU
         CCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895595; x=1690487595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgO53NfzPnoedZITujD9udrpcJdfIMWANeDb3IGDuBQ=;
        b=agJDm1DDEXngB81FybE+5OMIhPBBWQ61EeI56L10X74g50tU1zvGFmbSEAIXWRXkqv
         PXS3ipoJ7WVkooCSjNbMIMwE7NonU6yB1+djQDYYq95bZWM0cc/Rzq2IZmRfZgtBm3Ct
         4M8UtuR9pBNHnI/LAnrilKVGo/mn/XFC1ekXl7pMY/JNR9ZgK/2d1NhkqCz1bEeUc3T2
         /f6PpkqBlWdV4hqenz0yd7w8aWhrDn3AHFN5sZDi4Z1F7qAAtDkhYtAcZN4YiOnQjX79
         LKyADQH5UbjbO3sdIlsOO18OlV20GEh9vMYIU1K2cXKFVW69ZgdX5lbTzwijNLVWmPDA
         ecbw==
X-Gm-Message-State: AC+VfDyjycETkk9IzRb3+6BOjzsVRE4PgzKmWHzsspeB+XiosFb1d9lg
        xcO4kgCLx1yVzLJqA7tiW3c904L5p69ejr+cQ7kJ/z3wKNaCK7uWBUxSmnj5ZWw+BLpPsnwOKV1
        vMLyMs6hVREmDEiYdL/RgQP9g7ZYQyfAyN5pG4wKtVny0o7cRqi9NIqXolEfW6rwEuQ==
X-Google-Smtp-Source: ACHHUZ7W9lpU/psh6iMlPflz39D5G84QVMz2Ww3DtBfEnPcQzabxqSYoSvqncS9LyrnrGp9CxCKQlb9tB0fYyO0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:f082:b0:1b7:edcd:8dcf with SMTP
 id p2-20020a170902f08200b001b7edcd8dcfmr822075pla.4.1687895595258; Tue, 27
 Jun 2023 12:53:15 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:49 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-7-calvinwan@google.com>
Subject: [RFC PATCH 6/8] pager: remove pager_in_use()
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pager_in_use() is simply a wrapper around
git_env_bool("GIT_PAGER_IN_USE", 0). Other places that call
git_env_bool() in this fashion also do not have a wrapper function
around it. By removing pager_in_use(), we can also get rid of the
pager.h dependency from a few files.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/log.c | 2 +-
 color.c       | 2 +-
 column.c      | 2 +-
 date.c        | 4 ++--
 git.c         | 2 +-
 pager.c       | 5 -----
 pager.h       | 1 -
 7 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 03954fb749..d5e979932f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -82,7 +82,7 @@ struct line_opt_callback_data {
 
 static int session_is_interactive(void)
 {
-	return isatty(1) || pager_in_use();
+	return isatty(1) || git_env_bool("GIT_PAGER_IN_USE", 0);
 }
 
 static int auto_decoration_style(void)
diff --git a/color.c b/color.c
index f3c0a4659b..dd6f26b8db 100644
--- a/color.c
+++ b/color.c
@@ -388,7 +388,7 @@ static int check_auto_color(int fd)
 	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
 	if (*is_tty_p < 0)
 		*is_tty_p = isatty(fd);
-	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
+	if (*is_tty_p || (fd == 1 && git_env_bool("GIT_PAGER_IN_USE", 0) && pager_use_color)) {
 		if (!is_terminal_dumb())
 			return 1;
 	}
diff --git a/column.c b/column.c
index ff2f0abf39..e15ca70f36 100644
--- a/column.c
+++ b/column.c
@@ -214,7 +214,7 @@ int finalize_colopts(unsigned int *colopts, int stdout_is_tty)
 		if (stdout_is_tty < 0)
 			stdout_is_tty = isatty(1);
 		*colopts &= ~COL_ENABLE_MASK;
-		if (stdout_is_tty || pager_in_use())
+		if (stdout_is_tty || git_env_bool("GIT_PAGER_IN_USE", 0))
 			*colopts |= COL_ENABLED;
 	}
 	return 0;
diff --git a/date.c b/date.c
index 619ada5b20..95c0f568ba 100644
--- a/date.c
+++ b/date.c
@@ -7,7 +7,7 @@
 #include "git-compat-util.h"
 #include "date.h"
 #include "gettext.h"
-#include "pager.h"
+#include "parse.h"
 #include "strbuf.h"
 
 /*
@@ -1009,7 +1009,7 @@ void parse_date_format(const char *format, struct date_mode *mode)
 
 	/* "auto:foo" is "if tty/pager, then foo, otherwise normal" */
 	if (skip_prefix(format, "auto:", &p)) {
-		if (isatty(1) || pager_in_use())
+		if (isatty(1) || git_env_bool("GIT_PAGER_IN_USE", 0))
 			format = p;
 		else
 			format = "default";
diff --git a/git.c b/git.c
index eb69f4f997..3bfb673a4c 100644
--- a/git.c
+++ b/git.c
@@ -131,7 +131,7 @@ static void commit_pager_choice(void)
 
 void setup_auto_pager(const char *cmd, int def)
 {
-	if (use_pager != -1 || pager_in_use())
+	if (use_pager != -1 || git_env_bool("GIT_PAGER_IN_USE", 0))
 		return;
 	use_pager = check_pager_config(cmd);
 	if (use_pager == -1)
diff --git a/pager.c b/pager.c
index 63055d0873..9b392622d2 100644
--- a/pager.c
+++ b/pager.c
@@ -149,11 +149,6 @@ void setup_pager(void)
 	atexit(wait_for_pager_atexit);
 }
 
-int pager_in_use(void)
-{
-	return git_env_bool("GIT_PAGER_IN_USE", 0);
-}
-
 /*
  * Return cached value (if set) or $COLUMNS environment variable (if
  * set and positive) or ioctl(1, TIOCGWINSZ).ws_col (if positive),
diff --git a/pager.h b/pager.h
index b77433026d..6832c6168d 100644
--- a/pager.h
+++ b/pager.h
@@ -5,7 +5,6 @@ struct child_process;
 
 const char *git_pager(int stdout_is_tty);
 void setup_pager(void);
-int pager_in_use(void);
 int term_columns(void);
 void term_clear_line(void);
 int decimal_width(uintmax_t);
-- 
2.41.0.162.gfafddb0af9-goog


Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101EAC2BB55
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DBA206C1
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 18:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFHNXo0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJSQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:16:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46266 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJSQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 14:16:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id w4so1683593edv.13
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4VdSKBwiTSvZ50JMkWnnh+Qy/QCg98ea6LSHueBdTlg=;
        b=SFHNXo0GxjZV1fn2ipbTK6jLGP/wHDY/k6Nk8qGzOfevwOQNL/VCsZjaTGQeLHWQva
         7seAHQIoGnUYCBHrOroPsY3awKsl8+uoQIHnVGAGd6tHjfHFeq2pDmRPuy+dsqmttwCo
         +dSmu1QAsRG9inTJk2HsQv68IUmRyLn0SIYbh0jkLqMpURGn0m2v77EygopEVyzm95pc
         yVxN0tnVuH2Z9E3BHur8CJxa4ZrT1vk2ZBEjdygRJgM5sHAuww+qYZPQIJt0VNYGSaYm
         CAox5TRvq83HH6kQ1SuCzO58vmwMKpRvmcE4UUOmJcQD/pb69Xen/N4awmqLBlo0nn0v
         vsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4VdSKBwiTSvZ50JMkWnnh+Qy/QCg98ea6LSHueBdTlg=;
        b=UAIcUtFxM5cLI2ND/k7aT2K3qbARTyd4SU/lNzo2F16O02cvuTObQiC3fWETWV70p4
         I+j2fTgubV2vvHCzk9W8p1r4TzfITCqc+fiHEn3kgTzPFBKDiX+EhLUMSIPt6/My/KD9
         I+1SiQI2VE3y/zYcEVDHnHqeOU1/kzwKIEIaiK3rfcFFjINlydFqFxzVrDhf+fwTXaGF
         jjk0d3H3FyhuphA82EqoDn5AeQmWFgvE5taBQYrIFvZx2xdR/Vt4C8SDUg54hq2JwFbt
         5sUKOGeCGVLeEs8QvxjWrGaFpfApBsg10D26n5PnVFLyTLnaPHqIhjclEndoyMrIhith
         4Lcw==
X-Gm-Message-State: AGi0Pubz7O45oNE6dUrf2uDk6GhhTQdTd//gDav8bEL+bJBSJ0QTf03Z
        jzQAsqTC7WYXw8LMpOCVuMUFCxOo
X-Google-Smtp-Source: APiQypLVev8STi68KqgTS9SdeTZ1EaoM0eWDEW3yYlcGTsqFkWS3mm/REqoWVVavGyElvVnq0FnXdw==
X-Received: by 2002:aa7:c309:: with SMTP id l9mr2096118edq.6.1586542616683;
        Fri, 10 Apr 2020 11:16:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s29sm166355edc.25.2020.04.10.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 11:16:56 -0700 (PDT)
Message-Id: <072f95090aef69d7bdb2f270aea9d88ca27f68b1.1586542614.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.755.v3.git.git.1586542614.gitgitgadget@gmail.com>
References: <pull.755.v2.git.git.1586518072.gitgitgadget@gmail.com>
        <pull.755.v3.git.git.1586542614.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 18:16:53 +0000
Subject: [PATCH v3 1/2] Refactor code asking the user for input interactively
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are quite a few code locations (e.g. `git clean --interactive`)
where Git asks the user for an answer. In preparation for fixing a bug
shared by all of them, and also to DRY up the code, let's refactor it.

Please note that most of these callers trimmed white-space both at the
beginning and at the end of the answer, instead of trimming only the
end (as the caller in `add-patch.c` does).

Therefore, technically speaking, we change behavior in this patch. At
the same time, it can be argued that this is actually a bug fix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |  4 ++--
 add-patch.c       |  4 ++--
 builtin/clean.c   | 14 ++++----------
 prompt.c          | 10 ++++++++++
 prompt.h          |  2 ++
 shell.c           |  4 ++--
 6 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 4a9bf85cac0..29cd2fe0201 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -9,6 +9,7 @@
 #include "lockfile.h"
 #include "dir.h"
 #include "run-command.h"
+#include "prompt.h"
 
 static void init_color(struct repository *r, struct add_i_state *s,
 		       const char *slot_name, char *dst,
@@ -289,13 +290,12 @@ static ssize_t list_and_choose(struct add_i_state *s,
 		fputs(singleton ? "> " : ">> ", stdout);
 		fflush(stdout);
 
-		if (strbuf_getline(&input, stdin) == EOF) {
+		if (git_read_line_interactively(&input) == EOF) {
 			putchar('\n');
 			if (immediate)
 				res = LIST_AND_CHOOSE_QUIT;
 			break;
 		}
-		strbuf_trim(&input);
 
 		if (!input.len)
 			break;
diff --git a/add-patch.c b/add-patch.c
index d8dafa8168d..d8bfe379be4 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -7,6 +7,7 @@
 #include "color.h"
 #include "diff.h"
 #include "compat/terminal.h"
+#include "prompt.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
@@ -1158,9 +1159,8 @@ static int read_single_character(struct add_p_state *s)
 		return res;
 	}
 
-	if (strbuf_getline(&s->answer, stdin) == EOF)
+	if (git_read_line_interactively(&s->answer) == EOF)
 		return EOF;
-	strbuf_trim_trailing_newline(&s->answer);
 	return 0;
 }
 
diff --git a/builtin/clean.c b/builtin/clean.c
index 5abf087e7c4..c8c011d2ddf 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -18,6 +18,7 @@
 #include "color.h"
 #include "pathspec.h"
 #include "help.h"
+#include "prompt.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -420,7 +421,6 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
 	return found;
 }
 
-
 /*
  * Parse user input, and return choice(s) for menu (menu_stuff).
  *
@@ -580,9 +580,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 
-		if (strbuf_getline_lf(&choice, stdin) != EOF) {
-			strbuf_trim(&choice);
-		} else {
+		if (git_read_line_interactively(&choice) == EOF) {
 			eof = 1;
 			break;
 		}
@@ -662,9 +660,7 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline_lf(&confirm, stdin) != EOF)
-			strbuf_trim(&confirm);
-		else
+		if (git_read_line_interactively(&confirm) == EOF)
 			putchar('\n');
 
 		/* quit filter_by_pattern mode if press ENTER or Ctrl-D */
@@ -760,9 +756,7 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
-			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
-				strbuf_trim(&confirm);
-			} else {
+			if (git_read_line_interactively(&confirm) == EOF) {
 				putchar('\n');
 				eof = 1;
 			}
diff --git a/prompt.c b/prompt.c
index 6d5885d0096..098dcfb7cf9 100644
--- a/prompt.c
+++ b/prompt.c
@@ -74,3 +74,13 @@ char *git_prompt(const char *prompt, int flags)
 	}
 	return r;
 }
+
+int git_read_line_interactively(struct strbuf *line)
+{
+	int ret = strbuf_getline_lf(line, stdin);
+
+	if (ret != EOF)
+		strbuf_trim_trailing_newline(line);
+
+	return ret;
+}
diff --git a/prompt.h b/prompt.h
index e04cced030c..e294e93541c 100644
--- a/prompt.h
+++ b/prompt.h
@@ -6,4 +6,6 @@
 
 char *git_prompt(const char *prompt, int flags);
 
+int git_read_line_interactively(struct strbuf *line);
+
 #endif /* PROMPT_H */
diff --git a/shell.c b/shell.c
index 54cca7439de..cef7ffdc9e1 100644
--- a/shell.c
+++ b/shell.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "alias.h"
+#include "prompt.h"
 
 #define COMMAND_DIR "git-shell-commands"
 #define HELP_COMMAND COMMAND_DIR "/help"
@@ -76,12 +77,11 @@ static void run_shell(void)
 		int count;
 
 		fprintf(stderr, "git> ");
-		if (strbuf_getline_lf(&line, stdin) == EOF) {
+		if (git_read_line_interactively(&line) == EOF) {
 			fprintf(stderr, "\n");
 			strbuf_release(&line);
 			break;
 		}
-		strbuf_trim(&line);
 		rawargs = strbuf_detach(&line, NULL);
 		split_args = xstrdup(rawargs);
 		count = split_cmdline(split_args, &argv);
-- 
gitgitgadget


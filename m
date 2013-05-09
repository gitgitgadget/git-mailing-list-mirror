From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 02/12] git-clean: add support for -i/--interactive
Date: Fri, 10 May 2013 01:14:06 +0800
Message-ID: <708200939d6360b9d0161670fd2449715f9b4fbf.1368118918.git.worldhello.net@gmail.com>
References: <cover.1368118918.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQY-0002ba-Bo
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab3EIROl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:14:41 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45474 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3EIROk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:14:40 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so2099041pbb.8
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=KlNtptdtqjeK5GbEJQoWxINlv+B/1J4xc3B2QE3gm+g=;
        b=QK/gJnhZy7Ml0QnVMRjz7viP6oyvwV40AXThVGTe4gwl9792G5uMaDyDmszKQCuELk
         neKScEn/2GV0mUpjKXfio7o4NmOwptNnsihp7M9LA7bFmSSofAxcfPCjHjweAx/P8q0o
         bY6lwdzRGroDhQrCb3tTTxQONWnoVSBt2Wh+OhIXNoWQ7sjZhKg9qJBDznBr1BVSULVl
         jn2VpNbIL8QWHK0d5RskiaTrrfJYsPdPWhunhFz46pP+vC0L3MJW4272omND0A2xx/4f
         YmNDPq1SAvTrq/lUioU0/c4DAWkMFrTZgdRmQ4U4rlF8/ntpcctwybnkI+wUkGnBeJsL
         K1vA==
X-Received: by 10.66.177.177 with SMTP id cr17mr13834207pac.212.1368119678898;
        Thu, 09 May 2013 10:14:38 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com> <cover.1368118918.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223751>

Show what would be done and the user must confirm before actually
cleaning.

    Would remove ...
    Would remove ...
    Would remove ...

    Remove (y/n) ?

Press "y" to start cleaning, and press "n" if you want to abort.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/git-clean.txt | 10 ++++++--
 builtin/clean.c             | 61 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index bdc3a..186e34 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -34,7 +34,13 @@ OPTIONS
 -f::
 --force::
 	If the Git configuration variable clean.requireForce is not set
-	to false, 'git clean' will refuse to run unless given -f or -n.
+	to false, 'git clean' will refuse to run unless given -f, -n or
+	-i.
+
+-i::
+--interactive::
+	Show what would be done and the user must confirm before actually
+	cleaning.
 
 -n::
 --dry-run::
diff --git a/builtin/clean.c b/builtin/clean.c
index ccd4..2f9b9 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -15,10 +15,11 @@
 #include "quote.h"
 
 static int force = -1; /* unset */
+static int interactive;
 static struct string_list del_list = STRING_LIST_INIT_DUP;
 
 static const char *const builtin_clean_usage[] = {
-	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
+	N_("git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>..."),
 	NULL
 };
 
@@ -185,6 +186,50 @@ static const char *path_relative(const char *in, const char *prefix)
 	return buf;
 }
 
+static void interactive_main_loop(void)
+{
+	struct strbuf confirm = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	const char *qname;
+
+	while (del_list.nr) {
+		putchar('\n');
+		for_each_string_list_item(item, &del_list) {
+			qname = quote_path_relative(item->string, -1, &buf, NULL);
+			printf(_(msg_would_remove), qname);
+		}
+		putchar('\n');
+
+		printf(_("Remove (y/n) ? "));
+		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
+			strbuf_trim(&confirm);
+		} else {
+			/* Ctrl-D is the same as "quit" */
+			string_list_clear(&del_list, 0);
+			putchar('\n');
+			printf_ln("Bye.");
+			break;
+		}
+
+		if (confirm.len) {
+			if (!strncasecmp(confirm.buf, "yes", confirm.len)) {
+				break;
+			} else if (!strncasecmp(confirm.buf, "no", confirm.len) ||
+				   !strncasecmp(confirm.buf, "quit", confirm.len)) {
+				string_list_clear(&del_list, 0);
+				printf_ln("Bye.");
+				break;
+			} else {
+				continue;
+			}
+		}
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&confirm);
+}
+
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
 	int i, res;
@@ -204,6 +249,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
+		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
@@ -230,12 +276,16 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (ignored && ignored_only)
 		die(_("-x and -X cannot be used together"));
 
-	if (!dry_run && !force) {
+	if (interactive) {
+		if (!isatty(0) || !isatty(1))
+			die(_("interactive clean can not run without a valid tty; "
+				  "refusing to clean"));
+	} else if (!dry_run && !force) {
 		if (config_set)
-			die(_("clean.requireForce set to true and neither -n nor -f given; "
+			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 		else
-			die(_("clean.requireForce defaults to true and neither -n nor -f given; "
+			die(_("clean.requireForce defaults to true and neither -i, -n nor -f given; "
 				  "refusing to clean"));
 	}
 
@@ -309,7 +359,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* TODO: do interactive git-clean here, which will modify del_list */
+	if (interactive && !dry_run && del_list.nr > 0)
+		interactive_main_loop();
 
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
-- 
1.8.3.rc1.341.g24a8a0f

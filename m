From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v11 09/15] git-clean: add colors to interactive git-clean
Date: Fri, 17 May 2013 17:20:13 +0800
Message-ID: <fd4ad61c3bc7c1d059ed8f25ca0418cb86c437e3.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 11:21:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdGqg-0006aN-FE
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 11:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab3EQJU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 05:20:56 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:51244 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3EQJUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 05:20:53 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so3163152pdj.12
        for <git@vger.kernel.org>; Fri, 17 May 2013 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=JcYt08pxwaSbuSqKFH8wGSpbpKaTh10gOt0qgiy+NXQ=;
        b=uJL7hxU0MdV2hMQrYEd323Tj08ClgJQXFrtuF5frdinMRFhoBwjAPIsJXnxfghnaPh
         O47y1ynmZw5RTUR/M5WDBN6EudWjiW77cXnu25vWL5T2W/0WVpdUofLQVFG1zu3BHkfk
         /od6p4fiTmaCPSc1/+8H76NVwZdugTpDjNW9kavIXi9AEU0wpja/7cpPHETpFQMwYVEQ
         ZqHaGYR69F/6hpH94TlvT7TanJ2RfdGFGMKhO8ADw9DROAfSiFCQQ7RoyQVhjlTtZMk/
         ZqPMsosxENBuvF9PFl2UhOQsLpxGyVvkxqrPp6C0O50kEy+BzZ5o8KYbKx1n7e3CXpag
         zPmQ==
X-Received: by 10.68.244.5 with SMTP id xc5mr47928944pbc.66.1368782453463;
        Fri, 17 May 2013 02:20:53 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id 10sm10531002pbm.0.2013.05.17.02.20.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 02:20:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.380.g956c2b2
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368782129.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224676>

Show header, help, error messages, and prompt in colors for interactive
git-clean. Re-use config variables, such as "color.interactive" and
"color.interactive.<slot>" for command `git-add--interactive`.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Comments-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt | 17 +++++------
 builtin/clean.c          | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e031b..83613 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -876,16 +876,17 @@ The values of these variables may be specified as in color.branch.<slot>.
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
-	and displays (such as those used by "git-add --interactive").
-	When false (or `never`), never.  When set to `true` or `auto`, use
-	colors only when the output is to the terminal. Defaults to false.
+	and displays (such as those used by "git-add --interactive" and
+	"git-clean --interactive"). When false (or `never`), never.
+	When set to `true` or `auto`, use colors only when the output is
+	to the terminal. Defaults to false.
 
 color.interactive.<slot>::
-	Use customized color for 'git add --interactive'
-	output. `<slot>` may be `prompt`, `header`, `help` or `error`, for
-	four distinct types of normal output from interactive
-	commands.  The values of these variables may be specified as
-	in color.branch.<slot>.
+	Use customized color for 'git add --interactive' and 'git clean
+	--interactive' output. `<slot>` may be `prompt`, `header`, `help`
+	or `error`, for four distinct types of normal output from
+	interactive commands.  The values of these variables may be
+	specified as in color.branch.<slot>.
 
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
diff --git a/builtin/clean.c b/builtin/clean.c
index f25ba..0778a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -31,16 +32,82 @@ static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 
+static int clean_use_color = -1;
+static char clean_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_BOLD_BLUE,	/* PROMPT */
+	GIT_COLOR_BOLD,		/* HEADER */
+	GIT_COLOR_BOLD_RED,	/* HELP */
+	GIT_COLOR_BOLD_RED,	/* ERROR */
+};
+enum color_clean {
+	CLEAN_COLOR_RESET = 0,
+	CLEAN_COLOR_PLAIN = 1,
+	CLEAN_COLOR_PROMPT = 2,
+	CLEAN_COLOR_HEADER = 3,
+	CLEAN_COLOR_HELP = 4,
+	CLEAN_COLOR_ERROR = 5,
+};
+
+static int parse_clean_color_slot(const char *var)
+{
+	if (!strcasecmp(var, "reset"))
+		return CLEAN_COLOR_RESET;
+	if (!strcasecmp(var, "plain"))
+		return CLEAN_COLOR_PLAIN;
+	if (!strcasecmp(var, "prompt"))
+		return CLEAN_COLOR_PROMPT;
+	if (!strcasecmp(var, "header"))
+		return CLEAN_COLOR_HEADER;
+	if (!strcasecmp(var, "help"))
+		return CLEAN_COLOR_HELP;
+	if (!strcasecmp(var, "error"))
+		return CLEAN_COLOR_ERROR;
+	return -1;
+}
+
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	if (!prefixcmp(var, "column."))
 		return git_column_config(var, value, "clean", &colopts);
 
+	/* honors the color.interactive* config variables which also
+	   applied in git-add--interactive and git-stash */
+	if (!strcmp(var, "color.interactive")) {
+		clean_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+	if (!prefixcmp(var, "color.interactive.")) {
+		int slot = parse_clean_color_slot(var +
+						  strlen("color.interactive."));
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		color_parse(value, var, clean_colors[slot]);
+		return 0;
+	}
+
 	if (!strcmp(var, "clean.requireforce")) {
 		force = !git_config_bool(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+
+	/* inspect the color.ui config variable and others */
+	return git_color_default_config(var, value, cb);
+}
+
+static const char *clean_get_color(enum color_clean ix)
+{
+	if (want_color(clean_use_color))
+		return clean_colors[ix];
+	return "";
+}
+
+static void clean_print_color(enum color_clean ix)
+{
+	printf("%s", clean_get_color(ix));
 }
 
 static int exclude_cb(const struct option *opt, const char *arg, int unset)
@@ -184,14 +251,18 @@ static void interactive_main_loop(void)
 
 	while (del_list.nr) {
 		putchar('\n');
+		clean_print_color(CLEAN_COLOR_HEADER);
 		printf_ln(Q_("Would remove the following item:",
 			     "Would remove the following items:",
 			     del_list.nr));
+		clean_print_color(CLEAN_COLOR_RESET);
 		putchar('\n');
 
 		pretty_print_dels();
 
+		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Remove [y/n]? "));
+		clean_print_color(CLEAN_COLOR_RESET);
 		if (strbuf_getline(&confirm, stdin, '\n') != EOF) {
 			strbuf_trim(&confirm);
 		} else {
-- 
1.8.3.rc2.380.g956c2b2

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 05/11] i18n: help: mark strings for translation
Date: Mon, 16 Apr 2012 19:49:57 +0700
Message-ID: <1334580603-11577-6-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlPN-0006vi-Ci
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab2DPMvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:51:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52864 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2DPMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:51:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so6309124pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xZ/Qlcg4AyKupLkLHKfmE2XMsUHBy6Q6zt252FJR1ok=;
        b=LSfO28/IuyJKuVz2yQ2Izd9UHZUcMNhLL0tmYrbDPxmBTYTBO+F1xc0gQJdQ32gkX8
         1mqjnRzcnMScVBIjAV05vjcb8liy6NQU2tZb/2kqPEVjo5+W4vKf7ogfuj3guBApL5Sw
         knrR8oAFhXIOUHuc8bhEPDYdEYbYfx6rwYjSY702J8OnZqckl6/GHfIGmF2dZOakfEKY
         yeDvtYM7/xtkSafZ5z8GlLdwLi1sWP5ks7sDIBkZ7rrXHLvVZQ8IhM85TnlPmFVfqiyZ
         m4kM+lSfvteB1SWwrFhi/NDAYRGhsGflBW9ZZKphxD40dCBIE7A/ugwF9FdAnGGj1AUt
         ZfHA==
Received: by 10.68.221.35 with SMTP id qb3mr27562651pbc.136.1334580707705;
        Mon, 16 Apr 2012 05:51:47 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id k9sm17624056pbf.65.2012.04.16.05.51.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:51:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:50:56 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195628>

This patch also marks most common commands' synopsis for translation
so that "git help" gives a friendly listing.
---
 Makefile            |    2 +-
 builtin/help.c      |   48 ++++++++++++++++++++++++------------------------
 generate-cmdlist.sh |    2 +-
 git.c               |    2 +-
 help.c              |   34 +++++++++++++++++++++-------------
 5 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/Makefile b/Makefile
index be1957a..34cf971 100644
--- a/Makefile
+++ b/Makefile
@@ -2282,7 +2282,7 @@ XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
 XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
-LOCALIZED_C := $(C_OBJ:o=c)
+LOCALIZED_C := $(C_OBJ:o=c) common-cmds.h
 LOCALIZED_SH := $(SCRIPT_SH)
 LOCALIZED_PERL := $(SCRIPT_PERL)
 
diff --git a/builtin/help.c b/builtin/help.c
index 22756bd..ab6bbf4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -54,7 +54,7 @@ static enum help_format parse_help_format(const char *format)
 		return HELP_FORMAT_INFO;
 	if (!strcmp(format, "web") || !strcmp(format, "html"))
 		return HELP_FORMAT_WEB;
-	die("unrecognized help format '%s'", format);
+	die(_("unrecognized help format '%s'"), format);
 }
 
 static const char *get_man_viewer_info(const char *name)
@@ -82,7 +82,7 @@ static int check_emacsclient_version(void)
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
 	if (start_command(&ec_process))
-		return error("Failed to start emacsclient.");
+		return error(_("Failed to start emacsclient."));
 
 	strbuf_read(&buffer, ec_process.err, 20);
 	close(ec_process.err);
@@ -95,7 +95,7 @@ static int check_emacsclient_version(void)
 
 	if (prefixcmp(buffer.buf, "emacsclient")) {
 		strbuf_release(&buffer);
-		return error("Failed to parse emacsclient version.");
+		return error(_("Failed to parse emacsclient version."));
 	}
 
 	strbuf_remove(&buffer, 0, strlen("emacsclient"));
@@ -103,7 +103,7 @@ static int check_emacsclient_version(void)
 
 	if (version < 22) {
 		strbuf_release(&buffer);
-		return error("emacsclient version '%d' too old (< 22).",
+		return error(_("emacsclient version '%d' too old (< 22)."),
 			version);
 	}
 
@@ -121,7 +121,7 @@ static void exec_woman_emacs(const char *path, const char *page)
 			path = "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
 		execlp(path, "emacsclient", "-e", man_page.buf, (char *)NULL);
-		warning("failed to exec '%s': %s", path, strerror(errno));
+		warning(_("failed to exec '%s': %s"), path, strerror(errno));
 	}
 }
 
@@ -149,7 +149,7 @@ static void exec_man_konqueror(const char *path, const char *page)
 			path = "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
 		execlp(path, filename, "newTab", man_page.buf, (char *)NULL);
-		warning("failed to exec '%s': %s", path, strerror(errno));
+		warning(_("failed to exec '%s': %s"), path, strerror(errno));
 	}
 }
 
@@ -158,7 +158,7 @@ static void exec_man_man(const char *path, const char *page)
 	if (!path)
 		path = "man";
 	execlp(path, "man", page, (char *)NULL);
-	warning("failed to exec '%s': %s", path, strerror(errno));
+	warning(_("failed to exec '%s': %s"), path, strerror(errno));
 }
 
 static void exec_man_cmd(const char *cmd, const char *page)
@@ -166,7 +166,7 @@ static void exec_man_cmd(const char *cmd, const char *page)
 	struct strbuf shell_cmd = STRBUF_INIT;
 	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
 	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
-	warning("failed to exec '%s': %s", cmd, strerror(errno));
+	warning(_("failed to exec '%s': %s"), cmd, strerror(errno));
 }
 
 static void add_man_viewer(const char *name)
@@ -206,8 +206,8 @@ static int add_man_viewer_path(const char *name,
 	if (supported_man_viewer(name, len))
 		do_add_man_viewer_info(name, len, value);
 	else
-		warning("'%s': path for unsupported man viewer.\n"
-			"Please consider using 'man.<tool>.cmd' instead.",
+		warning(_("'%s': path for unsupported man viewer.\n"
+			  "Please consider using 'man.<tool>.cmd' instead."),
 			name);
 
 	return 0;
@@ -218,8 +218,8 @@ static int add_man_viewer_cmd(const char *name,
 			      const char *value)
 {
 	if (supported_man_viewer(name, len))
-		warning("'%s': cmd for supported man viewer.\n"
-			"Please consider using 'man.<tool>.path' instead.",
+		warning(_("'%s': cmd for supported man viewer.\n"
+			  "Please consider using 'man.<tool>.path' instead."),
 			name);
 	else
 		do_add_man_viewer_info(name, len, value);
@@ -280,11 +280,11 @@ void list_common_cmds_help(void)
 			longest = strlen(common_cmds[i].name);
 	}
 
-	puts("The most commonly used git commands are:");
+	puts(_("The most commonly used git commands are:"));
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
 		printf("   %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
+		puts(_(common_cmds[i].help));
 	}
 }
 
@@ -348,7 +348,7 @@ static void exec_viewer(const char *name, const char *page)
 	else if (info)
 		exec_man_cmd(info, page);
 	else
-		warning("'%s': unknown man viewer.", name);
+		warning(_("'%s': unknown man viewer."), name);
 }
 
 static void show_man_page(const char *git_cmd)
@@ -365,7 +365,7 @@ static void show_man_page(const char *git_cmd)
 	if (fallback)
 		exec_viewer(fallback, page);
 	exec_viewer("man", page);
-	die("no man viewer handled the request");
+	die(_("no man viewer handled the request"));
 }
 
 static void show_info_page(const char *git_cmd)
@@ -373,7 +373,7 @@ static void show_info_page(const char *git_cmd)
 	const char *page = cmd_to_page(git_cmd);
 	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
 	execlp("info", "info", "gitman", page, (char *)NULL);
-	die("no info viewer handled the request");
+	die(_("no info viewer handled the request"));
 }
 
 static void get_html_page_path(struct strbuf *page_path, const char *page)
@@ -384,7 +384,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	/* Check that we have a git documentation directory. */
 	if (stat(mkpath("%s/git.html", html_path), &st)
 	    || !S_ISREG(st.st_mode))
-		die("'%s': not a documentation directory.", html_path);
+		die(_("'%s': not a documentation directory."), html_path);
 
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
@@ -424,16 +424,16 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	parsed_help_format = help_format;
 
 	if (show_all) {
-		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", &main_cmds, &other_cmds);
-		printf("%s\n", git_more_info_string);
+		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
+		list_commands(_("git commands"), &main_cmds, &other_cmds);
+		printf("%s\n", _(git_more_info_string));
 		return 0;
 	}
 
 	if (!argv[0]) {
-		printf("usage: %s\n\n", git_usage_string);
+		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
-		printf("\n%s\n", git_more_info_string);
+		printf("\n%s\n", _(git_more_info_string));
 		return 0;
 	}
 
@@ -445,7 +445,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	alias = alias_lookup(argv[0]);
 	if (alias && !is_git_command(argv[0])) {
-		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
+		printf_ln(_("`git %s' is aliased to `%s'"), argv[0], alias);
 		return 0;
 	}
 
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 1093ef4..9a4c9b9 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -16,7 +16,7 @@ do
      /^NAME/,/git-'"$cmd"'/H
      ${
 	    x
-	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
+	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", N_("\1")},/
 	    p
      }' "Documentation/git-$cmd.txt"
 done
diff --git a/git.c b/git.c
index 3805616..4486deb 100644
--- a/git.c
+++ b/git.c
@@ -13,7 +13,7 @@ const char git_usage_string[] =
 	"           <command> [<args>]";
 
 const char git_more_info_string[] =
-	"See 'git help <command>' for more information on a specific command.";
+	N_("See 'git help <command>' for more information on a specific command.");
 
 static struct startup_info git_startup_info;
 static int use_pager = -1;
diff --git a/help.c b/help.c
index 14eefc9..462e83b 100644
--- a/help.c
+++ b/help.c
@@ -217,8 +217,9 @@ void list_commands(const char *title, struct cmdnames *main_cmds,
 
 	if (main_cmds->cnt) {
 		const char *exec_path = git_exec_path();
-		printf("available %s in '%s'\n", title, exec_path);
-		printf("----------------");
+		printf_ln(_("available %s in '%s'"), title, exec_path);
+		/* TRANSLATORS: this must align with "available %s in '%s'" */
+		printf(_("----------------"));
 		mput_char('-', strlen(title) + strlen(exec_path));
 		putchar('\n');
 		pretty_print_string_list(main_cmds, longest);
@@ -226,8 +227,12 @@ void list_commands(const char *title, struct cmdnames *main_cmds,
 	}
 
 	if (other_cmds->cnt) {
-		printf("%s available from elsewhere on your $PATH\n", title);
-		printf("---------------------------------------");
+		printf_ln(_("%s available from elsewhere on your $PATH"), title);
+		/* TRANSLATORS:
+		 * this must align with
+		 * "%s available from elsewhere on your $PATH"
+		 */
+		printf(_("---------------------------------------"));
 		mput_char('-', strlen(title));
 		putchar('\n');
 		pretty_print_string_list(other_cmds, longest);
@@ -341,7 +346,7 @@ const char *help_unknown_cmd(const char *cmd)
 	      sizeof(*main_cmds.names), levenshtein_compare);
 
 	if (!main_cmds.cnt)
-		die ("Uh oh. Your system reports no Git commands at all.");
+		die(_("Uh oh. Your system reports no Git commands at all."));
 
 	/* skip and count prefix matches */
 	for (n = 0; n < main_cmds.cnt && !main_cmds.names[n]->len; n++)
@@ -362,23 +367,26 @@ const char *help_unknown_cmd(const char *cmd)
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
-		fprintf(stderr, "WARNING: You called a Git command named '%s', "
-			"which does not exist.\n"
-			"Continuing under the assumption that you meant '%s'\n",
+		fprintf_ln(stderr,
+			   _("WARNING: You called a Git command named '%s', "
+			     "which does not exist.\n"
+			     "Continuing under the assumption that you meant '%s'"),
 			cmd, assumed);
 		if (autocorrect > 0) {
-			fprintf(stderr, "in %0.1f seconds automatically...\n",
+			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
 				(float)autocorrect/10.0);
 			poll(NULL, 0, autocorrect * 100);
 		}
 		return assumed;
 	}
 
-	fprintf(stderr, "git: '%s' is not a git command. See 'git --help'.\n", cmd);
+	fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 
 	if (SIMILAR_ENOUGH(best_similarity)) {
-		fprintf(stderr, "\nDid you mean %s?\n",
-			n < 2 ? "this": "one of these");
+		fprintf_ln(stderr,
+			   Q_("\nDid you mean this?",
+			      "\nDid you mean one of these?",
+			   n));
 
 		for (i = 0; i < n; i++)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
@@ -389,6 +397,6 @@ const char *help_unknown_cmd(const char *cmd)
 
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
-	printf("git version %s\n", git_version_string);
+	printf_ln(_("git version %s"), git_version_string);
 	return 0;
 }
-- 
1.7.3.1.256.g2539c.dirty

From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: [PATCH 1/2] Show html help with git-help --html
Date: Sat, 9 Jun 2007 11:03:22 -0400
Message-ID: <20070609150322.GB9316@localhost.myhome.westell.com>
References: <20070605183420.GA8450@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Lichtenheld <frank@lichtenheld.de>, junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 17:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx2TF-0007Tm-O1
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 17:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbXFIPDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Jun 2007 11:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXFIPDQ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 11:03:16 -0400
Received: from ag-out-0708.google.com ([72.14.246.245]:13667 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbXFIPDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 11:03:15 -0400
Received: by ag-out-0708.google.com with SMTP id 35so1019562aga
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 08:03:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=F2NvPWR8jVPyeJWBBXPHs+ebwolZJECvwqpNS1jfTrDgzbNd+ongboeCO0EPRrdZF56NyLVEPNZSJIc2A40mjCez3orWSO+IoHzs3D5H/YBKjLyZBwqPWgyZs5HeCBYbW+SLgTqU6/KIAyKL2GGD/rpgOLPDMMu4B83m0RJLFEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=SKS5U5qjXhInOwONyNUMU02wGhWj6HZ8Hj3sykYEKabWpNlVJlW4LLrpkZFIwYNbK56dbjauZgx9l00bhgd5mG5fk54JLC2RzPB0c/EB/OpMeULv7yk0TDBvnhE4dfydjDdsVYfgg8CKO1Db6KrUCkTP/4bW8MfEWNsjgRGt9Mc=
Received: by 10.90.120.13 with SMTP id s13mr2821983agc.1181401394334;
        Sat, 09 Jun 2007 08:03:14 -0700 (PDT)
Received: from pclouds@gmail.com ( [71.124.249.183])
        by mx.google.com with ESMTP id 21sm4699883agb.2007.06.09.08.03.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jun 2007 08:03:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat,  9 Jun 2007 11:03:22 -0400
Content-Disposition: inline
In-Reply-To: <20070605183420.GA8450@localhost>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49575>

This patch was inspired by ClearCase command 'ct man', which
opens an html help file on Windows. I at first attempted to
implement it for MinGW port only but found it so useful that I
wanted to have it even in Linux.

A new option '--html' is added to git. When git-help is called
with --html, it will try to open an html file located at
$(docdir)/html using xdg-open. HTML files are not installed
by default so users have to install them manually or have their
distributors to do that.

There are two new config options introduced in this patch. The
first is core.help. It has one of three values: html, auto or
man. 'html' has the same effect as git-help --html. 'auto'
will in addition fall back to man pages if possible. 'man'
is 'I hate html, give me my man pages'.  The second option is
core.htmlviewer, used to specify the program you want to
open html files instead of xdg-open. You can override the default
program by appending HTML_VIEWER=3Dblah when calling make.
core.htmlviewer can contain %p, %f or %b.  If none is given,
%p will be appended.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This patch changes core.htmlprogram to core.htmlviewer and
 mentions 'man' as default value for core.help as suggested
 by Frank.
 It also fixes a bug ignoring the remaining string after the
 last %x in html command


 Documentation/config.txt |   16 +++++
 Documentation/git.txt    |    5 +-
 Makefile                 |    5 +-
 cache.h                  |    2 +
 config.c                 |   17 +++++
 config.mak.in            |    2 +
 environment.c            |    2 +
 git.c                    |    2 +-
 help.c                   |  161 ++++++++++++++++++++++++++++++++++++++=
+++++++-
 9 files changed, 207 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index de408b6..2489b8e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -262,6 +262,22 @@ core.excludeFile::
 	of files which are not meant to be tracked.  See
 	gitlink:gitignore[5].
=20
+core.help::
+	If 'html', it is equivalent to 'git-help' with option --html.
+	If 'auto', it tries to open html files first. If that attempt fails
+	(the html program does not exist or the program return non-zero
+	value), then it will fall back to man pages. If 'man', always use
+	man pages as usual. Default is 'man'.
+
+core.htmlviewer::
+	Specify the program used to open html help files when 'git-help'
+	is called with option --html or core.help is other than 'man'.
+	By default, xdg-open will be used.
+	Special strings '%p', '%f' and '%b' will be replaced with html
+	full path, file name and git command (without .html suffix)
+	respectively. If none is given, '%p' will be automatically appended
+	to the command line.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last =3D cat-file commit HEAD", the invocation
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ba077c3..f1df402 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git' [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate]
-    [--bare] [--git-dir=3DGIT_DIR] [--help] COMMAND [ARGS]
+    [--bare] [--git-dir=3DGIT_DIR] [--help [--html]] COMMAND [ARGS]
=20
 DESCRIPTION
 -----------
@@ -87,6 +87,9 @@ OPTIONS
 	commands.  If a git command is named this option will bring up
 	the man-page for that command. If the option '--all' or '-a' is
 	given then all available commands are printed.
+	If option '--html' is given, try opening html files instead of
+	using 'man'. The default program to open html files is xdg-open.
+	See 'git-config' to know how to change html program.
=20
 --exec-path::
 	Path to wherever your core git programs are installed.
diff --git a/Makefile b/Makefile
index 0f75955..7b3180a 100644
--- a/Makefile
+++ b/Makefile
@@ -186,6 +186,7 @@ export TCL_PATH TCLTK_PATH
 # explicitly what architecture to check for. Fix this up for yours..
 SPARSE_FLAGS =3D -D__BIG_ENDIAN__ -D__powerpc__
=20
+HTML_VIEWER=3Dxdg-open
=20
=20
 ### --- END CONFIGURATION SECTION ---
@@ -692,6 +693,7 @@ ETC_GITCONFIG_SQ =3D $(subst ','\'',$(ETC_GITCONFIG=
))
 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))
 bindir_SQ =3D $(subst ','\'',$(bindir))
 gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
+html_dir_SQ =3D $(subst ','\'',$(html_dir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
=20
@@ -740,7 +742,8 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIB=
S) GIT-CFLAGS
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
=20
-help.o: common-cmds.h
+help.o: help.c common-cmds.h
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DHTML_DIR=3D'"$(html_dir_S=
Q)"' -DHTML_VIEWER=3D'"$(HTML_VIEWER)"' $<
=20
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
diff --git a/cache.h b/cache.h
index 5e7381e..60e586c 100644
--- a/cache.h
+++ b/cache.h
@@ -288,6 +288,8 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int show_html_help;
+extern const char *html_help_program;
=20
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 58d3ed5..9d91a06 100644
--- a/config.c
+++ b/config.c
@@ -382,6 +382,23 @@ int git_default_config(const char *var, const char=
 *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.help")) {
+		if (!strcmp(value, "auto"))
+			show_html_help =3D 2;
+		else if (!strcmp(value, "html"))
+			show_html_help =3D 1;
+		else if (!strcmp(value, "man"))
+			show_html_help =3D 0;
+		else
+			return 1;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.htmlviewer")) {
+		html_help_program =3D xstrdup(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/config.mak.in b/config.mak.in
index a3032e3..c3e410d 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -8,12 +8,14 @@ TAR =3D @TAR@
 #INSTALL =3D @INSTALL@		# needs install-sh or install.sh in sources
 TCLTK_PATH =3D @TCLTK_PATH@
=20
+PACKAGE_TARNAME=3D@PACKAGE_TARNAME@
 prefix =3D @prefix@
 exec_prefix =3D @exec_prefix@
 bindir =3D @bindir@
 #gitexecdir =3D @libexecdir@/git-core/
 datarootdir =3D @datarootdir@
 template_dir =3D @datadir@/git-core/templates/
+html_dir =3D @docdir@/html/
=20
 mandir=3D@mandir@
=20
diff --git a/environment.c b/environment.c
index 8b9b89d..aa22c68 100644
--- a/environment.c
+++ b/environment.c
@@ -32,6 +32,8 @@ size_t delta_base_cache_limit =3D 16 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color =3D 1;
 int auto_crlf =3D 0;	/* 1: both ways, -1: only when adding git objects=
 */
+int show_html_help =3D 0;
+const char *html_help_program =3D NULL;
=20
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graf=
t_file;
diff --git a/git.c b/git.c
index 29b55a1..c3c0fe8 100644
--- a/git.c
+++ b/git.c
@@ -4,7 +4,7 @@
 #include "quote.h"
=20
 const char git_usage_string[] =3D
-	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate] [--b=
are] [--git-dir=3DGIT_DIR] [--help] COMMAND [ARGS]";
+	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [-p|--paginate] [--b=
are] [--git-dir=3DGIT_DIR] [--help [--html]] COMMAND [ARGS]";
=20
 static void prepend_to_path(const char *dir, int len)
 {
diff --git a/help.c b/help.c
index 1cd33ec..52474e9 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,14 @@
 #include "common-cmds.h"
 #include <sys/ioctl.h>
=20
+#ifndef HTML_DIR
+#define HTML_DIR "/usr/share/html/"
+#endif
+
+#ifndef HTML_VIEWER
+#define HTML_VIEWER "xdg-open"
+#endif
+
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -183,6 +191,140 @@ static void show_man_page(const char *git_cmd)
 	execlp("man", "man", page, NULL);
 }
=20
+static void show_html_page(const char *git_cmd)
+{
+	const char *html_dir;
+	int len, ret, nr_quotes;
+	char *p, *p2;
+	const char *cp, *cp2;
+	struct stat st;
+	char *quoted_git_cmd;
+	const char *command;
+
+	html_dir =3D HTML_DIR;
+	command =3D html_help_program ? html_help_program : HTML_VIEWER;
+
+	nr_quotes =3D 0;
+	for (cp =3D git_cmd; *cp; cp++)
+		if (*cp =3D=3D '\'') nr_quotes ++;
+
+	len =3D strlen(git_cmd) + nr_quotes*2 + 2 + 4; /* two quotes and git-=
 */
+	quoted_git_cmd =3D p2 =3D xmalloc(len + 1);
+	*p2++ =3D '\'';
+	if (prefixcmp(git_cmd, "git")) {
+		strcpy(p2,"git-");
+		p2 +=3D 4;
+	}
+	for (cp =3D git_cmd; *cp; cp ++) {
+		if (*cp =3D=3D '\'')
+			*p2++ =3D '\\';
+		*p2++ =3D *cp;
+	}
+	*p2++ =3D '\'';
+	*p2 =3D 0;
+
+	/* first pass, calculate command length */
+	cp =3D command;
+	len =3D 0;
+	while (*cp && (cp2 =3D strchr(cp, '%'))) {
+		len +=3D cp2 - cp;
+
+		if (!cp2[1]) break;
+
+		switch (cp2[1]) {
+			case 'p':
+				len +=3D strlen(html_dir) + strlen(quoted_git_cmd) + 5; /* .html *=
/
+				break;
+
+			case 'f':
+				len +=3D strlen(quoted_git_cmd) + 5; /* .html */
+				break;
+
+			case 'b':
+				len +=3D strlen(quoted_git_cmd);
+				break;
+
+			default:
+				len +=3D 2;
+		}
+		cp =3D cp2 + 2;
+	}
+	if (!len) /* no expansion, append %p */
+		len +=3D 1 + strlen(html_dir) + strlen(quoted_git_cmd) + 5;
+	if (*cp)
+		len +=3D strlen(cp);
+
+	/* second pass */
+	cp =3D command;
+	p =3D p2 =3D xmalloc(len + 1);
+	while (*cp && (cp2 =3D strchr(cp, '%'))) {
+		len =3D cp2 - cp;
+		memcpy(p2, cp, len);
+		p2 +=3D len;
+
+		if (!cp2[1]) break;
+
+		switch (cp2[1]) {
+			case 'p':
+				len =3D strlen(html_dir);
+				memcpy(p2, html_dir, len);
+				p2 +=3D len;
+
+				len =3D strlen(quoted_git_cmd);
+				memcpy(p2, quoted_git_cmd, len);
+				p2 +=3D len;
+
+				memcpy(p2, ".html", 5);
+				p2 +=3D 5;
+				break;
+
+			case 'f':
+				len =3D strlen(quoted_git_cmd);
+				memcpy(p2, quoted_git_cmd, len);
+				p2 +=3D len;
+
+				memcpy(p2, ".html", 5);
+				p2 +=3D 5;
+				break;
+
+			case 'b':
+				len =3D strlen(quoted_git_cmd);
+				memcpy(p2, quoted_git_cmd, len);
+				p2 +=3D len;
+				break;
+
+			default:
+				*p2++ =3D cp2[0];
+				*p2++ =3D cp2[1];
+		}
+		cp =3D cp2+2;
+	}
+	if (*cp)
+		strcpy(p2,cp);
+	else
+		*p2 =3D 0;
+	if (p =3D=3D p2) { /* no expansion, append %p */
+		strcat(p2, " ");
+		strcat(p2, html_dir);
+		strcat(p2, quoted_git_cmd);
+		strcat(p2, ".html");
+	}
+
+	free(quoted_git_cmd);
+
+	ret =3D system(p);
+
+	if (ret =3D=3D -1)
+		error("Failed to run %s", p);
+
+	free(p);
+
+	/* fallback to man pages */
+	if (show_html_help > 1 && (ret =3D=3D -1 || ret > 0))
+		show_man_page(git_cmd);
+	exit(ret);
+}
+
 void help_unknown_cmd(const char *cmd)
 {
 	printf("git: '%s' is not a git-command\n\n", cmd);
@@ -214,8 +356,23 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
 		exit(1);
 	}
=20
-	else
-		show_man_page(help_cmd);
+	else {
+		git_config(git_default_config);
+		if (!strcmp(help_cmd, "--html")) {
+			help_cmd =3D argc > 2 ? argv[2] : NULL;
+			if (!help_cmd) {
+				printf("usage: %s\n\n", git_usage_string);
+				list_common_cmds_help();
+				exit(1);
+			}
+			show_html_help =3D 1;
+		}
+
+		if (show_html_help)
+			show_html_page(help_cmd);
+		else
+			show_man_page(help_cmd);
+	}
=20
 	return 0;
 }
--=20
1.5.2

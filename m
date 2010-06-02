From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 1/7] Add infrastructure for translating Git with gettext
Date: Wed,  2 Jun 2010 01:05:58 +0000
Message-ID: <1275440764-26153-2-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPT-0004eW-TK
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449Ab0FBBGQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 21:06:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab0FBBGP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:15 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AZRjQI3lfxKD93pwupToVqKmVdd+owGbI7ysuy4VweY=;
        b=SEC6HKjj1A0Sn5YwDjp7kpR16xdbjARkm8c2SFvnAdaacj23fe0Xb6aFRUrMMuh41P
         J+4cfXtWryqNXpToEYqelJC1bA28SwcEGT3VAzWko8BaBI2NkYGHdpukxiWHooEvkrlS
         7WVpF8xzDmHteWFSvf2Dhra4nzkYTumJLCf5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ijq8VfzL4TwBWf+ZjCFeJDcP2QYWTOk32OcINnrFQNSUUIkP+IpNNatynIZLzZBskS
         5TuPb4pdVT0+p3bk0B6OyZVeWZCpRhd+pobY0U/W6t55hvqz4iC7kABclHKQf+TbfRpO
         X1PjDt59xe9WVw67QesBT7BNHWJv7j72veP2c=
Received: by 10.223.24.5 with SMTP id t5mr7869084fab.72.1275440773948;
        Tue, 01 Jun 2010 18:06:13 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148181>

=46rom: Jeff Epler <jepler@unpythonic.net>

Change the build process to use GNU's libintl if it's available. If
not we define our own skeleton replacement functions which degrade
gracefully to English.

Gettext .mo files will be installed and looked for in
$(prefix)/share/locale. GIT_LOCALEDIR can also be set to override
that, this variable is only intended for testing Git itself.

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 .gitignore    |    1 +
 Makefile      |   30 +++++++++++++
 config.mak.in |    1 +
 configure.ac  |    6 +++
 gettext.c     |   25 +++++++++++
 gettext.h     |   13 ++++++
 git.c         |    3 +
 po/.gitignore |    1 +
 wt-status.c   |  129 +++++++++++++++++++++++++++++--------------------=
--------
 9 files changed, 145 insertions(+), 64 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 po/.gitignore

diff --git a/.gitignore b/.gitignore
index 14e2b6b..d22c0e5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -204,3 +204,4 @@
 *.pdb
 /Debug/
 /Release/
+/share/
diff --git a/Makefile b/Makefile
index d5d6565..4de0627 100644
--- a/Makefile
+++ b/Makefile
@@ -297,6 +297,8 @@ RPMBUILD =3D rpmbuild
 TCL_PATH =3D tclsh
 TCLTK_PATH =3D wish
 PTHREAD_LIBS =3D -lpthread
+XGETTEXT =3D xgettext
+MSGFMT =3D msgfmt
=20
 export TCL_PATH TCLTK_PATH
=20
@@ -523,6 +525,7 @@ LIB_H +=3D userdiff.h
 LIB_H +=3D utf8.h
 LIB_H +=3D xdiff-interface.h
 LIB_H +=3D xdiff/xdiff.h
+LIB_H +=3D gettext.h
=20
 LIB_OBJS +=3D abspath.o
 LIB_OBJS +=3D advice.o
@@ -564,6 +567,7 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fsck.o
+LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D graph.o
 LIB_OBJS +=3D grep.o
 LIB_OBJS +=3D hash.o
@@ -1386,6 +1390,12 @@ ifdef USE_NED_ALLOCATOR
        COMPAT_OBJS +=3D compat/nedmalloc/nedmalloc.o
 endif
=20
+ifdef NO_GETTEXT
+	COMPAT_CFLAGS +=3D -DNO_GETTEXT
+else
+	LIBINTL =3D -lintl
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=3DNoThanks
 endif
@@ -1415,6 +1425,7 @@ ifndef V
 	QUIET_BUILT_IN =3D @echo '   ' BUILTIN $@;
 	QUIET_GEN      =3D @echo '   ' GEN $@;
 	QUIET_LNCP     =3D @echo '   ' LN/CP $@;
+	QUIET_MSGFMT   =3D @echo '   ' MSGFMT $@;
 	QUIET_SUBDIR0  =3D +@subdir=3D
 	QUIET_SUBDIR1  =3D ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -1442,6 +1453,7 @@ gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
 template_dir_SQ =3D $(subst ','\'',$(template_dir))
 htmldir_SQ =3D $(subst ','\'',$(htmldir))
 prefix_SQ =3D $(subst ','\'',$(prefix))
+sharedir_SQ =3D $(subst ','\'',$(sharedir))
=20
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
@@ -1868,6 +1880,17 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
+pot:
+	$(XGETTEXT) -k_ -o po/git.pot $(C_OBJ:o=3Dc)
+
+POFILES :=3D $(wildcard po/*.po)
+MOFILES :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/git.mo,$(PO=
=46ILES))
+MODIRS :=3D $(patsubst po/%.po,share/locale/%/LC_MESSAGES/,$(POFILES))
+all:: $(MOFILES)
+share/locale/%/LC_MESSAGES/git.mo: po/%.po
+	@mkdir -p $(dir $@)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
+
 ### Detect prefix changes
 TRACK_CFLAGS =3D $(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
@@ -1980,6 +2003,9 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sharedir_SQ)/locale'
+	(cd share && tar cf - locale) | \
+		(cd '$(DESTDIR_SQ)$(sharedir_SQ)' && umask 022 && tar xof -)
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 ifndef NO_PERL
 	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' ins=
tall
@@ -2127,6 +2153,10 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui clean
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+ifndef NO_GETTEXT
+	$(RM) po/git.pot
+	$(RM) -r share/
+endif
=20
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
diff --git a/config.mak.in b/config.mak.in
index 0d4b64d..a15f3c1 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -32,6 +32,7 @@ NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
 HAVE_PATHS_H=3D@HAVE_PATHS_H@
+NO_GETTEXT=3D@NO_GETTEXT@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
 NEEDS_RESOLV=3D@NEEDS_RESOLV@
diff --git a/configure.ac b/configure.ac
index 71038fc..7bebfd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -730,6 +730,12 @@ AC_CHECK_HEADER([paths.h],
 [HAVE_PATHS_H=3D])
 AC_SUBST(HAVE_PATHS_H)
 #
+# Define NO_GETTEXT if you don't have libintl.h
+AC_CHECK_HEADER([libintl.h],
+[NO_GETTEXT=3D],
+[NO_GETTEXT=3DYesPlease])
+AC_SUBST(NO_GETTEXT)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3D],
diff --git a/gettext.c b/gettext.c
new file mode 100644
index 0000000..22cdcc1
--- /dev/null
+++ b/gettext.c
@@ -0,0 +1,25 @@
+#ifdef NO_GETTEXT
+void git_setup_gettext(void) {}
+#else
+#include "exec_cmd.h"
+#include <libintl.h>
+#include <stdlib.h>
+
+void git_setup_gettext(void) {
+	char *podir;
+	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");
+
+	if (envdir) {
+		(void)bindtextdomain("git", envdir);
+	} else {
+		podir =3D (char *)system_path("share/locale");
+		if (!podir) return;
+		(void)bindtextdomain("git", podir);
+		free(podir);
+	}
+
+	(void)setlocale(LC_MESSAGES, "");
+	(void)setlocale(LC_CTYPE, "");
+	(void)textdomain("git");
+}
+#endif
diff --git a/gettext.h b/gettext.h
new file mode 100644
index 0000000..a99da6a
--- /dev/null
+++ b/gettext.h
@@ -0,0 +1,13 @@
+#ifndef GETTEXT_H
+#define GETTEXT_H
+
+void git_setup_gettext(void);
+
+#ifdef NO_GETTEXT
+#define _(s) (s)
+#else
+#include <libintl.h>
+#define _(s) gettext(s)
+#endif
+
+#endif
diff --git a/git.c b/git.c
index 99f0363..d749eab 100644
--- a/git.c
+++ b/git.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "run-command.h"
+#include "gettext.h"
=20
 const char git_usage_string[] =3D
 	"git [--version] [--exec-path[=3DGIT_EXEC_PATH]] [--html-path]\n"
@@ -490,6 +491,8 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd =3D "git-help";
=20
+	git_setup_gettext();
+
 	/*
 	 * "git-xxxx" is the same as "git xxxx", but we obviously:
 	 *
diff --git a/po/.gitignore b/po/.gitignore
new file mode 100644
index 0000000..221000e
--- /dev/null
+++ b/po/.gitignore
@@ -0,0 +1 @@
+/*.pot
diff --git a/wt-status.c b/wt-status.c
index 14e0acc..70b4293 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "run-command.h"
 #include "remote.h"
+#include "gettext.h"
=20
 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -49,33 +50,33 @@ static void wt_status_print_unmerged_header(struct =
wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	color_fprintf_ln(s->fp, c, _("# Unmerged paths:"));
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		;
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
+		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to=
 unstage)"), s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appr=
opriate to mark resolution)");
-	color_fprintf_ln(s->fp, c, "#");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\"=
 to unstage)"));
+	color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" as ap=
propriate to mark resolution)"));
+	color_fprintf_ln(s->fp, c, _("#"));
 }
=20
 static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	color_fprintf_ln(s->fp, c, _("# Changes to be committed:"));
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to u=
nstage)", s->reference);
+		color_fprintf_ln(s->fp, c, _("#   (use \"git reset %s <file>...\" to=
 unstage)"), s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" t=
o unstage)");
-	color_fprintf_ln(s->fp, c, "#");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git rm --cached <file>...\"=
 to unstage)"));
+	color_fprintf_ln(s->fp, c, _("#"));
 }
=20
 static void wt_status_print_dirty_header(struct wt_status *s,
@@ -84,17 +85,17 @@ static void wt_status_print_dirty_header(struct wt_=
status *s,
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
=20
-	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
+	color_fprintf_ln(s->fp, c, _("# Changed but not updated:"));
 	if (!advice_status_hints)
 		return;
 	if (!has_deleted)
-		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update=
 what will be committed)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git add <file>...\" to upda=
te what will be committed)"));
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to upd=
ate what will be committed)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to=
 discard changes in working directory)");
+		color_fprintf_ln(s->fp, c, _("#   (use \"git add/rm <file>...\" to u=
pdate what will be committed)"));
+	color_fprintf_ln(s->fp, c, _("#   (use \"git checkout -- <file>...\" =
to discard changes in working directory)"));
 	if (has_dirty_submodules)
-		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or =
modified content in submodules)");
-	color_fprintf_ln(s->fp, c, "#");
+		color_fprintf_ln(s->fp, c, _("#   (commit or discard the untracked o=
r modified content in submodules)"));
+	color_fprintf_ln(s->fp, c, _("#"));
 }
=20
 static void wt_status_print_other_header(struct wt_status *s,
@@ -102,16 +103,16 @@ static void wt_status_print_other_header(struct w=
t_status *s,
 					 const char *how)
 {
 	const char *c =3D color(WT_STATUS_HEADER, s);
-	color_fprintf_ln(s->fp, c, "# %s files:", what);
+	color_fprintf_ln(s->fp, c, _("# %s files:"), what);
 	if (!advice_status_hints)
 		return;
-	color_fprintf_ln(s->fp, c, "#   (use \"git %s <file>...\" to include =
in what will be committed)", how);
-	color_fprintf_ln(s->fp, c, "#");
+	color_fprintf_ln(s->fp, c, _("#   (use \"git %s <file>...\" to includ=
e in what will be committed)"), how);
+	color_fprintf_ln(s->fp, c, _("#"));
 }
=20
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
 }
=20
 #define quote_path quote_path_relative
@@ -122,20 +123,20 @@ static void wt_status_print_unmerged_data(struct =
wt_status *s,
 	const char *c =3D color(WT_STATUS_UNMERGED, s);
 	struct wt_status_change_data *d =3D it->util;
 	struct strbuf onebuf =3D STRBUF_INIT;
-	const char *one, *how =3D "bug";
+	const char *one, *how =3D _("bug");
=20
 	one =3D quote_path(it->string, -1, &onebuf, s->prefix);
-	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("#\t"));
 	switch (d->stagemask) {
-	case 1: how =3D "both deleted:"; break;
-	case 2: how =3D "added by us:"; break;
-	case 3: how =3D "deleted by them:"; break;
-	case 4: how =3D "added by them:"; break;
-	case 5: how =3D "deleted by us:"; break;
-	case 6: how =3D "both added:"; break;
-	case 7: how =3D "both modified:"; break;
+	case 1: how =3D _("both deleted:"); break;
+	case 2: how =3D _("added by us:"); break;
+	case 3: how =3D _("deleted by them:"); break;
+	case 4: how =3D _("added by them:"); break;
+	case 5: how =3D _("deleted by us:"); break;
+	case 6: how =3D _("both added:"); break;
+	case 7: how =3D _("both modified:"); break;
 	}
-	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
+	color_fprintf(s->fp, c, _("%-20s%s\n"), how, one);
 	strbuf_release(&onebuf);
 }
=20
@@ -161,13 +162,13 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 		break;
 	case WT_STATUS_CHANGED:
 		if (d->new_submodule_commits || d->dirty_submodule) {
-			strbuf_addstr(&extra, " (");
+			strbuf_addstr(&extra, _(" ("));
 			if (d->new_submodule_commits)
-				strbuf_addf(&extra, "new commits, ");
+				strbuf_addf(&extra, _("new commits, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				strbuf_addf(&extra, "modified content, ");
+				strbuf_addf(&extra, _("modified content, "));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-				strbuf_addf(&extra, "untracked content, ");
+				strbuf_addf(&extra, _("untracked content, "));
 			strbuf_setlen(&extra, extra.len - 2);
 			strbuf_addch(&extra, ')');
 		}
@@ -178,40 +179,40 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 	one =3D quote_path(one_name, -1, &onebuf, s->prefix);
 	two =3D quote_path(two_name, -1, &twobuf, s->prefix);
=20
-	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
+	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("#\t"));
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		color_fprintf(s->fp, c, "new file:   %s", one);
+		color_fprintf(s->fp, c, _("new file:   %s"), one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
+		color_fprintf(s->fp, c, _("copied:     %s -> %s"), one, two);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_fprintf(s->fp, c, "deleted:    %s", one);
+		color_fprintf(s->fp, c, _("deleted:    %s"), one);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_fprintf(s->fp, c, "modified:   %s", one);
+		color_fprintf(s->fp, c, _("modified:   %s"), one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
+		color_fprintf(s->fp, c, _("renamed:    %s -> %s"), one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_fprintf(s->fp, c, "typechange: %s", one);
+		color_fprintf(s->fp, c, _("typechange: %s"), one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_fprintf(s->fp, c, "unknown:    %s", one);
+		color_fprintf(s->fp, c, _("unknown:    %s"), one);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_fprintf(s->fp, c, "unmerged:   %s", one);
+		color_fprintf(s->fp, c, _("unmerged:   %s"), one);
 		break;
 	default:
-		die("bug: unhandled diff status %c", status);
+		die(_("bug: unhandled diff status %c"), status);
 	}
 	if (extra.len) {
-		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
+		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), _("%s"), extra.buf)=
;
 		strbuf_release(&extra);
 	}
-	fprintf(s->fp, "\n");
+	fprintf(s->fp, _("\n"));
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
 }
@@ -618,14 +619,14 @@ void wt_status_print(struct wt_status *s)
 	const char *branch_color =3D color(WT_STATUS_HEADER, s);
=20
 	if (s->branch) {
-		const char *on_what =3D "On branch ";
+		const char *on_what =3D _("On branch ");
 		const char *branch_name =3D s->branch;
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name +=3D 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name =3D "";
 			branch_color =3D color(WT_STATUS_NOBRANCH, s);
-			on_what =3D "Not currently on any branch.";
+			on_what =3D _("Not currently on any branch.");
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
 		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
@@ -634,9 +635,9 @@ void wt_status_print(struct wt_status *s)
 	}
=20
 	if (s->is_initial) {
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commi=
t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("# Initial com=
mit"));
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), _("#"));
 	}
=20
 	wt_status_print_updated(s);
@@ -647,38 +648,38 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, "Untracked", "add");
+		wt_status_print_other(s, &s->untracked, _("Untracked"), _("add"));
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, "Ignored", "add -f");
+			wt_status_print_other(s, &s->ignored, _("Ignored"), _("add -f"));
 	} else if (s->commitable)
-		fprintf(s->fp, "# Untracked files not listed%s\n",
+		fprintf(s->fp, _("# Untracked files not listed%s\n"),
 			advice_status_hints
-			? " (use -u option to show untracked files)" : "");
+			? _(" (use -u option to show untracked files)") : "");
=20
 	if (s->verbose)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
+			fprintf(s->fp, _("# No changes\n"));
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
-			printf("no changes added to commit%s\n",
+			printf(_("no changes added to commit%s\n"),
 				advice_status_hints
-				? " (use \"git add\" and/or \"git commit -a\")" : "");
+				? _(" (use \"git add\" and/or \"git commit -a\")") : "");
 		else if (s->untracked.nr)
-			printf("nothing added to commit but untracked files present%s\n",
+			printf(_("nothing added to commit but untracked files present%s\n")=
,
 				advice_status_hints
-				? " (use \"git add\" to track)" : "");
+				? _(" (use \"git add\" to track)") : "");
 		else if (s->is_initial)
 			printf("nothing to commit%s\n", advice_status_hints
-				? " (create/copy files and use \"git add\" to track)" : "");
+				? _(" (create/copy files and use \"git add\" to track)") : "");
 		else if (!s->show_untracked_files)
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (use -u to show untracked files)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (use -u to show untracked files)") : "");
 		else
-			printf("nothing to commit%s\n", advice_status_hints
-				? " (working directory clean)" : "");
+			printf(_("nothing to commit%s\n"), advice_status_hints
+				? _(" (working directory clean)") : "");
 	}
 }
=20
--=20
1.7.1.251.gec7f5.dirty

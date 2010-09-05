From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/17] Introduce $GIT_DIR/narrow
Date: Sun,  5 Sep 2010 16:47:30 +1000
Message-ID: <1283669264-15759-4-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:48:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os921-0007rI-GZ
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394Ab0IEGsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:48:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37408 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0IEGsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:48:41 -0400
Received: by pzk9 with SMTP id 9so1040881pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=e9nHWoG68E1V2sOuqz/1Zd+rDODPUysoJ6iT5lu1hoQ=;
        b=beTLLwl0t7JBTA/C+h8AVIUIn3v0yYBvwuvkXxuaLGnhm8Xlt1tyQRA+Z7qrNU04Q8
         18v0fUCgSv2LkkP6rv0Tlpo1fvyFzev81Qpw1VVpcj4w83V3gOxVr1FGXmVOCm00SMRU
         YuDLS4Q9j+18TIsrcfgYEGNQkOxTtNy+fbTjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gymEslYfXxqjTAPJMJsyDL0cTaOk2tuefhwp4o8xYSmtdUi9N0odonxiIGWoUd+Y4T
         FEk72R0Z/WAcw//WcRQcLkKYhv0rVDpQNm9mxFqYYdwjkRlbnXf1dym89dejZ10HeYFd
         Jg+d4VHLFh2b7gncbFGW+aKH6w3ljLFpuUFKg=
Received: by 10.114.73.20 with SMTP id v20mr789551waa.148.1283669320527;
        Sat, 04 Sep 2010 23:48:40 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id 33sm8032903wad.18.2010.09.04.23.48.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:48:39 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:48:30 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155429>

This file contains a sorted list of narrow prefix, used in narrow
repositories.

rev-parse also learns --narrow-prefix to print $GIT_DIR/narrow out

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-rev-parse.txt        |    3 +
 Documentation/gitrepository-layout.txt |    5 ++
 Makefile                               |    2 +
 builtin/rev-parse.c                    |    8 +++
 cache.h                                |    3 +
 environment.c                          |    2 +
 narrow-tree.c                          |  106 ++++++++++++++++++++++++=
++++++++
 narrow-tree.h                          |    3 +
 t/t0063-narrow-repo.sh                 |   46 ++++++++++++++
 9 files changed, 178 insertions(+), 0 deletions(-)
 create mode 100644 narrow-tree.c
 create mode 100644 narrow-tree.h
 create mode 100755 t/t0063-narrow-repo.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index be4c053..5d5e77b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -148,6 +148,9 @@ shown.  If the pattern does not contain a globbing =
character (`?`,
 --is-bare-repository::
 	When the repository is bare print "true", otherwise "false".
=20
+--narrow-prefix::
+	Print narrow prefix git reads from $GIT_DIR/narrow.
+
 --local-env-vars::
 	List the GIT_* environment variables that are local to the
 	repository (e.g. GIT_DIR or GIT_WORK_TREE, but not GIT_EDITOR).
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index eb3d040..82e0350 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -193,6 +193,11 @@ shallow::
 	and maintained by shallow clone mechanism.  See `--depth`
 	option to linkgit:git-clone[1] and linkgit:git-fetch[1].
=20
+narrow::
+	This file contains narrow prefix in sorted order. It is
+	internally used and maintained by narrow clone mechanism.
+	See `--narrow-tree` option to linkgit:git-clone[1].
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/Makefile b/Makefile
index b4745a5..f1aaba9 100644
--- a/Makefile
+++ b/Makefile
@@ -525,6 +525,7 @@ LIB_H +=3D sigchain.h
 LIB_H +=3D strbuf.h
 LIB_H +=3D string-list.h
 LIB_H +=3D submodule.h
+LIB_H +=3D narrow-tree.h
 LIB_H +=3D tag.h
 LIB_H +=3D transport.h
 LIB_H +=3D tree.h
@@ -629,6 +630,7 @@ LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D strbuf.o
 LIB_OBJS +=3D string-list.o
 LIB_OBJS +=3D submodule.o
+LIB_OBJS +=3D narrow-tree.o
 LIB_OBJS +=3D symlinks.o
 LIB_OBJS +=3D tag.o
 LIB_OBJS +=3D trace.o
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..590df6f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -675,6 +675,14 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 						: "false");
 				continue;
 			}
+			if (!strcmp(arg, "--narrow-prefix")) {
+				const char **p =3D get_narrow_prefix();
+				if (!p)
+					continue;
+				while (*p)
+					printf("%s\n", *p++);
+				continue;
+			}
 			if (!prefixcmp(arg, "--since=3D")) {
 				show_datestring("--max-age=3D", arg+8);
 				continue;
diff --git a/cache.h b/cache.h
index eb77e1d..d09c4fc 100644
--- a/cache.h
+++ b/cache.h
@@ -1105,4 +1105,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned ch=
ar *to);
=20
+/* narrow-tree.c */
+extern const char **get_narrow_prefix();
+
 #endif /* CACHE_H */
diff --git a/environment.c b/environment.c
index 83d38d3..41fcbd4 100644
--- a/environment.c
+++ b/environment.c
@@ -8,6 +8,7 @@
  * are.
  */
 #include "cache.h"
+#include "narrow-tree.h"
=20
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
@@ -105,6 +106,7 @@ static void setup_git_env(void)
 		git_graft_file =3D git_pathdup("info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs =3D 0;
+	check_narrow_prefix();
 }
=20
 int is_bare_repository(void)
diff --git a/narrow-tree.c b/narrow-tree.c
new file mode 100644
index 0000000..85dbab4
--- /dev/null
+++ b/narrow-tree.c
@@ -0,0 +1,106 @@
+#include "cache.h"
+#include "narrow-tree.h"
+
+static const char **narrow_prefix;
+static char *narrow_buf;
+
+int valid_narrow_prefix(const char *prefix, const char *prev_prefix, i=
nt quiet)
+{
+	int len =3D strlen(prefix);
+
+	if (!*prefix) {
+		if (!quiet)
+			error("Empty line in $GIT_DIR/narrow");
+		return 0;
+	}
+
+	if (prefix[len-1] =3D=3D '/') {
+		if (!quiet)
+			error("Trailing slash not allowed in $GIT_DIR: %s", prefix);
+		return 0;
+	}
+
+	if (prev_prefix) {
+		if (strcmp(prev_prefix, prefix) >=3D 0) {
+			if (!quiet)
+				error("$GIT_DIR/narrow is unsorted at %s", prefix);
+			return 0;
+		}
+		len =3D strlen(prev_prefix);
+		if (!strncmp(prev_prefix, prefix, len) &&
+		    prefix[len] =3D=3D '/') {
+			if (!quiet) {
+				error("$GIT_DIR/narrow has nested prefix (%s and %s)",
+				      prev_prefix, prefix);
+				return 0;
+			}
+		}
+	}
+	return 1;
+}
+
+int check_narrow_prefix()
+{
+	struct stat st;
+	int fd, i, n, len;
+	char *p, *pp;
+
+	if (stat(git_path("narrow"), &st) || st.st_size =3D=3D 0)
+		return 0;
+
+	narrow_buf =3D xmalloc(st.st_size+2); /* NULL and \n */
+
+	fd =3D open(git_path("narrow"), O_RDONLY);
+	if (fd =3D=3D -1)
+		return 0;
+
+	if (xread(fd, narrow_buf, st.st_size) !=3D st.st_size)
+		die("failed to read $GIT_DIR/narrow");
+	close(fd);
+
+	if (narrow_buf[st.st_size-1] =3D=3D '\n')
+		narrow_buf[st.st_size] =3D '\0';
+	else {
+		narrow_buf[st.st_size] =3D '\n';
+		narrow_buf[st.st_size+1] =3D '\0';
+	}
+	n =3D 0;
+	for (p =3D narrow_buf; *p; p =3D strchr(p, '\n')+1)
+		n++;
+	if (!n)
+		return 0;
+	narrow_prefix =3D xmalloc(sizeof(*narrow_prefix)*(n+1));
+	p =3D narrow_buf;
+	for (i =3D 0; i < n; i++) {
+		pp =3D p;
+		p =3D strchr(p, '\n') + 1;
+		len =3D p - pp;
+		while (len &&
+		       (pp[len-1] =3D=3D '\n' ||
+			pp[len-1] =3D=3D '\r'))
+			len--;
+		pp[len] =3D '\0';
+		if (!valid_narrow_prefix(pp, i ? narrow_prefix[i-1] : NULL, 0))
+			die("Invalid $GIT_DIR/narrow");
+		narrow_prefix[i] =3D pp;
+	}
+	narrow_prefix[n] =3D NULL;
+	return 0;
+}
+
+const char **get_narrow_prefix()
+{
+	return narrow_prefix;
+}
+
+char *get_narrow_string()
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char **prefix =3D get_narrow_prefix();
+	while (*prefix) {
+		strbuf_addstr(&sb, *prefix);
+		strbuf_addch(&sb, '\n');
+		prefix++;
+	}
+	return strbuf_detach(&sb, NULL);
+}
diff --git a/narrow-tree.h b/narrow-tree.h
new file mode 100644
index 0000000..2097436
--- /dev/null
+++ b/narrow-tree.h
@@ -0,0 +1,3 @@
+extern int valid_narrow_prefix(const char *prefix, const char *prev_pr=
efix, int quiet);
+extern int check_narrow_prefix();
+extern char *get_narrow_string();
diff --git a/t/t0063-narrow-repo.sh b/t/t0063-narrow-repo.sh
new file mode 100755
index 0000000..51b753d
--- /dev/null
+++ b/t/t0063-narrow-repo.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description=3D'narrow index'
+
+. ./test-lib.sh
+
+test_expect_success 'empty $GIT_DIR/narrow' '
+	: >.git/narrow &&
+	git rev-parse --narrow-prefix >result &&
+	: >expected
+	test_cmp expected result
+'
+
+test_expect_success 'empty line' '
+	echo >.git/narrow &&
+	test_must_fail git rev-parse --narrow-prefix
+'
+
+test_expect_success 'single prefix' '
+	echo a >.git/narrow &&
+	git rev-parse --narrow-prefix >result &&
+	echo a >expected
+	test_cmp expected result
+'
+
+test_expect_success 'trailing slash in prefix' '
+	echo a/ >.git/narrow &&
+	test_must_fail git rev-parse --narrow-prefix
+'
+
+test_expect_success 'sorted multiple prefix' '
+	echo a >.git/narrow &&
+	echo b >>.git/narrow &&
+	git rev-parse --narrow-prefix >result &&
+	echo a >expected
+	echo b >>expected
+	test_cmp expected result
+'
+
+test_expect_success 'unsorted multiple prefix' '
+	echo b >.git/narrow &&
+	echo a >>.git/narrow &&
+	test_must_fail git rev-parse --narrow-prefix
+'
+
+test_done
--=20
1.7.1.rc1.69.g24c2f7

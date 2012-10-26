From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/7] Move setup_diff_pager to libgit.a
Date: Fri, 26 Oct 2012 22:53:52 +0700
Message-ID: <1351266835-22610-5-git-send-email-pclouds@gmail.com>
References: <20121026120253.GA1455@sigill.intra.peff.net>
 <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 17:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRmF7-0000Fg-5d
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933Ab2JZPy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 11:54:28 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59578 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2JZPy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:54:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2016315pad.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=J+cZoxBhRrdjw6XCbgrMyFW6k1InCts7VX48uhQoZjw=;
        b=rG8cIQ3Wi1BUww9vR7lqxmN3aEP6r9fprCddhWARtYfcWb2LQwqV51VZ/XNgNpsFhX
         1UV1CM7sSsPhMGD2Ozk6UHkjLfS+j/pXaboVXozgoBy+Qqsqd2XLE2RdFRrmV1nbFhgk
         EZGSVUh69L38Fi1UxpGbfXpDthBLnNZNchSgDwiLfD2XJyujv5gl4LC07NYTEDTrXu/x
         UkMFkugOag0oOzMds1M+JhAVyAHZweGTEIxvFQa6lmtvoU6mwFW6f0K8B0ab9AQoXXa2
         CnBjIu2ukcHbd4uQE3jJ2I0ozV7veE/nrMjxpzILKPWlqwm5MhaeK8WApLW2OXm+jZJu
         pGiQ==
Received: by 10.68.217.201 with SMTP id pa9mr70716346pbc.45.1351266866454;
        Fri, 26 Oct 2012 08:54:26 -0700 (PDT)
Received: from lanh ([115.74.33.44])
        by mx.google.com with ESMTPS id un16sm1350531pbc.47.2012.10.26.08.54.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 26 Oct 2012 08:54:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Oct 2012 22:54:27 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1351266835-22610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208460>

This is used by diff-no-index.c, part of libgit.a while it stays in
builtin/diff.c. Move it to diff.c so that we won't get undefined
reference if a program that uses libgit.a happens to pull it in.

While at it, move check_pager from git.c to pager.c. It makes more
sense there and pager.c is also part of libgit.a

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin.h      |  4 ----
 builtin/diff.c | 16 ----------------
 cache.h        |  1 +
 diff.c         | 16 ++++++++++++++++
 diff.h         |  1 +
 git.c          | 33 ---------------------------------
 pager.c        | 34 ++++++++++++++++++++++++++++++++++
 7 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/builtin.h b/builtin.h
index 95116b8..3faf9d6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -37,10 +37,6 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *=
c,
 			  const unsigned char *from_obj, const unsigned char *to_obj);
 void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
=20
-extern int check_pager_config(const char *cmd);
-struct diff_options;
-extern void setup_diff_pager(struct diff_options *);
-
 extern int textconv_object(const char *path, unsigned mode, const unsi=
gned char *sha1, int sha1_valid, char **buf, unsigned long *buf_size);
=20
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/builtin/diff.c b/builtin/diff.c
index 9650be2..9c70e40 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -418,19 +418,3 @@ int cmd_diff(int argc, const char **argv, const ch=
ar *prefix)
 		refresh_index_quietly();
 	return result;
 }
-
-void setup_diff_pager(struct diff_options *opt)
-{
-	/*
-	 * If the user asked for our exit code, then either they want --quiet
-	 * or --exit-code. We should definitely not bother with a pager in th=
e
-	 * former case, as we will generate no output. Since we still properl=
y
-	 * report our exit code even when a pager is run, we _could_ run a
-	 * pager with --exit-code. But since we have not done so historically=
,
-	 * and because it is easy to find people oneline advising "git diff
-	 * --exit-code" in hooks and other scripts, we do not do so.
-	 */
-	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
-	    check_pager_config("diff") !=3D 0)
-		setup_pager();
-}
diff --git a/cache.h b/cache.h
index 2dc4dec..dbd8018 100644
--- a/cache.h
+++ b/cache.h
@@ -1183,6 +1183,7 @@ extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
 extern int decimal_width(int);
+extern int check_pager_config(const char *cmd);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/diff.c b/diff.c
index 35d3f07..1b5727d 100644
--- a/diff.c
+++ b/diff.c
@@ -4871,3 +4871,19 @@ size_t fill_textconv(struct userdiff_driver *dri=
ver,
=20
 	return size;
 }
+
+void setup_diff_pager(struct diff_options *opt)
+{
+	/*
+	 * If the user asked for our exit code, then either they want --quiet
+	 * or --exit-code. We should definitely not bother with a pager in th=
e
+	 * former case, as we will generate no output. Since we still properl=
y
+	 * report our exit code even when a pager is run, we _could_ run a
+	 * pager with --exit-code. But since we have not done so historically=
,
+	 * and because it is easy to find people oneline advising "git diff
+	 * --exit-code" in hooks and other scripts, we do not do so.
+	 */
+	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
+	    check_pager_config("diff") !=3D 0)
+		setup_pager();
+}
diff --git a/diff.h b/diff.h
index a658f85..a47bae4 100644
--- a/diff.h
+++ b/diff.h
@@ -335,5 +335,6 @@ extern int parse_rename_score(const char **cp_p);
=20
 extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
+extern void setup_diff_pager(struct diff_options *);
=20
 #endif /* DIFF_H */
diff --git a/git.c b/git.c
index 8788b32..d33f9b3 100644
--- a/git.c
+++ b/git.c
@@ -17,39 +17,6 @@ const char git_more_info_string[] =3D
=20
 static struct startup_info git_startup_info;
 static int use_pager =3D -1;
-struct pager_config {
-	const char *cmd;
-	int want;
-	char *value;
-};
-
-static int pager_command_config(const char *var, const char *value, vo=
id *data)
-{
-	struct pager_config *c =3D data;
-	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, c->cmd)) {
-		int b =3D git_config_maybe_bool(var, value);
-		if (b >=3D 0)
-			c->want =3D b;
-		else {
-			c->want =3D 1;
-			c->value =3D xstrdup(value);
-		}
-	}
-	return 0;
-}
-
-/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specif=
ied" */
-int check_pager_config(const char *cmd)
-{
-	struct pager_config c;
-	c.cmd =3D cmd;
-	c.want =3D -1;
-	c.value =3D NULL;
-	git_config(pager_command_config, &c);
-	if (c.value)
-		pager_program =3D c.value;
-	return c.want;
-}
=20
 static void commit_pager_choice(void) {
 	switch (use_pager) {
diff --git a/pager.c b/pager.c
index 4dcb08d..060fa88 100644
--- a/pager.c
+++ b/pager.c
@@ -6,6 +6,12 @@
 #define DEFAULT_PAGER "less"
 #endif
=20
+struct pager_config {
+	const char *cmd;
+	int want;
+	char *value;
+};
+
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -159,3 +165,31 @@ int decimal_width(int number)
 		i *=3D 10;
 	return width;
 }
+
+static int pager_command_config(const char *var, const char *value, vo=
id *data)
+{
+	struct pager_config *c =3D data;
+	if (!prefixcmp(var, "pager.") && !strcmp(var + 6, c->cmd)) {
+		int b =3D git_config_maybe_bool(var, value);
+		if (b >=3D 0)
+			c->want =3D b;
+		else {
+			c->want =3D 1;
+			c->value =3D xstrdup(value);
+		}
+	}
+	return 0;
+}
+
+/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specif=
ied" */
+int check_pager_config(const char *cmd)
+{
+	struct pager_config c;
+	c.cmd =3D cmd;
+	c.want =3D -1;
+	c.value =3D NULL;
+	git_config(pager_command_config, &c);
+	if (c.value)
+		pager_program =3D c.value;
+	return c.want;
+}
--=20
1.8.0.rc2.23.g1fb49df

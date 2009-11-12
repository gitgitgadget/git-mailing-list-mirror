From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] Teach git var about GIT_EDITOR
Date: Wed, 11 Nov 2009 18:01:27 -0600
Message-ID: <20091112000126.GE1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:51:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8MyA-00088G-0S
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759337AbZKKXvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758940AbZKKXvJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:51:09 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56314 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbZKKXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:51:08 -0500
Received: by ywh6 with SMTP id 6so1462149ywh.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9HLSL+LQRFsV1wiXiWQGd5GylJBdgczyfT4sg/z166E=;
        b=cP98Q0p0yVUDjrUs9T873Ah0Odc1vnKnwQX+/vmsgnHGBxEu6dJFsWzpJ1kLpERvpE
         wUWIp++V+hrHjxC9tNw0p4XwWZpzYDyVGaKGY5JwJD3W6WJIStFSHcAn5Zz+eZm259jd
         plw10sMUgrFZGqgSzKsRY9vV7UpYlCVqxpFrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DY0tHTtYwnFJvdwne4CLTfcHsEW+l8XxqygPChuvqll8jinBCqMQ22NMMorQ1DWsoY
         iX49wA9E4HW+kYbpT9+Jsew7QvNoLidigBwYsZUzTLuQUzvqJbSg5HO/Lsyuj2XYmb3h
         40NOcEkzzNkeLsfRbW5Y/KPYFY9ir+9oGeGrs=
Received: by 10.90.42.39 with SMTP id p39mr3205668agp.86.1257983474417;
        Wed, 11 Nov 2009 15:51:14 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm1032097yxb.25.2009.11.11.15.51.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:51:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132725>

Expose the command used by launch_editor() for scripts to use.
This should allow one to avoid searching for a proper editor
separately in each command.

git_editor(void) uses the logic to decide which editor to use
that used to live in launch_editor().  The function returns NULL
if there is no suitable editor; the caller is expected to issue
an error message when appropriate.

launch_editor() uses git_editor() and gives the error message the
same way as before when EDITOR is not set.

"git var GIT_EDITOR" gives the editor name, or an error message
when there is no appropriate one.

"git var -l" gives GIT_EDITOR=3Dname only if there is an
appropriate editor.

Originally-submitted-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Changes from the version in pu:
 * unsquashed with the previous patch;
 * replaces Hannes=E2=80=99s sign-off with something more descriptive (=
see
<http://thread.gmane.org/gmane.comp.version-control.git/131471/focus=3D=
131851>);
 * nicer commit message based on Junio=E2=80=99s summary.

 Documentation/git-var.txt |    8 ++++++++
 cache.h                   |    1 +
 editor.c                  |   14 ++++++++++++--
 var.c                     |   16 +++++++++++++++-
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index e2f4c09..89e4b4f 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -36,6 +36,14 @@ GIT_AUTHOR_IDENT::
 GIT_COMMITTER_IDENT::
     The person who put a piece of code into git.
=20
+GIT_EDITOR::
+    Text editor for use by git commands.  The value is meant to be
+    interpreted by the shell when it is used.  Examples: `~/bin/vi`,
+    `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
+    --nofork`.  The order of preference is the `$GIT_EDITOR`
+    environment variable, then `core.editor` configuration, then
+    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
+
 Diagnostics
 -----------
 You don't exist. Go away!::
diff --git a/cache.h b/cache.h
index 96840c7..311cfe1 100644
--- a/cache.h
+++ b/cache.h
@@ -750,6 +750,7 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, cons=
t char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *git_editor(void);
=20
 struct checkout {
 	const char *base_dir;
diff --git a/editor.c b/editor.c
index 3f13751..70618f1 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"
=20
-int launch_editor(const char *path, struct strbuf *buffer, const char =
*const *env)
+const char *git_editor(void)
 {
 	const char *editor =3D getenv("GIT_EDITOR");
 	const char *terminal =3D getenv("TERM");
@@ -16,11 +16,21 @@ int launch_editor(const char *path, struct strbuf *=
buffer, const char *const *en
 		editor =3D getenv("EDITOR");
=20
 	if (!editor && terminal_is_dumb)
-		return error("terminal is dumb, but EDITOR unset");
+		return NULL;
=20
 	if (!editor)
 		editor =3D "vi";
=20
+	return editor;
+}
+
+int launch_editor(const char *path, struct strbuf *buffer, const char =
*const *env)
+{
+	const char *editor =3D git_editor();
+
+	if (!editor)
+		return error("Terminal is dumb, but EDITOR unset");
+
 	if (strcmp(editor, ":")) {
 		size_t len =3D strlen(editor);
 		int i =3D 0;
diff --git a/var.c b/var.c
index dacbaab..b502487 100644
--- a/var.c
+++ b/var.c
@@ -8,6 +8,16 @@
=20
 static const char var_usage[] =3D "git var [-l | <variable>]";
=20
+static const char *editor(int flag)
+{
+	const char *pgm =3D git_editor();
+
+	if (!pgm && flag & IDENT_ERROR_ON_NO_NAME)
+		die("Terminal is dumb, but EDITOR unset");
+
+	return pgm;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -15,14 +25,18 @@ struct git_var {
 static struct git_var git_vars[] =3D {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "GIT_EDITOR", editor },
 	{ "", NULL },
 };
=20
 static void list_vars(void)
 {
 	struct git_var *ptr;
+	const char *val;
+
 	for (ptr =3D git_vars; ptr->read; ptr++)
-		printf("%s=3D%s\n", ptr->name, ptr->read(0));
+		if ((val =3D ptr->read(0)))
+			printf("%s=3D%s\n", ptr->name, val);
 }
=20
 static const char *read_var(const char *var)
--=20
1.6.5.2

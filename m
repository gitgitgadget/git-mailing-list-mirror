From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 05:26:58 -0500
Message-ID: <20091030102658.GD1610@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 11:17:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3oXQ-0004KO-MO
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917AbZJ3KQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756909AbZJ3KQo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:16:44 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:39575 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbZJ3KQn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:16:43 -0400
Received: by yxe17 with SMTP id 17so2536436yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uK31QEKLCSywPTVz2/MCG1b13xiATZXPCOuO4fG/0TY=;
        b=lmUt6b648NtPXn4vxMs+1d76JWkYfUUsb3obFXoe0cMwP1VVNtMVsmAYYC/9za1gO3
         KJqd3d5nNmrZivj+aGBea6cVLGWFTHSxC8Mu4SprVs/CyomOEgcjutsmts/CUPH+QZ7f
         oTENgPULANG0BIdxIfnbmP96bR18Q0vOjJib4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wUCZlHnWIyjA4z20mxQFsiyL9bjPktEldpQH214d4QNGQUFpy6q53Gk3odijBnAxJG
         XANFdMemMBvm7s9YiWl0DcahXezTIBfax+mEf9Z3Ve1N8AaV/yK2nSJ3S7kosNGISQ+o
         /wJN+Usx9QM2hsgWQaRq6gkHnsKoEHN9jw/Vo=
Received: by 10.150.238.4 with SMTP id l4mr2596603ybh.177.1256897807644;
        Fri, 30 Oct 2009 03:16:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm524176gxk.4.2009.10.30.03.16.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:16:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131687>

From: Johannes Sixt <j.sixt@viscovery.net>

Expose the command used by launch_editor() for scripts to use.
This should allow one to avoid searching for a proper editor
separately in each command.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-var.txt |    8 ++++++++
 cache.h                   |    1 +
 editor.c                  |   18 +++++++++++++++---
 var.c                     |   10 ++++++++++
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index e2f4c09..89e4b4f 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -36,6 +36,14 @@ GIT_AUTHOR_IDENT::
 GIT_COMMITTER_IDENT::
     The person who put a piece of code into git.
 
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
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *git_editor(void);
 
 struct checkout {
 	const char *base_dir;
diff --git a/editor.c b/editor.c
index facd7f2..9dcf95c 100644
--- a/editor.c
+++ b/editor.c
@@ -2,7 +2,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 
-int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+const char *git_editor(void)
 {
 	const char *editor, *terminal;
 
@@ -15,18 +15,30 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		editor = getenv("EDITOR");
 
 	terminal = getenv("TERM");
-	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
+	if (!editor && (!terminal || !strcmp(terminal, "dumb"))) {
 		/* Terminal is dumb but no VISUAL nor EDITOR defined. */
-		return error(
+		error(
 		  "No editor specified in GIT_EDITOR, core.editor, VISUAL,\n"
 		  "or EDITOR. Tried to fall back to vi but terminal is dumb.\n"
 		  "Please set one of these variables to an appropriate\n"
 		  "editor or run again with options that will not cause an\n"
 		  "editor to be invoked (e.g., -m or -F for git commit).");
+		return NULL;
+	}
 
 	if (!editor)
 		editor = "vi";
 
+	return editor;
+}
+
+int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+{
+	const char *editor = git_editor();
+
+	if (!editor)
+		return -1;
+
 	if (strcmp(editor, ":")) {
 		size_t len = strlen(editor);
 		int i = 0;
diff --git a/var.c b/var.c
index 125c0d1..342dc2c 100644
--- a/var.c
+++ b/var.c
@@ -8,6 +8,15 @@
 
 static const char var_usage[] = "git var [-l | <variable>]";
 
+static const char *editor(int flag)
+{
+	const char *pgm = git_editor();
+
+	if (!pgm && (flag & IDENT_ERROR_ON_NO_NAME))
+		die("cannot find a suitable editor");
+	return pgm;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -15,6 +24,7 @@ struct git_var {
 static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
+	{ "GIT_EDITOR", editor },
 	{ "", NULL },
 };
 
-- 
1.6.5.2

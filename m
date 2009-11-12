From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] Teach git var about GIT_PAGER
Date: Wed, 11 Nov 2009 18:02:09 -0600
Message-ID: <20091112000208.GF1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:52:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Myn-0008SD-GA
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759282AbZKKXvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758940AbZKKXvv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:51:51 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:51755 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758691AbZKKXvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:51:50 -0500
Received: by gxk26 with SMTP id 26so1570247gxk.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uykCSppBy7KdLB13thRHTvv8Sr1VJmJgiCj8a0p6MG4=;
        b=CoUK0TnQCDZJxR0LUVSiP1Y0687PuQcDAFcX0zP+7M2hRIxMT5BvcLPVu/pq0J6c7z
         Na383joo2pzp5q72O4EJRpAaHq4UpXZ2rrmMYxL8uxvk+sLrYn2GWtbNjI4FpzKOSuos
         lAfhuOtb1GNaXuE2n70aVofYzHcAYp7nnoYMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NwyGgYxprgmMhCdmR/K5VEXbrEhjoa8uVqrBCJGcBNoA738R6VKXTP2e6MBVYAB6Ij
         mRw1KRcDGH12jsOsnA1+mnybGVbG90chHUe3dH+dRBKaplgQXvPKJHfgSxgug9EoojGU
         Q5HB8hhexr6cFMlEr4mHUXHa41dlfDlqrX7PE=
Received: by 10.150.17.5 with SMTP id 5mr3910408ybq.195.1257983515803;
        Wed, 11 Nov 2009 15:51:55 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm996126gxk.2.2009.11.11.15.51.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:51:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132726>

Expose the command found by setup_pager() for scripts to use.
Scripts can use this to avoid repeating the logic to look for a
proper pager in each command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
The rest of the series is unchanged from pu.

 Documentation/git-var.txt |    6 ++++++
 cache.h                   |    1 +
 pager.c                   |   18 +++++++++++++++---
 var.c                     |   10 ++++++++++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 89e4b4f..ef6aa81 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -44,6 +44,12 @@ GIT_EDITOR::
     environment variable, then `core.editor` configuration, then
     `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
 
+GIT_PAGER::
+    Text viewer for use by git commands (e.g., 'less').  The value
+    is meant to be interpreted by the shell.  The order of preference
+    is the `$GIT_PAGER` environment variable, then `core.pager`
+    configuration, then `$PAGER`, and then finally 'less'.
+
 Diagnostics
 -----------
 You don't exist. Go away!::
diff --git a/cache.h b/cache.h
index 311cfe1..5aaa4ba 100644
--- a/cache.h
+++ b/cache.h
@@ -751,6 +751,7 @@ extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
+extern const char *git_pager(void);
 
 struct checkout {
 	const char *base_dir;
diff --git a/pager.c b/pager.c
index 86facec..0b63d99 100644
--- a/pager.c
+++ b/pager.c
@@ -44,12 +44,14 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
 
-void setup_pager(void)
+const char *git_pager(void)
 {
-	const char *pager = getenv("GIT_PAGER");
+	const char *pager;
 
 	if (!isatty(1))
-		return;
+		return NULL;
+
+	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
 			git_config(git_default_config, NULL);
@@ -60,6 +62,16 @@ void setup_pager(void)
 	if (!pager)
 		pager = "less";
 	else if (!*pager || !strcmp(pager, "cat"))
+		pager = NULL;
+
+	return pager;
+}
+
+void setup_pager(void)
+{
+	const char *pager = git_pager();
+
+	if (!pager)
 		return;
 
 	spawned_pager = 1; /* means we are emitting to terminal */
diff --git a/var.c b/var.c
index b502487..d9892f8 100644
--- a/var.c
+++ b/var.c
@@ -18,6 +18,15 @@ static const char *editor(int flag)
 	return pgm;
 }
 
+static const char *pager(int flag)
+{
+	const char *pgm = git_pager();
+
+	if (!pgm)
+		pgm = "cat";
+	return pgm;
+}
+
 struct git_var {
 	const char *name;
 	const char *(*read)(int);
@@ -26,6 +35,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
+	{ "GIT_PAGER", pager },
 	{ "", NULL },
 };
 
-- 
1.6.5.2

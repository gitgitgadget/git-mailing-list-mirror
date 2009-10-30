From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] Teach git var about GIT_PAGER
Date: Fri, 30 Oct 2009 05:29:22 -0500
Message-ID: <20091030102921.GE1610@progeny.tock>
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
X-From: git-owner@vger.kernel.org Fri Oct 30 11:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3oZi-0005Jd-SK
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 11:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756742AbZJ3KTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 06:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756711AbZJ3KTI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 06:19:08 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:50424 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680AbZJ3KTG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 06:19:06 -0400
Received: by ywh40 with SMTP id 40so2530813ywh.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5p56BtP/3AZbEbnA7k94VHiRlkw/ilZs2Z1bCOa74+w=;
        b=JuMUojoIKo+dQFGjCJljEOPMC/IK5512jBjiEiUIpgF1tWYIcmvx8vGwy1flawk8T6
         kulRIjxDzpqn6PKK+L5Q7NnZ0Nd/XHxRNk19bMYYS/MgtE0qwzXS/5HGNxzrVEz1aJCM
         pbtOiwVT/3bBMu4/N+/hJdDd1b5zux8qd1mTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZUPJ4MI5p1JUEti7RyBwbs35o2qd+Yak6hrgaRXYZByP/zCnRsTWdLgLogrRs8HT5Y
         1UOVGh4McldPgGIVqjvwCCddPlccj35K7FzpPlLcgVswvN9GIF7/SxmIVGqKDbfJtYYy
         /YUoekCTcon0tG5QC3rUkRBOcRvmufqsUIW6w=
Received: by 10.91.159.22 with SMTP id l22mr4000033ago.9.1256897950920;
        Fri, 30 Oct 2009 03:19:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm169844yxh.40.2009.10.30.03.19.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 03:19:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091030101634.GA1610@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131688>

Expose the command found by setup_pager() for scripts to use.
Scripts can use this to avoid repeating the logic to look for a
proper pager in each command.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
index 342dc2c..18dad57 100644
--- a/var.c
+++ b/var.c
@@ -17,6 +17,15 @@ static const char *editor(int flag)
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
@@ -25,6 +34,7 @@ static struct git_var git_vars[] = {
 	{ "GIT_COMMITTER_IDENT", git_committer_info },
 	{ "GIT_AUTHOR_IDENT",   git_author_info },
 	{ "GIT_EDITOR", editor },
+	{ "GIT_PAGER", pager },
 	{ "", NULL },
 };
 
-- 
1.6.5.2

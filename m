From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Mon, 26 Dec 2005 18:42:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512261840060.8240@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 26 18:42:58 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqwN5-00081o-IG
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 18:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVLZRmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 12:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVLZRmj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 12:42:39 -0500
Received: from mail.gmx.net ([213.165.64.21]:20453 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932071AbVLZRmi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Dec 2005 12:42:38 -0500
Received: (qmail invoked by alias); 26 Dec 2005 17:42:36 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp019) with SMTP; 26 Dec 2005 18:42:36 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14056>

[Sorry, this mail will probably be sent to you twice. The mailserver I 
use normally is kinda broken. It sends out the mails one or two days late, 
so paradoxically, the resent mail will arrive earlier than the original.]

Hi,

On Sat, 24 Dec 2005, Eric Wong wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> > 
> > > My home directories have different names on different machines I'm
> > > on, and I want to avoid having to recompile git for each one.
> > > I don't have root access to some of them, so installing globally in /usr
> > > or /usr/local isn't an option, either.
> > 
> > Then you probably need to use GIT_EXEC_PATH environment
> > variable.
> 
> That works with git.c but not init-db.  But then again I don't use
> git-init-db that often.  I'll just write a shell script wrapper for the
> latter if I do.

How about something like this?

---
[PATCH] Introduce environment variable for the path to the templates

The environment variable GIT_TEMPLATE_PATH can override the compiled-in
setting, and can be overridden with the '--template=' argument to init-db.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Eric said that GIT_EXEC_PATH is enough for most things, but not for
	init-db. I guess he wanted something like this.

 init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

5d95ce750b09a14bcb86e07ba23077ab0825089c
diff --git a/init-db.c b/init-db.c
index 863ec1a..774a91f 100644
--- a/init-db.c
+++ b/init-db.c
@@ -238,7 +238,7 @@ int main(int argc, char **argv)
 {
 	const char *git_dir;
 	const char *sha1_dir;
-	char *path, *template_dir = NULL;
+	char *path, *template_dir = getenv("GIT_TEMPLATE_PATH");
 	int len, i;
 
 	for (i = 1; i < argc; i++, argv++) {
-- 
1.0.GIT

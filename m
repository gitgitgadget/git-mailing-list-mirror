From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add strcpy_user_path() and use it in init-db.c and git.c
Date: Mon, 26 Dec 2005 17:40:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512261730170.7716@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224122016.GD3963@mail.yhbt.net> <7virtes6zd.fsf@assigned-by-dhcp.cox.net>
 <20051224195033.GE3963@mail.yhbt.net> <7vu0cyqk5d.fsf@assigned-by-dhcp.cox.net>
 <20051224211925.GH3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 26 17:40:30 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqvOX-0000PW-MK
	for gcvg-git@gmane.org; Mon, 26 Dec 2005 17:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVLZQkP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 11:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbVLZQkP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 11:40:15 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:18328 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932066AbVLZQkN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 11:40:13 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5769EE3C42; Mon, 26 Dec 2005 17:40:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 4A0FD297A;
	Mon, 26 Dec 2005 17:40:10 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 2AAF28F1;
	Mon, 26 Dec 2005 17:40:10 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BBA341412D8; Mon, 26 Dec 2005 17:40:09 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224211925.GH3963@mail.yhbt.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14054>

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

From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not show .exe in git command list.
Date: Fri, 18 Nov 2005 15:44:46 -0800
Message-ID: <7vacg1frm9.fsf_-_@assigned-by-dhcp.cox.net>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de>
	<7v7jb6o1kl.fsf@assigned-by-dhcp.cox.net> <437E5A79.9070402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 00:52:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdFuV-0006c2-DE
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVKRXos (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKRXos
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:44:48 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53499 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751213AbVKRXor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 18:44:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118234448.XDIY25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 18:44:48 -0500
To: git@vger.kernel.org
In-Reply-To: <437E5A79.9070402@gmail.com> (John Benes's message of "Fri, 18
	Nov 2005 16:49:29 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12290>

Truncate the result from readdir() in the exec-path if they end
with .exe, to make it a bit more readable on Cygwin.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Today I borrowed a Cygwin environment to build things without
 any customization (no config.mak nor make command line
 override), and I have to report that make test passed OK for
 me.

 git.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

applies-to: ff891e258456492507934e82d90fd8aacb124845
f9039f30d56e3815eaab870d8b19c7b94aded8aa
diff --git a/git.c b/git.c
index b9b8c62..bdd3f8d 100644
--- a/git.c
+++ b/git.c
@@ -59,7 +59,8 @@ static void add_cmdname(const char *name
 	if (!ent)
 		oom();
 	ent->len = len;
-	memcpy(ent->name, name, len+1);
+	memcpy(ent->name, name, len);
+	ent->name[len] = 0;
 	cmdname[cmdname_cnt++] = ent;
 }
 
@@ -132,6 +133,8 @@ static void list_commands(const char *ex
 			continue;
 
 		entlen = strlen(de->d_name);
+		if (4 < entlen && !strcmp(de->d_name + entlen - 4, ".exe"))
+			entlen -= 4;
 
 		if (longest < entlen)
 			longest = entlen;
---
0.99.9.GIT

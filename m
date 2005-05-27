From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] allow pathspec to end with a slash
Date: Thu, 26 May 2005 17:49:01 -0700
Message-ID: <7vis157ate.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 02:48:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbT0R-0007Hh-4o
	for gcvg-git@gmane.org; Fri, 27 May 2005 02:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVE0AtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVE0AtH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:49:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46274 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261307AbVE0AtD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 20:49:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527004902.MKAE1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 20:49:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 26 May 2005 17:41:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Recent rewrite broke "git-whatchanged -v -p drivers/usb/" but 
"git-whatchanged -v -p drivers/usb" still works.  Just strip out
the trailing slashes internally to make it work again.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - linus: [PATCH] Make ls-* output consistent with diff-* output format.
# + (working tree)
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -45,8 +45,12 @@ void diffcore_pathspec(const char **path
 	speccnt = i;
 	spec = xmalloc(sizeof(*spec) * speccnt);
 	for (i = 0; pathspec[i]; i++) {
+		int l;
 		spec[i].spec = pathspec[i];
-		spec[i].len = strlen(pathspec[i]);
+		l = strlen(pathspec[i]);
+		while (pathspec[i][l-1] == '/')
+			l--;
+		spec[i].len = l;
 	}
 
 	for (i = 0; i < q->nr; i++) {

Compilation finished at Thu May 26 17:46:56


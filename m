From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] allow pathspec to end with a slash (take #2)
Date: Thu, 26 May 2005 17:52:43 -0700
Message-ID: <7v7jhl7an8.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vis157ate.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 02:51:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbT3o-0007Xx-Iu
	for gcvg-git@gmane.org; Fri, 27 May 2005 02:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVE0Aws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 20:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVE0Aws
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 20:52:48 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4268 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261257AbVE0Awp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 20:52:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527005243.JGXE23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 20:52:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vis157ate.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 26 May 2005 17:49:01 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Oops, wrong patch; I am an idiot.

------------
Recent rewrite broke "git-whatchanged -v -p drivers/usb/" but 
"git-whatchanged -v -p drivers/usb" still works.  Just strip out
the trailing slashes internally to make it work again.

It uses compare-thing-with-number comparison order instead of
visual comparison order ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff 1: diffcore-pathspec.c
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
+		while (l > 0 && pathspec[i][l-1] == '/')
+			l--;
+		spec[i].len = l;
 	}
 
 	for (i = 0; i < q->nr; i++) {

Compilation finished at Thu May 26 17:50:40


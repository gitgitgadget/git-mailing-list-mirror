From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] ls-tree: Resurrect funny name quoting lost during rewrite.
Date: Mon, 28 Nov 2005 02:51:51 -0800
Message-ID: <7vwtitujso.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy83cdu7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
	<7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511260855560.13959@g5.osdl.org>
	<7vr792fnta.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511270949540.13959@g5.osdl.org>
	<20051127182244.GK22159@pasky.or.cz>
	<Pine.LNX.4.64.0511271049090.13959@g5.osdl.org>
	<7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511271742520.13959@g5.osdl.org>
	<7vpsol1ett.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511272219420.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 11:53:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eggc2-00013w-PD
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 11:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVK1Kvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVK1Kvy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 05:51:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53485 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751244AbVK1Kvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 05:51:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128105120.GUA15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 05:51:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511272219420.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Nov 2005 22:48:08 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12871>

The rewrite to match ls-files/diff-tree behaviour accidentally
lost the name quoting.  I am not proud about this code, but this
would get the test going.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-tree.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

applies-to: 4db95789ce3af40091ead2a97a72e75f9a0b8384
e7cdcbbbbd2fd2848244f998a0b92338fc68fe78
diff --git a/ls-tree.c b/ls-tree.c
index 4df5830..df3bcec 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -48,7 +48,15 @@ static int show_tree(unsigned char *sha1
 		type = "tree";
 	}
 
-	printf("%06o %s %s\t%.*s%s%c", mode, type, sha1_to_hex(sha1), baselen, base, pathname, line_termination);
+	printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
+	if (1) {
+		/* NEEDSWORK: */
+		char base_[baselen + 1];
+		memcpy(base_, base, baselen);
+		base_[baselen] = 0;
+		write_name_quoted(base_, pathname, line_termination, stdout);
+	}
+	putchar(line_termination);
 	return 0;
 }
 
---
0.99.9.GIT

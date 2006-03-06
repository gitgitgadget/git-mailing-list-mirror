From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] blame: unbreak "diff -U 0".
Date: Mon, 06 Mar 2006 00:45:01 -0800
Message-ID: <7vr75g6jxu.fsf@assigned-by-dhcp.cox.net>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Mon Mar 06 09:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBL7-00063j-HS
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 09:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbWCFIpE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 03:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbWCFIpE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 03:45:04 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45785 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1752286AbWCFIpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 03:45:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306084213.JFPD17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 03:42:13 -0500
To: git@vger.kernel.org
In-Reply-To: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 05 Mar 2006 23:13:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17285>

Junio C Hamano <junkio@cox.net> writes:

> The "deathmatch" between Ryan's annotate and Fredrik's blame is
> officially on.  Currently the last test in all three branches
> fail.  Please do not get alarmed.

It turns out the breakage was caused after merging Fredrik's
improvements.  I'm double-checking the fix and will be pushing
out corrected "master", "next" and "pu" shortly.

Sorry, Fredrik.

-- >8 --
Subject: [PATCH] blame: unbreak "diff -U 0".

The commit 604c86d15bb319a1e93ba218fca48ce1c500ae52 changed the
original "diff -u0" to "diff -u -U 0" for portability.

A big mistake without proper testing.

The form "diff -u -U 0" shows the default 3-line contexts,
because -u and -U 0 contradicts with each other; "diff -U 0" (or
its longhand "diff --unified=0") is what we meant.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 blame.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

690e307f54b4aa84349b89e8552b25e7495f1cd6
diff --git a/blame.c b/blame.c
index fca22f9..90338af 100644
--- a/blame.c
+++ b/blame.c
@@ -92,7 +92,7 @@ static struct patch *get_patch(struct co
 		die("write failed: %s", strerror(errno));
 	close(fd);
 
-	sprintf(diff_cmd, "diff -u -U 0 %s %s", tmp_path1, tmp_path2);
+	sprintf(diff_cmd, "diff -U 0 %s %s", tmp_path1, tmp_path2);
 	fin = popen(diff_cmd, "r");
 	if (!fin)
 		die("popen failed: %s", strerror(errno));
@@ -234,7 +234,7 @@ static void print_patch(struct patch *p)
 	}
 }
 
-#if 0
+#if DEBUG
 /* For debugging only */
 static void print_map(struct commit *cmit, struct commit *other)
 {
-- 
1.2.4.g3bcd

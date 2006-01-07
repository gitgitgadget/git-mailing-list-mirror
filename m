From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] tar-tree: finish honoring extractor's umask in git-tar-tree.
Date: Sat, 07 Jan 2006 15:21:46 -0800
Message-ID: <7vace7aak5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 00:21:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvNNg-0002Wf-UW
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 00:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWAGXVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 18:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWAGXVu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 18:21:50 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:3731 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1161050AbWAGXVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 18:21:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107231919.IHMP20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 18:19:19 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14285>

Earlier commit 38ec15a973a1f075f0d94d130b0ef279562921cd forgot
to apply the same principle of not forcing go-w to the base
directory when specified.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * This will be in fixes branch to be slurped into both maint
   and master.  Please do not extract the kernel tarball as root
   user, especially if you do not know how tar command works for
   root user by default (hint: --no-same-permissions).

 tar-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3ac0ebbba4d2d47ca2f4a674afead830f76ca256
diff --git a/tar-tree.c b/tar-tree.c
index 96bd143..f749d4b 100644
--- a/tar-tree.c
+++ b/tar-tree.c
@@ -433,7 +433,7 @@ int main(int argc, char **argv)
 		archive_time = time(NULL);
 	if (basedir)
 		write_header((unsigned char *)"0", TYPEFLAG_DIR, NULL, NULL,
-			basedir, 040755, NULL, 0);
+			basedir, 040777, NULL, 0);
 	traverse_tree(buffer, size, NULL);
 	free(buffer);
 	write_trailer();
-- 
1.0.7-g0263

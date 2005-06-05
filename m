From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Improve git-rev-list --header output
Date: Sun, 5 Jun 2005 15:25:16 +0200
Message-ID: <20050605132515.GB17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 15:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dev51-0007TH-6e
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 15:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFENZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFENZ2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 09:25:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:46490 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261561AbVFENZS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 09:25:18 -0400
Received: (qmail 1490 invoked by uid 2001); 5 Jun 2005 13:25:16 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Indent the commit header by four spaces like in the --pretty output;
the commit ID is still shown unaligned. This makes the --header output
actually usable for further processing.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 7c99469f9820f41138e1bfe1a0f416fa6b56d09d
tree ea9091df859f279e920ec0f8ca9fdc8d9d307e33
parent 441258d08a4bc12121c998e0aa112c8453eb15fc
author Petr Baudis <pasky@ucw.cz> Sun, 05 Jun 2005 15:24:25 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Sun, 05 Jun 2005 15:24:25 +0200

 rev-list.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -35,12 +35,34 @@ static void show_commit(struct commit *c
 	putchar('\n');
 	if (verbose_header) {
 		const char *buf = commit->buffer;
+		static char pretty_header[16384];
 		if (pretty_print) {
-			static char pretty_header[16384];
 			pretty_print_commit(commit->buffer, ~0, pretty_header, sizeof(pretty_header));
 			buf = pretty_header;
+		} else {
+			/* Indent the commit contents by four chars */
+			char *buf2 = pretty_header;
+			char *eol;
+			do {
+				int len = -1;
+
+				eol = strchr(buf, '\n');
+				if (eol || *buf) {
+					strcpy(buf2, "    ");
+					buf2 += 4;
+				}
+				if (eol) {
+					eol++;
+					len = eol - buf;
+					strncpy(buf2, buf, len);
+					buf2 += len;
+					buf = eol;
+				} else {
+					strcpy(buf2, buf);
+				}
+			} while (eol);
 		}
-		printf("%s%c", buf, hdr_termination);
+		printf("%s%c", pretty_header, hdr_termination);
 	}
 }
 

|
-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

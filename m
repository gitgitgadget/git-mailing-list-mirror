From: David Kastrup <dak@gnu.org>
Subject: [PATCH] builtin/blame.c::find_copy_in_blob: no need to scan for region end
Date: Sat, 22 Feb 2014 17:02:47 +0100
Message-ID: <1393084967-23408-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 17:03:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHF2e-0006oJ-V9
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 17:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbaBVQDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 11:03:00 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:45768 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaBVQC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 11:02:59 -0500
Received: from localhost ([127.0.0.1]:44810 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WHF2Y-0003Op-Hq; Sat, 22 Feb 2014 11:02:58 -0500
Received: by lola (Postfix, from userid 1000)
	id 1D3D0E067D; Sat, 22 Feb 2014 17:02:49 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242529>

The region end can be looked up just like its beginning.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 builtin/blame.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..96716dd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -939,7 +939,6 @@ static void find_copy_in_blob(struct scoreboard *sb,
 			      mmfile_t *file_p)
 {
 	const char *cp;
-	int cnt;
 	mmfile_t file_o;
 	struct handle_split_cb_data d;
 
@@ -950,13 +949,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 */
 	cp = nth_line(sb, ent->lno);
 	file_o.ptr = (char *) cp;
-	cnt = ent->num_lines;
-
-	while (cnt && cp < sb->final_buf + sb->final_buf_size) {
-		if (*cp++ == '\n')
-			cnt--;
-	}
-	file_o.size = cp - file_o.ptr;
+	file_o.size = nth_line(sb, ent->lno + ent->num_lines) - cp;
 
 	/*
 	 * file_o is a part of final image we are annotating.
-- 
1.8.3.2

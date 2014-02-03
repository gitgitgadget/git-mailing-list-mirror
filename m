From: David Kastrup <dak@gnu.org>
Subject: [PATCH 4/5] Performance improvement: don't drop origin blobs that are going to get tested next.
Date: Mon,  3 Feb 2014 20:14:08 +0100
Message-ID: <1391454849-26558-5-git-send-email-dak@gnu.org>
References: <1391454849-26558-1-git-send-email-dak@gnu.org>
Cc: David Kastrup <dak@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 20:14:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAOyX-0008LG-3K
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbaBCTOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:14:30 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:57355 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbaBCTO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:14:28 -0500
Received: from localhost ([127.0.0.1]:56393 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WAOyJ-0007G0-BY; Mon, 03 Feb 2014 14:14:19 -0500
Received: by lola (Postfix, from userid 1000)
	id E9F1AE86F9; Mon,  3 Feb 2014 20:14:18 +0100 (CET)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1391454849-26558-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241451>

---
 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e881b6e..0188115 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1435,7 +1435,8 @@ static void pass_blame(struct scoreboard *sb, struct origin *origin, int opt)
  finish:
 	for (i = 0; i < num_sg; i++) {
 		if (sg_origin[i]) {
-			drop_origin_blob(sg_origin[i]);
+			if (!sg_origin[i]->suspects)
+				drop_origin_blob(sg_origin[i]);
 			origin_decref(sg_origin[i]);
 		}
 	}
-- 
1.8.3.2

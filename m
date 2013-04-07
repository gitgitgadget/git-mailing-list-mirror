From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 1/2] bundle: Accept prerequisites without commit messages
Date: Sun,  7 Apr 2013 13:53:15 +0200
Message-ID: <1365335596-19917-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 13:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOoAB-0007UL-RO
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 13:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933591Ab3DGLx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 07:53:27 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:22771 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583Ab3DGLxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 07:53:21 -0400
Received: from localhost (p57B429B9.dip.t-dialin.net [87.180.41.185])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 310ab84a
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Sun, 7 Apr 2013 13:53:16 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220309>

While explicitly stating that the commit message in a prerequisite line
is optional, we required all lines with 40 or more characters to contain
a space after the object name, bailing out if a line consisted of an
object name only. Fix this off-by-one error and only require lines with
more than 40 characters to contain the separating space.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 bundle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle.c b/bundle.c
index 505e07e..4b0e5cd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -57,7 +57,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		 * followed by SP and subject line.
 		 */
 		if (get_sha1_hex(buf.buf, sha1) ||
-		    (40 <= buf.len && !isspace(buf.buf[40])) ||
+		    (buf.len > 40 && !isspace(buf.buf[40])) ||
 		    (!is_prereq && buf.len <= 40)) {
 			if (report_path)
 				error(_("unrecognized header: %s%s (%d)"),
-- 
1.8.2.675.gda3bb24.dirty

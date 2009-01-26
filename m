From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat() inside
 show_patch_diff()
Date: Mon, 26 Jan 2009 22:17:16 +0100
Message-ID: <1233004637-15112-6-git-send-email-barvik@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:19:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYrH-0000UB-90
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbZAZVRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZAZVRd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:17:33 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62238 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbZAZVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:17:30 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003U0KH2XC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:26 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3001KZKGTUNC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:26 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107284>

Currently inside show_patch_diff() we have and fstat() call after an
ok lstat() call.  Since we before the call to fstat() have already
test for the link case with S_ISLNK() the fstat() can be removed.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 combine-diff.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bccc018..ab4df31 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -713,9 +713,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result_size = buf.len;
 			result = strbuf_detach(&buf, NULL);
 			elem->mode = canon_mode(st.st_mode);
-		}
-		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
-			 !fstat(fd, &st)) {
+
+		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
 			ssize_t done;
 			int is_file, i;
-- 
1.6.1.349.g99fa5

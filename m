From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 8/9] show_patch_diff(): remove a call to fstat()
Date: Mon, 09 Feb 2009 21:54:52 +0100
Message-ID: <0b2bf9500731f079b5e711a8ee7da692da1ee865.1234211595.git.barvik@broadpark.no>
References: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdB6-0002TR-3x
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbZBIUzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbZBIUzA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:55:00 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36121 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZBIUy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:54:59 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IFKGRKPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:56 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007G9GRH8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:56 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234211594.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109125>

Currently inside show_patch_diff() we have an fstat() call after an
ok lstat() call.  Since before the call to fstat() we have already
tested for the link case with S_ISLNK(), the fstat() can be removed.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 combine-diff.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bccc018..4300319 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -713,9 +713,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			result_size = buf.len;
 			result = strbuf_detach(&buf, NULL);
 			elem->mode = canon_mode(st.st_mode);
-		}
-		else if (0 <= (fd = open(elem->path, O_RDONLY)) &&
-			 !fstat(fd, &st)) {
+		} else if (0 <= (fd = open(elem->path, O_RDONLY))) {
 			size_t len = xsize_t(st.st_size);
 			ssize_t done;
 			int is_file, i;
-- 
1.6.1.349.g99fa5

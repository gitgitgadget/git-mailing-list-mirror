From: David Brown <git@davidb.org>
Subject: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 11:15:03 -0700
Message-ID: <119022570352-git-send-email-git@davidb.org>
Cc: David Brown <git@davidb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 21:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4g9-0002D7-6J
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 20:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbXISSxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbXISSxg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 14:53:36 -0400
Received: from mail.davidb.org ([66.93.32.219]:58139 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbXISSxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 14:53:35 -0400
X-Greylist: delayed 2308 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2007 14:53:35 EDT
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY44l-0000Fk-Az; Wed, 19 Sep 2007 11:15:03 -0700
X-Mailer: git-send-email 1.4.4.4
In-Reply-To: 20070919171243.GA23902@old.davidb.org
References: 20070919171243.GA23902@old.davidb.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58722>

git-p4 was missing the execute bit setting if the file had other attribute
bits set.
---
 contrib/fast-import/git-p4 |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index adaaae6..50850b8 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -932,7 +932,10 @@ class P4Sync(Command):
                 data = file['data']
 
                 mode = "644"
-                if file["type"].startswith("x"):
+                if (file["type"].startswith("x") or
+                        file["type"].startswith("cx") or
+                        file["type"].startswith("kx") or
+                        file["type"].startswith("ux")):
                     mode = "755"
                 elif file["type"] == "symlink":
                     mode = "120000"
-- 
1.5.3.1

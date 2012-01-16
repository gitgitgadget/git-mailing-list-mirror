From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/4] git-p4: cope with labels with empty descriptions
Date: Mon, 16 Jan 2012 23:14:47 +0000
Message-ID: <1326755689-3344-3-git-send-email-luke@diamand.org>
References: <1326755689-3344-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 00:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmvlt-0008II-N2
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541Ab2APXPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 18:15:18 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48124 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2APXPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:15:06 -0500
Received: by wgbgn7 with SMTP id gn7so1899433wgb.1
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:15:05 -0800 (PST)
Received: by 10.180.84.133 with SMTP id z5mr18433767wiy.10.1326755704984;
        Mon, 16 Jan 2012 15:15:04 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id hv1sm13727543wib.1.2012.01.16.15.15.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 15:15:04 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1326755689-3344-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188672>

Use an explicit length for the data in a label, rather
than EOT, so that labels with empty descriptions are
passed through correctly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 822e6f1..f7707f2 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1741,9 +1741,11 @@ class P4Sync(Command, P4UserMap):
                     else:
                         tagger = "%s <a@b> %s %s" % (owner, epoch, self.tz)
                     self.gitStream.write("tagger %s\n" % tagger)
-                    self.gitStream.write("data <<EOT\n")
-                    self.gitStream.write(labelDetails["Description"])
-                    self.gitStream.write("EOT\n\n")
+
+                    description = labelDetails["Description"]
+                    self.gitStream.write("data %d\n" % len(description))
+                    self.gitStream.write(description)
+                    self.gitStream.write("\n")
 
                 else:
                     if not self.silent:
-- 
1.7.8.rc1.209.geac91.dirty

From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/4] git-p4: cope with labels with empty descriptions
Date: Wed, 30 Nov 2011 09:03:35 +0000
Message-ID: <1322643817-13051-3-git-send-email-luke@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVg5m-0005Gg-Hv
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 10:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab1K3JEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 04:04:30 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757213Ab1K3JE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 04:04:26 -0500
Received: by mail-bw0-f46.google.com with SMTP id s6so570681bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 01:04:25 -0800 (PST)
Received: by 10.204.155.141 with SMTP id s13mr1348001bkw.40.1322643865609;
        Wed, 30 Nov 2011 01:04:25 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id c4sm2565364bkk.13.2011.11.30.01.04.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 01:04:24 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1322643817-13051-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186119>

Use an explicit length for the data in a label, rather
than EOT, so that labels with empty descriptions are
passed through correctly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index bcac6ec..02f0f54 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1511,9 +1511,11 @@ class P4Sync(Command, P4UserMap):
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

From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 2/4] git-p4: cope with labels with empty descriptions
Date: Mon,  7 Nov 2011 21:36:37 +0000
Message-ID: <1320701799-26071-3-git-send-email-luke@diamand.org>
References: <1320701799-26071-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 22:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWsd-0003FH-Pd
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab1KGVhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 16:37:01 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33354 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1KGVhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:37:00 -0500
Received: by mail-wy0-f174.google.com with SMTP id 15so4955595wyh.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 13:37:00 -0800 (PST)
Received: by 10.216.176.16 with SMTP id a16mr1098850wem.111.1320701819650;
        Mon, 07 Nov 2011 13:36:59 -0800 (PST)
Received: from localhost.localdomain (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id b5sm29264775wbh.4.2011.11.07.13.36.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 13:36:58 -0800 (PST)
X-Mailer: git-send-email 1.7.7.295.g34dd4
In-Reply-To: <1320701799-26071-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185033>

Use an explicit length for the data in a label, rather
than EOT, so that labels with empty descriptions are
passed through correctly.
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
1.7.7.295.g34dd4

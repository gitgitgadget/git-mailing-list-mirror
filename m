From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 2/5] git-p4: cope with labels with empty descriptions
Date: Thu, 19 Jan 2012 09:52:26 +0000
Message-ID: <1326966749-9077-3-git-send-email-luke@diamand.org>
References: <1326966749-9077-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnofw-00023s-C0
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511Ab2ASJww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 04:52:52 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:46638 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab2ASJwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:52:42 -0500
Received: by werb13 with SMTP id b13so1052333wer.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:52:40 -0800 (PST)
Received: by 10.216.139.217 with SMTP id c67mr160028wej.21.1326966760806;
        Thu, 19 Jan 2012 01:52:40 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id bj10sm27093411wib.9.2012.01.19.01.52.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 01:52:40 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1326966749-9077-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188801>

Use an explicit length for the data in a label, rather
than EOT, so that labels with empty descriptions are
passed through correctly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 163e95a..5b59bc8 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1752,9 +1752,11 @@ class P4Sync(Command, P4UserMap):
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

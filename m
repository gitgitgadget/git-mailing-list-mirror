From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v2 1/3] git-p4: Add checkpoint() task
Date: Sat, 21 Jan 2012 00:21:30 +0000
Message-ID: <1327105292-30092-2-git-send-email-vitor.hda@gmail.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:22:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOif-0005rg-Hb
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670Ab2AUAWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:22:07 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58535 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab2AUAV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:21:56 -0500
Received: by wics10 with SMTP id s10so876969wic.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 16:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/CLlxe8XFfqdJtWBkGOHBxic4Ehff+xnlAPkjRNn5t4=;
        b=kU0J58Xa0o77wM2qggE4qBAfwhRwa/HZW0JP+vGPVroekWvD3oYOJXOJD7yY6uM29j
         OiNOsbBZHJQvxTNaY7UHlp9Ar7GQnvaakygZmGxhU15rwrJemC1xSru/pF4Jz/7wcqF4
         uWBrLPZgxo5UJ8NTgyBzuoqGdxmvVr95YKfsg=
Received: by 10.180.106.202 with SMTP id gw10mr1243264wib.3.1327105315337;
        Fri, 20 Jan 2012 16:21:55 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q7sm566234wix.5.2012.01.20.16.21.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 16:21:54 -0800 (PST)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188912>

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3e1aa27..417d119 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1450,6 +1450,14 @@ class P4Sync(Command, P4UserMap):
                    .replace("%25", "%")
         return path
 
+    # Force a checkpoint in fast-import and wait for it to finish
+    def checkpoint(self):
+        self.gitStream.write("checkpoint\n\n")
+        self.gitStream.write("progress checkpoint\n\n")
+        out = self.gitOutput.readline()
+        if self.verbose:
+            print "checkpoint finished: " + out
+
     def extractFilesFromCommit(self, commit):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
-- 
1.7.7.rc2.14.g5e044.dirty

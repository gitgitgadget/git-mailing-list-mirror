From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/3] git-p4: Add checkpoint() task
Date: Mon, 16 Jan 2012 00:39:18 +0000
Message-ID: <1326674360-2771-2-git-send-email-vitor.hda@gmail.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 01:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmac6-000672-IH
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 01:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab2APAjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 19:39:48 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:41578 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab2APAjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 19:39:47 -0500
Received: by werb13 with SMTP id b13so1632821wer.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4APExAHfVlsX3HY42rmFSY1otmQXaO95agkRFB7b2vs=;
        b=dVdWL8eUcOaqdcnmEYXETG6x18x8SZzS6vti+Uzp6vvUl+yR10LmHhgg/B8r0dzRzk
         EU8rWHjNjo/kbX3+WlDA4aDH1LnG0898TbIvJmJ/L4gXNiNieeZOJmLPcqbPUoc80QL/
         NxV6dLE7hsPbc3HsJrEX/3YUKeDN658KyWjF4=
Received: by 10.180.100.234 with SMTP id fb10mr10799275wib.5.1326674386287;
        Sun, 15 Jan 2012 16:39:46 -0800 (PST)
Received: from fenix.lan (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id q5sm20225601wbo.8.2012.01.15.16.39.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 16:39:45 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188602>

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
1.7.8.3

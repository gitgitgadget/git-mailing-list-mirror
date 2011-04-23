From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 06/23] Introduce --rebasing
Date: Sat, 23 Apr 2011 17:22:35 +1000
Message-ID: <1303543372-77843-7-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCR-0004jf-QP
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab1DWHYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:06 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:34280 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1DWHYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:03 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so862616pxi.10
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Y3r35cFJlbcmDiYwxF4arB07rKWPglZeBPTpvbpMiu4=;
        b=WY9eWT7Rw5yrl86QWLeF/mllanu8y61C92ecX2pXnGmK+f3LP2DBvj4EdG9rQTpN+N
         b6mrEyViONjDVBTk1+o6t6IT+yotElNME9MMxdecrg0Qt3Jkj6XiteqFUD7xPAjmF0XV
         SAvFYgFshK/EiXRzd2KIdMBBgvHRqI+Q1SO5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KfACBrTThFlVMvZzlEl/WdfmIExcdQykOftiAB+gFFw1Ss8rv3YkUD1ywv5R5gBGds
         xpzjkMZP9fiJUS5k47WMqymgLLJvDzO4TKZ2oDs8alWJ7P2o07Wv+tt/Qh9NjguCvC9n
         sRGVZmxNITCasUY2kfITZUYizMC7TK5w5uvlk=
Received: by 10.68.48.228 with SMTP id p4mr603869pbn.490.1303543442763;
        Sat, 23 Apr 2011 00:24:02 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171959>

---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 4f86265..e872608 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -72,6 +72,8 @@ CONDITIONS
 	Tests if there are (not) any untracked files in the working tree.
 '--conflicted'|'--not-conflicted'::
 	Tests if there are (not) any merge conflicts in the index.
+'--rebasing'|'--not-rebasing'::
+        Tests if a rebase is (not) in progress.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 7f3724e..0d6e0a1 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -53,5 +53,16 @@ check_conflicted_0()
 
 }
 
+check_rebasing_0()
+{
+	if test -d "$(git rev-parse --git-dir)/rebase-apply"
+	then
+		echo "A rebase is in progress."
+	else
+		echo "There is no rebase in progress."
+		false
+	fi
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622

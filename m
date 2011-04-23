From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 05/23] Introduce --conflicted
Date: Sat, 23 Apr 2011 17:22:34 +1000
Message-ID: <1303543372-77843-6-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:24:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXCS-0004jf-CN
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab1DWHYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:09 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab1DWHX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:23:59 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qBwKeAWc16A5RlVRhAU3OPo1vkDdDBbWoyvCS0UhCGo=;
        b=nGYYBB/e9L8LPqBdx4lpVcCNThpZMpW6m/Ar/kBBgpGyNQeR1HRiI4tmIVvzNcZsqQ
         DizOuG+HvmGC7d9Khp4xEIypQCw9y6HPCKkpkNDAGJhohFVISbcg4s/w+yaXvd8OWcaH
         Og1IjEqrnBWWeA8V7Wbw/F0HpmEOaQKKmmd4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JU1dd2I4ZYWzCOsU8dttdNN1gYI16Qr9KDahC2fMY/imwqckanbbq7juOwAc/jOC4G
         jzrm+NdksSEBKUzIFPddQftTCxXWMDdUcRQKuH9hS7nJQEXcBZbS2hB8UBLL/ZjYV56d
         dD2hRZLEDst4fnXJWjFLC5EVBl8GKXjAilvBo=
Received: by 10.68.30.68 with SMTP id q4mr3082649pbh.435.1303543439313;
        Sat, 23 Apr 2011 00:23:59 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.23.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:23:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171960>

---
 Documentation/git-test.txt |    2 ++
 git-conditions-lib.sh      |   12 ++++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-test.txt b/Documentation/git-test.txt
index 9f6a4c3..4f86265 100644
--- a/Documentation/git-test.txt
+++ b/Documentation/git-test.txt
@@ -70,6 +70,8 @@ CONDITIONS
         Tests if there are (not) any staged changes in the index.
 '--untracked'|'--not-untracked'::
 	Tests if there are (not) any untracked files in the working tree.
+'--conflicted'|'--not-conflicted'::
+	Tests if there are (not) any merge conflicts in the index.
 
 EXTENDING THE CONDITION LIBRARY
 -------------------------------
diff --git a/git-conditions-lib.sh b/git-conditions-lib.sh
index 7198e6a..7f3724e 100644
--- a/git-conditions-lib.sh
+++ b/git-conditions-lib.sh
@@ -41,5 +41,17 @@ check_untracked_0()
 	fi
 }
 
+check_conflicted_0()
+{
+	if test $(git ls-files --unmerged | wc -l) -ne 0
+	then
+		echo "There are unmerged files."
+	else
+		echo "There are no unmerged files."
+		false
+	fi
+
+}
+
 
 fi
-- 
1.7.5.rc1.23.g7f622

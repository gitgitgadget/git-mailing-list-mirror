From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe@aidecoe.name>
Subject: [PATCH] git-p4.py: Don't try to rebase on submit from bare repository
Date: Wed, 17 Feb 2016 22:46:00 +0000
Message-ID: <1455749160-2017-1-git-send-email-aidecoe@aidecoe.name>
Cc: aidecoe@aidecoe.name
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 00:08:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXgr-00087f-J8
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947536AbcBRXIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:08:49 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:45300 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947316AbcBRXIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:08:48 -0500
X-Greylist: delayed 6748 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Feb 2016 18:08:48 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Message-Id:Date:Subject:Cc:To:From; bh=6lSF+YDB1TORxh6jDLI+9F8nNPJo72D499+07sW6p2w=;
	b=SRqyYr7ktYsIbpXWK39/IWh5e7PYDq6sS5Ec7dk6cjEr9A+K7GeXHWX4atUq0GoeFdXjnWP+Suc19A7jVDIjmITaS1Cb1wQGt5eVUgzh4bhKRlJNzObkudjPLxA0Jfrb+YKkuPy94DklwxMMuyVjaPrAEOoOZodvno+9lWT/pYOSMM/fKX/kSa0Q493Za++OjwQdpLpcAUH5c1OJ7tipnaegfBNWspTn2oLr5+j9UAQQZ96u8b9YX1K0inHXh2oKU0vMJzQyrUFyHGX+BdjQEEFOIEsMAqLbpjelEjOXiBcDHWmpdF6nT/HQHWOJ6sR4uHrGdjBGsyRkNAAMcjoxlQ==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aWArP-0000nQ-Fn; Wed, 17 Feb 2016 23:46:16 +0100
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286637>

git-p4 can be successfully used from bare repository (which acts as a
bridge between Perforce repository and pure Git repositories). On submit
git-p4 performs unconditional rebase. Do rebase only on non-bare
repositories.
---
 git-p4.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c33dece..e00cd02 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2059,8 +2059,9 @@ class P4Submit(Command, P4UserMap):
                 sync.branch = self.branch
             sync.run([])
 
-            rebase = P4Rebase()
-            rebase.rebase()
+            if not gitConfigBool("core.bare"):
+                rebase = P4Rebase()
+                rebase.rebase()
 
         else:
             if len(applied) == 0:
-- 
2.7.0

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] remote-hg: add support for hg v3.0
Date: Sat,  3 May 2014 21:16:54 -0500
Message-ID: <1399169814-20201-5-git-send-email-felipe.contreras@gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 04:27:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgm9l-0005zA-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 04:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbaEDC1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 22:27:49 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:40900 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaEDC1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 22:27:48 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so2591409oag.27
        for <git@vger.kernel.org>; Sat, 03 May 2014 19:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gQmOhs7oXglbSFjph20Y0VLHp1m6U8rZ1vIuslaG+EU=;
        b=r7iyMqPwANhZAiTG0dj0xrfqnTLC9QbmFwlb3nFLRxPPCd2ATFidZW+OtTemZtCVZK
         W58CBP1vbeeNh89G8uRSGqA1gGXAIeS6lBkR6eEWVEWvBjPjovL4zPapY215V83rkTvI
         w68kL6S8rXEoSTv+N/u+RcydkmwVMuhkxlcsOEB26/eXvPzQca76zehNjFU9GPjJitkJ
         SrL8sg1mBIKzWvzfdN980nH1/AvFj8wOnl19Sm+1HApDAKNpdv0m40mYFQQ4+r3T1KVk
         CjHVdprddbHRzD47wJh28ZxvOPO145MSft9a4eT2TQ2/ACLbOOWXKwIp9xa+M0wJCetG
         9pNQ==
X-Received: by 10.182.165.3 with SMTP id yu3mr23638123obb.14.1399170468354;
        Sat, 03 May 2014 19:27:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm8987879obb.14.2014.05.03.19.27.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 19:27:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248065>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 34cda02..8b02803 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -13,6 +13,7 @@
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
 from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
+from mercurial import changegroup
 
 import re
 import sys
@@ -985,7 +986,10 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     if not checkheads(repo, remote, p_revs):
         return None
 
-    cg = repo.getbundle('push', heads=list(p_revs), common=common)
+    if check_version(3, 0):
+        cg = changegroup.getbundle(repo, 'push', heads=list(p_revs), common=common)
+    else:
+        cg = repo.getbundle('push', heads=list(p_revs), common=common)
 
     unbundle = remote.capable('unbundle')
     if unbundle:
-- 
1.9.2+fc1.20.g204a630

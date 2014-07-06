From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 2/4] test-dump-cache-tree: invalid trees are not errors
Date: Sat,  5 Jul 2014 21:06:57 -0700
Message-ID: <1404619619-4774-2-git-send-email-dturner@twitter.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 06:07:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3djj-0005L2-Mb
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 06:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbaGFEH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 00:07:29 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52706 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbaGFEH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 00:07:28 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so3676232pad.28
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 21:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DsGOu/w6S6/9j/aK/nor1t7zCeNTe4yUH/dhrmfaeUI=;
        b=T4ZyYSUqqRrpOPgB0pCoj1unCHM8fOK08Zt9whIxG6YzoGEuLH4rpLRxWiexNXsMyN
         h/PD1gKbspAHsjJ67HH37y/bTlLjlC5c57xQ250hl/J2ee4sFo4HyKe1ctz8+6KM1c9p
         DbijXf4sO6z72W2XBCaiOScCEYDJ46F90oO/RikElZg/HrGK0pMJIos7JfqvyD/ZkQOQ
         SlHUn09xmrYnQ54sLn1g4Mu2mIeJxzTNtoF3HKCsOgGeCAPLLxk/FzcVAmSsF6JIuo/7
         Z0j7/yklAwBxfjFJRPArpQoDdWXE8z128gJ6YD7tyt7qsgDrxKTYRf4d2aFN7PyW5iEI
         2DFg==
X-Gm-Message-State: ALoCoQmODyZ9tO7dRFZX33YJpGK41OoQeU22PbStC71XtKILAlUWAPfpxdc/q+6biCNb347flVm3
X-Received: by 10.68.97.129 with SMTP id ea1mr10355598pbb.73.1404619647667;
        Sat, 05 Jul 2014 21:07:27 -0700 (PDT)
Received: from stross.twitter.corp (c-67-169-40-58.hsd1.ca.comcast.net. [67.169.40.58])
        by mx.google.com with ESMTPSA id by1sm48542593pbb.75.2014.07.05.21.07.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Jul 2014 21:07:26 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404619619-4774-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252925>

Do not treat known-invalid trees as errors even when their count is
incorrect.  Because git already knows that these trees are invalid,
nothing depends on the count field.

Add a couple of comments.

Signed-off-by: David Turner <dturner@twitter.com>
---
 test-dump-cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 47eab97..cbbbd8e 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -26,16 +26,16 @@ static int dump_cache_tree(struct cache_tree *it,
 		return 0;
 
 	if (it->entry_count < 0) {
+		/* invalid */
 		dump_one(it, pfx, "");
 		dump_one(ref, pfx, "#(ref) ");
-		if (it->subtree_nr != ref->subtree_nr)
-			errs = 1;
 	}
 	else {
 		dump_one(it, pfx, "");
 		if (hashcmp(it->sha1, ref->sha1) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
+			/* claims to be valid but is lying */
 			dump_one(ref, pfx, "#(ref) ");
 			errs = 1;
 		}
-- 
2.0.0.390.gcb682f8

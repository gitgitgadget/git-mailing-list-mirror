From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 2/4] test-dump-cache-tree: invalid trees are not errors
Date: Fri, 11 Jul 2014 16:22:25 -0700
Message-ID: <1405120947-3142-2-git-send-email-dturner@twitter.com>
References: <1405120947-3142-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 01:23:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5k9b-00078d-WB
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbaGKXWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:22:54 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:57246 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbaGKXWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:22:51 -0400
Received: by mail-qa0-f41.google.com with SMTP id j7so810828qaq.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 16:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CtD3/BLkZVb7f30z6OgIhJRvnqz5cgQFgxg1ANEcKc=;
        b=ByAdFqXFYGYD/DdOy7FFKOiiRYRKdIR5qRoBmlbPuBPZJsWc5QBvwZQwqHTWrO8yS7
         7kY7y+56GXJFQP8J5/0tOrnbeHIyEVpCHOi0b6oQ4R3obO9Pa9CRXsuxdFLW6VsDEnpT
         CM4gbj0j5YMqyflNyY2CPeA4obQZGYpH8XTQOYAZJqMK5vr+oqREmYuN/BCtuL+7crze
         GHG+qTElaI9p2/LcdZrkl2aI7iCKLD0uBrhox8M9n/iz1oCTWLI5r/KdM/7ouA4za4xN
         71P3S34zixeiPpTHrCOe5udE9i4LSgmuAEVvQai7Lhea0duKwUxQ3DFmNJA0cnBcAq/o
         7mWA==
X-Gm-Message-State: ALoCoQmFMGYLVlrh6HNt+glYojYzwvRtxwUXP4qOqljVZ2tgTMiG8u6vmymGS2raA/bke/mmWuU2
X-Received: by 10.224.11.196 with SMTP id u4mr647607qau.101.1405120970747;
        Fri, 11 Jul 2014 16:22:50 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id k7sm6652126qas.24.2014.07.11.16.22.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 16:22:50 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405120947-3142-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253351>

Do not treat known-invalid trees as errors even when their subtree_nr is
incorrect.  Because git already knows that these trees are invalid,
an incorrect subtree_nr will not cause problems.

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

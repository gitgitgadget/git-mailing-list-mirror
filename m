From: David Turner <dturner@twopensource.com>
Subject: [PATCH 2/4 v6] test-dump-cache-tree: invalid trees are not errors
Date: Thu, 10 Jul 2014 17:31:24 -0700
Message-ID: <1405038686-1138-2-git-send-email-dturner@twitter.com>
References: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 02:32:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Oks-0002jd-OD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbaGKAbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:31:55 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:41601 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaGKAby (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:31:54 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so329196qgd.5
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 17:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CtD3/BLkZVb7f30z6OgIhJRvnqz5cgQFgxg1ANEcKc=;
        b=So2kt4SjZplucf6WHErIYNXpshQ2BZnFLft/MDGXwjvIKAkh0QhluRUKXquwB56zOQ
         yPymYETJLe8wrNdx/GZOSnwXDxZ4L7fAv7rd4fLyPwNMI+f0Hp1Ziu02qijndioroxLT
         ZQ4V6dndPjxx1g1Ze/rYra+mZeqtLVwW/Eim2dWECuIwf/jhHUz6sw5b2NwcFVz36+d6
         gqmE3/22z2BXTl/InAO3GlymF6deXrZieTpesOyetqx1X43wiszCRl7wt0Ye/iPLkMIm
         fNuv2kkNV1rHbHTOGOLHdiOvRXTFNECPVbUFst7pvAbCnNdR9exHdymUv6RVUWf9skjC
         1sKA==
X-Gm-Message-State: ALoCoQmsgvtPd8lZQ7xhcxbOs0vP/WlLoDJybwgTfPymjFRleThPSE8jQ4gOGmgGRvFjC0nYLTgS
X-Received: by 10.229.191.135 with SMTP id dm7mr82968305qcb.9.1405038714262;
        Thu, 10 Jul 2014 17:31:54 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id s62sm752254qga.28.2014.07.10.17.31.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jul 2014 17:31:53 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253244>

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

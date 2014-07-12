From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 2/4] test-dump-cache-tree: invalid trees are not errors
Date: Fri, 11 Jul 2014 21:44:34 -0700
Message-ID: <1405140276-32162-2-git-send-email-dturner@twitter.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 06:45:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5pBW-0000DG-Qy
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 06:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbaGLEpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 00:45:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40277 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaGLEpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 00:45:01 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so2557556pad.9
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 21:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CtD3/BLkZVb7f30z6OgIhJRvnqz5cgQFgxg1ANEcKc=;
        b=h2dC1Qg1kkhnRM24XHWatxFtC8GFyB7OuhapPAJyPgUOVMuq/Yto9MDl8EhYmhJxTK
         +N9v8JmSNbreyXYGfmGRbrnSrJYpIQvuqT//ANsVC3WYT257UUq7wvSS7Vn7SEZKBmPj
         wSyW9RxVBe1LcCQiwjbcPhCP/I24si5C9Pys30+/6UBJ9LB4oQrIQwcnjOfm4dsRPLrQ
         pC1sN1FGY2wFhED7RIkvtqcsCfFobXVBGqGEZefvvxjgVcab/aKYJt0U1z7SC+1EHhHI
         fzJ0Aq4eoKNbaLU+E0MIpyAd2q83cadoExkcWsTPYl/LnehGcnYxrPKbZqNLO7trihGt
         k//Q==
X-Gm-Message-State: ALoCoQlH7DTRyaA0uESakTYi36gricj/T5gZIYusT61Dw6meSOGgqmPzoZHEu3l5ob9KkOxuVB0y
X-Received: by 10.68.103.228 with SMTP id fz4mr3327124pbb.46.1405140300645;
        Fri, 11 Jul 2014 21:45:00 -0700 (PDT)
Received: from stross.twitter.corp (50-206-59-106-static.hfc.comcastbusiness.net. [50.206.59.106])
        by mx.google.com with ESMTPSA id fl6sm16828665pab.43.2014.07.11.21.44.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 21:44:59 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405140276-32162-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253377>

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

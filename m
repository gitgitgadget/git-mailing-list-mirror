From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 2/4] test-dump-cache-tree: invalid trees are not errors
Date: Sun, 13 Jul 2014 13:28:17 -0700
Message-ID: <1405283299-25636-2-git-send-email-dturner@twitter.com>
References: <1405283299-25636-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 22:28:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6QO2-00012P-Ka
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 22:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaGMU2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 16:28:38 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53500 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMU2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 16:28:36 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so2843038pab.6
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 13:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILpFSI++CwYoLSuxTDD5Eb0CTT4BigdpF2WiXWdOAQU=;
        b=gEhMXe2LQj7er8lIYJGGrEAv/oRlwwPW6+Nl+NXDnvvyvJgjBWyrV44Myt816eNLra
         VG9moPRJmKbVvfMZCE4FvY0WYQMOIc8QhDoprgkPp7R81I5ABIZIHyuzm9802a5ffk3S
         ptfbVQQsEky0nvtUghkdMwBQV4+RvPySLuMkK1FlPZn7Fp2iqemi2w9Yu2uEBV4mhA1R
         fgEnPS2lZ8IQkx/UKwJaH9piaYzLdz2zOqq55G6B3eF6wen7VzlVg+N7V1V7yn32Ogs1
         d3otKSc2PeR2YXwilEpz3+kncbYK0Vi8oQXBqows4QQy6UpgN1mVxvWtHdiW6g5J7xMG
         PQ/Q==
X-Gm-Message-State: ALoCoQnZBu6wdkt/aGcsvEqekHNLKI/C1RkEhj+Z4bCO0TIMyR5uZuiUACdzVwHRGLWdZJIoo4tL
X-Received: by 10.70.88.17 with SMTP id bc17mr12258029pdb.45.1405283316215;
        Sun, 13 Jul 2014 13:28:36 -0700 (PDT)
Received: from stross.twitter.corp (mobile-166-137-185-178.mycingular.net. [166.137.185.178])
        by mx.google.com with ESMTPSA id jb5sm8609217pbd.73.2014.07.13.13.28.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Jul 2014 13:28:34 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1405283299-25636-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253458>

From: David Turner <dturner@twopensource.com>

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

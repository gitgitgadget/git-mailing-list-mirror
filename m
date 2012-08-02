From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 05/16] t2104: Don't fail when index version is 5
Date: Thu,  2 Aug 2012 13:01:55 +0200
Message-ID: <1343905326-23790-6-git-send-email-t.gummerer@gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 13:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwtBT-00056m-4O
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 13:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598Ab2HBLDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 07:03:01 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44602 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2HBLC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 07:02:59 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so2331146eei.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=B2eJcMSwBrhah167oydrWrBhGbNqFrZzY9E3nMCnUqU=;
        b=rw7nZa4UPyBuglFm4rDFSnFUFmOy6SVI+eZEbT7+HfixIvPpMHxaC9U8IzR1Fs3Joi
         SceNK7BCu0P6Lds/0GGU/qojS3B0sD9JRGwvQJQ3eUPlg1GAtyqX6p4ASd/9ELSWGHEe
         +9+esjeQ1nXP1aGDytGy9LsXNgceico3Z/vVKBUxR1IJG1NbmRhkQt7d4YDm51rqNLKp
         0lyDxUnoCWrD0EN1APm+9sacT8y0Mva0+EUCOdklGxuL9R5CfZ7hEwOPcLCuZNxXqy4z
         phr1FZ4M8QBIBX/q3S7FeNKiXLP5RuCgmmSPmx3xqu3Cr6nA2PKKbd5csFwHU0lBr2vH
         fbhA==
Received: by 10.14.202.69 with SMTP id c45mr26514242eeo.4.1343905378728;
        Thu, 02 Aug 2012 04:02:58 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id o47sm16473536eem.0.2012.08.02.04.02.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 04:02:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.886.gdf6792c.dirty
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202754>

The test t2104 currently checks if the index version is correctly
reduced to 2/increased to 3, when an entry need extended flags,
or doesn't use them anymore. Since index-v5 doesn't have extended
flags (the extended flags are part of the normal flags), we simply
add a check if the index version is 2/3 (whichever is correct for
that test) or 5.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..e66f23e 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -28,8 +28,9 @@ test_expect_success 'setup' '
 	git ls-files -t | test_cmp expect.full -
 '
 
-test_expect_success 'index is at version 2' '
-	test "$(test-index-version < .git/index)" = 2
+test_expect_success 'index is at version 2 or version 5' '
+	test "$(test-index-version < .git/index)" = 2 ||
+	test "$(test-index-version < .git/index)" = 5
 '
 
 test_expect_success 'update-index --skip-worktree' '
@@ -37,8 +38,9 @@ test_expect_success 'update-index --skip-worktree' '
 	git ls-files -t | test_cmp expect.skip -
 '
 
-test_expect_success 'index is at version 3 after having some skip-worktree entries' '
-	test "$(test-index-version < .git/index)" = 3
+test_expect_success 'index is at version 3 or version 5 after having some skip-worktree entries' '
+	test "$(test-index-version < .git/index)" = 3 ||
+	test "$(test-index-version < .git/index)" = 5
 '
 
 test_expect_success 'ls-files -t' '
@@ -50,8 +52,9 @@ test_expect_success 'update-index --no-skip-worktree' '
 	git ls-files -t | test_cmp expect.full -
 '
 
-test_expect_success 'index version is back to 2 when there is no skip-worktree entry' '
-	test "$(test-index-version < .git/index)" = 2
+test_expect_success 'index version is back to 2 or 5 when there is no skip-worktree entry' '
+	test "$(test-index-version < .git/index)" = 2 ||
+	test "$(test-index-version < .git/index)" = 5
 '
 
 test_done
-- 
1.7.10.886.gdf6792c.dirty

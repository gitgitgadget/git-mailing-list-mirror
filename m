From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 05/16] t2104: Don't fail for index versions other than [23]
Date: Sun,  5 Aug 2012 23:49:02 +0200
Message-ID: <1344203353-2819-6-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jQ-0002Kp-9k
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab2HEVup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:45 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab2HEVtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:55 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fEjX0b6snbWyaHqlXq7gtHTPzQRYCiVlAfKfFdrLvxY=;
        b=0I/N1PqLuIaogh94ELz52rk2w72j/QnAVQ4S6mhkw6WOcGqT50eXy6FjB61YoE8qVi
         DyVVyFgQRbEEnz1Zm/tQl/TSN/dTDFHbBDx1rKLAfos5SGmOx37P23RrBAQQLrDfrExc
         ZutJ+eByAKCd8sViC7l46rCBBVbw8dubCf+r1dJREgkdSqhj0euzqTCc78GnvaVn7a6u
         XZVkIC8L4NUmBD5jO6QZtavK4gjmvrzJx1f/lfaMjsAhBiiM1XbkN95OsRdvmfwiRsyl
         A6flJOjuSSYcF+HB1cVU7oZsjiFW1ge17P/LV4BcAkVeo02p42dyP7bFfn3a5MG0McNw
         hy/Q==
Received: by 10.14.5.78 with SMTP id 54mr10481909eek.1.1344203394498;
        Sun, 05 Aug 2012 14:49:54 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id h42sm42295407eem.5.2012.08.05.14.49.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202935>

t2104 currently checks for the exact index version 2 or 3,
depending if there is a skip-worktree flag or not. Other
index versions do not use extended flags and thus cannot
be tested for version changes.

Make this test update the index to version 2 at the beginning
of the test. Testing the skip-worktree flags for the default
index format is still covered by t7011 and t7012.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..4ef7d99 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -25,7 +25,8 @@ test_expect_success 'setup' '
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
-	git ls-files -t | test_cmp expect.full -
+	git ls-files -t | test_cmp expect.full - &&
+	git update-index --index-version=2
 '
 
 test_expect_success 'index is at version 2' '
-- 
1.7.10.GIT

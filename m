From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] t3200 (branch): fix '&&' chaining
Date: Fri,  9 Dec 2011 16:59:16 +0530
Message-ID: <1323430158-14885-5-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@mgmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 12:30:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYyf6-0000M6-DL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 12:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab1LILaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 06:30:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34509 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab1LILae (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 06:30:34 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so4103014iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 03:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5qXb7GCrP0mY6U/VRcwu9vgoEUfFEARf12bfRg13rbU=;
        b=s2NNmIpurHWiOs1Pe61KwUJjWSvquqRnfP9++TlevvecHBwxm1a8KX2p7nIZPirPIW
         Yc2ExL/s+aotA0SU4gU1NdAraEi8r8OVMjybjeplpRPiOmCk4I3KO8zHQ4fFn7bjWvzl
         jj74PFewkclNIud7Fd7m1lUlD/lVD22WfF/NY=
Received: by 10.50.203.100 with SMTP id kp4mr3306457igc.7.1323430234222;
        Fri, 09 Dec 2011 03:30:34 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id d19sm9096588ibh.8.2011.12.09.03.30.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 03:30:33 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186628>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix these breaks.

'git branch --help' will fail when git manpages aren't already
installed; now that its status is tested, guard these instances with
'test_might_fail'.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3200-branch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index bc73c20..95066d0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -22,7 +22,7 @@ test_expect_success \
 
 test_expect_success \
     'git branch --help should not have created a bogus branch' '
-     git branch --help </dev/null >/dev/null 2>/dev/null;
+     test_might_fail git branch --help </dev/null >/dev/null 2>/dev/null &&
      test_path_is_missing .git/refs/heads/--help
 '
 
@@ -88,7 +88,7 @@ test_expect_success \
 test_expect_success \
     'git branch -m n/n n should work' \
        'git branch -l n/n &&
-        git branch -m n/n n
+        git branch -m n/n n &&
 	test_path_is_file .git/logs/refs/heads/n'
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
-- 
1.7.7.3

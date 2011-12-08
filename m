From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/6] t3200 (branch): fix '&&' chaining
Date: Thu,  8 Dec 2011 18:40:15 +0530
Message-ID: <1323349817-15737-7-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdlK-0004PD-JD
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445Ab1LHNLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:43 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab1LHNLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:41 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so2573483iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=P5qJwXs/FWEAUpGkkI+Sx8f8ueYcEqrZI5O5ofMrAdY=;
        b=Mrf31CXPgISTobigUkl0GeHKxGO0FS3WNeBRrHKob4p/OmTGWp7As+jK4kCwrXI2ft
         d1clCpoTLYBsBbNEkT9BqwqS52EtWICFmuD3fsMxR9/+OiNXiont2caSG8Zktf+80AEK
         qoLGiOVfTILlu+EIIG/X9ZwEZVvYxL38hsnVU=
Received: by 10.231.20.201 with SMTP id g9mr694460ibb.57.1323349900785;
        Thu, 08 Dec 2011 05:11:40 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:40 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186557>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix these breaks.

Additionally, note that 'git branch --help' will fail when git
manpages aren't already installed: guard the line with a
'test_might_fail'.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
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

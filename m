From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] t1510 (worktree): fix '&&' chaining
Date: Fri,  9 Dec 2011 16:59:17 +0530
Message-ID: <1323430158-14885-6-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@mgmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 12:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYyf6-0000M6-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 12:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab1LILaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 06:30:39 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34509 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab1LILai (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 06:30:38 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so4103014iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 03:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yJwojTbOPpZ/QrPycc0NOEZM04fCFJVSm8b3As+uwSI=;
        b=pL8HaYVpwnd5KUcYVcwm2mL4D57Ol5Z6VU6aIug1gM4fWHnbeyu9a/T7tAVeMf/Q2W
         yCOOoJZrOwl2BWYtYsvqpGHtzmumLAvINtwsXN/AgVWK/98TxbTfAm22s0B1HnmTBFEj
         yoGI9ROmswkuMzYsTmUot/D0Q2rzXjqOeVfv0=
Received: by 10.50.183.133 with SMTP id em5mr3001703igc.73.1323430238296;
        Fri, 09 Dec 2011 03:30:38 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id d19sm9096588ibh.8.2011.12.09.03.30.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 03:30:37 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323430158-14885-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186629>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix these breaks.

'unset' returns non-zero status when the variable passed was already
unset on some shells; now that its status is tested, change these
instances to 'sane_unset'.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1501-worktree.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 6384983..e661147 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup: helper for testing rev-parse' '
 '
 
 test_expect_success 'setup: core.worktree = relative path' '
-	unset GIT_WORK_TREE;
+	sane_unset GIT_WORK_TREE &&
 	GIT_DIR=repo.git &&
 	GIT_CONFIG="$(pwd)"/$GIT_DIR/config &&
 	export GIT_DIR GIT_CONFIG &&
@@ -89,7 +89,7 @@ test_expect_success 'subdir of work tree' '
 '
 
 test_expect_success 'setup: core.worktree = absolute path' '
-	unset GIT_WORK_TREE;
+	sane_unset GIT_WORK_TREE &&
 	GIT_DIR=$(pwd)/repo.git &&
 	GIT_CONFIG=$GIT_DIR/config &&
 	export GIT_DIR GIT_CONFIG &&
@@ -334,7 +334,7 @@ test_expect_success 'absolute pathspec should fail gracefully' '
 '
 
 test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
-	>dummy_file
+	>dummy_file &&
 	echo git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file &&
 	git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file
 '
-- 
1.7.7.3

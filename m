From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] t1510 (worktree): fix '&&' chaining
Date: Thu,  8 Dec 2011 18:40:16 +0530
Message-ID: <1323349817-15737-8-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdlT-0004UC-Rw
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1LHNLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab1LHNLo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:44 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so2573483iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GcOcsW8yXYwpk88hrayJcg1ZFmHw4GQ4jAJ1W7OFihA=;
        b=q6t+1JJX+C/6P1fCsUMAw8jyH/vs5Xn0/N8MAdl7GBf7uwlsgMf0bm4MC8EIYxE0Me
         n7rd+GqXcemoKXEfYjsV/5aFqWllhRLERImixYRQL4MrGaWLFNTzkmft9BNjzHRBz+92
         rVffZvoBx067kKsHO9v6ez0WdVgqXoNG/LjgY=
Received: by 10.231.60.84 with SMTP id o20mr734805ibh.31.1323349904380;
        Thu, 08 Dec 2011 05:11:44 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:43 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186560>

Breaks in a test assertion's && chain can potentially hide failures
from earlier commands in the chain.  Fix these breaks.

Additionally, note that 'unset' returns non-zero status when the
variable passed was already unset on some shells: change these
instances to 'safe_unset'.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1501-worktree.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 6384983..8e04e7c 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup: helper for testing rev-parse' '
 '
 
 test_expect_success 'setup: core.worktree = relative path' '
-	unset GIT_WORK_TREE;
+	safe_unset GIT_WORK_TREE &&
 	GIT_DIR=repo.git &&
 	GIT_CONFIG="$(pwd)"/$GIT_DIR/config &&
 	export GIT_DIR GIT_CONFIG &&
@@ -89,7 +89,7 @@ test_expect_success 'subdir of work tree' '
 '
 
 test_expect_success 'setup: core.worktree = absolute path' '
-	unset GIT_WORK_TREE;
+	safe_unset GIT_WORK_TREE &&
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

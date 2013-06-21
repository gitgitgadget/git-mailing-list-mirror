From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/16] t/t5515-fetch-merge-logic: don't use {branches,remotes}-file
Date: Fri, 21 Jun 2013 16:42:39 +0530
Message-ID: <1371813160-4200-16-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKY-0003kx-2A
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413Ab3FULQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42293 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030379Ab3FULQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:30 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so7623161pac.40
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C0l/R4U6Qj1saXDh1q1xozgfeszQ+/qqKz+XLvAlIzk=;
        b=dXMXN+3RczKvsbVHqtn32Ge/sWloWPOVuIAOBAzVsGoNHW1yXVVG2sVzk3aBDL/+Ar
         ChAcEe8xnfMAeWYywM8b0iOsiEtAov7fFq2SF1NhBTkMU8+Ys/mvxpBFc4U3uoNPF5Y1
         l9UVgMPOybcD/ASkQULZ9wUzwRr6K5ftX41htB6aH4cW1Bo/16dLUtpk1JEKkVWKtpT+
         mmRlGS+wfljMdX74RqPilqASDuvCxBlrx79ge/8hs/yOqHsxQVV9KAO5mzkeQap1N48X
         rUA+poDCGNkiNwYiAKmUSKn4CQvxVrqZd7D8GjUj2qXw3/n5Ldtjr3neyupTEAsKSM2w
         xRqA==
X-Received: by 10.66.158.9 with SMTP id wq9mr15840449pab.189.1371813389787;
        Fri, 21 Jun 2013 04:16:29 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228605>

Replace it with the equivalent gitconfig configuration, using the
results of the corresponding tests in t/t5505-remote.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5515-fetch-merge-logic.sh | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index dbb927d..cde44e0 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -55,27 +55,25 @@ test_expect_success setup '
 	git config remote.config-glob.fetch refs/heads/*:refs/remotes/rem/* &&
 	remotes="$remotes config-glob" &&
 
-	mkdir -p .git/remotes &&
-	{
-		echo "URL: ../.git/"
-		echo "Pull: refs/heads/master:remotes/rem/master"
-		echo "Pull: refs/heads/one:remotes/rem/one"
-		echo "Pull: two:remotes/rem/two"
-		echo "Pull: refs/heads/three:remotes/rem/three"
-	} >.git/remotes/remote-explicit &&
+	git config remote.remote-explicit.url ../.git/ &&
+	git config remote.remote-explicit.fetch refs/heads/master:remotes/rem/master &&
+	git config --add remote.remote-explicit.fetch refs/heads/one:remotes/rem/one &&
+	git config --add remote.remote-explicit.fetch two:remotes/rem/two &&
+	git config --add remote.remote-explicit.fetch refs/heads/three:remotes/rem/three &&
 	remotes="$remotes remote-explicit" &&
 
-	{
-		echo "URL: ../.git/"
-		echo "Pull: refs/heads/*:refs/remotes/rem/*"
-	} >.git/remotes/remote-glob &&
+	git config remote.remote-glob.url ../.git/ &&
+	git config remote.remote-glob.fetch refs/heads/*:refs/remotes/rem/* &&
 	remotes="$remotes remote-glob" &&
 
-	mkdir -p .git/branches &&
-	echo "../.git" > .git/branches/branches-default &&
+	git config remote.branches-default.url ../.git/ &&
+	git config remote.branches-default.fetch refs/heads/master:refs/heads/branches-default &&
+	git config remote.branches-default.push HEAD:refs/heads/master &&
 	remotes="$remotes branches-default" &&
 
-	echo "../.git#one" > .git/branches/branches-one &&
+	git config remote.branches-one.url ../.git/ &&
+	git config remote.branches-one.fetch refs/heads/one:refs/heads/branches-one &&
+	git config remote.branches-one.push HEAD:refs/heads/one &&
 	remotes="$remotes branches-one" &&
 
 	for remote in $remotes ; do
-- 
1.8.3.1.499.g7ad3486.dirty

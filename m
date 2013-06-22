From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 13/14] t/t5515-fetch-merge-logic: don't use {branches,remotes}-file
Date: Sat, 22 Jun 2013 13:28:20 +0530
Message-ID: <1371887901-5659-14-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIm9-00005F-Rt
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423775Ab3FVICN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:13 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:61257 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423767Ab3FVICJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:02:09 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so8824648pbc.1
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dfNN+tQdR185HOB+QqNodnq4KvkOmaXqHGQa+sQZ4bk=;
        b=Y44YqsDwSdToEdjC/9DpJgiuu0XeKrFRpKPvZz+Vik83UmEGWvVUhgCl+RN2wPD+VP
         LyvgrYgyFHgejrQK4xp8xyu56Hwnz1oOyf3USwG3vLpRYGBMmCRWqChBlNoOY/EiT1HC
         FJE2XeCQe8nuvVTJ5Mp1O0WYs2LSRc+iKK21GRoN3BX8rNA1pqBSUNbPwu7fszgdkPpw
         eo4FLAocHcpOXVFRcRkwpwdYV079mKajHY/HreMmFgySFLYeJ7pk84FcoNVZ+XabD2EW
         24aig90ZHyp6A5yPEnJHsDYES5RrBECiE1Ks//wXukjtqO3Y8+E8T4stY7CGjA/cBUFc
         Twng==
X-Received: by 10.66.144.5 with SMTP id si5mr19728380pab.6.1371888128826;
        Sat, 22 Jun 2013 01:02:08 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.02.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:02:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228686>

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
1.8.3.1.498.gacf2885

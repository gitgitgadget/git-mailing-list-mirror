From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 44/45] tests: move test for rebase messages from t3400 to t3406
Date: Sun,  9 Jun 2013 11:40:56 -0500
Message-ID: <1370796057-25312-45-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulijt-0007i7-Ti
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab3FIQpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:45:01 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35224 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3FIQoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:55 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so8925516obq.21
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dNf77lR4ingDh7TjJku2P8vcBUPejfvNFDHWt4xUz90=;
        b=LBmxTYRc7MfCRj3qadZnOu6olpvL+qr4Awn3lcfvvzy76Hvl4gEjgNjd11G4J6HFcW
         9p/Z6OJPGPmCVOhEPYtvAofdrQuaALwIEUCqDmxd8ws4Sgi4x14LIsSKzf4JxH5oMNoK
         0bxlzB7zqGHcAIBJM6Ch3kNIcn+4PvcUTOlMcnDpczb1GnREeT7R+somQXcy60rhafTa
         S8LUXVi6k+C6ZWDNpf1zLkBModvbacaChs4y6Bkf263HygCJsGBylGs0YaMKdaZrblYk
         I0hYUKjZPL92zuKe045aE3/YJd8gc9JFHvjIrtQxR+4lgLHxA6AmJIMucPDjBa3rA6gc
         5HVg==
X-Received: by 10.182.237.77 with SMTP id va13mr5343677obc.65.1370796295020;
        Sun, 09 Jun 2013 09:44:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id oe10sm15164686oeb.6.2013.06.09.09.44.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227010>

From: Martin von Zweigbergk <martinvonz@gmail.com>

t3406 is supposed to test "messages from rebase operation", so let's
move tests in t3400 that fit that description into 3406. Most of the
functionality they tested, except for the messages, has now been
subsumed by t3420.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

Conflicts:
	t/t3406-rebase-message.sh
---
 t/t3400-rebase.sh         | 22 ----------------------
 t/t3406-rebase-message.sh | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b436ef4..45a55e9 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -59,28 +59,6 @@ test_expect_success 'rebase against master' '
 	git rebase master
 '
 
-test_expect_success 'rebase against master twice' '
-	git rebase master >out &&
-	test_i18ngrep "Current branch my-topic-branch is up to date" out
-'
-
-test_expect_success 'rebase against master twice with --force' '
-	git rebase --force-rebase master >out &&
-	test_i18ngrep "Current branch my-topic-branch is up to date, rebase forced" out
-'
-
-test_expect_success 'rebase against master twice from another branch' '
-	git checkout my-topic-branch^ &&
-	git rebase master my-topic-branch >out &&
-	test_i18ngrep "Current branch my-topic-branch is up to date" out
-'
-
-test_expect_success 'rebase fast-forward to master' '
-	git checkout my-topic-branch^ &&
-	git rebase my-topic-branch >out &&
-	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
-'
-
 test_expect_success 'the rebase operation should not have destroyed author information' '
 	! (git log | grep "Author:" | grep "<>")
 '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 7f48d0f..f03cc5f 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -17,6 +17,29 @@ test_expect_success 'setup' '
 	git tag start
 '
 
+test_expect_success 'rebase against master twice' '
+	git rebase -m master &&
+	git rebase master >out &&
+	test_i18ngrep "Current branch topic is up to date" out
+'
+
+test_expect_success 'rebase against master twice with --force' '
+	git rebase --force-rebase master >out &&
+	test_i18ngrep "Current branch topic is up to date, rebase forced" out
+'
+
+test_expect_success 'rebase against master twice from another branch' '
+	git checkout topic^ &&
+	git rebase master topic >out &&
+	test_i18ngrep "Current branch topic is up to date" out
+'
+
+test_expect_success 'rebase fast-forward to master' '
+	git checkout topic^ &&
+	git rebase topic >out &&
+	test_i18ngrep "Fast-forwarded HEAD to topic" out
+'
+
 test_expect_success 'rebase --stat' '
 	git reset --hard start &&
         git rebase --stat master >diffstat.txt &&
-- 
1.8.3.698.g079b096

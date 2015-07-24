From: David Turner <dturner@twopensource.com>
Subject: [PATCH 4/9] tests: treat FETCH_HEAD as a pseudoref
Date: Fri, 24 Jul 2015 00:45:24 -0400
Message-ID: <1437713129-19373-5-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUs9-0003xD-EL
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbbGXEp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:45:58 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34346 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbGXEpx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:53 -0400
Received: by qgeu79 with SMTP id u79so6102313qge.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nC1jRx2dq2TuQtK85adBw2HDOrtbsWRpgGRe/uz/P3Y=;
        b=kp114on61mP+oKKBhI07bLt0V8NJVBdGsrwsUpw8Svn/6d7WnIMnSNtbzRJ4WXK17P
         dwi8dFnaGZMFagmgfyy/zCqDTIPv032ARXKyWC7o8wNtywh485xdTWyFqxKnvN0YqR2o
         rl4ZmwwWyKzIAzbY5bWTPTNSW23rPhfsPXnqK0bjoZFJ4KFBSUVABIVP01aatUl1YBRC
         fC4BKe8ZS9IM42l8klcVcpFePvXk/UMVzjyBm3agRG1UVZBhjN1tPvaelu0KKv8gk4xa
         KCkBQvlxpWsD55GN3nFFYURsrdhU6g8Jd5pYhWKtx6h+8GNzZB9ORrSXZdQWMuCF5TlS
         1qTg==
X-Gm-Message-State: ALoCoQmd5OjDi1q960zqpwRQpInu6HLy9Gh9/sdELSRsSWfvIeoFBge8NHr+OXZDhwBKfVIryAEk
X-Received: by 10.140.237.70 with SMTP id i67mr18399917qhc.44.1437713153028;
        Thu, 23 Jul 2015 21:45:53 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274551>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 t/t5510-fetch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0ba9db0..467cade 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -362,7 +362,7 @@ test_expect_success 'fetch with a non-applying branch.<name>.merge' '
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [1]' '
 	one_head=$(cd one && git rev-parse HEAD) &&
 	this_head=$(git rev-parse HEAD) &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head = "$(git rev-parse --verify HEAD)"
@@ -374,7 +374,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 	one_ref=$(cd one && git symbolic-ref HEAD) &&
 	git config branch.master.remote blub &&
 	git config branch.master.merge "$one_ref" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head = "$(git rev-parse --verify HEAD)"
@@ -384,7 +384,7 @@ test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.merge [3]' '
 	git config branch.master.merge "${one_ref}_not" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head = "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head = "$(git rev-parse --verify HEAD)"
-- 
2.0.4.315.gad8727a-twtrsrc

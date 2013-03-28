From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/2] t5520 (pull): use test_config where appropriate
Date: Thu, 28 Mar 2013 18:10:19 +0530
Message-ID: <1364474419-22796-1-git-send-email-artagnon@gmail.com>
References: <7v4nfz1ndo.fsf@alter.siamese.dyndns.org>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 13:39:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULC7E-00037t-5y
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 13:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab3C1MjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 08:39:07 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:50888 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976Ab3C1MjG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 08:39:06 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp2so5779421pbb.34
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jKoGCEd0yX98fVEfHMB5u5slmqcg3xEWD1flNug7KNA=;
        b=tXhwl5RZwkYQSF8X3hNDLMBsrYffFGZ/XCkArXBxGWQ0CmR+Pujx1Csd+gAxLNiKMC
         gfht0yt8aUhCgwRt1iyiW45rfhTGnVVhVtdjtSCnlE9B7+h2hC+bt25jUxW6v30B3f0a
         IpPY3OGAxYCmn4rSro0F4++KrFc9+zQL9tTYk9XbY0xZ+jbRHBByYv2RYlbrZIgQeOTM
         580nK9GBvdsyUmNJ8yXVDpLWWy8UpwCB8fCjR1kgz1p0OxYS+IycjiME5ajkE2Pb5Sxt
         mHoc50XE5+hZWcVy5MCpH3TzgA47v5Egtgc/gRRkYouHoPB7uBU9ZXYI5esun8Rt+46/
         rcwA==
X-Received: by 10.68.213.167 with SMTP id nt7mr34271110pbc.194.1364474345632;
        Thu, 28 Mar 2013 05:39:05 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id m18sm27593854pad.17.2013.03.28.05.39.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 05:39:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g07926c6
In-Reply-To: <7v4nfz1ndo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219382>

Configuration from test_config does not last beyond the end of the
current test assertion, making each test easier to think about in
isolation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Removed first hunk, as per Junio's comment.

 t/t5520-pull.sh | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e5adee8..87777ea 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -96,8 +96,7 @@ test_expect_success '--rebase' '
 '
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-	git config --bool pull.rebase true &&
-	test_when_finished "git config --unset pull.rebase" &&
+	test_config pull.rebase true &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
@@ -105,8 +104,7 @@ test_expect_success 'pull.rebase' '
 
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
-	git config --bool branch.to-rebase.rebase true &&
-	test_when_finished "git config --unset branch.to-rebase.rebase" &&
+	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
@@ -114,10 +112,8 @@ test_expect_success 'branch.to-rebase.rebase' '
 
 test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	git reset --hard before-rebase &&
-	git config --bool pull.rebase true &&
-	test_when_finished "git config --unset pull.rebase" &&
-	git config --bool branch.to-rebase.rebase false &&
-	test_when_finished "git config --unset branch.to-rebase.rebase" &&
+	test_config pull.rebase true &&
+	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
 	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
 	test new = $(git show HEAD:file2)
@@ -171,9 +167,9 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	git update-ref refs/remotes/me/copy copy^ &&
 	COPY=$(git rev-parse --verify me/copy) &&
 	git rebase --onto $COPY copy &&
-	git config branch.to-rebase.remote me &&
-	git config branch.to-rebase.merge refs/heads/copy &&
-	git config branch.to-rebase.rebase true &&
+	test_config branch.to-rebase.remote me &&
+	test_config branch.to-rebase.merge refs/heads/copy &&
+	test_config branch.to-rebase.rebase true &&
 	echo dirty >> file &&
 	git add file &&
 	test_must_fail git pull &&
-- 
1.8.2.141.g07926c6

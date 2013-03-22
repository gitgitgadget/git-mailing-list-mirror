From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] t5520 (pull): use test_config where appropriate
Date: Fri, 22 Mar 2013 18:01:48 +0530
Message-ID: <1363955508-13368-3-git-send-email-artagnon@gmail.com>
References: <1363955508-13368-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ17z-0006rd-JL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112Ab3CVMao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:30:44 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:53084 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249Ab3CVMam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:30:42 -0400
Received: by mail-pb0-f42.google.com with SMTP id xb4so3044300pbc.29
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=s+NvEp3ZmKivG3z9MCkLepr3RanmEg0G+ZSBYBlenLg=;
        b=ADCitsGRdYZIw9QHT2vynEWLQu4FNGUliC02Up8F6xQIPj3/ZrpEz/H8vaPxjCLUT5
         1GDhiyU81chfTcmYnI7U6kVEh/95UGTkdcvKcIGBC4nyWibBE//4yF3lczJxd/js59pw
         ev9SkWdTvV+CriD/4k+C6bSXQT9Thu8NlNizIHBH1/e03X6y194AnFEbjugrqKHu/7Pc
         sTm6A2SC1i3ZGoVNr2fw/i0+oS2eszUcX3wYts1rIFRclZrXmHk5yPdjBmzsLAMnqwSe
         lo9CmCLTwbRWjrDBrY52FV8DbX3Zd4e8oph+m55OOyMwSP3AvWp2sK6+2vT/RNux5sCt
         uf5g==
X-Received: by 10.66.155.67 with SMTP id vu3mr3005734pab.70.1363955442083;
        Fri, 22 Mar 2013 05:30:42 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ky17sm2808786pab.23.2013.03.22.05.30.39
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:30:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
In-Reply-To: <1363955508-13368-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218799>

Configuration from test_config does not last beyond the end of the
current test assertion, making each test easier to think about in
isolation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5520-pull.sh | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e5adee8..0fe935b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -60,8 +60,8 @@ test_expect_success 'pulling into void does not overwrite untracked files' '
 test_expect_success 'test . as a remote' '
 
 	git branch copy master &&
-	git config branch.copy.remote . &&
-	git config branch.copy.merge refs/heads/master &&
+	test_config branch.copy.remote . &&
+	test_config branch.copy.merge refs/heads/master &&
 	echo updated >file &&
 	git commit -a -m updated &&
 	git checkout copy &&
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
1.8.2.141.gad203c2.dirty

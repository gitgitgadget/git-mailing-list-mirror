From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 19/23] rebasing: add tests
Date: Sat, 23 Apr 2011 17:22:48 +1000
Message-ID: <1303543372-77843-20-git-send-email-jon.seymour@gmail.com>
References: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 09:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDXDB-0005Iv-1g
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 09:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab1DWHYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 03:24:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44129 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1DWHYn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 03:24:43 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so585772pvg.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 00:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=dC6u03VIfNOTwoPubivaGnPw84ai7l6EfuiHYFBxiYA=;
        b=t9GL4FEuHWoYpkLG4IiGyEYOwpyJQo+m9WgC5k+3ednwzdvKSRMaLIycEQ5CqRCqoG
         0w8+gO4gr2IJUS+VydXWMijNDhkR2Ek9PNCP94xIi83iBvHmDJMdv+VVHvfvzctWs9nI
         J6qQ79Hlklf9QnylFRt7gXdaYOXebxU5UTsx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wza5b0ADWIanrJOvkUfvy/NOZDUBef0BrSZxP1kMUg1EmHBJh/dM/+Bz/vOkc4kS/I
         wrxsl1OdAp/cmSHVh5vBkfVe2g+4aIuLeH0Qq+uuvoIpWt7DIMv2REjAI1a6q82dmI/D
         j/arboLUwmyrUll1Fm06elG0cxP89/7psdw30=
Received: by 10.68.62.132 with SMTP id y4mr2898316pbr.212.1303543483353;
        Sat, 23 Apr 2011 00:24:43 -0700 (PDT)
Received: from localhost.localdomain (124-169-133-110.dyn.iinet.net.au [124.169.133.110])
        by mx.google.com with ESMTPS id v8sm2498310pbk.95.2011.04.23.00.24.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Apr 2011 00:24:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.rc1.23.g7f622
In-Reply-To: <1303543372-77843-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171972>

---
 t/t1520-test.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t1520-test.sh b/t/t1520-test.sh
index a18c1d7..1db3598 100755
--- a/t/t1520-test.sh
+++ b/t/t1520-test.sh
@@ -468,4 +468,39 @@ test_expect_success 'git test --not-conflicted # should fail when there are conf
 	
 '
 
+test_expect_success 'git test --rebasing # should fail' \
+'
+	test_must_fail git test --rebasing
+'
+
+test_expect_success 'git test --not-rebasing' \
+'
+	git test --not-rebasing
+'
+
+test_expect_success 'git test --rebasing' \
+'
+	test_when_finished "
+		git reset --hard HEAD &&
+		git checkout -f master && 
+		git branch -D rebase
+	" && 
+        git branch rebase F &&
+        ! git rebase --onto D F~1 F
+	git test --rebasing 
+	
+'
+
+test_expect_success 'git test --not-rebasing' \
+'
+	test_when_finished "
+		git reset --hard HEAD &&
+		git checkout -f master &&
+		git branch -D rebase
+	" && 
+        git branch rebase F &&
+        ! git rebase --onto D F~1 F
+	test_must_fail git test --not-rebasing
+'
+
 test_done
-- 
1.7.5.rc1.23.g7f622

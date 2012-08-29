From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 2/3] demonstrate broken 'git cherry-pick three one two'
Date: Tue, 28 Aug 2012 23:15:55 -0700
Message-ID: <1346220956-25034-3-git-send-email-martinvonz@gmail.com>
References: <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 08:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6bap-0006rt-BK
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 08:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab2H2GRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 02:17:25 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:48967 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2H2GQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 02:16:56 -0400
Received: by bkcjc3 with SMTP id jc3so12375bkc.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 23:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=aTycNEAOtViBzY7wWzXyNHPY9sYiqhfv3/EwoQBpwcQ=;
        b=K1QAz7oedUAd5kgD4vRW+b1k3AZA52BzLaY3UbRQ0MnEwWJe/H44mtyurWkAlVVt9s
         BSzBCzgA1jhgnmb7bKk+hZAjUt3WcrcGt4LJ2vqLRLaBqAsvIYulKTaGrQeTPM8RShXg
         xX7aIPZph2dxcpsvN0SOlefe0HKncEMIs6IuckkJwW0j/JYJPeTKAPcqwpHBgpyYuTTz
         CR8BG4Q1EbxFcScnM5fb2uHjtrmChyek6Y+0s0einHNNVw8omoAstpCqw6u1W0NLrqaI
         xm01E1Wuae3nN+N3tnmoKO0+AcVP5K7VlkzwM6ILqsg0zhQBVv4YsHNI+fe/fS0HHsAR
         UXOw==
Received: by 10.216.84.129 with SMTP id s1mr35728wee.2.1346221015216;
        Tue, 28 Aug 2012 23:16:55 -0700 (PDT)
Received: by 10.216.84.129 with SMTP id s1mr35719wee.2.1346221015145;
        Tue, 28 Aug 2012 23:16:55 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id em7si1105890wib.2.2012.08.28.23.16.55
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 28 Aug 2012 23:16:55 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id BBF9620004E;
	Tue, 28 Aug 2012 23:16:54 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 2AC66C2AB1; Tue, 28 Aug 2012 23:16:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1346220956-25034-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQlZSoWsDfI5Jxeyv2vEzQB8gJ5aP4wcHGMfkacFuk2XfIy1utIjU1Yq5MQHytfiEJzoNTDMBQ2bb5exDvVdIDQmfxKQX2/W0/z/i2MjWHPjlYLnXC8qR8TKnQfi3YO4U2kw6FzS0eLbvy8465gxmZvXgKZyE8s3EtHbXJ06gv56w6zSanY1FCXu7svDus6doJjyG84Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204465>

Cherry-picking commits out of order (w.r.t. commit time stamp) doesn't
currently work. Add a test case to demonstrate it.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 t/t3508-cherry-pick-many-commits.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 75f7ff4..fff20c3 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -44,6 +44,21 @@ test_expect_success 'cherry-pick first..fourth works' '
 	check_head_differs_from fourth
 '
 
+test_expect_failure 'cherry-pick three one two works' '
+	git checkout -f first &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git checkout -f master &&
+	git reset --hard first &&
+	git cherry-pick three one two &&
+	git diff --quiet three &&
+	git diff --quiet HEAD three &&
+	test "$(git log --reverse --format=%s first..)" == "three
+one
+two"
+'
+
 test_expect_success 'output to keep user entertained during multi-pick' '
 	cat <<-\EOF >expected &&
 	[master OBJID] second
-- 
1.7.11.1.104.ge7b44f1

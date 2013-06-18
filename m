From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/7] t/t7512-status-help: test "HEAD detached from"
Date: Wed, 19 Jun 2013 00:25:31 +0530
Message-ID: <1371581737-10013-2-git-send-email-artagnon@gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:58:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up17I-0002Ab-Ks
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933695Ab3FRS6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:58:51 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59049 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab3FRS6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:58:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so4274731pad.5
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tw6rc8nePaCYKMLpyKgxZsrRYCadmBmknvbeqBsHVs8=;
        b=OuOyR8YuDgyEePZD8f+dKPYs5+RAr/JkqM5UFIQjELzilPev57z6nFbpac8ihqaze+
         ev9b7VuRjrgl59D5gGWTVxrSJciMO5P43MQrWOV3Nl0L3c1lx6+9bjAJ34oOCl/SxmUu
         xJzocQ0QVohZ2MwEbO0E7twJZQat2odfnCxtH2WxUGVbOoHMikI9J2iR/MVxVUo1X37z
         MUOs/G2UHfHd99Xzzkh08dPqcNx6VytVirTyy2z4UAfmBrZ2zWz7tikg+7mBivM6gMhz
         nvt67cshyw+HE2bB4uvbJDuAacFY5ZztbKgTYl3Nm4Mk062OhFC3IiuFHKFbpBY0q/mz
         LyjQ==
X-Received: by 10.68.20.165 with SMTP id o5mr17912124pbe.220.1371581928181;
        Tue, 18 Jun 2013 11:58:48 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ag4sm19432751pbc.20.2013.06.18.11.58.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:58:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
In-Reply-To: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228297>

From: Junio C Hamano <gitster@pobox.com>

b397ea (status: show more info than "currently not on any branch",
2013-03-13) wanted to make sure that after a checkout to detach HEAD,
the user can see where the HEAD was originally detached from.  The last
test added by that commit to t/status-help shows one example,
immediately after HEAD is detached via a checkout.  Enhance that test to
test the "HEAD detached from" message is displayed when the user further
resets to another commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t7512-status-help.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bf08d4e..bafa5e7 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -667,7 +667,7 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 	test_i18ncmp expected actual
 '
 
-test_expect_success 'status showing detached from a tag' '
+test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
 	cat >expected <<-\EOF
@@ -675,6 +675,14 @@ test_expect_success 'status showing detached from a tag' '
 	nothing to commit (use -u to show untracked files)
 	EOF
 	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual &&
+
+	git reset --hard HEAD^ &&
+	cat >expected <<-\EOF
+	# HEAD detached from atag
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
 
-- 
1.8.3.1.455.g5932b31

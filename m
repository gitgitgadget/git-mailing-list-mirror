From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 1/7] t/t7512-status-help: test "HEAD detached from"
Date: Wed, 19 Jun 2013 13:34:43 +0530
Message-ID: <1371629089-27008-2-git-send-email-artagnon@gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDRL-0001ly-I4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab3FSIIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:08:15 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:48565 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637Ab3FSIIA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:08:00 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4817292pbc.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=w8tQ8NNXZxH4YIPTutqVNkUuZ8ZSiLCG3yhk28cO9NM=;
        b=UO9lv1P7xdiVHzBOpBIGcq1c8qMhkC66fClLE7sqGrhb+beipGRCfLNoo6SH4Xp/FW
         AxeruIdi8If4j4aXiQuyONrOWfG1kAU/M3s6nVlcCR7sexK4smUQ+tpdgFjZRq9PuloG
         O9WN4KX+At5D/UMxv75IujxOd53HVGzyUX+ERdhtdklInzzLHN9WkGa2f75Bs/znn7qp
         p4TydQEeYENX/9t4+bZ08O8Hb419XzwzYWSju4/pLexnPdIjg/A75OcXMXeBBkcHKsuR
         uanNDn16fdfNmiGfjVSB1/x+JQaRjSAFwVURH4Kl55guEHPRopzLUixDoGOkWwIC3cdK
         Gzng==
X-Received: by 10.68.76.67 with SMTP id i3mr1729675pbw.20.1371629279973;
        Wed, 19 Jun 2013 01:07:59 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm23663400pac.20.2013.06.19.01.07.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 01:07:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
In-Reply-To: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228373>

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
1.8.3.1.449.g41b32a4.dirty

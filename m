From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] t6131 - skip tests if on case-insensitive file system
Date: Wed, 17 Jul 2013 09:22:16 -0400
Message-ID: <1374067336-6545-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 15:22:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzRgY-0001gR-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 15:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab3GQNWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 09:22:23 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:56504 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479Ab3GQNWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 09:22:22 -0400
Received: by mail-qc0-f176.google.com with SMTP id z10so1052960qcx.7
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=d1y1SQmtmzwFoM9mfKBCUZ0aObGggIMol+TdK+e5UKo=;
        b=iUh+L387g+afKS0kUqh1zRsrTkomQT80HknqlVHmRGO1EkROkxoP0l/4suKcSgmtPY
         m3ilmVqxY/E8MihzRPQgTHX40Bu0fOcCGZ54VmHSTK3zGCh1aSJ/GYIsqxrmTPT8RZlx
         S6LxTJ8mYksGnBY9QMF+zPy1e5i1ZfTUIFfLr0DJ3inIAXzKQm7qnRBKfY/NkXbYDPYs
         wLtTE3LaSOP3aW2gRcr2CgiQ/67PFW50xvbIYCM1EtvwPWngHQoDP0kmgOeofQ/kOa/8
         Ik6q3Dwh58SCSYPL4NaHBKKLdI3kufkzaCyBU7AS8vnc0r1q2XvJGxddL6quj3GqWmlq
         OgMw==
X-Received: by 10.224.25.140 with SMTP id z12mr8787527qab.46.1374067341725;
        Wed, 17 Jul 2013 06:22:21 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id 2sm10529328qap.7.2013.07.17.06.22.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 06:22:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230623>

This test fails on Cygwin where the default system configuration does not 
support case sensitivity (only case retention), so don't run the test on 
such systems.  

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/t6131-pathspec-icase.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index 3215eef..8d4a7fc 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -3,6 +3,12 @@
 test_description='test case insensitive pathspec limiting'
 . ./test-lib.sh
 
+if test_have_prereq CASE_INSENSITIVE_FS
+then
+	skip_all='skipping case sensitive tests - case insensitive file system'
+	test_done
+fi
+
 test_expect_success 'create commits with glob characters' '
 	test_commit bar bar &&
 	test_commit bAr bAr &&
-- 
1.8.3.2.0.63

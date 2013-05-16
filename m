From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/6] test-lib: enable MALLOC_* for the actual tests
Date: Thu, 16 May 2013 22:50:12 +0200
Message-ID: <043f7ee12630ae267bcde88e92a7dfacbf41e730.1368736093.git.trast@inf.ethz.ch>
References: <cover.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 16 22:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud58B-0004hR-0k
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab3EPUuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 16:50:21 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:48887 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab3EPUuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 16:50:20 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:17 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 May
 2013 22:50:17 +0200
X-Mailer: git-send-email 1.8.3.rc2.393.g8636c0b
In-Reply-To: <cover.1368736093.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224616>

1b3185f (MALLOC_CHECK: various clean-ups, 2012-09-14) moved around the
MALLOC_CHECK_ and MALLOC_PERTURB_ assignments, intending to limit
their effect to only the test runs.  However, they were actually
enabled only during test cleanup.  Call setup/teardown_malloc_check
also around the evaluation of the actual test snippet.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ca6bdef..229f5f7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -337,8 +337,10 @@ test_eval_ () {
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
+	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?
+	teardown_malloc_check
 
 	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
 	then
-- 
1.8.3.rc2.393.g8636c0b

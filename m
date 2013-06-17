From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 1/6] test-lib: enable MALLOC_* for the actual tests
Date: Mon, 17 Jun 2013 11:18:46 +0200
Message-ID: <fc300eeacd6c42dbdc00fe33216189a88d606412.1371460265.git.trast@inf.ethz.ch>
References: <cover.1371460265.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 11:19:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoVat-0004qy-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 11:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab3FQJS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 05:18:59 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40405 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755919Ab3FQJS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 05:18:56 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 11:18:49 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 17 Jun
 2013 11:18:52 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371460265.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228054>

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
index eff3a65..35da859 100644
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
1.8.3.1.530.g6f90e57

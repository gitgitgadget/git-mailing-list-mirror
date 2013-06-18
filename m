From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 1/8] test-lib: enable MALLOC_* for the actual tests
Date: Tue, 18 Jun 2013 14:25:57 +0200
Message-ID: <60de7a05a5ad90c4ade5570e4cd6e83f84a06568.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzR-0007cU-Cg
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab3FRM0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:15 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:42501 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755764Ab3FRM0P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:15 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:07 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:11 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228213>

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

From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v4 1/8] test-lib: enable MALLOC_* for the actual tests
Date: Sun, 23 Jun 2013 20:12:52 +0200
Message-ID: <d2b5d1eac050319b4ed24506e3d8b1a07d88aa32.1372010917.git.trast@inf.ethz.ch>
References: <cover.1372010917.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 20:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqon5-0007dl-JS
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 20:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174Ab3FWSNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 14:13:07 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:34489 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab3FWSND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 14:13:03 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:12:54 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 23 Jun
 2013 20:13:00 +0200
X-Mailer: git-send-email 1.8.3.1.727.gcbe3af3
In-Reply-To: <cover.1372010917.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228749>

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
1.8.3.1.727.gcbe3af3

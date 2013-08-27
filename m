From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/5] t6050-replace: test that objects are of the same type
Date: Tue, 27 Aug 2013 21:48:25 +0200
Message-ID: <20130827194828.11172.45373.chriscool@tuxfamily.org>
References: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:49:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEPGN-0006k6-La
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab3H0TtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:49:05 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:58560 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab3H0TtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:49:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8EE0A77;
	Tue, 27 Aug 2013 21:48:59 +0200 (CEST)
X-git-sha1: 9103b1958afb218a77e2184840abf19ce61d2d02 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130827194022.11172.56453.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233149>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index decdc33..5c352c4 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -263,4 +263,17 @@ test_expect_success 'not just commits' '
 	test_cmp file.replaced file
 '
 
+test_expect_success 'replaced and replacement objects must be of the same type' '
+	test_must_fail git replace mytag $HASH1 2>err &&
+	grep "mytag. points to a replaced object of type .tag" err &&
+	grep "$HASH1. points to a replacement object of type .commit" err &&
+	test_must_fail git replace HEAD^{tree} HEAD~1 2>err &&
+	grep "HEAD^{tree}. points to a replaced object of type .tree" err &&
+	grep "HEAD~1. points to a replacement object of type .commit" err &&
+	BLOB=$(git rev-parse :file) &&
+	test_must_fail git replace HEAD^ $BLOB 2>err &&
+	grep "HEAD^. points to a replaced object of type .commit" err &&
+	grep "$BLOB. points to a replacement object of type .blob" err
+'
+
 test_done
-- 
1.8.4.rc1.26.gdd51ee9

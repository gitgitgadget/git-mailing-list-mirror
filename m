From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/11] t6050-replace: test that objects are of the same type
Date: Sat, 31 Aug 2013 21:12:06 +0200
Message-ID: <20130831191215.26699.38193.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqc9-00015H-TF
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993Ab3HaTNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:16 -0400
Received: from [194.158.98.14] ([194.158.98.14]:54203 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752603Ab3HaTNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:14 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id D463D47;
	Sat, 31 Aug 2013 21:12:52 +0200 (CEST)
X-git-sha1: e4032fd793d2a9095f98f23d977ed9c369de824e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233539>

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
1.8.4.rc1.31.g530f5ce.dirty

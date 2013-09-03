From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 03/11] t6050-replace: test that objects are of the same type
Date: Tue, 03 Sep 2013 09:10:17 +0200
Message-ID: <20130903071026.29838.76131.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkrr-0008AL-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544Ab3ICHRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:21 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:45641 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932529Ab3ICHRS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:18 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 955306A;
	Tue,  3 Sep 2013 09:17:17 +0200 (CEST)
X-git-sha1: e4032fd793d2a9095f98f23d977ed9c369de824e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233691>

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

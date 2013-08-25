From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] t6050-replace: test that objects are of the same type
Date: Sun, 25 Aug 2013 15:06:06 +0200
Message-ID: <20130825130609.4681.58306.chriscool@tuxfamily.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 15:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDa1q-0003bG-Fh
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 15:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab3HYNGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 09:06:41 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:62412 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab3HYNGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 09:06:37 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 28A554F;
	Sun, 25 Aug 2013 15:06:36 +0200 (CEST)
X-git-sha1: 2e052a9556efd9ace0308c87e1e38b1240e0fbc5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130825125940.4681.70226.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232954>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index decdc33..8f631ac 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -263,4 +263,17 @@ test_expect_success 'not just commits' '
 	test_cmp file.replaced file
 '
 
+test_expect_success 'replaced and replacement objects must be of the same type' '
+	test_must_fail git replace mytag $HASH1 2>err &&
+	grep "Object ref '\''mytag'\'' is of type '\''tag'\''" err &&
+	grep "replace ref '\''$HASH1'\'' is of type '\''commit'\''" err &&
+	test_must_fail git replace HEAD^{tree} HEAD~1 2>err &&
+	grep "Object ref '\''HEAD^{tree}'\'' is of type '\''tree'\''" err &&
+	grep "replace ref '\''HEAD~1'\'' is of type '\''commit'\''" err &&
+	BLOB=$(git rev-parse :file) &&
+	test_must_fail git replace HEAD^ $BLOB 2>err &&
+	grep "Object ref '\''HEAD^'\'' is of type '\''commit'\''" err &&
+	grep "replace ref '\''$BLOB'\'' is of type '\''blob'\''" err
+'
+
 test_done
-- 
1.8.4.rc1.24.g13dc82a

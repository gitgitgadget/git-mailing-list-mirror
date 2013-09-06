From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/7] t6050-replace: test that objects are of the same type
Date: Fri, 06 Sep 2013 07:10:55 +0200
Message-ID: <20130906051100.6657.75496.chriscool@tuxfamily.org>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 07:12:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHoLD-0005Jw-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 07:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777Ab3IFFL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 01:11:56 -0400
Received: from [194.158.98.14] ([194.158.98.14]:38051 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733Ab3IFFLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 01:11:55 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id BFD4A5A;
	Fri,  6 Sep 2013 07:11:34 +0200 (CEST)
X-git-sha1: 9ba6585f427b12d7df1830d00856009fe97fca4f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130906050702.6657.25651.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234024>

and that the -f option bypasses the type check

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index decdc33..09bad98 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -263,4 +263,17 @@ test_expect_success 'not just commits' '
 	test_cmp file.replaced file
 '
 
+test_expect_success 'replaced and replacement objects must be of the same type' '
+	test_must_fail git replace mytag $HASH1 &&
+	test_must_fail git replace HEAD^{tree} HEAD~1 &&
+	BLOB=$(git rev-parse :file) &&
+	test_must_fail git replace HEAD^ $BLOB
+'
+
+test_expect_success '-f option bypasses the type check' '
+	git replace -f mytag $HASH1 &&
+	git replace -f HEAD^{tree} HEAD~1 &&
+	git replace -f HEAD^ $BLOB
+'
+
 test_done
-- 
1.8.4.rc1.28.ge2684af

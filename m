From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 2/3] replace: add test for --graft
Date: Thu, 22 May 2014 23:33:05 +0200
Message-ID: <20140522213307.27162.82339.chriscool@tuxfamily.org>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 07:09:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnhjK-0008LM-HV
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 07:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaEWFJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 01:09:11 -0400
Received: from [194.158.98.45] ([194.158.98.45]:42022 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751598AbaEWFJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 01:09:01 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 7754D49;
	Fri, 23 May 2014 07:08:40 +0200 (CEST)
X-git-sha1: 9a99122d2359d2556b101897816f87c829b74c53 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140522211836.27162.80311.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249973>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 68b3cb2..ca45a84 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -351,4 +351,16 @@ test_expect_success 'replace ref cleanup' '
 	test -z "$(git replace)"
 '
 
+test_expect_success '--graft with and without already replaced object' '
+	test $(git log --oneline | wc -l) = 7 &&
+	git replace --graft $HASH5 &&
+	test $(git log --oneline | wc -l) = 3 &&
+	git cat-file -p $HASH5 | test_must_fail grep parent &&
+	test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
+	git replace --force -g $HASH5 $HASH4 $HASH3 &&
+	git cat-file -p $HASH5 | grep "parent $HASH4" &&
+	git cat-file -p $HASH5 | grep "parent $HASH3" &&
+	git replace -d $HASH5
+'
+
 test_done
-- 
1.9.rc0.17.g651113e

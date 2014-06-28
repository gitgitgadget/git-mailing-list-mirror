From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 2/7] replace: add test for --graft
Date: Sat, 28 Jun 2014 20:11:11 +0200
Message-ID: <20140628181117.5687.23923.chriscool@tuxfamily.org>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 20:19:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0xEE-0007b1-9K
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 20:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbaF1STu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 14:19:50 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:59209 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032AbaF1STr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 14:19:47 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B35E7F5;
	Sat, 28 Jun 2014 20:19:45 +0200 (CEST)
X-git-sha1: 33ffb3e0c4c40eee6bd4dbca6ab1e4e53aee458b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252609>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.0.0.421.g786a89d.dirty

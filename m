From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] send-email: test --no-thread --in-reply-to combination
Date: Wed, 11 Mar 2009 23:40:13 +0100
Message-ID: <356f6d0e8e2d6f7da3ef59f460fd34724ebbc6fd.1236811120.git.trast@student.ethz.ch>
References: <200903112337.36799.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhX7v-0000Ri-08
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZCKWkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 18:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbZCKWkq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:40:46 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:53802 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbZCKWkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 18:40:46 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Mar 2009 23:40:43 +0100
Received: from localhost.localdomain ([84.75.148.224]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 11 Mar 2009 23:40:42 +0100
X-Mailer: git-send-email 1.6.2.489.g51f6b7
In-Reply-To: <200903112337.36799.trast@student.ethz.ch>
X-OriginalArrivalTime: 11 Mar 2009 22:40:43.0011 (UTC) FILETIME=[692ED530:01C9A29A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112986>

3e0c4ff (send-email: respect in-reply-to regardless of threading,
2009-03-01) fixed the handling of the In-Reply-To header when both
--no-thread and --in-reply-to are in effect.  Add a test for it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t9001-send-email.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 08d5b91..a46f747 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -531,4 +531,15 @@ test_expect_success 'feed two files' '
 	test "z$(sed -n -e 2p subjects)" = "zSubject: [PATCH 2/2] add master"
 '
 
+test_expect_success 'in-reply-to but no threading' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--in-reply-to="<in-reply-id@example.com>" \
+		--no-thread \
+		$patches |
+	grep "In-Reply-To: <in-reply-id@example.com>"
+'
+
 test_done
-- 
1.6.2.489.g51f6b7

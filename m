From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] git-patch-id: test for "no newline" markers
Date: Wed, 16 Feb 2011 17:55:37 +0100
Message-ID: <d27aa07556df763b34b980d3706320216094d592.1297875236.git.git@drmicha.warpmail.net>
References: <4D5BF73E.50002@drmicha.warpmail.net>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 17:58:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpkiK-0004jx-FR
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1BPQ6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 11:58:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41289 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752191Ab1BPQ6p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 11:58:45 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4A1F520592;
	Wed, 16 Feb 2011 11:58:45 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 16 Feb 2011 11:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=GA1K3hO6UNWwAG8OPQs4/P1fr/U=; b=tOTrgknC5xX+NGq2RcX8lq5m4GlZ8qgBgQtJvzqnP9gLTGT7pplvn+DmF3jkmB9ByF2PZo9GKQqHuu8fPOEu4rUjoiBCIkTzDzLniEjH5VsI0giUYJyOHXfbVbfK44s6OpWJQn622pFJQMQQ4ze1j4ISUVHM38BXD+jZgrlU6y8=
X-Sasl-enc: VhSh3eS6HLmoBMh/qpv4WqCTFNcCXIvp8NbKzC2/xrC/ 1297875524
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B368340272B;
	Wed, 16 Feb 2011 11:58:44 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <4D5BF73E.50002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166976>

Currently, patch-id trips over our very own diff extension for marking
the absence of newline at EOF.

Expose this in a test.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t4204-patch-id.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 68e2652..db96064 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -63,4 +63,40 @@ test_expect_success 'patch-id supports git-format-patch MIME output' '
 	test_cmp patch-id_master patch-id_same
 '
 
+cat >nonl <<\EOF
+diff --git i/a w/a
+index e69de29..2e65efe 100644
+--- i/a
++++ w/a
+@@ -0,0 +1 @@
++a
+\ No newline at end of file
+diff --git i/b w/b
+index e69de29..6178079 100644
+--- i/b
++++ w/b
+@@ -0,0 +1 @@
++b
+EOF
+
+cat >withnl <<\EOF
+diff --git i/a w/a
+index e69de29..7898192 100644
+--- i/a
++++ w/a
+@@ -0,0 +1 @@
++a
+diff --git i/b w/b
+index e69de29..6178079 100644
+--- i/b
++++ w/b
+@@ -0,0 +1 @@
++b
+EOF
+
+test_expect_failure 'patch-id handles no-nl-at-eof markers' '
+	cat nonl | calc_patch_id nonl &&
+	cat withnl | calc_patch_id withnl &&
+	test_cmp patch-id_nonl patch-id_withnl
+'
 test_done
-- 
1.7.4.1.74.gf39475.dirty

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 1/2] git-patch-id: test for "no newline" markers
Date: Fri, 18 Feb 2011 11:12:41 +0100
Message-ID: <26bc8a07f1b965a3022c3a1542f95422a8462e42.1298023827.git.git@drmicha.warpmail.net>
References: <4D5E278F.2010509@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 11:16:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqNNb-0008JG-BW
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 11:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab1BRKPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 05:15:55 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44240 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947Ab1BRKPy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 05:15:54 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9851E20E49;
	Fri, 18 Feb 2011 05:15:53 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 18 Feb 2011 05:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ImrnfuQXKObFHQBnGbmjph6v81A=; b=AFoW8BHpoz1neM6ydfli7f6j0iQ+8CX+4rmdO5B6+7Y1SjYcsxremDYq4Q3MIC0pi+5o/KXf3FqKzGgjuw2DkWGgFpF4ONDkOjJ91AirCb9wYRK0rYh+KZHPl/bvCqs5QjGVj6BTinq1bPHKE/Pf8dUt/M5ra0CdnooN19Od9cE=
X-Sasl-enc: oG993AMK8vk4JOdF8/nyBSJIWdj6RgM4WpptsqqoNvpp 1298024153
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1AA2540215B;
	Fri, 18 Feb 2011 05:15:52 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <4D5E278F.2010509@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167192>

Currently, patch-id trips over the diff extension for marking
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

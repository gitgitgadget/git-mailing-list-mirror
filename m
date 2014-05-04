From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] t: remote-hg: trivial cleanups and fixes
Date: Sat,  3 May 2014 21:16:53 -0500
Message-ID: <1399169814-20201-4-git-send-email-felipe.contreras@gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 04:27:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgm9l-0005zA-6V
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 04:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbaEDC1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 22:27:44 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:53607 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaEDC1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 22:27:44 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so6690oag.25
        for <git@vger.kernel.org>; Sat, 03 May 2014 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQzY/b4NhXyXuH43mXqfZPBvdkU2QA0fYh5GfBtuRuM=;
        b=q5LzY4Un08sBZrDt2kTDnjwN2mwhnLQEIdyW61C4HmEVF2fxSu3mWrnx20EiRUDMAo
         cHeKZRwndQWXj+AVQRr2PPeAvbctMQWC+tFLmOwQjKHmItjltGGRyigOjXS7biaS6OZh
         mexYov/zNmrv2UH/rB3XVaMkjhJNW+BabL3ok1liRDPxu0k9bCg/LPHZ+8OwVvvZXIsC
         N0Wr8PYSGSXGO8tdjJa0MiG3qNnMs93AP+OT1u5GWpsswmS4EdqIWqSBn0CAIfrxGA+h
         5U30xg7N/V5DvU+TexYdZLCxUEbI6hqzdw56Cr4Cg3vePrWGJOQdeVgozzh16Xkac7na
         xtcA==
X-Received: by 10.60.115.129 with SMTP id jo1mr25618180oeb.0.1399170463685;
        Sat, 03 May 2014 19:27:43 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p1sm8995141obn.20.2014.05.03.19.27.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 19:27:42 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248064>

There was a broken && chain, and cat is simpler than echo in a subshell.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index df09966..9b9468b 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -25,7 +25,7 @@ fi
 
 check () {
 	echo $3 >expected &&
-	git --git-dir=$1/.git log --format='%s' -1 $2 >actual
+	git --git-dir=$1/.git log --format='%s' -1 $2 >actual &&
 	test_cmp expected actual
 }
 
@@ -103,12 +103,12 @@ check_push () {
 }
 
 setup () {
-	(
-	echo "[ui]"
-	echo "username = H G Wells <wells@example.com>"
-	echo "[extensions]"
-	echo "mq ="
-	) >>"$HOME"/.hgrc &&
+	cat >> "$HOME"/.hgrc <<-EOF &&
+	[ui]
+	username = H G Wells <wells@example.com>
+	[extensions]
+	mq =
+	EOF
 
 	GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0230" &&
 	GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE" &&
-- 
1.9.2+fc1.20.g204a630

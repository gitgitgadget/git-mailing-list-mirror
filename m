From: vfr@lyx.org
Subject: [PATCH] t0020: make sure the test file is lf to start with
Date: Sun, 10 Jun 2012 10:32:32 +0000
Message-ID: <1339324352-7376-1-git-send-email-vfr@lyx.org>
Cc: msysgit@googlegroups.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 12:33:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdfS9-0001Mz-50
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 12:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab2FJKc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 06:32:57 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46746 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab2FJKcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 06:32:55 -0400
Received: by wgbdr13 with SMTP id dr13so2222637wgb.1
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 03:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=sPZ0PaQMdxVJ++oMbEqniol2Re8giV9OzIpU9qLizO0=;
        b=DjJ+pRUHGeGb0MNAPTSXgM5VK+dxd+yNspk7Lu2/SwwvZ7YZXO98sZcgRDTKV4sWfc
         AyVw5dR6ntum2x56BS0ml/XW/XoUdN5YKt9hz5TrW97UUEHl/bJLejnGWkoRIT5hjS8I
         JW2qhKBkeSMXoYE0Os5UrL7QDauU7mkRi9EyOtZZ4ubOvytk6K0O+D8mNuFutkjSxS4u
         MwSaIYt1KbPBBbtBRzPk2pE1Vs8PEQ428RmK8qlDI2OGZTcZu9CsMZieoC7ZwXo/5UJA
         yeQUHPbfbTpfqDkZ6a9uaQuk57o1j6OfJFaQE/MwS6IHZXourXaG6WCW72ASNCzx25nK
         bFYw==
Received: by 10.180.102.228 with SMTP id fr4mr13037241wib.6.1339324374386;
        Sun, 10 Jun 2012 03:32:54 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id f7sm25502643wiv.2.2012.06.10.03.32.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 03:32:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQlchaFe1yJTw/u2nf/rIIjx5mOAB1Wa9le3PHtDujb4xLxc5L/KmSMBfi6C71K1+8TRrUu5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199583>

From: Vincent van Ravesteijn <vfr@lyx.org>

On Windows, the perl interpreter used by q_to_nul also converts the
eol-style to crlf. Because the eol-style is now wrong from the beginning, the
later tests '.gitattributes says two is binary' and 'checkout with
existing .gitattributes' fail. This patch makes sure that the eol-style is
lf when the test file is setup and makes the tests to pass also on
Windows.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>

---
I'm not sure everyone will like this solution to fix a problem that is only present on Windows. I'd be happy to discuss a different solution. 

 t/t0020-crlf.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 1a8f44c..4c41b6e 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 	for w in Hello world how are you; do echo $w; done >one &&
 	mkdir dir &&
 	for w in I am very very fine thank you; do echo $w; done >dir/two &&
-	for w in Oh here is NULQin text here; do echo $w; done | q_to_nul >three &&
+	for w in Oh here is NULQin text here; do echo $w; done | q_to_nul | remove_cr >three &&
 	git add . &&
 
 	git commit -m initial &&
-- 
1.7.9.msysgit.0

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Mon,  2 Sep 2013 01:30:38 -0500
Message-ID: <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:35:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNja-0003jJ-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785Ab3IBGfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:35:32 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:48275 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3IBGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:35:30 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so4762480oag.40
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBPnoiF3uGgEb+ZAXpnlb2WZUy0oHksZArbmNXrYZOQ=;
        b=lyRN6aI/N3FJzbtRMgzkK3tuWlzltCqeO7Mi4X5fwEtiW7jcHIJRrjGjEN2jX1ZMNV
         RhQBUveGsmJDhIpyUkyELC8zzrFW1THK0Rwbt2D9HG2aBFfYERLD4CkEcg2ai+VWUCuy
         +ZsWCm+wSD4T6FQthTxyXsrhxGqn3sRkaJ065Wwr+ouIDezbPuXuHocjxHICIfMfAPQW
         INsoETlaR2iuwonwDvC2tNSi/qGfuLvrz/6fz4hxqZ2BXvRf+dknV/9ixgqjGTIc6ioL
         UhtEoQe4qMaFzJmTUmome04DvB6X79G3hcDbLF1rXQJ4Z5B7dNv+BpadXCEQsFgDWlyt
         T18A==
X-Received: by 10.182.199.38 with SMTP id jh6mr16131474obc.33.1378103729806;
        Sun, 01 Sep 2013 23:35:29 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm12522668oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 23:35:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233613>

Just as 5 == X is weird, so is comparing first the expected value, and
then the value we are testing. So switch them around.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index c10580c..b9aef31 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -22,7 +22,7 @@ test_expect_success 'start is valid' '
 '
 
 test_expect_success 'start^0' '
-	test $(cat .git/refs/tags/start) = $(git rev-parse start^0)
+	test $(git rev-parse start^0) = $(cat .git/refs/tags/start)
 '
 
 test_expect_success 'start^1 not valid' '
@@ -34,15 +34,15 @@ test_expect_success 'second^1 = second^' '
 '
 
 test_expect_success 'final^1^1^1' '
-	test $(git rev-parse start) = $(git rev-parse final^1^1^1)
+	test $(git rev-parse final^1^1^1) = $(git rev-parse start)
 '
 
 test_expect_success 'final^1^1^1 = final^^^' '
-	test $(git rev-parse final^1^1^1) = $(git rev-parse final^^^)
+	test $(git rev-parse final^^^) = $(git rev-parse final^1^1^1)
 '
 
 test_expect_success 'final^1^2' '
-	test $(git rev-parse start2) = $(git rev-parse final^1^2)
+	test $(git rev-parse final^1^2) = $(git rev-parse start2)
 '
 
 test_expect_success 'final^1^2 != final^1^1' '
-- 
1.8.4-338-gefd7fa6

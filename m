From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] t: rev-parse-parents: simplify setup
Date: Mon,  2 Sep 2013 01:30:39 -0500
Message-ID: <1378103439-3225-5-git-send-email-felipe.contreras@gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 02 08:35:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNjh-0003lm-91
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756971Ab3IBGfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:35:34 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:59742 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3IBGfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:35:32 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so922261oag.32
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hFksBcNMZKEi2/Aq5ahL4XfNkdy9HezFEidh3MY4sio=;
        b=M0ILmwD5QwzBWd2pTsAAzzPrp7UjQS97nkmkvYLTjHdBmmGgBduCfkO8iVlEirmz/i
         ptkp2fy51CrxGvcR6BfugUwDcWz1NaT6/jfEPNjqYrFBSJUaLzBtjlGbkliW2bvhOqKn
         /Rf9k0dU0Fo9D+Mm7Y5a+yjJAWMu+RdIKwxlcS9X19F5V1fznNBFPZIlFoRZqpQ+d+nO
         ePm1NWQBE+vRMBvprU1Lgv+Dk1WAyjLODHr36xN+XMxEB2hJPSsCwybpSD2nhl6USo64
         FVUrjEK0lpuSAfmFshoTjLnb8eqoiFzbzKFBZ5B/9GmHDk9wiLCPilQ/IK1zdQ5L7sXl
         0UFw==
X-Received: by 10.182.242.37 with SMTP id wn5mr15842631obc.56.1378103732318;
        Sun, 01 Sep 2013 23:35:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm12528563oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 23:35:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233614>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index b9aef31..0653f5e 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -6,16 +6,16 @@
 test_description='Test git rev-parse with different parent options'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
-
-date >path0
-git update-index --add path0
-save_tag tree git write-tree
-hide_error save_tag start unique_commit "start" tree
-save_tag second unique_commit "second" tree -p start
-hide_error save_tag start2 unique_commit "start2" tree
-save_tag two_parents unique_commit "next" tree -p second -p start2
-save_tag final unique_commit "final" tree -p two_parents
+
+test_expect_success 'setup' '
+	test_commit start &&
+	test_commit second &&
+	git checkout --orphan tmp &&
+	test_commit start2 &&
+	git checkout master &&
+	git merge -m next start2 &&
+	test_commit final
+'
 
 test_expect_success 'start is valid' '
 	git rev-parse start | grep "^[0-9a-f]\{40\}$"
-- 
1.8.4-338-gefd7fa6

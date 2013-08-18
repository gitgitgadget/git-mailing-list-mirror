From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 01/24] t2104: Don't fail for index versions other than [23]
Date: Sun, 18 Aug 2013 21:41:50 +0200
Message-ID: <1376854933-31241-2-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8xQ-0003Yv-8h
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab3HRTsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:07 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41002 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3HRTsG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:06 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so1383694wgh.8
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m5bvIMlM7ynzLPzSDzYYpFFqvWUpOhc+Sq0vIlC7g+k=;
        b=LqquMWwl8Ak3mpMGMgfSTTK1iSGJr7PRC2P/tP5e/RjGN1IgNCohFAkhsILU8mMLx7
         Fdb83RUBpOMuptzOnVO8WpcqVyaNoKY6yDA2TzhDYG5q8at/J+sx6NG4SVgeNIYQWIK6
         Gm5O40zExIS0GyMLTkrmZEKFkNB/zc//Ds3giqfzuV2e2iBTfXJyNYzDWSgBdPsWE4xe
         SoMPQ/jKZfPyvPdSOAAT+sVxUb5fs354RNME45BTNOqTpOgrDXIumsQ7Aj4QOE0zLfkA
         XXHBX0EVFIMlL78ZdsR5ZVWXsgZ6GEQo87uScCwTcJ7qcx2sNmXb5VzLc/h60ZIIcWgt
         aEEg==
X-Received: by 10.180.149.204 with SMTP id uc12mr5467365wib.47.1376855285227;
        Sun, 18 Aug 2013 12:48:05 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id hb2sm13377654wib.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232489>

t2104 currently checks for the exact index version 2 or 3,
depending if there is a skip-worktree flag or not. Other
index versions do not use extended flags and thus cannot
be tested for version changes.

Make this test update the index to version 2 at the beginning
of the test. Testing the skip-worktree flags for the default
index format is still covered by t7011 and t7012.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2104-update-index-skip-worktree.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 1d0879b..bd9644f 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -22,6 +22,7 @@ H sub/2
 EOF
 
 test_expect_success 'setup' '
+	git update-index --index-version=2 &&
 	mkdir sub &&
 	touch ./1 ./2 sub/1 sub/2 &&
 	git add 1 2 sub/1 sub/2 &&
-- 
1.8.3.4.1231.g9fbf354.dirty

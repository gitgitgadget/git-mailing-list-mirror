From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/5 v2] t/test-lib-functions.sh: allow to specify the tag name to test_commit
Date: Wed, 14 Nov 2012 21:49:30 -0800
Message-ID: <1352958570-18724-1-git-send-email-drafnel@gmail.com>
References: <20121115032005.GA20677@ftbfs.org>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: kraai@ftbfs.org
X-From: git-owner@vger.kernel.org Thu Nov 15 06:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYsKz-0001UZ-5O
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 06:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab2KOFtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 00:49:49 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63040 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2KOFts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 00:49:48 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so841040pad.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 21:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2FnDZ0geJ+70qloa2pYdpznOL6c1emvWGYunPQQ+Fac=;
        b=lmRR8zDMAArAJR80EMO/v6+UUBDzd5AYd2TZYLW/NGfJ26N5scwXL6g+pH/eNqyyEM
         67owNAtjJ/ep58kwZMW238yIu03QH6q0RMzyeVNiRXDrbKXCwd2mjzNz6rt1U+HUgzGs
         ZIEqTx+9MuqPp6TJgZJegu/XYwmJLQl9Pq1GviI7ffx0V7d7g3Esutc53B+5DOHtaBHY
         d933NSmH6Pjk6LH2Ttbwe0np+2DcCQqNOdd9oEcwJR5in48KIK/UTKd8PB0Ob93u1Gy1
         Fgf6C93PiYlJroUHBh//N+KsCRKGJ2d7LtXz2oE/cs4cHiKGrKU3j6HjTbRSlPYvx8sw
         ZgwA==
Received: by 10.69.0.10 with SMTP id au10mr1572232pbd.18.1352958588009;
        Wed, 14 Nov 2012 21:49:48 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net. (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id c8sm9161883pav.4.2012.11.14.21.49.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 21:49:47 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <20121115032005.GA20677@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209797>

The <message> part of test_commit() may not be appropriate for a tag name.
So let's allow test_commit to accept a fourth argument to specify the tag
name.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/test-lib-functions.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8889ba5..9e2b8b8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -135,12 +135,13 @@ test_pause () {
 	fi
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message.  It will also add a tag with <message> as name unless <tag> is
+# given.
 #
-# Both <file> and <contents> default to <message>.
+# <file>, <contents>, and <tag> all default to <message>.
 
 test_commit () {
 	notick= &&
@@ -168,7 +169,7 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
-	git tag "$1"
+	git tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
1.8.0

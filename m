From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t/annotate-tests: Use echo & cat instead of sed
Date: Thu,  5 May 2011 00:43:37 -0400
Message-ID: <1304570617-17603-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 06:54:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHqaQ-0005Ub-IE
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 06:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002Ab1EEEyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 00:54:32 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56037 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab1EEEyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 00:54:32 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6086E1FFC134; Thu,  5 May 2011 04:43:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	by silverinsanity.com (Postfix) with ESMTPA id 1536B1FFC0F6;
	Thu,  5 May 2011 04:43:27 +0000 (UTC)
X-Mailer: git-send-email 1.7.5.258.g6ba2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172795>

The use of the sed command "1i No robots allowed" caused the version
of sed in OS X to die with

   sed: 1: "1i "No robots allowed"\n": command i expects \ followed by
   text

Since this command was just trying to add a single line to the
beginning of the file, do the same with "echo > file.net && cat file
>> file.new"

Unbreaks t8001 and t8002 on OS X 10.6.7
---
 t/annotate-tests.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index abb1885..c56a77d 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -127,7 +127,8 @@ test_expect_success \
 
 test_expect_success \
     'an obfuscated email added' \
-    'sed -e "1i No robots allowed" < file > file.new &&
+    'echo "No robots allowed" > file.new &&
+     cat file >> file.new &&
      mv file.new file &&
      GIT_AUTHOR_NAME="E" GIT_AUTHOR_EMAIL="E at test dot git" git commit -a -m "norobots"'
 
-- 
1.7.5.258.g6ba2f

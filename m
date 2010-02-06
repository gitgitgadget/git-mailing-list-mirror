From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t9501: Correctly force over max load everywhere
Date: Sat,  6 Feb 2010 09:50:03 -0500
Message-ID: <1265467803-31210-1-git-send-email-brian@gernhardtsoftware.com>
References: <201002061505.13886.jnareb@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdlzF-0007B4-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 15:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab0BFOuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 09:50:10 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:43622 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab0BFOuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 09:50:09 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 005E01FFC1CE; Sat,  6 Feb 2010 14:50:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (unknown [64.134.69.84])
	by silverinsanity.com (Postfix) with ESMTPA id B30C31FFC06B;
	Sat,  6 Feb 2010 14:50:01 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.205.g52ece
In-Reply-To: <201002061505.13886.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139171>

The code to check for load returns 0 if it doesn't know how to find
load.  It also checks to see if the current load is higher than the
max load.  So to force the script to quit early by setting the maxload
variable negative which should work for systems where we can detect
load (which should be a positive number) and systems where we can't
(where detected load is 0)

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Tested and works.

 t/t9501-gitweb-standalone-http-status.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 7590f10..d196cc5 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -117,7 +117,7 @@ test_debug 'cat gitweb.output'
 
 # always hit the load limit
 cat >>gitweb_config.perl <<\EOF
-our $maxload = 0;
+our $maxload = -1;
 EOF
 
 test_expect_success 'load checking: load too high (default action)' '
-- 
1.7.0.rc1.205.g52ece

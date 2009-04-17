From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 1/5] archive tests: do not use .gitattributes in working
 directory
Date: Sat, 18 Apr 2009 00:17:49 +0200
Message-ID: <49E9000D.1050808@lsrfire.ath.cx>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwQ1-0000iT-Pi
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759782AbZDQWSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753537AbZDQWSA
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:18:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:46208 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbZDQWR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 18:17:59 -0400
Received: from [10.0.1.101] (p57B7DF1E.dip.t-dialin.net [87.183.223.30])
	by india601.server4you.de (Postfix) with ESMTPSA id 44FE62F8044;
	Sat, 18 Apr 2009 00:17:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116793>

We are interested in using archive mostly from a bare repository, so it
should not add .gitattributes to the work tree.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5000-tar-tree.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7641e0d..abb41b0 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,7 +50,7 @@ test_expect_success \
 test_expect_success \
     'add ignored file' \
     'echo ignore me >a/ignored &&
-     echo ignored export-ignore >.gitattributes'
+     echo ignored export-ignore >.git/info/attributes'
 
 test_expect_success \
     'add files to repository' \
@@ -64,7 +64,7 @@ test_expect_success \
 test_expect_success \
     'create bare clone' \
     'git clone --bare . bare.git &&
-     cp .gitattributes bare.git/info/attributes'
+     cp .git/info/attributes bare.git/info/attributes'
 
 test_expect_success \
     'remove ignored file' \
@@ -139,10 +139,11 @@ test_expect_success \
 
 test_expect_success \
     'create archives with substfiles' \
-    'echo "substfile?" export-subst >a/.gitattributes &&
+    'cp .git/info/attributes .git/info/attributes.before &&
+     echo "substfile?" export-subst >>.git/info/attributes &&
      git archive HEAD >f.tar &&
      git archive --prefix=prefix/ HEAD >g.tar &&
-     rm a/.gitattributes'
+     mv .git/info/attributes.before .git/info/attributes'
 
 test_expect_success \
     'extract substfiles' \
-- 
1.6.3.rc0

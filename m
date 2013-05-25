From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 20/48] remote-bzr: simplify test checks
Date: Fri, 24 May 2013 21:29:36 -0500
Message-ID: <1369449004-17981-21-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hs-00022Y-Cd
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab3EYCcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:46 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:33394 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab3EYCco (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:44 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so7018451oag.15
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ndwg3EE/c59CKo/bW54I8UTpIyx2fGsNDrCK16oSqyM=;
        b=0HWGycSliazzs1Npnh+6/2ajQlTmKe+F1dLzzpO6p8ErONaMlfYi66P9KLgBFKdEJo
         8ki6ZYVg2TOnSsrkMtIByyPT/uLHMavoxwd+61O+4WWW5HWSQj4b++6FdummVhBuMZSm
         ynaqnP3u3k+l2BYg84wQtNIQd8o2GWiqOBct66qudSZcSGtNDhG/49cxK50UAYEQOk7o
         IHVC1XMJDhhhSeXYi3Zf2BlgNVKGPdglwMYoTPxoEei3u2QXM1C+8scnbkfEghkarEds
         KEq+CtvxTVLmvM2t0NVKjthJJmUitlskU5buv0j+eNWUI1fhqE45pDqCLXyeeD6JFwKG
         P8AQ==
X-Received: by 10.182.204.105 with SMTP id kx9mr13241378obc.81.1369449163790;
        Fri, 24 May 2013 19:32:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm20121244obl.1.2013.05.24.19.32.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225435>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 0276db0..435b280 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -18,15 +18,8 @@ if ! "$PYTHON_PATH" -c 'import bzrlib'; then
 fi
 
 check () {
-	(
-	cd $1 &&
-	git log --format='%s' -1 &&
-	git symbolic-ref HEAD
-	) > actual &&
-	(
-	echo $2 &&
-	echo "refs/heads/$3"
-	) > expected &&
+	echo $3 > expected &&
+	git --git-dir=$1/.git log --format='%s' -1 $2 > actual
 	test_cmp expected actual
 }
 
@@ -42,7 +35,7 @@ test_expect_success 'cloning' '
 	) &&
 
 	git clone "bzr::bzrrepo" gitrepo &&
-	check gitrepo one master
+	check gitrepo HEAD one
 '
 
 test_expect_success 'pulling' '
@@ -54,7 +47,7 @@ test_expect_success 'pulling' '
 
 	(cd gitrepo && git pull) &&
 
-	check gitrepo two master
+	check gitrepo HEAD two
 '
 
 test_expect_success 'pushing' '
@@ -89,7 +82,7 @@ test_expect_success 'roundtrip' '
 
 	(cd gitrepo && git pull && git push) &&
 
-	check gitrepo four master &&
+	check gitrepo HEAD four &&
 
 	(
 	cd gitrepo &&
-- 
1.8.3.rc3.312.g47657de

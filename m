From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 27/47] remote-bzr: simplify test checks
Date: Mon, 13 May 2013 23:36:50 -0500
Message-ID: <1368506230-19614-28-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72F-0004WY-2x
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab3ENEkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:11 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:50304 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755745Ab3ENEkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:08 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so103269oah.10
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nM6+NzNYEn/aNghO8O2nMksgCbEiasnd2ZYDeI92myc=;
        b=qmylV6FeVRPkotlrryvpFjLYHubdnNjN09PxAmr4BiRh3IFunzD7Neyj136Pwa/w8A
         tXLo1weSdrtyTbR5gcZDyNU4DwWpikfUjOnzV3wNY+8llMaHQ2PfJqKbb0I46oKniY+7
         bD1mYb2oL3wY/m+BgBPVKRkbs0FYOQPTWz1UW7f9eHqPAj6Z6XWzMZmgS0jGwJ84T65T
         8QFDQvdlqg1yQNVvyGZxmtV/YAf8l3j7rQoxCO7Ks1jdJR+6DiAfkT1Xn2L6lLuem00n
         O8y3Y0YgPOrglWl/1OUYGkKPmrSc0aleU7O6c2TJ5DB4oPvVJVKx4QVAcjCdfWn4zq7F
         gfrg==
X-Received: by 10.60.79.198 with SMTP id l6mr15136205oex.47.1368506408016;
        Mon, 13 May 2013 21:40:08 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm20503828oez.4.2013.05.13.21.40.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224258>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 90f8c7f..220e388 100755
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
1.8.3.rc1.579.g184e698

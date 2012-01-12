From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] stash show: use default pretty format
Date: Thu, 12 Jan 2012 15:05:53 +0800
Message-ID: <1326351953-3724-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 08:06:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlEjf-00058F-C2
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 08:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab2ALHGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 02:06:04 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33075 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab2ALHGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 02:06:01 -0500
Received: by ghbg16 with SMTP id g16so124203ghb.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 23:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=a86riA9Ykz8HDdjOOEoORMTovvyWfAPVG5ba4yYzFEo=;
        b=o5bBh7ojuhNh0y1WSeFEIoofB4Rtq002LuJ98DhNoIC0OHbwoRHoulJfSp4Edn6Zgq
         1Prtzf4M3m9i0OIiHopxaNA0q/65gJVb2JmkeAVkVuwdWuuGtGpDDByl2Jae3gZ1e8uI
         HWbcadDj/ACYry/qsQIrRBWzm18ftDB2W55QU=
Received: by 10.236.152.35 with SMTP id c23mr3544804yhk.58.1326351961181;
        Wed, 11 Jan 2012 23:06:01 -0800 (PST)
Received: from localhost (nusnet-228-27.dynip.nus.edu.sg. [137.132.228.27])
        by mx.google.com with ESMTPS id u47sm7072674yhl.0.2012.01.11.23.05.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 23:05:59 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188433>

By default (ie. when stash show is invoked without any arguments), the
diff stat of the stashed changes is displayed. Let git-diff decide the
default pretty format to use.

This gives git more consistency, as users who have set their
pretty.format config would naturally expect `git-stash show` to display
the diff in the same pretty format as the other diff-producing procelain
like git-log and git-show.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 git-stash.sh     |    2 +-
 t/t3903-stash.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index fe4ab28..a0db3de 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -271,7 +271,7 @@ list_stash () {
 show_stash () {
 	assert_stash_like "$@"
 
-	git diff ${FLAGS:---stat} $b_commit $w_commit
+	git diff ${FLAGS} $b_commit $w_commit
 }
 
 #
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index dbe2ac1..7a18af8 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -446,7 +446,7 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	 file |    1 +
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
-	git stash show ${STASH_ID} >actual &&
+	git stash show --stat ${STASH_ID} >actual &&
 	test_cmp expected actual
 '
 
@@ -484,7 +484,7 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	 file |    1 +
 	 1 files changed, 1 insertions(+), 0 deletions(-)
 	EOF
-	git stash show ${STASH_ID} >actual &&
+	git stash show --stat ${STASH_ID} >actual &&
 	test_cmp expected actual
 '
 
-- 
1.7.9.rc0.132.ge406

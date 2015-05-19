From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 3/3] git-p4: tests: use test-chmtime in place of touch
Date: Tue, 19 May 2015 23:23:18 +0100
Message-ID: <1432074198-13806-4-git-send-email-luke@diamand.org>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
 <1432074198-13806-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 00:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupvu-0005dQ-Og
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbESWYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:24:09 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38890 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbbESWYG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:24:06 -0400
Received: by wichy4 with SMTP id hy4so39305554wic.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C7hgPsSpcd9bgo2GZbJOdqX/2isukaTtH85WKxSpDTs=;
        b=CMsphreYTpXXsSzL5YKV7AzUXqkOVRTN2bZTDpfM6ES1stcInNQcoirybs/mhXYkLv
         iuuiP50nWHUv6j2HJdhu2wp694fsujYmFDoAjamzcwFKyO/Xb4rOEb5zcIQ57H9WKIsZ
         OzNxPN0fwHb0TcrATfoSnS3yb+s0mpoRNeUP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C7hgPsSpcd9bgo2GZbJOdqX/2isukaTtH85WKxSpDTs=;
        b=RQi+AP71mH2ITwaPCEnVeK0lQ/hyoq2qxiAA2Mc/sIx8aGG2gUOnSZ825bzrYR0KSk
         JuGQdl7BZbV3j4ACvwNHpGuV3MbQnAc2KdB3vAeFj6NDob+o/A9jSoqVlNtfsuw8S4th
         2jvnyVV2HwuOGXKrgSrbBMNVLWVfaZVVgFBKzioGUypOX31TzVdeucjF4M5lZAjKUxt/
         d1MU+AhzjDIMRQ9oxOHrrk9z0TSKOX+SYyx3qXgprHxPNSRYA9vi7I+XM4weXzxCnKW4
         qqOp8AeWuF0l+jYRAfeB8dfwhhR0p8vNApNlf9wYDCrdOQXcq3/pXKZkP5QASovUIRxV
         sY7A==
X-Gm-Message-State: ALoCoQl5zYFEuI4hUzbcg/gDhpbwujF1s5ilRKZqI5tIKwpjfGX5fd1VA/fxQTcJWg0Zz/M1BlJX
X-Received: by 10.194.239.99 with SMTP id vr3mr59455997wjc.151.1432074244637;
        Tue, 19 May 2015 15:24:04 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id x10sm23711568wjf.45.2015.05.19.15.24.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 15:24:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <1432074198-13806-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269425>

Using "touch" for P4EDITOR means that the tests can be a bit
racy, since git-p4 checks the timestamp has been updated and
fails if the timestamp is not updated.

Use test-chmtime instead, which is designed for this.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9803-git-p4-shell-metachars.sh  | 4 ++--
 t/t9805-git-p4-skip-submit-edit.sh | 2 +-
 t/t9813-git-p4-preserve-users.sh   | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index fbacff3..d950c7d 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -28,7 +28,7 @@ test_expect_success 'shell metachars in filenames' '
 		echo f2 >"file with spaces" &&
 		git add "file with spaces" &&
 		git commit -m "add files" &&
-		P4EDITOR=touch git p4 submit
+		P4EDITOR="test-chmtime +5" git p4 submit
 	) &&
 	(
 		cd "$cli" &&
@@ -47,7 +47,7 @@ test_expect_success 'deleting with shell metachars' '
 		git rm foo\$bar &&
 		git rm file\ with\ spaces &&
 		git commit -m "remove files" &&
-		P4EDITOR=touch git p4 submit
+		P4EDITOR="test-chmtime +5" git p4 submit
 	) &&
 	(
 		cd "$cli" &&
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 5fbf904..dc8fc0c 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -17,7 +17,6 @@ test_expect_success 'init depot' '
 	)
 '
 
-# this works because P4EDITOR is set to true
 test_expect_success 'no config, unedited, say yes' '
 	git p4 clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
@@ -25,6 +24,7 @@ test_expect_success 'no config, unedited, say yes' '
 		cd "$git" &&
 		echo line >>file1 &&
 		git commit -a -m "change 2" &&
+		P4EDITOR="test-chmtime +5" &&
 		echo y | git p4 submit &&
 		p4 changes //depot/... >wc &&
 		test_line_count = 2 wc
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 166b840..fe65788 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -53,7 +53,8 @@ test_expect_success 'preserve users' '
 		git commit --author "Alice <alice@example.com>" -m "a change by alice" file1 &&
 		git commit --author "Bob <bob@example.com>" -m "a change by bob" file2 &&
 		git config git-p4.skipSubmitEditCheck true &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret git p4 commit --preserve-user &&
+		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
+		git p4 commit --preserve-user &&
 		p4_check_commit_author file1 alice &&
 		p4_check_commit_author file2 bob
 	)
@@ -69,7 +70,7 @@ test_expect_success 'refuse to preserve users without perms' '
 		git config git-p4.skipSubmitEditCheck true &&
 		echo "username-noperms: a change by alice" >>file1 &&
 		git commit --author "Alice <alice@example.com>" -m "perms: a change by alice" file1 &&
-		P4EDITOR=touch P4USER=bob P4PASSWD=secret &&
+		P4EDITOR="test-chmtime +5" P4USER=bob P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		test_must_fail git p4 commit --preserve-user &&
 		! git diff --exit-code HEAD..p4/master
@@ -87,7 +88,7 @@ test_expect_success 'preserve user where author is unknown to p4' '
 		git commit --author "Bob <bob@example.com>" -m "preserve: a change by bob" file1 &&
 		echo "username-unknown: a change by charlie" >>file1 &&
 		git commit --author "Charlie <charlie@example.com>" -m "preserve: a change by charlie" file1 &&
-		P4EDITOR=touch P4USER=alice P4PASSWD=secret &&
+		P4EDITOR="test-chmtime +5" P4USER=alice P4PASSWD=secret &&
 		export P4EDITOR P4USER P4PASSWD &&
 		test_must_fail git p4 commit --preserve-user &&
 		! git diff --exit-code HEAD..p4/master &&
-- 
2.4.1.502.gb11c5ab

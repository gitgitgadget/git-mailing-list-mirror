From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/7] t6200: modernize with test_tick
Date: Wed, 24 Mar 2010 00:15:59 -0700
Message-ID: <1269414964-9518-3-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:17:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpu-0006wZ-3a
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab0CXHQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:26 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51811 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0CXHQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:13 -0400
Received: by gxk9 with SMTP id 9so1364583gxk.8
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7IT1VFgfdnLCbArWW6o5B4cL/GbScHEOuj6eTdwSYgE=;
        b=wgdLmqZm3gMXemj+rZnkeOjBgv+0LvIrPCsPJcbHA8LkD9A1dgUe5z90zmFP53OF0f
         1O0vHWuY8SdNEI/nZxIoMjwMq4lEeTOOFRI0VU7XTzMBKeyDxx+f28uPjj5p6WTDVCH+
         7aOTwpAQnduvDEMCiCyx9TelkSAhmI3gVAHSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ix+zpH4w1SjpPEPG0BzssS4rmcec3UZ1htZDP8lcTdjbGvtcLAUJNTJoClmBGquAQv
         NBcbeyjFcLe4gNjQ+m++hWtz4VTArQ+bYvYWsZWiVah8gfTbeTg9hYcg1TJjF6RhzQ/d
         2A33m/BQiMYqmxKown5X0EbcQhnV0UUvJ9Yzk=
Received: by 10.150.128.35 with SMTP id a35mr1536737ybd.213.1269414972430;
        Wed, 24 Mar 2010 00:16:12 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm5801584iwn.15.2010.03.24.00.16.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143070>

This test defines its own version of test_tick. Get rid of it.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   64 +++++++++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index ade209a..b24c5bf 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -7,18 +7,10 @@ test_description='fmt-merge-msg test'
 
 . ./test-lib.sh
 
-datestamp=1151939923
-setdate () {
-	GIT_COMMITTER_DATE="$datestamp +0200"
-	GIT_AUTHOR_DATE="$datestamp +0200"
-	datestamp=`expr "$datestamp" + 1`
-	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
-}
-
 test_expect_success setup '
 	echo one >one &&
 	git add one &&
-	setdate &&
+	test_tick &&
 	git commit -m "Initial" &&
 
 	git clone . remote &&
@@ -26,46 +18,48 @@ test_expect_success setup '
 	echo uno >one &&
 	echo dos >two &&
 	git add two &&
-	setdate &&
+	test_tick &&
 	git commit -a -m "Second" &&
 
 	git checkout -b left &&
 
-	echo $datestamp >one &&
-	setdate &&
+	echo "c1" >one &&
+	test_tick &&
 	git commit -a -m "Common #1" &&
 
-	echo $datestamp >one &&
-	setdate &&
+	echo "c2" >one &&
+	test_tick &&
 	git commit -a -m "Common #2" &&
 
 	git branch right &&
 
-	echo $datestamp >two &&
-	setdate &&
+	echo "l3" >two &&
+	test_tick &&
 	git commit -a -m "Left #3" &&
 
-	echo $datestamp >two &&
-	setdate &&
+	echo "l4" >two &&
+	test_tick &&
 	git commit -a -m "Left #4" &&
 
-	echo $datestamp >two &&
-	setdate &&
+	echo "l5" >two &&
+	test_tick &&
 	git commit -a -m "Left #5" &&
+	git tag tag-l5 &&
 
 	git checkout right &&
 
-	echo $datestamp >three &&
+	echo "r3" >three &&
 	git add three &&
-	setdate &&
+	test_tick &&
 	git commit -a -m "Right #3" &&
+	git tag tag-r3 &&
 
-	echo $datestamp >three &&
-	setdate &&
+	echo "r4" >three &&
+	test_tick &&
 	git commit -a -m "Right #4" &&
 
-	echo $datestamp >three &&
-	setdate &&
+	echo "r5" >three &&
+	test_tick &&
 	git commit -a -m "Right #5" &&
 
 	git show-branch
@@ -115,7 +109,7 @@ test_expect_success 'merge-msg test #3-1' '
 	git config merge.log true &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -129,7 +123,7 @@ test_expect_success 'merge-msg test #3-2' '
 	git config merge.summary true &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -161,7 +155,7 @@ test_expect_success 'merge-msg test #4-1' '
 	git config merge.log true &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -175,7 +169,7 @@ test_expect_success 'merge-msg test #4-2' '
 	git config merge.summary true &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -189,7 +183,7 @@ test_expect_success 'merge-msg test #5-1' '
 	git config merge.log yes &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -203,7 +197,7 @@ test_expect_success 'merge-msg test #5-2' '
 	git config merge.summary yes &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left right &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
@@ -217,7 +211,7 @@ test_expect_success 'merge-msg -F' '
 	git config merge.summary yes &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left right &&
 
 	git fmt-merge-msg -F .git/FETCH_HEAD >actual &&
@@ -231,7 +225,7 @@ test_expect_success 'merge-msg -F in subdirectory' '
 	git config merge.summary yes &&
 
 	git checkout master &&
-	setdate &&
+	test_tick &&
 	git fetch . left right &&
 	mkdir sub &&
 	cp .git/FETCH_HEAD sub/FETCH_HEAD &&
@@ -251,7 +245,7 @@ test_expect_success 'merge-msg with nothing to merge' '
 	(
 		cd remote &&
 		git checkout -b unrelated &&
-		setdate &&
+		test_tick &&
 		git fetch origin &&
 		git fmt-merge-msg <.git/FETCH_HEAD >../actual
 	) &&
-- 
1.7.0.3.254.g4503b

From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/2] t4034-diff-words: replace regex for diff driver
Date: Thu, 12 Jan 2012 01:25:01 +0800
Message-ID: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 18:39:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl29Q-0004QQ-QK
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 18:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933673Ab2AKRZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 12:25:13 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35635 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886Ab2AKRZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 12:25:10 -0500
Received: by vcbfk14 with SMTP id fk14so674012vcb.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 09:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tkvKqjsm+n/dgadaRZ0tNTPfqgzKf39bnGVuXq3OTgQ=;
        b=pmHrOwkb6ColHMVkNPOu7SjyWEXuHj/hCnDNWM9FTYcPGxpTjV2wLHX73yeanz0hmK
         /GEQ2rRUgDoWiO7tWpRePNSlmW0+jC9ejT7bGc94eh20ol/uR70EO4MySYBed8+tMsNj
         JICkuGI/FQpBOw98lNjFqal1R/0Vs31GKcHYU=
Received: by 10.221.13.2 with SMTP id pk2mr3186703vcb.71.1326302709375;
        Wed, 11 Jan 2012 09:25:09 -0800 (PST)
Received: from localhost (nusnet-253-163.dynip.nus.edu.sg. [137.132.253.163])
        by mx.google.com with ESMTPS id hk9sm1655270vdb.13.2012.01.11.09.25.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 09:25:07 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188376>

The next patch uses a non-whitespace regex, similar to the regex
currently used by the 'testdriver' diff driver; replace the regex with a
distinct one so that we can continue to conclude its effects.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

---
Kept separate to keep the next patch clean.
---
 t/t4034-diff-words.sh |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 6f1e5a2..9ae0e1a 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -46,6 +46,20 @@ cat >expect.non-whitespace-is-word <<-\EOF
 
 	<GREEN>aeff = aeff * ( aaa )<RESET>
 EOF
+cat >expect.everything-is-word <<-\EOF
+	<BOLD>diff --git a/pre b/post<RESET>
+	<BOLD>index 330b04f..5ed8eff 100644<RESET>
+	<BOLD>--- a/pre<RESET>
+	<BOLD>+++ b/post<RESET>
+	<CYAN>@@ -1,3 +1,7 @@<RESET>
+	<RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
+
+	a = b + c<RESET>
+
+	<GREEN>aa = a<RESET>
+
+	<GREEN>aeff = aeff * ( aaa )<RESET>
+EOF
 
 word_diff () {
 	test_must_fail git diff --no-index "$@" pre post >output &&
@@ -179,7 +193,7 @@ test_expect_success 'word diff with a regular expression' '
 '
 
 test_expect_success 'set up a diff driver' '
-	git config diff.testdriver.wordRegex "[^[:space:]]" &&
+	git config diff.testdriver.wordRegex ".+" &&
 	cat <<-\EOF >.gitattributes
 		pre diff=testdriver
 		post diff=testdriver
@@ -192,7 +206,7 @@ test_expect_success 'option overrides .gitattributes' '
 '
 
 test_expect_success 'use regex supplied by driver' '
-	cp expect.non-whitespace-is-word expect &&
+	cp expect.everything-is-word expect &&
 	word_diff --color-words
 '
 
@@ -224,7 +238,7 @@ test_expect_success 'command-line overrides config: --word-diff-regex' '
 '
 
 test_expect_success '.gitattributes override config' '
-	cp expect.non-whitespace-is-word expect &&
+	cp expect.everything-is-word expect &&
 	word_diff --color-words
 '
 
-- 
1.7.7.584.g16d0ea

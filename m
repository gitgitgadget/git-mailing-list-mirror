From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 2/3] t7508: test git status -v
Date: Fri,  6 Mar 2015 10:43:34 +0100
Message-ID: <4423047f119f779299bb426978d2d58a1ee7b305.1425634616.git.git@drmicha.warpmail.net>
References: <mqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 10:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTonQ-0000yg-OM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 10:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbbCFJnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 04:43:46 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39488 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932636AbbCFJnm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 04:43:42 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E5E272081E
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 04:43:39 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 06 Mar 2015 04:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=Bdm8orZTf3AsB4Ea2CuWo0DbquQ=; b=Q1FEzK8NLCvKdUYGGbJE
	+PmgyxKdAPJwwUEwfylou6XQRPeNmz7moBSYgQofZUcfuft38JaGuqysG9xssg+p
	/TfPeKrQRFnDHBXmiH/JK7v4fq3OdBBC0fwtf5lSswsHjzW6GD8Fte6V2JnEcZLs
	3lCZzwv5alI8qIisJG7sC1I=
X-Sasl-enc: pH8LZ8172ofZ6adbq34wzYHWV5k/zZ6yC5AOhGJYt710 1425635020
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 10E13C002A6;
	Fri,  6 Mar 2015 04:43:39 -0500 (EST)
X-Mailer: git-send-email 2.3.1.303.g5174db1
In-Reply-To: <mqqfv9j2nqu.fsf@gitster.dls.corp.google.com>
In-Reply-To: <cover.1425634616.git.git@drmicha.warpmail.net>
References: <cover.1425634616.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264903>

"status -v" had no test. Include one.

This also requires changing the .gitignore subtests, which is a good thing:
they include testing a .gitignore pattern now.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 514df67..e3c9cf9 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -137,6 +137,12 @@ test_expect_success 'status with status.displayCommentPrefix=false' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'status -v' '
+	(cat expect && git diff --cached) >expect-with-v &&
+	git status -v >output &&
+	test_i18ncmp expect-with-v output
+'
+
 test_expect_success 'setup fake editor' '
 	cat >.git/editor <<-\EOF &&
 	#! /bin/sh
@@ -201,7 +207,7 @@ test_expect_success 'status -s' '
 test_expect_success 'status with gitignore' '
 	{
 		echo ".gitignore" &&
-		echo "expect" &&
+		echo "expect*" &&
 		echo "output" &&
 		echo "untracked"
 	} >.gitignore &&
@@ -222,6 +228,7 @@ test_expect_success 'status with gitignore' '
 	!! dir1/untracked
 	!! dir2/untracked
 	!! expect
+	!! expect-with-v
 	!! output
 	!! untracked
 	EOF
@@ -253,6 +260,7 @@ Ignored files:
 	dir1/untracked
 	dir2/untracked
 	expect
+	expect-with-v
 	output
 	untracked
 
@@ -264,7 +272,7 @@ EOF
 test_expect_success 'status with gitignore (nothing untracked)' '
 	{
 		echo ".gitignore" &&
-		echo "expect" &&
+		echo "expect*" &&
 		echo "dir2/modified" &&
 		echo "output" &&
 		echo "untracked"
@@ -285,6 +293,7 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 	!! dir2/modified
 	!! dir2/untracked
 	!! expect
+	!! expect-with-v
 	!! output
 	!! untracked
 	EOF
@@ -312,6 +321,7 @@ Ignored files:
 	dir2/modified
 	dir2/untracked
 	expect
+	expect-with-v
 	output
 	untracked
 
-- 
2.3.1.303.g5174db1

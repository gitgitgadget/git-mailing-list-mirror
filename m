From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation+t5708: document and test status -s -b
Date: Tue, 25 May 2010 16:52:03 +0200
Message-ID: <d007399dfec8e1346f6b3ba5d1f34469026fb90f.1274798738.git.git@drmicha.warpmail.net>
References: <4BFBD8A3.8040203@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89+git@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 16:52:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGvUY-00068P-MH
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 16:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758520Ab0EYOwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 10:52:21 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50187 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756228Ab0EYOwU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 10:52:20 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7FB7FF7C5A;
	Tue, 25 May 2010 10:52:19 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 25 May 2010 10:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ZVQljt0+SsfT0NqWRbdoIDhK/Zs=; b=E86BEqj5exVozFMefRhOqRH32LsUo/sHnnDvjdmqYMd3JI182p6oc5Gtr7sNwYguuZ5nBHYZR1+Gj3lT1S6q5bSPmLw+pyUedOuS8Kxs9QzRNOqBcqWtXqOGxsZ8l/ioRNC9WB7dJrDfEtdg4db6XGEHj8XndyyWa987vUjnUUU=
X-Sasl-enc: 8ldeEHl37GLGad/9kBYslV98mj++h/JMTqMryTAaWwO1 1274799138
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B71414B3C01;
	Tue, 25 May 2010 10:52:18 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.342.g1c280
In-Reply-To: <4BFBD8A3.8040203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147713>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Since I liked -b so much...
Cheers!

 Documentation/git-status.txt |   12 +++++++++-
 t/t7508-status.sh            |   47 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 2d4bbfc..beb1c8a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -27,6 +27,10 @@ OPTIONS
 --short::
 	Give the output in the short-format.
 
+-b::
+--branch::
+	Show the branch and tracking info even in short-format.
+
 --porcelain::
 	Give the output in a stable, easy-to-parse format for scripts.
 	Currently this is identical to --short output, but is guaranteed
@@ -73,7 +77,7 @@ In short-format, the status of each path is shown as
 where `PATH1` is the path in the `HEAD`, and ` -> PATH2` part is
 shown only when `PATH1` corresponds to a different path in the
 index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
-status code.
+status code. 
 
 The fields (including the `->`) are separated from each other by a
 single space. If a filename contains whitespace or other nonprintable
@@ -120,6 +124,10 @@ Ignored files are not listed.
     ?           ?    untracked
     -------------------------------------------------
 
+If -b is used the short-format status is preceded by a line
+
+## branchname tracking info
+
 There is an alternate -z format recommended for machine parsing.  In
 that format, the status field is the same, but some other things
 change.  First, the '->' is omitted from rename entries and the field
@@ -128,7 +136,7 @@ order is reversed (e.g 'from -> to' becomes 'to from'). Second, a NUL
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
-backslash-escaping is performed.
+backslash-escaping is performed. Fourth, there is no branch line.
 
 CONFIGURATION
 -------------
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 008d571..9e08107 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -107,13 +107,32 @@ A  dir2/added
 ?? untracked
 EOF
 
-test_expect_success 'status -s (2)' '
+test_expect_success 'status -s' '
 
 	git status -s >output &&
 	test_cmp expect output
 
 '
 
+cat >expect <<\EOF
+## master
+ M dir1/modified
+A  dir2/added
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? expect
+?? output
+?? untracked
+EOF
+
+test_expect_success 'status -s -b' '
+
+	git status -s -b >output &&
+	test_cmp expect output
+
+'
+
 cat >expect <<EOF
 # On branch master
 # Changes to be committed:
@@ -437,6 +456,25 @@ test_expect_success 'status -s with color.status' '
 '
 
 cat >expect <<\EOF
+## <GREEN>master<RESET>
+ <RED>M<RESET> dir1/modified
+<GREEN>A<RESET>  dir2/added
+<BLUE>??<RESET> dir1/untracked
+<BLUE>??<RESET> dir2/modified
+<BLUE>??<RESET> dir2/untracked
+<BLUE>??<RESET> expect
+<BLUE>??<RESET> output
+<BLUE>??<RESET> untracked
+EOF
+
+test_expect_success 'status -s -b with color.status' '
+
+	git status -s -b | test_decode_color >output &&
+	test_cmp expect output
+
+'
+
+cat >expect <<\EOF
  M dir1/modified
 A  dir2/added
 ?? dir1/untracked
@@ -469,6 +507,13 @@ test_expect_success 'status --porcelain ignores color.status' '
 git config --unset color.status
 git config --unset color.ui
 
+test_expect_success 'status --porcelain ignores -b' '
+
+	git status --porcelain -b >output &&
+	test_cmp expect output
+
+'
+
 cat >expect <<\EOF
 # On branch master
 # Changes to be committed:
-- 
1.7.1.342.g1c280

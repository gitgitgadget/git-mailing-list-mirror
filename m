From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v3 4/7] t4052: Adjust --graph --stat output for prefixes
Date: Mon, 16 Apr 2012 03:44:52 -0700
Message-ID: <1334573095-32286-5-git-send-email-lucian.poston@gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 12:47:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjT5-0000d7-9E
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab2DPKr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:47:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46920 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593Ab2DPKrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:47:24 -0400
Received: by pbcun15 with SMTP id un15so6192020pbc.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FVBYUC1lFpXw/Jz0imr277DhIpvadIiXCvTPD/ryljw=;
        b=o8i1Wv3tHE7c/5HsZpd4K7HvfJfrA8N/uB1RDCxmPML2xE3DBqfLuWshSeMQORhLJq
         45z0AT8cAeXZkoLsfAAeLvtQr8hvUruFavoRP03+QZSwbFaGyNBxz7BWq/QzW8q3HwS6
         ng6tVMaL8N0qz3rXnD3hybRdomFpRh+BiUfLT9UyewcJ2x+JvXxMG8659xOMwGXazHz3
         v1Z/SIkyZ8BVo4BhYGjzzuAvZ/tl/zPDnzoQAnm40VZa7munio6I0VirvS3xZIKDy9uH
         KBlmNIwNE92uGPLoVWzuvFNkZgBMCmjNeZBegm7ACj1qQ3PcDliCq5w/SxaER0tLPn7g
         xd7g==
Received: by 10.68.229.170 with SMTP id sr10mr22879779pbc.62.1334573244289;
        Mon, 16 Apr 2012 03:47:24 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id oh2sm10793051pbb.45.2012.04.16.03.47.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 03:47:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195615>

Adjust tests to verify that the commit history graph tree is taken into
consideration when the diff stat output width is calculated.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 t/t4052-stat-output.sh |   34 +++++++++++++++++++++++++---------
 1 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index da14984..d748e5e 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -89,7 +89,7 @@ cat >expect200 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 cat >expect200-graph <<'EOF'
-|  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+|  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -117,7 +117,7 @@ cat >expect40 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
 cat >expect40-graph <<'EOF'
-|  abcd | 1000 ++++++++++++++++++++++++++
+|  abcd | 1000 ++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -127,12 +127,6 @@ do
 		test_cmp "$expect" actual
 	'
 
-	test_expect_success "$cmd $verb statGraphWidth config" '
-		git -c diff.statGraphWidth=26 $cmd $args >output
-		grep " | " output >actual &&
-		test_cmp "$expect" actual
-	'
-
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
@@ -140,6 +134,28 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+respects expect40 diff HEAD^ HEAD --stat
+respects expect40 show --stat
+respects expect40 log -1 --stat
+EOF
+
+cat >expect40 <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++
+EOF
+cat >expect40-graph <<'EOF'
+|  abcd | 1000 ++++++++++++++++++++++++++
+EOF
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb statGraphWidth config" '
+		git -c diff.statGraphWidth=26 $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+
+	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb statGraphWidth config" '
 		git -c diff.statGraphWidth=26 $cmd $args --graph >output
@@ -244,7 +260,7 @@ cat >expect200 <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 cat >expect200-graph <<'EOF'
-|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
-- 
1.7.3.4

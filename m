From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 2/3] doc/fast-import: document feature import-marks-if-exists
Date: Wed, 13 Jul 2011 23:10:54 +0600
Message-ID: <1310577055-6347-2-git-send-email-divanorama@gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 19:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2xK-0005uQ-BB
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 19:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab1GMRKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 13:10:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60819 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab1GMRKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 13:10:33 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2176367eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Pewfh9beuOriaJ//2b0+iMKxvlpGo2MKQ0yUq9YLvmA=;
        b=KMznCD+DxAu0Je9woAnctznQ3g46friGdXi0MXUyuRujHGrMZFHVYPN4zHKG0UlH9N
         Jg4hSap4nQiZxB3U8zdubkD2O0ImPPqNkyZhrQ7M/zSE20Wii4RhjLiJ6JsJu7eOEBdO
         hV2FAGPVxBvaSonzSaQikkwuTKme4BeQ3c57s=
Received: by 10.14.27.138 with SMTP id e10mr429365eea.106.1310577032369;
        Wed, 13 Jul 2011 10:10:32 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id z14sm9432354eef.13.2011.07.13.10.10.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 10:10:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177060>

fast-import command-line option --import-marks-if-exists was introduced
in commit dded4f1 (fast-import: Introduce --import-marks-if-exists, 2011-01-15)

--import-marks option can be set via a "feature" command in a fast-import
stream and --import-marks-if-exists had support for such specification
from the very beginning too due to some shared codebase. Though the
documentation for this feature wasn't written in dded4f1.

Add the documentation for "feature import-marks-if-exists=<file>". Also add
a minimalistic test for it.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
Reworded a bit, united import-marks* descriptions. One more case to test:
--import-marks-if-exists= overrides feature import-marks=. And "fixed" the
test, I left the --import-marks accidentally, though it was a fine test too.
Also not feeling like adding a whole ton of coverage tests yet.

 Documentation/git-fast-import.txt |   10 +++++++---
 t/t9300-fast-import.sh            |   15 +++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 3f5b912..3a5aa55 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1000,10 +1000,14 @@ force::
 	(see OPTIONS, above).
 
 import-marks::
+import-marks-if-exists::
 	Like --import-marks except in two respects: first, only one
-	"feature import-marks" command is allowed per stream;
-	second, an --import-marks= command-line option overrides
-	any "feature import-marks" command in the stream.
+	"feature import-marks" or "feature import-marks-if-exists"
+	command is allowed per stream; second, an --import-marks=
+	or --import-marks-if-exists command-line option overrides
+	any of these "feature" commands in the stream; third,
+	"feature import-marks-if-exists" like a corresponding
+	command-line option silently skips a nonexistent file.
 
 cat-blob::
 ls::
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2a53640..9af1a78 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1882,6 +1882,21 @@ test_expect_success 'R: --import-marks-if-exists' '
 	test_cmp expect io.marks
 '
 
+test_expect_success 'R: feature import-marks-if-exists' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	echo ":1 $blob" >expect &&
+	git fast-import --export-marks=io.marks <<-\EOF &&
+	feature import-marks-if-exists=io.marks
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks
+'
+
 cat >input << EOF
 feature import-marks=marks.out
 feature export-marks=marks.new
-- 
1.7.3.4

From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 11/11] t6300: add tests for "-local" date formats
Date: Thu,  3 Sep 2015 22:49:01 +0100
Message-ID: <5559d4bca517cb1be881e2a2e6ff7aefbd0fee64.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcQ8-0001yb-BH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757822AbbICVvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:51:45 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49197 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757808AbbICVvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:51:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id F3986CDA61A;
	Thu,  3 Sep 2015 22:51:43 +0100 (BST)
X-Quarantine-ID: <S-8iENpJmBBX>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S-8iENpJmBBX; Thu,  3 Sep 2015 22:51:43 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 9CB91CDA626;
	Thu,  3 Sep 2015 22:51:29 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277272>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Changes since v2:
- "relative-local" and "raw-local" are now allowed

 t/t6300-for-each-ref.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 899251e..03873b0 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -180,6 +180,10 @@ test_expect_success 'Check format "default" formatted date fields output' '
 		"Tue Jul 4 01:18:45 2006 +0200"
 '
 
+test_expect_success 'Check format "default-local" date fields output' '
+	test_date default-local "Mon Jul 3 23:18:43 2006" "Mon Jul 3 23:18:44 2006" "Mon Jul 3 23:18:45 2006"
+'
+
 # Don't know how to do relative check because I can't know when this script
 # is going to be run and can't fake the current time to git, and hence can't
 # provide expected output.  Instead, I'll just make sure that "relative"
@@ -190,10 +194,22 @@ test_expect_success 'Check format "relative" date fields output' '
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
 '
 
+# We just check that this is the same as "relative" for now.
+test_expect_success 'Check format "relative-local" date fields output' '
+	test_date relative-local \
+		"$(git for-each-ref --format="%(committerdate:relative)" refs/heads)" \
+		"$(git for-each-ref --format="%(authordate:relative)" refs/heads)" \
+		"$(git for-each-ref --format="%(taggerdate:relative)" refs/tags)"
+'
+
 test_expect_success 'Check format "short" date fields output' '
 	test_date short 2006-07-04 2006-07-04 2006-07-04
 '
 
+test_expect_success 'Check format "short-local" date fields output' '
+	test_date short-local 2006-07-03 2006-07-03 2006-07-03
+'
+
 test_expect_success 'Check format "local" date fields output' '
 	test_date local \
 		"Mon Jul 3 23:18:43 2006" \
@@ -208,6 +224,10 @@ test_expect_success 'Check format "iso8601" date fields output' '
 		"2006-07-04 01:18:45 +0200"
 '
 
+test_expect_success 'Check format "iso8601-local" date fields output' '
+	test_date iso8601-local "2006-07-03 23:18:43 +0000" "2006-07-03 23:18:44 +0000" "2006-07-03 23:18:45 +0000"
+'
+
 test_expect_success 'Check format "rfc2822" date fields output' '
 	test_date rfc2822 \
 		"Tue, 4 Jul 2006 01:18:43 +0200" \
@@ -215,10 +235,18 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 		"Tue, 4 Jul 2006 01:18:45 +0200"
 '
 
+test_expect_success 'Check format "rfc2822-local" date fields output' '
+	test_date rfc2822-local "Mon, 3 Jul 2006 23:18:43 +0000" "Mon, 3 Jul 2006 23:18:44 +0000" "Mon, 3 Jul 2006 23:18:45 +0000"
+'
+
 test_expect_success 'Check format "raw" date fields output' '
 	test_date raw "1151968723 +0200" "1151968724 +0200" "1151968725 +0200"
 '
 
+test_expect_success 'Check format "raw-local" date fields output' '
+	test_date raw-local "1151968723 +0000" "1151968724 +0000" "1151968725 +0000"
+'
+
 test_expect_success 'Check format of strftime date fields' '
 	echo "my date is 2006-07-04" >expected &&
 	git for-each-ref \
@@ -227,6 +255,14 @@ test_expect_success 'Check format of strftime date fields' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Check format of strftime-local date fields' '
+	echo "my date is 2006-07-03" >expected &&
+	git for-each-ref \
+	  --format="%(authordate:format-local:my date is %Y-%m-%d)" \
+	  refs/heads >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'exercise strftime with odd fields' '
 	echo >expected &&
 	git for-each-ref --format="%(authordate:format:)" refs/heads >actual &&
-- 
2.5.0.466.g9af26fa

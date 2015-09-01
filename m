From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 6/6] t6300: add tests for "-local" date formats
Date: Tue,  1 Sep 2015 22:55:44 +0100
Message-ID: <2663f49187d2e7617a21c6e22e93e56a879fff10.1441144343.git.john@keeping.me.uk>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 23:57:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtYP-0006Zo-6i
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 23:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbbIAV5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 17:57:17 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48235 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbIAV5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 17:57:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9AF89CDA5CD;
	Tue,  1 Sep 2015 22:57:16 +0100 (BST)
X-Quarantine-ID: <FJYlu-ZFA6cS>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FJYlu-ZFA6cS; Tue,  1 Sep 2015 22:57:15 +0100 (BST)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1F5DFCDA56C;
	Tue,  1 Sep 2015 22:57:03 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
In-Reply-To: <cover.1441144343.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277049>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t6300-for-each-ref.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2e76ca9..c3aee70 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -170,6 +170,10 @@ test_expect_success 'Check format "default" formatted date fields output' '
 	test_date default "Tue Jul 4 01:18:43 2006 +0200" "Tue Jul 4 01:18:44 2006 +0200" "Tue Jul 4 01:18:45 2006 +0200"
 '
 
+test_expect_success 'Check format "default-local" date fields output' '
+	test_date default-local "Mon Jul 3 23:18:43 2006" "Mon Jul 3 23:18:44 2006" "Mon Jul 3 23:18:45 2006"
+'
+
 # Don't know how to do relative check because I can't know when this script
 # is going to be run and can't fake the current time to git, and hence can't
 # provide expected output.  Instead, I'll just make sure that "relative"
@@ -180,10 +184,18 @@ test_expect_success 'Check format "relative" date fields output' '
 	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual
 '
 
+test_expect_success 'Format "relative-local" is not allowed' '
+	test_must_fail git for-each-ref --format="%(authordate:relative-local)" refs/heads
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
 	test_date local "Mon Jul 3 23:18:43 2006" "Mon Jul 3 23:18:44 2006" "Mon Jul 3 23:18:45 2006"
 '
@@ -192,14 +204,26 @@ test_expect_success 'Check format "iso8601" date fields output' '
 	test_date iso8601 "2006-07-04 01:18:43 +0200" "2006-07-04 01:18:44 +0200" "2006-07-04 01:18:45 +0200"
 '
 
+test_expect_success 'Check format "iso8601-local" date fields output' '
+	test_date iso8601-local "2006-07-03 23:18:43 +0000" "2006-07-03 23:18:44 +0000" "2006-07-03 23:18:45 +0000"
+'
+
 test_expect_success 'Check format "rfc2822" date fields output' '
 	test_date rfc2822 "Tue, 4 Jul 2006 01:18:43 +0200" "Tue, 4 Jul 2006 01:18:44 +0200" "Tue, 4 Jul 2006 01:18:45 +0200"
 '
 
+test_expect_success 'Check format "rfc2822-local" date fields output' '
+	test_date rfc2822-local "Mon, 3 Jul 2006 23:18:43 +0000" "Mon, 3 Jul 2006 23:18:44 +0000" "Mon, 3 Jul 2006 23:18:45 +0000"
+'
+
 test_expect_success 'Check format "raw" date fields output' '
 	test_date raw "1151968723 +0200" "1151968724 +0200" "1151968725 +0200"
 '
 
+test_expect_success 'Format "raw-local" is not allowed' '
+	test_must_fail git for-each-ref --format="%(authordate:raw-local)" refs/heads
+'
+
 test_expect_success 'Check format of strftime date fields' '
 	echo "my date is 2006-07-04" >expected &&
 	git for-each-ref \
@@ -208,6 +232,14 @@ test_expect_success 'Check format of strftime date fields' '
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

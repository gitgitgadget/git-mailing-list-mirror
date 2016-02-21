From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 17:32:21 +0000
Message-ID: <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
References: <cover.1456075680.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 18:33:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXXsa-0004cK-TR
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbcBURdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:33:04 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:45580 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbcBURdC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:33:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2B32CCDA5D6;
	Sun, 21 Feb 2016 17:33:02 +0000 (GMT)
X-Quarantine-ID: <NqLbwBIJr4Nv>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NqLbwBIJr4Nv; Sun, 21 Feb 2016 17:33:01 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D8BC6CDA2D4;
	Sun, 21 Feb 2016 17:32:47 +0000 (GMT)
X-Mailer: git-send-email 2.7.1.503.g3cfa3ac
In-Reply-To: <cover.1456075680.git.john@keeping.me.uk>
In-Reply-To: <cover.1456075680.git.john@keeping.me.uk>
References: <20160219193310.GA1299@sigill.intra.peff.net> <cover.1456075680.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286805>

GNU grep 2.23 detects the input used in this test as binary data so it
does not work for extracting lines from a file.  We could add the "-a"
option to force grep to treat the input as text, but not all
implementations support that.  Instead, use sed to extract the desired
lines since it will always treat its input as text.

While touching these lines, modernize the test style to avoid hiding the
exit status of "git blame" and remove a space following a redirection
operator.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t8005-blame-i18n.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 847d098..0a86c72 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -35,8 +35,8 @@ EOF
 
 test_expect_success !MINGW \
 	'blame respects i18n.commitencoding' '
-	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
+	git blame --incremental file >output &&
+	sed -ne "/^\(author\|summary\) /p" output >actual &&
 	test_cmp actual expected
 '
 
@@ -52,8 +52,8 @@ EOF
 test_expect_success !MINGW \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding eucJP &&
-	git blame --incremental file | \
-		egrep "^(author|summary) " > actual &&
+	git blame --incremental file >output &&
+	sed -ne "/^\(author\|summary\) /p" output >actual &&
 	test_cmp actual expected
 '
 
@@ -68,8 +68,8 @@ EOF
 
 test_expect_success !MINGW \
 	'blame respects --encoding=UTF-8' '
-	git blame --incremental --encoding=UTF-8 file | \
-		egrep "^(author|summary) " > actual &&
+	git blame --incremental --encoding=UTF-8 file >output &&
+	sed -ne "/^\(author\|summary\) /p" output >actual &&
 	test_cmp actual expected
 '
 
@@ -84,8 +84,8 @@ EOF
 
 test_expect_success !MINGW \
 	'blame respects --encoding=none' '
-	git blame --incremental --encoding=none file | \
-		egrep "^(author|summary) " > actual &&
+	git blame --incremental --encoding=none file >output &&
+	sed -ne "/^\(author\|summary\) /p" output >actual &&
 	test_cmp actual expected
 '
 
-- 
2.7.1.503.g3cfa3ac

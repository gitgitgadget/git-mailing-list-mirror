From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/3] Use shorter error messages for whitespace problems
Date: Fri, 14 Dec 2007 12:23:43 +0100
Message-ID: <1197631424-52586-3-git-send-email-win@wincent.com>
References: <1197631424-52586-1-git-send-email-win@wincent.com>
 <1197631424-52586-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:25:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38fc-0002y8-EV
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbXLNLZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 06:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbXLNLZH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 06:25:07 -0500
Received: from wincent.com ([72.3.236.74]:50232 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765581AbXLNLZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 06:25:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBEBNkhY018244;
	Fri, 14 Dec 2007 05:23:49 -0600
X-Mailer: git-send-email 1.5.4.rc0.1099.g76fa0-dirty
In-Reply-To: <1197631424-52586-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68297>

The initial version of the whitespace_error_string() function took the
messages from builtin-apply.c rather than the shorter messages from
diff.c.

This commit addresses Junio's concern that these messages might be too
long (now that we can emit multiple warnings per line).

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 t/t4015-diff-whitespace.sh |    2 +-
 ws.c                       |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 05ef78b..9bff8f5 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -121,7 +121,7 @@ test_expect_success 'check mixed spaces and tabs in indent' '
 
 	# This is indented with SP HT SP.
 	echo " 	 foo();" > x &&
-	git diff --check | grep "Space in indent is followed by a tab"
+	git diff --check | grep "space before tab in indent"
 
 '
 
diff --git a/ws.c b/ws.c
index d7d1522..46cbdd6 100644
--- a/ws.c
+++ b/ws.c
@@ -101,16 +101,16 @@ char *whitespace_error_string(unsigned ws)
 	struct strbuf err;
 	strbuf_init(&err, 0);
 	if (ws & WS_TRAILING_SPACE)
-		strbuf_addstr(&err, "Adds trailing whitespace");
+		strbuf_addstr(&err, "trailing whitespace");
 	if (ws & WS_SPACE_BEFORE_TAB) {
 		if (err.len)
 			strbuf_addstr(&err, ", ");
-		strbuf_addstr(&err, "Space in indent is followed by a tab");
+		strbuf_addstr(&err, "space before tab in indent");
 	}
 	if (ws & WS_INDENT_WITH_NON_TAB) {
 		if (err.len)
 			strbuf_addstr(&err, ", ");
-		strbuf_addstr(&err, "Indent more than 8 places with spaces");
+		strbuf_addstr(&err, "indent with spaces");
 	}
 	return strbuf_detach(&err, NULL);
 }
-- 
1.5.4.rc0.1099.g76fa0-dirty

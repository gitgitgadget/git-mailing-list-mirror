From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 2/5] diff.c: Use show variable name in fn_out_diff_words_aux
Date: Sat,  3 May 2008 19:57:05 +0800
Message-ID: <1209815828-6548-3-git-send-email-pkufranky@gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
 <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 13:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsGNY-0004et-DK
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 13:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754AbYECL5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 07:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbYECL5R
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 07:57:17 -0400
Received: from mail.qikoo.org ([60.28.205.235]:41301 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753446AbYECL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 07:57:16 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9C00F470AF; Sat,  3 May 2008 19:57:08 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209815828-6548-2-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81067>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 diff.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index acef138..b5f7141 100644
--- a/diff.c
+++ b/diff.c
@@ -408,28 +408,32 @@ static void print_word(FILE *file, struct diff_words_buffer *buffer, int len, in
 
 static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 {
-	struct diff_words_data *diff_words = priv;
+	struct diff_words_data *diff_words;
+	struct diff_words_buffer *dm, *dp;
+	FILE *df;
 
-	if (diff_words->minus.suppressed_newline) {
+	diff_words = priv;
+	dm = &(diff_words->minus);
+	dp = &(diff_words->plus);
+	df = diff_words->file;
+
+	if (dm->suppressed_newline) {
 		if (line[0] != '+')
-			putc('\n', diff_words->file);
-		diff_words->minus.suppressed_newline = 0;
+			putc('\n', df);
+		dm->suppressed_newline = 0;
 	}
 
 	len--;
 	switch (line[0]) {
 		case '-':
-			print_word(diff_words->file,
-				   &diff_words->minus, len, DIFF_FILE_OLD, 1);
+			print_word(df, dm, len, DIFF_FILE_OLD, 1);
 			break;
 		case '+':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_FILE_NEW, 0);
+			print_word(df, dp, len, DIFF_FILE_NEW, 0);
 			break;
 		case ' ':
-			print_word(diff_words->file,
-				   &diff_words->plus, len, DIFF_PLAIN, 0);
-			diff_words->minus.current += len;
+			print_word(df, dp, len, DIFF_PLAIN, 0);
+			dm->current += len;
 			break;
 	}
 }
-- 
1.5.5.1.121.g26b3

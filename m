From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 12/12] trailer: add blank line before the trailers if
 needed
Date: Sun, 06 Apr 2014 19:02:03 +0200
Message-ID: <20140406170204.15116.15100.chriscool@tuxfamily.org>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:44:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEWt-0003Y6-AR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbaDGSoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:44:09 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:46773 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755867AbaDGSoH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:44:07 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id A6E0C36;
	Mon,  7 Apr 2014 20:44:05 +0200 (CEST)
X-git-sha1: 20d5f345c2b5f432fb83a2e2597c4f211ac3fbf0 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140406163214.15116.91484.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245876>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7513-interpret-trailers.sh | 12 +++++++++++-
 trailer.c                     | 26 ++++++++++++++++++--------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 262f7bf..44a7131 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -34,6 +34,7 @@ test_expect_success 'setup' '
 
 test_expect_success 'without config' '
 	sed -e "s/ Z\$/ /" >expected <<-\EOF &&
+
 		ack: Peff
 		Reviewed-by: Z
 		Acked-by: Johan
@@ -44,6 +45,7 @@ test_expect_success 'without config' '
 
 test_expect_success '--trim-empty without config' '
 	cat >expected <<-\EOF &&
+
 		ack: Peff
 		Acked-by: Johan
 	EOF
@@ -55,6 +57,7 @@ test_expect_success '--trim-empty without config' '
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
+
 		Acked-by: Peff
 	EOF
 	git interpret-trailers --trim-empty "ack = Peff" >actual &&
@@ -68,6 +71,7 @@ test_expect_success 'with config setup' '
 test_expect_success 'with config setup and = sign' '
 	git config trailer.ack.key "Acked-by= " &&
 	cat >expected <<-\EOF &&
+
 		Acked-by= Peff
 	EOF
 	git interpret-trailers --trim-empty "ack = Peff" >actual &&
@@ -81,6 +85,7 @@ test_expect_success 'with config setup and = sign' '
 test_expect_success 'with config setup and # sign' '
 	git config trailer.bug.key "Bug #" &&
 	cat >expected <<-\EOF &&
+
 		Bug #42
 	EOF
 	git interpret-trailers --trim-empty "bug = 42" >actual &&
@@ -88,8 +93,10 @@ test_expect_success 'with config setup and # sign' '
 '
 
 test_expect_success 'with commit basic message' '
+	cat basic_message >expected &&
+	echo >>expected &&
 	git interpret-trailers <basic_message >actual &&
-	test_cmp basic_message actual
+	test_cmp expected actual
 '
 
 test_expect_success 'with commit complex message' '
@@ -436,6 +443,7 @@ test_expect_success 'with failing command using $ARG' '
 
 test_expect_success 'with empty tokens' '
 	cat >expected <<-EOF &&
+
 		Signed-off-by: A U Thor <author@example.com>
 	EOF
 	git interpret-trailers ":" ":test" >actual <<-EOF &&
@@ -446,6 +454,7 @@ test_expect_success 'with empty tokens' '
 test_expect_success 'with command but no key' '
 	git config --unset trailer.sign.key &&
 	cat >expected <<-EOF &&
+
 		sign: A U Thor <author@example.com>
 	EOF
 	git interpret-trailers >actual <<-EOF &&
@@ -456,6 +465,7 @@ test_expect_success 'with command but no key' '
 test_expect_success 'with no command and no key' '
 	git config --unset trailer.review.key &&
 	cat >expected <<-EOF &&
+
 		review: Junio
 		sign: A U Thor <author@example.com>
 	EOF
diff --git a/trailer.c b/trailer.c
index 09db2c2..639f657 100644
--- a/trailer.c
+++ b/trailer.c
@@ -618,12 +618,14 @@ static struct strbuf **read_stdin(void)
 }
 
 /*
- * Return the the (0 based) index of the first trailer line
+ * Return the (0 based) index of the first trailer line
  * or the line count if there are no trailers.
+ * The has_blank_line parameter tells if there is a blank
+ * line before the trailers.
  */
-static int find_trailer_start(struct strbuf **lines)
+static int find_trailer_start(struct strbuf **lines, int *has_blank_line)
 {
-	int start, empty = 1, count = 0;
+	int start, only_spaces = 1, count = 0;
 
 	/* Get the line count */
 	while (lines[count])
@@ -635,32 +637,40 @@ static int find_trailer_start(struct strbuf **lines)
 	 */
 	for (start = count - 1; start >= 0; start--) {
 		if (contains_only_spaces(lines[start]->buf)) {
-			if (empty)
+			if (only_spaces)
 				continue;
+			*has_blank_line = 1;
 			return start + 1;
 		}
 		if (strchr(lines[start]->buf, ':')) {
-			if (empty)
-				empty = 0;
+			if (only_spaces)
+				only_spaces = 0;
 			continue;
 		}
+		*has_blank_line = start == count - 1 ?
+		  0 : contains_only_spaces(lines[start + 1]->buf);
 		return count;
 	}
 
-	return empty ? count : start + 1;
+	*has_blank_line = only_spaces ? count > 0 : 0;
+	return only_spaces ? count : start + 1;
 }
 
 static void process_stdin(struct trailer_item **in_tok_first,
 			  struct trailer_item **in_tok_last)
 {
 	struct strbuf **lines = read_stdin();
-	int start = find_trailer_start(lines);
+	int has_blank_line;
+	int start = find_trailer_start(lines, &has_blank_line);
 	int i;
 
 	/* Print non trailer lines as is */
 	for (i = 0; lines[i] && i < start; i++)
 		printf("%s", lines[i]->buf);
 
+	if (!has_blank_line)
+		printf("\n");
+
 	/* Parse trailer lines */
 	for (i = start; lines[i]; i++) {
 		struct trailer_item *new = create_trailer_item(lines[i]->buf);
-- 
1.9.0.163.g8ca203c

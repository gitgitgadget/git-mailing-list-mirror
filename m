From: Alexander Shishkin <ash@koowaldah.org>
Subject: [PATCH/RFC] pretty.c: add %O format specifier to format_commit_one()
Date: Sat,  1 May 2010 13:56:41 +0300
Message-ID: <1272711401-29005-1-git-send-email-ash@koowaldah.org>
Cc: Alexander Shishkin <ash@koowaldah.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 01 13:03:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8AU1-0001mF-8L
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 13:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0EALDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 07:03:35 -0400
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:57852 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0EALDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 07:03:34 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 May 2010 07:03:34 EDT
Received: from localhost (localhost [127.0.0.1])
	by filtteri5.pp.htv.fi (Postfix) with ESMTP id E69305A6157;
	Sat,  1 May 2010 13:57:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
	with ESMTP id VavMURUIFlwY; Sat,  1 May 2010 13:57:09 +0300 (EEST)
Received: from ukko (cs27003010.pp.htv.fi [89.27.3.10])
	by smtp5.welho.com (Postfix) with ESMTP id 937B45BC002;
	Sat,  1 May 2010 13:57:09 +0300 (EEST)
Received: from ash by ukko with local (Exim 4.69)
	(envelope-from <ash@shisha.kicks-ass.net>)
	id 1O8ANR-0007YQ-Kz; Sat, 01 May 2010 13:56:53 +0300
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146083>

This specifier represents the number of each commit in the output
stream.

Signed-off-by: Alexander Shishkin <ash@koowaldah.org>
---
 Documentation/pretty-formats.txt |    3 ++-
 pretty.c                         |    5 +++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 1686a54..7b0cab1 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -137,7 +137,8 @@ The placeholders are:
 - '%%': a raw '%'
 - '%x00': print a byte from a hex code
 - '%w([<w>[,<i1>[,<i2>]]])': switch line wrapping, like the -w option of
-  linkgit:git-shortlog[1].
+  linkgit:git-shortlog[1]
+- '%O': number of the record in the output.
 
 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
diff --git a/pretty.c b/pretty.c
index 7cb3a2a..3e3d399 100644
--- a/pretty.c
+++ b/pretty.c
@@ -11,6 +11,7 @@
 #include "reflog-walk.h"
 
 static char *user_format;
+static int record_number;
 
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
 {
@@ -639,6 +640,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
+	case 'O':
+		strbuf_addf(sb, "%d", record_number);
+		return 1;
 	case 'C':
 		if (placeholder[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
@@ -899,6 +903,7 @@ void format_commit_message(const struct commit *commit,
 	context.wrap_start = sb->len;
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
+	record_number++;
 }
 
 static void pp_header(enum cmit_fmt fmt,
-- 
1.7.0.4

From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2' 12/16] diff: use tempfile module
Date: Wed, 12 Aug 2015 19:12:01 +0200
Message-ID: <2c01cbf0b64b95ddaca54e7f2f9df7bab8bab6cd.1439399089.git.mhagger@alum.mit.edu>
References: <xmqqy4hglar6.fsf@gitster.dls.corp.google.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 19:12:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPZZi-000091-CH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 19:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbbHLRMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 13:12:21 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49617 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964784AbbHLRMU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 13:12:20 -0400
X-AuditID: 12074413-f79bd6d000007ac2-3a-55cb7e6c0fcb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id A7.D6.31426.C6E7BC55; Wed, 12 Aug 2015 13:12:12 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D5A.dip0.t-ipconnect.de [79.201.125.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7CHC9ie019972
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 12 Aug 2015 13:12:11 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <xmqqy4hglar6.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqJtTdzrU4NBRZYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGRdbn7IU
	PJSuOHvqF1MD40GxLkZODgkBE4nlLx6yQ9hiEhfurWfrYuTiEBK4zChxduJBZgjnBJPErrk7
	warYBHQlFvU0M4HYIgJqEhPbDrGA2MwC6RInFrSD2cJAU6/dbwarZxFQlTh1tp8VxOYViJJY
	vb4JqJcDaJucxIIL6SBhTgFriVuX7oGNFBKwklh4tJdpAiPvAkaGVYxyiTmlubq5iZk5xanJ
	usXJiXl5qUW65nq5mSV6qSmlmxgh4SO8g3HXSblDjAIcjEo8vDf6ToUKsSaWFVfmHmKU5GBS
	EuUNrDwdKsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE90cFUI43JbGyKrUoHyYlzcGiJM6rtkTd
	T0ggPbEkNTs1tSC1CCYrw8GhJMH7vgaoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQk
	Ix4UGfHFwNgASfEA7V0L0s5bXJCYCxSFaD3FqCglzstYC5QQAElklObBjYUlhVeM4kBfCvNm
	g1TxABMKXPcroMFMQIPT5U6BDC5JREhJNTDqTfq1a46orMpVm13Ptmes3abwOtKbf+Ypr99r
	DdiE7FXe/SuZ33f800+ZTZ/qV6jWJoRstPzruHz7Mdf01D/lB2Y352s/XVHd4m9RcUPweef0
	/f231ivv3Pt7s0DX7vnsR5l/rfqv7bFj8sTe7vbJnzhLZ4QGz5yXLnLlRsCDrd+6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275785>

Also add some code comments explaining how the fields in "struct
diff_tempfile" are used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This is a replacement for tempfile patch v2 12/16 that includes some
extra code comments. It is also available from my GitHub repo [1] on
branch "tempfile".

[1] https://github.com/mhagger/git

 diff.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index 7500c55..528d25c 100644
--- a/diff.c
+++ b/diff.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -308,11 +309,26 @@ static const char *external_diff(void)
 	return external_diff_cmd;
 }
 
+/*
+ * Keep track of files used for diffing. Sometimes such an entry
+ * refers to a temporary file, sometimes to an existing file, and
+ * sometimes to "/dev/null".
+ */
 static struct diff_tempfile {
-	const char *name; /* filename external diff should read from */
+	/*
+	 * filename external diff should read from, or NULL if this
+	 * entry is currently not in use:
+	 */
+	const char *name;
+
 	char hex[41];
 	char mode[10];
-	char tmp_path[PATH_MAX];
+
+	/*
+	 * If this diff_tempfile instance refers to a temporary file,
+	 * this tempfile object is used to manage its lifetime.
+	 */
+	struct tempfile tempfile;
 } diff_temp[2];
 
 typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
@@ -564,25 +580,16 @@ static struct diff_tempfile *claim_diff_tempfile(void) {
 	die("BUG: diff is failing to clean up its tempfiles");
 }
 
-static int remove_tempfile_installed;
-
 static void remove_tempfile(void)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
-		if (diff_temp[i].name == diff_temp[i].tmp_path)
-			unlink_or_warn(diff_temp[i].name);
+		if (is_tempfile_active(&diff_temp[i].tempfile))
+			delete_tempfile(&diff_temp[i].tempfile);
 		diff_temp[i].name = NULL;
 	}
 }
 
-static void remove_tempfile_on_signal(int signo)
-{
-	remove_tempfile();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 static void print_line_count(FILE *file, int count)
 {
 	switch (count) {
@@ -2817,8 +2824,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	strbuf_addstr(&template, "XXXXXX_");
 	strbuf_addstr(&template, base);
 
-	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
-			strlen(base) + 1);
+	fd = mks_tempfile_ts(&temp->tempfile, template.buf, strlen(base) + 1);
 	if (fd < 0)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
@@ -2828,8 +2834,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	}
 	if (write_in_full(fd, blob, size) != size)
 		die_errno("unable to write temp-file");
-	close(fd);
-	temp->name = temp->tmp_path;
+	close_tempfile(&temp->tempfile);
+	temp->name = get_tempfile_path(&temp->tempfile);
 	strcpy(temp->hex, sha1_to_hex(sha1));
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
@@ -2854,12 +2860,6 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		return temp;
 	}
 
-	if (!remove_tempfile_installed) {
-		atexit(remove_tempfile);
-		sigchain_push_common(remove_tempfile_on_signal);
-		remove_tempfile_installed = 1;
-	}
-
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->sha1_valid ||
 	     reuse_worktree_file(name, one->sha1, 1))) {
-- 
2.5.0

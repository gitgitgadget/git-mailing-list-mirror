From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/13] delete_refs(): new function for the refs API
Date: Mon,  8 Jun 2015 13:45:38 +0200
Message-ID: <e6897bee0aba656cf9d287c4c8eae5a1ed52e4b3.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVd-0005Ts-1U
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbbFHLqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58253 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752414AbbFHLqC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:02 -0400
X-AuditID: 12074413-f79386d000000d23-2d-55758075dab6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D5.32.03363.57085755; Mon,  8 Jun 2015 07:45:57 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop1017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:56 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqFvaUBpqcOGahUXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4MybdvclWcEm04sqRJrYGxoWCXYycHBICJhJHT39kgrDFJC7cW8/WxcjFISRwmVFi668m
	KOcEk8T7eUdZQarYBHQlFvU0g3WICKhJTGw7xAJSxCzQwShxYfk2dpCEsICzxLV7r8AaWARU
	JSbensUCYvMKREk0TN3HCLFOTuL88Z/MIDangIXE3f8X2EBsIQFziY/b2hknMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESVMI7GHedlDvEKMDBqMTDe2BRSagQ
	a2JZcWXuIUZJDiYlUd6ustJQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8TBZAOd6UxMqq1KJ8
	mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/HOqBGwaLU9NSKtMycEoQ0EwcnyHAu
	KZHi1LyU1KLE0pKMeFB0xBcD4wMkxQO0V6UeZG9xQWIuUBSi9RSjopQ472OQuQIgiYzSPLix
	sFTxilEc6EthXl2Qdh5gmoHrfgU0mAlo8PevxSCDSxIRUlINjCEnA6y/KStHJ97PmRdatudw
	ILvWg3VH1p7J/FuSe/Fk/7e6fbuv19xNFQoQTv9mvKTa1M1HfKb3pJBFBT9eNzDdiNrg/3Cr
	//2HGU+mbdzYNzNb8NrfCc3r7HLmLp5n/7z4RFXNLZG/c5i9b9aKRi/ae1Hb3T3w 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271021>

Move the function remove_branches() from builtin/remote.c to refs.c,
rename it to delete_refs(), and make it public.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 21 +--------------------
 refs.c           | 19 +++++++++++++++++++
 refs.h           |  7 +++++++
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 53b8e13..c8dc724 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -746,25 +746,6 @@ static int mv(int argc, const char **argv)
 	return 0;
 }
 
-static int remove_branches(struct string_list *branches)
-{
-	struct strbuf err = STRBUF_INIT;
-	int i, result = 0;
-
-	if (repack_without_refs(branches, &err))
-		result |= error("%s", err.buf);
-	strbuf_release(&err);
-
-	for (i = 0; i < branches->nr; i++) {
-		const char *refname = branches->items[i].string;
-
-		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
-	}
-
-	return result;
-}
-
 static int rm(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -821,7 +802,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = remove_branches(&branches);
+		result = delete_refs(&branches);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
diff --git a/refs.c b/refs.c
index f9d87b6..c413282 100644
--- a/refs.c
+++ b/refs.c
@@ -2814,6 +2814,25 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
+int delete_refs(struct string_list *refnames)
+{
+	struct strbuf err = STRBUF_INIT;
+	int i, result = 0;
+
+	if (repack_without_refs(refnames, &err))
+		result |= error("%s", err.buf);
+	strbuf_release(&err);
+
+	for (i = 0; i < refnames->nr; i++) {
+		const char *refname = refnames->items[i].string;
+
+		if (delete_ref(refname, NULL, 0))
+			result |= error(_("Could not remove branch %s"), refname);
+	}
+
+	return result;
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
diff --git a/refs.h b/refs.h
index 8785bca..9b75b9f 100644
--- a/refs.h
+++ b/refs.h
@@ -211,6 +211,13 @@ extern int reflog_exists(const char *refname);
 extern int delete_ref(const char *refname, const unsigned char *old_sha1,
 		      unsigned int flags);
 
+/*
+ * Delete the specified references. If there are any problems, emit
+ * errors but attempt to keep going (i.e., the deletes are not done in
+ * an all-or-nothing transaction).
+ */
+extern int delete_refs(struct string_list *refnames);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.4

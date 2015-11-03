From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 19/25] refs: move copy_msg to the common code
Date: Tue,  3 Nov 2015 08:40:03 +0100
Message-ID: <226c66afe0bc7eb946c0f3075ab8b1062f074fc3.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWJk-0005R9-V3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbKCHrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:41 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61769 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751500AbbKCHrk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:40 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:47:40 EST
X-AuditID: 1207440e-f79516d0000012b3-ee-563864f6b6d6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D7.37.04787.6F468365; Tue,  3 Nov 2015 02:40:38 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdG016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:37 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqPstxSLM4MpTeYv5m04wWnRd6Way
	aOi9wmxxe8V8ZgcWj7/vPzB5XLyk7LHg+X12j8+b5AJYorhtkhJLyoIz0/P07RK4M67M3s1e
	8Fu84u7uBuYGxk7hLkZODgkBE4mvf+8zQthiEhfurWfrYuTiEBK4zCjx7PkhKOcYk8Thu71M
	IFVsAroSi3qawWwRATWJiW2HWLoYOTiYBYok7vTrgISFBRwkur4uZwGxWQRUJZ593w9WwisQ
	JbH7tjbELjmJKffbwaZwClhIPLj7hx3EFhIwl9h0bxnbBEbeBYwMqxjlEnNKc3VzEzNzilOT
	dYuTE/PyUot0jfVyM0v0UlNKNzFCgodvB2P7eplDjAIcjEo8vAuWmIcJsSaWFVfmHmKU5GBS
	EuVdF2MRJsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEtyAQKMebklhZlVqUD5OS5mBREudVW6Lu
	JySQnliSmp2aWpBaBJOV4eBQkuCdnQzUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqS
	EQ+Ki/hiYGSApHiA9iakgOwtLkjMBYpCtJ5iVJQS550MMlcAJJFRmgc3FpYSXjGKA30pzBsG
	UsUDTCdw3a+ABjMBDQ7fZgoyuCQRISXVwNi0NetLlIHdM/kXD3OMb8eHr0kL5JmqW8vVq6x+
	SeGmhPu2HsWN8oKL4udLKy1vs05JUKmV1hadOovXU/zVjafqErFSpzdMWXKnXf/JVEmGiLze
	X7daNPdXWxzcqKY+ke//Dqvnr9Y8efvjr3ZHSHvwtPtc8n9rlOeVJbuVes2QSWe4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280768>

From: David Turner <dturner@twopensource.com>

Rename copy_msg to copy_reflog_msg and add it to refs/refs-internal.h.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 28 +---------------------------
 refs/refs-internal.h |  7 +++++++
 refs/refs.c          | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3a4aff6..4807b32 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2665,32 +2665,6 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-/*
- * copy the reflog message msg to buf, which has been allocated sufficiently
- * large, while cleaning up the whitespaces.  Especially, convert LF to space,
- * because reflog file is one line per entry.
- */
-static int copy_msg(char *buf, const char *msg)
-{
-	char *cp = buf;
-	char c;
-	int wasspace = 1;
-
-	*cp++ = '\t';
-	while ((c = *msg++)) {
-		if (wasspace && isspace(c))
-			continue;
-		wasspace = isspace(c);
-		if (wasspace)
-			c = ' ';
-		*cp++ = c;
-	}
-	while (buf < cp && isspace(cp[-1]))
-		cp--;
-	*cp++ = '\n';
-	return cp - buf;
-}
-
 static int should_autocreate_reflog(const char *refname)
 {
 	if (!log_all_ref_updates)
@@ -2774,7 +2748,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			sha1_to_hex(new_sha1),
 			committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5ae084b..a1655e3 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -114,4 +114,11 @@ struct ref_transaction {
 	enum ref_transaction_state state;
 };
 
+/*
+ * Copy the reflog message msg to buf, which has been allocated sufficiently
+ * large, while cleaning up the whitespaces.  Especially, convert LF to space,
+ * because reflog file is one line per entry.
+ */
+int copy_reflog_msg(char *buf, const char *msg);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/refs.c b/refs/refs.c
index 31f1b19..6bf790b 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -827,6 +827,27 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 	return for_each_ref_in_submodule(submodule, "refs/remotes/", fn, cb_data);
 }
 
+int copy_reflog_msg(char *buf, const char *msg)
+{
+	char *cp = buf;
+	char c;
+	int wasspace = 1;
+
+	*cp++ = '\t';
+	while ((c = *msg++)) {
+		if (wasspace && isspace(c))
+			continue;
+		wasspace = isspace(c);
+		if (wasspace)
+			c = ' ';
+		*cp++ = c;
+	}
+	while (buf < cp && isspace(cp[-1]))
+		cp--;
+	*cp++ = '\n';
+	return cp - buf;
+}
+
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
2.6.2

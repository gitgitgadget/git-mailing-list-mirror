From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 20/26] refs.c: move copy_msg to the common code
Date: Tue, 27 Oct 2015 22:14:21 -0400
Message-ID: <1445998467-11511-21-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:15:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGu-0001Nm-UO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbbJ1CPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:19 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35524 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbbJ1CPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:16 -0400
Received: by iofz202 with SMTP id z202so241533485iof.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t+R4gqn5Gnv9W+921mvBKsIoIk77AIKX6iGEo/+J0RY=;
        b=O2TtOFmS6eE5aY0SqY5ZA5hCSzv4gbq9EW8fLjq2kKOYJX9cELvLAMAWnzqnXN3Pk+
         DHjTAeeCUeYzXvw+X7RUji7RXdanaEyN/XoQbxt4icRNEZbhf5feVZu6ujsjnw2fQV93
         utLDRSrobsUjhXmnbFuSYnvB92o/lEBG/ZYZhJh6jxSx4BtTKrFtpjHSreMwvhVmiuU2
         0hyZIo3STPph4V6WzLstF4TH//hI/61IaMsLf4nVmmlKL4lQqDXn4dkonxgyUHxwlGca
         rRnv8rq4xN7T5Eb7xUPiJJTNlBhOYVAsskYcZnH3isyIPPTgIXrGuSjbV8eHD7AjTzZl
         vuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t+R4gqn5Gnv9W+921mvBKsIoIk77AIKX6iGEo/+J0RY=;
        b=APTJ7Fr6qcKHpWz7aOQRKdolwaeDG8a4cidZ7oeLXjHvgFYa+ODlgeasbwxkZUsi5e
         oishKApiHl9Kwogq8cYCR3I8qHy34Xkm1PGMaYz9GtcflpuOmuyG+niDTNrcdNWKbADT
         NLUSWjf6Bzci+t0ZwdNJNTiedjYY51z+eHtlUloLbkvQPoVpAwyEJZ07M3TcQWg9cXz1
         QL74qlmrCsBkkArJo3W3pjV0y35gz2tQKZRsNflOqVjeUi64D5XF0PCZ7oTEUEDwdY+G
         NONYLdMVCQhMvE9s4T3SQPOzJgGtAe3uyv1trisQZzmFB0sPoje0hC0EqPmRF7dLcBUQ
         DOJg==
X-Gm-Message-State: ALoCoQk3T9R6fnEJZ/HdoyIyZ0YwRz/HNAYIkujFpHJZsJCkKPmNMU6KuxOCjAxLv2TB6BPMyW8f
X-Received: by 10.107.136.67 with SMTP id k64mr42684752iod.117.1445998515359;
        Tue, 27 Oct 2015 19:15:15 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:14 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280339>

Rename copy_msg to copy_reflog_msg and make it public.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 28 +---------------------------
 refs.c          | 21 +++++++++++++++++++++
 refs.h          |  7 +++++++
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 0111282..fc8a0a9 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2653,32 +2653,6 @@ static int commit_ref(struct ref_lock *lock)
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
@@ -2773,7 +2747,7 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 			sha1_to_hex(new_sha1),
 			committer);
 	if (msglen)
-		len += copy_msg(logrec + len - 1, msg) - 1;
+		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
 
 	written = len <= maxlen ? write_in_full(fd, logrec, len) : -1;
 	free(logrec);
diff --git a/refs.c b/refs.c
index cd0ab21..c31418d 100644
--- a/refs.c
+++ b/refs.c
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
diff --git a/refs.h b/refs.h
index 927b64d..4951141 100644
--- a/refs.h
+++ b/refs.h
@@ -576,6 +576,13 @@ enum ref_type {
 
 enum ref_type ref_type(const char *refname);
 
+/*
+ * Copy the reflog message msg to buf, which has been allocated sufficiently
+ * large, while cleaning up the whitespaces.  Especially, convert LF to space,
+ * because reflog file is one line per entry.
+ */
+int copy_reflog_msg(char *buf, const char *msg);
+
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
 	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
-- 
2.4.2.658.g6d8523e-twtrsrc

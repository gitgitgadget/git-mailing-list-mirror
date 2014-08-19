From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 15/23] refs.c: move names_conflict to the common code
Date: Tue, 19 Aug 2014 09:30:39 -0700
Message-ID: <1408465847-30384-16-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmJR-0002OV-P0
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbaHSQbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:01 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:43566 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-oi0-f74.google.com with SMTP id a141so1439485oig.5
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LTpTbFgMQd27l7rK1MSvP+87/JC82m9FaYt5xFyMW5s=;
        b=U6OzdW4Oa4VucYT3TJBmZLA5Q5B/xEKV0vrrRwPkxnnjxaquxkcNH8ooBCmYMMy0FO
         f5OwNVVsB1TJM/4JOpUXf41EMNMSQQZtIO3ohmtJ4IwZzH5g8Cra/x74/MbMkP2OSfCG
         K3unkL/W8tleVjv+Xmzsn3WhUiGb2f/VKRh2Q6S3kXhs7crxth4zF1b6ac7KyMfBUpBi
         fjgQwKXwXk8uwQ19qMWxOB68qmpNfHItlOZstkOoJaPT7PQCvKnDGCEYGIDBh9e3bG22
         WzI3y5+BX6Wa8YLtKDDekGvqrUoTlLtIcDJw41unPXvl1OMzXGZ7vLYed4YV4l2MO9yh
         HDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LTpTbFgMQd27l7rK1MSvP+87/JC82m9FaYt5xFyMW5s=;
        b=llI3HMiL/gEEFhrtS5zurMxiKsUqQ+xMdfpK5lNu411Mf630aQXl9z9xjbqEDzz2ds
         WpA8fWjqDz+Wfl8++2Ww8pJOAVwocLU7o5jLAwvlRWuEOxjjJe4wEO/j3+bLGMgTm/gp
         WhVC+e+Uv7d4XAtaB8XwtiDi+2gQtenVyMCkq7M1qQvpdnUi2e+DGPI1Hr3S2lcYLwzu
         7gHgt7f3gMIWYHyjC9jVo2Eh4SXOOTw31DwYym+8Yd8pjfRkNio9lYVPWVztolgv8dtl
         rSJXbYUQ8iQIGOiRXRcmwWNDKBqz7Tj4iywmY1WwhYvL3IPnZBrADK579YvEsRuOx1TW
         sRpQ==
X-Gm-Message-State: ALoCoQlDoFbW5Fkdm63IudWhpFM73Sz6UxuYYyOZiabxQXMrR+xbdJj1IisTMT2G0H4rI/rGAHMR
X-Received: by 10.42.83.5 with SMTP id f5mr21472752icl.27.1408465853466;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t75si329274yhe.5.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4DCB45A4406;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 055B6E1BDA; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255481>

Move names_conflict to the common code and make it public.
We want to use the same name conflict checks across all backends
so we guarantee compatibility across backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 14 --------------
 refs.c          |  8 ++++++++
 refs.h          |  9 +++++++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 70c034c..6542969 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -676,20 +676,6 @@ static void prime_ref_dir(struct ref_dir *dir)
 			prime_ref_dir(get_ref_dir(entry));
 	}
 }
-/*
- * Return true iff refname1 and refname2 conflict with each other.
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- */
-static int names_conflict(const char *refname1, const char *refname2)
-{
-	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
-		;
-	return (*refname1 == '\0' && *refname2 == '/')
-		|| (*refname1 == '/' && *refname2 == '\0');
-}
 
 struct name_conflict_cb {
 	const char *refname;
diff --git a/refs.c b/refs.c
index 9bc0a31..177bed6 100644
--- a/refs.c
+++ b/refs.c
@@ -688,3 +688,11 @@ int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
+
+int names_conflict(const char *refname1, const char *refname2)
+{
+	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
+		;
+	return (*refname1 == '\0' && *refname2 == '/')
+		|| (*refname1 == '/' && *refname2 == '\0');
+}
diff --git a/refs.h b/refs.h
index d526da0..a14fc5d 100644
--- a/refs.h
+++ b/refs.h
@@ -128,6 +128,15 @@ int pack_refs(unsigned int flags, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
+/*
+ * Return true iff refname1 and refname2 conflict with each other.
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ */
+int names_conflict(const char *refname1, const char *refname2);
+
 extern int is_branch(const char *refname);
 
 /*
-- 
2.0.1.552.g1af257a

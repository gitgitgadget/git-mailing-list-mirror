From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 14/22] refs-common.c: move names_conflict to the common code
Date: Fri,  8 Aug 2014 09:45:01 -0700
Message-ID: <1407516309-27989-15-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIs-00085S-6G
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbaHHQpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:41 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:59176 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-ob0-f202.google.com with SMTP id wp18so1043022obc.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ccYK4cscaGByjuXX8TW/iIsONOc1ulVCYaD8tY8EOJw=;
        b=jxbxcNLHbx22VlosLKvC9Q1q5o01MsdJcKWDadTYujdyWDHl/u3otSo0Cp4i7ErT01
         0XdU9qVLpUI6yBgkPQ0AQy06HFiGClXQiuD7Ey4aev5KvDnZiZmhu8Sx8kva6l0isE0e
         ro+aAR08+U+ZiQsvXzqz/TBdQsDMB2u4AcGIZ41H7Tre6aJ++mBgl/RMLYFY9K/2j2GZ
         clu7sykGWWX5KeTD8HR0lOnLudL7dF/VJ90XUr/ahDCHVafuRuWMxn+taSfSU6IV+oK8
         PCja3gKlsdjT+pnRvW1IWHqNFNWKaH7oLG3T2t65cnvOsvv7ttKrIYjZc6V+g+FHUWNt
         sTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ccYK4cscaGByjuXX8TW/iIsONOc1ulVCYaD8tY8EOJw=;
        b=UC+8TkiWlNmsc2YgBS/6dhr2Of4W1pKXuILaiTYHtFVxqaJ8fuiBfuZUEnkdno7K2i
         uIe9f5jDLxr64GRUCBwzRrtRsss34ZODaOq7K1LBlWBxtnxnJF5HnLVA1PwuCWkPbckr
         lGc7jO0jS6KwkzGCA5BrSBqzPNGqFefdm0ZC0OT7PZSI+F2OjDZRqBVp3nnz0ut5n8dT
         PYHPoq0Aj4Qsvt5QAC4jZu0rG9QPy2Ir0lVAwN6If9aZpADAv2FkSDDXXLOg4TTeWPoK
         l5LgDi//haDy4jvxldO2OL3tThiM/7EI3nKzWdIlOveKkCDfuVOTKqVfDiT0tYA0lhE5
         1NnA==
X-Gm-Message-State: ALoCoQkJB0TvMzw/8Svbfic21W7gViwZ1OceJDVZ+9t1q/8ftwkDQiBoxmGZ1VFf1SyUfqfQpfdh
X-Received: by 10.50.119.5 with SMTP id kq5mr2493953igb.1.1407516315916;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v44si506102yhv.0.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BE49931C5BD;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8BF70E1203; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255034>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c |  8 ++++++++
 refs.c        | 14 --------------
 refs.h        |  9 +++++++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 5f83d7e..6eef80b 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -3,6 +3,14 @@
 #include "refs.h"
 #include "string-list.h"
 
+int names_conflict(const char *refname1, const char *refname2)
+{
+	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
+		;
+	return (*refname1 == '\0' && *refname2 == '/')
+		|| (*refname1 == '/' && *refname2 == '\0');
+}
+
 int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
diff --git a/refs.c b/refs.c
index 70c034c..6542969 100644
--- a/refs.c
+++ b/refs.c
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
diff --git a/refs.h b/refs.h
index 7b59044..5577824 100644
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
2.0.1.553.geee1b3e

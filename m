From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 03/22] refs-common.c: move update_ref to refs-common.c
Date: Fri,  8 Aug 2014 09:44:50 -0700
Message-ID: <1407516309-27989-4-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIK-0007Q7-2r
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbaHHQpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:45362 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbaHHQpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:15 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so1475415pab.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nkWHvzN4mnTzNM5H/mMLVbDXqJw3DNTzwi+pxPY6kaI=;
        b=PFYAwpNynG3oSCxtSozm4Xv4DlgjYmsmtqwNc9RYpi1GHZhdESMwrwlSxxqmjSFTy+
         W03GfRksWu4RYTpHfcoIKq0hSb9HiM7aWeh3ui4CnB8FzAOUTPO41gSooThR/22l9jko
         I2Y//LazhyXHzw875cLtBba/Cve3I4ssJERP4HbiydnskzI5hIT2k4wKeS9PUq4im+30
         f1lSIRLnANy4feM409W2c3sYnDEvTsn+2fDR+vIzk64zZLIDlPgJAizXKj03GZrzUnFM
         DWPa9Eo4uIGICEoKWlJ0wNpwZC9hmj4M94XhgR97IpD3ZuBBgUPnLUM+3hjlM+J5QhV8
         v5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkWHvzN4mnTzNM5H/mMLVbDXqJw3DNTzwi+pxPY6kaI=;
        b=cBj6iLSnzBpysbJScDh6PkINEDAhR3tsYb/o1KCX2Ge/qSpvROBmoITFaJrd+RpbgO
         4/01DQdENwowxD8cobDVH9WQ7hf31+0a0BU+JjBdv2m9BX4ioYHI1ISsa6aZANw3Z0C7
         Nws2iEJ5bq/dJzf5Y+za4nVXvOa4qyZmCexRvQr/EaUiQpQ/BkCXCAIPrpBoIQLqAWUm
         zCUg0zFGifqh9Yw4KjHsZ0/+1NVeZtBrhRwb2iyaSLWKQSFmxWuNkfFAZuWvGeXzLPBm
         /8ypeLQ8CeJm5VNmAT8dLHYQ4lKVrz+VE/eGE6S66JOm1CB3wWRfGeWkHhJtlprfp6Vh
         mAJQ==
X-Gm-Message-State: ALoCoQkF3pJcU+x2A/rliTxXpN1Q7LrdGdq9PNO8Wgo90iQM2UGKWsbBN+Q0jtcVL1tiZrAZAy5o
X-Received: by 10.66.141.48 with SMTP id rl16mr12827822pab.1.1407516315381;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si503971yhh.5.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 346E631C5BA;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D3FA3E009D; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255026>

This change moves update_ref() to the refs-common.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 25 +++++++++++++++++++++++++
 refs.c        | 23 -----------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 44d96d2..cb884b2 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -1,2 +1,27 @@
 /* common code for all ref backends */
+#include "cache.h"
+#include "refs.h"
+
+int update_ref(const char *action, const char *refname,
+	       const unsigned char *sha1, const unsigned char *oldval,
+	       int flags, struct strbuf *e)
+{
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = transaction_begin(&err);
+	if (!t ||
+	    transaction_update_sha1(t, refname, sha1, oldval, flags,
+				    !!oldval, action, &err) ||
+	    transaction_commit(t, &err)) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		transaction_free(t);
+		if (e)
+			strbuf_addf(e, str, refname, err.buf);
+		strbuf_release(&err);
+		return 1;
+	}
+	return 0;
+}
 
diff --git a/refs.c b/refs.c
index 4a22513..eb66cf7 100644
--- a/refs.c
+++ b/refs.c
@@ -3576,29 +3576,6 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 				      old_sha1, flags, have_old, msg, err);
 }
 
-int update_ref(const char *action, const char *refname,
-	       const unsigned char *sha1, const unsigned char *oldval,
-	       int flags, struct strbuf *e)
-{
-	struct ref_transaction *t;
-	struct strbuf err = STRBUF_INIT;
-
-	t = transaction_begin(&err);
-	if (!t ||
-	    transaction_update_sha1(t, refname, sha1, oldval, flags,
-				    !!oldval, action, &err) ||
-	    transaction_commit(t, &err)) {
-		const char *str = "update_ref failed for ref '%s': %s";
-
-		transaction_free(t);
-		if (e)
-			strbuf_addf(e, str, refname, err.buf);
-		strbuf_release(&err);
-		return 1;
-	}
-	return 0;
-}
-
 static int ref_update_compare(const void *r1, const void *r2)
 {
 	const struct ref_update * const *u1 = r1;
-- 
2.0.1.553.geee1b3e

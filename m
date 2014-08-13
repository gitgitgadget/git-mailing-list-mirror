From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 03/23] refs-common.c: move update_ref to refs-common.c
Date: Wed, 13 Aug 2014 13:14:47 -0700
Message-ID: <1407960907-18189-4-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHey2-0000Gh-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbaHMUQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:04 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:33015 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-qc0-f202.google.com with SMTP id r5so35838qcx.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J6whb5P9t8wLbXiG/advDKEZ3OCa3FJADGk//frf25s=;
        b=lFs9QLhEGNwDcprzJMDCNYcr78leIFeXLvvfA45n3qY/cEq1NXYl8FwIAWm5nasW1f
         SARxjr5xqM/BgunFcpQgwchT/kLifM8fd1x3jtqjNEG0EANxTvK+QSvJ5YAEwjCKIUZN
         S1PRTPGM5/C6jzefwqu3ccLengnm44qYqQfWstSJGUNDTe5w5FqsDS/5hboJejqFtl6C
         l9SmRBXj8h6PwuLbEgzH/UJNzeuWOjV7bSpR4m/+k5AYEMb+lPecFg48OKsRktoXZbQl
         A7Au3bbLR0+OAY5+8IB0pME0UuYhRGh3mAaHsSRD4jJC9HW2gHZghhSaSRl6TUfY7zV4
         xyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J6whb5P9t8wLbXiG/advDKEZ3OCa3FJADGk//frf25s=;
        b=eqo+RVeVc1i5Rj98Vt7uNqQhGx6QD8uD9UotnT0xwg8KrhgZcneAFJ4E1qPmHO/EUO
         09O2XWnr5eaMUg68zLiTWU9GbVmL5FZObr25KYthtXNj+Ac9kUe4Zi/rNu9apUO9UCNE
         +2F2yrjphvsT63+4q4ygw4MkypzibQ1kA7Ce4QLB2NK6GhrwSi/35XMriFuhXYTYB2nL
         hU8wA+vYptHkBxkR9H4M9L/El3WKZogh/3g93Q5h7JlqO0kk0Nwpg3THURtLiyAqb56K
         Ph/m+DDEzyk1w2JUbZnQiVQFfRLiYZxbcWqZB5sePZlRy7j12BysJH+SxGZgGToMU3va
         AtxQ==
X-Gm-Message-State: ALoCoQkj9k0PAx04iCVAP+/i3ZD8qNNFPGGbFa8LquCqHZUyumZjOOb2jDFAsoRsbZtWkx3ye3ZQ
X-Received: by 10.236.155.132 with SMTP id j4mr193862yhk.56.1407960910005;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h42si209637yhj.3.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D68675A43D3;
	Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 81048E08FA; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255247>

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
2.0.1.556.g3edca4c

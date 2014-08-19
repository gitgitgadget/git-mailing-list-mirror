From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 04/23] refs.c: move update_ref to refs.c
Date: Tue, 19 Aug 2014 09:30:28 -0700
Message-ID: <1408465847-30384-5-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:31:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmJQ-0002OV-OW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbaHSQay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:36731 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbaHSQax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:53 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so1812965pab.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJBE8egu5DlLWsPJSGRhtoU6A5XqR9z2iRJCG0kExyo=;
        b=euZA24nsyzJJtPQg6oHjvrKn25NUFB+Z0HCbU4A8WuI0xoV9Jj/Lo/jHuonG+347FW
         VKGmMcE11WddPfdwjVRMyKqIgB7E2RZOQQ+5XmydMk5y+2vVOcLodHRU4PEfRcGKnsEN
         watyDUdalkvLOJ+f8ULnVPcora1dTEwBnegFoYX3eHTtSXjy1riWxiCcaB1uvtWWavRG
         jyvVP+kyuh1eHwauPJqKYMC1uB2X4/dDSPu/xNlgKBb5KBqXA2/aD2EtR5F0rQpegmdl
         +0smMNDiwKGm1+501ta5KLmHgGe7z8pVEyPO51wxL3XQf2zyrxekwXPcEnIEjWi/TllO
         XO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJBE8egu5DlLWsPJSGRhtoU6A5XqR9z2iRJCG0kExyo=;
        b=XUVzvdaMfdJk+ra9Sjqo2dI2YkyTP2JZGx+3OCb225em5BTzHfUvUzgcOKsOPbl7v1
         bJr0ZGk6akQKNbxBvHuRjYbFfKiXkshbqD4c95PUXuWPb4TOcv4xmqXckl/R6SpuY0Uf
         PdQjCMZnOm0yUtCOVyXP99MNFbdUw+jR/T6Iwr+XlbHwmz5A0pSYvzRb2rxHA+kpNe4D
         Y8Sf9uw46C5kPvDLEjBYI4X3oAjuXsYjfponor8/fS/KrZPJA44avKlKn3iTIJiO53ND
         YrOOojTb8L1X4i9TWcVA2piteKUAGeQLeTV424Szgkw3B60cPdKUl7YzDexDbejyb8XG
         85YQ==
X-Gm-Message-State: ALoCoQlT5V+OPifqsbRhw4/geb9MjJUVj/Po/m+4B7pNJ40eXxVcaIZER+xltA3TFZV3fUmjI9wF
X-Received: by 10.70.130.135 with SMTP id oe7mr1468961pdb.9.1408465853094;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si329226yhg.7.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C7FD831C534;
	Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 72F32E0F40; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255479>

This change moves update_ref() to the refs.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 23 -----------------------
 refs.c          | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 4a22513..eb66cf7 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
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
diff --git a/refs.c b/refs.c
index 77492ff..5f6a1e7 100644
--- a/refs.c
+++ b/refs.c
@@ -1,3 +1,28 @@
 /*
  * Common refs code for all backends.
  */
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
-- 
2.0.1.552.g1af257a

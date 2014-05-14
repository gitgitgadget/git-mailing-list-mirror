From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 09/42] refs.c: change ref_transaction_create to do error checking and return status
Date: Wed, 14 May 2014 14:16:43 -0700
Message-ID: <1400102236-30082-10-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgc9-0001WN-S8
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbaENVVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:11 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:39863 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbaENVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:23 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so34042veb.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCcxdA4wCbcANLP9fpccDPoRtAGtCp2CYPqTeJCIcTg=;
        b=A6V5Ki5QFv8T5SIQ4KnMu3CdgRrxpa0xsWi0iVBbLvZZFg2mcMD6xc/o/kuOQnlLke
         A17sy2RgoKOGdFqYiSEiLmhMJ1DQjmkVUGLtJzUaxZKx1/OMVIZlSmgj6V21mGSj9Av9
         XjsINE/EQ2EbF/+J/9L00IYqiuEfe4seZ3IMAMY82dTpANi7k0FNi5tCKnubk6o80XY1
         zWecGpWjvHjOz6xfAG1wfjIsxUJb+wMlD1l1lDsQVpmZskBib2fvYslYDD6rh0hNWJwC
         YlAuUaUufod+DASb+8zpogefy+u6QoCyigsDA86+41m28S3ZcQNrOiDKV4LZgC5EbHVI
         Zi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCcxdA4wCbcANLP9fpccDPoRtAGtCp2CYPqTeJCIcTg=;
        b=afKhrMAB3QSLRoHotNTw7UVE6JIk+T5Rt1PQmv2mhuLTKq0wcd2yrd5HBC764uv/iC
         fwdKY1GjSZO0H9SzG2xn/aXzfjs7Guy1q5bHJuMWuTPEMR0hT/q5CtRaIEKn/KFi1j11
         7OdpDb0qjo22gNfkexkHlnhks0Z0pAtt+5PRgAuH3kZ7HCdCjh9Le4PbJtcjoHkqxyWJ
         8FpAssf+6DijL5Hq5IelQpjH+C/lUMykjM7l+XenSgPBVuGWN+b7AToKegpYJKs9+u0x
         wft9j63f6QWrF4rfGGBu/7yCNgby5IOgG+f4P4CgN2uBBUevxSfmGty7x+5M4Ph7+/Fb
         eDZw==
X-Gm-Message-State: ALoCoQkqVvW2OjUS1YBqzvbh0CotmCrTpyNp5e4GbyixcrshNlWus06pGx4XOAWQdfBGwCXZcPE/
X-Received: by 10.58.94.163 with SMTP id dd3mr2959218veb.29.1400102242932;
        Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si146330yhj.0.2014.05.14.14.17.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B545E31C1F8;
	Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 79A30E0973; Wed, 14 May 2014 14:17:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248993>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               |  9 +++++----
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 59c4d6b..3fab810 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags))
+		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 77b27ce..df376fa 100644
--- a/refs.c
+++ b/refs.c
@@ -3362,18 +3362,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 57103aa..d4c068d 100644
--- a/refs.h
+++ b/refs.h
@@ -255,11 +255,12 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
-- 
2.0.0.rc3.471.g2055d11.dirty

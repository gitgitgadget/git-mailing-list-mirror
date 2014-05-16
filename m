From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 11/44] refs.c: change ref_transaction_create to do error checking and return status
Date: Fri, 16 May 2014 10:36:59 -0700
Message-ID: <1400261852-31303-12-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6j-0002jl-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758082AbaEPRjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:42 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:58697 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so885815yha.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oD2SlXs+YxHoOduVS1JQi8W4OoWdMMbGW22m3ygF4lc=;
        b=i6Ncw5FtO7MhZUCLrT2TgaVfENTklHosiBL5mMp7jlERcgAb85wRR11u4z51I4w2o2
         n5XUttpNajGyPxu2Icgp7ayrh/9SV1B976UllKsMWJdkem3KojPuPSJNl8qCM2PkCJ34
         6euEb2fA/Qd51JA34pY/gPl5WWhJ9XyAus176k55c9e+4nQnubiTYyh8DrrhWrOupLWq
         il5q6MLQdG/id2jVnfX3nVuH2oj8milIHYi+ZCUvNIdZFmFL0kDzAOfujK9+l59d+yK2
         gaoD2oDojXc5q7Tq8t8wCG9eEfnfMkYWmg1O2JjSzhqFk+T9yNOuQrUfu3IQbpAm6yWD
         4XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oD2SlXs+YxHoOduVS1JQi8W4OoWdMMbGW22m3ygF4lc=;
        b=XKCbWoW041+3skWqQolNPDiGC9M5z678yrnZbdv0tFGJz0QHZE87DHk9hF/FelirYt
         aFERBYQRtXz/Aguj2mD6p88dSWuvwOSEO2Ki6hkHP38CvNiYp49LkF76BE8n00mFixJ+
         iU3Zi6P/BIwhNaE01u2KH73bSlYRXfG0L9d6faJfVFMlZ25epQIe52NXTrS5Uze7E7LG
         rUOuheuHZoNCtUVcB8iuW9rnjX2hwrKHdhwfg6OLjt1FVV0kqEzkE+byuz0kmmPMR5Io
         clNIMJiGbwZsmXgCZham22bFfZIO04Qkwh/7/6RY0lSD7aXuwahnTcoW6HXQrcAFki+0
         Ylyg==
X-Gm-Message-State: ALoCoQl6APygZUqdPPJuJztZmGAbV2F0IxqUVPE1Ppsm7QJTNLaqwyRu2Czyh2Ap23EV+L0zxOXb
X-Received: by 10.58.30.78 with SMTP id q14mr8635644veh.10.1400261857167;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si368508yhj.5.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 090A65A4292;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B8D96E13DD; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249390>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 18 ++++++++++++------
 refs.h               | 12 ++++++++----
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 9f328b2..e9c216e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags, NULL))
+		die("cannot create ref '%s'", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index a4fdfc7..06a4fed 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,18 +3397,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create ref with null new_sha1");
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
index 454871a..bcae348 100644
--- a/refs.h
+++ b/refs.h
@@ -251,11 +251,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure. A failure to create
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
-- 
2.0.0.rc3.510.g20c254b

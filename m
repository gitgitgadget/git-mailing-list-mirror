From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/15] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Tue, 21 Oct 2014 12:24:09 -0700
Message-ID: <1413919462-3458-3-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:25:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf3O-0000Yv-GE
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbaJUTZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:25:01 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:36201 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbaJUTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:35 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so283191oif.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7aiaMGXWZz6yJwnb+GEJ8HAOJIKXMUoWFMdxipTYivo=;
        b=FPijBvfnSLiGZ0mPbb8Kztz+a371queszbaqRA2gXSyfCutgQPhYYVuamxifMocq6V
         J4abQp/UTcJG1PkkHPQmL6Odiv3eajSL2oyCVwj00/qy/pAErKJW69M1I9IbHMHEFhst
         4QoH+EJsitEOIjNJDvbPj4tbOe8CICsqjjaXixv4ne36n1g2huJb78VBeULj9mlWmZiC
         0xQ+ELW9PJ0i+LLN8xpOUDJEE/dNiYFLHgsLhJH2/5IFz06ccO84vuxlK/AiVfmPUrJq
         pH4+J711rZZ2cz96VGR2Gj3d4jt9qrA2+wxzU8P3RLnLgdV47DOgad20PYpGvNOOuDxs
         591A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7aiaMGXWZz6yJwnb+GEJ8HAOJIKXMUoWFMdxipTYivo=;
        b=RdxLR3SZYP7FS+8q/nZ/xWnuZPJHJzUKBQV5cmraU3U4IzJF4YzO1YZWzrL7JCVyfz
         gLAt3htUKX9r8XeCpStqkPIw7oPwYlZ+spJ9O5AKSZCnRk7QVhGqJTvQ3gzNpEVhrPWi
         Bipy/60jQaZrC5UVCHiZbysPtHSMIL5+KqhT5JJaV+Rf9vUQk+T1ZAdqneI52fOvUM3s
         IEbNk7fCLvgDAp9IeApGybX8Lyt+xs8DvnCyOw791zsSTKOk5YVnNiesUQ53qO/BJaya
         jQDseVB0fRjV+lqeTxpvXL/NQhVgdH4uhOedHJiaXOeNkxX98nXugDnVSEQNIWE0dJg3
         Emjg==
X-Gm-Message-State: ALoCoQlMfHT0EkOou9VwYBxAX9pnlfMwAtkjaHTLZWAY5X/vM1qkQJA3PcyT3ZLE9XkEpU4bxbCo
X-Received: by 10.182.73.225 with SMTP id o1mr24509267obv.28.1413919474943;
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si582838yha.6.2014.10.21.12.24.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Ll6Muiic.1; Tue, 21 Oct 2014 12:24:34 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2B3C8E1006; Tue, 21 Oct 2014 12:24:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 0beeda259297c92d411ecc92fa508ec7cfd87cc5 upstream.

Change-Id: I685291986e544a8dc14f94c73b6a7c6400acd9d2
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 22 ++--------------------
 refs.h |  2 +-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index ed0485e..c607ab7 100644
--- a/refs.c
+++ b/refs.c
@@ -3633,26 +3633,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: delete called for transaction that is not open");
-
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 2bc3556..7d675b7 100644
--- a/refs.h
+++ b/refs.h
@@ -283,7 +283,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
-- 
2.1.0.rc2.206.gedb03e5

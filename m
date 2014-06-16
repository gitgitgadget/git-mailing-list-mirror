From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 02/14] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Mon, 16 Jun 2014 09:51:33 -0700
Message-ID: <1402937505-6091-3-git-send-email-sahlberg@google.com>
References: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 18:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwa9G-0003HJ-PQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 18:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbaFPQwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 12:52:43 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:58732 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbaFPQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 12:51:50 -0400
Received: by mail-ob0-f202.google.com with SMTP id va2so1116342obc.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DovcM9SzfO8AFq6UOaSUN7gso4C32GXCJZf+OjYEgX8=;
        b=BoHaPRkTdzTMrYzll+rXxroUfGab3kUk/Bg9fFXMFFF3TZMjVVwuN0mzp0/un8Td1i
         LP/EuVxIxt+LCtp5qjtPdnHz1/ZxM0yXNQ7HYzrnPnLeMWYRUdAWXD0d5gr3UNcr+gu4
         L08K8TJNfSHhT5PghGrS6qkFK3zCK6BpVpHHttUVgZ5v4b3ylUBRjI+5PkEtwju5+ZJL
         hY8i2kJdNCI/praaxz9TInZyg0lF2LS+grrkvLVk1N57QhILf8UFsfQgtHQjAKQyMhW+
         nhITidyD2RLbDsY4zFw4QkEAmpRIyiW6iZZKvKwbuLloQ0iKTsy8WavMHzuR61kOv77d
         NR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DovcM9SzfO8AFq6UOaSUN7gso4C32GXCJZf+OjYEgX8=;
        b=Ai+IXRyLcrIr5d9H1hT7OvQZjr8QdBbNjAuVhVpmLetFCIIReOGbHPQ3pGdBzHqAvJ
         hJmtMFe399fkiz6nPmD78uymaYs46NIfkIlnACsKmHnLulIKLVVZnE1sP8Sw+UEmA3qk
         1UmvvGYmiMPz0GMSkirtM5Cr6C/ov4yjiP8IWUOyAtmQjD/RWuElhub8WNn4Lhu3j5SE
         StPQ7NQFDoACE+Atfxrejh+C6NRwmPkCnERHvuy2CE2wze+eFodggZ/sV9ey50e96isU
         nhgWGZr/eapfGkxxC6d2v+kelmaEphC1gasKpXaWdwndH/agKNzYDGVAG+8M2ryqDLwm
         6vpQ==
X-Gm-Message-State: ALoCoQk9tkIqPPbfN/Y+4NQ5of63TRmAqYoviHOF5oZo8ihmlVj3u2StN0Zc4/crH7RnZOZIakv9
X-Received: by 10.182.109.231 with SMTP id hv7mr2304628obb.2.1402937509611;
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si984632yhm.0.2014.06.16.09.51.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6B7DF31C675;
	Mon, 16 Jun 2014 09:51:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 07748E0CFF; Mon, 16 Jun 2014 09:51:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.770.gd892650.dirty
In-Reply-To: <1402937505-6091-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251731>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++------------
 refs.h |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index c62df4c..76732a4 100644
--- a/refs.c
+++ b/refs.c
@@ -3525,24 +3525,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
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
+	if (have_old && is_null_sha1(old_sha1))
+		die("BUG: have_old is true but old_sha1 is null_sha1");
+
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 4843706..43aafb7 100644
--- a/refs.h
+++ b/refs.h
@@ -281,7 +281,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true and old_sha is not the null_sha1
  * then the previous value of the ref must match or the update will fail.
  * If have_old is true and old_sha1 is the null_sha1 then the ref must not
-- 
2.0.0.770.gd892650.dirty

From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/31] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Wed, 14 May 2014 15:13:01 -0700
Message-ID: <1400105610-21194-3-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSZ-00019y-Cw
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbaENWPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:30 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:34441 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbaENWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:33 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so47400qcy.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udck+YhUAax9+9Yl0HazdChRB05Q0VwYBDqcAwFe2GI=;
        b=h6wZh/iHbWrg3sWGzM8rCV570g/P4hekue9lWGlpfuyCK5O8Eqh/rxVwhKFc1WjZig
         lkZJu3NbEZOJEOZUTHdsTkix++jOg8H8WsiejB2KdUOfAMYY06HzBKJnPdGWTsKXarwW
         f7teUbW49IPIeXVO5Rf1c1zGoWlKckCPgMZ5K8A/r7GQV03Uojk63IqOhwdfnL0Qsgys
         fzzbI+9K/QAljVca++tno6YMaRuNyQPRWVCg3L9wS2K8BIVpFj8K7AGFEFenQBYSdjta
         p4P8spnGOJSQS7txZ3VNWEL7ilZWh/1mdLKz9fGXr99YotO7hMo/biOAVXejtUYTQ7LA
         HurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udck+YhUAax9+9Yl0HazdChRB05Q0VwYBDqcAwFe2GI=;
        b=ffia0erxs54Wn76jnTv6/Tl8RvplRm/LHfXuCVeb9nmM4nSMXg84tLS1NeUmdRm/Av
         9icfrxXM7cnLhJU8VKLAugAcepqLksK97pkwKbCbp+2LHg8ROTmxAvAsiPfsCZvICu58
         TUuOFgHmsPlQndMiqVY4WyhzGKwfDEJZuA7UPRyEv/ioJljyj05kniPGM5vLGEh0j5Hf
         vgEsOi+2ofVD+ywFsCTPVb6MgHAxp/smoMCoV456C/FJ6k0MfvXVBBWZJDXcTrhCwtgB
         OguFt/xwgaksVPea0AmmCnwOiK0cTVrF43y+5+HYuiT3KcWaHqUIjflqu7+yM2GwZYIK
         92cQ==
X-Gm-Message-State: ALoCoQnvbBe2bm2wmAIbK5w6GaqaJD5kwuT6SMJsMxxoBrfN25yzP/w+VF50CZZIGyiOjEeDBiF4
X-Received: by 10.58.218.232 with SMTP id pj8mr3075415vec.3.1400105612938;
        Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si152241yhq.3.2014.05.14.15.13.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C5F7A5A41E5;
	Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 868F3E038E; Wed, 14 May 2014 15:13:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249037>

We want to allow to delete a ref even if it only exists as a packed ref
so we must tweak the REF_ISPACKONLY test in _update so it only applies
to the non-delete case.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 ++++++-----------
 refs.h |  2 +-
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index fe195dd..c180fa2 100644
--- a/refs.c
+++ b/refs.c
@@ -3326,7 +3326,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: update on transaction that is not open");
 
-	if (flags & REF_ISPACKONLY)
+	if (flags & REF_ISPACKONLY && !is_null_sha1(new_sha1))
 		die("BUG: REF_ISPACKONLY can not be used with updates");
 
 	update = add_update(transaction, refname);
@@ -3370,19 +3370,14 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
+	if (have_old && is_null_sha1(old_sha1))
+		die("BUG: have_old is true but old_sha1 is null_sha1");
+
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: delete on transaction that is not open");
 
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
+				      old_sha1, flags, have_old, msg);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index d615871..8d56edf 100644
--- a/refs.h
+++ b/refs.h
@@ -232,7 +232,7 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true and old_sha is not the null_sha1
  * then the previous value of the ref must match or the update will fail.
  * If have_old is true and old_sha1 is the null_sha1 then the ref must not
-- 
2.0.0.rc3.506.g3739a35

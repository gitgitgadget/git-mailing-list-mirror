From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 36/48] refs.c: remove the update_ref_lock function
Date: Tue, 17 Jun 2014 08:53:50 -0700
Message-ID: <1403020442-31049-37-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvk5-0005sn-3c
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933526AbaFQPzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:52 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:46546 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so1487956oag.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ho2WFYAQCLDlkPMG9JsQ9Juz4f5kjBRfhpNpHvoItiI=;
        b=ivUrf4p6Rg4tJobw0+n35E2vvgJbJkXFwQrf9EWVRboL5BSN1NWCy22LcA1VfNRpMU
         wlFcFqzlyt0MwpG+E5RproKeZCp2aLKx+z8EE4D6TlE4UQCZyiJiAu+Pd4YMChgbbxmB
         jnJ59RNCvLfHsuzf0tICNShLR+MEiUJlYynZkbV4xr7qxA23BqJGgmEbOUFey+mh21TG
         Rdl3RfzXOHxG/WEmMhlv+Cv6bzFQj6/2kYbvL1z6+w0jvfAXKjY4OqHTD+mLxtT/NFfg
         Tpzh+7E1j06oAwBYPFu2jxWulfWMwRarauUwTS1xX7Y1nc14GNE+1lWm7xXQEdBZLlV0
         4Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ho2WFYAQCLDlkPMG9JsQ9Juz4f5kjBRfhpNpHvoItiI=;
        b=TDVihOKT9taQdZHkbPvqs8m/6JVMUYjj5Qd33Cyyv2rra0jAkeqZHvirxpvu7f0OCU
         voFCzVxWrNDrnme8BVnMtxUjQ7qAPC7Rq93GYj+rNNlkEf335WCd5cUi0KokTqf26hmD
         PtipHnWmIj6VCYVLcjkkCIyob+xpuODlrK+UWoFhcDsGUQrxbyE0ffGG7C0gcQdBIXJF
         dYv8lEOOfzy1RpJCCuecWs4elIO6RoSkBz8TFKWkVFzUBHA72ovfW3nyomOMrk2oAsUJ
         wiG2RsbraOluAsAbOpG4dBErSFDuatgqDFAVwBatPCl9gzWLJjbJG+FZqcKJBVZDYzLS
         0lcg==
X-Gm-Message-State: ALoCoQm5q8nXeyHXf9AocCKKqT/CaytRGbv1mViGIB0Ch6R6/7GCj8djKajHrdcGmIEK2ZbWnfE9
X-Received: by 10.182.58.71 with SMTP id o7mr1019333obq.3.1403020445731;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1209160yhb.3.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8860B31C76B;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6368FE1129; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251899>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 56a52e0..f8e4300 100644
--- a/refs.c
+++ b/refs.c
@@ -3356,24 +3356,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static struct ref_lock *update_ref_lock(const char *refname,
-					const unsigned char *oldval,
-					int flags, int *type_p,
-					enum action_on_err onerr)
-{
-	struct ref_lock *lock;
-	lock = lock_any_ref_for_update(refname, oldval, flags, type_p);
-	if (!lock) {
-		const char *str = "Cannot lock the ref '%s'.";
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-	}
-	return lock;
-}
-
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
 			    struct strbuf *err, enum action_on_err onerr)
@@ -3623,12 +3605,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = update_ref_lock(update->refname,
-					       (update->have_old ?
-						update->old_sha1 : NULL),
-					       update->flags,
-					       &update->type,
-					       UPDATE_REFS_QUIET_ON_ERR);
+		update->lock = lock_any_ref_for_update(update->refname,
+						       (update->have_old ?
+							update->old_sha1 :
+							NULL),
+						       update->flags,
+						       &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.438.gec92e5c

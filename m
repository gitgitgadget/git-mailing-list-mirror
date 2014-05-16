From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 31/44] refs.c: remove the update_ref_lock function
Date: Fri, 16 May 2014 10:37:19 -0700
Message-ID: <1400261852-31303-32-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5l-0000Oy-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122AbaEPRin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:43 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:40822 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so489878veb.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5Dqd7q/QHixJlRv72ZJRFNisNjztJJNUhzwJT/wo6k=;
        b=BnUC3TDv3WIQcAZFv7Q8mo1zWth5/uCeK3ML5x4N5BNA8nzLcY+JdLUzpKDYx24CgX
         q4zXySfUHqt0muotV7Bjij1fcVOVVvgC0baAfQW38dczKcZHA3+vVqhi16Ixvs26hocK
         spfau8z3e/fwOwAWHoDXeM3BTNaHc7ZBfEpVMeNvRvbYAUxqLh0w9j04gyPVUhHYVVSu
         RsLK2yBKFhf52myW8Xojca3p/PBP2ZNLkL8G81qK14TBKfBJFEtQyEh4TMmrnnwBO+60
         h7Bscd6AV/077+2SzosRJtCSPVuFru9T6zm8zyF/UZYzQYVsgvm+K8YrTuauyyUUwuuM
         2ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A5Dqd7q/QHixJlRv72ZJRFNisNjztJJNUhzwJT/wo6k=;
        b=m7ubE79tFBGcuS4PsB2wDGOeBj6cZdTQvsPcGizcw+GVVmPCRyfi4SuiiACTTg8Agl
         bw2xH3X6eY3g1k1GZgyzCSzcXtVva+WtkM4TdcCTbVvcNiK9pi2NFuyxGUB5Vc6hQIgL
         UaipZlklhV6DRaDq+uuevbvzVAb4C24+4uRVAet5ysledEyiMRu/JBEsFKbG/NsaE5Dr
         wN1DMPA+JGpNPSmh8/2wIPiZcrh8cBZXAtKvNwfHFxBqjXTdH1n2RpiyPDjuQ66Dzfis
         4FiewcRuHoHiu7zs/lkcPJ5b5ov73fhUjQN3sxrumEBFPy5v60tKLYAhAkjegqNxgzbR
         HO/g==
X-Gm-Message-State: ALoCoQn0FgRCnp5y8n1mbrFwRlqW3yhAgBHRaYPema/DgVY1aOi2ZOlMK1XX92e1RdzpzVWjm/Ci
X-Received: by 10.224.29.129 with SMTP id q1mr8018090qac.3.1400261858253;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si368517yhj.5.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1ED1731C227;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0E0AE0F5D; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249371>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 4f7ae92..04de777 100644
--- a/refs.c
+++ b/refs.c
@@ -3283,24 +3283,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3537,12 +3519,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.510.g20c254b

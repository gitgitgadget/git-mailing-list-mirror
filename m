From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 31/44] refs.c: remove the update_ref_lock function
Date: Thu, 15 May 2014 10:29:46 -0700
Message-ID: <1400174999-26786-32-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUm-00005L-T4
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbaEORaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:22 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:44292 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ie0-f202.google.com with SMTP id ar20so289265iec.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JfrLon3eHKCFvzrCycWlkSlfMiCLS5k4HwVSMNDyBxY=;
        b=RTxUI8DGZpj1V52OITSFNb7324PBuheo7+L2W9zygdNDIi1JPpRITtdb54sBwuyFc6
         4MVEs6y/+y3LBfC4DYRdEAHOSkZhHXogYBiULCwGbFXbSOPr0ztz65n/a+Q1Qh9et/lc
         e8fK9fnwXg95wfyO9brQhVBGIugRWTTmHXDPzFkhzUORyaBKnv/MDb2kXLl7lZnQWGbl
         Osjc8AdJ9Uvnu7EeEu/1Xfcxh2/bF/ZaOZkIJ4EcuSqxASfp0X0xcHjwx2AYebAW9XK+
         9h6ubG4M9FRV7UD9JnMHy0z22A7TQD+eoyKETBM7YF3wOGo0Oc1IPAJBAVrzPsAXGrM2
         NzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JfrLon3eHKCFvzrCycWlkSlfMiCLS5k4HwVSMNDyBxY=;
        b=CpvHoRoK6+5VgOmtSsGxEHukQbx7kASeAsSV5YXu6iDEwpqmXBRRbvULKUgQWtUJnu
         fjwp+R/AJO3VGagpa/eQJQ1E23oL2gFsfdMIfzzLl1JVhcBAHOG/EznFwdtkNe4Vdbk3
         xLa9lrTTndceTb6yEm3muzzq7vyDtc59fsEs8xt6u9NuWiRDdA/yXKKeq5kjWioPau1c
         Ezb9HHacYcwdGVwNiplRNa846cJPN/ZlETujrvPxw0umf0vlMitHnB8f9GeLShR7WeiC
         KhJoIJMQXJ1h3zG4LRZmzUFYEqXcLCKIrmPby1jJsbcmw/K3CZ+B/XXC1ttLkvYlmiqn
         0klg==
X-Gm-Message-State: ALoCoQm056UOqs/L0NRXvo0mjlZnVEwKwALl6oqVqJ5+j/mMNzPznQFLCQt9+CznCv2HKKHDJt8s
X-Received: by 10.182.227.131 with SMTP id sa3mr5581459obc.38.1400175007233;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si272584yhb.6.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 19A125A427D;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E904EE1207; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249134>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index f11f832..07377ad 100644
--- a/refs.c
+++ b/refs.c
@@ -3255,24 +3255,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3516,12 +3498,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.g0f8edf7

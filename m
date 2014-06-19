From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 35/48] refs.c: remove the update_ref_lock function
Date: Thu, 19 Jun 2014 08:53:17 -0700
Message-ID: <1403193210-6028-36-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxef8-0006a7-Hm
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758110AbaFSPx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:58 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:52181 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758069AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so692555ieb.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4K292YzQ8Pl5+vw66YWmanG7i82ydbUL/mID0d5OKVM=;
        b=nE++UIu3fk32kkQ/f1tUD7eYE6AykPzt8K1cUT5LgnTojgXTWHDLFcWjFr0Y1ZJ+44
         TPsR3xj6+4GeA8rGc8Qfti4exk3SrPzPMXfZ4BjOkk3aeOBZS82DOijeVKMyyI3oG+EW
         MB0iMOq1QmZIZo+BsJhhh/OjwYmRoaydzuh5yuMidFYYtfrNX35bH7TSThYEiVbmvW+/
         iaKUpkLx84fbbSMpcMoI+HX7hB7fW7PGwqEDdMpfGDTmI+9cHeUvQZnqoRsAg8ywECMa
         ARX0g4U3f93elZzx4c1jqc406dNq3v2uB6Rb0H28v2oLGZyG8NSVWybXCV6VVQmdgfRB
         sXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4K292YzQ8Pl5+vw66YWmanG7i82ydbUL/mID0d5OKVM=;
        b=P7yOsZY5YJBDysJyUeoGxHZQl2KagPx6syzwPf32VGF9XsGTQLhiovegvO9jB29d4R
         7Im10R0R2u5zn1QBPJs7aEmt4sX2y7xROaT965/91VmVbuhN0KCiFwRnvhDIFdQwuZ98
         DCTuTStfEH2Zqy5W/ia7aUgC2suWJamMoM2kLXcI8DPV0wD44mWtOGgLroGfHwnW7rn4
         GfegrzFgXkC16/WCrS1KABZpurTUz/1AQj4HXPzKCWjFKrv61O8UfTbd+e+zV74hlPEL
         Ty5tdFUuq7YCadcZE1BO1vPMn+hHcRfV3iK3koku9paHsEEavC6UZmhnBZYylPJkL0tw
         KG5Q==
X-Gm-Message-State: ALoCoQk/xtNNTdC5D3v+N09ENkFWaj9pXbCeN+0auu5XVLfyTxQyG8T/YhdhObcSox454NcFO85E
X-Received: by 10.50.12.7 with SMTP id u7mr4702383igb.5.1403193214243;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si419495yhk.4.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 19B6331C2E6;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ECA73E033F; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252122>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index db8e0a0..b063baa 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,24 +3333,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3600,12 +3582,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.438.g337c581

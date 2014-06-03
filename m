From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 28/41] refs.c: remove the update_ref_lock function
Date: Tue,  3 Jun 2014 14:37:46 -0700
Message-ID: <1401831479-3388-29-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:38:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwPe-0005YP-EM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934344AbaFCViW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:38:22 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:33007 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934244AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1408538yhl.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6MJpoi6m+wjjwND4pV2giolM1ZuRYHHFACaEV4T7XtI=;
        b=IaFzhR1kG3kohomVi08MzOcVtpJQAT9RTNyDRTzXwpYo/fgQZ+vFzww26a4Yh6ian0
         uOEIglCY2yDS7rIsWDztAvZvVdhEFl5MXwiBK5AvPDFJs3Gf3wGDjtnA/A2lzZgm6YiT
         hUc35b4q1OoDjgpDaC0nCY4E3FtHM2WuyaJ62aIMS356h81dqw07xxq/D/xaBdf1tH1f
         PbMgg6bPgP16jcL4if/mcVecdn615O4P/osP6icu63akeyqIepproX1kcAdOgM/3vC88
         yLz5jduQer5vjlzbQ0DoSyWgBeiCQ6ODU45g1vvitQTT0U37U45mQqu5g2PCBaXh9QDl
         Izgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6MJpoi6m+wjjwND4pV2giolM1ZuRYHHFACaEV4T7XtI=;
        b=msPy2CRcnPKfHx1rSDAI9Ze6JW4oKLaeQdFBqMtLAowcDE5mLwUov2AiQswURXLbyO
         ru1ujpNCxa6/rA8oaD+1TjhvGK9LVhk8HIxawm3JM5n6tih7kvdz2aCcudgp3u+tzlD0
         PjHM/fTYbjGEnDBCv0vUBuwYaEBcSB2wTbH6DIecwp4KtUe1ykCDcrMUQTFKwXjwlLVQ
         dIfhlIVUx9Txq7vbW5gySBC7cfsNk7lBacMlCJGI33W71te3lUrNh1UFEy2Z3EZMnrUm
         dYfq6LDsr8eM6PxLYA9CxBN25wxGZ3btv0vHChJF7E+eBR1zWhtSgV/7F5+Us3ZHIWbj
         en9A==
X-Gm-Message-State: ALoCoQlpY1gCKFiwFoR2u7AgC9msZy/Q4l4RehpC3xrG4JYViDJBszS+CAR6KnzPC1n8J+nciiV2
X-Received: by 10.236.135.145 with SMTP id u17mr17040377yhi.44.1401831487974;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si29583yhk.4.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CF43231C45F;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ABD3BE07FA; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250652>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index d2fd419..3796957 100644
--- a/refs.c
+++ b/refs.c
@@ -3323,24 +3323,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3590,12 +3572,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.567.g64a7adf

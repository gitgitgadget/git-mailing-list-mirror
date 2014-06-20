From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 35/48] refs.c: remove the update_ref_lock function
Date: Fri, 20 Jun 2014 07:43:16 -0700
Message-ID: <1403275409-28173-36-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy04v-0003ML-F7
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbaFTOpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:45:43 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:49344 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbaFTOne (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:34 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so978015oag.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gJ2ZhryomeJvdfyBU6hXu+LSuihhD46gfTtBgvlp62Y=;
        b=jGAHSakVPhZfYI2XjO/xsXOMw88pchvjKlfdaJUWkgoNw70x10V8sGYeJZW9T3IN2o
         rU7pF+ykGGqsG8jrXd+CRIeM2+tnTs2D2o88T6RTdcr5HkSIQ61kb9SaLpy4iJCMcuTr
         Rp8mrrvphiKIYY5DB0zrC+9Nb990rkPsZPbq9eL7tA2ThZiXMADzeSR20wNuBCukP/85
         agbPnQFZtWI2ABKf7zHF8aFsb+Y7yv3F6ZGHhYGgvk62ijfrLbP0vply+JMQMpkzLXMN
         LM7WLal7IlFgeoN0rUuTLUywQgbq8Wo20MBld3lFXUrkmCj2BHPHiLG5oWAK64C4AWJW
         qlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gJ2ZhryomeJvdfyBU6hXu+LSuihhD46gfTtBgvlp62Y=;
        b=Ii6wLI6QBkHDZB0uZnupF1CB4nq+U5rK0ikTLrONQ8p+tYNgM2/iKUYQhrADVrXLGo
         vbgHVVk1RNNalkp62XjYjdFOjKeqOi3fSQtaP801JQCQB0VBAEMkc/uz06EG/TbfRzwA
         tIGyxSQzM18dVcu5Q5Fa7T478gs/3KhUnis1d42GC2LNqvObldLf6AFI/sRqxtRTDNWS
         3baElcm6JAaBfD0TuEpQTXqesHU9PN+V2JE5S3S2Rq9IJgc2pppWVADt3qsZU9syYMl7
         Eyh7Tilfe34yHdwm4iF+qIxfjWx6fptJcK+mS+jC7qaYNYdkPrIWo7K3UlZvpDi54yLd
         vnNQ==
X-Gm-Message-State: ALoCoQkascK6p+0TjTed6sVXqMStzTLr+4pBp1mMALleW6+QLVa73PqTt4DdJlLKdsBsD/de3x/3
X-Received: by 10.182.98.167 with SMTP id ej7mr1536579obb.45.1403275413519;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si591926yhe.2.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5EF715A43E3;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3BB8AE0873; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252255>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 456acdd..8fb0a9e 100644
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
@@ -3603,12 +3585,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.420.g181e020.dirty

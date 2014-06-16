From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 36/48] refs.c: remove the update_ref_lock function
Date: Mon, 16 Jun 2014 11:04:07 -0700
Message-ID: <1402941859-29354-37-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbHu-0004b7-U0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbaFPSFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:31 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:46278 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-ob0-f202.google.com with SMTP id va2so1139081obc.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nOhc+0Oyao03b8VWqs0+elYruwAXyK+du2c0uuDu93U=;
        b=ULomu1LBD7tFjBAt1wED2EDOcHKlIYPazMJgy9xB7zi02obiObkMBH6TxngNR1p/jl
         MEogoDX3kVQfOdm9w/v5/rY7jqnLO2LwYUkiUjTZKLHXcIur0OzzzTAe2EQD/rtLqC0q
         qoeWxSyMXwc3ky1hYvEtrYK0i4Iv+tm3OlRuCx/tfGx9wIsd7JxFBZDM/151b6ekxmCW
         MW1NGSVC8wB5hmvWbsZac8mp6+ONSocylecwj9c8K8yDQLbmhp03LxpWg4ySbEdjf4Kc
         jLNAnMX1t63qf+oCLZYaP0tERWywwwETZd1BKY9skc0aaAiXKZ511lrLO9UfYCyzBKVW
         VEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nOhc+0Oyao03b8VWqs0+elYruwAXyK+du2c0uuDu93U=;
        b=hTnccDQEWpTmC5OwH1QgDMTCNKTAG3apzL/joxQippCPp63kBsC7Eqf21YTCepiqAW
         AkS0S+8l3TffO9ux5xkm8UAgDnWTb6D8r06VCGllqE97i0FSz4r7wqjqi9iDdILkC01F
         A0VymHSUxMo2ik1AixmTAiJctm6cHN/34TsP/xN+eKynmq5gmODROt0dMzK/ftMcgKuq
         7ipyVan2o65j/UNblEB1boWhF6KEKJkYXMCFYSWzHbKWZm5VrSKSEjAba7IeTu6Tf1XN
         yj2GmSp1oj7V5EqG7Bo0FCs4+Zub9J2FmFYLTLiGlap9O5/SErxIclDtIuxHkW4bbf8R
         HGBQ==
X-Gm-Message-State: ALoCoQnmeVsCojBVbBT3IxjsVSHM+4FrM5406W6XDytbZ88X7TwE/XB+z2re6vII8Rr1+MF+G8nm
X-Received: by 10.182.119.194 with SMTP id kw2mr446349obb.27.1402941863710;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si997135yhj.5.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 8EE365A4912;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6F5A7E0CFF; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251752>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index bb12e65..8fe7877 100644
--- a/refs.c
+++ b/refs.c
@@ -3330,24 +3330,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3597,12 +3579,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.282.g3799eda.dirty

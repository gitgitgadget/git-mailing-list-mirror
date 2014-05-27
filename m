From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 28/41] refs.c: remove the update_ref_lock function
Date: Tue, 27 May 2014 13:25:47 -0700
Message-ID: <1401222360-21175-29-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxj-0003CU-GT
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbaE0U1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:02 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:48436 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so845150vcb.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwKs6k6Bbz/j7HYOQT1w/nBt7b4O4zbsacxKAGv5SII=;
        b=M3tw3gpcJPrVhCXlCBeTQfLYSM4lyjPy5l2Gf62M1bWwZ4SGpk1zduruIJEj1nLBC2
         is6iWmBrcEwBCjW8aSZxkABN7EnmYIQ9X89GcxvBJVcP5shJpp0nOuQKdV0bS20pAlmC
         QpBsAdbP+uIJpyy6aTCNqHeYFofPPkQ2Nz/HyS4Cws7Uf77UpOUZQ0I5LzJWKDy9lXEA
         KzUvEhkXKTBOJeEIneQRsVEelUKskIaz4WBZLcMIrxkaIiKiP4XGrpISyjOXmthWQqLT
         2R7sJOP4plKlrIF6rbMpxW1+WANiJASEhjVndDkm5br1Wyq0ySdYv1suq6La9QHyQy2D
         G1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwKs6k6Bbz/j7HYOQT1w/nBt7b4O4zbsacxKAGv5SII=;
        b=MDiGdSzBzORF6dirl7CG2Uuu4Cax2C9T9JLRjlbtClQTrbHhoTugfIhJHNXtlREwKp
         swvZYpmdymZAPBJKk2cx2KWuEh2SPDE3L7j9NYHXxoYa81pYqAGhQL6L6wPcZaX8tz1o
         ScJA2z4ihKaGu1MfDBAel9TjfTu7V3fzxEetlTuti8Afi7k4fd3AvavwcpPP25h30uny
         8+1Z7krVN1qPWPaV+XfPCQAtArrz+LcAauRgZgWkKrPGROVk6oTFzZ4zBHe0LV+yiq9t
         01/JOHuZKzLCGxftzhnUl+YjZPqqC1IxWuQ4YVhSXqBd0e3Vt9wgi7Re0FzYXc3ml/iS
         2wyQ==
X-Gm-Message-State: ALoCoQnPqGYn8z/rC7xmd8ysfoR7hiONHhGZmcN8wjTC6Vn43RoKTdpK8TKk6s+XCJOzCae5QeoQ
X-Received: by 10.236.159.39 with SMTP id r27mr13890843yhk.7.1401222364944;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si1575171yhq.3.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B6DAE2F4ACE;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 97074E1081; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250211>

Since we now only call update_ref_lock with onerr==QUIET_ON_ERR we no longer
need this function and can replace it with just calling lock_any_ref_for_update
directly.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/refs.c b/refs.c
index 01d8ac4..0f82cdb 100644
--- a/refs.c
+++ b/refs.c
@@ -3281,24 +3281,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
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
@@ -3550,12 +3532,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.474.g0203784

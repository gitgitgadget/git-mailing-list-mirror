From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 29/40] refs.c: remove the update_ref_write function
Date: Fri,  6 Jun 2014 15:29:07 -0700
Message-ID: <1402093758-3162-30-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2ff-0003Mw-Db
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaFFWag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:36 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:45403 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so742702oah.0
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MMWctbDa9f50HUuTc4KJcRruy9DKxhSDaI9ni5bRO2Y=;
        b=lJ/4zvVxE8xS/vxJSx/KpPlSRDCn7gNxdIRSFpt7u0LRVyw6hfrPpIRzUU9i/2quD1
         2gZDR6WA4A8VZo6kkxF5V4QIoHW72InTB0HwDoh9I4PLVbhK+0D5KVEsMKaIBoFSKhmH
         WO5PnT55yIXP1SjtPxVZ8bFCIEKBQ+T8/gV2+JU21HPOk08YKPh0bM25k3/V8sUYSniB
         Eq1I2W/THDMyR52SdHJ6rwNt2lxTKvY6/G2pWGQcLwVpzfiLoNxvKkS4SBlPO3sioluS
         3nd894nQPckWz65/Uv5rbOcFHRG6G/STLM3JnMys1S9E+KO0B5ZI8IzxWoU9FRyHv3Kg
         yaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MMWctbDa9f50HUuTc4KJcRruy9DKxhSDaI9ni5bRO2Y=;
        b=HsuDQWKaxt+uEEEMfUCVquQ5gQdCjeeVOSlDFBgr3Z78nmH/CgQx7v0sFQQayzpOb7
         wsVIo0rLtxTDSE3Foh6duhIbDAtjc37EbrGywYWKRl2wPdU0C8iRlR+dn2CzqW8p9u1w
         cPV6Cm+9HhMIaQkEbNNRAS+p6Vewz3S428Nlw0mwcys4ghFousTp+R+3Riib711tmEuw
         OxpI4FTJN27BC4GqKoR0trs+VUPw/WR26Tt9FCTqm+KJz+x16yTd6JoLNYKKWUd4kkck
         BFqbIDYzzZD5rLoQDUX71iNC+6Huq5Bk+YTWIReMYFERT/uyy6qzfESmyCiTrHMCWIOc
         QUuQ==
X-Gm-Message-State: ALoCoQlyD5wXCZKK3PKGeDZRCbIDCaFPImM8hIVK43KuawDFrydljig+ciCgQpBMeUhZAelloSvr
X-Received: by 10.43.66.6 with SMTP id xo6mr1499348icb.33.1402093763160;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id pr8si750963vdb.1.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E1CBF5A450E;
	Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BE3F1E0878; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251003>

Since we only call update_ref_write from a single place and we only call it
with onerr==QUIET_ON_ERR we can just as well get rid of it and just call
write_ref_sha1 directly. This changes the return status for _commit from
1 to -1 on failures when writing to the ref. Eventually we will want
_commit to start returning more detailed error conditions than the current
simple success/failure. For example if the commit failed due to name
conflicts etc.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 3796957..245c540 100644
--- a/refs.c
+++ b/refs.c
@@ -3323,25 +3323,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-static int update_ref_write(const char *action, const char *refname,
-			    const unsigned char *sha1, struct ref_lock *lock,
-			    struct strbuf *err, enum action_on_err onerr)
-{
-	if (write_ref_sha1(lock, sha1, action) < 0) {
-		const char *str = "Cannot update the ref '%s'.";
-		if (err)
-			strbuf_addf(err, str, refname);
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
-		}
-		return 1;
-	}
-	return 0;
-}
-
 /**
  * Information needed for a single ref update.  Set new_sha1 to the
  * new value or to zero to delete the ref.  To check the old value
@@ -3592,14 +3573,16 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			ret = update_ref_write(msg,
-					       update->refname,
-					       update->new_sha1,
-					       update->lock, err,
-					       UPDATE_REFS_QUIET_ON_ERR);
-			update->lock = NULL; /* freed by update_ref_write */
-			if (ret)
+			ret = write_ref_sha1(update->lock, update->new_sha1,
+					     msg);
+			update->lock = NULL; /* freed by write_ref_sha1 */
+			if (ret) {
+				const char *str = "Cannot update the ref '%s'.";
+
+				if (err)
+					strbuf_addf(err, str, update->refname);
 				goto cleanup;
+			}
 		}
 	}
 
-- 
2.0.0.582.ge25c160

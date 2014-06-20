From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 18/48] refs.c: remove the onerr argument to ref_transaction_commit
Date: Fri, 20 Jun 2014 07:42:59 -0700
Message-ID: <1403275409-28173-19-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:47:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy060-0004ZO-NC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbaFTOq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:57 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:55022 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-ob0-f201.google.com with SMTP id nu7so192245obb.2
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uvoXlxttzC8lc61+IjoBXPIGO63cpOnnc/JK9pzcLVM=;
        b=hrZShblTtg6EoUhPuV8lNqidSS9woItRprdG3K3zNZoTtgbFNy9cQF5X5YLQS6HpfI
         vckdClGeUhCVyOGwK/ja+ThbNpuPnqYwqcvJqe+RWxzSrCS3Hl5qWJ7lzrpnqJt5VFSH
         FrBBDFiI7sFF64CJvFsETNIagErQe2rN/qyAKvLp6wt1YLZcYDOrYqRxl4XbypmDadjX
         JfDaNXFOUV5leQ847MKUqLQjdrZ1YA8vvo4rqM4m9qczwQrauMWeQswlmt45q5Q8p9Ie
         b7CsEVReH3zzbe9ildw/0ogi3i/mGx+EnZo+GqZZ4xtLsGyh1aEevGnayOMBLONi7hAM
         phKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uvoXlxttzC8lc61+IjoBXPIGO63cpOnnc/JK9pzcLVM=;
        b=Tq+nwJYEc2tfX5xqizQ6LUVeFXIr0OvDNwIxZvHVZwhkbdw2cobWWNsc6RBqqU5FI3
         DXZFbPSLs5/ZWVyaOr42eQih+xJy/y+EF2lpFIEwdZ/zbgoFea+fqbf0XC9igauMUNPY
         WQm/Sp1BTXI5IsGlrRbGyJO7PdRJ8XijboQnTUfz80VPUPo8S0HFHmeEGQzabVUVXOim
         TB2oFkHr5njtLZj3lE67stqfSqS4+9whWAYqXOYBrbrFL17LwhODNmlJoxBaM3J9LPJN
         wBTIQW6ZJ0HQgdaZOuguDRvtdSbU0rxZDOgzFz8V6BkiTpv6yT0QWD61/ZodR0FnDDkK
         OaSw==
X-Gm-Message-State: ALoCoQldjOL4y5FVZiwxgTm7Fqvm/P6PQ1XDuB0YfQ4yO+lAOOw99rhSD+JBFWOpcfzO9LIOy++8
X-Received: by 10.182.87.3 with SMTP id t3mr1547039obz.20.1403275412806;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si663235yhl.7.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 842905A43E3;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 621EAE08AF; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252274>

Since all callers now use QUIET_ON_ERR we no longer need to provide an onerr
argument any more. Remove the onerr argument from the ref_transaction_commit
signature.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  3 +--
 refs.c               | 22 +++++++---------------
 refs.h               |  3 +--
 3 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aec9004..88ab785 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -366,8 +366,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err,
-					   UPDATE_REFS_QUIET_ON_ERR))
+		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		return 0;
diff --git a/refs.c b/refs.c
index 003b313..4f78bd9 100644
--- a/refs.c
+++ b/refs.c
@@ -3491,8 +3491,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
-					struct strbuf *err,
-					enum action_on_err onerr)
+					struct strbuf *err)
 {
 	int i;
 	for (i = 1; i < n; i++)
@@ -3502,22 +3501,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 			if (err)
 				strbuf_addf(err, str, updates[i]->refname);
 
-			switch (onerr) {
-			case UPDATE_REFS_MSG_ON_ERR:
-				error(str, updates[i]->refname); break;
-			case UPDATE_REFS_DIE_ON_ERR:
-				die(str, updates[i]->refname); break;
-			case UPDATE_REFS_QUIET_ON_ERR:
-				break;
-			}
 			return 1;
 		}
 	return 0;
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr)
+			   const char *msg, struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3532,7 +3522,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, err, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err);
 	if (ret)
 		goto cleanup;
 
@@ -3544,7 +3534,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       (update->have_old ?
 						update->old_sha1 : NULL),
 					       update->flags,
-					       &update->type, onerr);
+					       &update->type,
+					       UPDATE_REFS_QUIET_ON_ERR);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
@@ -3562,7 +3553,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, err, onerr);
+					       update->lock, err,
+					       UPDATE_REFS_QUIET_ON_ERR);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
diff --git a/refs.h b/refs.h
index e588ff8..163b45c 100644
--- a/refs.h
+++ b/refs.h
@@ -282,8 +282,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, struct strbuf *err,
-			   enum action_on_err onerr);
+			   const char *msg, struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.420.g181e020.dirty

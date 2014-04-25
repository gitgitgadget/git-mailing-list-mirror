From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 19/19] refs.c: pass **transaction to commit and have it clear the pointer
Date: Fri, 25 Apr 2014 09:14:54 -0700
Message-ID: <1398442494-23438-20-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:15:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdimv-00076U-HT
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbaDYQPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:21 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:65421 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779AbaDYQPK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:10 -0400
Received: by mail-oa0-f73.google.com with SMTP id m1so916481oag.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1T04dX8BMJa9N2iqdFPIpqKIYip2awEJKlbozGBVs0=;
        b=Ho3bfcZ4k7dhb1KzgmsLQdvBwdCmXjOA2GKb+j0JTFsC48jrjKjaBcXXRBjq3dCSjx
         HtdlI+ajUM/bVefGvo2hT3Bvojx1BWaWO2WwyzRXcCbzVUh0xPrUV8FJsxFqCKL8K00w
         wcaHT7XIeOk6449UWs5avKac6+5/ganMK2CH85tT3S99JHT4Na3tncat4aCznzVusSgt
         gFMQP86BQNxfXzcl744jKBMzewsUJpdxbBM1lKReuF0nBafqvUUcNQPlq73U0nJBl5no
         bmj7Hj+A0jyo1G84P/7ibncow9idleVr7ItufGPk8TIfjktWoNdwRlXKCzpeIIRO5RZx
         c/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B1T04dX8BMJa9N2iqdFPIpqKIYip2awEJKlbozGBVs0=;
        b=C589i49cZaVA0U5QOD6z8kEUN+YlpxJn3vfftO8/dzvvcGxTMXX3X4V3cVrfJ8q1tw
         xCRMkr3Qym72lxNsB5yp2hy5Ry0UTW4TlaVLS4vb23mKphyv8nsw25QiwMoq1k2IQENw
         Qp1bjAEM0R4FWPaVYLwh/VG6CuuzALBpO6ojsNbYnRPRYRogCz+ec6pJ60eIP5+NaqXL
         XSnp3SFUGLvGr+8Q2yvqRCd46n3cvmFo6Ge80zd1PH5YMWXIVYNm6ZxSwoyr7SfgyU3W
         QudU0FaoJZpWn1D9HkWhO0+8MViERM6gVcCUVzJd8kn5sZz5vtj9VZT4LMVoFAYSB2VM
         JVSg==
X-Gm-Message-State: ALoCoQk+frdlzpJx2W6w65nPGEjNpUaEKYXHkc5dveVib/SM6TO0rbfQl4WWjFMzLMZHzS91N66femUWy0LFocBo0b+HAISBlNmEtsL6BxjILigfEFgwVjQv73guOQyKPQiSfFBEOILXE2ZypeM4dnSTi/EGyWGD08x3zDMP6kRQj/GIqeSs2jP+sOdwW1io2HSOjZ+zBD/0
X-Received: by 10.43.158.9 with SMTP id ls9mr4555059icc.18.1398442509432;
        Fri, 25 Apr 2014 09:15:09 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si1050746yhk.4.2014.04.25.09.15.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 381F531C028;
	Fri, 25 Apr 2014 09:15:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DE40BE0855; Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247055>

Change ref_transaction_commit to take a pointer to a pointer for the
transaction. This allows us to clear the transaction pointer from within
ref_transaction_commit so that it becomes NULL in the caller.

This makes transaction handling in the callers much nicer since instead of
having to write horrible code like :
	t = ref_transaction_begin();
	if ((!t ||
	    ref_transaction_update(t, refname, sha1, oldval, flags,
				   !!oldval)) ||
	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
		ref_transaction_rollback(t);

we can now just do the much nicer
	t = ref_transaction_begin();
	if (!t ||
	    ref_transaction_update(t, refname, sha1, oldval, flags,
				   !!oldval) ||
	    ref_transaction_commit(&t, action, &err)) {
		ref_transaction_rollback(t);

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c             |  4 ++--
 builtin/commit.c     |  2 +-
 builtin/replace.c    |  2 +-
 builtin/tag.c        |  2 +-
 builtin/update-ref.c |  2 +-
 fast-import.c        |  7 +++----
 refs.c               | 18 ++++++++++--------
 refs.h               |  3 ++-
 sequencer.c          |  7 +++----
 9 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 23cde1e..5d68467 100644
--- a/branch.c
+++ b/branch.c
@@ -303,14 +303,14 @@ void create_branch(const char *head,
 			if (!transaction ||
 			    ref_transaction_update(transaction, ref.buf, sha1,
 						   NULL, 0, 0) ||
-			    ref_transaction_commit(transaction, msg, &err))
+			    ref_transaction_commit(&transaction, msg, &err))
 			  die_errno(_("%s: failed to write ref: %s"),
 				    ref.buf, err);
 		} else {
 			if (!transaction ||
 			    ref_transaction_create(transaction, ref.buf, sha1,
 						   0) ||
-			    ref_transaction_commit(transaction, msg, &err))
+			    ref_transaction_commit(&transaction, msg, &err))
 			  die_errno(_("%s: failed to write ref: %s"),
 				    ref.buf, err);
 		}
diff --git a/builtin/commit.c b/builtin/commit.c
index 7e4c306..3142827 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1682,7 +1682,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				   current_head ? 
 				   current_head->object.sha1 : NULL,
 				   0, !!current_head) ||
-	    ref_transaction_commit(transaction, sb.buf, &err)) {
+	    ref_transaction_commit(&transaction, sb.buf, &err)) {
 		rollback_index_files();
 		die(_("HEAD: cannot update ref: %s"), err);
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index cf0f56d..51e9ddf 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -162,7 +162,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
 				   0, !is_null_sha1(prev)) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+	    ref_transaction_commit(&transaction, NULL, &err))
 	  die(_("%s: failed to replace ref: %s"), ref, err);
 
 	return 0;
diff --git a/builtin/tag.c b/builtin/tag.c
index dd53fb4..60b57a1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -646,7 +646,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
 				   0, !is_null_sha1(prev)) ||
-	    ref_transaction_commit(transaction, NULL, &err))
+	    ref_transaction_commit(&transaction, NULL, &err))
 	  die(_("%s: cannot update the ref: %s"), ref.buf, err);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a600ab3..4a0901d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -373,7 +373,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, msg, &err))
+		if (ref_transaction_commit(&transaction, msg, &err))
 			die("update_ref failed: %s", err);
 		return 0;
 	}
diff --git a/fast-import.c b/fast-import.c
index a2b05fa..3ce2f47 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1703,11 +1703,10 @@ static int update_branch(struct branch *b)
 		}
 	}
 	transaction = ref_transaction_begin();
-	if ((!transaction ||
+	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1)) ||
-	    (ref_transaction_commit(transaction, msg, &err) &&
-	     !(transaction = NULL))) {
+				   0, 1) ||
+	    ref_transaction_commit(&transaction, msg, &err)) {
 		ref_transaction_rollback(transaction);
 		return error("Unable to update branch %s: %s", b->name, err);
 	}
diff --git a/refs.c b/refs.c
index ffa9c83..0b60250 100644
--- a/refs.c
+++ b/refs.c
@@ -3401,10 +3401,10 @@ int update_ref(const char *action, const char *refname,
 	char *err = NULL;
 
 	t = ref_transaction_begin();
-	if ((!t ||
+	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval)) ||
-	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+				   !!oldval) ||
+	    ref_transaction_commit(&t, action, &err)) {
 	     const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_rollback(t);
@@ -3444,16 +3444,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
+int ref_transaction_commit(struct ref_transaction **transaction,
 			   const char *msg, char **err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
-	int n = transaction->nr;
-	struct ref_update **updates = transaction->updates;
+	int n = (*transaction)->nr;
+	struct ref_update **updates = (*transaction)->updates;
 
 	if (!n) {
-		ref_transaction_free(transaction);
+		ref_transaction_free(*transaction);
+		*transaction = NULL;
 		return 0;
 	}
 
@@ -3527,7 +3528,8 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
+	ref_transaction_free(*transaction);
+	*transaction = NULL;
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 8135131..85127f2 100644
--- a/refs.h
+++ b/refs.h
@@ -270,8 +270,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * problem.  The ref_transaction is freed by this function.
  * If error is non-NULL it will return an error string that describes
  * why a commit failed. This string must be free()ed by the caller.
+ * *transaction is reset to NULL in this call.
  */
-int ref_transaction_commit(struct ref_transaction *transaction,
+int ref_transaction_commit(struct ref_transaction **transaction,
 			   const char *msg, char **err);
 
 /** Lock a ref and then write its file */
diff --git a/sequencer.c b/sequencer.c
index 7d59f58..3f6eced 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -283,11 +283,10 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
 	transaction = ref_transaction_begin();
-	if ((!transaction ||
+	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn)) ||
-	    (ref_transaction_commit(transaction, sb.buf, &err) &&
-	     !(transaction = NULL))) {
+				   0, !unborn) ||
+	    ref_transaction_commit(&transaction, sb.buf, &err)) {
 		ref_transaction_rollback(transaction);
 		strbuf_release(&sb);
 		return error(_("HEAD: Could not fast-forward: %s\n"), err);
-- 
1.9.1.521.g5dc89fa

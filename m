From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 16/31] refs.c: add an error argument to create/delete/update just like commit
Date: Wed, 14 May 2014 15:13:15 -0700
Message-ID: <1400105610-21194-17-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRL-00076W-7w
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbaENWON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:13 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:47739 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaENWNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:38 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so47541qcv.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m8Tp7S4hSFr0pp1/1BrIhoEXTVuxxa1FcbvJsmrAHsU=;
        b=M3yCVmJMOJ2ToxEkE/OIkWhagw/vY5LIto6ESx5SGK5T1PxB3xm9qge3wLi6O1pafI
         Z5n3QHaWtjJvbG36BonMSgDx4eSxyHh4FeXQDWIFQ4wcH8rx+0Sif7tbgOJ8HW9HPpqM
         /vyVHe0ivuPoL0uBEzGAAVFyZQtI2VcZq2q3WeiIpFM252JUir1iwoWyYz7YSWE+sKRV
         LLI9szB7c64KD/FgJJ2CtykE/TaJcKSjZm9pnQ1ugYf2eBA78NAA092wFdNi2KYpdoJi
         kM3n56AwsQP7gzSEjOXavnb6oifRP2I5pe16VazNGQEclGrGtHP/tqeaUAqzK0d1G6za
         WMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m8Tp7S4hSFr0pp1/1BrIhoEXTVuxxa1FcbvJsmrAHsU=;
        b=aBrg8rt0tFndmqfUpLVsT4udXG7Fvh/Z082uUmcinJd0xNEvGkULsc7DCf78QT1jAo
         yqSnHET4WV9ar0Sfhq/9Z6tltzS/kV2vuJhibZt20YZD7kTtUMtCGMuIdYKGsR4E8Ukh
         daLlFqwfKj74DOkMIAv3mNu5fhq3lZ8YKtaXFmGyTaFAZAA1ZsYLRCv3u88O/vWLWdS0
         +KdNN3jh5EHOoJKMc76EmFjMLo5O6A0hWJHq/nkQyJuuWi/7ax/1jIto+1rIi+WbAvH9
         BHywFY674BXJisI5OC9XWWr9vfY6fDR9irbiKR/Gm6rZaSZHdOfzDg0dTfnyV5hmLKS3
         mfkQ==
X-Gm-Message-State: ALoCoQlClrRIjPI0Qr/p7qe2y0gt0uIMdQ8mU62M9oL0g3dzLvuHKwqa2lGw6j8OIv6AZ1XjVjny
X-Received: by 10.236.39.175 with SMTP id d35mr2672753yhb.12.1400105618011;
        Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si152804yho.1.2014.05.14.15.13.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BC99731C1F8;
	Wed, 14 May 2014 15:13:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 81C29E0973; Wed, 14 May 2014 15:13:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249019>

Update the signatures for transaction create/delete/update and add
a strbuf err argument we can use to pass an error back to the caller.
We will need this later once we start moving checks from _commit to _update.
Change all callers that would die() on _commit failures to handle _update
failures similarly.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               |  3 ++-
 builtin/commit.c       |  2 +-
 builtin/fetch.c        |  2 +-
 builtin/receive-pack.c |  3 ++-
 builtin/replace.c      |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   | 20 ++++++++++++--------
 fast-import.c          |  8 +++++---
 refs.c                 | 24 ++++++++++++++----------
 refs.h                 |  9 ++++++---
 sequencer.c            |  2 +-
 walker.c               |  3 ++-
 12 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/branch.c b/branch.c
index 0a4d4f3..0b9fd61 100644
--- a/branch.c
+++ b/branch.c
@@ -301,7 +301,8 @@ void create_branch(const char *head,
 		transaction = transaction_begin();
 		if (!transaction ||
 		    transaction_update_sha1(transaction, ref.buf, sha1,
-					    null_sha1, 0, !forcing, msg) ||
+					    null_sha1, 0, !forcing, msg,
+					    &err) ||
 		    transaction_commit(transaction, &err))
 				die_errno(_("%s: failed to write ref: %s"),
 					  ref.buf, err.buf);
diff --git a/builtin/commit.c b/builtin/commit.c
index 386dfb1..fd61a8e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1721,7 +1721,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    transaction_update_sha1(transaction, "HEAD", sha1,
 				    current_head ?
 				    current_head->object.sha1 : NULL,
-				    0, !!current_head, sb.buf) ||
+				    0, !!current_head, sb.buf, &err) ||
 	    transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die(_("HEAD: cannot update ref: %s"), err.buf);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f74a267..e5e891f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -384,7 +384,7 @@ static int s_update_ref(const char *action,
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
 	if (transaction_update_sha1(transaction, ref->name, ref->new_sha1,
-				    ref->old_sha1, 0, check_old, msg))
+				    ref->old_sha1, 0, check_old, msg, NULL))
 		return STORE_REF_ERROR_OTHER;
 
 	return 0;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0461f93..777ecf8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -582,7 +582,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			return "shallow error";
 
 		if (transaction_update_sha1(transaction, namespaced_name,
-					    new_sha1, old_sha1, 0, 1, "push"))
+					    new_sha1, old_sha1, 0, 1, "push",
+					    &err))
 			return "failed to update";
 		return NULL; /* good */
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 2587a06..1598d69 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -160,7 +160,7 @@ static int replace_object_sha1(const char *object_ref,
 	transaction = transaction_begin();
 	if (!transaction ||
 	    transaction_update_sha1(transaction, ref, repl, prev,
-				    0, !is_null_sha1(prev), NULL) ||
+				    0, !is_null_sha1(prev), NULL, &err) ||
 	    transaction_commit(transaction, &err))
 		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 3739e23..9b6da6c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -705,7 +705,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = transaction_begin();
 	if (!transaction ||
 	    transaction_update_sha1(transaction, ref.buf, object, prev,
-				    0, !is_null_sha1(prev), NULL) ||
+				    0, !is_null_sha1(prev), NULL, &err) ||
 	    transaction_commit(transaction, &err))
 		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
 	transaction_free(transaction);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index f7e33bd..1b0c889 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -183,6 +183,7 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int have_old;
+	struct strbuf err = STRBUF_INIT;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
@@ -199,8 +200,8 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		die("update %s: extra input: %s", refname, next);
 
 	if (transaction_update_sha1(transaction, refname, new_sha1, old_sha1,
-				    update_flags, have_old, msg))
-		die("update %s: failed", refname);
+				    update_flags, have_old, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -212,6 +213,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 {
 	char *refname;
 	unsigned char new_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
@@ -227,8 +229,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create %s: extra input: %s", refname, next);
 
 	if (transaction_create_sha1(transaction, refname, new_sha1,
-				    update_flags, msg))
-		die("failed transaction create for %s", refname);
+				    update_flags, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -241,6 +243,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	char *refname;
 	unsigned char old_sha1[20];
 	int have_old;
+	struct strbuf err = STRBUF_INIT;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
@@ -259,8 +262,8 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete %s: extra input: %s", refname, next);
 
 	if (transaction_delete_sha1(transaction, refname, old_sha1,
-				    update_flags, have_old, msg))
-		die("failed transaction delete for %s", refname);
+				    update_flags, have_old, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -274,6 +277,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
 	int have_old;
+	struct strbuf err = STRBUF_INIT;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
@@ -292,8 +296,8 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify %s: extra input: %s", refname, next);
 
 	if (transaction_update_sha1(transaction, refname, new_sha1, old_sha1,
-				    update_flags, have_old, msg))
-		die("failed transaction update for %s", refname);
+				    update_flags, have_old, msg, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/fast-import.c b/fast-import.c
index 2fa1d29..24378d1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1710,7 +1710,7 @@ static int update_branch(struct branch *b)
 	transaction = transaction_begin();
 	if (!transaction ||
 	    transaction_update_sha1(transaction, b->name, b->sha1, old_sha1,
-				    0, 1, msg) ||
+				    0, 1, msg, &err) ||
 	    transaction_commit(transaction, &err)) {
 		transaction_rollback(transaction);
 		error("Unable to update branch %s: %s", b->name, err.buf);
@@ -1745,8 +1745,10 @@ static void dump_tags(void)
 		sprintf(ref_name, "refs/tags/%s", t->name);
 
 		if (transaction_update_sha1(transaction, ref_name, t->sha1,
-					    NULL, 0, 0, msg))
-			failure |= error("Unable to update %s", err.buf);
+					    NULL, 0, 0, msg, &err)) {
+			failure |= 1;
+			break;
+		}
 	}
 	if (failure || transaction_commit(transaction, &err))
 		failure |= error("Unable to update %s", err.buf);
diff --git a/refs.c b/refs.c
index b006238..59f1ca1 100644
--- a/refs.c
+++ b/refs.c
@@ -2364,7 +2364,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = transaction_begin();
 	if (!transaction ||
 	    transaction_delete_sha1(transaction, r->name, r->sha1,
-				    REF_ISPRUNING, 1, NULL) ||
+				    REF_ISPRUNING, 1, NULL, &err) ||
 	    transaction_commit(transaction, &err)) {
 		transaction_rollback(transaction);
 		warning("prune_ref: %s", err.buf);
@@ -2528,7 +2528,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	transaction = transaction_begin();
 	if (!transaction ||
 	    transaction_delete_sha1(transaction, refname, sha1, delopt,
-				    sha1 && !is_null_sha1(sha1), NULL) ||
+				    sha1 && !is_null_sha1(sha1), NULL, NULL) ||
 	    transaction_commit(transaction, NULL)) {
 		transaction_rollback(transaction);
 		return 1;
@@ -2633,9 +2633,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!transaction ||
 	    transaction_delete_sha1(transaction, oldrefname, sha1,
 				    REF_NODEREF | REF_ISPACKONLY,
-				    1, NULL) ||
+				    1, NULL, &err) ||
 	    transaction_update_sha1(transaction, newrefname, sha1,
-				    NULL, 0, 0, logmsg) ||
+				    NULL, 0, 0, logmsg, &err) ||
 	    transaction_commit(transaction, &err)) {
 		transaction_rollback(transaction);
 		error("rename_ref failed: %s", err.buf);
@@ -3410,7 +3410,8 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
-			    int flags, int have_old, const char *msg)
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err)
 {
 	struct ref_update *update;
 
@@ -3454,7 +3455,8 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 int transaction_create_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
-			    int flags, const char *msg)
+			    int flags, const char *msg,
+			    struct strbuf *err)
 {
 	struct ref_update *update;
 
@@ -3468,13 +3470,14 @@ int transaction_create_sha1(struct ref_transaction *transaction,
 		die("BUG: REF_ISPACKONLY can not be used with create");
 
 	return transaction_update_sha1(transaction, refname, new_sha1,
-				       null_sha1, flags, 1, msg);
+				       null_sha1, flags, 1, msg, err);
 }
 
 int transaction_delete_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *old_sha1,
-			    int flags, int have_old, const char *msg)
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err)
 {
 	struct ref_update *update;
 
@@ -3488,7 +3491,8 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 		die("BUG: delete on transaction that is not open");
 
 	return transaction_update_sha1(transaction, refname, null_sha1,
-				       old_sha1, flags, have_old, msg);
+				       old_sha1, flags, have_old, msg,
+				       err);
 }
 
 int update_ref(const char *action, const char *refname,
@@ -3501,7 +3505,7 @@ int update_ref(const char *action, const char *refname,
 	t = transaction_begin();
 	if (!t ||
 	    transaction_update_sha1(t, refname, sha1, oldval, flags,
-				    !!oldval, action) ||
+				    !!oldval, action, &err) ||
 	    transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
diff --git a/refs.h b/refs.h
index c552f04..ebe7368 100644
--- a/refs.h
+++ b/refs.h
@@ -244,7 +244,8 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
-			    int flags, int have_old, const char *msg);
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
@@ -256,7 +257,8 @@ int transaction_update_sha1(struct ref_transaction *transaction,
 int transaction_create_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
-			    int flags, const char *msg);
+			    int flags, const char *msg,
+			    struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -267,7 +269,8 @@ int transaction_create_sha1(struct ref_transaction *transaction,
 int transaction_delete_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *old_sha1,
-			    int flags, int have_old, const char *msg);
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err);
 
 #define REFLOG_TRUNCATE 0x01
 /*
diff --git a/sequencer.c b/sequencer.c
index 3f7996f..604df39 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -285,7 +285,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	transaction = transaction_begin();
 	if (!transaction ||
 	    transaction_update_sha1(transaction, "HEAD", to, from,
-				    0, !unborn, sb.buf) ||
+				    0, !unborn, sb.buf, &err) ||
 	    transaction_commit(transaction, &err)) {
 		transaction_rollback(transaction);
 		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
diff --git a/walker.c b/walker.c
index 3701c78..8630fcb 100644
--- a/walker.c
+++ b/walker.c
@@ -292,7 +292,8 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		if (transaction_update_sha1(transaction, ref_name,
 					    &sha1[20 * i], NULL,
 					    0, 0,
-					    msg ? msg : "fetch (unknown)"))
+					    msg ? msg : "fetch (unknown)",
+					    &err))
 			goto rollback_and_fail;
 	}
 
-- 
2.0.0.rc3.506.g3739a35

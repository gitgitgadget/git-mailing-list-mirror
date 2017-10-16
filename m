Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D587C20372
	for <e@80x24.org>; Mon, 16 Oct 2017 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdJPCPh (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 22:15:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58158 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751506AbdJPCPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 22:15:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0E9498AEE;
        Sun, 15 Oct 2017 22:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RKx/XUeHTTIuWmPTfjnfgFrfGzU=; b=q+6Ol2
        smVoPUMdAIAnSIsdtdEEVmUpMXkKGuLeYPDleS7nIz84YhYwVmwGru7YeTD8mc7p
        S5Vhv4LjV3oOhuCdsIoZ6S5nmHMVN3Tsx//59ZEoqFbzLQguEr4nuwcQfulAnD0I
        fnkA+7hxiRaMBm0hC8oN+AKmyzcAEi3xE0WCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nno9D7AZTXJQDEit6wyi15gvm0DPmeFZ
        T8IQ8Nr8B7l0pD6ujuUFlUoMI0F0TnKnK2LybNY5Gs3aVTPzjXWP44lMHAY/QnHp
        F4+oh6HT0INDfNKjmKiajBVBvduCPQQbCZDCrwSKH7+17v3jwJgw1HkM6MJaGUU6
        IhJeo2Kiuqs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E680698AED;
        Sun, 15 Oct 2017 22:15:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D9AB98AEB;
        Sun, 15 Oct 2017 22:15:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/25] object_id part 10
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
Date:   Mon, 16 Oct 2017 11:15:34 +0900
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 15 Oct 2017 22:06:47 +0000")
Message-ID: <xmqq8tgbu9bt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4EA5A82-B217-11E7-A80D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the tenth in a series of patches to convert from unsigned char
> [20] to struct object_id.  This series mostly involves changes to the
> refs code.  After these changes, there are almost no references to
> unsigned char in the main refs code.
>
> In this iteration, I chose to skip the ALLOC_ARRAY conversion to limit
> the scope of changes and because I think to be fixed properly the code
> requires converting the targets parameter to size_t, which involves
> touching more code unrelated to the series than I'd like to do right
> now.
>
> All the other issues that were brought up should be fixed.

With a hope that this might help other reviewers, here is the
interdiff between "the previous one merged with v2.15-rc1" and "this
round applied on v2.15-rc1 directly".  

The changes all looked sensible to me.  Thanks.


 builtin/checkout.c   |  3 ++-
 refs.c               | 10 +++++++---
 refs.h               | 28 ++++++++++++++--------------
 refs/files-backend.c |  8 ++++----
 remote.c             |  3 ++-
 sequencer.c          |  9 ++++++---
 6 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 88e841d6bf..a8e2849f8a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -662,7 +662,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	if (!strcmp(new->name, "HEAD") && !new->path && !opts->force_detach) {
 		/* Nothing to do. */
 	} else if (opts->force_detach || !new->path) {	/* No longer on any branch. */
-		update_ref(msg.buf, "HEAD", &new->commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
+		update_ref(msg.buf, "HEAD", &new->commit->object.oid, NULL,
+			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path &&
 			    advice_detached_head && !opts->force_detach)
diff --git a/refs.c b/refs.c
index 1af6ce1e1d..62a7621025 100644
--- a/refs.c
+++ b/refs.c
@@ -583,6 +583,9 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 	struct strbuf buf = STRBUF_INIT;
 	int ret = -1;
 
+	if (!oid)
+		return 0;
+
 	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 
 	filename = git_path("%s", pseudoref);
@@ -953,7 +956,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (!new_oid || is_null_oid(new_oid))
-		die("BUG: create called without valid new_sha1");
+		die("BUG: create called without valid new_oid");
 	return ref_transaction_update(transaction, refname, new_oid,
 				      &null_oid, flags, msg, err);
 }
@@ -965,7 +968,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (old_oid && is_null_oid(old_oid))
-		die("BUG: delete called with old_sha1 set to zeros");
+		die("BUG: delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      &null_oid, old_oid,
 				      flags, msg, err);
@@ -978,7 +981,7 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	if (!old_oid)
-		die("BUG: verify called with old_sha1 set to NULL");
+		die("BUG: verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
 				      flags, NULL, err);
@@ -994,6 +997,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	int ret = 0;
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		assert(refs == get_main_ref_store());
 		ret = write_pseudoref(refname, new_oid, old_oid, &err);
 	} else {
 		t = ref_store_transaction_begin(refs, &err);
diff --git a/refs.h b/refs.h
index d791eb2ed3..15fd419c7d 100644
--- a/refs.h
+++ b/refs.h
@@ -14,22 +14,22 @@ struct worktree;
  * at the resolved object name.  The return value, if not NULL, is a
  * pointer into either a static buffer or the input ref.
  *
- * If sha1 is non-NULL, store the referred-to object's name in it.
+ * If oid is non-NULL, store the referred-to object's name in it.
  *
  * If the reference cannot be resolved to an object, the behavior
  * depends on the RESOLVE_REF_READING flag:
  *
  * - If RESOLVE_REF_READING is set, return NULL.
  *
- * - If RESOLVE_REF_READING is not set, clear sha1 and return the name of
+ * - If RESOLVE_REF_READING is not set, clear oid and return the name of
  *   the last reference name in the chain, which will either be a non-symbolic
  *   reference or an undefined reference.  If this is a prelude to
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
  * If the RESOLVE_REF_NO_RECURSE flag is passed, only resolves one
- * level of symbolic reference.  The value stored in sha1 for a symbolic
- * reference will always be null_sha1 in this case, and the return
+ * level of symbolic reference.  The value stored in oid for a symbolic
+ * reference will always be null_oid in this case, and the return
  * value is the reference that the symref refers to directly.
  *
  * If flags is non-NULL, set the value that it points to the
@@ -46,7 +46,7 @@ struct worktree;
  *
  * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
  * name is invalid according to git-check-ref-format(1).  If the name
- * is bad then the value stored in sha1 will be null_sha1 and the two
+ * is bad then the value stored in oid will be null_oid and the two
  * flags REF_ISBROKEN and REF_BAD_NAME will be set.
  *
  * Even with RESOLVE_REF_ALLOW_BAD_NAME, names that escape the refs/
@@ -114,8 +114,8 @@ extern int refs_init_db(struct strbuf *err);
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
- * store the SHA1 of the referred-to object to sha1 and return 0.  If
- * any of these conditions are not met, return a non-zero value.
+ * store the object ID of the referred-to object to oid and return 0.
+ * If any of these conditions are not met, return a non-zero value.
  * Symbolic references are considered unpeelable, even if they
  * ultimately resolve to a peelable tag.
  */
@@ -511,14 +511,14 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 
 /*
- * Add a reference update to transaction. new_sha1 is the value that
- * the reference should have after the update, or null_sha1 if it
- * should be deleted. If new_sha1 is NULL, then the reference is not
- * changed at all. old_sha1 is the value that the reference must have
- * before the update, or null_sha1 if it must not have existed
+ * Add a reference update to transaction. new_oid is the value that
+ * the reference should have after the update, or null_oid if it
+ * should be deleted. If new_oid is NULL, then the reference is not
+ * changed at all. old_oid is the value that the reference must have
+ * before the update, or null_oid if it must not have existed
  * beforehand. The old value is checked after the lock is taken to
- * prevent races. If the old value doesn't agree with old_sha1, the
- * whole transaction fails. If old_sha1 is NULL, then the previous
+ * prevent races. If the old value doesn't agree with old_oid, the
+ * whole transaction fails. If old_oid is NULL, then the previous
  * value is not checked.
  *
  * See the above comment "Reference transaction updates" for more
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5976c0e65c..b7b9e767de 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -770,10 +770,10 @@ static struct ref_iterator *files_ref_iterator_begin(
 }
 
 /*
- * Verify that the reference locked by lock has the value old_sha1.
- * Fail if the reference doesn't exist and mustexist is set. Return 0
- * on success. On error, write an error message to err, set errno, and
- * return a negative value.
+ * Verify that the reference locked by lock has the value old_oid
+ * (unless it is NULL).  Fail if the reference doesn't exist and
+ * mustexist is set. Return 0 on success. On error, write an error
+ * message to err, set errno, and return a negative value.
  */
 static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 		       const struct object_id *old_oid, int mustexist,
diff --git a/remote.c b/remote.c
index cddc0fc479..3b6a800b80 100644
--- a/remote.c
+++ b/remote.c
@@ -1660,7 +1660,8 @@ static void set_merge(struct branch *ret)
 		if (!remote_find_tracking(remote, ret->merge[i]) ||
 		    strcmp(ret->remote_name, "."))
 			continue;
-		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]), &oid, &ref) == 1)
+		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
+			     &oid, &ref) == 1)
 			ret->merge[i]->dst = ref;
 		else
 			ret->merge[i]->dst = xstrdup(ret->merge_name[i]);
diff --git a/sequencer.c b/sequencer.c
index 8c0d66f018..a75d542a83 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1115,10 +1115,12 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	 * write it at all.
 	 */
 	if (command == TODO_PICK && !opts->no_commit && (res == 0 || res == 1) &&
-	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 	if (command == TODO_REVERT && ((opts->no_commit && res == 0) || res == 1) &&
-	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
+	    update_ref(NULL, "REVERT_HEAD", &commit->object.oid, NULL,
+		       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 		res = -1;
 
 	if (res) {
@@ -2121,7 +2123,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			}
 			msg = reflog_message(opts, "finish", "%s onto %s",
 				head_ref.buf, buf.buf);
-			if (update_ref(msg, head_ref.buf, &head, &orig, REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
+			if (update_ref(msg, head_ref.buf, &head, &orig,
+				       REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
 				res = error(_("could not update %s"),
 					head_ref.buf);
 				goto cleanup_head_ref;

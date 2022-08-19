Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708FC00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244358AbiHSDWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiHSDWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:22:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC11DC5F2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:22:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u22so3078347plq.12
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uXKCWVWtQjc1NdGCr3YIv96Jsg/UJxXiRI9uw1i1pOU=;
        b=m3Pwh2M2EmY7P364ZYpdM50/+fiTtHvC62GlyhVxlWvYoaDN66GHnKDHRiBZxJ/06O
         bcFdPTL2jHQmalrZ12CXCWbAjV3Bar7dS/9ekbr2WpsoJMwTPCLWMjzKKDwo1SfYfLjl
         /Vr9X3MVynM7qzvN0teZLPZ6BDrahCBazPiQNvS3YIWcLiTm7vkVYPRDyOhkXq6Pc+j4
         oodbGQEOO4HfZQ9fGDn4VPaB/2TuGIq72e1Ne6fT3LgtXgDyDkNBuho71/4ZOsbYFlR6
         SEnUmNgRzAmnCc41SPJlZeTLPT2RPY3zFjn4Jpc+v7zWMZv7P0P2ajdh9zZyinLuV+S0
         mAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uXKCWVWtQjc1NdGCr3YIv96Jsg/UJxXiRI9uw1i1pOU=;
        b=qb8pDYxC4EQgD7+tr+nO0l1XNxDxU6nJtExltPHL8ed8YdG0Wp825jLTebXl8vK/bs
         JbSXW5NI+u8QX1/W0Xhqzr8Fov3Tl/nLGhqmOnftWlF7b2kqwJShJEKQLxo5//ihU4tC
         wZC7qaRazSc/tXG7ZR/wnvnsAW9DsIhiNRnK1QrI0fBA4WhtNIU1DyXsquzMHCxbqPjL
         H6cq27/D29cq/LnZDbzVTLuszof9BNlZqNtSQgVjP0vcXcBq+2Tzwnj5cYEvkFQH8Djk
         dguBTjXHsA+AhVT4akcNrAYQABQv7k18UFJeh6+2t0GiE9yHTercu1QjrpadL3sxN/iZ
         kbyQ==
X-Gm-Message-State: ACgBeo2u78KFqovYAFPohGi2X87gEpryZ3b9mQDKTFupzh4RxjhVxbjM
        CzrGLddgHU9uV3BlyHiq6d5VO1L2BwE=
X-Google-Smtp-Source: AA6agR5VZG5mrySQHu9XbRMOwgRtRgNpxSHuy31GneczUBeYGIYztx6z3yVRuwh9mibDXuxluNxBnQ==
X-Received: by 2002:a17:903:31c9:b0:16c:3024:69c4 with SMTP id v9-20020a17090331c900b0016c302469c4mr5356443ple.81.1660879320748;
        Thu, 18 Aug 2022 20:22:00 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:22:00 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 9/9] refs: reimplement refs_delete_refs() and run hook once
Date:   Fri, 19 Aug 2022 11:21:47 +0800
Message-Id: <20220819032147.28841-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When using "git branch -d" or "git tag -d" to delete one or multiple
references, command "reference-transaction committed" will be called
repeatedly for the same references. This is because the function
"refs_delete_refs()" is called twice, once for loose ref-store and once
for packed ref-store.

The old story starts when running the function "refs_delete_refs()" on a
loose ref-store:

 1. Try to remove the references from packed ref-store.

    1.1. Lock the packed-ref-store by calling "packed_refs_lock()" in
         "files_delete_refs()".

    1.2. Call "refs_delete_refs()" on packed-ref-store, and then call
         "packed_delete_refs()".

    1.3. Create a transaction for packed-ref-store in function
         "packed_delete_refs()" by calling the function
         "ref_store_transaction_begin()".

    2.2. Add update entries for all the references to be removed into
         this transaction by calling "ref_transaction_delete()".

    2.3. Call "ref_transaction_commit()" to commit the transaction.

    2.4. Unlock the packed-ref-store.

 2. Try to remove the references one by one by calling the function
    "refs_delete_ref()".

    2.1. Create a new transaction on loose-ref-store by calling
         "ref_store_transaction_begin()".

    2.2. Call "ref_transaction_delete()" to add a update entry
         for the reference to be deleted into the transaction.

    2.3. In "ref_transaction_commit()", it will call functions
         "files_transaction_prepare()" and "files_transaction_finish()"
         to commit the transaction.

         2.3.1. Lock the loose reference.

         2.3.2. Create a new packed-transaction, and add a new update
                entry to this packed-transaction. The previous step 1
                makes this operation unnecessary.

         2.3.3. Lock the packed-ref-store and call fucntion
                "is_packed_transaction_needed()" to check whether it
                is necessary to commit the transaction, and then
                abort the transaction because the reference is already
                removed from the packed-ref-store in step 1.

         2.3.4. Remove the reflog and the loose reference file for
                the reference to be deleted.

         2.3.4. Unlock the loose reference.

From the above steps, we can see that "refs_delete_refs()" is not an
atomic operation, but a semi-atomic operation. The operation is atomic
if all references to be deleted are in the packed ref-store, but not
if some references are loose references because we delete the loose
references one by one by calling "refs_delete_ref()" .

Refactored function "files_delete_refs()" to delete references within a
transaction, so the "reference-transaction" hook will only run once for
deleted branches and tags.

The behavior of the following git commands and the last two testcases
have been fixed in t1416:

 * git branch -d <branch>
 * git tag -d <tag>

A testcase in t5510 is broken because we used to call the function
"packed_refs_lock()", but it is not necessary if the deleted reference
is not in the "packed-refs" file.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             | 21 +++++-----
 refs/packed-backend.c            | 51 +-----------------------
 t/t1416-ref-transaction-hooks.sh | 68 +-------------------------------
 t/t5510-fetch.sh                 | 16 ++++++++
 4 files changed, 28 insertions(+), 128 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e029f5a885..8f3deddc71 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1268,31 +1268,27 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
 	if (!refnames->nr)
 		return 0;
 
-	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
-		goto error;
-
-	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
-		packed_refs_unlock(refs->packed_ref_store);
+	transaction = ref_store_transaction_begin(ref_store, &err);
+	if (!transaction)
 		goto error;
-	}
-
-	packed_refs_unlock(refs->packed_ref_store);
 
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
-
-		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
+		if (ref_transaction_delete(transaction, refname, NULL,
+					   flags, msg, &err))
 			result |= error(_("could not remove reference %s"), refname);
 	}
+	if (ref_transaction_commit(transaction, &err))
+		goto error;
 
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return result;
 
@@ -1309,6 +1305,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	else
 		error(_("could not delete references: %s"), err.buf);
 
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return -1;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 97b6837767..fdb7a0a52c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1519,55 +1519,6 @@ static int packed_initial_transaction_commit(struct ref_store *ref_store,
 	return ref_transaction_commit(transaction, err);
 }
 
-static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
-			     struct string_list *refnames, unsigned int flags)
-{
-	struct packed_ref_store *refs =
-		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
-	struct strbuf err = STRBUF_INIT;
-	struct ref_transaction *transaction;
-	struct string_list_item *item;
-	int ret;
-
-	(void)refs; /* We need the check above, but don't use the variable */
-
-	if (!refnames->nr)
-		return 0;
-
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
-
-	transaction = ref_store_transaction_begin(ref_store, &err);
-	if (!transaction)
-		return -1;
-
-	for_each_string_list_item(item, refnames) {
-		if (ref_transaction_delete(transaction, item->string, NULL,
-					   flags, msg, &err)) {
-			warning(_("could not delete reference %s: %s"),
-				item->string, err.buf);
-			strbuf_reset(&err);
-		}
-	}
-
-	ret = ref_transaction_commit(transaction, &err);
-
-	if (ret) {
-		if (refnames->nr == 1)
-			error(_("could not delete reference %s: %s"),
-			      refnames->items[0].string, err.buf);
-		else
-			error(_("could not delete references: %s"), err.buf);
-	}
-
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return ret;
-}
-
 static int packed_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	/*
@@ -1595,7 +1546,7 @@ struct ref_storage_be refs_be_packed = {
 
 	.pack_refs = packed_pack_refs,
 	.create_symref = NULL,
-	.delete_refs = packed_delete_refs,
+	.delete_refs = NULL,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 77996017d7..3d39e1634a 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -789,39 +789,7 @@ test_expect_success "branch: rename branches" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output for "git branch -d":
-#
-#  * The delete branches operation should be treated as one transaction,
-#    but was splitted into several transactions on loose references,
-#    and the "reference-transaction committed" command was executed
-#    redundantly on the packed-ref-store.
-#
-# The differences are as follows:
-#
-#     @@ -2,11 +2,19 @@
-#      <ZERO-OID> <ZERO-OID> refs/heads/topic1
-#      <ZERO-OID> <ZERO-OID> refs/heads/topic2
-#      <ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +## Call hook: reference-transaction  prepared ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#     +## Call hook: reference-transaction  prepared ##
-#     +<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     +## Call hook: reference-transaction committed ##
-#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
-test_expect_failure "branch: remove branches" '
+test_expect_success "branch: remove branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -950,39 +918,7 @@ test_expect_success "tag: update refs to create loose refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Mismatched hook output for "git tag -d":
-#
-#  * The delete tags operation should be treated as one transaction,
-#    but was splitted into several transactions on loose references,
-#    and the "reference-transaction committed" command was executed
-#    redundantly on the packed-ref-store.
-#
-# The differences are as follows:
-#
-#     @@ -2,11 +2,19 @@
-#      <ZERO-OID> <ZERO-OID> refs/tags/v1
-#      <ZERO-OID> <ZERO-OID> refs/tags/v2
-#      <ZERO-OID> <ZERO-OID> refs/tags/v3
-#     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v2
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v3
-#     +## Call hook: reference-transaction  prepared ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
-#     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-A> <ZERO-OID> refs/tags/v1
-#      <COMMIT-B> <ZERO-OID> refs/tags/v2
-#     -<COMMIT-C> <ZERO-OID> refs/tags/v3
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-A> <ZERO-OID> refs/tags/v1
-#      <COMMIT-B> <ZERO-OID> refs/tags/v2
-#     +## Call hook: reference-transaction  prepared ##
-#     +<COMMIT-C> <ZERO-OID> refs/tags/v3
-#     +## Call hook: reference-transaction committed ##
-#      <COMMIT-C> <ZERO-OID> refs/tags/v3
-test_expect_failure "tag: remove tags with mixed ref_stores" '
+test_expect_success "tag: remove tags with mixed ref_stores" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b45879a760..dfdab09600 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -168,6 +168,8 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	cd "$D" &&
 	git clone . prune-fail &&
 	cd prune-fail &&
+	git update-ref refs/remotes/origin/extrabranch main~ &&
+	git pack-refs --all &&
 	git update-ref refs/remotes/origin/extrabranch main &&
 	: this will prevent --prune from locking packed-refs for deleting refs, but adding loose refs still succeeds  &&
 	>.git/packed-refs.new &&
@@ -175,6 +177,20 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	test_must_fail git fetch --prune origin
 '
 
+test_expect_success REFFILES 'fetch --prune ok for loose refs not in locked packed-refs' '
+	cd "$D" &&
+	git clone . prune-ok-ref-not-packed &&
+	(
+		cd prune-ok-ref-not-packed &&
+		git update-ref refs/remotes/origin/extrabranch main &&
+		: for loose refs not in packed-refs, we can delete them even the packed-refs is locked &&
+		:>.git/packed-refs.new &&
+
+		git fetch --prune origin &&
+		test_must_fail git rev-parse refs/remotes/origin/extrabranch --
+	)
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf \"$D\"/atomic" &&
 
-- 
2.36.1.25.gc87d5ad63a.dirty


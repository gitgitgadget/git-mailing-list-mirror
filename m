Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29C9C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiHSDWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiHSDV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:21:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C307D8E0B
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso2991633pjd.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5jmcH3OZDb8XZiXAdR7eHucA5ADcneu4RIWfy5rinAo=;
        b=CglJ66+iRWbXXiv9JsoLr5MsZZjQ19Xs/phEsoG0hcb8B4PQzV3gpIx5Mn/NY1EShi
         nZxf2CWbiLQ7WbArnay8D+IoBI9zvDLTzlaqW8Dfsj4s1EfKaUHaPVRYWf9/q82L2QMx
         +TgAYdurFS782ViB1B6AMmyMRPv1hjuGrnD/hdrwJo4alLVD87b/CqzMZeddSin2H9ZH
         13jNMTtA4pMckPVeDYg6rgY5sErU5IX6Kbl+PBSEH5zsyQ6EJDX7tcYA6/9l+LEqX2mS
         LrlMM2yuw4xSzY9uIOcrWesaSBAwEq3b8qD0o6uhs/QrZwiHl+HgfFKHXmFpuT7xfhtB
         HzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5jmcH3OZDb8XZiXAdR7eHucA5ADcneu4RIWfy5rinAo=;
        b=uSLqCzKSd+AfDVwFnL7J8Hz6jP4WBN7UxOgrQkyrsJkjlyAiDF8KWMbGhghGjhIdfJ
         prOioBRzdCnavdIVoi6xkeN1g4tAYXZfBKU5DNcskapQBQFBNC+8DNxntIXHkjJFb9EB
         K8za5NGHB1rmFLk64VsKQkTNqZ1m+z3oefucwe+JoZIYitLH5gb2iekxxsrSWdFiA/7P
         nN9EJNcaBlVlMJiRoM22yp1LB19j57EdKHaHIFvT51F+9axSu6ACrxLDXDrueInl/9ZY
         a+Abcrk4niUEmzI+WEIgw5v1YN/eru30JpEL5V1K2OGRTKSFv8/ISzi7qsNURPKNSRSg
         EiCw==
X-Gm-Message-State: ACgBeo1VUFelb//qg2QckKU7ldLac/HoeiT8Ud0gs9kQPWw5NNc6wKWc
        OzRNOYb0lV/Pxz2QGH5knY8=
X-Google-Smtp-Source: AA6agR7rlh4ktu2xodDljqxQHmRyULY8MPAYoh72gWdduV62vX8LcebBOWZl9CELznQIRCB9M8Bz7Q==
X-Received: by 2002:a17:902:d2c1:b0:16e:ea4e:36d3 with SMTP id n1-20020a170902d2c100b0016eea4e36d3mr5297849plc.98.1660879313930;
        Thu, 18 Aug 2022 20:21:53 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:53 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 2/9] refs: update missing old-oid in transaction from lockfile
Date:   Fri, 19 Aug 2022 11:21:40 +0800
Message-Id: <20220819032147.28841-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

For commands that update a reference without providing an old-oid, the
"reference-transaction" hook will receive a zero-oid instead of the
correct old-oid.

In order to provide the "reference-transaction" hook with a real old-oid
in any case, get proper old_oid from the lock file and propagate it to
the corresponding update entry of a transaction.

The behavior of the following git commands and five testcases have been
fixed in t1416:

 * git branch [-f] <ref> <new-oid>      # update branch
 * git cherry-pick <oid>
 * git rebase
 * git tag -d <tag>
 * git update-ref --stdin               # update refs
 * git update-ref -d <ref>
 * git update-ref <ref> <new-oid>       # update ref

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs/files-backend.c             |  28 +++-
 t/t1416-ref-transaction-hooks.sh | 231 ++++++-------------------------
 2 files changed, 65 insertions(+), 194 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8db7882aac..7c1c25a25c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2523,15 +2523,24 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	update->backend_data = lock;
 
 	if (update->type & REF_ISSYMREF) {
+		const char *ref;
+
+		/*
+		 * Read the referent even though we won't use it as part
+		 * of the transaction, because we want to set a proper
+		 * old_oid for this symref using the oid we got.
+		 */
+		ref = refs_resolve_ref_unsafe(&refs->base,
+					      referent.buf, 0,
+					      &lock->old_oid, NULL);
+
 		if (update->flags & REF_NO_DEREF) {
 			/*
 			 * We won't be reading the referent as part of
-			 * the transaction, so we have to read it here
-			 * to record and possibly check old_oid:
+			 * the transaction, so we may need to check
+			 * old_oid here:
 			 */
-			if (!refs_resolve_ref_unsafe(&refs->base,
-						     referent.buf, 0,
-						     &lock->old_oid, NULL)) {
+			if (!ref) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
@@ -2578,6 +2587,15 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
+	/*
+	 * Propagate old_oid from the lock to the update entry, so we can
+	 * provide a proper old-oid of to the "reference-transaction" hook.
+	 */
+	if (!(update->flags & REF_HAVE_OLD) && !is_null_oid(&lock->old_oid)) {
+		oidcpy(&update->old_oid, &lock->old_oid);
+		update->flags |= REF_HAVE_OLD;
+	}
+
 	if ((update->flags & REF_HAVE_NEW) &&
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 84509cb6a4..1ae601a73d 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -52,8 +52,8 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/main
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST <<-EOF &&
 		update HEAD $ZERO_OID $POST_OID
@@ -75,8 +75,8 @@ test_expect_success 'hook gets all queued updates in committed state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/main
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST &&
 	test_cmp expect actual
@@ -320,26 +320,7 @@ test_expect_success "update-ref: create new refs" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Failed because the old-oids for the default branch and
-# HEAD which points to the default branch were not the
-# expected old-oids, but <ZERO-OID>.
-#
-# The differences are as follows:
-#
-#     @@ -5,8 +5,8 @@
-#      <COMMIT-A> <COMMIT-B> refs/heads/topic1
-#      <COMMIT-A> <COMMIT-B> HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-B> <COMMIT-A> refs/heads/topic1
-#     -<COMMIT-B> <COMMIT-A> HEAD
-#     +<ZERO-OID> <COMMIT-A> refs/heads/topic1
-#     +<ZERO-OID> <COMMIT-A> HEAD
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-B> <COMMIT-A> refs/heads/topic1
-#     -<COMMIT-B> <COMMIT-A> HEAD
-#     +<ZERO-OID> <COMMIT-A> refs/heads/topic1
-#     +<ZERO-OID> <COMMIT-A> HEAD
-test_expect_failure "update-ref: update default branch" '
+test_expect_success "update-ref: update default branch" '
 	test_when_finished "git switch main; rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -375,25 +356,7 @@ test_expect_failure "update-ref: update default branch" '
 	test_cmp_heads_and_tags -C workdir expect
 '
 
-# Failed because the old-oids for HEAD and the ref that the HEAD points
-# to were not the expected old-oids, but <ZERO-OID>.
-#
-# The differences are as follows:
-#
-#     @@ -5,8 +5,8 @@
-#      <COMMIT-A> <COMMIT-B> HEAD
-#      <COMMIT-A> <COMMIT-B> refs/heads/topic1
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-B> <COMMIT-A> HEAD
-#     -<COMMIT-B> <COMMIT-A> refs/heads/topic1
-#     +<ZERO-OID> <COMMIT-A> HEAD
-#     +<ZERO-OID> <COMMIT-A> refs/heads/topic1
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-B> <COMMIT-A> HEAD
-#     -<COMMIT-B> <COMMIT-A> refs/heads/topic1
-#     +<ZERO-OID> <COMMIT-A> HEAD
-#     +<ZERO-OID> <COMMIT-A> refs/heads/topic1
-test_expect_failure "update-ref: update HEAD" '
+test_expect_success "update-ref: update HEAD" '
 	test_when_finished "git switch main; rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -438,32 +401,7 @@ test_expect_failure "update-ref: prepare packed_ref_store using pack-refs" '
 	test_path_is_missing $HOOK_OUTPUT
 '
 
-# Failed because the old-oid was not the expected old-oid, but
-# <ZERO-OID> for updating a reference using git-update-refs
-# command without providing the old-oid parameter.
-#
-# The differences are as follows:
-#
-#     @@ -3,14 +3,14 @@
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-A> <COMMIT-B> refs/heads/topic2
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-A> <COMMIT-C> refs/heads/topic3
-#     +<ZERO-OID> <COMMIT-C> refs/heads/topic3
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-A> <COMMIT-C> refs/heads/topic3
-#     +<ZERO-OID> <COMMIT-C> refs/heads/topic3
-#      ## Call hook: reference-transaction  prepared ##
-#      <ZERO-OID> <COMMIT-A> refs/heads/topic4
-#      ## Call hook: reference-transaction committed ##
-#      <ZERO-OID> <COMMIT-A> refs/heads/topic4
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-A> <COMMIT-C> refs/heads/topic4
-#     +<ZERO-OID> <COMMIT-C> refs/heads/topic4
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-A> <COMMIT-C> refs/heads/topic4
-#     +<ZERO-OID> <COMMIT-C> refs/heads/topic4
-test_expect_failure "update-ref: update refs already in packed_ref_store" '
+test_expect_success "update-ref: update refs already in packed_ref_store" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -510,9 +448,6 @@ test_expect_failure "update-ref: update refs already in packed_ref_store" '
 #  * The "reference-transaction committed" command was executed twice,
 #    once for packed ref-store, and once for loose ref-store.
 #
-#  * The old-oid was not the expected old-oid, but <ZERO-OID> when
-#    deleting a reference without providing the old-oid parameter.
-#
 #  * Unexpected execution of the "reference-transaction abort" command.
 #
 # The differences are as follows:
@@ -526,7 +461,7 @@ test_expect_failure "update-ref: update refs already in packed_ref_store" '
 #      <COMMIT-A> <ZERO-OID> refs/heads/topic1
 #      <COMMIT-A> <ZERO-OID> HEAD
 #      ## Call hook: reference-transaction  prepared ##
-#     @@ -11,14 +13,20 @@
+#     @@ -11,13 +13,19 @@
 #      ## Call hook: reference-transaction  prepared ##
 #      <COMMIT-B> <ZERO-OID> refs/heads/topic2
 #      ## Call hook: reference-transaction committed ##
@@ -536,21 +471,16 @@ test_expect_failure "update-ref: update refs already in packed_ref_store" '
 #      ## Call hook: reference-transaction  prepared ##
 #      <ZERO-OID> <ZERO-OID> refs/heads/topic3
 #      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
+#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
 #      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
+#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
 #      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic4
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
+#      <COMMIT-C> <ZERO-OID> refs/heads/topic4
 #      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic4
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
 test_expect_failure "update-ref: remove refs with mixed ref_stores" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
@@ -638,24 +568,7 @@ test_expect_success "update-ref --stdin: prepare packed_ref_store using pack-ref
 	git -C workdir pack-refs --all
 '
 
-# Failed because the old-oid was not the expected old-oid, but
-# <ZERO-OID> when running "git update-ref --stdin" to update a
-# reference without providing an old-oid.
-#
-# The differences are as follows:
-#
-#     @@ -1,8 +1,8 @@
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-A> <COMMIT-B> refs/heads/topic2
-#     -<COMMIT-A> <COMMIT-C> refs/heads/topic3
-#     +<ZERO-OID> <COMMIT-C> refs/heads/topic3
-#      <ZERO-OID> <COMMIT-C> refs/heads/topic4
-#      ## Call hook: reference-transaction committed ##
-#      <COMMIT-A> <COMMIT-B> refs/heads/topic2
-#     -<COMMIT-A> <COMMIT-C> refs/heads/topic3
-#     +<ZERO-OID> <COMMIT-C> refs/heads/topic3
-#      <ZERO-OID> <COMMIT-C> refs/heads/topic4
-test_expect_failure "update-ref --stdin: update refs" '
+test_expect_success "update-ref --stdin: update refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -699,39 +612,20 @@ test_expect_failure "update-ref --stdin: update refs" '
 #  * The "reference-transaction committed" command was executed twice,
 #    once for packed ref-store, and once for loose ref-store.
 #
-#  * The old-oid was not the expected old-oid, but <ZERO-OID> when
-#    deleting a ref without providing the old-oid parameter.
-#
 # The differences are as follows:
 #
-#     @@ -4,14 +4,19 @@
-#      <ZERO-OID> <ZERO-OID> refs/heads/topic3
-#      <ZERO-OID> <ZERO-OID> refs/heads/topic4
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic4
-#     -<COMMIT-A> <ZERO-OID> HEAD
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
-#     +<ZERO-OID> <ZERO-OID> HEAD
+#     @@ -10,6 +10,11 @@
+#      <COMMIT-C> <ZERO-OID> refs/heads/topic4
+#      <COMMIT-A> <ZERO-OID> HEAD
 #      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
 #     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
+#      <COMMIT-A> <ZERO-OID> refs/heads/topic1
 #      <COMMIT-B> <ZERO-OID> refs/heads/topic2
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic4
-#     -<COMMIT-A> <ZERO-OID> HEAD
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic4
-#     +<ZERO-OID> <ZERO-OID> HEAD
+#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
 test_expect_failure "update-ref --stdin: delete refs" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
@@ -852,23 +746,7 @@ test_expect_failure "branch: prepare packed_ref_store using gc" '
 	test_path_is_missing $HOOK_OUTPUT
 '
 
-# Failed because the old-oid was not the expected old-oid, but
-# <ZERO-OID> when running git-branch to update a branch without
-# providing an old-oid.
-#
-# The differences are as follows:
-#
-#     @@ -1,7 +1,7 @@
-#      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-A> <COMMIT-B> refs/heads/topic2
-#     +<ZERO-OID> <COMMIT-B> refs/heads/topic2
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-A> <COMMIT-B> refs/heads/topic2
-#     +<ZERO-OID> <COMMIT-B> refs/heads/topic2
-#      ## Call hook: reference-transaction  prepared ##
-#      <ZERO-OID> <COMMIT-C> refs/heads/topic3
-#      ## Call hook: reference-transaction committed ##
-test_expect_failure "branch: update branch without old-oid" '
+test_expect_success "branch: update branch without old-oid" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
 	cat >expect <<-\EOF &&
@@ -1007,9 +885,6 @@ test_expect_failure "branch: rename branches" '
 
 # Mismatched hook output for "git branch -d":
 #
-#  * The old-oid was not the expected old-oid, but <ZERO-OID> when
-#    deleting a branch without providing the old-oid parameter.
-#
 #  * The delete branches operation should be treated as one transaction,
 #    but was splitted into several transactions on loose references,
 #    and the "reference-transaction committed" command was executed
@@ -1029,28 +904,25 @@ test_expect_failure "branch: rename branches" '
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
+#     +## Call hook: reference-transaction  prepared ##
+#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
+#     +## Call hook: reference-transaction committed ##
+#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
+#     +## Call hook: reference-transaction   aborted ##
+#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
 #      ## Call hook: reference-transaction  prepared ##
 #     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
-#     -<COMMIT-B> <ZERO-OID> refs/heads/topic2
+#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
 #     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
 #      ## Call hook: reference-transaction committed ##
 #     -<COMMIT-A> <ZERO-OID> refs/heads/topic1
-#     -<COMMIT-B> <ZERO-OID> refs/heads/topic2
-#     -<COMMIT-C> <ZERO-OID> refs/heads/topic3
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic1
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
-#     +## Call hook: reference-transaction  prepared ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
-#     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic2
+#      <COMMIT-B> <ZERO-OID> refs/heads/topic2
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction  prepared ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
+#     +<COMMIT-C> <ZERO-OID> refs/heads/topic3
 #     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/heads/topic3
+#      <COMMIT-C> <ZERO-OID> refs/heads/topic3
 test_expect_failure "branch: remove branches" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
@@ -1184,9 +1056,6 @@ test_expect_success "tag: update refs to create loose refs" '
 
 # Mismatched hook output for "git tag -d":
 #
-#  * The old-oid was not the expected old-oid, but <ZERO-OID> when
-#    deleting a tag without providing the old-oid parameter.
-#
 #  * The delete tags operation should be treated as one transaction,
 #    but was splitted into several transactions on loose references,
 #    and the "reference-transaction committed" command was executed
@@ -1206,28 +1075,25 @@ test_expect_success "tag: update refs to create loose refs" '
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v3
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v1
+#     +## Call hook: reference-transaction  prepared ##
+#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
+#     +## Call hook: reference-transaction committed ##
+#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
+#     +## Call hook: reference-transaction   aborted ##
+#     +<ZERO-OID> <ZERO-OID> refs/tags/v2
 #      ## Call hook: reference-transaction  prepared ##
 #     -<COMMIT-A> <ZERO-OID> refs/tags/v1
-#     -<COMMIT-B> <ZERO-OID> refs/tags/v2
+#      <COMMIT-B> <ZERO-OID> refs/tags/v2
 #     -<COMMIT-C> <ZERO-OID> refs/tags/v3
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
 #      ## Call hook: reference-transaction committed ##
 #     -<COMMIT-A> <ZERO-OID> refs/tags/v1
-#     -<COMMIT-B> <ZERO-OID> refs/tags/v2
-#     -<COMMIT-C> <ZERO-OID> refs/tags/v3
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v1
-#     +## Call hook: reference-transaction   aborted ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v2
-#     +## Call hook: reference-transaction  prepared ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v2
-#     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v2
+#      <COMMIT-B> <ZERO-OID> refs/tags/v2
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> refs/tags/v3
 #     +## Call hook: reference-transaction  prepared ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v3
+#     +<COMMIT-C> <ZERO-OID> refs/tags/v3
 #     +## Call hook: reference-transaction committed ##
-#     +<ZERO-OID> <ZERO-OID> refs/tags/v3
+#      <COMMIT-C> <ZERO-OID> refs/tags/v3
 test_expect_failure "tag: remove tags with mixed ref_stores" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
@@ -1374,24 +1240,19 @@ test_expect_success "worktree: topic2: merge" '
 
 # Mismatched hook output for git-cherry-pick:
 #
-#  * The old-oid was not the expected old-oid, but <ZERO-OID>.
-#
 #  * Unexpected execution of the "reference-transaction abort" command.
 #
 # The differences are as follows:
 #
-#     @@ -12,7 +12,9 @@
+#     @@ -12,6 +12,8 @@
 #      ## Call hook: reference-transaction committed ##
 #      <COMMIT-A> <COMMIT-F> HEAD
 #      <COMMIT-A> <COMMIT-F> refs/heads/topic3
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
 #      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-C> <ZERO-OID> CHERRY_PICK_HEAD
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
+#      <COMMIT-C> <ZERO-OID> CHERRY_PICK_HEAD
 #      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-C> <ZERO-OID> CHERRY_PICK_HEAD
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
 test_expect_failure "worktree: topic3: cherry-pick" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
 
@@ -1438,8 +1299,6 @@ test_expect_failure "worktree: topic3: cherry-pick" '
 
 # Mismatched hook output for git-rebase:
 #
-#  * The old-oid was not the expected old-oid, but <ZERO-OID>.
-#
 #  * Unexpected execution of the "reference-transaction abort" command.
 #
 # The differences are as follows:
@@ -1453,20 +1312,14 @@ test_expect_failure "worktree: topic3: cherry-pick" '
 #      ## Call hook: reference-transaction  prepared ##
 #      <ZERO-OID> <ZERO-OID> REBASE_HEAD
 #      ## Call hook: reference-transaction committed ##
-#     @@ -18,10 +20,12 @@
+#     @@ -18,6 +20,8 @@
 #      <COMMIT-C> <COMMIT-H> HEAD
 #      ## Call hook: reference-transaction committed ##
 #      <COMMIT-C> <COMMIT-H> HEAD
 #     +## Call hook: reference-transaction   aborted ##
 #     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
 #      ## Call hook: reference-transaction  prepared ##
-#     -<COMMIT-G> <ZERO-OID> CHERRY_PICK_HEAD
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction committed ##
-#     -<COMMIT-G> <ZERO-OID> CHERRY_PICK_HEAD
-#     +<ZERO-OID> <ZERO-OID> CHERRY_PICK_HEAD
-#      ## Call hook: reference-transaction  prepared ##
-#      <COMMIT-G> <COMMIT-H> refs/heads/topic4
+#      <COMMIT-G> <ZERO-OID> CHERRY_PICK_HEAD
 #      ## Call hook: reference-transaction committed ##
 test_expect_failure "worktree: topic4: rebase" '
 	test_when_finished "rm -f $HOOK_OUTPUT" &&
-- 
2.36.1.25.gc87d5ad63a.dirty


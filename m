Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AEC6377E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C7D6101E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbhGTJuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B97C0613BC
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so1181269wms.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDAw3YZvdL2a1qC7c/lLSHLg9P6Mwv1ogLcex2KyNrE=;
        b=rjuFEa8AuK8AE/OYtHjIGuBEV3rlvu2Ijto+E6T9xUbmUi/YWAHwktQ95E3uQy9ESv
         OMTgvQRHRhzDcBJgjsDGsVRMHpWvQERhHjyBtA+BwwLbIkl56s7R4+6AhXNl10iCyQyH
         IbAsTHvJTNNyXhlu0WMWOCh9Q7LWfUxfIDdnZvfVilufpf4EtPi+fnL0nGsAr1tKIKbk
         wOtbF0UTn1btsOg0Z8so3RTfx4ERQiDN7GZNDd/afsEBMueEwRjII66rA7W6reZirMBa
         fCG7QKFKmIW7qY5iNKytBpEHoIaObOjenJ8uP3Fq4VO5V4R8/qm2kfpyIYXdW3FZ/ITb
         XLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDAw3YZvdL2a1qC7c/lLSHLg9P6Mwv1ogLcex2KyNrE=;
        b=skhsAfWMSkg7kxvCiQQzosizoTMfhg95/BJViuB0uYwy0GTNdfPdVz1X9cL2KNP2St
         GkxoPrVcmNrx1IvY5j3rc7tTUKqJFKtK0M5RWzujK/g0z3t5QN6AwjejvdQpcLabaRXS
         3NhoDEhle8mzaUDlNYnUckyZ01WPLsOFPxNAODe9jXOPrL4qL+eQy4W1+k5CVqU6sy30
         9d9iIiUKSrMxfZBoDJGQsP0HRqagbtddVoL9sXpONMj83hSgc53YUqD17HV8oTeWDOBb
         h+YV+PjoLhZJwW13Sf3a/Bb5b4Iu2Qq+76ZrY0MjbJUeAyakk6dzF9A7Bm3kXvq/VTKG
         OViA==
X-Gm-Message-State: AOAM531Il3YWu6hhM1QlGftYFVa6C0GrY32tNGBuGCzQzwocO+QbuWHZ
        tIz4sOecm/PVDWqPpkieCHjaGs2FmkE5Aw==
X-Google-Smtp-Source: ABdhPJyGvo3i8vxHT2pJcjAx+2xO7LLKBAfmoBmqbAVwiJg0vFQzuIxHaLxlcuojk0S44Qt0RDqG5A==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr30866897wmb.162.1626776667621;
        Tue, 20 Jul 2021 03:24:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/12] refs API: pass the "lock OID" to reflog "prepare"
Date:   Tue, 20 Jul 2021 12:24:11 +0200
Message-Id: <patch-06.12-295594fe8ae-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't pass the object ID we pass into reflog_expire() back to the
caller, but rather our locked OID. As the assert shows these two were
the same thing in practice as we'd exit earlier in this function if we
couldn't lock the desired OID.

This is in preparation for a subsequent change of not having
reflog_expire() pass in the OID at all, also remove the "const" from
the parameter since the "struct ref_lock" does not have it on its
"old_oid" member.

As we'll see in a subsequent commit we don't actually want to assert
that we locked a given OID, we want this API to do the locking and
tell us what the OID is, but for now let's just setup the basic
scaffolding for that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c     | 4 ++--
 refs.h               | 4 ++--
 refs/debug.c         | 8 +++++---
 refs/files-backend.c | 3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 09541d1c804..9f9e6bceb03 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -351,7 +351,7 @@ static int is_head(const char *refname)
 }
 
 static void reflog_expiry_prepare(const char *refname,
-				  const struct object_id *oid,
+				  struct object_id *locked_oid,
 				  void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
@@ -361,7 +361,7 @@ static void reflog_expiry_prepare(const char *refname,
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
 		cb->tip_commit = lookup_commit_reference_gently(the_repository,
-								oid, 1);
+								locked_oid, 1);
 		if (!cb->tip_commit)
 			cb->unreachable_expire_kind = UE_ALWAYS;
 		else
diff --git a/refs.h b/refs.h
index 48970dfc7e0..c009707438d 100644
--- a/refs.h
+++ b/refs.h
@@ -796,7 +796,7 @@ enum expire_reflog_flags {
  * expiration policy that is desired.
  *
  * reflog_expiry_prepare_fn -- Called once after the reference is
- *     locked.
+ *     locked. Called with the OID of the locked reference.
  *
  * reflog_expiry_should_prune_fn -- Called once for each entry in the
  *     existing reflog. It should return true iff that entry should be
@@ -806,7 +806,7 @@ enum expire_reflog_flags {
  *     unlocked again.
  */
 typedef void reflog_expiry_prepare_fn(const char *refname,
-				      const struct object_id *oid,
+				      struct object_id *lock_oid,
 				      void *cb_data);
 typedef int reflog_expiry_should_prune_fn(struct object_id *ooid,
 					  struct object_id *noid,
diff --git a/refs/debug.c b/refs/debug.c
index 449ac3e6cc8..18fd9bca595 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -364,12 +364,14 @@ struct debug_reflog_expiry_should_prune {
 };
 
 static void debug_reflog_expiry_prepare(const char *refname,
-					const struct object_id *oid,
+					struct object_id *locked_oid,
 					void *cb_data)
 {
 	struct debug_reflog_expiry_should_prune *prune = cb_data;
-	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s\n", refname);
-	prune->prepare(refname, oid, prune->cb_data);
+	trace_printf_key(&trace_refs, "reflog_expire_prepare: %s locket at %s\n",
+			 refname,
+			 oid_to_hex(locked_oid));
+	prune->prepare(refname, locked_oid, prune->cb_data);
 }
 
 static int debug_reflog_expiry_should_prune_fn(struct object_id *ooid,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index af332fa8fe4..ce4b3fb1c7a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3098,7 +3098,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	(*prepare_fn)(refname, oid, cb.policy_cb);
+	assert(oideq(&lock->old_oid, oid));
+	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
-- 
2.32.0.874.ge7a9d58bfcf


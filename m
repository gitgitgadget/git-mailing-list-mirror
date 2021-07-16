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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EE1C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D61613EB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhGPOQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbhGPOQT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F24C061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so6984101wmf.5
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eshe/9n5XyR/ztvffNnilQjb6AsPQ34i3bNCQVmfiR0=;
        b=qOzc6GXYsBluEaUFiZ3tGcJSkApEXkcodaVo48sgO3z3pGMTKPedXncVcjuXRI8Z/Q
         viR5hRUeIg43G/areT5VtA+Sw8XTCJfxIQn5gmczUbH/yuGyX/rtcttD+4AU4ZIWhcbu
         4OTkNJDyADR62gORQ1QWnEsSEifvp3mki83vboUWYrV/f2zxiRK53weM8za5FX/L/kpi
         EDmzlHgn36VPdWc3WAiR25HSlEv65SepmE7J0eUSM5BBAP9XsHqfNr24w2B5IoE9WLdU
         N9lG2nt51o1eGg25Kegv5uP16h1cusRyzIcbzNrE+4o5J7RuN16IWlKW6aqBFgPFTugP
         rY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eshe/9n5XyR/ztvffNnilQjb6AsPQ34i3bNCQVmfiR0=;
        b=X5FrvY+WcTS1yaxlnFNC183lZsgBxq/1kxdOHYinC03tDmmjuM89jgzUmsoODJx8OF
         1OOSXtMbNxior4zpI9pj2HdHXPqbrAQgeA42/yfmU5bpE+cy9/FFyHrVNJM8U6XqXcsx
         3v0q8vgroZ+m/mG8bCURZSUt8WSWKzny6Eor1b7OxTVuRzE7TZOdwvj6DhL7xWZu7TR8
         SzppqBo1DXhpRmJH23U7XrkeekjXziNB5kDgvN47VCM+snF06bUcBWZPyoanbnVPmJna
         W7oHPl4pMB+mxJuzUBlbfDI5KNJ01MKML3+6itCNnsHUxbCj0yIybDQQlLR/l60nQNxl
         KVdQ==
X-Gm-Message-State: AOAM531suU4uN7/wuxZ92KmsQhBjYnH/ah6FoOgbBknSofOYy6J8XMOh
        Am5Ste5P4Qx6PmPJjENgJYSxynyJPBUCGg==
X-Google-Smtp-Source: ABdhPJy1rL9fjYrLpOVNjMqpzYLkqPQ9By/e8ZmAsqAqVZ+xwEZg6k0XmXge5e+iYY62hYtnfiSdiQ==
X-Received: by 2002:a05:600c:3799:: with SMTP id o25mr16879582wmr.63.1626444801532;
        Fri, 16 Jul 2021 07:13:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] refs API: pass the "lock OID" to reflog "prepare"
Date:   Fri, 16 Jul 2021 16:13:02 +0200
Message-Id: <patch-06.11-e93465f4137-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't pass the object ID we pass into reflog_expire() back to the
caller, but rather our locked OID.

As the assert shows these two were the same thing in practice as we'd
exit earlier in this function if we couldn't lock the desired OID, but
as part of removing the passing of the OID to other functions further
on I'm splitting up these concerns.

As we'll see in a subsequent commit we don't actually want to assert
that we locked a given OID, we want this API to do the locking and
tell us what the OID is, but for now let's just setup the scaffolding
for that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c     | 4 ++--
 refs.h               | 4 ++--
 refs/debug.c         | 8 +++++---
 refs/files-backend.c | 2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

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
index af332fa8fe4..ec9c70d79cc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3098,7 +3098,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	(*prepare_fn)(refname, oid, cb.policy_cb);
+	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
 
-- 
2.32.0.873.gb6f2f696497


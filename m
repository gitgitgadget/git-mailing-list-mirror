Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8D3C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D990D61212
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhHWLhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbhHWLhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BEC0613C1
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f5so25741588wrm.13
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wghmPfL5lBgMi4V/ythx4RZuCQ0GO5ckah/zFELQ3jA=;
        b=HbSZk2s4how15bE0jtMQdpjDfSojKW6LKu2K+yYvAmtm0FgYqWtX1KR3i+0J0zJ6aw
         fIqAsmKf2jaNjhzxqEmTy6RG1qk0IIO7I0TIuG0BzHp9pdrum4SCPgfoSSCV17mZefEp
         ExPkfhUXiPsqcFQLDeFKWz4OT4gegrqMd58BFmLa6xODmxHFCF0ChH5mPXIv2BxbZcPU
         Eux/N3scDjyE3Tf17BcvCHclKTYsE0StFNyymw+4aJkMjD8jHvhhBaFWhqo5EWohfmM6
         QXX3+lKlxV8eLBfiDKvjdaBmNL8lgxs5hXJmZvJ766B9lHiXiTVFaYLId8iAI289z1WI
         aCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wghmPfL5lBgMi4V/ythx4RZuCQ0GO5ckah/zFELQ3jA=;
        b=iUJGDyxhhPHqXyUxYxgR8PBoAdP+or/9Ley6Q6JbbwTsd/x8AjbPO7DKbBiffmIX//
         /DjFk4KMpzqQABXKVAedSJps6J4Cm9Nq1K1bJfPccBtVbQFZYkbqktnLdfhgu9H3W8FA
         LoItP1d0ue72EjCSUddMW2n1k6eFT114te6KT4wXbtmVnmnrHmKubgZfjylaBgfzPLPz
         jJllB/OdZgbPex53UpheHogzDhF7xUrM/HAKhyVEnHyCAsrDDTk7p5zsdm39knc1IRh0
         /bpD+coHcsWHlgv+ETcca2dh3P4wdP8x6IgBcoAfHJS01JiJKWFJLVizxXqzqtjhtPzd
         Y9/Q==
X-Gm-Message-State: AOAM533rYpuJ1M2uOP4FVAFDV1nqbLuhfMSol4uzb3hSCvuotV/Z+5Ct
        S8OmHLbCdiJu/yb+vH/LzkPIsyekndINy3hX
X-Google-Smtp-Source: ABdhPJyI09C+Sc0wwvJWjrBG0rVOy/jjsyVbhbbKWUEPUiryscQoblzfqG7N4MS57DvqbR56PYfSvQ==
X-Received: by 2002:a5d:548e:: with SMTP id h14mr7865256wrv.7.1629718585158;
        Mon, 23 Aug 2021 04:36:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/13] refs API: remove OID argument to reflog_expire()
Date:   Mon, 23 Aug 2021 13:36:11 +0200
Message-Id: <patch-v5-10.13-5afa8f1be29-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the the preceding commit the "oid" parameter to reflog_expire()
is always NULL, but it was not cleaned up to reduce the size of the
diff. Let's do that subsequent API and documentation cleanup now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c      | 6 +++---
 refs.c                | 8 ++++----
 refs.h                | 7 +++----
 refs/debug.c          | 4 ++--
 refs/files-backend.c  | 3 +--
 refs/packed-backend.c | 2 +-
 refs/refs-internal.h  | 2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 61795f22d53..bd4c669918d 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -631,7 +631,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			struct collected_reflog *e = collected.e[i];
 
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-			status |= reflog_expire(e->reflog, NULL, flags,
+			status |= reflog_expire(e->reflog, flags,
 						reflog_expiry_prepare,
 						should_expire_reflog_ent,
 						reflog_expiry_cleanup,
@@ -648,7 +648,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
-		status |= reflog_expire(ref, NULL, flags,
+		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
@@ -723,7 +723,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			cb.cmd.expire_total = 0;
 		}
 
-		status |= reflog_expire(ref, NULL, flags,
+		status |= reflog_expire(ref, flags,
 					reflog_expiry_prepare,
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
diff --git a/refs.c b/refs.c
index d9635436759..05944d8e725 100644
--- a/refs.c
+++ b/refs.c
@@ -2371,19 +2371,19 @@ int delete_reflog(const char *refname)
 }
 
 int refs_reflog_expire(struct ref_store *refs,
-		       const char *refname, const struct object_id *oid,
+		       const char *refname,
 		       unsigned int flags,
 		       reflog_expiry_prepare_fn prepare_fn,
 		       reflog_expiry_should_prune_fn should_prune_fn,
 		       reflog_expiry_cleanup_fn cleanup_fn,
 		       void *policy_cb_data)
 {
-	return refs->be->reflog_expire(refs, refname, oid, flags,
+	return refs->be->reflog_expire(refs, refname, flags,
 				       prepare_fn, should_prune_fn,
 				       cleanup_fn, policy_cb_data);
 }
 
-int reflog_expire(const char *refname, const struct object_id *oid,
+int reflog_expire(const char *refname,
 		  unsigned int flags,
 		  reflog_expiry_prepare_fn prepare_fn,
 		  reflog_expiry_should_prune_fn should_prune_fn,
@@ -2391,7 +2391,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 		  void *policy_cb_data)
 {
 	return refs_reflog_expire(get_main_ref_store(the_repository),
-				  refname, oid, flags,
+				  refname, flags,
 				  prepare_fn, should_prune_fn,
 				  cleanup_fn, policy_cb_data);
 }
diff --git a/refs.h b/refs.h
index ddbf15f1c21..fda8aef1547 100644
--- a/refs.h
+++ b/refs.h
@@ -816,20 +816,19 @@ typedef int reflog_expiry_should_prune_fn(struct object_id *ooid,
 typedef void reflog_expiry_cleanup_fn(void *cb_data);
 
 /*
- * Expire reflog entries for the specified reference. oid is the old
- * value of the reference. flags is a combination of the constants in
+ * Expire reflog entries for the specified reference.
+ * flags is a combination of the constants in
  * enum expire_reflog_flags. The three function pointers are described
  * above. On success, return zero.
  */
 int refs_reflog_expire(struct ref_store *refs,
 		       const char *refname,
-		       const struct object_id *oid,
 		       unsigned int flags,
 		       reflog_expiry_prepare_fn prepare_fn,
 		       reflog_expiry_should_prune_fn should_prune_fn,
 		       reflog_expiry_cleanup_fn cleanup_fn,
 		       void *policy_cb_data);
-int reflog_expire(const char *refname, const struct object_id *oid,
+int reflog_expire(const char *refname,
 		  unsigned int flags,
 		  reflog_expiry_prepare_fn prepare_fn,
 		  reflog_expiry_should_prune_fn should_prune_fn,
diff --git a/refs/debug.c b/refs/debug.c
index 3f1455db2df..bf4a82bccb6 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -392,7 +392,7 @@ static void debug_reflog_expiry_cleanup(void *cb_data)
 }
 
 static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
-			       const struct object_id *oid, unsigned int flags,
+			       unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
 			       reflog_expiry_cleanup_fn cleanup_fn,
@@ -405,7 +405,7 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 		.should_prune = should_prune_fn,
 		.cb_data = policy_cb_data,
 	};
-	int res = drefs->refs->be->reflog_expire(drefs->refs, refname, oid,
+	int res = drefs->refs->be->reflog_expire(drefs->refs, refname,
 						 flags, &debug_reflog_expiry_prepare,
 						 &debug_reflog_expiry_should_prune_fn,
 						 &debug_reflog_expiry_cleanup,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d81bda8bc25..a4adac46443 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3027,7 +3027,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 static int files_reflog_expire(struct ref_store *ref_store,
-			       const char *refname, const struct object_id *unused_oid,
+			       const char *refname,
 			       unsigned int flags,
 			       reflog_expiry_prepare_fn prepare_fn,
 			       reflog_expiry_should_prune_fn should_prune_fn,
@@ -3106,7 +3106,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	assert(!unused_oid);
 	(*prepare_fn)(refname, oid, cb.policy_cb);
 	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
 	(*cleanup_fn)(cb.policy_cb);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 24a360b719f..65ba4214b8d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1635,7 +1635,7 @@ static int packed_delete_reflog(struct ref_store *ref_store,
 }
 
 static int packed_reflog_expire(struct ref_store *ref_store,
-				const char *refname, const struct object_id *oid,
+				const char *refname,
 				unsigned int flags,
 				reflog_expiry_prepare_fn prepare_fn,
 				reflog_expiry_should_prune_fn should_prune_fn,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3155708345f..d496c5ed52d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -593,7 +593,7 @@ typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
 			     int force_create, struct strbuf *err);
 typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
 typedef int reflog_expire_fn(struct ref_store *ref_store,
-			     const char *refname, const struct object_id *oid,
+			     const char *refname,
 			     unsigned int flags,
 			     reflog_expiry_prepare_fn prepare_fn,
 			     reflog_expiry_should_prune_fn should_prune_fn,
-- 
2.33.0.662.g438caf9576d


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A9C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF6A61019
	for <git@archiver.kernel.org>; Wed, 19 May 2021 15:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbhESPc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354872AbhESPcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 11:32:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE04C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 08:31:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso1040290wmc.2
        for <git@vger.kernel.org>; Wed, 19 May 2021 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6V1XWGMJetLdCMPLQ0ztpXWsz13TJzyO4IGS7BgsjMQ=;
        b=XpSErdamv/V/AjybvSrdYp5d19FaAgqIy6GvwpBUHpEiXLaHvt68AsuIvPxV/qxuRh
         +RHDIA+1K3WOVsrSUyUGL9QPX/GGU6ltWtZ7jnVPQYBnG1vufvH63XPSShBPMX8dSIHm
         QWNUh29b3hhOi291T8/izM9RBRFOoRnZtN6IZ7nExSCPoEZ2/81olooTfccUDYnaGo1B
         aLEZB08Stzhe6XDJ7N7acvA1bSxEYHxz0yNAmXbel6pr2qeNBio6KUcNP+LGJYFgYVdJ
         Afpik9bHsebkc9sT1ly+02OdZoBHD9uFQ0K62qpmvq9doTaa3DVxxwIorFD2/14pPad0
         +KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6V1XWGMJetLdCMPLQ0ztpXWsz13TJzyO4IGS7BgsjMQ=;
        b=IXEt5MaH1WaZru1uQduC/nJXgVl4gh1SqueaaxgC5PdEFRotsJJV8KD7s5G8hx73oQ
         B1VQnkNluQIWmeAApj4uGFBoh6AY9+QbtcgU5M+Pe5/JnqXod/A9ccdC3vzVr8Z5+e3E
         cePEvSN1ACvarvVUMkJhSCOAU4KnHUf1P2BRf7zPOvevkS6v9aV50H3Wy1uQxe7aCK2V
         G9rlPeZdTXsAMQg9+915Y5siMn+VKOdr6FDk2BBoCFG01A6iR9YIO4xwNG7zZDhB8EqR
         r5iBrKteqkYxJG48F+1BMuDMin8kTeNReLHSmELTvBSyaZ9jjAp/bNdGMPWlyQSmxTbJ
         +FYA==
X-Gm-Message-State: AOAM530HcY0td2uCDBF6pdZ/IW7QBIDXQyIDHVBTtBl1sHWtYY80cWkH
        S8JI1gaw3lCYpMm4rx93j6NXuFOvvxQ=
X-Google-Smtp-Source: ABdhPJyhq0yFelQFV/wL41uOeCfhvaFCJXDXBMEpbGLhgTLV8fNkRPeiU8OgsPolnMSGEBR5MH3vGw==
X-Received: by 2002:a05:600c:379a:: with SMTP id o26mr12106009wmr.86.1621438290961;
        Wed, 19 May 2021 08:31:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm20874194wmk.45.2021.05.19.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:31:30 -0700 (PDT)
Message-Id: <pull.1006.v2.git.git.1621438289354.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.git.git.1618484566164.gitgitgadget@gmail.com>
References: <pull.1006.git.git.1618484566164.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 May 2021 15:31:28 +0000
Subject: [PATCH v2] refs: make explicit that ref_iterator_peel returns boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Use -1 as error return value throughout.

This removes spurious differences in the GIT_TRACE_REFS output, depending on the
ref storage backend active.

Before, the cached ref_iterator (but only that iterator!) would return
peel_object() output directly. No callers relied on the peel_status values
beyond success/failure. All calls to these functions go through
peel_iterated_oid(), which returns peel_object() as a fallback, but also
squashing the error values.

The iteration interface already passes REF_ISSYMREF and REF_ISBROKEN through the
flags argument, so the additional error values in enum peel_status provide no
value.

The ref iteration interface provides a separate peel() function because certain
formats (eg. packed-refs and reftable) can store the peeled object next to the
tag SHA1. Passing the peeled SHA1 as an optional argument to each_ref_fn maps
more naturally to the implementation of ref databases. Changing the code in this
way is left for a future refactoring.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: ref_iterator_peel returns boolean, rather than peel_status
    
    v2: expand commit message.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1006%2Fhanwen%2Fpeel_return-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1006/hanwen/peel_return-v2
Pull-Request: https://github.com/git/git/pull/1006

Range-diff vs v1:

 1:  241e0ad1954b ! 1:  f1dc6c2d7fea refs: ref_iterator_peel returns boolean, rather than peel_status
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    refs: ref_iterator_peel returns boolean, rather than peel_status
     +    refs: make explicit that ref_iterator_peel returns boolean
      
     -    Before, the cached ref_iterator would return peel_object() output directly. This
     -    led to spurious differences in the GIT_TRACE_REFS output, depending on the ref
     -    storage backend active.
     +    Use -1 as error return value throughout.
     +
     +    This removes spurious differences in the GIT_TRACE_REFS output, depending on the
     +    ref storage backend active.
     +
     +    Before, the cached ref_iterator (but only that iterator!) would return
     +    peel_object() output directly. No callers relied on the peel_status values
     +    beyond success/failure. All calls to these functions go through
     +    peel_iterated_oid(), which returns peel_object() as a fallback, but also
     +    squashing the error values.
     +
     +    The iteration interface already passes REF_ISSYMREF and REF_ISBROKEN through the
     +    flags argument, so the additional error values in enum peel_status provide no
     +    value.
     +
     +    The ref iteration interface provides a separate peel() function because certain
     +    formats (eg. packed-refs and reftable) can store the peeled object next to the
     +    tag SHA1. Passing the peeled SHA1 as an optional argument to each_ref_fn maps
     +    more naturally to the implementation of ref databases. Changing the code in this
     +    way is left for a future refactoring.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ refs.c: int peel_iterated_oid(const struct object_id *base, struct object_id *pe
       		return ref_iterator_peel(current_ref_iter, peeled);
       
      -	return peel_object(base, peeled);
     -+	return !!peel_object(base, peeled);
     ++	return peel_object(base, peeled) ? -1 : 0;
       }
       
       int refs_create_symref(struct ref_store *refs,
      
     + ## refs/packed-backend.c ##
     +@@ refs/packed-backend.c: static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
     + 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
     + 		return -1;
     + 	} else {
     +-		return !!peel_object(&iter->oid, peeled);
     ++		return peel_object(&iter->oid, peeled) ? -1 : 0;
     + 	}
     + }
     + 
     +
       ## refs/ref-cache.c ##
      @@ refs/ref-cache.c: static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
       static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
       				   struct object_id *peeled)
       {
      -	return peel_object(ref_iterator->oid, peeled);
     -+	return !!peel_object(ref_iterator->oid, peeled);
     ++	return peel_object(ref_iterator->oid, peeled) ? -1 : 0;
       }
       
       static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
     @@ refs/refs-internal.h: void base_ref_iterator_free(struct ref_iterator *iter);
       typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
       
      +/*
     -+ * Peels the current ref, returning 0 for success.
     ++ * Peels the current ref, returning 0 for success or -1 for failure.
      + */
       typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
       				 struct object_id *peeled);


 refs.c                | 2 +-
 refs/packed-backend.c | 2 +-
 refs/ref-cache.c      | 2 +-
 refs/refs-internal.h  | 3 +++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 8c9490235ea6..8b9f7c3a80a0 100644
--- a/refs.c
+++ b/refs.c
@@ -2010,7 +2010,7 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	     oideq(current_ref_iter->oid, base)))
 		return ref_iterator_peel(current_ref_iter, peeled);
 
-	return peel_object(base, peeled);
+	return peel_object(base, peeled) ? -1 : 0;
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfecdbc1db60..66cb90c79ee0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -889,7 +889,7 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
 		return -1;
 	} else {
-		return !!peel_object(&iter->oid, peeled);
+		return peel_object(&iter->oid, peeled) ? -1 : 0;
 	}
 }
 
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 46f1e5428433..49d732f6db96 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -491,7 +491,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	return peel_object(ref_iterator->oid, peeled);
+	return peel_object(ref_iterator->oid, peeled) ? -1 : 0;
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..3155708345fc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -453,6 +453,9 @@ void base_ref_iterator_free(struct ref_iterator *iter);
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
+/*
+ * Peels the current ref, returning 0 for success or -1 for failure.
+ */
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
 				 struct object_id *peeled);
 

base-commit: bf949ade81106fbda068c1fdb2c6fd1cb1babe7e
-- 
gitgitgadget

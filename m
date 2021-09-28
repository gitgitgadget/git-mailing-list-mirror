Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6AFC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE90961139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhI1NER (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbhI1NEO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52719C061765
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i23so58002736wrb.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWzZNSZlLqHb7JiYN949u/XL/6K/WmSSl3phQ7/XwYU=;
        b=IK/MNHFWVCy9tDDavKCFH4YMbnGm3VSwy5I1U3Zz06/eeuLT6/TAYkHKh3Zl1iyKfG
         vdEGMQmfn5hcD7Im1CkHIVr4Fxuww39nmULzRv5FyIHbd1fUvt49D0YkZ42AdjKZ9HPm
         R8V8AcJMgBZh1g1hX95GoapCEwuWJvL4fnEIFfflcrkk6w2sC9IAU2sQrpfCO2shGzeP
         TKmldU2A8s2xzHq0otVDbh+qLlbXUXr+mPXlc61ki07Hsj9zrYceRJZ5kEC5Ndv+UFBh
         JIkqkAtqN+bNYwOaD7LQGm9Bl5RUtGv2QYHmK9mDWtIw0stH1vG7/tYQ5gOWmuTUYUf6
         j6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWzZNSZlLqHb7JiYN949u/XL/6K/WmSSl3phQ7/XwYU=;
        b=RRRQ9i9pymB8OP9zHvBVv/XTKrc5p0RXMEVzCl00xMdKj54CcM0QueSLQzEGYE/Xx1
         6vIng7p4rWuSTsO5GxH7ZLpqw+/m+onIR6rMq6/pbD4ey6uxPzwn+osfXL8HAWn+gqG9
         R4kXgHwOMbXRO5MAa5uV49igHLM4gqvm5AZEgoGEWpvpMpPle1VmIK+k0mi3WqWJlcwi
         ksFWdXGhFPvxGE0x2mcgVQ/BoG2cho/I5ZSPIegFajWyt7cuA9fE7jLBOnRNR/diosX4
         S0E9supawcr2glVZp+uCK5sBO0dn1HDfLn8xm+YMgHoowYOQl9TXYQfO/mSdxYUpbd4p
         A5FQ==
X-Gm-Message-State: AOAM530RY2EIyrGhoXVIItUvKI+xTs/+hdIBURuYRbDc8tqNLAa9QEkI
        ulv08rB1Os0FXqiTfPPQXmV81Frwy01pnw==
X-Google-Smtp-Source: ABdhPJwkDhan7qB6TFcNrDzRrSlGSeXj6KP4Qs12dGTRD+bACrtcvc8HRxVIkJUtsrva4iDz1s3kZQ==
X-Received: by 2002:a5d:5746:: with SMTP id q6mr6314668wrw.434.1632834153017;
        Tue, 28 Sep 2021 06:02:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm20180669wra.38.2021.09.28.06.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:02:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] refs/ref-cache.[ch]: remove unused add_ref_entry()
Date:   Tue, 28 Sep 2021 15:02:22 +0200
Message-Id: <patch-3.5-962c1bffa21-20210928T130032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function has not been used since 9dd389f3d8d (packed_ref_store:
get rid of the `ref_cache` entirely, 2017-09-25).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/ref-cache.c | 9 ---------
 refs/ref-cache.h | 7 -------
 2 files changed, 16 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index e0feebf628f..a28883768c9 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -212,15 +212,6 @@ struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
 	return (entry->flag & REF_DIR) ? NULL : entry;
 }
 
-int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
-{
-	dir = find_containing_dir(dir, ref->name, 1);
-	if (!dir)
-		return -1;
-	add_entry_to_dir(dir, ref);
-	return 0;
-}
-
 /*
  * Emit a warning and return true iff ref1 and ref2 have the same name
  * and the same oid. Die if they have the same name but different
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index bd1ff578ea2..580d4038f62 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -199,13 +199,6 @@ void free_ref_cache(struct ref_cache *cache);
  */
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 
-/*
- * Add a ref_entry to the ref_dir (unsorted), recursing into
- * subdirectories as necessary.  dir must represent the top-level
- * directory.  Return 0 on success.
- */
-int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref);
-
 /*
  * Find the value entry with the given name in dir, sorting ref_dirs
  * and recursing into subdirectories as necessary.  If the name is not
-- 
2.33.0.1340.ge9f77250f2b


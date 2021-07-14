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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C4C11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE4A6101D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhGNLqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNLqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:46:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901BC061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so3699989wmb.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4YckRV94lI+Ux8z9gYZhCTewo4+hmIcQEr+Iu6x6VZE=;
        b=fgGO3S2PxnhnTnScfCnIHd8vOitXHHDRFQxbypxENr2U5rgKzn76ErOPrYsh3QOLZB
         PJjhT7zBOZh7GifmsSJ5r9nPRiORVqNfg+y8w6Q406hMOD3rb3FVGCTwGFLd9I7zYR6p
         1C+CK1IxoFTUclwoKIWzOCvSH0HsbfM8cM/gaaIt5//J4v9Odb/cS1VsepsAFIeTB6cu
         B+oFz2WLislrR+AsQjYypIMfb2jwn+NqE6KywPLqlVErOgu2hLxcJnjD7e5Omk9CtL/X
         nGNMDA20n/OLFzkPDVPafvEQ29v7wUS0EpI1IHHP0UqYUEwkoUodCdm/FZtqwkp2mvj0
         q2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YckRV94lI+Ux8z9gYZhCTewo4+hmIcQEr+Iu6x6VZE=;
        b=Ncotz0k4EkevQmE/CPAWCJ6VDo5HmbBZUMSW4FunpNReAu0c/KiBCXcpH8r5YvEedy
         9SUrWBmNRbqfTwNJkhmwhhTGMxhbDjUdaj0W2BmmGDbsyZtxi8znjWSY1FDW/BGWRKCU
         kwpcuE4D36/Jusc5pp5TbyWf/dmQtGK3vLVxIQMcuKQtVkggWWTysZn0vyRSh5syL/Tp
         i8Rs53GGbNKqAHS11bmK47bwakQqE/B1nPkBLOyWWZ3GIIs02HnobhT+pEVOpSYckKv1
         WehlXTE0roxyPYveNIO3BY5yuf2BtlNFdkifaNXSqY6JVaJGIPzIswJ3CEbrrshGCMw9
         5eSg==
X-Gm-Message-State: AOAM532sUTknIivvz9g8VWxL9tH78l76McSzvScufa4RBhI3EjtcI5Mx
        5Ldb6yBx/ZRt7XFKBKYrSL22SM4gyLakWN07
X-Google-Smtp-Source: ABdhPJylf7ggIJApl54jZiegizRlxsvZ0+0VE7e0HCuKPAYheliP2Q9EIt3sUX5x9EZ2zE7MNP2Uew==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr10772352wml.116.1626263018509;
        Wed, 14 Jul 2021 04:43:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm2373626wrt.61.2021.07.14.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:43:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 1/6] refs: remove EINVAL errno output from specification of read_raw_ref_fn
Date:   Wed, 14 Jul 2021 13:43:29 +0200
Message-Id: <patch-1.6-4beba4443a-20210714T114301Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.851.g0fc62a9785
In-Reply-To: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com> <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This commit does not change code; it documents the fact that an alternate ref
backend does not need to return EINVAL from read_raw_ref_fn to function
properly.

This is correct, because refs_read_raw_ref is only called from;

* resolve_ref_unsafe(), which does not care for the EINVAL errno result.

* refs_verify_refname_available(), which does not inspect errno.

* files-backend.c, where errno is overwritten on failure.

* packed-backend.c (is_packed_transaction_needed), which calls it for the
  packed ref backend, which never emits EINVAL.

A grep for EINVAL */*c reveals that no code checks errno against EINVAL after
reading references. In addition, the refs.h file does not mention errno at all.

A grep over resolve_ref_unsafe() turned up the following callers that inspect
errno:

* sequencer.c::print_commit_summary, which uses it for die_errno

* lock_ref_oid_basic(), which only treats EISDIR and ENOTDIR specially.

The files ref backend does use EINVAL. The files backend does not call into
the generic API (refs_read_raw), but into the files-specific function
(files_read_raw_ref), which we are not changing in this commit.

As the errno sideband is unintuitive and error-prone, remove EINVAL
value, as a step towards getting rid of the errno sideband altogether.

Spotted by Ævar Arnfjörð Bjarmason <avarab@gmail.com>.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/refs-internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c93..f4445e3290 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -619,9 +619,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
  *
  * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
  * and return -1. If the ref exists but is neither a symbolic ref nor
- * an object ID, it is broken; set REF_ISBROKEN in type, set errno to
- * EINVAL, and return -1. If there is another error reading the ref,
- * set errno appropriately and return -1.
+ * an object ID, it is broken; set REF_ISBROKEN in type, and return -1
+ * (errno should not be ENOENT) If there is another error reading the
+ * ref, set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
-- 
2.32.0.851.g0fc62a9785


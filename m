Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F97C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEFE613F5
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbhGPOZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhGPOZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE700C061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so5969845wmc.2
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dd5qrkZH5laEigirq6zvsEzR3g3ZRQCaRTLgN8MtPdM=;
        b=i8TsUQRz3VUISRD9dSp7KxXBqLHohXOHHPZEMnK7oegsyQRHoqRVYbTuXt17yhLfTJ
         TdPH8ZGRW1AG6315p5O1hXrDF7AA25/w2CzyJvZok7vhKhLSbylLB+LU6MmlTiDReBpe
         RNOXB5fQIY+kUO00MpBmUJ+ghu88f/H4BowckcLRvRGSZOKHyk+PMMvjjYw796eTC4uS
         bhLktZg69Q/65WmW5xnFhGxiCPLKCbZ+rbzPxsiePfB4eDW6q5mnGdvLKTgT5ZJOcy2q
         NU5QGmgjUjRGgiJ5ncxfxcgcYrRpnV0MDLb1edP9RhlFfVY0lahM1AWc3xZoGWfrAugw
         vIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dd5qrkZH5laEigirq6zvsEzR3g3ZRQCaRTLgN8MtPdM=;
        b=ZRNNjW1JvBGnyGUbanyujLdkNvbOM5VfdbpXmmL2ii7ejYZDLCk360gRlf+xNIVkUI
         ErgQ6VtVv7eBRNfkA1ADym9Qo5J86tdyk0sFfgslzVwQNFJ/tFg6HA4Upz/MgxoPEkvF
         saWd7nIppw8TQ50KUYtcNQgDJ/TkqGhKFEK+MrzKFQ5Dg4+TCnmSJaSzjvjD4LW8zDYp
         Y30AEpXo1ERS7IyI/8b+LCQYzEHHJNfwBdXrhuq0Cdeuboxx6E/CtT68kPJuGanuqRtu
         734gSsA39cKbr0oClGt77Wko5vnfxfUnMPuaqOMoXq/6dwYvCPeQAmzucBkI5wm1BOeP
         vCYQ==
X-Gm-Message-State: AOAM532DcLRAGr/ZLHqkCJyANpgt545Wgm+hXSG2FkBDMxMAMJCZjZQh
        peUwtQbvYkGm2wZJRsiQMIURcrOZ8Acgdg==
X-Google-Smtp-Source: ABdhPJwwLzK2MZoBQdnGqRuMjvA2bDBc7zWuQMKGI+UWhhD2/cfpIsdA4pvfywe8+xHA2Kgassv53Q==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr11087058wmc.2.1626445356809;
        Fri, 16 Jul 2021 07:22:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 2/7] refs: remove EINVAL errno output from specification of read_raw_ref_fn
Date:   Fri, 16 Jul 2021 16:22:27 +0200
Message-Id: <patch-2.7-2a69bbea821-20210716T142032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com> <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
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
index 467f4b3c936..f4445e32904 100644
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
2.32.0.874.gfa1990a4f10


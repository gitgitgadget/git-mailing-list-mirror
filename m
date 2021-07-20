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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07CCC636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA126113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhGTJxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbhGTJw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:52:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A2C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c15so1849606wrs.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8NVtBzykseMSgq5/5UylxP0KhLLIOhfcfT3ZvXlLOZQ=;
        b=KWTSFXqLsY/CrysoJlCJ7kxD/w/HTcMe6sDHozXQk+x3xEwxVzINMfYQB26Nn4VCTG
         ygpEQJDXD++H98C/E7tv89VNI2LY3f8bfpgEiZei/7pVS3Z6NMo2I2dwbTbXvNGktwDi
         UNV1NYOjFMIqOxVeTBZaqKJD4IJ8IVdzMPzkrldxPMLeX7W1TbGxTlIruDemEeTz8lJG
         H9gZ0s5GHeS6jg1lopgiMRzHjKaYT48g34kBflunNZZ9XFDmwD0krjogBttdkjF3ZHMD
         i+9NUrP1WzBSRzGURkqPVBkhBax5zA0wKSoupbD0bX0Goi+V2WftXohEp4U9nqSjLiOR
         jrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8NVtBzykseMSgq5/5UylxP0KhLLIOhfcfT3ZvXlLOZQ=;
        b=YchOfgDVsB/iGTDJOWRvLMtNPiUsij2E1v2y2HhlggUaSMrHm8HOnUDSPbIGeJqnTg
         nA2J0B2LiTcymEO6nyy0iuBQSjcyx6xmuxOMqqr6fOQVmznqIBHqc37EUNPhVh93tqbq
         s2L8EiXUaWIjV0j1Hns2oSwzjqvuWd0cPiq9VKCibvpDm8bInZ+cV6AxceOzSUOfQg0y
         ch+OTjDPi09ZeLT7ZOUIW5FlsMY72BVCm9NID1BxzG6+cvVHVxQxsRkBI4Airdb4BCX+
         vsYkGqxMarCE+Ld51ZcK67uHb6aZTjWl3AnjsLqwDZoUCS/kTUL6xKD0nGiTMUF41uKW
         Aeww==
X-Gm-Message-State: AOAM533eeKnSCKS5pjAsVjsXzX7sT1ygBQc2gRuEmntQUwz1eyYh+YCM
        7LCDgBzb/d1IdWnjThuC6d9+I5IgyaB/Dw==
X-Google-Smtp-Source: ABdhPJyOaOp1iY/4NUv4SkCKlCvZUoKdrJCpUIVlNDxBrZDwMxkrcZaJSMJnHetpnZqT6KMzY2kkig==
X-Received: by 2002:a5d:591c:: with SMTP id v28mr34657053wrd.373.1626777215087;
        Tue, 20 Jul 2021 03:33:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 2/7] refs: remove EINVAL errno output from specification of read_raw_ref_fn
Date:   Tue, 20 Jul 2021 12:33:25 +0200
Message-Id: <patch-2.7-5a63b64f53f-20210720T102644Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com> <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
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
index 3155708345f..dc0d826c3ac 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -622,9 +622,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
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
2.32.0.874.ge7a9d58bfcf


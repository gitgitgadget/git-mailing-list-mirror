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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA321C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F1E6101E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbhGTJuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF30C0613B5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f190so10407448wmf.4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KY+tWZQPyoSryn7STBqGNabPfDxysc33R8mcW+m9lqs=;
        b=jebTL7FSHxZQYoH+GLrHyduYC0GltIaXDtCE09rOE8mhgb0KsYEMH+1IUDtSFmUXhG
         mC3Q8mvYdlv2HYsxDluO9VoUcGPmvFVUtac2lOjfPluqzyypqrg/6YCLb81p4h3z8RVZ
         0RooQ9hBhhjETYM0HOYkqkhuazYpdKUyT1BGlVJAYQ2iI3Zyjto0qw/d4lZzTMIgJ5KI
         i/HMH0Zt05prjaxvDaVrUp2SyHcEL9Byn+OIcSgfsxQVUREYBqIgsdRVUM2cyUs3CFJs
         u6r9SdzUju3ap4MxLHtPt284VGRwSltw/YKFfo9Iu98d/MSy2ARM9vJ0lO8WKXDkLgqe
         OnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KY+tWZQPyoSryn7STBqGNabPfDxysc33R8mcW+m9lqs=;
        b=dOm2BNqldrZ84upRkURisvbuhMRsOcCvYGk8u/DH+eu3BHgvRsK7SCY1MWDfPXYHtV
         9/Voop1DFU4AgGQwr+sXHoKh8m4y4pyOIsxk8qAsoU/rbQeszSkvInVjEHLScGAKNFqU
         YeSn60wsWDmQIVyPUdFD4FLY8St2paMd09YmcfM/N7VRw0uL4rqOjdF94P8RB4kG5L10
         xnBFyT9zJQBqAsLL2RskvuEyofwbTAEKStY4faSf7fcCylpq2YDx6PeQOmk9lh4Agi0x
         vcVcP0Nyb5g5dtrUi+/ZSLvc6nF0dRYAr/GjzT/+dycaep4r06SmmAhA30fGvNPjxj4D
         ygBQ==
X-Gm-Message-State: AOAM531i5UDG6R1g/S4xjxnUNondFCTLVGflGpf40oWwtIkAfR0y3CRj
        n7G5DHdmpbIetQgDykEHlQYTScGK5VYp2w==
X-Google-Smtp-Source: ABdhPJy6OGAPwdo8i0cb14zyZFp+0v9/ZfEKm/4vAXr+4+tClrQ2LIfeBGgmxRuclaU6ClpVWuAkWg==
X-Received: by 2002:a1c:741a:: with SMTP id p26mr30647650wmc.47.1626776665861;
        Tue, 20 Jul 2021 03:24:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/12] refs/files: remove unused "skip" in lock_raw_ref() too
Date:   Tue, 20 Jul 2021 12:24:09 +0200
Message-Id: <patch-04.12-7fb7ff97491-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the unused "skip" parameter to lock_raw_ref(), it was never
used. We do use it when passing "skip" to the
refs_rename_ref_available() function in files_copy_or_rename_ref(),
but not here.

This is part of a larger series that modifies lock_ref_oid_basic()
extensively, there will be no more modifications of this function in
this series, but since the preceding commit removed this unused
parameter from lock_ref_oid_basic(), let's do it here too for
consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a59823d667e..af332fa8fe4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -531,7 +531,6 @@ static void unlock_ref(struct ref_lock *lock)
 static int lock_raw_ref(struct files_ref_store *refs,
 			const char *refname, int mustexist,
 			const struct string_list *extras,
-			const struct string_list *skip,
 			struct ref_lock **lock_p,
 			struct strbuf *referent,
 			unsigned int *type,
@@ -568,7 +567,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 * reason to expect this error to be transitory.
 		 */
 		if (refs_verify_refname_available(&refs->base, refname,
-						  extras, skip, err)) {
+						  extras, NULL, err)) {
 			if (mustexist) {
 				/*
 				 * To the user the relevant error is
@@ -673,7 +672,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 							  REMOVE_DIR_EMPTY_ONLY)) {
 				if (refs_verify_refname_available(
 						    &refs->base, refname,
-						    extras, skip, err)) {
+						    extras, NULL, err)) {
 					/*
 					 * The error message set by
 					 * verify_refname_available() is OK.
@@ -710,7 +709,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 */
 		if (refs_verify_refname_available(
 				    refs->packed_ref_store, refname,
-				    extras, skip, err))
+				    extras, NULL, err))
 			goto error_return;
 	}
 
@@ -2412,7 +2411,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	}
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
-			   affected_refnames, NULL,
+			   affected_refnames,
 			   &lock, &referent,
 			   &update->type, err);
 	if (ret) {
-- 
2.32.0.874.ge7a9d58bfcf


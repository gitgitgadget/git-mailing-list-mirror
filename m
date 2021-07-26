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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8603C432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A7C60F94
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhGZXEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhGZXEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1779BC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b7so12995457wri.8
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZJadjZL3aza8OHq3yrDMTPC1gHXTvaojn9VV1UnHjg=;
        b=Yw5qnStsqzOiFSGtREIQPgjVIz2u0dZ/nVTQSLZfaRPC9gT5wcZeHKldvJKTnFdzrv
         srW2rYk/6OloNbN9h7gXUerXIVN0EG7UBbIaw7iC/SI4PrfymfpGVphrS5wU0jRQzFXU
         eA/rqOaAdmtuukYQuLXCoCPURR6qdqzBr3fDATlCfsC4956is8GV8wMkFUN+wDAHEsQX
         OgV3ULv/8fYNEf7441TeHlI31GV/Y90qFmd6zR4jyURn9JKkzaY+77eeISXx9D4RhmWv
         DMhQ27/z6LFtvxxPJG+n9qJz9MkkDjSZUA+P/Qtak7SP8xTO5GU4lbR1H9AbXFRF4O/J
         KIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZJadjZL3aza8OHq3yrDMTPC1gHXTvaojn9VV1UnHjg=;
        b=bzlT4vJ3/2gfjVdMgj9Vk2hxJADbg6RBSypeD+aZU4b2+TwYw35MNDQie6TWzIMj0U
         uTbzzAxG9WO+eLTyGtcF0SJCJVo71H37vLbdASVlEUv0dG+Hct3C3IOFiN4kW9tiO6AX
         ou/qViMDZg3HJ+zdU9hprdwM5sMbjGyrtYEaigqEhIU0H6E4lpplltADS5LxcT7d8YRv
         INZ1CRBFmTRQgWe3c1tMvO8Xum3S1Otd2yq6HOVcDkeSAZpA1QMB5XY+YmCHdJmG0WQH
         j9gxAex2tPCBIQmGGi1z/j26O6l5MStMARq2AycHt27LWHieBy0JJnmaQWbTG58P4y4S
         5ISQ==
X-Gm-Message-State: AOAM530QVnZToU3/qkfKevWkPax66A5y3G7FHODM8xn1tMIf2d14fu5L
        E3GkywxmxNc6uhQ7425NzFbnWF5pk83+pw==
X-Google-Smtp-Source: ABdhPJyj2FpHH2stVCZCftti5U823Y1OsF3Xd2zxLucL9hlOMe8gQdH+ChBjPM2qUODv2TM4Qj7uKg==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr12112701wrx.379.1627343073369;
        Mon, 26 Jul 2021 16:44:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/11] refs/files: remove unused "skip" in lock_raw_ref() too
Date:   Tue, 27 Jul 2021 01:44:20 +0200
Message-Id: <patch-04.11-852f86e666-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
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
index a59823d667..af332fa8fe 100644
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
2.32.0.956.g6b0c84ceda8


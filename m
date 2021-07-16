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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ECBC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF53F613EB
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbhGPOQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhGPOQR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A279C061760
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g16so12291109wrw.5
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTYiFHLwxoA2G6tuYvUmIwltasJol6cFbm5zGgdtlDM=;
        b=RF4SUtUNeEf6+VvZsq7kwxRqVmI7mcDOZ9H5i/f+8EMs31DtH7M6Wb3kTwBwbYP3dZ
         nGlconKGfMjwsEY2Qe32qt/dEjYSPfRP/scxuKGsLsp32IQRQ7yVyMpmSvjL/0yaTb6S
         vx+2e20NC9G64qd+QRv6E+JKM9DfH7WwBNeKPKHddKqRPu1b7Pc7DEpimkE127s9aFBC
         ps7laAO8OGND3VVul2NGIYftjdwIfV6zNitGVACOLJ1FgaxKoyEUbR5z94+m4HiR8YLB
         3QX6pPpBoco1zgP9f0LX4pFJFV8ejfcjaWPKSx83gOPJILfZuft9ODMB4RZY79mQ322m
         1GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTYiFHLwxoA2G6tuYvUmIwltasJol6cFbm5zGgdtlDM=;
        b=mtKDwnactbzue4nv6yxnUUVRSp5nfUBEtz4pZ8WMQ3DkDozh331CbWZjWfGVDjaKWC
         b6SYUriVJGm3YGzlIf164W/RRQEF9Bu8D8xW1I9cUPACHtdU0f1K1So9BAcrTMOGOk+K
         FdZT4T9j9MpUfYbP68Vq7xR3lJrDZFUBJ55hwpiTpucKz3W09JrUTMlveBUn/TF1RTVn
         fAgk3hvYmOiGmY1AYmY7iKO2L/WH1PZXrJWAanHx8G3g4Y0WEDx+l68HmCZdd7ZixvXq
         OuwDV3NyjzHKjFKXztn++6uuaaU3sLgHVJWjGZHXER/9ScBbeDDPSNp59Gzq2xExaMCw
         RsZA==
X-Gm-Message-State: AOAM5337f7FPlhVSzmr4vbDSC+6m023XvXOiMbjYxu9Lnucv3hVgl27v
        Vw6LLbYlMAH6vLOiaOVpPSn6pYJLgD9lnQ==
X-Google-Smtp-Source: ABdhPJxJCNoqQAUo7iF29SPd48CnGHLKEenvi13LeFuxymoWzLRax655ov6kPF7h2wLipko81Xjxww==
X-Received: by 2002:a5d:6501:: with SMTP id x1mr12413158wru.169.1626444799865;
        Fri, 16 Jul 2021 07:13:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/11] refs/files: remove unused "skip" in lock_raw_ref() too
Date:   Fri, 16 Jul 2021 16:13:00 +0200
Message-Id: <patch-04.11-61f9e0fc864-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
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
2.32.0.873.gb6f2f696497


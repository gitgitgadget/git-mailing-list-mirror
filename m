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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C3C4320A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2023461378
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhHWLhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236494AbhHWLhH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7209C061764
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u1so10336140wmm.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkVLWDGCHkfK8N5vklaasW/9asq9Tm8FgDwK0N75EHs=;
        b=snxkXepySemk34SQDdTxSUW9Qv3En/oJBdEaUu6f1FDk4M2mY+1GZ/AVyN8NX/qNUD
         jDmx9DlASGOqmZ7f3AlahgWX9ib3JtLwUAijXSmTywLQYsyM6/Xl+RDRQzCzMndBdaAV
         UHSTCRiTDNTL+OweQz7OElOUITNF5RF8ijUyoinx1qpQ6dPQ3gAr+Uj9mXjlJoT8VThQ
         FpZG08VbltkFL2tVkDMrtVHgC3fzidL9O7+tlWrAFjq04A62Y9n+Gh/fyFjYhczZMYUQ
         Ez7mMV5OiAn8LNiTloMsKcC2e1+aBymtbgPaRLFPe2SCCXTOKeETnYm/8ear4+DBkS1q
         lbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkVLWDGCHkfK8N5vklaasW/9asq9Tm8FgDwK0N75EHs=;
        b=Yp6EFYHuO0aJwV9K7SABqRH6O6YhlhKdy2YCdai0N3R2XglL4uABrX7FarT9qPq69Y
         vRHd0oVTRnQqYT3KK03CaKsn2Zg5Cgl3X8W3Xz4gOTmwnuMVcihG59OQcX4OlZkYsQKG
         A6CQh5JhRxSRHJ825CJqceF+eOyzYFKXMmiKy7qdr1fbIVMQ7qHhx6AuIzlqcXqajNTA
         7tf/B/OYgJb+tPGmQK2JrX527smOial8JImMDZGeXqQcxuMT2b2imfbOaMLmthGzjsNC
         u0HTTgki2tTQ3RtUWTH0wdlGEjDe6rCygSaLBa1vvFKFBA29jh4pcT8aZqC4bm1M6nsn
         /t8A==
X-Gm-Message-State: AOAM531FVFN8Kn33RTMsz921FckSFW+ivn7AibYyziotj0N/3WCHL+vE
        XGqrVZQyHwgRWMwsjqU/Qi9/bB3mDGduXHfj
X-Google-Smtp-Source: ABdhPJzaUpN7D+eLRZNoxpiNN1M/bgpvYQ6GQxxC0UTs5gzpOZW4nEn4O3/bgJQED7PWLtNZekyfag==
X-Received: by 2002:a1c:1d1:: with SMTP id 200mr8125730wmb.53.1629718581201;
        Mon, 23 Aug 2021 04:36:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/13] refs/files: remove unused "skip" in lock_raw_ref() too
Date:   Mon, 23 Aug 2021 13:36:06 +0200
Message-Id: <patch-v5-05.13-b7335e79f8b-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
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
index 69f7f54e03b..997e021c1c4 100644
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
 
@@ -2407,7 +2406,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	}
 
 	ret = lock_raw_ref(refs, update->refname, mustexist,
-			   affected_refnames, NULL,
+			   affected_refnames,
 			   &lock, &referent,
 			   &update->type, err);
 	if (ret) {
-- 
2.33.0.662.g438caf9576d


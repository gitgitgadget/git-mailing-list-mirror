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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79130C07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EAC6117A
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhGKQdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhGKQdo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45060C0613F0
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d12so20507661wre.13
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slVCEbpC68iN+1wykIByDC9NFAOozpz9S0n3idpjG/8=;
        b=PuB0dqCNIypR1iPNe14nHlWIwg8NG9RXMkUdTgu/rr7Zfd6DvkE75M3EtnqsU/1qvW
         HVSQcQ88iGMJxQ05fX37ozsBvBgkGFVLnBVtmqXAmYqCnouXcfaelsEVd6YRPy00wxPv
         DbxZXAfZFaJl6ihPi7tzBMKXXc5XSm2Waz9LL2f9hIbY38wdIbA4OliV0hEw0oIx7R2F
         bvHsVLU+cUSmb5oc/El2V+dLOTWvUfyqx1Vcg2YFofcyOn6KEk4djB/Ge7HUl1ZbqYro
         LIEfxhSCLWVwoxhydEfnRIV3hmBNS61Gvmdb+YuxpClm8zHebxLEp7KwTMavxs4I+zJ1
         /Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slVCEbpC68iN+1wykIByDC9NFAOozpz9S0n3idpjG/8=;
        b=ggaO5krCHqW8WliEPjZ8CNll4VJ+a2gVfPBZM+XCvC6LFU3x8mie8aLTnrAz7PqBQP
         u49mAVobMusTloy8232kZ9hnqKVWLFVAc09gLDNP4UzS2Gd0G7o65GwlvTR4V8AO5Ypo
         oBrpaP7TU/zV0zRCrhfrPCuWwVWekten5+xSgCLdG8s7Dy/MpJ+FVZNdSbaJiLx28rK8
         +CIPeiTF2Qeda5anJErfRRGuoyeEMXFb8XE0pwRNfhVB7n9o4/J5IhgnpNdLDN7FJXMr
         Z1dIQu8jeiawS8Xygm+IKJ3N7giOgfzgTifFlQcoW5N0qxc7m8wrpHxbrEmhAlX+e8q+
         N5aA==
X-Gm-Message-State: AOAM533wI9pNOGtI6/N2EWJmhA5mTWDLp/NE3C32EKhVS4BwnMZIGhIw
        5wKIH6rkKxwZuqjMqW3xvb3XrCH1i7t7KQ==
X-Google-Smtp-Source: ABdhPJxRqI4w7YbTAEpTWKxcdBtHzDLG9wGvlvzC2OMI/dHHisRlnpaVFLxbpGwE20PuF7qOl285Ug==
X-Received: by 2002:a05:6000:1141:: with SMTP id d1mr28651665wrx.396.1626021052617;
        Sun, 11 Jul 2021 09:30:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 08/17] refs file-backend.c: stop setting "EBUSY" in verify_lock()
Date:   Sun, 11 Jul 2021 18:30:32 +0200
Message-Id: <patch-08.17-ff38a3f1936-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This EBUSY was set in 835e3c992fd (refs.c: verify_lock should set
errno to something meaningful, 2014-06-20) to fix a bug in code that
was later refactored in cd94f765720 (fetch.c: change s_update_ref to
use a ref transaction, 2014-04-28) to not use errno at all, the two
were a part of the same series.

So this was only ever needed for an intra-series bugfix, and we kept
it around for no reason. Removing it makes subsequent commits where we
refactor code surrounding verify_lock() (which may use errno) easier
to reason about.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4e9344ac8b..abed0572fea 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -880,9 +880,7 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 			       mustexist ? RESOLVE_REF_READING : 0,
 			       &lock->old_oid, NULL)) {
 		if (old_oid) {
-			int save_errno = errno;
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
-			errno = save_errno;
 			return -1;
 		} else {
 			oidclr(&lock->old_oid);
@@ -894,7 +892,6 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 			    lock->ref_name,
 			    oid_to_hex(&lock->old_oid),
 			    oid_to_hex(old_oid));
-		errno = EBUSY;
 		return -1;
 	}
 	return 0;
-- 
2.32.0-dev


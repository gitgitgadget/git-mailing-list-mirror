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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8893C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07D061175
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhGKQds (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhGKQdo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD593C061787
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r11so15889108wro.9
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdL2+R2Jjft+ZwBfwukMjoVQZrRrFOveq9+G63RgWsE=;
        b=bOHYLqNAT5YX296PBty+SPOcWcG6H/5qcTbX18RKhRaoOtcYpMgISiQ1Fms4mfskCH
         Pwdm3rgprrJBl5OiGUGH8+Sq9Tub5PdWT0n1Pg8gFjx5/hhvxUcE9nNLpl0MKp0P1oH0
         hT+JgkkbqCGZdhOKEnHHr0hCr83XH/TwYtlJXkrf5zLcME3ReC8TuN+8K2mLXKYl5WN/
         044AoegvIkTMAnzTbO41wG5EEStxddNqQShkOc/1wgzfqqtnwPQ6MNkYP6RP+myy1vpH
         cIz4pLAgQ6/tc3apsxlmGqXlBMqrl7k5lTldnQofrLVDrKrBz54/TlBBhcPzgXAq/mXI
         0Z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdL2+R2Jjft+ZwBfwukMjoVQZrRrFOveq9+G63RgWsE=;
        b=L01O5Toofg2PjzKNpSEI0QyXxQKDRamNj4zkXkIHFDESF31vuwpFjeyPP8aPW+8UVc
         o2Z+HcgXC2U6eVTle5YaR4PimXzt/7TWtJ7n56tyKg7BDxUW1UuSfq4nMqIWY0qb8ulF
         0DSbsoLAIBp6QEo+4SE+3nviLlsYGsTbugu2eL1LDDO55IXrdgPyKkcfW3p8XjiM4yCl
         LLqeKxHgoFkxtXbH0v5dZtSyvOsJTQtymckP4/OMqxV8t7ajy5UY0tOzp7Nt87dNHu9y
         mI/GfouVKlLN7WBWFqvTGnqLyM8vayQ3cxqHbnpjoHlNdQ4UIx/vUqIGeWXAXKbXhHvi
         lo/Q==
X-Gm-Message-State: AOAM532C5j3XNzWc02+XrTslO/seRwbTbVPWMSgaBUPstqfonD5hN2+I
        YggboTVH27M6rjrYWWYJjt2NB5w1NZkttQ==
X-Google-Smtp-Source: ABdhPJw2Xv687K8noLKYXCpW9GTxS6h1EjFxxVEfB7784TZcMh2LBe7URW9Vea3TXRHRUcLX0JL13w==
X-Received: by 2002:a5d:48ca:: with SMTP id p10mr53722646wrs.87.1626021053331;
        Sun, 11 Jul 2021 09:30:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.52
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
Subject: [PATCH v6? 09/17] refs file-backend.c: deal with errno directly in verify_lock()
Date:   Sun, 11 Jul 2021 18:30:33 +0200
Message-Id: <patch-09.17-cdec272f06f-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the refs_read_ref_full() wrapper function let's use
the refs_resolve_ref_unsafe_with_errno() function it resolves to (note
the inverted return values).

Per a preceding change to remove an "errno" assignment from
verify_lock() we can explicitly ignore errno here, we use the strbuf
"err" API instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index abed0572fea..e3d27001b86 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -874,11 +874,12 @@ static int verify_lock(struct ref_store *ref_store, struct ref_lock *lock,
 		       const struct object_id *old_oid, int mustexist,
 		       struct strbuf *err)
 {
+	int ignore_errno;
 	assert(err);
 
-	if (refs_read_ref_full(ref_store, lock->ref_name,
-			       mustexist ? RESOLVE_REF_READING : 0,
-			       &lock->old_oid, NULL)) {
+	if (!refs_resolve_ref_unsafe_with_errno(ref_store, lock->ref_name,
+						mustexist ? RESOLVE_REF_READING : 0,
+						&lock->old_oid, NULL, &ignore_errno)) {
 		if (old_oid) {
 			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
 			return -1;
-- 
2.32.0-dev


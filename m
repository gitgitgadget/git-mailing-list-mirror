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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56DC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3CC61175
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhGKQdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhGKQdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42764C0613EE
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:31:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l7so20211392wrv.7
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8nMyCyHolcaK2kOMgpAUGy+3zXJjg/kP9UbsXFu6KwQ=;
        b=a/7EW5rJD2h8C66/0tdBcidB6GSdSrcNKJHJbdI4V3T+acJNWaXpp6psyCQ/onssPu
         N1S7tL1FBcS20yr8zCKeTeh8yKOa0RlkDE3D1VO2GCWMxwM2So6K3pCpLa+76x6Dawop
         TOVWGtPuOkK1+9zmwKgnMsOvHN6LVPXT3yZxrf6ty+M98F0B7z5qfBlULazOKDldB8V6
         Vw9YCdfb84lmTCI7uAMeMO7agtuKxXGdUAlySPJ644SK5Dodv44TkiCtoGheEl+fgmlN
         t++MNiMR0bW/HDh2EdM0bzAzbL44PoQulyQGfuvxVQ6QdnPaWo5gu8pgvSUu5IjdETFn
         SQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8nMyCyHolcaK2kOMgpAUGy+3zXJjg/kP9UbsXFu6KwQ=;
        b=ZRk+7IJ74petmrejFZ56Yj8PooQ+fkRiq2vV+2URd/9R/44opnbhgZOxV4jxOqT/0M
         9h6hnE9hiwzXoxM3L4DHxyn9iUncWYrQaaZ6GSec8i04rKVM4XrPQOkWAjFssnWyRiZL
         ih54iQlWI+7CDmJcz2opXUo3gmGVxFrf15c2/HaQxkncJj8D9PZRS0HA5e+REAu3iqQE
         Z5f1u67UpJiVuqRcROtMrOKa9J2o8mBvRGG7qcHRpvzSo/hGM+QmvtVvv/VZT2negLV+
         4se2Kp8bbRudUo2wAJ7h5Sw9xe05kiF0D3UYt+heDaWk0w2k6P/nab/BZbO4hvMV8KCz
         RWSw==
X-Gm-Message-State: AOAM531Uqvaq3xZR4Z/W/lNct/fCGp29Dk6OiNzjRxhwquXyPLYPGP2a
        D+cQ2f8IkvJPG4ZuWfUMMDg3xL5UzJc8Lw==
X-Google-Smtp-Source: ABdhPJw5ieDGoejcF8eAZcJ4B7c18eHmYAsh6CAAyLBrg+RXSzPgYtYH47T6JXBvmSa+Gftb5XrAlQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr54141232wre.419.1626021058660;
        Sun, 11 Jul 2021 09:30:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 16/17] refs API: make expand_ref() and repo_dwim_log() not set errno
Date:   Sun, 11 Jul 2021 18:30:40 +0200
Message-Id: <patch-16.17-37c5b88d7d8-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of these two is rather trivial, and it's easy to see none of
their callers care about errno. So let's move them from
refs_resolve_ref_unsafe() to refs_resolve_ref_unsafe_with_errno(),
these were the last two callers, so we can get rid of that wrapper
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 1d44027497e..3357ba14e1d 100644
--- a/refs.c
+++ b/refs.c
@@ -267,21 +267,6 @@ int ref_resolves_to_object(const char *refname,
 	return 1;
 }
 
-static const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-					   const char *refname,
-					   int resolve_flags,
-					   struct object_id *oid, int *flags)
-{
-	int failure_errno = 0;
-	const char *refn;
-	refn = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
-						  oid, flags, &failure_errno);
-	if (!refn)
-		/* For unmigrated legacy callers */
-		errno = failure_errno;
-	return refn;
-}
-
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
 			  struct object_id *oid, int *flags)
@@ -675,13 +660,16 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		struct object_id oid_from_ref;
 		struct object_id *this_result;
 		int flag;
+		struct ref_store *refs = get_main_ref_store(repo);
+		int ignore_errno;
 
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = refs_resolve_ref_unsafe(get_main_ref_store(repo),
-					    fullref.buf, RESOLVE_REF_READING,
-					    this_result, &flag);
+		r = refs_resolve_ref_unsafe_with_errno(refs, fullref.buf,
+						       RESOLVE_REF_READING,
+						       this_result, &flag,
+						       &ignore_errno);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -710,12 +698,14 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 	for (p = ref_rev_parse_rules; *p; p++) {
 		struct object_id hash;
 		const char *ref, *it;
+		int ignore_errno;
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = refs_resolve_ref_unsafe(refs, path.buf,
-					      RESOLVE_REF_READING,
-					      &hash, NULL);
+		ref = refs_resolve_ref_unsafe_with_errno(refs, path.buf,
+							 RESOLVE_REF_READING,
+							 &hash, NULL,
+							 &ignore_errno);
 		if (!ref)
 			continue;
 		if (refs_reflog_exists(refs, path.buf))
-- 
2.32.0-dev


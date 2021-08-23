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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0796C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876566137B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhHWMOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbhHWMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF5C061292
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g138so10382367wmg.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJnulIZpD+Lj9g7edzXRk+Bt6LI/3p2ktZZS6HhCRZ0=;
        b=kDQ4tCL949BskXHdc848tgCkrlN+mGFVfNUn8YQwUJIga6QyK0RbdZb/W9IU3/01vH
         5zlefpc81YBa5K3+RwrnRMMsbkHsSOEORnY2d1H3EqnNCcqyPvgzgI69uLq6VcVbZWMF
         R7fewcjNib3YfP9Nn/9GZxAfW33oUz4NomceS0q610EPw7ygKjRFK/Q8w5MXY7bUYI5a
         7V6CnenVTU1eJOfFyviUl1dEKJ2EdMmPez+YFXbo3BjmgodomtUcRN0YNr7puzeyvvYE
         Pf8km2vLn52RI0LuLyX1q3gFki68OIpBjOTr5zl8LFPlwd0+ILfKqxOOIRhI47lCA7Ha
         HhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJnulIZpD+Lj9g7edzXRk+Bt6LI/3p2ktZZS6HhCRZ0=;
        b=s8Jt3w218rbO+LcLXwEKWMosNpq4zR2AvvseAdIgIrHqcovplMmc/S1moqUy9VxpZG
         RMReR3irhqistYkO5pPzjRjUJ5mfm4Uo6pO8oPj1GkLOIz+gURdCuSs+ef2zlauDPWUT
         ZVt1C/6uK3ukX+YeHymyGvKkQLbCugNS3cDc7uis/LBXahZ5EnLSFrVfQiKyy4Qzlitl
         /fzDIM3CtSpwpW4pSnSbM/xek05BwTKC/oSJkI+zj4pDEr8rjNeRU4rzDRpC4pvGiNgm
         OsgVyBlpb+PHjaOY0TdOsoOcQdngvHq8HSgBloWxAJSoV+CkgVkOofPzDDapKAc+1hwD
         9I1w==
X-Gm-Message-State: AOAM530u5K8iqoAfCBy6s2nu0/k5neEn+FlTJV6wff7DFH6TQRhhedOV
        4tfDHB4GaZF2MH6wjCx1e1XqsJ98DCMDqsIV
X-Google-Smtp-Source: ABdhPJyuAiSjqePwsTHMXPF+blK4w/hqaK7du1KHPv2Cd45xhoYs/EUUEqG2NgxCNvJ/U7tfk1JZLQ==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr16197448wmk.51.1629720798412;
        Mon, 23 Aug 2021 05:13:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 27/28] reftable: fixup for new base topic 2/3
Date:   Mon, 23 Aug 2021 14:12:38 +0200
Message-Id: <patch-v4-27.28-c4f9fb42d9e-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since my "refs API: remove OID argument to reflog_expire()" we don't
have the "oid" as part of the reflog_expire() signature. Instead the
reflog_expire() should pass the OID of the tip of the "locked" ref to
the prepare_fn().

In files_reflog_expire() we do that by getting the OID from
lock_ref_oid_basic(). I'm assuming (but am not familiar enough with
reftable...) that by the time we get here we've got a locked ref
already in some way, so let's just use
refs_resolve_ref_unsafe_with_errno() to lookup the current OID of that
presumably-locked ref.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/reftable-backend.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index dcc792e5e87..94917c85cf7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1463,7 +1463,7 @@ static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
 
 static int
 git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
-			   const struct object_id *oid, unsigned int flags,
+			   unsigned int flags,
 			   reflog_expiry_prepare_fn prepare_fn,
 			   reflog_expiry_should_prune_fn should_prune_fn,
 			   reflog_expiry_cleanup_fn cleanup_fn,
@@ -1497,6 +1497,9 @@ git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
 	struct reftable_iterator it = { NULL };
 	struct reftable_addition *add = NULL;
 	int err = 0;
+	int ignore_errno;
+	struct object_id oid;
+
 	if (refs->err < 0) {
 		return refs->err;
 	}
@@ -1515,7 +1518,14 @@ git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
 	if (err) {
 		goto done;
 	}
-	prepare_fn(refname, oid, policy_cb_data);
+	if (!refs_resolve_ref_unsafe_with_errno(ref_store, refname,
+					       RESOLVE_REF_READING, &oid,
+					       NULL, &ignore_errno)) {
+		err = -1;
+		goto done;
+	}
+	prepare_fn(refname, &oid, policy_cb_data);
+
 	while (1) {
 		struct reftable_log_record log = { NULL };
 		int err = reftable_iterator_next_log(&it, &log);
-- 
2.33.0.662.gbaddc25a55e


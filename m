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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C901C636CE
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7723F61242
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhGTJtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD3DC0613B3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1287541wmc.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAIwz2LkcNS7M0zdOjdG//UwSqGXWyC8Mh97oVNpkkY=;
        b=K/PmAAlz4tngDuqiQJqFi2pk0VrSSgr8/NJFg2St5AiU9XdKmQY03hQ7Q5IJZ+PGry
         Csz0iT1g5cr0glh1xfgXFs3CsNZpHvvW1UK4Vwx4dcrmfdjaViorpGUQLLztbFL0//74
         5LQtFGA+Q2FW0RY00ar9hlTf9vz6SnRKl6E9uuGCZHUYLkHosGAKb+kxLxVeW/E2d68Q
         IOX1LCqsGl/spl7VQPtkB61mL0JFhI1ShnSHwvaGRHXJ50ai0F9MzkbJ6ExXYHS/1ZC2
         RoA+8pspLQEKgXjmtlboDJc54F9+XEDbx5bEbfStXA5WeoWGbfZk+yVWdQoiQsi3X7YD
         1URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UAIwz2LkcNS7M0zdOjdG//UwSqGXWyC8Mh97oVNpkkY=;
        b=ZX6VdsHbbjdLWEPCDuOSRwhm0WlLkW7kjqANGB3spvFxUMlrpyYMNtMytrbK7SKJyn
         xuBtsD9vd+Vob3qKl8zN2FVnVyC/EhrvZjLOeGWs51UauOPl5u2pTw81K1t7Erx32rO6
         FwMw5XmdK9ubsI1bTv1LKd3RSY3hYWndsfE+rKg0YEPxaxSXnlVlq9uRfgBfIrBR0V0f
         KquVn7zMvGeXMjgsDlO3evWrp6KsBdJnuvfRxzizUuO5FQsQFGt8m/bOpdk4sMf5EiHE
         1ORQmYtqBRJXbeMxjEQtkpwTbt5j45XyX2NBONYEfnR15Czqia9ajjoz+nrCI3IUKiKM
         Zr4g==
X-Gm-Message-State: AOAM532Mp7xsZTEkm13YzEhwIHFgX/NMBfBeVqPHW1+RaeT+7fp4LdhO
        0K3lNulXFNOs+AccGTBDbdG8DtwPjwYSXA==
X-Google-Smtp-Source: ABdhPJzWrddGlpgNaJ4SkQrf+bEMijxuhfIedF3DO6X8iouvAvO82eCRlQnH2bjpseCmjScguftc2g==
X-Received: by 2002:a1c:4c15:: with SMTP id z21mr30971449wmf.114.1626776664334;
        Tue, 20 Jul 2021 03:24:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/12] refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
Date:   Tue, 20 Jul 2021 12:24:07 +0200
Message-Id: <patch-02.12-dfb9e34076e-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lock_ref_oid_basic() function has gradually been by most callers
no longer performing a low-level "acquire lock, update and release",
and instead using the ref transaction API. So there are only 4
remaining callers of lock_ref_oid_basic().

None of those callers pass REF_DELETING anymore, the last caller went
away in 92b1551b1d (refs: resolve symbolic refs first,
2016-04-25).

Before that we'd refactored and moved this code in:

 - 8df4e511387 (struct ref_update: move "have_old" into "flags",
   2015-02-17)

 - 7bd9bcf372d (refs: split filesystem-based refs code into a new
   file, 2015-11-09)

 - 165056b2fc (lock_ref_for_update(): new function, 2016-04-24)

We then finally stopped using it in 92b1551b1d (noted above). So let's
remove the handling of this parameter.

By itself this change doesn't benefit us much, but it's the start of
even more removal of unused code in and around this function in
subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2..326f0224218 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -934,8 +934,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_DELETING)
-		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-- 
2.32.0.874.ge7a9d58bfcf


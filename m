Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DBC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C7361CCC
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 19:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhGGTKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 15:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhGGTKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 15:10:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63504C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 12:07:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a8so4295739wrp.5
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=28uzDAeGOKcnmFSDAZZdAYg3F6G6ewQ9Uyr464q53QI=;
        b=CpOgMXFrhB0ZUaffLLDVxsE/e03+25XWXPBqBfhfKrH5GqglaQ9ZOb6NotjKli/LXh
         r2oXFlsuOuKaNTuCIHLa5HF+ggzrsTRm9vidTyuY53HgMYpBUprCQxfeb4ljr1crq420
         qUNCoHum91i13kcRi4/8cSwjOao1rInV8EfHy0DE9N3xno/3hcCCbZLmCw2ewSe/WqN1
         0o5d9uVp/xE9wV0tzOvVJkn1xo9C2u80+CvTFAg3sHavqDyJ1tJIdsdDhcSrzXGURb1v
         ZpezadfpT7z8XH1LKg7w0oUOOuLynPgOIBwv9aWB614ji1CB+IYe0+hNGYeUKK0cHwZz
         H92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=28uzDAeGOKcnmFSDAZZdAYg3F6G6ewQ9Uyr464q53QI=;
        b=k89YR3UvzHZYyGNwh2ed3vW9pF5CK+nYo8TbfMlliVN4/zv8z+A1nHCGqHN/YyWWd8
         bG/xUdNGRo/jpdMO0e+kW2aBiz3FMkmuv8qmVS1NH4bMrvaORNd/yQJec9Gp9PkeoUV6
         AmeOGcpM8RCJFckEwLZxWo8vJq2oQ+rpxpCjcCWsbGRkbbbenpGx0rcMIBmgcKMIX2aB
         fV+reSVDxLYLTar9WZB+nkgIfITuYMY03jzuvieiUtiBrQtWR/WXr/CFWe6ZgDb+dDjy
         D2y68Vn23BKoojuoyjen3b/lnF2jRjIqnkgGjpKaka3FZ9eGsQTmZDiTRFbNhhGw0RUP
         ibDw==
X-Gm-Message-State: AOAM532RVAdYVvK7sYNonZbpb52p7ufDxaU7g1kxU/Qbjs9pczCqu8cH
        gNB4etcjEIaUlMP/Ru8kdgSFZc/Wb2s=
X-Google-Smtp-Source: ABdhPJxFoGjl+T3mL4cyV1Sdzv3oCEyOxI1Tb8FjExGnjWQk6o6LiF26mkjH1zR4ktHPAHHPY9M8bg==
X-Received: by 2002:a5d:4086:: with SMTP id o6mr3006626wrp.379.1625684872019;
        Wed, 07 Jul 2021 12:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm21258619wrp.44.2021.07.07.12.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 12:07:51 -0700 (PDT)
Message-Id: <d6a41c3c0cb8bcd3d65f1273431f266541a96754.1625684869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
        <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Jul 2021 19:07:44 +0000
Subject: [PATCH v5 1/6] refs: remove EINVAL errno output from specification of
 read_raw_ref_fn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
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
---
 refs/refs-internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936..f4445e32904 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -619,9 +619,9 @@ typedef int reflog_expire_fn(struct ref_store *ref_store,
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
gitgitgadget


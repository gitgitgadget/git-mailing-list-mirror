Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37661C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1677461205
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 20:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGEU6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGEU6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 16:58:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77598C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 13:56:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l1so12142732wme.4
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rLwbUcyqZa4V72hV5etU85rDGU7np/UT3Sn1ACjR9rw=;
        b=Kmmdy+Q0LM4x3mAqXIZ+rnZ2ydHEsQ7C+OjmH4oRsKodn3U91418/h/b/uEjw+0YOI
         7DekkAIDojPV0V6+tWlfuW7fNA3LW3ZwwwsiEkvo6xrHSPBPzsynRSNp/OJuI/Pm52t/
         36aFQDwQKkFYyQL71IETPF6xoTaB3rHNrODIpjq6qVlxipXaHy8gYawCuCNlcyjC+D78
         9N758hZTmtyV/Rsx4EsdhqrCZBF5KtZTe/TpP6wsvWst1IVeS7LVPzMJEjRJa3U6IkdT
         +2hFOINRqPAaq0t/U5HIRJyJEbi157LCxwmdcvzoBoqyNhruNg6hYumetoAxzQml7ocD
         HutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rLwbUcyqZa4V72hV5etU85rDGU7np/UT3Sn1ACjR9rw=;
        b=pge9zakubgczYk2fK6A32PszzGJ4VF0dOSEEoljWnWpUaEKoK26rXoc4rQF9Q+7Z+C
         yb2YY8TAxMN9eMpJN7hE0zE8FMNIKKnr7YWfkBoBW8nEffUCHXxp2RrA/72hfecrK013
         PTDsnc9jyv28klV07QYPeQ9LzOjvZGinGjL7KTi3phZe8qFNIYXtEskeUmcNhuAbNrJJ
         ikzhWekGycsRTHgjP4RXd7iXAKDp23309JAoQxwiMENzXtezRXwN9cDTOd1eJgrWTJkY
         Aq6zPB5wHukVlyPkqJe3MIHwQUTVR0cDJyJV2wKYmRTeXVS5vNXXPirNe8s5ZeuFrar/
         R7iQ==
X-Gm-Message-State: AOAM532cVwpoLJ0CWXHJFpYnMGN7nze3iQQRvMEymdADApO/dWAVInH+
        NRdTOQb99OMRyZpOl9+g9KUE+ThZKkU=
X-Google-Smtp-Source: ABdhPJxGIUdHWwSkBMKaI5kEbB4sZ/t2e5caswys2MozNiaddf/iIJvCVR1D31/WKD5HGxmPDT/saQ==
X-Received: by 2002:a05:600c:3399:: with SMTP id o25mr16422881wmp.3.1625518568059;
        Mon, 05 Jul 2021 13:56:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm13965547wrv.37.2021.07.05.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 13:56:07 -0700 (PDT)
Message-Id: <e2a0e5387ab4d9bbe54d5d5303171a1a0a4fc8be.1625518566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
References: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
        <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Jul 2021 20:56:01 +0000
Subject: [PATCH v3 1/5] refs: remove EINVAL errno output from specification of
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
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
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


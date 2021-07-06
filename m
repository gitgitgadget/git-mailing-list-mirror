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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18145C07E9C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D5F61C24
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhGFS6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhGFS6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:58:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6470C06175F
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:56:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p8so195521wrr.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=28uzDAeGOKcnmFSDAZZdAYg3F6G6ewQ9Uyr464q53QI=;
        b=KzFrEhzX8O8/v9/JsIMcwyUojUvxeMAeU13yi+grTpejJdec+yk2RV1bjC2rw9XN67
         Ky1GrmyzrF6pgVtFhV6ep76wFFCzPOY6UT7T8eczmpFVHlRgeBUHhNJxq8x88SAhn6G+
         2loWFVnDIAA79Ealb5CQ4vaVE/Q1o3MUrhWM9xGBrsvr9Fm1rx8j6R5WxmnY0iPak8Q6
         hzZ3R35RbMERN/E8p+wbkx+uaCxozZ6cn+HV8VoamDTlztgfRkjlq+ZWtXxlcf+L2j7L
         h5qeixgqkGF91uetOY1nLUEDRHvOuO45KZ1weh64yhPCAnuk1wXnFIkbJnWCvwzzShTj
         pweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=28uzDAeGOKcnmFSDAZZdAYg3F6G6ewQ9Uyr464q53QI=;
        b=NnnSpVSknHuQaV6L4BOz0dzdqwR93S/XyZ9mJzAQ3R1x5dQ8hrUe5oUO7Arjmoe1v2
         Iubnd0bTiEDAXe8A767ICj1Ku+zFhj7efBL59H8s2W2MvPqpnXtkhWDfDnYOEIxUkNTh
         SZkc+8L++TK93SlBggs/B3+EfM1x2TviCYLwnkvQhfdFjR3yTyrnY2AUGgHe9Tx13AB/
         2vliHnfCoyxBR7vsMLBr1IiKSLWSiqqHy8YeYJJv3aqJ52hXVSNz5TmJYKUN1MbL1JZa
         II+TfDNxG0C+xHxqc5+MI5FFWmLKIkbyHVbcJJpVD62CvCH6DT0IEpeOcnTw1/0ToYdX
         Mmjg==
X-Gm-Message-State: AOAM533pcYIkQgiBw+M+poPGRafjfGE+IJE1z9Vus7rxjnHVkGIfbA2p
        xVJMvHF+r86JU4By6e4NHPPNK713DJ4=
X-Google-Smtp-Source: ABdhPJyTp2TTkbRhxpTavHBf1v1/Ot84/PULqlQxiKyW4CNbRxc2pPrCPfztbbEP+UDNFte8Cp0P2w==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr20763447wrt.128.1625597759363;
        Tue, 06 Jul 2021 11:55:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23sm3761140wmi.29.2021.07.06.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:55:59 -0700 (PDT)
Message-Id: <d6a41c3c0cb8bcd3d65f1273431f266541a96754.1625597757.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
        <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 18:55:52 +0000
Subject: [PATCH v4 1/6] refs: remove EINVAL errno output from specification of
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


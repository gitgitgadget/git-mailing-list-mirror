Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33CCC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EF1206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPjah5/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgFESDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFESDb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CDBC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so9227407wmh.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=pPjah5/qfdnrMlt0S1dE5gwJ734VFnR53FWgE4S1dg+lxlXWSAacYDsILBvJLIrQ0m
         84y6LKFfCgkg9VJy6uBGsz4K/Ss8DoL7/cLz9zin9dwfubW+6Yfqk7O3zUWFALnJVSNK
         lmLY1ql1lxt0xTB0BbYGexRJpV1MsNJS86rgPzLxrrJglzaLVVGgSGd5MG4XJ5tspka0
         gcf9snBMPmGmFFnSBQz9xkRyqj6zVfQjO7po2Vr5bo2DPDx1RiSZiaCo0rQfX3msew8H
         tmHtAR7Y3xCM+8SFuU1DEkKX7No2XH4YtEpRqDXKWmRK9STioPUehjysdOyRxIHc71By
         1vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=tEPooWD9LJ8uw9lHN4QcGUtgwzUizOPEFbrdLBZbtD1Ao6th0soaN3DR/S01iM3ibB
         4hcsQ/dgSii2JUeyG6aGwE6mXfARig3YPaKGF3KrSp4L4cuPgDscEdv9SqofnWmuQAys
         TruhBrVz3Q6mApbCWNiQ/+tQU0jWg/oRWlZmtV8gMFkoBzH79NNNKorPSN6VBQpUX++S
         zp/ltyM7DVvhAK5BdAY7xBP+8eE5lvyuigyfJHWrScZfzGCDe1EjteblqqJflqTUOVVW
         557ePhz/fcRYxUyhJl4GU8gjXEn2vlwaWYH1fxJ8W1Wf+yPtFPlDokH8+lCgxwG2lx08
         cztQ==
X-Gm-Message-State: AOAM532ABxOq3dM8rUJE4VuOqMuKKlegMoj0mFka22GKuQypNRmydjdv
        M9Ihe+ZWoBKCfQk3x1ksM+r3rBqB
X-Google-Smtp-Source: ABdhPJyq3BhsFA2KrJfK+WD1j2G+0kbLyQoLOsS4bEdw0r3ailVVkP9dnyJmSm4x7kPgX5xLWLpQZA==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr3698673wmg.132.1591380208924;
        Fri, 05 Jun 2020 11:03:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm11711601wmc.15.2020.06.05.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:28 -0700 (PDT)
Message-Id: <556d57610cc3304a9c521b399dc306880b15aa07.1591380199.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:11 +0000
Subject: [PATCH v16 07/14] Iterate over the "refs/" namespace in
 for_each_[raw]ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This happens implicitly in the files/packed ref backend; making it
explicit simplifies adding alternate ref storage backends, such as
reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 812fee47108..29e710a29e9 100644
--- a/refs.c
+++ b/refs.c
@@ -1450,7 +1450,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 
 int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
@@ -1510,8 +1510,8 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+	return do_for_each_ref(refs, "refs/", fn, 0, DO_FOR_EACH_INCLUDE_BROKEN,
+			       cb_data);
 }
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
-- 
gitgitgadget


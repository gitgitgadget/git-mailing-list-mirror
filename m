Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDDC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6B020776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/2ZsQay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgFPTV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbgFPTUy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8006C061794
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q25so4282061wmj.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=C/2ZsQayb8Uf69hOCXFlVdHMDgK8I1ropkrf9+7IjSXodkH4fByvUmO8rvOfuVuOq2
         Jb/lQVe0xUzyciM+iyS1QoMB3gZHwtKUBfvgTMZ8HVlJcL9li+5n/1baeeJ1k46J2zzO
         jJO4d81WF5QJxNHhn49te6r6juZCRalRy9GrKThmScBMsBcYEjHh377I6YPujcmlAT+z
         OuZVSBlLgtsPI9UZmZrVYpMGhNn5Wc7bxljlXNIjLT4uvi+tQNhXUp9yxKkziFFfULaj
         tCy4MR/j6vHsHMAvLMv9H6pbmxbECmBbD8XtUwcMiQxdkPKFCAnw033OQ/XEjp1BSSTL
         B5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=aNqfxMMrkSTl0I/4T1YaYxYqqXwZJoF0D+kEx1EMZTBSeC0bPIyYzYo/TVajpZDCp6
         jq6D38CFM0I0hdMX380bAde1/ptjXfGOjupkXGxO/wUz1mq5cZW57pa7n0+53hIOkmsJ
         NzyUY1InJMeu2jqbwgAN8f+MsHgK9gY6RBKgZjdSD4L3nQV7JYcivW1Jx4vxMfxsOyaK
         EcMbENbkLm8Ff8Qj5w25NDgcYl0mHh/r7IHZqG/QAIC95kSXirJOIvL9oLJjksZScuET
         eJK/szr9zPfr8uifOW4aeCL1/Gseq4XMD2XUSumrvxSd/8Gep6stTgU35QBOKc74nZgF
         S8Tw==
X-Gm-Message-State: AOAM530ziii6GzKJDNLpl0R9SKHrL2eNEZfwk79F/fEC2akEd6eBOvFT
        rMJ1OtkddwFS4XnJHj5dXD832I5e
X-Google-Smtp-Source: ABdhPJyNLhv9vwaLUyeUsd+HZ9TfL2+j2eiRqoRPeqnp6MSQ3mdWHq9N0x1leKuAql2B2pCTjg7+bw==
X-Received: by 2002:a05:600c:4410:: with SMTP id u16mr4701652wmn.88.1592335252460;
        Tue, 16 Jun 2020 12:20:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm28639876wrt.73.2020.06.16.12.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:52 -0700 (PDT)
Message-Id: <f452c48ae44be3a30d15c68bfa9f8d1ad56b2556.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:34 +0000
Subject: [PATCH v17 09/17] Iterate over the "refs/" namespace in
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


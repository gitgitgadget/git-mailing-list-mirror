Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D6C433E2
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE74020767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMdAmfzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgFVVzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgFVVzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89093C061796
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so1134854wmo.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=KMdAmfzRcFRb0jYJW6Ewa6/bUqEAltZqLRRT2m4vz+7R0sOvYd9KEwrR4f6pqLXqqa
         jXEs+y9v/mdvxqOasYTxf4Ey2uTUklA/9Fzx/rLm6HGeYuGE9TD6QBFf8A2M4JqCCpdO
         JWmLqCSj04g/q6PH7Z+KzsRbiiwGgZdkUCRCwfugIA6F62KBIHsrG+NeW+0YC2uZadYG
         9BHSo9BsdfThf+tkraicoxsyVakDonBlRPJa+/D4qoHH83dtyGhNiX0QtUoznFl2m7oG
         hoX3lAxcMLl9laC+BGOHj3Tq6qWjxMnpyTNE5iR0FFuvn0KVf0Fcp1HqoSQRS6q3GmqK
         9HRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9vcJ73dXE7fO76RktXgm61AhF8amudgtEPjX0Aw3B8=;
        b=oEvze+UpOXBxxvC/cuzdUgJ72dh1HIZjr3W0zBRUoNBmLr4vcGB42XnDYKKxVCfkVt
         Yu3l+HHYYsYauznaRA3s4Ew8iosBxmsrswx5mbnehN3oqTt4mReMqJ8dszxzPAfwu0Ph
         14KvIwMcldNNba35QoiB3lLJYVzN2GIXVCs6tZXiM9MWrieDdYoc23zpGgFYCrbwO8W/
         eglWKNEceMbfq6BqerPcWxdmLst4d4cRl3LWBX/bEA0CmEh3dZgjBOYM8db5E5j2f5Qk
         i5X3AFvp22t5F8SI3eeQV/YUbvBZySAW/9br2pcspKi/tu0BJdp1vDUq7TcntYz4n2Ka
         wReg==
X-Gm-Message-State: AOAM533A4R4zSChi2QfuYfEUM4VvFbKT0k0u2C+UrodiG8Bsb9rQDU5y
        AWMvehJ2ZuJmWf91h/brOFBYu5SR
X-Google-Smtp-Source: ABdhPJxYhg0WePWkqtmHTH4tOVtVP5X5myFMK3YRgJ7h4Wtr9nMP2WI8lALZSxnQQkABCUo0imwHhQ==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr5299136wmc.23.1592862931187;
        Mon, 22 Jun 2020 14:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14sm1012211wmk.19.2020.06.22.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:30 -0700 (PDT)
Message-Id: <468f00eaf67d46e6d4bf9694b0ce99723ea84283.1592862921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
        <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:10 +0000
Subject: [PATCH v18 09/19] Iterate over the "refs/" namespace in
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


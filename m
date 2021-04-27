Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6EC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F7F61164
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhD0KkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbhD0KjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E10C061760
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m5so4755914wmf.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=40fNg/YXL9V2E3fT8q9uHPMFRE+qotRDYqO2Gm7KhAo=;
        b=uNdd0rbTbJbYQpLbdNjXk38wIY0DaymeDnYKShoyoATRVv50VNZDBh5NegC2pvTS4P
         nQRBFBI2T4+XdAofrZP11sR4NuOLFxuKgr/tuUNyWFOQBHq7OAaoKnfgWyHjTY47P4Th
         gkQjzdJBWCCjzvQ07Tmcv9vdpkm0dd9F3Kh9ai2H6pIAWz/rt/fLTFH9AJIF0RE4ShI5
         dJPO1+hk+KhHrk8FLAgzG8tGlPeiam9wudYtNhk0FWIW4LY75PRYds6SJFUHV2xt4Mmg
         OnRbN42nsVN6HBjMQwgcQZyTdzVlXy0VNwwt03at6yeTEs4nKfYbMtPYe0lBUzkM4uxG
         KbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=40fNg/YXL9V2E3fT8q9uHPMFRE+qotRDYqO2Gm7KhAo=;
        b=kAASYHKru4qRYD0ThlneAGMfkb0QVLpirXt9AEdoyzC6rhsomChOEe6nMnvPLtPmBq
         CUzkSmFuvDCOr9c9NK2uvb2gTRz38A0zzCCSrIWe65p42Ng9GsnaIKhWbi4ELFjWt5qu
         7ZcHkydo7qznqMepS5nLwEgGsLyhTSrN5cJo9Hbp5Ub8Y28i0tZCyTzCW7zVpRMOMMms
         vlbVNqNXZK7cNzi4tYzbo5YoA7HUevLq76IaneAXroO2HMX51mT5rvMZlJSF++5QoG2z
         6fiz+xtEqzAdHX2PHS2gozoaGxbIaIN38sfN1uUq+TjNm/XL7zTHdirw2wB9f1dKC4+8
         5F3g==
X-Gm-Message-State: AOAM531B8llPzd0+HFm9+wLagX25oaXlzRuFzHB97S/BeXB+kGWPM9QA
        pTazJZEpRMb+VPlPHD3Q+DfKd5TWFpA=
X-Google-Smtp-Source: ABdhPJyyYoJU5PuXlwx6AbDtNNp48ZPos8pujkYQHHDQ1VsCvQ6n/D073fHXgNuysO1ICJGrsZNC6A==
X-Received: by 2002:a05:600c:892:: with SMTP id l18mr3559684wmp.52.1619519912313;
        Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm3219271wrt.14.2021.04.27.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
Message-Id: <f3307b62bfd776dce7178932031609e754b4ca75.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:15 +0000
Subject: [PATCH v2 14/21] t1407: require REFFILES for for_each_reflog test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add extensive comment why this test needs a REFFILES annotation.

I tried forcing universal reflog creation with core.logAllRefUpdates=true, but
that apparently also doesn't cause reflogs to be created for pseudorefs

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1407-worktree-ref-store.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index d3fe77751122..ad8006c81397 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -52,7 +52,14 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
 	test_cmp expected actual
 '
 
-test_expect_success 'for_each_reflog()' '
+# Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
+# only appear in the for-each-reflog output if it is called from the correct
+# worktree, which is exercised in this test. This test is poorly written (and
+# therefore marked REFFILES) for mulitple reasons: 1) it creates invalidly
+# formatted log entres. 2) it uses direct FS access for creating the reflogs. 3)
+# PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
+# not testing a realistic scenario.
+test_expect_success REFFILES 'for_each_reflog()' '
 	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
 	mkdir -p     .git/logs/refs/bisect &&
 	echo $ZERO_OID > .git/logs/refs/bisect/random &&
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276FC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752CA61108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhEaRmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhEaRlE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:41:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC458C008759
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o127so6575743wmo.4
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=f8jhm8QsO/5/8KPSNS3WSZqG40hSn5q5psjTJDCM/qE=;
        b=KNO5eukybtlZfcYHmUnDBbOhYiUA6qUB0ibsUSySHEnLIipC6wGRI9JWDe+YB9xCTm
         k4gGQizqkc81lIcDrcYSSPf/42tyQODvSQH6meRzTFYnd2ukp5iLHqPWRkXHbsYbePZC
         wiKm6GR4fVDSO4PlrX6B+g8WPCJ3GlZ5CRZcfpXjySmhB7L4LiRbjsD02Qyq2KssYiMU
         kKVYhBO1wy7Sb1ZVZI7ZOjVe9hItAjSaFjg6sXeM8wKf6R89yqmDa4qAznnjN7BhN9h/
         Vcy22itsuDbXiPUKdP45x6Y7YzP9IZrKD35w9e/v3pPHRrdE2nVKWqiRA4xGMm1Z3VCp
         HXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=f8jhm8QsO/5/8KPSNS3WSZqG40hSn5q5psjTJDCM/qE=;
        b=fZpC5fv9azro1B9FTb63xa7iNbGmqeh4M56k3rvSOKVaxEQgrNgH1nKI1dQesxvmzq
         iYiCnv3s1j/K741JMNXg8x3Gi8Q1iActwtMQpIbvl8GXitDU6pxd0n+b0bj+PA1X+CzB
         ovGlGuo1PTQlM/ufr++GL64SBCirYvfSogV7Bnx+VYtf1HMKQEvxP8It18M5geZA2UHg
         UpHoUJlAY1BcLWB5/nyLUAGVatpL6mpYALDqfJ1UWxTDe4WT/AQ1ZiKLutQj0UX5nE+u
         QGe7o+hnyOjiz2NUveFL4CozSRjeD8CIRyrSQ10XVrDLjqPVWQbjfUJDV8ONvgljKh8t
         gvWg==
X-Gm-Message-State: AOAM530CPajxU35+N69eBxJzlDKVr6fBiQmMoKHFMx4Qc/hPK+rtlO1/
        m8hJsradoaNxmUybbqr1uXcl9AHKQDQ=
X-Google-Smtp-Source: ABdhPJzY0XsEFueueFDOXQMhyrEP5Czfcn13AC2ryafHKQ3/tdOf6s1/zf/69wl/dYQIh+Dz5qGP+Q==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr37610wmi.151.1622480210604;
        Mon, 31 May 2021 09:56:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm15459506wmj.15.2021.05.31.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:50 -0700 (PDT)
Message-Id: <cbcbb2d78fc939e968347c2dc2ac079ab6771e97.1622480198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:37 +0000
Subject: [PATCH v3 22/22] t1415: set REFFILES for test specific to storage
 format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Packing refs (and therefore checking that certain refs are not packed)
is a property of the packed/loose ref storage. Add a comment to explain
what the test checks.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1415-worktree-refs.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index 7ab91241ab7c..66f27d0fdfc9 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -16,7 +16,10 @@ test_expect_success 'setup' '
 	git -C wt2 update-ref refs/worktree/foo HEAD
 '
 
-test_expect_success 'refs/worktree must not be packed' '
+# The 'packed-refs' file is stored directly in .git/. This means it is global
+# to the repository, and can only contain refs that are shared across all
+# worktrees.
+test_expect_success REFFILES 'refs/worktree must not be packed' '
 	git pack-refs --all &&
 	test_path_is_missing .git/refs/tags/wt1 &&
 	test_path_is_file .git/refs/worktree/foo &&
-- 
gitgitgadget

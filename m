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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B66BC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6802660231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhEaRlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhEaRkr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE0FC068EFF
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c5so369571wrq.9
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=0SfGWZX9GqZOYlK+b90C9VwwzSuPwmYUOcCKlOU8bVY=;
        b=k+AmVkmPUndJbIDh7lSBQft+2vcnh+uQzWbmRYlOitxpJZR3FtV/T38BMwphK/xnfe
         hCH8svPTm8F+x6e0gRelqxGY36aRHTDyEHuoh6S7kkf2LAeOntfg4Wi8QlHoFyZsn9OA
         BF5lJxlASOv515BuxdJBQKtcIcZyQ852uzOd47GNVTZMRmjxfYCBUrDp9hlDKyL1sh+S
         BcG2YDGkDoHkhh1muDRvhFE0FIJzivCTc4+/IHlVWDdNIkNq1uo+pbiYqlthFb4+8eiW
         /XXoDq8uzwF8EaQpuuyO0lobY3LfEAcN4KQps40F//og+DRKSPKTR0AiS2vdWY5OOZWi
         86qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=0SfGWZX9GqZOYlK+b90C9VwwzSuPwmYUOcCKlOU8bVY=;
        b=PjFHEj3Z6ZsMzv3PplJN39KPsvldDoMtrR8O45L+hD+9ILxocbzhDx8E6FVzdzSsst
         QCT96V1tC4MsFGQa94jn/+fpea+Pwk6DU12VHto0ia/U74KLHcrh5ni3Y7CRe+Bgony1
         DghlOqwjPUJNDxKAUNKdc1VVedMo6nVtrnVsxYbx63HtowzCoVLqdKuEYuQFG9pgJRV8
         En6BoLnbs2We66mkRu5R3G8Paxt69FQz7N3gHa3/wSVHtFy/XsQpmg+AWU4pkdODJiUn
         UyQwuvb+aPXt4z5TkvIVjhrrPYbOfjVQjVXv0DbnPmsZGlhAA1wJxJmmBnQ1S/vzc/5x
         Zi9g==
X-Gm-Message-State: AOAM530U5v1QtERSwswOvC0/BtsxCbOz+4pNQrDbNFK7vo88LF8kx+0/
        bsc9nqKr9S8qymK4cOfwUzVmifdSuiY=
X-Google-Smtp-Source: ABdhPJz7MnC3qkZcrxuP5gy8T8OduNLbuyhZJySB9YX3zLvHTi6bav1QY/XETWx4/MuMrUDrXyVn9w==
X-Received: by 2002:adf:de09:: with SMTP id b9mr23450338wrm.340.1622480201086;
        Mon, 31 May 2021 09:56:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm246925wrv.89.2021.05.31.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:40 -0700 (PDT)
Message-Id: <130099d30aba9a2f526a6ce217f18a5e235306f0.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:18 +0000
Subject: [PATCH v3 03/22] t9300: check ref existence using test-helper rather
 than a file system check
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465cb..1aea943bef72 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -392,7 +392,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 		git gc
 		git prune" &&
 	git fast-import <input &&
-	test -f .git/TEMP_TAG &&
+	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
 	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
 '
 
-- 
gitgitgadget


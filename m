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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB1DC432BE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE12A60EB5
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhGVUsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhGVUsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F8C06175F
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so420897wmb.5
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9KVw4pEzNFeWgplGe9YGi9/mdHySu7RVQZAxi7KePI=;
        b=OkTuzmvr1s5YddGvtfi2boC4KK3b0BOIqzMJFw27Q8SVl4rb/rGMK8UI+Vx5zZOcsw
         5u/defwPXtatAKqXaC1f91iRpdmk6KNR6YZOdvAp5yJngeFzpFF4hVUYg/cLomR3cLFS
         G8wDi1D6BeLZxVzafqZrJWdHVvpdVujdh7Gy4Jzi/dZ/16ppt4AAh55c+BxuzkRFXXwO
         DlsaL2t4TEh/Q/VmR2N+RuPK+YxeQm7iMz546DKJdDK62Fq3nkWBN/PgFBGWZkypsqa5
         dz8AemT314lMwXcnkvCh0cyzP/7HHMGWwbKyFAVz3oq3pIbMPUVU7Ie5L4Y134KH7SDa
         AxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9KVw4pEzNFeWgplGe9YGi9/mdHySu7RVQZAxi7KePI=;
        b=EGEhO2ZfmMmkEhKY7onlj8vNcu5Zi1C1itOO9XTv7L1AoMsNy7f+bE6SpAe/iWqNe2
         WXkBdy62Un5d3KnX3aPM/FmLdq388Xnthr7j3Op3Rt8dx3WkP76QspbRbmvkl38VTrd3
         8sNEbigKMq9tlxVwFoy4l80bgh8/K83SJAvy2er6ZC1Dqx2nzjo+wjvc+htf1+pxwY9E
         Mwdl+B2wHheNcl2INvAhWctJ1tcOiVioxRGtClFSA/BEtZUvwYswKriEzA0ML4xyjqgZ
         Xbyv110esGRhHKyf5NGI0LT8aLf3jVskMQ936q4qkxdfU0zgGg7Nqgz8Zp8VlzyMjAnq
         ZRnA==
X-Gm-Message-State: AOAM530fF94Bxo3Y0sv00upsnYTru3zg6P0An70gmhEpAP9CQWuRfQn0
        K+FcrrMN9F1o6+4BHl+ytkO4N2c93qU=
X-Google-Smtp-Source: ABdhPJyKAzYqdGOiqxXZL58FZdctyHRGiIMmg7Zjm8kSlJ7fI/Nl9lnF8iYDlqzaDjmOBRa+WJoKKQ==
X-Received: by 2002:a05:600c:4c11:: with SMTP id d17mr11103779wmp.121.1626989330346;
        Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8sm9778121wrc.6.2021.07.22.14.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:50 -0700 (PDT)
Message-Id: <cbf90c13e5beb0849f4e112c6d4e8e0f8675b508.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:39 +0000
Subject: [PATCH v2 03/11] t6120: use git-update-ref rather than filesystem
 access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6120-describe.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1a501ee09e1..bae2419150b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -107,7 +107,8 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 check_describe tags/A --all A^0
 
 test_expect_success 'renaming tag A to Q locally produces a warning' "
-	mv .git/refs/tags/A .git/refs/tags/Q &&
+	git update-ref refs/tags/Q $(git rev-parse refs/tags/A) &&
+	git update-ref -d refs/tags/A &&
 	git describe HEAD 2>err >out &&
 	cat >expected <<-\EOF &&
 	warning: tag 'Q' is externally known as 'A'
@@ -135,7 +136,8 @@ test_expect_success 'abbrev=0 will not break misplaced tag (2)' '
 '
 
 test_expect_success 'rename tag Q back to A' '
-	mv .git/refs/tags/Q .git/refs/tags/A
+	git update-ref refs/tags/A $(git rev-parse refs/tags/Q) &&
+	git update-ref -d refs/tags/Q
 '
 
 test_expect_success 'pack tag refs' 'git pack-refs'
-- 
gitgitgadget


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED22DC433FB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA72619C7
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhC3NLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhC3NLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99940C061765
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o16so16251963wrn.0
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HXXyCb3008cEuxUb0eFiCeUe/gRR165/1lETbl5mS4A=;
        b=dAoYrdzuJv9tphGjjQdH3rhj79cI4b1WzxoA3VhwPoiwc5SvVyE3EEGYmxCN9333tL
         dxHbOwFcuchDC1O37st1nhvtM5QihFGk/SkbglNg4u4Ipn+OaAuYgQA7nWjZZ1Drjw/i
         L152b2o9OZBJM/DtxT7W7r6ZxXjI9Pv7YkmlQR/n/exN/tlk0MUAZ5wYSY2MGUeoKOYy
         0itJv4Ud0d56foRc943oP+HDPq+XLZvo1SZDP1aRSQ2MZd5t3Pgq7LrUIwZ6pmX460ig
         cHx41p7owWsRqHlqslJDfE0P0fHCi6RbldJQ35C0wn6u1cRtGljUyRAhaS1USfPqkeEn
         Rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HXXyCb3008cEuxUb0eFiCeUe/gRR165/1lETbl5mS4A=;
        b=mvvaisOlqnh3K+VRfPY8KGfQod5HsXZfkBn5Fc37Jdelkmoi0u+vNbd82WKFMDi5Y4
         kvwW9U74rKHHdELUqvxTI5NsPlJUHRIKw4QYW7oqc3YXY/uoavJzY5bfTg5IqRaQsTyb
         iJVI9+/IE+u/t++sBsx+JzRvCuxk6BTMuEEWHWrCKQcArqm/0W1tNQhjEK2gf5+G62fA
         8p7Dv+i6TU+3PbzKgiEFDWhQpe1WOwx9IV4HZLapsZd8XpKYQse8Hk+iHp/hLkd2gU/6
         hrnK8agZHrGLbJ7JNaOJttvPVg2hh6E2StJ0CK/gEEU5hUh+2naJhxvVXRcjalbOHjIs
         vUvg==
X-Gm-Message-State: AOAM531RU/N2P08/7QYf9T4gczqnrymJmCxn+m36DmCtP/TZJ11LuRdo
        TRbja/ByqmvV2obLQhEDXwIMOOqugWY=
X-Google-Smtp-Source: ABdhPJymsnrA4SNnV6NSDx9eRVCKV20rOOUtTA6RvRQprxHqrKLQU/PBTS5p+Bs1zhNjsQKslorOLQ==
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr34748939wrx.97.1617109878367;
        Tue, 30 Mar 2021 06:11:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm3421388wmq.31.2021.03.30.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:17 -0700 (PDT)
Message-Id: <57be9b4a728b2bb16c841d3bad3c9c876a8839e0.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:10:58 +0000
Subject: [PATCH v5 15/21] sparse-index: check index conversion happens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test case that uses test_region to ensure that we are truly
expanding a sparse index to a full one, then converting back to sparse
when writing the index. As we integrate more Git commands with the
sparse index, we will convert these commands to check that we do _not_
convert the sparse index to a full index and instead stay sparse the
entire time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index cba5f89b1e96..47f983217852 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -393,4 +393,22 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+test_expect_success 'sparse-index is expanded and converted back' '
+	init_repos &&
+
+	(
+		GIT_TEST_SPARSE_INDEX=1 &&
+		export GIT_TEST_SPARSE_INDEX &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		test_region index convert_to_sparse trace2.txt &&
+		test_region index ensure_full_index trace2.txt &&
+
+		rm trace2.txt &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+			git -C sparse-index -c core.fsmonitor="" status -uno &&
+		test_region index ensure_full_index trace2.txt
+	)
+'
+
 test_done
-- 
gitgitgadget


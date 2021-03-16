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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCEBC4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B811D65109
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhCPQoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhCPQnU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:43:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89981C06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso1829792wmi.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=X/ut/9z8pH3pSneMoimwEahGbj5uRUjtSCXclDi+34KjX7PvxXQrLuWgAEFOrb7WPQ
         eNNWKtClj3kEv17It5x1iGYq4YTdKncGXjFLmi8xatTud+RF0l9yy/2ndo9vqARtooab
         FKkxEHXEZslT7oy3vPEEDEDiKYy8jjnBIkCxP2ABKeSK4lrn3oSheACZbL5w8co/ZCxd
         3QLNtqZQwgTt2gJxrjIm/ET9sgx8YclkLPGoMEVBprw8j2it9pAiUaRHiGfrlYHosO5v
         fm02qkElj3FFn4mae7dZEp1wqLy4G1f75oPw7A/fBiN+NFUM9VjSvneYVWh4WOPOSkIk
         Ce0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=lkvYttVGcTnUrPqIngyyXqVEs0KsQZJv2x+HC+WFwWkeh1fg82ZoygrdT4Vm9YrjjO
         +I+t0RgPjFFlkjNh8cC6zk4l9ducpCKGzYxVfPgXeyC8wcDSt7TBN8V26gy9q6bboW/9
         +X8KI3ZirOCU0pqkeb/UJm7FICmOgUHGWSOkG/9LayXa6FehCLH5VBF36Nv0WDGzSQl3
         K9y5zxlMb/rND3oqQWrTsAteNHMpdE2oub5LkLD+6dfSlQUqJvv+2JM4HE1XEiqoPMIQ
         l63/H92OlLeSr29yp9T15/bedWAdCibF33G1ARgQGktTg6xlSIYDbP8FbH5mqSM7Mx6C
         KLfQ==
X-Gm-Message-State: AOAM531ZLUKDyMj3KYI8YWPMTrFUjS06VpNtpuQUDWafO8yy6mysqTUv
        hOB4XHOBk1G3DMqAxhaVC8Wc1LCT/ZM=
X-Google-Smtp-Source: ABdhPJyPYIJ393S5b2BwPayYyOO1H9fyJTACR3ae2CHnG0Vqe5zVsEDr0YJID09TTzxVJZKIt+MZmQ==
X-Received: by 2002:a1c:7e16:: with SMTP id z22mr503740wmc.74.1615912997370;
        Tue, 16 Mar 2021 09:43:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm29839514wrd.9.2021.03.16.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:43:16 -0700 (PDT)
Message-Id: <598557f90a2a6d2a8656ff60179adcd260074771.1615912983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
        <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 16:43:00 +0000
Subject: [PATCH v3 17/20] sparse-checkout: disable sparse-index
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

We use 'git sparse-checkout init --cone --sparse-index' to toggle the
sparse-index feature. It makes sense to also disable it when running
'git sparse-checkout disable'. This is particularly important because it
removes the extensions.sparseIndex config option, allowing other tools
to use this Git repository again.

This does mean that 'git sparse-checkout init' will not re-enable the
sparse-index feature, even if it was previously enabled.

While testing this feature, I noticed that the sparse-index was not
being written on the first run, but by a second. This was caught by the
call to 'test-tool read-cache --table'. This requires adjusting some
assignments to core_apply_sparse_checkout and pl.use_cone_patterns in
the sparse_checkout_init() logic.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 10 +++++++++-
 t/t1091-sparse-checkout-builtin.sh | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index ca63e2c64e95..585343fa1972 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -280,6 +280,9 @@ static int set_config(enum sparse_checkout_mode mode)
 				      "core.sparseCheckoutCone",
 				      mode == MODE_CONE_PATTERNS ? "true" : NULL);
 
+	if (mode == MODE_NO_PATTERNS)
+		set_sparse_index_config(the_repository, 0);
+
 	return 0;
 }
 
@@ -341,10 +344,11 @@ static int sparse_checkout_init(int argc, const char **argv)
 		the_repository->index->updated_workdir = 1;
 	}
 
+	core_apply_sparse_checkout = 1;
+
 	/* If we already have a sparse-checkout file, use it. */
 	if (res >= 0) {
 		free(sparse_filename);
-		core_apply_sparse_checkout = 1;
 		return update_working_directory(NULL);
 	}
 
@@ -366,6 +370,7 @@ static int sparse_checkout_init(int argc, const char **argv)
 	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
 	strbuf_addstr(&pattern, "!/*/");
 	add_pattern(strbuf_detach(&pattern, NULL), empty_base, 0, &pl, 0);
+	pl.use_cone_patterns = init_opts.cone_mode;
 
 	return write_patterns_and_update(&pl);
 }
@@ -632,6 +637,9 @@ static int sparse_checkout_disable(int argc, const char **argv)
 	strbuf_addstr(&match_all, "/*");
 	add_pattern(strbuf_detach(&match_all, NULL), empty_base, 0, &pl, 0);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.sparse_index = 0;
+
 	if (update_working_directory(&pl))
 		die(_("error while refreshing working directory"));
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index fc64e9ed99f4..ff1ad570a255 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -205,6 +205,19 @@ test_expect_success 'sparse-checkout disable' '
 	check_files repo a deep folder1 folder2
 '
 
+test_expect_success 'sparse-index enabled and disabled' '
+	git -C repo sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C repo true extensions.sparseIndex &&
+	test-tool -C repo read-cache --table >cache &&
+	grep " tree " cache &&
+
+	git -C repo sparse-checkout disable &&
+	test-tool -C repo read-cache --table >cache &&
+	! grep " tree " cache &&
+	git -C repo config --list >config &&
+	! grep extensions.sparseindex config
+'
+
 test_expect_success 'cone mode: init and set' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo config --list >config &&
-- 
gitgitgadget


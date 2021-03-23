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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC83AC433F4
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A155A619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhCWNpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhCWNoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 09:44:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8D7C0613D9
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y124-20020a1c32820000b029010c93864955so13042225wmy.5
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=e2PqLUKRaZNgnAWi6oEqFK59MUGSJ1Khi0LyP3UkxodskHkdmb4WLkC1Mo3ykCFP8X
         +/w0Gfp666u0a/8RLcx8gTFdzFzQ69mbXqGixP4qhtNAZPC2z2F790tllDstLH4zAO8T
         taa4Wabjl3lUAwRbWuBdHHYZ8xusHxrl0sUhmJhVqgygCaOrjkujorggI+p0ydRO5lFV
         Wkb6l/YTFuC5Wyos4bhr0C+jEvaRtw8eB08Xa6cldkEAczN99V+YZtyLp713YXZHHvEg
         MYnuQTijc9EXRM2Oba7sPAAeMuC7YaXtayB8Aeki+/EC6PWxlGH7GUiYDT7FxPgxRhpF
         /PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=kDcYLPyEMBDtHJhHNGsgpFrl1yx/S9vP/0w2qL/3EDE8LVKWotM53YowZns6lPkA+H
         A+oJmafQcVbhjYQyuIlB1sNRCpxVIp8tJDbhwXmHT8mKGtDGWOLGhLcfJKlAy1uS2U5t
         R95HHxvHKbrZ6JUaks9TA7tbigfe9lty7jxNd4SjBalO1tXFM663q5D2josoZ9daQ89Q
         d/Jqd+z7la/m746h9H/3Fm4GsPBowrxifEPj/lpYt8kgAtgy9uxjRduK5XxsGZRth3RO
         oFEOy1CCXDrWGa95ACVn1m2idm35bV6cxGBCzlh88WfTNvE5w9Kfr91tLG6enm59yZcO
         XX/g==
X-Gm-Message-State: AOAM533MTQWtEgfjYjnAyanaGORgo9+Q923inbH2plO/6l4QTamyvnwc
        PvsirQ1Vmg1OVStNGq651sNS1BBjfWY=
X-Google-Smtp-Source: ABdhPJy21vxcwkk4PYHAhAwqrdVALFPvYJsYY9OckYK+7WR5aWDiwlaUDmenI3YyImZd9MSKmIVTXw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr3441058wmc.51.1616507084547;
        Tue, 23 Mar 2021 06:44:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm2726078wmh.13.2021.03.23.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:44:44 -0700 (PDT)
Message-Id: <6f1ad72c390dc56f9e4a4d724369a0e1c7ac3a94.1616507069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
        <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Mar 2021 13:44:25 +0000
Subject: [PATCH v4 17/20] sparse-checkout: disable sparse-index
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


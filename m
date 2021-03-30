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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDCBC43445
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A4E1619F4
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 13:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhC3NLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhC3NLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 09:11:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F5C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so16161920wro.7
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NjgXkWn7l+CyODn0S0i+uIkYbiIeO7IGgnPTtD2hg6A=;
        b=Bmjn3jGOqaMIqp1nhUkwIX3d6BhaaLncttynQumjsuUJEP/U8dCDpFGuYN10hF6Zkl
         d206XUmHq0ZVp3rIwouvgXdyhgwngAElPgR5aJSRS8w+/kLRLbzd9h/sCFxIim0X6lZu
         qguMaelJ/FACKBHlCMRLHdlgGi/C0etZaw3MQgfURLJNGWpsIKA7DvMcV0PaFTj6tNA8
         qiGfx9u2oAqQZ2rxXSzBwm5xULe1geZAt0qkxIvknqOeEoOx9tzZBidIEEphzJa5n6Cb
         7IrXhN+w7Y4/eQzxq8VNQhnGBV0TjuknOVr/ZlZ/rj9RhHc92zsdUqxDuagQSlJFWIWi
         LEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NjgXkWn7l+CyODn0S0i+uIkYbiIeO7IGgnPTtD2hg6A=;
        b=Kq0ELyxbppNm3pk8g5tUvyojL732/NdAGJMcczJ1Wy3SndWbZtE5Kx3Rxss0iwVVV2
         dg3fxnMqoBh/PvffexttCrdg3Tnqv53DDra4B/8vP8ZIsqoVNIxn8mOCgvogmdEu22JI
         KkU6I+qt6Z1RK6BS1/27kniC+uyPB8iiFqQZ5Ptez7nbOKtBSR3IzUXgPXknmPrl9a3g
         GVkl0bEixVOOi4zNyJGufu7mK79kQ0SD+y9UesC1UbRs0UFaJqvuQoI3e4ola59R3NRd
         i4KWRR2EQlSsPZBhg6JjosTy1jDS6oHbKTjjJk+H3GAOyOZhAZQGfL2f9z/Plm8N52kG
         HufA==
X-Gm-Message-State: AOAM532j9zsbbSVHJzgl/oyX2qA+nb7bga5gsiCCdfDIn1GxPDkn56pd
        N6edPI2EnTBz4JAQbdETIORSh4orMKQ=
X-Google-Smtp-Source: ABdhPJzYjkhDfbgux0Wy2wg/4vPsitOz84HSrAQJY4GMLIIfx+IbSgQudli/OB1fWyIIVeImQm3xmA==
X-Received: by 2002:a05:6000:18d2:: with SMTP id w18mr34147286wrq.88.1617109880459;
        Tue, 30 Mar 2021 06:11:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm3884205wme.40.2021.03.30.06.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:11:20 -0700 (PDT)
Message-Id: <7f55a232e6479b62efc7b97d04cdf3ad11a0623d.1617109865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
References: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
        <pull.883.v5.git.1617109864.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Mar 2021 13:11:01 +0000
Subject: [PATCH v5 18/21] sparse-checkout: disable sparse-index
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
index fc64e9ed99f4..38fc8340f5c9 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -205,6 +205,19 @@ test_expect_success 'sparse-checkout disable' '
 	check_files repo a deep folder1 folder2
 '
 
+test_expect_success 'sparse-index enabled and disabled' '
+	git -C repo sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C repo true index.sparse &&
+	test-tool -C repo read-cache --table >cache &&
+	grep " tree " cache &&
+
+	git -C repo sparse-checkout disable &&
+	test-tool -C repo read-cache --table >cache &&
+	! grep " tree " cache &&
+	git -C repo config --list >config &&
+	! grep index.sparse config
+'
+
 test_expect_success 'cone mode: init and set' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo config --list >config &&
-- 
gitgitgadget


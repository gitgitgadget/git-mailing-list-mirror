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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF2C432C3
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C62D64FDC
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 19:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhCJTbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhCJTbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 14:31:19 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE5C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so24633242wrx.8
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=khRtp5ShFLQPShkydoXzgmrAGtrxBQJoAPFyU9FmndTmfYqTrYhJI41FAZuOS3dRQH
         roEO5c1+hpiNtY+VETGz5aTgFpsGORc2C5ZWoG5YeQ71Vk+/TBBsNbBoh59EQKELQ87a
         gPA7iXGujv1SDtV/xbqU26SDFkkj7dWlLu87ovk+P1Nl4DteJ3dAhbXt6k0NfR1dwEKH
         vy+M8Dnmray+jJ5Dtquskn7ehzdQWTrFpAKXlGb7gAxPJdEIebbELpDGCClliDTUMe8k
         YkWvYCPt5ozUufEVtZx6imF6Tckb8A/L9SAI7wcTJHb8xiIT4JqjYSOjbcAssMkvSi+t
         GWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h/Sv2nt7HYoFWjtNBIuIh6ZaRdlBye0GXuHQNudUZb8=;
        b=o6GfFhqHELBtGGj08p3v2WJhDOfib7pAoELzxWatYud9SxYxFl1kdxsfJ3K8g6uDm/
         zW8AA8bX9inIiPmdzqDFBjG0e3np+453oipLfwMl6Lpvt+bmu/bfA0/V49arwBHZzJxA
         tGoJAtwVX3k2aAIRcPSssuLbvmHT/jwAsV02Yix3MBHRQPvjHGiM4vn2EBfivS6HgrnQ
         x6MnxfGrhy/GVWR45o9tq0lXbjuOLcUVm3n5Ud3W+r5ScNA3ow6/KhjEnI/pATlY9fRK
         bF54l1zhNdyUMJhdgZcVFmTp/Lpl/GH296QiKlm9jGX1xi1soJX8cTKUborSx8GJQ387
         ybZA==
X-Gm-Message-State: AOAM532PSmCSRvJewgR3N7DVVUA1nZA7idm7KdkUjlkqPSVtEI7kHt2Q
        8Gk223kcZKz/a8G2n+i1lhIFt+WOsm8=
X-Google-Smtp-Source: ABdhPJwEmM4HEk0cSDk76mowOyMWuAaC8pxFWkf/6LIij1wdI7Tho38PmYa9V3Qtro3dQKYYXGs1hQ==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4912762wrp.89.1615404677671;
        Wed, 10 Mar 2021 11:31:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm308367wrg.84.2021.03.10.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:31:17 -0800 (PST)
Message-Id: <42d0da9c5def853dcec0855d586fe3c78de4c9d5.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
        <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 19:31:00 +0000
Subject: [PATCH v2 17/20] sparse-checkout: disable sparse-index
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
        Derrick Stolee <derrickstolee@github.com>,
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


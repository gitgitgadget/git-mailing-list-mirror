Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5FCC433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 13:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbhLONqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbhLONqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 08:46:14 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC8C06173E
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso18527077wms.3
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hefOraxaOEQ0KhvCVtqg70N18D185JeHbaisQYJ4NRA=;
        b=kSAkbW2UC7J7WGVxWkiDuza21SpHs3QSmPbDCiQ0Mmflkfxu67K70Iod/BJa/sd8W9
         GJZsYlvhmvJFFK41t2DGgYKOalS9OrFztD8LvMTXD99Fq7ehm5nUlI/PdBL8SqmbbM74
         UlfozV9Gr1q6OBhaDx1A2eBqmKThUX6GULKLCUHH2C5pANODvjXGiMNJTc3bB7Kxsr8d
         8hjTHEptqe30MWsLZZNmSprtvKeooGmvVlyUePqzzAc5jZfLQVHZctkhr4/0reStaM4U
         +23k83S65qzNVg/L/eRr8SJLTty4ARMsu/rjA/4/UKUPFI4u9YqqM7k0oI45MyRaKf0E
         gKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hefOraxaOEQ0KhvCVtqg70N18D185JeHbaisQYJ4NRA=;
        b=3KQKX16OpR7ASf4kKx2d5lm0JVsGibldsTc0XyFam22MvSyF2Sq5DDhzkst6qhkZ/j
         /rQxpmmRAPBC4iN74OW7tZkhyH1zGSgbnZ4gO5hYVc59q94Mm0IrAOtsrJhZTXNzE+r/
         uWQMiu+WZFh2SRMX8HAp+fsFXEl3gxUcqYCCMC5eyjYfqlt5IrtyG14/cBVdcquPADyu
         r5etkm1D6O+E/oSGh9BM7TLlcL3A/ety1UQYgTEs6zxzV3mFAe9On9ythr++MffFp7oU
         +gtt0m7BAHPu2kaP+ESJeauK1tPa2Ci2YPAfMDwpPqdzO4IHoHtdgM9xFraLaaM20aaq
         5gzQ==
X-Gm-Message-State: AOAM532s9GOBd3P1RqUdNdFLnkyeBD032g4qr7md1qpe3E7ZtKagiF9F
        ab9g6L90Tx/NYm2OZUfo6MBUvSmi5nmmJw==
X-Google-Smtp-Source: ABdhPJzXscysyx2Dtp2OobubOTsSx8ATpw1e2muPcDOogBI/j//9lQfGK1Bc4nCccVLGMUkG9KY6SA==
X-Received: by 2002:a1c:4d0b:: with SMTP id o11mr4623532wmh.68.1639575971789;
        Wed, 15 Dec 2021 05:46:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm2655249wry.70.2021.12.15.05.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:46:11 -0800 (PST)
Message-Id: <a0e5a942ae0597b4662bfb67dfb6dffab7113f52.1639575968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
        <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 13:46:08 +0000
Subject: [PATCH v3 3/3] sparse-checkout: refuse to add to bad patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When in cone mode sparse-checkout, it is unclear how 'git
sparse-checkout add <dir1> ...' should behave if the existing
sparse-checkout file does not match the cone mode patterns. Change the
behavior to fail with an error message about the existing patterns.

Also, all cone mode patterns start with a '/' character, so add that
restriction. This is necessary for our example test 'cone mode: warn on
bad pattern', but also requires modifying the example sparse-checkout
file we use to test the warnings related to recognizing cone mode
patterns.

This error checking would cause a failure further down the test script
because of a test that adds non-cone mode patterns without cleaning them
up. Perform that cleanup as part of the test now.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 3 +++
 dir.c                              | 2 +-
 t/t1091-sparse-checkout-builtin.sh | 7 +++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 9ccdcde9832..6580075a631 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -598,6 +598,9 @@ static void add_patterns_cone_mode(int argc, const char **argv,
 		die(_("unable to load existing sparse-checkout patterns"));
 	free(sparse_filename);
 
+	if (!existing.use_cone_patterns)
+		die(_("existing sparse-checkout patterns do not use cone mode"));
+
 	hashmap_for_each_entry(&existing.recursive_hashmap, &iter, pe, ent) {
 		if (!hashmap_contains_parent(&pl->recursive_hashmap,
 					pe->pattern, &buffer) ||
diff --git a/dir.c b/dir.c
index 0693c7cb3ee..a5dddafa16d 100644
--- a/dir.c
+++ b/dir.c
@@ -727,7 +727,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	}
 
 	if (given->patternlen < 2 ||
-	    *given->pattern == '*' ||
+	    *given->pattern != '/' ||
 	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 67ce24c9c83..2ed247d75a5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -110,7 +110,8 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 		git sparse-checkout init &&
 		git sparse-checkout add dir &&
 		git config core.sparseCheckoutCone true &&
-		git sparse-checkout add dir
+		test_must_fail git sparse-checkout add dir 2>err &&
+		grep "existing sparse-checkout patterns do not use cone mode" err
 	)
 '
 
@@ -176,12 +177,14 @@ test_expect_success 'set sparse-checkout using --stdin' '
 '
 
 test_expect_success 'add to sparse-checkout' '
-	cat repo/.git/info/sparse-checkout >expect &&
+	cat repo/.git/info/sparse-checkout >old &&
+	test_when_finished cp old repo/.git/info/sparse-checkout &&
 	cat >add <<-\EOF &&
 	pattern1
 	/folder1/
 	pattern2
 	EOF
+	cat old >expect &&
 	cat add >>expect &&
 	git -C repo sparse-checkout add --stdin <add &&
 	git -C repo sparse-checkout list >actual &&
-- 
gitgitgadget

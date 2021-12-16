Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4134C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhLPQNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbhLPQNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:13:48 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F34C06173F
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a9so45106150wrr.8
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 08:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BetIyBobJRBgFMtcCsw2ibE8x45ldtmHtv7K3P7JMaY=;
        b=YJP0MDg+MBVLOgpf+9Yl5GXP0FYZ9z0LS5OmWYI110tQeS8LR0a5qdRppIa1fjGYRT
         IKqS4+FU5bosj1JSs/MHhk2ZXGhM8puM/0RdoK8DIwi5OvWFpFfXqaSEltyhDouz5nBN
         z3h4Pgmes2MoAn8ftv+rIC48HFOIfV1UN2NRcxo5nhmKcPADb0lYuxt5RFWdGbAHL4Qa
         ygVD3oCe7uPEQXdHFUKFwBVLtQGHXLzL38iSerhPQhVbH3ypR7Zh+yshUKBrp66NSVHe
         oSUA2/V5p5Lerbz7Q7+3/ong+ZdxkIMPU/lzZ2e29AFCFqVcP9CmrCOMOt8bWAn1xiL5
         jesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BetIyBobJRBgFMtcCsw2ibE8x45ldtmHtv7K3P7JMaY=;
        b=5gSNnuwP0eT8lhJCZ3KeJsoEyYVr2V5b3XnV6xFwzmtgwH6MvQtE/p76GhaXY6BelN
         nXzo6fW9fYqBJiLhVgDntsMwOCZo27R/GNv4N9vFHM1k3H4J5tO2UpqjZhaCQov/jxmZ
         hZ1Qwl9NMUJou4cyyge+DzUeNW/auhu0yACTnPdsrq8YjM5pixVpQe5aRL+atYwave7z
         t04RqCrb1XYdveXY4TY2wx+rXEiZzj6T/ytMvG7bSmkQDa8isxrBU/nlu9CK2zQafsr4
         2n2F9g+cqrNqW6FBSzP0IZ6RoMg9SRG+3rmzK7CTI/fg/R+GuN8++dTdFTbosyuhy1ln
         s6Qg==
X-Gm-Message-State: AOAM533T6ktIsGI8KFZ2s6i0lNiCVpnilyVwv8PnbOxq2zDO0fEcjwT7
        HU/Nd6Bzl9SPW+gllEqwm0sjA9MvZxw=
X-Google-Smtp-Source: ABdhPJzPBf74/X+B5DiRDpa7voqyV5ZgWlLFt9O5gLMqPI/Op6EdtKL20lbHncqEUBRreC+XUVFPAw==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr1318113wrm.370.1639671226568;
        Thu, 16 Dec 2021 08:13:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm4996108wrz.92.2021.12.16.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:13:46 -0800 (PST)
Message-Id: <f5f7b8b8e0407cfc0609f1d254b4fa0842991278.1639671222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
References: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
        <pull.1069.v4.git.1639671222.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 16:13:42 +0000
Subject: [PATCH v4 3/3] sparse-checkout: refuse to add to bad patterns
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
index 7e72958d51d..eca75e89213 100644
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
index 1f877ced0c8..34b97fd3ee0 100755
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

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB286C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbhLGUF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbhLGUFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:05:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454CC061748
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:02:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so96621wrb.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nHSBja1nsAH0zardxs26xICqSvhBOQvdPGSC0uUkPM8=;
        b=LXRI6ldy4p0P5I9E6zbAI5nAV/iU3w6rslPfHH6yAKTyDA5BSQYnYqN3vofwXBU9RD
         FHpD/fR07gR5xn75ATu172EeVhI+BxiYKO28aLdS4G0wOaSBCThUtLl+g6CIOs1ebuu6
         uXQnCMbhTXNnOb5wds+ep0A20OFRb8A+Z09e/OjYzGa/+wuBNfkYO5R29uJNbJiy5gOC
         ABtaaKRleBZ7yI03qlZ1S8C4oyQ3mCtoGoaUP0CXhyQw3I9By2eq5rW8cClodyqfdaKx
         3tCiZUdjwLSCcVETn+IHD/ucKp34LNVcn8uUL/q8xAPAY58X6gmxEwcssIR20SOuIsP1
         An6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nHSBja1nsAH0zardxs26xICqSvhBOQvdPGSC0uUkPM8=;
        b=0CLyLGUAzdL1CoKT5zlOl9E0I6eSzvh42BK9Eb9pZhkZaVCZLG+HMPyPwdjXQGSyk0
         UIqCKsTQcKWs+YFfLmTKTH6VAaktgvyEZU+7BOfHXS1dUvlaPY4IP1Vh/GHgYX3kso5G
         aD04fApLTiqPSTLjRZm0NAsagsW8iywfZ4EBb4zb5foeat3H38dS73EgktkPxtnzVHFY
         65GJhQ5/zWVa/UnVSxgXXTMqWLQTCB6aMNZt5ZslTB3srsRiFpJ15YMrKn4FfDPPBH1n
         6qoTR49jVOK8t/2KCbDEbql4yv9rLO/x6BrC5eGxGGxYNQTA3MxT782DeTful1EH/Bc+
         AMXw==
X-Gm-Message-State: AOAM532pixzf9AeGPcGYJ9GQoIIs2vLJIriev5JBUKvYh/cPgM+U0qbX
        dXv4iqor++Vx9TV6YzkLzhCM178YsMo=
X-Google-Smtp-Source: ABdhPJyvrcsfbrMAp90Mg1KXbQx+WQJvJnFazrJjevR29Ktp2S+gH1o9skEhKEwkR+bcZf7nqJ0ajQ==
X-Received: by 2002:a5d:4883:: with SMTP id g3mr53648636wrq.590.1638907340018;
        Tue, 07 Dec 2021 12:02:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q26sm677142wrc.39.2021.12.07.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:02:19 -0800 (PST)
Message-Id: <cc52fb2b0b76ccfd8f17f0e359b440433569dd80.1638907336.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:02:16 +0000
Subject: [PATCH 3/3] sparse-checkout: refuse to add to bad patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
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

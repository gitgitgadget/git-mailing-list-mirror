Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA5DC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242752AbhLJPV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbhLJPVv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:21:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B1C061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j3so15531802wrp.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hefOraxaOEQ0KhvCVtqg70N18D185JeHbaisQYJ4NRA=;
        b=GNj8FU3XnqeFnnhxgstKJ9v5RJHW5w1hjyMTLhjwWTgNwMUdXdrL0gG3LCyYXT6U9R
         RRTa1Sy7DuzZJglIL0Cx1taWkst0Lih58QXzViLtYnGGg2To1GqS0d7kTonLTPbj+zMK
         XyvDtdPj+VxQ0BT66YsB26JMk029YhZdrAXcUa3VT4l8opkkk2uuGsc5RUTXrbpXeYUK
         Jjc9n3zTO8wvbwGvgnp9bM8O8pCpt1va6cavwiyRGT+1WPpTmbgTJb2watCTZbSF/Njt
         c3zDhCZ+XwL7g4twq64hIDv84hEx/A3w1SQuXWfX347ek/btZaZTRaaxVB9bCT9eDM1p
         /CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hefOraxaOEQ0KhvCVtqg70N18D185JeHbaisQYJ4NRA=;
        b=4R27URDm59JfQ6uFEng8rfF5aib4EkbKwTu3IiGxdFkvsd3eplZ4FxaAPLAmD2Zkzd
         4UM9XaniqLqblUY54Ji9IGj806IXzsMy8KKa/GSdOhTpv2yOBlRz9ZJ3iCe70YTRoJ9i
         up0Of+UxqNY9zuutwmCAl3fa/s45k7l//BqvJgVjBgkTRq+a55NuXS/8mh4UwJgXRmA5
         1TYMfnU+nOG6ceeZ/lxnpk25zfo0q4HSljOKyl/Ncyj1g+vPJ2fQSYm5CwaEzPj0oQoq
         aaMbWQomxiNhTKXOYQjXfY00D3+I+SiU+SmOw2kB6U4LcIqEdUOHGKrKqIp0VHldl4/u
         N4Kw==
X-Gm-Message-State: AOAM531HA8ye6iuI1v3X0gYyXaUEDDvpFQS2XJnyRG5I72I7G8vr28ff
        N/ji6YX/7E5gsIMUs84f+WuuXuDEkqs=
X-Google-Smtp-Source: ABdhPJxtmgtYU31sCrGATx3QQR23udrjkRI1qKd+a2YdAmtpBjj86ErcdBPyJ95cVy+vhWCiTJkv4A==
X-Received: by 2002:adf:fbd0:: with SMTP id d16mr15223689wrs.107.1639149493669;
        Fri, 10 Dec 2021 07:18:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e24sm2894005wra.78.2021.12.10.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:18:13 -0800 (PST)
Message-Id: <5d096e380a400759f3915568228fa703232cdd18.1639149490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
        <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:18:10 +0000
Subject: [PATCH v2 3/4] sparse-checkout: refuse to add to bad patterns
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

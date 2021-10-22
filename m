Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EAAC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB9B61181
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhJVSWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhJVSWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BE7C061348
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v127so3674828wme.5
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMLIvTHv2DlatvET7viPvieVl+TCDPn5XNdiVULZneE=;
        b=lEfkCYe9iMenEWEyTZ07h8ysa1HSdhGeb4j8Q4hskiRFa4GZqBhKk5C9FO/zrRbYHA
         Vzt7ESnN2FQFp6t8R8Z8SfM2N4Vyk6+Qx0Y2LO5Hu97nvh2WY48GGSKLJ6Urppzv48Tg
         EWZmBo+/0AemEuy/UTO47xxdYQF6tTxkJggttjLLV5lwmriqx1lQA9tRtr3V6r8XQ5Nw
         abWqOoon84Wjt7rHSNyD71eh9Tjp8EPf1zoByBUgeEMTq87/3IhPBNl9NrwW9vfdlToU
         qXDlybmnGgCd5R5uQ5I5LxC8TQs1FHfqZN48U/2kBRUslO8XEIsPqQcFa73xzKdGNUXn
         YEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMLIvTHv2DlatvET7viPvieVl+TCDPn5XNdiVULZneE=;
        b=bozUkI0n7LBFAFnV+bfhTl9mSVr85dnQ5i7fov2IuC4sPP2TnQVCUFEMSssQAZf7wy
         PXQ5TMIyRsCEPiBvoBR3QmGmpBhS7rgG2JbzPWYtRYfCfHozPSdmQDvYjzBMUgzJmpJN
         HU5vobBNKVuqn0twOy1Ezq44gENI9S32UMfdKAaNwKd4VpK29IQU5OxtGvC1LqPiVjzL
         tYtdQGD32TBU/BobgGNQFBJiD7jgJJlJYA2B3rdcztWHvmOV48AqLg1SLZ0R92oC4H5M
         e6/QOlznuE3H1B5oRl9v7BOm6+hotHipHgSEaK4GvdjXiTJFLto6nbZeWITepBezNTKp
         hMrg==
X-Gm-Message-State: AOAM5332gzKf5n9bHk4L9vNwzF14X3lUG+Jhk+F0npUM4+YLo4Ps+PGU
        xBxalXaVUoJB7dO6Rml30VnP0JEj4OGbyw==
X-Google-Smtp-Source: ABdhPJyqcAVdq5sj2B/IQFzyj1XLSdbu3P1vuAYKPhn6quIBynXUUvwBXdXfLF+QTbPq6rzM3gAQSA==
X-Received: by 2002:a05:600c:4e94:: with SMTP id f20mr30868007wmq.52.1634926786602;
        Fri, 22 Oct 2021 11:19:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] refs: plug memory leak in repo_default_branch_name()
Date:   Fri, 22 Oct 2021 20:19:39 +0200
Message-Id: <patch-v3-6.6-d2f639b53cd-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in repo_default_branch_name(), we'll leak memory
before exit(128) here.

Normally we would not care much about such leaks, we do leak the
memory, as e.g. valgrind(1) will report. But the more commonly used
SANITIZE=leak mode will use GCC and Clang's LSAN mode will not
normally report such leaks.

At least one GCC version does that in this case, and having the tests
fail under -O3 would be annoying, so let's free() the allocated memory
here.

This uses a new die_message() function introduced in a preceding
commit. That new function makes the flow around such code easier to
manage. In this case we can't free(ret) before the die().

In this case only the "free(full_ref)" appears to be needed, but since
we're freeing one let's free both, some other compiler or version
might arrange this code in such a way as to complain about "ret" too
with SANITIZE=leak, and valgrind(1) will do so in any case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 7f019c2377e..2a816c9561d 100644
--- a/refs.c
+++ b/refs.c
@@ -577,6 +577,7 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 	const char *config_display_key = "init.defaultBranch";
 	char *ret = NULL, *full_ref;
 	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
+	int exit_with = 0;
 
 	if (env && *env)
 		ret = xstrdup(env);
@@ -591,8 +592,13 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
 	if (check_refname_format(full_ref, 0))
-		die(_("invalid branch name: %s = %s"), config_display_key, ret);
+		exit_with = die_message(_("invalid branch name: %s = %s"),
+					config_display_key, ret);
 	free(full_ref);
+	if (exit_with) {
+		free(ret);
+		exit(exit_with);
+	}
 
 	return ret;
 }
-- 
2.33.1.1494.g88b39a443e1


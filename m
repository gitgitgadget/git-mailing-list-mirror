Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF599C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhLONqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhLONqM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 08:46:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FADC061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t9so38304626wrx.7
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bkM55JutuPy5Bj2XQ92/MSM2wQIb24IQFA9MxfrcIXc=;
        b=hOn0B/1ypv79/faXeClZWwx6S5ewgNWC8yBwM9/xZjeA/D4W4ciO9BZqMh9pIMT+a4
         YOXKg/JQmeZmDIbLk+SCOP3fS6/eH/bMHafx/gv5cusswQhXnpoKZMQzpOM+EQDPHKYg
         ECVyOnHgcpBnLsylfDo+KGY+oAULG8h9mAwwWg8GD74/ltxy8UO3dvjOz+//qqLKYN1J
         sc66T9Y9LlopA7Rsuw+Bw30vJYxHiNvqtdHyDvRsJ2rfE1GgAuV5wGK/bTZk/cZLyayL
         x8mBcXivStYz9MJIjYj/pntdWrgsF73rFaJWpYgfl9IFDwFnQBEIP6s1R/ujUOUBTR9P
         q/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bkM55JutuPy5Bj2XQ92/MSM2wQIb24IQFA9MxfrcIXc=;
        b=DRKkYNI+FQSnhGqKzlDofgadfaSEEF6GB7WcfyXWYKxYw/C05s2QVvwafykTZiyZBI
         K0koTXOEn+YJVNoO6pJoRuT027yidfJsJlpQKu5TOKL61ZQaIYYwuITaY0ooLvgAh/ju
         KhS5uGL3ldnhdnZU0+DHRa4UoAxQZXZW6BFbqbh9O46KnmXOIMj+HMWfoZm6a0eWzxuA
         py+79iRO/PFJSlTjrN++hfpjGzEToHz3GOMJx0M0+NKEHSqIpfo5GfZ7SLBV3qXynWvx
         jpORlSvnvm74Z79xmQez1OwvAUjcPwbACAy0VsvqiOonwHuObpjhx6EC80YAYfa/Y9kB
         eTtg==
X-Gm-Message-State: AOAM532mFqQ65UynGU0D/AICrfKHFowOeLes420TY1ojG1KzGyUPt3ge
        4iwOcD4AfIPS5lE+VyIH/s6pUVrEt1QIYw==
X-Google-Smtp-Source: ABdhPJwKZGz6xz/Z8aiOqoV05GqHpBfrhik2ESOqtOUQRGykFR6qUvEE5vazor4CloIBFSKJtumb7A==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr4397607wru.316.1639575970081;
        Wed, 15 Dec 2021 05:46:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm2113018wrg.105.2021.12.15.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:46:09 -0800 (PST)
Message-Id: <1744a26845fbe4d7dbc80f387be1d842b5f8fe94.1639575968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
        <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 13:46:06 +0000
Subject: [PATCH v3 1/3] sparse-checkout: fix segfault on malformed patterns
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

Then core.sparseCheckoutCone is enabled, the sparse-checkout patterns are
used to populate two hashsets that accelerate pattern matching. If the user
modifies the sparse-checkout file outside of the 'sparse-checkout' builtin,
then strange patterns can happen, triggering some error checks.

One of these error checks is possible to hit when some special characters
exist in a line. A warning message is correctly written to stderr, but then
there is additional logic that attempts to remove the line from the hashset
and free the data. This leads to a segfault in the 'git sparse-checkout
list' command because it iterates over the contents of the hashset, which is
now invalid.

The fix here is to stop trying to remove from the hashset. Better to leave
bad data in the sparse-checkout matching logic (with a warning) than to
segfault. If we are in this state, then we are already traversing into
undefined behavior, so this change to keep the entry in the hashset is no
worse than removing it.

Add a test that triggers the segfault without the code change.

Reported-by: John Burnett <johnburnett@johnburnett.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              |  3 ---
 t/t1091-sparse-checkout-builtin.sh | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 5aa6fbad0b7..0693c7cb3ee 100644
--- a/dir.c
+++ b/dir.c
@@ -819,9 +819,6 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		/* we already included this at the parent level */
 		warning(_("your sparse-checkout file may have issues: pattern '%s' is repeated"),
 			given->pattern);
-		hashmap_remove(&pl->parent_hashmap, &translated->ent, &data);
-		free(data);
-		free(translated);
 	}
 
 	return;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..c72b8ee2e7b 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -708,4 +708,19 @@ test_expect_success 'cone mode clears ignored subdirectories' '
 	test_cmp expect out
 '
 
+test_expect_success 'malformed cone-mode patterns' '
+	git -C repo sparse-checkout init --cone &&
+	mkdir -p repo/foo/bar &&
+	touch repo/foo/bar/x repo/foo/y &&
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/foo/
+	!/foo/*/
+	/foo/\*/
+	EOF
+	cat repo/.git/info/sparse-checkout &&
+	git -C repo sparse-checkout list
+'
+
 test_done
-- 
gitgitgadget


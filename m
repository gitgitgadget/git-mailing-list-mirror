Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A62C433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiBMAkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiBMAkK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:10 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5D60061
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j26so10314390wrb.7
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=brGviHVD/ER7adMOJxV+OlzowtgFiRjqrVrbut9m81o=;
        b=SINSBP7wMys/sjgbGKngC+cxzWcEeWEI0iTNMvRJErnUPnBgMf95Bg1ecL+oNXA83D
         ccxbwJQcejp9JpqRQn4iz9HYcVablvYfTKJoM+54RMxSS+CjKqtps01RF31SG8afFyeM
         ivclkk/f3XGAC82SCRcKXYWG+Nexxjw6UqmWgs3RFoL1NkQurhS6duyNniEpbI8pDZjB
         wolt9FAHMObW2Q1OahcJNqeqpZ6MnJM0WZONRq+F5Y9BbwhIiSSM20EeicO8WiluMeT7
         dqRCOJqYXo1JiUkoNJONJTIBV17s225nVSQlTQ8Cb2Uxr0hkA/rK1QgaWL9UK5XLNNhY
         RiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=brGviHVD/ER7adMOJxV+OlzowtgFiRjqrVrbut9m81o=;
        b=c5a+6fxq1UTC8BQOikAfeHBgGmHYpZ3RcUATcBk8LRLCsjxZYzSGG+msLKlMTCHe37
         s0C1meaASX8VdKuvDHdkI4RU9cD7wJKrW6VWqXb/Shgny4qUkxw8zQ0eWfpHldVEjmdR
         gKoO/PIv9Mm9eLbmJCXRGpHA98PlQWVi7l6zi4M+H4dZqDXSs7JrWGL2hluijog8sAuT
         UXBudx304+GNZTXvMjOqAZb70JVYhQoZDQ7nJE/y/2wuPaVsWOFD+V6PxO46eR7spKOj
         IPa9FFxcHJjIe3fgyF2AgtRMfBSoStDra4w8gWj2fHyiv+QT3A6hwRry68af1xR1045E
         XE5w==
X-Gm-Message-State: AOAM532smPIn7wTNaeMngzMh+TaZM5rK3rZj7ToK9xsPMMymGjgNGQzZ
        KI2dLtf5rZ1FMskhzGWrsRIrT+/7LDQ=
X-Google-Smtp-Source: ABdhPJxRk/UQWYiOocThS3k4oSZdk6bXTggHxcMItM+glMOwWumN6Sr6KdVjCu4Strlu4rJFgwFDxg==
X-Received: by 2002:a5d:4bc7:: with SMTP id l7mr6362135wrt.230.1644712804455;
        Sat, 12 Feb 2022 16:40:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16sm13298260wrn.87.2022.02.12.16.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:40:03 -0800 (PST)
Message-Id: <502da48b8f43e2c5a67d5519ac7aacf80accd818.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:56 +0000
Subject: [PATCH 6/7] sparse-checkout: reject arguments in cone-mode that look
 like patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In sparse-checkout add/set under cone mode, the arguments passed are
supposed to be directories rather than gitignore-style patterns.
However, given the amount of effort spent in the manual discussing
patterns, it is easy for users to assume they need to pass patterns such
as
   /foo/*
or
   !/bar/*/
or perhaps they really do ignore the directory rule and specify a
random gitignore-style pattern like
   *.c

To help catch such mistakes, throw an error if any of the positional
arguments:
  * starts with any of '/!'
  * contains any of '*\?[]'

Inform users they can pass --skip-checks if they have a directory that
really does have such special characters in its name.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 16 ++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0f9e737ed97..6e0af166f80 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -704,10 +704,22 @@ static void sanitize_paths(int argc, const char **argv,
 	if (skip_checks)
 		return;
 
-	if (!core_sparse_checkout_cone)
-		for (i = 0; i < argc; i++)
+	for (i = 0; i < argc; i++) {
+		if (core_sparse_checkout_cone) {
+			if (argv[i][0] == '/')
+				die(_("specify directories rather than patterns (no leading slash)"));
+			if (argv[i][0] == '!')
+				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
+			if (strchr(argv[i], '*') ||
+			    strchr(argv[i], '?') ||
+			    strchr(argv[i], '[') ||
+			    strchr(argv[i], ']'))
+				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]' in it, pass --skip-checks"));
+		} else {
 			if (argv[i][0] == '#')
 				die(_("paths beginning with a '#' must be preceeded by a backslash"));
+		}
+	}
 
 	for (i = 0; i < argc; i++) {
 		struct cache_entry *ce;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 32b77415679..343ce16a534 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -691,7 +691,7 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped characters' '
 	git -C escaped reset --hard $COMMIT &&
 	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" zglob[!a]? &&
 	git -C escaped sparse-checkout init --cone &&
-	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
+	git -C escaped sparse-checkout set --skip-checks zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" "zglob[!a]?" &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
-- 
gitgitgadget


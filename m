Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3965C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiGJTQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJTQk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 15:16:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507212D1E
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 12:16:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so4532274wrr.6
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xlkgqC5iQ/7VFM49E0bzzfl1UKZmHPsHGIFuh1MlkLU=;
        b=ixkE+PhjS+xQFXUz3aStwjF4gEdYH70mP3CIe8sqw+UNYwwrvoFbG6Pj98gFonBjm1
         t3OGGEHkWiUtksHA11gxFHsPtrgj6HMguKXfuklP7K9VBAwSeAi0d9XqOmHD1EhItjGd
         pwr+AXnhUMp9J8fEfWPbZlmmkrSos1+RjXYuBn4NjK5uPzadUOnxCoyJuZW7NdyTFSII
         zppWzzX6TTxy8SU1/J1nWY+UY1Urv/Bme193pOQcohbrQS/lTvDKzh2+CHaOUVX7/52P
         TI/y0rBOp7rk8b8OyJS7L0aZLh5A/tRMAcm6GlE4wlkyr2Afn0Kkt8d+CP8+tqZkRyFs
         sScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xlkgqC5iQ/7VFM49E0bzzfl1UKZmHPsHGIFuh1MlkLU=;
        b=g5L1fn1kkKIto5A6cEkK9Q2T36EgthHL38WWrkzPc5cqrvpl9/VJETirwPom8v39rC
         0zXr2+MTjWwYln374KMGvkKNAuxkTAwttkpU/nT1VvnZHIDefe/uvrnMxlnLNKPKgAVx
         TJ4lSena7wsaYJS2WOdIN4Ao52l5cGK1A4gbpqFzgWhRY0u8erpVKAT4wXkWTIOiZrhz
         DKmfoS0WsKpG3ZzbkdlcXrqbYGhr8hQLnHQpzS2HCvSOf4peVheXaPQgYuu7/ystuisI
         ge8jKCTf0T8Y5qw3RIcwDQ9smjZafKcmU09aZqhR3l2EJeYP9TYPVG58JBJhlofPSknG
         6ajg==
X-Gm-Message-State: AJIora9XW4aMUPL/dBWDXGVqzBGQwFTp0DDaRMHnCmraWBdBryc4evaP
        WWT3tBwfYuTalnFMVGZ2lWT3CTsh5DI=
X-Google-Smtp-Source: AGRyM1vSD/xKpZ/EUFfPUQb2t0/2Lr1U0bits7Y4Kugdy2jv9idWXel39iwUUkH86oMkMQyxLC+SQw==
X-Received: by 2002:adf:fc02:0:b0:21d:7de9:2e8 with SMTP id i2-20020adffc02000000b0021d7de902e8mr12813623wrr.706.1657480595704;
        Sun, 10 Jul 2022 12:16:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003a02de5de80sm7848764wms.4.2022.07.10.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 12:16:34 -0700 (PDT)
Message-Id: <pull.1279.git.1657480594123.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 10 Jul 2022 19:16:33 +0000
Subject: [PATCH] rev-parse: respect push.autosetupremote when evaluating
 @{push}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In a previous release, the push.autosetupremote config was introduced to
ease new branch management in "simple" single-remote workflows. This makes
"git push" work on new branches (without configured upstream) with
push.default set to "simple" or "upstream" and it implies
"--set-upstream" regardless of whether the same-name remote branch exists
or not.

The "@{push}" suffix logic was not adjusted to account for this new option,
however, and sometimes returns an error when "git push" would successfully
push to an existing remote branch.

This is an edge-case, as the main context where push.autosetupremote will
apply is for *new* branches, with no corresponding remote branch yet, and
so even if the defaulting is handled correctly, the rev-parse will still
fail with "unknown revision or path not in the working tree".

Fix this edge-case so "git rev-parse @{push}" works, if there is no
upstream tracking relationship set up but the remote tracking branch that
will be defaulted to does exist and can be resolved.

Also add corresponding test cases.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    rev-parse: respect push.autosetupremote when evaluating @{push}
    
    Minor consistency fix for previously-introduced "push.autosetupremote"
    option.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1279%2FTaoK%2Ftao-rev-parse-autosetupremote-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1279/TaoK/tao-rev-parse-autosetupremote-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1279

 remote.c                  | 30 ++++++++++++++++++++++++++++--
 t/t1514-rev-parse-push.sh | 20 ++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index b19e3a2f015..59f5bf5b5f5 100644
--- a/remote.c
+++ b/remote.c
@@ -1919,6 +1919,23 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
+static const char *default_missing_upstream(struct remote *remote,
+				    struct branch *branch,
+				    struct strbuf *err)
+{
+	int autosetupremote = 0;
+
+	if (branch && (!branch->merge || !branch->merge[0])) {
+		repo_config_get_bool(the_repository,
+				     "push.autosetupremote",
+				     &autosetupremote);
+		if (autosetupremote)
+			return tracking_for_push_dest(remote, branch->refname, err);
+	}
+
+	return NULL;
+}
+
 static const char *branch_get_push_1(struct remote_state *remote_state,
 				     struct branch *branch, struct strbuf *err)
 {
@@ -1959,13 +1976,22 @@ static const char *branch_get_push_1(struct remote_state *remote_state,
 		return tracking_for_push_dest(remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
-		return branch_get_upstream(branch, err);
-
+		{
+			const char *up;
+			up = default_missing_upstream(remote, branch, err);
+			if (up)
+				return up;
+			return branch_get_upstream(branch, err);
+		}
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		{
 			const char *up, *cur;
 
+			up = default_missing_upstream(remote, branch, err);
+			if (up)
+				return up;
+
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index d868a081105..ffa0db14585 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -21,7 +21,10 @@ test_expect_success 'setup' '
 	git push origin HEAD &&
 	git branch --set-upstream-to=origin/main main &&
 	git branch --track topic origin/main &&
+	git branch --no-track indie_topic origin/main &&
+	git branch --no-track new_topic origin/main &&
 	git push origin topic &&
+	git push origin indie_topic &&
 	git push other topic
 '
 
@@ -73,4 +76,21 @@ test_expect_success 'resolving @{push} fails with a detached HEAD' '
 	test_must_fail git rev-parse @{push}
 '
 
+test_expect_success '@{push} with default=simple without tracking' '
+	test_config push.default simple &&
+	test_must_fail git rev-parse indie_topic@{push}
+'
+
+test_expect_success '@{push} with default=simple with autosetupremote' '
+	test_config push.default simple &&
+	test_config push.autosetupremote true &&
+	resolve indie_topic@{push} refs/remotes/origin/indie_topic
+'
+
+test_expect_success '@{push} with default=simple with autosetupremote, new branch' '
+	test_config push.default simple &&
+	test_config push.autosetupremote true &&
+	test_must_fail git rev-parse new_topic@{push}
+'
+
 test_done

base-commit: 39c15e485575089eb77c769f6da02f98a55905e0
-- 
gitgitgadget

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3415C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B600061206
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhDMOCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbhDMOCD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CCC06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so3851883wrx.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wy+APj9NNOktVQw1Dg8sosD01WrzUgk01YbHujHnv/M=;
        b=MeMEm/wQTmjLU4NX0pkv2DYWZyVFVgfjleYo8/Xja3JY064bIUl2TNOQbxAMM9+P33
         lmEPAH5jxRfSudXiSboLqPtjjtF1Sb9jJr8shCLPx2Gby9TjwJRRAykBew34CDn8uNLg
         02vJWslsj6/gsnSVcHhiXnwga/IdYyMvTIbHa8thK3zvhgeF+jq0SBfRXssJJA6HzZu3
         3sUuf4pm+UIfag6w43hNwUuu/SCgcO2oznzuEMljHTG0ybdGbbW+AMAmjoHUDkLteUrP
         8i7+pwDnptv3fhjfNQg/ujnW/R+BOMR1kfy/NA3GeXsfsZArNiv8aZyWdG7HBFk8EZrL
         EAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wy+APj9NNOktVQw1Dg8sosD01WrzUgk01YbHujHnv/M=;
        b=QHlHv+QNIvUWABWUz8CIsPy/4LB31sfaR9FsB1EvOLgy23CPAL3zjW8502BUpoOe+d
         6mzh3Avtjti/09VbE/dUbmjPcf8os9qb08pGBFmQMrTJLwe5l6IobYjMFiSRW2xA5UI1
         Ma9X+DhKwqYDfPLz3LjDzCWs6CcVHP+eYFSk97rpR5T0DAm++4FS4g+YSUZWAFSH5x+O
         k/OZXK79r4lOWHNz9hcBIkVuuWFXzsVkv66noI5l2SleKj3IO/LTG73UdUW9bpzmp9JS
         Y/t8mrkV26B059VEm0Yxvmpw2hfiJwN6Av6cSe5qDpT8btsylytPd6dyHnlrrWnKzbfh
         8X2g==
X-Gm-Message-State: AOAM532LOteRh+gv/LURAlUsfrmaCvkp5mlYRUOijdMJdXpIFE0VCxed
        7rmQqms7hbroQ7pnm3pCOhBd/Z0XakY=
X-Google-Smtp-Source: ABdhPJzI9N60MqHz03WFfNFGO6KyUi0A+PBTxu0nRW8JCdNSIgbStAOXx5oRFi76q1Q9vY7xH2Wvsw==
X-Received: by 2002:adf:de08:: with SMTP id b8mr10379034wrm.279.1618322499870;
        Tue, 13 Apr 2021 07:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2sm2582184wmp.20.2021.04.13.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:39 -0700 (PDT)
Message-Id: <b2cb5401eff83c43ca805a36bf41a28a6ffc3630.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:28 +0000
Subject: [PATCH 01/10] t1092: add tests for status/add and sparse files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before moving to update 'git status' and 'git add' to work with sparse
indexes, add an explicit test that ensures the sparse-index works the
same as a normal sparse-checkout when the worktree contains directories
and files outside of the sparse cone.

Specifically, 'folder1/a' is a file in our test repo, but 'folder1' is
not in the sparse cone. When 'folder1/a' is modified, the file
'folder1/a' is shown as modified, but adding it fails. This is new
behavior as of a20f704 (add: warn when asked to update SKIP_WORKTREE
entries, 2021-04-08). Before that change, these adds would be silently
ignored.

Untracked files are fine: adding new files both with 'git add .' and
'git add folder1/' works just as in a full checkout. This may not be
entirely desirable, but we are not intending to change behavior at the
moment, only document it.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 12e6c453024f..6598c12a2069 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -232,6 +232,42 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'status/add: outside sparse cone' '
+	init_repos &&
+
+	# folder1 is at HEAD, but outside the sparse cone
+	run_on_sparse mkdir folder1 &&
+	cp initial-repo/folder1/a sparse-checkout/folder1/a &&
+	cp initial-repo/folder1/a sparse-index/folder1/a &&
+
+	test_sparse_match git status &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+	run_on_all ../edit-contents folder1/a &&
+	run_on_all ../edit-contents folder1/new &&
+
+	test_sparse_match git status --porcelain=v2 &&
+
+	# This "git add folder1/a" is completely ignored
+	# by the sparse-checkout repos. It causes the
+	# full repo to have a different staged environment.
+	test_must_fail git -C sparse-checkout add folder1/a &&
+	test_must_fail git -C sparse-index add folder1/a &&
+	git -C full-checkout checkout HEAD -- folder1/a &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	test_all_match git add . &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m folder1/new &&
+
+	run_on_all ../edit-contents folder1/newer &&
+	test_all_match git add folder1/ &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m folder1/newer
+'
+
 test_expect_success 'checkout and reset --hard' '
 	init_repos &&
 
-- 
gitgitgadget


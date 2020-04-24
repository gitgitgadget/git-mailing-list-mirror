Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22EEC54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29BB206D7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3mZNdkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgDXRRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgDXRRn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:17:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE6CC09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:17:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k13so11813109wrw.7
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TrqfBfKsxTjIM6Xib331lnGezZRE3i7y+ZI6w1fceyY=;
        b=Z3mZNdkIZKj8V6xaltFxdfekkrq9XsjzuHYkG4jhk2AIYfU9aLRNA8vNBLrSNVV9zn
         TBWTY5eXdxCVwUnQaYyugGJ/iLmRb4qtnyZDszMmGQ5TRcIzsfxdyW0fmqJQlFolZ8r2
         vZS+srgLtVVVKSTVUDsdK1bTg8vnQ1JMc5iQSUsXNrwtd95+gcgXVZc/hjkk71WHVsd4
         yimd6I+k03/UBB+2MLlEPI1Jbtxxnjru4Tw/FxAj9upJ8FAIqx9G8ONoA0QmkBamfhKu
         ACpPf2+R8wRFlrmiMEcpShJjogxyIUAbQUkJuUyr0XsqZGkssCPRf+OIUVjM83RmZSwv
         +Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TrqfBfKsxTjIM6Xib331lnGezZRE3i7y+ZI6w1fceyY=;
        b=fhYU5WgMUs9uzsO/Btgh9RWnY4YY4t2MWi2lFRQc1mLXqk2U7Wt9dGZfo9NiFILy76
         ZZIJpaCS1F54FIb14JU66FMJ3q+OViy0mKRtpgRXcl4qKQwdfu4QRNGF5CVWDS9J0EK1
         YNOJT73M5XUbsZDdFh0lhZwwh+pBmJlenRGqP0VHpJxqR5LUUUAjMzuHO/91kDq8WkR7
         Selh/kJs3+us9uDiIGFqVA/pnmgIu6o4OWQ85y4OdZ1dwlH8EBa2JFJw7KTInPJGD2xO
         Te/614P1q3WpC/7Ml+XPD8mnv1KRjAXu6J90pNhRiOiIctx93wjgsjknt5anfJ3gHd3z
         27IA==
X-Gm-Message-State: AGi0Puag6DUiN8TEx2vYK05FP45J+4kLp3JwNYDW33F6QpaI0JVzCJrS
        ITWEoAoJG8sW5U2P2VfoUn3cYK1j
X-Google-Smtp-Source: APiQypJuDoZGy1O/OJkrOYqRNol06UlHLFprpGPTsrf9fA16kyp7PRhHZgbRJzwuluaXupdJPXZVnA==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr12504470wrp.275.1587748661251;
        Fri, 24 Apr 2020 10:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm3846514wmj.14.2020.04.24.10.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:17:40 -0700 (PDT)
Message-Id: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 17:17:40 +0000
Subject: [PATCH] ci: fix GitHub workflow when on a tagged revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `master` is tagged, and then both `master` and the tag are pushed,
Travis CI will happily build both. That is a waste of energy, which is
why we skip the build for `master` in that case.

However, our GitHub workflow does not trigger on tags, therefore, this
logic results in a missing build for that revision.

Even worse: the run would _fail_ because we would skip the Windows
build, there are no artifacts to publish, and therefore no artifacts to
download in the Windows test jobs.

Let's just change the GitHub workflow to skip the logic to skip
revisions that are tagged.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Do not skip tagged revisions in the GitHub workflow runs
    
    I noticed a failure in the run for Git for Windows v2.26.2 which was
    caused by this.
    
    This patch is based on dd/ci-swap-azure-pipelines-with-github-actions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-619%2Fdscho%2Fgithub-workflows-and-tags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-619/dscho/github-workflows-and-tags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/619

 ci/lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index dac36886e37..f151e2f0ecb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,6 +1,7 @@
 # Library of functions shared by all CI scripts
 
 skip_branch_tip_with_tag () {
+	test -z "$DONT_SKIP_TAGS" || return 0
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
 	# both at the same time is a waste.
@@ -151,6 +152,7 @@ then
 	CC="${CC:-gcc}"
 
 	cache_dir="$HOME/none"
+	DONT_SKIP_TAGS=t
 
 	export GIT_PROVE_OPTS="--timer --jobs 10"
 	export GIT_TEST_OPTS="--verbose-log -x"

base-commit: f72f328bc57e1b0db380ef76e0c1e94a9ed0ac7c
-- 
gitgitgadget

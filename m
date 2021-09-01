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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B0C00143
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28D360F6C
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbhIAL6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243940AbhIAL6U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:58:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5840BC0617A8
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:57:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z4so4094128wrr.6
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aj7qmTvNoJwSdr7mXvo6B3RIS1tbzvVYyRSRPuAGcrc=;
        b=n14LREJEFQe6tL/gNL9Q1hg1vBppD9KKi9F7jLGA9FFj5o2CsuieER694XOUqTVpwL
         CABVBAsnwlY3gVCIfetsl6OkGmCQfsN56nIiGkaU78czAGFip/cHRdsN1r6Yi+vrlj9Z
         VpiYkrti57ZrszqR9Umm+y4mElP89PWLBJw+pGiiW3/pARfLWIxR1B9uXBD7n182CPXc
         uWq5ms33U5dBe4ca15cHzyiFlQCeSVMdlIe3vtkrJDsnJLNfES6plosBMWGpeEtJGd8X
         JDYLlvQWiGZE4yB6KKPfOyDcPttlfsc53qhiAYwNAjr2ynzNgnB75SVwJ6AeLcMmTJ7l
         ruyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aj7qmTvNoJwSdr7mXvo6B3RIS1tbzvVYyRSRPuAGcrc=;
        b=bL8qCdDwFKXV/oEiQfNN/y75FpKfMvjePcgIT4a/cP2VFn2FLs/TRdjk5TLdYivwNQ
         9UDue0COEWsDzEUs4KooDLO/0SKdLfzM3AyRz4sGQ71VaYNu3gGVaWW1+QXhhCAeopjy
         5HdLqWK0wjIGzxx6IRlKptuNQKz0VYxac7/WBaoyIdb9ycyYvakPXkIHzy38CmwaIOFi
         BUxJZA5YbwuBTZEr60AfR3yPqbi3AIhHCTgBnSy0epTXG391ROdA6R1WghLnOp/78U6B
         HYAaL9c4FOVFTeK0Uaf49hbwCXG1HCIxc5vVcsp5ux164qpgEUPged+KwmHxO6U8l5Jl
         09kQ==
X-Gm-Message-State: AOAM532o1GtLv6jXBWZxYXFakW45osqCIDM7GmoT2q9ooE8JfbJNAdgD
        DcMJm6kIEIjsFzNEc6WCP7yBHYmqY9s=
X-Google-Smtp-Source: ABdhPJzrkKuW5kn3K35Up79uaNFBbutHukqeveJO4rXTjFGh/qyv3de/ri4vudTTgYpAssFzKQv5ow==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr37035799wrq.174.1630497440992;
        Wed, 01 Sep 2021 04:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm20938969wrb.62.2021.09.01.04.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:57:20 -0700 (PDT)
Message-Id: <a987e9439af6335e15a3d41b82832e9a8824317b.1630497435.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
        <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 11:57:13 +0000
Subject: [PATCH v2 6/7] git-svn: drop support for `--preserve-merges`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We already passed the `--rebase-merges` option to `git rebase` instead,
now we make this move permanent.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-svn.txt | 1 -
 git-svn.perl              | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d5776ffcfd5..222b556d7a9 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -678,7 +678,6 @@ config key: svn.authorsProg
 --strategy=<strategy>::
 -p::
 --rebase-merges::
---preserve-merges (DEPRECATED)::
 	These are only used with the 'dcommit' and 'rebase' commands.
 +
 Passed directly to 'git rebase' when using 'dcommit' if a
diff --git a/git-svn.perl b/git-svn.perl
index 70cb5e2a83b..be987e316f9 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -273,7 +273,6 @@ my %cmd = (
 			  'fetch-all|all' => \$_fetch_all,
 			  'dry-run|n' => \$_dry_run,
 			  'rebase-merges|p' => \$_rebase_merges,
-			  'preserve-merges|p' => \$_rebase_merges,
 			  %fc_opts } ],
 	'commit-diff' => [ \&cmd_commit_diff,
 	                   'Commit a diff between two trees',
-- 
gitgitgadget


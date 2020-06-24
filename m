Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA1DC433E2
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A23020724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUjJlCJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391292AbgFXOqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389253AbgFXOqm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC2C0613ED
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g18so2580384wrm.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0X4OIh+5wlwwOufNlNxI8I6NYiLAwPFO7s8kaVL4YYQ=;
        b=JUjJlCJ4zx3GlgaG0Zzo46rtAS3Ljia52G69qYZ00yPVH+gf3ucJ/YwHzh4/HvNdfw
         M9OFe5YyjdngTx4pmAOrmAdsqYTwo/rc1sK9LHbTk1aMuZ2sX2KT5zgnFGtFsDBu0Wr4
         5AcG8j14yTjtJ/LPl0XHn+9wYPJh6M4nRAprHeiZb30HNoBK+NLVk5G9d6O+Z8aTw4jP
         ehVTYExJ6AlL3OyalnOaYRuBwFakhxq1NE/kkj+iTisb3Xjm+Z8pjCfKPvZZyY7BRRvk
         rGh9HN2XvRkkk1XkotxgTppZHqSJoEncMiZZdwokoKS+Wtl8s7Af/a6OjEzsRY/ECXPq
         DymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0X4OIh+5wlwwOufNlNxI8I6NYiLAwPFO7s8kaVL4YYQ=;
        b=iTLnzV1P7RvUlJeq5L0LkpA5FNyKB26QcSpJqZVUr6Fac9hwUJzgXx2NFKlYF6twXj
         oz8ZYDEHPRDKJ0QQts9f0OmWRTgpotMQsTuHpN7gBpVHKDclHsZE1/bLTpCY6bu/BJ2n
         FoLskyzS8/ZLF4HCkACNwWFxR1Vl2WWSApUU1DTd8uYLsMlreNM+G8TAyI0SUN+4cjsR
         pTaweLmhH1m7YFpNwtpOp/xqdM9x91MMQ9UWnKiDlFcxsHA3rFuFms3wPEsG+B/5ZcJB
         sdrLCVhGTQiO93cl1ytunBzDyuaU0KeXNZNZ6d75LvM6LOYJwxEspWjgfp0Gtd4ynkgR
         xaaA==
X-Gm-Message-State: AOAM5322ZUZbVEZw5UiKcGY1hTjN12iQpdT6ZyMXEDcWkezWZQ3UXYtk
        Nkzbpw14ksq1/6Om3g01xt97IbZyfas=
X-Google-Smtp-Source: ABdhPJzImERDcFoH0QsEZh5vC743TrNQ1fS8iiJhe0ZuCmtHEvNKaKH626Sxa3tDL1YrrfGtGwIoZQ==
X-Received: by 2002:adf:afc3:: with SMTP id y3mr32474730wrd.277.1593010001224;
        Wed, 24 Jun 2020 07:46:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm6958386wrq.3.2020.06.24.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:40 -0700 (PDT)
Message-Id: <1d723d35ed107e084a363b5eeb2b505dbe0c21eb.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:31 +0000
Subject: [PATCH v4 4/9] docs: add missing diamond brackets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There were a couple of instances in our manual pages that had an
opening diamond bracket without a corresponding closing one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-branch.txt | 2 +-
 Documentation/git-clone.txt  | 2 +-
 Documentation/git-init.txt   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 135206ff4a..03c0824d52 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 	[-v [--abbrev=<length> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[(--merged | --no-merged) [<commit>]]
-	[--contains [<commit]] [--no-contains [<commit>]]
+	[--contains [<commit>]] [--no-contains [<commit>]]
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 08d6045c4a..c898310099 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -259,7 +259,7 @@ maintain a branch with no references other than a single cloned
 branch. This is useful e.g. to maintain minimal clones of the default
 branch of some repository for search indexing.
 
---recurse-submodules[=<pathspec]::
+--recurse-submodules[=<pathspec>]::
 	After the clone is created, initialize and clone submodules
 	within based on the provided pathspec.  If no pathspec is
 	provided, all submodules are initialized and cloned.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index adc6adfd38..f9467cc6a4 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>] [--object-format=<format]
+	  [--separate-git-dir <git dir>] [--object-format=<format>]
 	  [--shared[=<permissions>]] [directory]
 
 
-- 
gitgitgadget


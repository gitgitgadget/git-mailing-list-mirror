Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2FC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDAA60F48
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 06:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbhIXGi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244216AbhIXGis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 02:38:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED137C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so24167000wrb.0
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/3m+7QqjHSrfqnwKbprHOY8NTr4Stirdf/5VwuV4OCM=;
        b=ebyZxa+TDgUplYMH8yHU7QXMIxWXqB6meKBtiGc1jOdTWyhRJrkOLRmQvdtBxXxPB+
         UDgWdE17Zs92lsihpURBz8zqcIIcb4I/bU/b5Nzu1W+/dQQENW0X0CH9MXZSijll8GPZ
         3qDo39biFOgdndLtT4uYcbU2eiRLv7NLmIGWfuVbK6qXySf7wy3jxfK5ZFfL6leWpIh5
         +XkAhbFu/p1WE4giVuUnUAa43UYdGIqkUENNWuzsRPwJYo3UZ36tRawaqFcPFOJJw1Sb
         8GkROjjOwkTosch1Z1q2m4pdROYwaBVpdCzLibH1nbI4gqbO8YPWtmCxBJj4ESFfnWZ8
         32ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/3m+7QqjHSrfqnwKbprHOY8NTr4Stirdf/5VwuV4OCM=;
        b=ZkgczEsBFyJ7kcRnbETip2uJO16Rm1Ea2G/Mp99wOKOXr8yXtkKJOo8high8NsYejD
         5TCrbT9wGl9x1hxIADIa50cNs6P2cRcYmIXafHFqEEtyie6R5hl0zJietE6LFjQPDyP2
         ivUxZWDZTbU/Oie/6S3iWV+NpKH3w7AQN+ExOzJDlp4/qriC/OrHfpn7CoNduZuODQlD
         W01s8FvNNmsgF0y2aTZRovqC+GV364Xw4ZLYW34dX5vyQPBLqJ93vxwo/MwnMVWDNlaw
         t+C9g9tmwOk+fLDuX2E8gitBxDio2x0zMoq1Y20rC0I4zjNRYcWDX2FrJw01IG5XsM5X
         3M7Q==
X-Gm-Message-State: AOAM531V8rN92ENkYuUrsAD3IBBLgQTe/B6Z40nR0+kfy/07q5SAHjC3
        zjp7jT/KjTSiV14CmAwhexUgP1tJlsQ=
X-Google-Smtp-Source: ABdhPJwxkU1mTBmp8zqgK5iKZmHsk1HtdelQeHERV5dme5QmKC1EyMBkczRJHH3BtVNqae6ZL5ibVQ==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr301125wmk.116.1632465434532;
        Thu, 23 Sep 2021 23:37:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a202sm11778491wmd.15.2021.09.23.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:37:14 -0700 (PDT)
Message-Id: <993451a8036165930fb6ada72156695c24940c6c.1632465429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
        <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 06:37:09 +0000
Subject: [PATCH v2 6/6] Documentation: call out commands that nuke untracked
 files/directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Some commands have traditionally also removed untracked files (or
directories) that were in the way of a tracked file we needed.  Document
these cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-checkout.txt  | 5 +++--
 Documentation/git-read-tree.txt | 5 +++--
 Documentation/git-reset.txt     | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe44997..d473c9bf387 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,8 +118,9 @@ OPTIONS
 -f::
 --force::
 	When switching branches, proceed even if the index or the
-	working tree differs from `HEAD`.  This is used to throw away
-	local changes.
+	working tree differs from `HEAD`, and even if there are untracked
+	files in the way.  This is used to throw away local changes and
+	any untracked files or directories that are in the way.
 +
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5fa8bab64c2..4731ec3283f 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -39,8 +39,9 @@ OPTIONS
 
 --reset::
 	Same as -m, except that unmerged entries are discarded instead
-	of failing. When used with `-u`, updates leading to loss of
-	working tree changes will not abort the operation.
+	of failing.  When used with `-u`, updates leading to loss of
+	working tree changes or untracked files or directories will not
+	abort the operation.
 
 -u::
 	After a successful merge, update the files in the work
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 252e2d4e47d..6f7685f53d5 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -69,7 +69,8 @@ linkgit:git-add[1]).
 
 --hard::
 	Resets the index and working tree. Any changes to tracked files in the
-	working tree since `<commit>` are discarded.
+	working tree since `<commit>` are discarded.  Any untracked files or
+	directories in the way of writing any tracked files are simply deleted.
 
 --merge::
 	Resets the index and updates the files in the working tree that are
-- 
gitgitgadget

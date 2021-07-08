Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE12C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B68E61621
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhGHPxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhGHPx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:53:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFB0C061760
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 08:50:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p8so8153076wrr.1
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i67g+3kM8fu0ZSxeCuCgoTqnwSExukN5fXsrjYMc2Vw=;
        b=GJQze7mdBOLP+OpcHgnQI3Jfo9KGSeau9dI76Re9gGAC/v901enCOyLiueLocOEZCs
         0+E4K/n4fvciJTnsDPXhsoncgwYlyuEV+E4JhnFD9u65T0+5LJ9qAZzPa2738ZMc7+OS
         tavQDkUC44N77KB1d08FSrp6SpLkMcvDPcsppOsao+Qddk9iMHDEgn2YMtfk9BmzivQv
         QmCB9wpYQ6HkTQefl4HCXfWjCSAhtNtQo3qooTLhwicOExrcGEF2LwdZEPTosZKLJmGU
         KhwglaBk4VnNEYQGGjdGKYUFxnkbprHbeRUzGW9KjmSR9qBsZzAsgKgKG/yPGoI6Hias
         EDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=i67g+3kM8fu0ZSxeCuCgoTqnwSExukN5fXsrjYMc2Vw=;
        b=q8alFQrAzWqsC7o9N4EaReQfL7ekEZnLAl01ZvOAAAMOJg90E6J114Nxuud9rZWOeZ
         BU9JAPvLXoUauX+iD59U3E/Cn/XcEIUCiS1hPT3vzRtA/eQZuNM7gsjI0+Unl+3j5cUP
         fax42bMfgVVNluVQwNryW8tH3w2CSX2F1UDpYzYOOqAk1XNl+YcUG9AJ26mbKpMQih0D
         MMYJkX20JGecCua9f37U65sL4mlQhX5DYQ9FZfzv8k4ELmlGzEk2WowwvHqyW2NPpCPY
         TUaIBwx4AP5YV1jCchp1ewpyLAlie7L6tq7FU4NU2a+jjGgM5FdTNd/LM6FDW1v3ulIT
         plgQ==
X-Gm-Message-State: AOAM530nhe7KCiQAgnKm7yrWeNyGa0A1KGJo+cS615rUQYcXWIEbWJOS
        sSut8yEFOLF15fMBLHi/PzLQdclmdcY=
X-Google-Smtp-Source: ABdhPJyj/ZVxs2uiqQWEu7BuWedyRU/x6IbkI5t0bVQsxa6b+n+EPJvt317cQdI1PHqi9uN5NDAORw==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr33116706wrt.153.1625759445228;
        Thu, 08 Jul 2021 08:50:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm2635249wro.30.2021.07.08.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:50:44 -0700 (PDT)
Message-Id: <5459e5bb4212e47873d2862c4a96651c2f7d96b5.1625759443.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <pull.992.v2.git.1625759443.gitgitgadget@gmail.com>
From:   "Stephen Manz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Jul 2021 15:50:41 +0000
Subject: [PATCH v2 1/3] t2400: remove unneeded `git rev-parse` from '"add"
 worktree with lock' test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Stephen Manz <smanz@alum.mit.edu>,
        Stephen Manz <smanz@alum.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Manz <smanz@alum.mit.edu>

It must have come from a copy-paste of another test

Signed-off-by: Stephen Manz <smanz@alum.mit.edu>
---
 t/t2400-worktree-add.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 96dfca15542..874a61dbfa7 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -67,7 +67,6 @@ test_expect_success '"add" worktree' '
 '
 
 test_expect_success '"add" worktree with lock' '
-	git rev-parse HEAD >expect &&
 	git worktree add --detach --lock here-with-lock main &&
 	test -f .git/worktrees/here-with-lock/locked
 '
-- 
gitgitgadget


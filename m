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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659FC432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F30C60F94
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbhHCPfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhHCPfo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065AC06179F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b11so20448552wrx.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U987+ulcGm3hzWmt/FG/WVucoBBBUvxjMrzmM9hO7HQ=;
        b=AQ5IJvKT4XqA7ES+2idgjZKMK3+p45n1UhKhBEUJIFEL6XB6mOfA2/c0sSHxDNgKlp
         166pP1ajUYJoMn9PSZW+qxc4hyaauKXnLxkX3MEZ8hCKgQ606/2ERKW8f7QTlI8ZaEkM
         fvn0eSz2wE8gVmDMbfxQsoCFTIhDQYxo3DkP9QGT14/fl18qL8C8SotyBPcJw9q2OtMy
         BxddpuWqhGqjMEr1BZjuwJAZOOw6+E3F1lASI91sqwd1PAJJODfAMZDurhbf4rvhnjkf
         XUF6O7asDaPAv/r93AFc98KptthVqnMS5TM0mGj4KFF+dN/8Sic6Fuz3rLNx7NVdlEcD
         btbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U987+ulcGm3hzWmt/FG/WVucoBBBUvxjMrzmM9hO7HQ=;
        b=CEn6PeuzgRdXKDD17JViE/nr4LfW0+aHPLWaishn5akPR0GwgVMWpjNbUmVsj0LrGj
         ixfVyb7zx960kECtLj9ONxFODnNOQpreShkSBnVN9b3IRdFn79hWmQ+Sl830ZmoWm+P2
         ydp/F5ycbCzbCdspIUoEa+U02SJAR5O1A7m6GYIpBJUYTFfPhzU26gHsxdccJlp6YaWM
         V8iRQf9+CpYuwB9wqru6Kw1JHLTfAt+l4wCEFY3ez9IL0OsWH7aDagGdC0/zveCleYrK
         BCSzbrraBNciDsxiFgVxcqN9l019n2Z6aO76XI+HuBncEh9voCtmxOI4N71ppW1KL1hK
         Z9og==
X-Gm-Message-State: AOAM533odciDlhfKFiwwaM5ftz/WgqwngClyRBnm1gD95hVq4xg90Pk/
        fX6WC3nkwFqFCAPDgfAyCaknKg1AL5A=
X-Google-Smtp-Source: ABdhPJymy22DdF1R4F6Lgt+rQH9cBTAwniZxsY6F66862OJu1oR2iC0/lxZSjS2caVLfNrz1ve7VHw==
X-Received: by 2002:adf:e0c4:: with SMTP id m4mr23728970wri.312.1628004932240;
        Tue, 03 Aug 2021 08:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9sm14818220wrz.75.2021.08.03.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:31 -0700 (PDT)
Message-Id: <2a7169c8c1be425d4234e414c106ad1278aacdd6.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:20 +0000
Subject: [PATCH 10/10] Update error message and code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were two locations in the code that referred to 'merge-recursive'
but which were also applicable to 'merge-ort'.  Update them to more
general wording.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 2 +-
 sequencer.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f54..24b62a9c532 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -738,7 +738,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
-				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
+				die(_("Unknown strategy option: -X%s"), xopts[x]);
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..a4e5c43fcf2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2065,7 +2065,7 @@ static int do_pick_commit(struct repository *r,
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
-		 * that represents the "current" state for merge-recursive
+		 * that represents the "current" state for the merge machinery
 		 * to work on.
 		 */
 		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
-- 
gitgitgadget

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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA960C4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C234760FC2
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhHCPfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhHCPfo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95FC06179B
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l34-20020a05600c1d22b02902573c214807so2016417wms.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q20QLMCGWJS3y5odzPH+v5RPF9OiX/DaSu750F7vd54=;
        b=nMNl4xHR5tJUm7lBY30a5uUw/QKFyqIviic4TyCKl1qxbVUaEhwoWT4tx5VCD9Xx3Q
         0lXHVTXqQExePcCr2i+yPQ7g/iBq4bmVTuNY8XOmmq9j2Y1FjYdWWkW+HbP6iF4/mFYs
         Lg19pMHbnRzyKC1LyvDli7z4Yqlc73en7f1as0GiROzpkckxJwz7rIgP4UcAOn5Dzpet
         jYNptkHCD6kDJpbMyXybfvRBJM6Cy6xH9V/Oj9O1fbH5ocZBlOspYHe4n4BZOmpp9Yp4
         Jrfhl/0A9UoiIcAfg7Q8sg4AnlIgjZsABArVzyHXr1BYln1iVtEOrIQ/BwRsJrJzCIE4
         hKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q20QLMCGWJS3y5odzPH+v5RPF9OiX/DaSu750F7vd54=;
        b=EoQn3gCZ2ILWITA1ob8Bfud5pddrh/Wq41yWI8+e46ooZwGGGw7ntE39E0huewAhFM
         J6uSJ59hSOyx1FknDIaRSMongiw9rqzDqM1LrgJa0/6UOPp65KTdmR493YKHwLvCqDV/
         MkTYFCjFy5RK5RLbZGF6lVxYBvdNU/l8nrTHCcUh3eOpTqsrLi2iZ7OcTFL0iIgB9lJ/
         FgLBQO5kOd+cLHOS1MYV3lI640irZwK1yJchS5X+H4OnkArxeYzvYupu/a3MYby+OUxo
         9HfgiI1ZBz+np+4X2505KlsQEM7vxAjOxSwWTUoEiuxTc9S7Hwx/6Jt3BYkcOFai6ZyW
         vU+A==
X-Gm-Message-State: AOAM532Ro4vfu4noMBz40mDLv2TBAL2+Y50U6pUr835QEjnHw5SkIlj3
        6mRtqHo58w15aXawuZ21HPDrPcFmuQU=
X-Google-Smtp-Source: ABdhPJyo458bg6QW9znj5z2Xxb8sO7U1bkRyT3YFrEI7TCb9xQlmYsgp3+FlvwdM6UoB9Peo2kVtAw==
X-Received: by 2002:a7b:c0c9:: with SMTP id s9mr22802177wmh.188.1628004931219;
        Tue, 03 Aug 2021 08:35:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17sm14679221wru.94.2021.08.03.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:30 -0700 (PDT)
Message-Id: <37a69fd2e0bdb7fba6b6c47c3edec0964165cb61.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:19 +0000
Subject: [PATCH 09/10] Documentation: add coverage of the `ort` merge strategy
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt       |  7 ++++---
 Documentation/merge-strategies.txt | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b4429954480..3e112011c6f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -340,9 +340,10 @@ See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
-	Use merging strategies to rebase.  When the recursive (default) merge
-	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.  This is the default.
+	Use merging strategies to rebase.  When either the `recursive`
+	(default) or `ort` merge strategy is used, this allows rebase
+	to be aware of renames on the upstream side.  This is the
+	default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index d21dbd1e051..d13d4a29875 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -96,6 +96,20 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+ort::
+	This is meant as a drop-in replacement for the `recursive`
+	algorithm (as reflected in its acronym -- "Ostensibly
+	Recursive's Twin"), and will likely replace it in the future.
+	It fixes corner cases that the `recursive` strategy handles
+	suboptimally, and is significantly faster in large
+	repositories -- especially when many renames are involved.
++
+The `ort` strategy takes all the same options as `recursive`.
+However, it ignores three of those options: `no-renames`,
+`patience` and `diff-algorithm`.  It always runs with rename
+detection (it handles it much faster than `recursive` does), and
+it specifically uses diff-algorithm=histogram.
+
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using a 3-way merge
-- 
gitgitgadget


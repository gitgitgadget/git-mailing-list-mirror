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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187CC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108E460EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhHDXvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhHDXvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CAFC061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:50:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso4508442wms.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wt5gmRNRVTwDXL/bKPtXFYAtdu79hzBOjaNGfv3bFuA=;
        b=axgsHRiSuFoB4Wm0XdD9JmxW3tGkSYHFS+AqAFCzrz+LIs0Rj94ZhzD4liUJEJrCBV
         UrH9XhDQUjRRxJqlBrdu2wNjFF1LdWlPzt1AaRrNRJXbs5cZuOMH7+1OzNLvmN8a4fb9
         sFEeCNd/JaXxYqZ2e7qMeV2P00SqDoEffgzjjmA3I+qq3CvpCVRsCsybAwxCPJ134K2q
         JJfYced62zM4vPaEz+Tyawcah6amlCNt51F1l6VKuNrqTGru4Iy6H76W/WhJY3+id66p
         /UPqYRN9Apdc6KqPYmUzWCmVtbG8/txPk5J7qbwAQDMsS9zQzpEEuzd1AAgHiZrYXvG6
         vyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wt5gmRNRVTwDXL/bKPtXFYAtdu79hzBOjaNGfv3bFuA=;
        b=Hmqs60Krw1OpsqKYxKr43KfKZ8bDNnk5r1aN7ZDUdQdbj3Dk7SIGQPoZ8vY+vZC0q3
         XGsXsMI2cVv2PYhubclr2EWarWHSshhCFKzzWgAwq1Z7/NFvFX7MlvHGwGz7Q2A1IHfc
         gtH0Dodc7pIi8o/vxOUYceWCPgKF0bup0VVNnVqPod+ASdOd4a319MCCdoah0ukm57ma
         tYWU6aOnLLWxyD0K5/rCnArChmavf5K2bZyKNPyQjd97ijwV/V+g874srXjDpncCTBWQ
         NUQKUC3UkeDRRd8f6VzCEn09DfUac/of/+lRAZ6l1OwtC2aW3pZSrdLR6JkEujqv0KPz
         faPA==
X-Gm-Message-State: AOAM533cfmDvgOml18oIc8lTubk5vAzR0pdUhTNF9pRKnWZVL70rVqjN
        lV62r8iaDDEeIaMEHd6TR1tXoU8h5fM=
X-Google-Smtp-Source: ABdhPJzR7NCKWiC4Mvv/tDvckXi0tJgn9bzYZpfzgMo4AINlrshsK3pnYHYc9cqx/UIzN063rBuTvQ==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr12456165wma.49.1628121056774;
        Wed, 04 Aug 2021 16:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm4910553wrt.18.2021.08.04.16.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:56 -0700 (PDT)
Message-Id: <75b81598a8085d7135fa80e3add317e09fd9fac2.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:45 +0000
Subject: [PATCH v3 01/10] git-rebase.txt: correct antiquated claims about
 --rebase-merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When --rebase-merges was first introduced, it only worked with the
`recursive` strategy.  Some time later, it gained support for merges
using the `octopus` strategy.  The limitation of only supporting these
two strategies was documented in 25cff9f109 ("rebase -i --rebase-merges:
add a section to the man page", 2018-04-25) and lifted in e145d99347
("rebase -r: support merge strategies other than `recursive`",
2019-07-31).  However, when the limitation was lifted, the documentation
was not updated.  Update it now.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 55af6fd24e2..8a67227846a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -1219,12 +1219,16 @@ successful merge so that the user can edit the message.
 If a `merge` command fails for any reason other than merge conflicts (i.e.
 when the merge operation did not even start), it is rescheduled immediately.
 
-At this time, the `merge` command will *always* use the `recursive`
-merge strategy for regular merges, and `octopus` for octopus merges,
-with no way to choose a different one. To work around
-this, an `exec` command can be used to call `git merge` explicitly,
-using the fact that the labels are worktree-local refs (the ref
-`refs/rewritten/onto` would correspond to the label `onto`, for example).
+By default, the `merge` command will use the `recursive` merge
+strategy for regular merges, and `octopus` for octopus merges.  One
+can specify a default strategy for all merges using the `--strategy`
+argument when invoking rebase, or can override specific merges in the
+interactive list of commands by using an `exec` command to call `git
+merge` explicitly with a `--strategy` argument.  Note that when
+calling `git merge` explicitly like this, you can make use of the fact
+that the labels are worktree-local refs (the ref `refs/rewritten/onto`
+would correspond to the label `onto`, for example) in order to refer
+to the branches you want to merge.
 
 Note: the first command (`label onto`) labels the revision onto which
 the commits are rebased; The name `onto` is just a convention, as a nod
-- 
gitgitgadget


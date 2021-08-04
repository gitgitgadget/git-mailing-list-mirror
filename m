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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF3EC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8277060F10
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhHDF3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbhHDF3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF5BC0613D5
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k4so846087wrc.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u2OexVHCWIr4ZGDtSXlLtMCutTpWklNj+dqklHUXpRk=;
        b=coqO8ebmqLMEBVkNoAoqNNnm4j6gP3C2VeL+V+yQvaa78sOJ01PE8KA+dx2MlLcpxO
         GqQ7uKSpUsTPbbE+tocJ4O8btZpMAo/0z3iS2X+sokYOkneSZvQLpxJzJM6bhI2AJcO1
         WN1uchxtqy2nABEQt3izPgh1vR3Yb2R+yULMfQ8b3xyriBgqsJPt5Ue00xFI7QI1kWvj
         1ND+WZ1cLvCehS7mAfTvzWkS0RgFh52fOdowhei/svTwR06PwbUc8A+kmSXS4HZNs69j
         Mr+YSlDA3Q7Z0+IYfHe8UkcgEokHotWvqEa8q328TLPEeslbMZ4Jy/AKWPN8ETlqHNxD
         PVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u2OexVHCWIr4ZGDtSXlLtMCutTpWklNj+dqklHUXpRk=;
        b=otGDjVV1NNgEN+VS82BHbbGJEj+Hr8M/ibcIZXZb7499mHp5tkBBQc+pqso8SyD0rP
         43iXJKIl3F4Awnth4qmC6z2fH70xRsFQp5bTXXPGTt8mHJUfy6LzqmQrXLa+/F45e+Ml
         eXejxDVmea5Ssr/oCNUfQND0VLUL+6lQ4YdEbogeVKB57PbjdyeUDFX7YFuCeUt2SnZ6
         XEbJ2o48Gp/pHKTOTg43eOBnLOwGJZsFL6Am2b9fWE+RACjN3d670SolyYvx/U6dgk6i
         HM11uOyi6hAxaj4n3ha/STvUcJleRvMZSYnmswAUA1lqbrnyZ+Xio53bQSDdtkooVh5m
         Ml6Q==
X-Gm-Message-State: AOAM53308Be4cpzTo9wXxtZXsRqp8Negd4j2eMdbfUIJQJ7+7+sH5H6p
        iMSIFbccnRaQwXUkaCsUR/KjwKnsAcc=
X-Google-Smtp-Source: ABdhPJxi+aQzqqHRfky/+kaDkePutvekedOoux2PS0Pq9SavhWuisijkSAXU/6v5aGTSkquEZ1u/dA==
X-Received: by 2002:adf:fa11:: with SMTP id m17mr26598210wrr.150.1628054939646;
        Tue, 03 Aug 2021 22:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm1220508wrc.90.2021.08.03.22.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:28:59 -0700 (PDT)
Message-Id: <2a38320c2be2fb859bead9f54e396b4e97020f32.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:48 +0000
Subject: [PATCH v2 03/10] Documentation: edit awkward references to `git
 merge-recursive`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A few places in the documentation referred to the "`recursive` strategy"
using the phrase "`git merge-recursive`", suggesting that it was forking
subprocesses to call a toplevel builtin.  Perhaps that was relevant to
when rebase was a shell script, but it seems like a rather indirect way
to refer to the `recursive` strategy.  Simplify the references.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt       | 5 ++---
 Documentation/merge-options.txt    | 4 ++--
 Documentation/merge-strategies.txt | 9 +++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8a67227846a..c3edcb07e3e 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -354,9 +354,8 @@ See also INCOMPATIBLE OPTIONS below.
 
 -s <strategy>::
 --strategy=<strategy>::
-	Use the given merge strategy.
-	If there is no `-s` option 'git merge-recursive' is used
-	instead.  This implies --merge.
+	Use the given merge strategy, instead of the default
+	`recursive`.  This implies `--merge`.
 +
 Because 'git rebase' replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..f819bd8dd68 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,8 @@ With --squash, --commit is not allowed, and will fail.
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git merge-recursive' when merging a single
-	head, 'git merge-octopus' otherwise).
+	is used instead (`recursive` when merging a single head,
+	`octopus` otherwise).
 
 -X <option>::
 --strategy-option=<option>::
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2912de706bf..5d707e952aa 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -51,10 +51,11 @@ patience;;
 	See also linkgit:git-diff[1] `--patience`.
 
 diff-algorithm=[patience|minimal|histogram|myers];;
-	Tells 'merge-recursive' to use a different diff algorithm, which
-	can help avoid mismerges that occur due to unimportant matching
-	lines (such as braces from distinct functions).  See also
-	linkgit:git-diff[1] `--diff-algorithm`.
+	Use a different diff algorithm while merging, which can help
+	avoid mismerges that occur due to unimportant matching lines
+	(such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.  Defaults to the
+	`diff.algorithm` config setting.
 
 ignore-space-change;;
 ignore-all-space;;
-- 
gitgitgadget


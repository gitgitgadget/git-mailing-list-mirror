Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B69C433EB
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBFB20825
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js03D6vF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgG1PoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgG1PoT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:44:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE11C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:44:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so18756670wrs.11
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cWTuzdwoAX2F13MDPqxZFBPVu33tkJ0HCqz67r+1vBA=;
        b=js03D6vFQ5XG3sV3X0Zad+pNUVXDukWdnTl8aaZYp830OXM0y5gID+9Xr/IPE6B2YO
         e9H7RnLfxJnrytKknBIeoD2QOEAsjvXRIJchRoXsn8iiB0N2FwNuhg37YFLU4z3AhVZG
         Qfbd1psQnzGFJkvq6qqW2M0Cgru6dtEzaUOwg+toJmKcZ3e76AHL7i4wbUCVqZKYg/2y
         hJKzVa6lNz2PSipgHY8ATvC4S9b9Xoyi8jx0B+DrBW4YKAIMtipjQVTk3KH9vFr7QMqf
         6kou1OoE+mwVPVBL2Pd2R8sXd+mkgsBvv2tyq0q1xtPptiZAie8smXhlHUeThvZULYX9
         D4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cWTuzdwoAX2F13MDPqxZFBPVu33tkJ0HCqz67r+1vBA=;
        b=IzAIqYGTRuskTwGBpWJKLLiGhoLBCMeHP+Qql7xNEqqKzkNXak6+6JGHqH0EtvDv6H
         ghgbR/J1fr6KATSQNNNppCBdamqMqIz8PEsiNClZO3UnVmnd0rQmTH2NBD39lQaslfQf
         j5im7HOgCnyPT/QP9GhvynE6ygvJMGs6s/V/J1Pd843Ar8COhD/c3qNgjaTP21bti862
         +ygrVNerjhXoBtSQXpl7dATkWgmoah9LbI539NwFqpiegKogiJDmjI5ZaRE+ixgk9TLB
         3TcNIYkMHCuPrsAGsUABtyBm+IqU25YcD38EIkmUPRRPoi908wc/1dqnVSDS7ll9Ij1T
         h4Yw==
X-Gm-Message-State: AOAM533uE3YswDxJw+MSDhy4XsDNGduqGCV9LrD7BfSt12B335kRPLPT
        7y0bvIdTPk3gnWPeCYSE0GXimKzX
X-Google-Smtp-Source: ABdhPJwEoiFxIsAYCNi58j45RKT2KquTdOjJ5lBN7gfSSUWg9S7LhTj0t1tXaz3ungVzVxUplWY49w==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr27061607wru.178.1595951057560;
        Tue, 28 Jul 2020 08:44:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h23sm4753409wmb.3.2020.07.28.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:44:16 -0700 (PDT)
Message-Id: <pull.686.git.1595951056.gitgitgadget@gmail.com>
From:   "Aaron Lipman via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 15:44:13 +0000
Subject: [PATCH 0/3] Introduce --first-parent flag for git bisect
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've always wished git bisect had a first-parent flag, e.g. "git bisect
start --first-parent"

This option would be particularly useful in avoiding false positives when
bisecting, if a merged branch contained broken or non-buildable commits, but
the merge itself was OK.

There have been a couple attempts/iterations towards this functionality in
the past two years or so, and I'd like to get this across the finish line.

The previous iterations have focussed on the preliminary step of editing
functions in bisect.c to accept a first_parent_only parameter, enabling the
--bisect and --first-parent flags to be used in conjunction with git
rev-list. In addition to updating git rev-list, I intend to enable the
--first-parent flag on git bisect as well.

I've taken some of the feedback from previous iterations into account,
specifically tidying up the code that assigns weights to commits in
do_find_bisection(), utilizing existing commit graphs when running tests,
and clarifying the test for "git rev-list --bisect-all --first-parent"

Previous two iterations (most recent first):
https://lore.kernel.org/git/20191105052141.15913-1-workingjubilee@gmail.com/
https://lore.kernel.org/git/20180828123234.44582-1-tiagonbotelho@hotmail.com/

Related discussion about combining multiple boolean params passed to
find_bisection() into a single unsigned integer:
https://lore.kernel.org/git/20180415085841.1269-1-haraldnordgren@gmail.com/

Aaron Lipman (3):
  rev-list: allow bisect and first-parent flags
  bisect: introduce first-parent flag
  bisect: combine args passed to find_bisection()

 Documentation/git-bisect.txt       | 13 +++++-
 Documentation/rev-list-options.txt |  7 ++--
 bisect.c                           | 66 +++++++++++++++++++++---------
 bisect.h                           |  7 +++-
 builtin/bisect--helper.c           | 16 ++++++--
 builtin/rev-list.c                 |  9 +++-
 revision.c                         |  3 --
 t/t6000-rev-list-misc.sh           |  4 +-
 t/t6002-rev-list-bisect.sh         | 45 ++++++++++++++++++++
 t/t6030-bisect-porcelain.sh        | 17 ++++++++
 10 files changed, 151 insertions(+), 36 deletions(-)


base-commit: 00a7a21b97a47889cf66de32f8defed023c14c2c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-686%2Falipman88%2Fbisect_first_parent_final_draft-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-686/alipman88/bisect_first_parent_final_draft-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/686
-- 
gitgitgadget

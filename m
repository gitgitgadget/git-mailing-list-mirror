Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0F7C2D0A8
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E712080A
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 00:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8e7kdhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIGADi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgIGADc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 20:03:32 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E01C061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 17:03:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r25so1394200ioj.0
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeWVOiJ87uCRO69f4bfaQjLBAfla01P00ABjwpPLld0=;
        b=J8e7kdhFRZ41ajbdUmb8WckV+BfawQbf4Db5gl3bqeUFgFRXhplWVfojUz1CAdDDWi
         7G14nrLpbo8vIwhOak6ZPftXlVvSvB1X0C7pwIDmnKv8e7KlytF5EVqjslmRtd8B+36H
         L5p5RpRGbuKj80Y26aonOdK1KedQ4+8/kHsO2F8QyH6arErOdnzYdoUIQPj2KCxQkz+R
         XDtBRRuQm57CWTcBn35F+80JFoVoZ0HRyzqx0Zzy8clA2eH3Osaozb1NbKOZXrk4uDIt
         n3veJg/CKUppVTfU8S2C1o7atm9bz+kThKmG+R2Atr7YA2jPYnVIX70EfKkjAldMDh6v
         CoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xeWVOiJ87uCRO69f4bfaQjLBAfla01P00ABjwpPLld0=;
        b=OUhpvQdQ/kQRlXFCYnJ7CAIuF19eb+Kwc5Sl0h8ZlHFP66dwx/IIL0ZAyNDrGDqk2q
         nT+s9jBCJsKMjMD9O4vb1LL+cfJNwhklLgIyFS4U83BfYQWcywGfYZTFHbgqhq0b+3b3
         0hwoHPQSj/RVHu4aPXopdsWyzHCEjnbKzfwj2/0sQd1Kn5JpFlTkT+NJeV6HXs4xSbQk
         yfemSTi5nuvrvMzfk6h6wNROAhyOsY65qCiv0QhiJDgc98t6O5BwFydgVlFLCqfZmoSi
         /8EPrNogbb9Meau50XsAE4NAUsB97jsEl0QXnEmeRWNsulnXzWdTrvUKZadJw6w9cejb
         qYgg==
X-Gm-Message-State: AOAM532F/jW66aqoS/+BnOQX+BMWbnb/z6qG9afZL8WN5S1xoW/jLUYk
        fN7xB+jdvYCtzggKLaEcMezBjzlhiQQ=
X-Google-Smtp-Source: ABdhPJzUm0Ykl4wkBYqLFFnzYpChW6uVkvg3Yd2xdGVL19ySjklmNTi+qKapJyTPG6VkjoYN/BMAgw==
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr14906220jad.5.1599437005529;
        Sun, 06 Sep 2020 17:03:25 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e22sm6381664ioc.43.2020.09.06.17.03.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Sep 2020 17:03:25 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] git-worktree.txt: discuss branch-based vs. throwaway worktrees
Date:   Sun,  6 Sep 2020 20:02:22 -0400
Message-Id: <20200907000222.4717-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200907000222.4717-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
 <20200907000222.4717-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, `git worktree add` creates a new worktree associated with a
particular branch (which may have been created automatically if not
specified explicitly on the command-line). It is also convenient to
create throwaway worktrees not associated with any branch, which can be
handy when making experimental changes or doing testing. However, the
latter use-case may not be obvious to newcomers since the high-level
description of worktrees talks only about checking out "more than one
branch at a time". Therefore, enhance the description to to discuss both
use-cases.

A secondary goal of highlighting the distinction between branch-based
and throwaway worktrees is to help newcomers understand that the
simplest form `git worktree add <path>` automatically creates a new
branch. Stating this early in the description, may help newcomers avoid
creating branches without realizing they are doing so, and later
wondering why `git branch --list` shows branches the user did not
intentionally create.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index d252b6873b..1449491c1b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -31,6 +31,18 @@ A repository has one main working tree (if it's not a
 bare repository) and zero or more linked working trees. When you are done
 with a linked working tree, remove it with `git worktree remove`.
 
+In its simplest form, `git worktree add <path>` automatically creates a
+new branch whose name is the final component of `<path>`, which is
+convenient if you plan to work on a new topic. For instance, `git
+worktree add ../hotfix` creates new branch `hotfix` and checks it out at
+path `../hotfix`. To instead work on an existing branch in a new working
+tree, use `git worktree add <path> <branch>`. On the other hand, if you
+just plan to make some experimental changes or do testing without
+disturbing existing development, it is often convenient to create a
+'throwaway' working tree not associated with any branch. For instance,
+`git worktree add -d <path>` creates a new working tree with a detached
+`HEAD` at the same commit as the current branch.
+
 If a working tree is deleted without using `git worktree remove`, then
 its associated administrative files, which reside in the repository
 (see "DETAILS" below), will eventually be removed automatically (see
-- 
2.28.0.618.gf4bc123cb7


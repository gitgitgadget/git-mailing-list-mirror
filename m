Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E9C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04ACF20722
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 07:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IveFyqDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgIDHIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbgIDHIq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 03:08:46 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC2C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 00:08:45 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h4so6138143ioe.5
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9i3kuZlAqjrdQo1iLQhsd8GMLeoUz/SnVkf+bbekH9M=;
        b=IveFyqDP8fi9MUyOB9keKYGRohF8c0sLf2JACQtLGe89PAExPhNqWKJ5u907OGjKhv
         NuSEZx6zUl4p7bjGziIStiAl8fbMKR7kUyHjOrf2A6gEsIfa3JUzng4X6MNKizMNlcMs
         lM/Nl0bcyC5fvVfPO6in0nbEbdqqB2V8laC3UBw29qH+m7iKHPA9s+S0Oz+DhAJgVar2
         uHDwMFNvCOLbJ2vmeqdosYf285vnmgHycEH7cfkia9gM/E1dlP/a7zsAP0AUO1L+R22L
         EjlQ20mTbmr6EnjuVLyQxQ1MR7cwYmXWO4HrQYLAaK0pWC88+qab7LMPb1tnFlJeEOfc
         sr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9i3kuZlAqjrdQo1iLQhsd8GMLeoUz/SnVkf+bbekH9M=;
        b=ZiQlXTXk2z+EBaTGG3AyUUgYMAKn9km/Fl7nLMw23Yu0GmBL7/eQQi2ehZ+BVIwvx/
         zCPDLd9oo3FDnr0B5H/cr76ciC/ogywM+vWcTQyagmOyzqzMKSyel8UQglhs+UEUNt2R
         MlcR9GyzuHm/eb7Zk7u/jJsZneAzlPxvstqj2bWYenA5XMuhsScQYkkHaBgjt2Bit1xt
         roBHSp1CmJ+yz5hamHmJSX+Q2SVsy1e+smWU/XGOyX0N/xwsVMGDkujyGgCb2cPd/Tz/
         PiK97jwr+ch/BmRAeiTLtNUbwJnw54oJTpN9f3qQVIBRVf9bAdCLsDoPzNFDLSIsChxW
         5JmQ==
X-Gm-Message-State: AOAM530O8M7bz33Se7CgTBAJn0o8RxOLvko8XCOrwgj1wQQoJAPWISTD
        2QGOvUuxC/WpkuzEMbRWFmuscRqH+X0=
X-Google-Smtp-Source: ABdhPJya1F7gn3RW5VerrdTmfFOoRBPUgshRnpzC5PG4KDIQ5m+4geK116UKXihIGWR9uT1BV76bEw==
X-Received: by 2002:a02:3502:: with SMTP id k2mr6924634jaa.129.1599203323651;
        Fri, 04 Sep 2020 00:08:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id n62sm2881950ild.36.2020.09.04.00.08.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 00:08:43 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] git-worktree.txt: discuss branch-based vs. throwaway worktrees
Date:   Fri,  4 Sep 2020 03:07:03 -0400
Message-Id: <20200904070703.47898-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200904070703.47898-1-sunshine@sunshineco.com>
References: <20200904070703.47898-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, "git worktree add" creates a new worktree associated with a
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
creating unwanted new branches without being aware that they are doing
so, and later wondering why `git branch --list` shows branches the user
did not intentionally create.

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


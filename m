Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F80C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B00206F6
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMcV80oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHCFhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgHCFhR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 01:37:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076CCC06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 22:37:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id j8so24991416ioe.9
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 22:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HpVA0NXsvLxx+AwSRhuX2F7NRxJr0UnllPJtSwKty8=;
        b=qMcV80oA0Yz4Y+UN8+bMG7jvSnP+BX/9IigjWcXLyZc7CxCvEQMXD1pOjzjA7Ds4MO
         F2qblCbQGLBI0A1Kk9sA7xL8yUe5TtGbspP8PtIlBfOdX6nq4AqLrri7NeQTzwPviZsE
         g2F1NQfjaAi2J+5amUyBG9rp5W/St5cgWnaBvqZHA03pl7Q39cZLhdegrHgVS9jnHBfe
         nha2BUaivhqCG0yLSHNzGcOkg4Pjfkx3SA03QRGKq60y73DT7ZGWHA97pCjgN1v5cMlR
         o6pfYyCEQMyUofYa6zAiEK1oS7NrDXiCOo/UUV4YLvG4v3xM2BLhgaPr7ogrLcTLd9ut
         ozUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7HpVA0NXsvLxx+AwSRhuX2F7NRxJr0UnllPJtSwKty8=;
        b=dpU7mKT09NG6G6iAgfEREfwXRLKQcvESqy4F3YP2rJrNlbe/6eW056Qeri0S+jTe0x
         igyPTmOlsZMeXIsY+2eJPxXK5oKxfefvEymqAjQ9ztxCz+wHkkS6Dfb2Pnh1oP5Ld5Ss
         LL+aBNMT7dSukT+t4REGDtJ8L55QokJ3uXOdUL5eRM+b9iP2lOgyQxgveUyXN3TxoJGk
         Mtj4wAjQaqNYuBgVT1n3VVdzNjb3Sh7XolLd9F3QzvOhxflavaIByYF9StvCrH2Kc0PX
         4Zlv35FOqEeGenzMLynZQ6G7BlbShfQMfDRVQ0qZ1vRvyHsMi3QWCXQxJW7bS8PK302a
         yfJQ==
X-Gm-Message-State: AOAM532aqaAVInKzau4Qbysvzmz4HpTTzkXKQompCLX/94kI8rLBQb8/
        l/R8MTOWzSuEAQYkuBhfImh8sGVXIxU=
X-Google-Smtp-Source: ABdhPJzDy1/iDAgUtQboQtReRlwSRH++Ye1y8Esu34mv9ktlPftVAa8HUUMRcUosowcio3SUPJ//oQ==
X-Received: by 2002:a05:6602:2417:: with SMTP id s23mr14879060ioa.94.1596433036027;
        Sun, 02 Aug 2020 22:37:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r6sm8183114iod.7.2020.08.02.22.37.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:37:15 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/4] git-worktree.txt: consistently use term "working tree"
Date:   Mon,  3 Aug 2020 01:36:10 -0400
Message-Id: <20200803053612.50095-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200803053612.50095-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As originally composed, git-worktree.txt employed a mix of "worktree"
and "working tree" which was inconsistent and potentially confusing to
readers. bc483285b7 (Documentation/git-worktree: consistently use term
"linked working tree", 2015-07-20) undertook the task of employing the
term "working tree" consistently throughout the document and avoiding
"worktree" altogether for descriptive text. Since that time, some
instances of "worktree" have crept back in. Continue the work of
bc483285b7 by transforming these to "working tree", as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 810fc8b5e1..cd762876f0 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -70,20 +70,20 @@ branches from there if `<branch>` is ambiguous but exists on the
 linkgit:git-config[1].
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, the new worktree is associated with a branch
+then, as a convenience, the new working tree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
 doesn't exist, a new branch based on HEAD is automatically created as
 if `-b <branch>` was given.  If `<branch>` does exist, it will be
-checked out in the new worktree, if it's not checked out anywhere
-else, otherwise the command will refuse to create the worktree (unless
+checked out in the new working tree, if it's not checked out anywhere
+else, otherwise the command will refuse to create the working tree (unless
 `--force` is used).
 
 list::
 
-List details of each worktree.  The main worktree is listed first, followed by
-each of the linked worktrees.  The output details include if the worktree is
-bare, the revision currently checked out, and the branch currently checked out
-(or "detached HEAD" if none).
+List details of each working tree.  The main working tree is listed first,
+followed by each of the linked working trees.  The output details include
+if the working tree is bare, the revision currently checked out, and the
+branch currently checked out (or "detached HEAD" if none).
 
 lock::
 
@@ -202,7 +202,7 @@ This can also be set up as the default behaviour by using the
 	absolute.
 +
 If the last path components in the working tree's path is unique among
-working trees, it can be used to identify worktrees. For example if
+working trees, it can be used to identify working trees. For example if
 you only have two working trees, at `/abc/def/ghi` and `/abc/def/ggg`,
 then `ghi` or `def/ghi` is enough to point to the former working tree.
 
@@ -221,7 +221,7 @@ shared.
 
 Refs that are per working tree can still be accessed from another
 working tree via two special paths, `main-worktree` and `worktrees`. The
-former gives access to per-worktree refs of the main working tree,
+former gives access to per-working tree refs of the main working tree,
 while the latter to all linked working trees.
 
 For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
@@ -335,8 +335,8 @@ Porcelain Format
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like `bare`
 and `detached`) are listed as a label only, and are only present if and only
-if the value is true.  The first attribute of a worktree is always `worktree`,
-an empty line indicates the end of the record.  For example:
+if the value is true.  The first attribute of a working tree is always
+`worktree`, an empty line indicates the end of the record.  For example:
 
 ------------
 $ git worktree list --porcelain
-- 
2.28.0.236.gb10cc79966


Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666EC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE660206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PscI2qt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfLPPsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:18 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:39980 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfLPPsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:16 -0500
Received: by mail-wm1-f46.google.com with SMTP id t14so7223805wmi.5
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=PscI2qt11AzkVKDEELtHDEUFJJiKmx403cVJh9enZRLDQ3Izf4MvXgm6ELTohrC7Xc
         PMqjVF601pSmyH+R7K2z+lRUaLJ2QaJSlHl8E5pK9l2sp65FzjOK+G8OJAm0IwFhtVat
         05m/StkWnCblkqTHGEEkjnJEX3FBqk9JnBuz6+S8jgrTMs+cMehV4eCwU/r3wi1i4ShN
         naW+74zsPoJWEl8sijbVMkNwvEiG2qhmJyvP/8Y1NMDMGc108IlRjEW7jNYggedDTaIw
         WfeewxzOgPE2XvoBpTKvpJSLavZR6UHNJ2GOhbBpVzWrIs+FsFzP2TNh2B/KIdy6noWF
         e4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=cgzAZGcPubAfAThot/etqhOamleYwiuvmnEOcXUfYKCUMyErbp93bsuYcMAk2DyXDc
         EEH+RO64lTukwdHaG4Qm4z6pnhhOuWZ7177Gs1248huKDIMb44T28uWMfO9UEjpKQw4u
         HLnRM6e0yOToomNYaWW8LF4qyXqW8pEISBr+g805VtK2w22C79PXqujZcPLsDHzQtElj
         dxBTvktn0ibvaYtnTZfkdnYkU7GRthPXWcSm0fUqguKIn0WLSUDstOT2+XcCjQYle6Oy
         fxlHp8yJbpUUSsG1e6Tr6WJ4bDp2+eO9Kw+hINgZiiIu5KEL45WxFuFywberIBA+qrDb
         WsYw==
X-Gm-Message-State: APjAAAWQvhZS1MWJvG64xf6/LArorREceCMOzg2uJvGHmRYtn0wz1hQE
        TgCSRdBtQumhK9Jv5XgWuGxspCOJ
X-Google-Smtp-Source: APXvYqxI4/gE+l07RqS1Od2I3Qo7GIs1UJ91uAJRsnczUeFbgUDcwEZbYeU/52yWAmKx4Yz9ZY3jJA==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr30311074wmb.174.1576511294215;
        Mon, 16 Dec 2019 07:48:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm21342322wmc.8.2019.12.16.07.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:13 -0800 (PST)
Message-Id: <db6e40d0042d01cc66b2d0354b52af211e6b5df9.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:57 +0000
Subject: [PATCH v2 09/18] doc: checkout: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`git add` shows an example of good writing, follow it.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d47046e050..93124f3ad9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,13 +12,13 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
-or the specified tree.  If no paths are given, 'git checkout' will
+or the specified tree.  If no pathspec was given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
@@ -78,13 +78,13 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 +
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...::
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
 
-	Overwrite paths in the working tree by replacing with the
-	contents in the index or in the `<tree-ish>` (most often a
-	commit).  When a `<tree-ish>` is given, the paths that
-	match the `<pathspec>` are updated both in the index and in
-	the working tree.
+	Overwrite the contents of the files that match the pathspec.
+	When the `<tree-ish>` (most often a commit) is not given, 
+	overwrite working tree with the contents in the index.
+	When the `<tree-ish>` is given, overwrite both the index and
+	the working tree with the contents at the `<tree-ish>`.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -336,7 +336,13 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
 
+\--::
+	Do not interpret any more arguments as options.
 
+<pathspec>...::
+	Limits the paths affected by the operation.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 DETACHED HEAD
 -------------
-- 
gitgitgadget


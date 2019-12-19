Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523EEC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197F92465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZIvMTXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfLSSCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33845 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfLSSCI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so5785088edw.1
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=dZIvMTXBNvXTx7oMS2UvRbkhiGLitEiVrCT0FtjhHME0OfIQSdycY89ry4QbdNFORe
         hblrmgPVLsxgjzooyXGo6V/Rje6bEa4oRCTgmgI0mRJe5HmousvNjHd/X73zffHi6ZAl
         dZs1o1gmB1bVJJSQFuC0it3ZEIhrjQnKa0mpzn5eflGYxDAdHfI6Norr3frSeZ16Os4z
         5MsC4Mf19aMdKqEPY5GGJwYKTyYJOhSZds6XtGcZCUq/GwlX9kClzIf0Vzd56FdvR6li
         E7QuLxW/rxALMy6vzHwwxRzED88chbT54UyKGTe34A2QVIu3IbCiEdujllBHp8AYxWoy
         rssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=o9j+RfYgsGu3WeEnepVfbBGCt2N/yWoZPEVBbsmUTDI2KthSqWK7/QBCY0xsGnn7Io
         eZqzJ72FVmFZw7I/rRqVFQjUkQmH6+3QN4KxtB9bE1lHFWJoiHRVjVF9HkenOMMLqAEb
         h9VT91mO+/Rw8foNS2JyfgmgjB1AufOyjGyUB+xuyz6i9N4yk2u2q7dftDMaVeKMJOW5
         kSKu1TYcTx3V6qApeJVh2vu07zBc+SrVAJVuFNP/kw/NLzYkUEl5JF/XClqTbbOfiU6l
         aaSA8pcvtWmtesowpz1xnw1S83Jd5C7ujRAqoEWUtczRvbdujnOKm/vDk6zWPJDyS81S
         +2Eg==
X-Gm-Message-State: APjAAAXfY2B/AZ6M/zNLQu6Phk5wX2y259QD5poWxzS8xTmklVtUBlbu
        cvGNhVfFFyTNa/0fyVQLoFvcenJv
X-Google-Smtp-Source: APXvYqxaT8+wUodwVh7eG2ULdGq3FPjZSqWDU0IKdyx6TboW6vYdpsVR4Cz2WaHnm///OxD7lDampg==
X-Received: by 2002:a05:6402:689:: with SMTP id f9mr10620069edy.231.1576778526961;
        Thu, 19 Dec 2019 10:02:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dk14sm666957ejb.12.2019.12.19.10.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:06 -0800 (PST)
Message-Id: <1d981b199f2564093d6d04e1eb8be9fa30c1d1da.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:46 +0000
Subject: [PATCH v3 09/18] doc: checkout: synchronize <pathspec> description
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


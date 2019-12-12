Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C1C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E7B21655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7k0eM5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfLLOgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45696 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbfLLOgd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so2942678wrj.12
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=E7k0eM5z2K1/Yl7w+LV8Yvk5Bu7stVF4t8KQUe0pZgIqozUt3/o+4pjWF9oEwH7INl
         QebBYlW2bs+FD5Bb+mkcNS6mJMfaCPLcWFsfm77vs2yoW3u3/lcTNQRW9yQ/Br0oRROE
         a45IDDqCzphnVbk5Q/SxXddPnAN9XndSP2FeMr9YU691oscY4nG3anBpXnhz+rWrdf3c
         Zqx03Z2D/FUXN53StoZoUs0UYdZnloP0UREw0ysyVr+oJhnDyh9R8kx68W7EOGH4aaMV
         ka9XOlY2dLI/CIM/U1twVF/hpxYaUMTVsL1XxlaoGXx2nlcT3POBQSTME6LNuAedkZ+1
         z4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=Ex0KH5uY+BEFN3bHk5FN56ckl3gQMWH88jItfn9wEFQByVi9gXJE2D2PLdCxsoF4cz
         ja8/w+zr0TTkyNaAhNC/Bh3kZdMMsrgVQkbYqPjpW+iYOE3mjeIYMBQVl0M8Ohem7kXG
         5Fsxu7/SOn9NQJwE1oHjuLNy7ESQ9PmxMZr7iXFQ3DSwJ7xxG/nV1ERS37igjDk2tbVV
         rWS1bC5rNA43CQdOnSdw2wzEtZWLxEy2bebOgJ+K4Bg2RoIo8U7IRU4Zmy1fwyIy2swC
         vkuSQgfpquBB0TttDGws1uW/xAM/p1IG8t8jFDBgcECcm5kXqFup41LOfLPkSiRJkFFL
         nNAA==
X-Gm-Message-State: APjAAAVYKehywGml60yuMvdCD0cejoxQegQ5FMJviWU3TayRNajC/0re
        R0V2Ou3PiV0wfbJ4p5k4ngaTLNCv
X-Google-Smtp-Source: APXvYqyImv8dSD2abtQ9s5b2FbGfZC1ozU5feNRIn8CmOoT3xdEpyGz0JJTLG3fMFItFzQ/sPLrOZA==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr6831625wru.220.1576161391451;
        Thu, 12 Dec 2019 06:36:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm6453087wml.11.2019.12.12.06.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:31 -0800 (PST)
Message-Id: <6288a7fa36d013a6cb4864544993412b6e39eac1.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:16 +0000
Subject: [PATCH 07/16] doc: checkout: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
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


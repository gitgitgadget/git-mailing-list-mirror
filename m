Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA42C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85627206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="su76R3ZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHDA4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHDA43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:56:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B84C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:56:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g19so28446375ioh.8
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VPcT+JMH6AJwI6gcbyoNqxtrVihgXkZmzME6U4NPUA=;
        b=su76R3ZPCFuRhdiZNyPPW4I1hlBNV7LS+FGGBTKlY/bSQH6NWIX1WLvngV+jH+w2uX
         x4q0nq6suL5wcYNulCSWeavrS69kndiSZJL3KlQAGV6UgUiHna3IGW3xJDQ5v92DviaF
         V+1EZyGHPgX1RH1LLQDh6HamYsaOqGlSrJy/r1L9oAzZ8O4MXV7xyyX3SXbfbIr9dVLh
         DYoujwbdRCzaxuZ4ggUm+f3/HCzSdrqjGCXnpyDjCbgNNsUTiixB9SeP8xqE2JvLbnqw
         X/+mPqh8zmfYvEocijlg0ykLSAsuZSYQtU1xSWBCU3L9v/fVDGQJXeSrn471DztrKyDK
         /HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5VPcT+JMH6AJwI6gcbyoNqxtrVihgXkZmzME6U4NPUA=;
        b=QjRCxvFAVF2APfePPP1HE4YNi/aVpazPgZvhlHExerpaLo/XUlGGgyl4c1/rlpNtLS
         CKFSsNWjBr1becvj+qOi5q+RUnEFFREQ04BQ2FnSFxVxM9JfB59tcJ4mkJ9bdOkE8UoH
         qKo/JnB+XLjKF646q9+SzMYykWvZOIvRWt/d5x97xZ2R8Z9IuPwyuuj7BkcCYG1krit2
         7n/S+b26/I8zyIWwaTqOkBO4JWBK3Qn+Xild9rB0+/++KZQbPFfAUG7cAzcasemAwUr4
         VU6k/oUcMP66b0UIQkZtBpY890vaR2FaGfDd61DU8+05qW1wPsy3HDVNgdmikf6K140A
         f40A==
X-Gm-Message-State: AOAM533iBWDOdkkQiT+9YXQkRF2hCSspFnD2cVczlvZWO7tqbovWsHBb
        bbPo8CFC7tXXq/vTTakqfVWfa50tzGA=
X-Google-Smtp-Source: ABdhPJyReXCcY7aHFD9r3TBSp3HdD9A+zN3Q5cbqxYHeV5wPvPveu3vHIo9cI5ilQjOCB12cw/+F/Q==
X-Received: by 2002:a02:76d0:: with SMTP id z199mr2822760jab.39.1596502587782;
        Mon, 03 Aug 2020 17:56:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e84sm11878453ill.60.2020.08.03.17.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 17:56:27 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] git-worktree.txt: consistently use term "working tree"
Date:   Mon,  3 Aug 2020 20:55:32 -0400
Message-Id: <20200804005535.5126-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200804005535.5126-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com>
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
index f7c1bd34f8..926f4662ee 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -70,20 +70,20 @@ branches from there if `<branch>` is ambiguous but exists on the
 linkgit:git-config[1].
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, the new worktree is associated with a branch
+then, as a convenience, the new working tree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
 doesn't exist, a new branch based on `HEAD` is automatically created as
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


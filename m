Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39655C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03362206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci1fYFqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgFKPPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgFKPPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:15:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD0AC08C5C2
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so7172510wmn.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6m7/WZRUaNHCgJuWCwjTknz3XBZCYper52ToaaqXcZ4=;
        b=Ci1fYFqHJ3hsaDgnwKNwJFRD9vE8VlWnCTwbfyDJLlNK37PTzsOUt9Skq8/blnYoma
         31yLq5Pq9i2uNcn9FGSpSlWiqRzedc8PdYQq/68/qu2NbqVdCucYNOFW+VfgD1E8nUm2
         4LTlFLyUwn5imKsIw/aJxJfOE/+UvMF8mB4moUbWOGTkTJxtWrlwaDj3zfgXR5JlvxZK
         k2MhvCdISQe7MG2ekzV94Z2umFG2+dLQmFQHkbNxVpVKVUMn+EOdd2VNmXoWgwu5dVCH
         fzlSTqFZHLBq6Gxwz4LP3M2QW3qiWibbchUAabDkus46Y0xhCRDA7LCHaXOlCW1pd4F3
         l7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6m7/WZRUaNHCgJuWCwjTknz3XBZCYper52ToaaqXcZ4=;
        b=KH/2L9T2l2Cj8dpColg+aCC3B4TbsCPnwxlKeF8xYts53n+JHUbHpQHkL9TG6GSFKa
         uzJlHsT7gteVhRb9tBGRFq7F2BKLXiPsVtbJCrks0VdlOWWnkZy3oUCpGgNtNEOc54Y4
         g1JA3/ucUVFtHCAOg8XpzXmnyxK0bDkFvZODTt31ydxtyuWmxIcZHZCQZ+V20DwHcvNp
         oNvntjY+nzCVFsaFpAK5E22kI0tHTZF+EFu59tUC9qmPpPXwD7ai5afsOEpRDtngai4v
         orwXD5Mq8JoCFczyV5MSVyiQS+GsM2m6OXcOOjyd/fnN2l5q7Bzw3hC89sP3R7WpvBOn
         H5ng==
X-Gm-Message-State: AOAM530V8HID7JfwSCbEyOqmzYzp3ZvA/kA21vU4wm40cAuQekkbi4bC
        6Eb3aXrsLdpfYUbAGQQXlCtTP+Wc
X-Google-Smtp-Source: ABdhPJz9K0p7LbHqiIpYGnnUTRBkzrDpW73bVSRSC/OjsV1cUsK9D8cXv283uPRqmWp7oVnwjnuo7w==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr8430845wmi.43.1591888515172;
        Thu, 11 Jun 2020 08:15:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm5041627wma.23.2020.06.11.08.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:15:14 -0700 (PDT)
Message-Id: <a7da92cd63582ec9405a529ee4ecbe245f18a4e1.1591888511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
References: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
        <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 15:15:10 +0000
Subject: [PATCH v3 3/3] Documentation: usage for diff combined commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Torek <chris.torek@gmail.com>

Document the usage for producing combined commits with "git diff".
This includes updating the synopsis section.

While here, add the three-dot notation to the synopsis.

Make "git diff -h" print the same usage summary as the manual
page synopsis, minus the "A..B" form, which is now discouraged.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 Documentation/git-diff.txt | 20 ++++++++++++++++----
 builtin/diff.c             |  8 +++++++-
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 37781cf1755..1018110ddc2 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -11,15 +11,17 @@ SYNOPSIS
 [verse]
 'git diff' [<options>] [<commit>] [--] [<path>...]
 'git diff' [<options>] --cached [<commit>] [--] [<path>...]
-'git diff' [<options>] <commit> <commit> [--] [<path>...]
+'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
+'git diff' [<options>] <commit>...<commit> [--] [<path>...]
 'git diff' [<options>] <blob> <blob>
 'git diff' [<options>] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
 Show changes between the working tree and the index or a tree, changes
-between the index and a tree, changes between two trees, changes between
-two blob objects, or changes between two files on disk.
+between the index and a tree, changes between two trees, changes resulting
+from a merge, changes between two blob objects, or changes between two
+files on disk.
 
 'git diff' [<options>] [--] [<path>...]::
 
@@ -67,6 +69,15 @@ two blob objects, or changes between two files on disk.
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
+'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]::
+
+	This form is to view the results of a merge commit.  The first
+	listed <commit> must be the merge itself; the remaining two or
+	more commits should be its parents.  A convenient way to produce
+	the desired set of revisions is to use the {caret}@ suffix.
+	For instance, if `master` names a merge commit, `git diff master
+	master^@` gives the same combined diff as `git show master`.
+
 'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
@@ -196,7 +207,8 @@ linkgit:git-difftool[1],
 linkgit:git-log[1],
 linkgit:gitdiffcore[7],
 linkgit:git-format-patch[1],
-linkgit:git-apply[1]
+linkgit:git-apply[1],
+linkgit:git-show[1]
 
 GIT
 ---
diff --git a/builtin/diff.c b/builtin/diff.c
index 3d33a9231ae..c8a999f8089 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -24,7 +24,13 @@
 #define DIFF_NO_INDEX_IMPLICIT 2
 
 static const char builtin_diff_usage[] =
-"git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
+"git diff [<options>] [<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] --cached [<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <commit> [<commit>...] <commit> [--] [<path>...]\n"
+"   or: git diff [<options>] <commit>...<commit>] [--] [<path>...]\n"
+"   or: git diff [<options>] <blob> <blob>]\n"
+"   or: git diff [<options>] --no-index [--] <path> <path>]\n"
+COMMON_DIFF_OPTIONS_HELP;
 
 static const char *blob_path(struct object_array_entry *entry)
 {
-- 
gitgitgadget

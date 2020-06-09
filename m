Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F51C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439BD2068D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fje43MeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgFITAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389106AbgFITAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:00:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C133C08C5C2
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:00:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so22536970wrv.4
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VBPa1738gJHdbHm0jfynd/hxZJcXSH3Vb4JZADGhX00=;
        b=fje43MeU/B9VlzqE6SfWQ4uoiCAUxcdWXGkVBu5//Tdrx2W0VVi/0aVSU9n2eby3hw
         /X7waTviTPt9gfFbIyr5dqSKIWGy4/suxj6PIlJ+XYdOf9Y6sTPO9AqDd+Xo7Gn6CRiv
         R+NKdBxziVbNoTJOuXsrJFrRn8hniu5yxMXYVjzxFQ+p2bOtcOchrxck5NdpfFaemvsY
         l7w1ZQR7uHWonuMUPT+Jvqm4g++3ygOU9xFd/+m+bE/VG3Ud2FwAmDt86I2U/LsIkkTC
         Jc8YpobV0K7FynVj6vPOQK4LT7g3qeEKWM7BEnEMLvTmRuvkdJI/5S+xa2vg7ZbqQFie
         DdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VBPa1738gJHdbHm0jfynd/hxZJcXSH3Vb4JZADGhX00=;
        b=p7M3WkEqdWv0u/fLj7pKLahFvmEGpnaVudJj46Hro99frKAv8EDAOLPyAfqXpdK1gV
         1He7QSiIAyz5r7dKQUGqZXUZLxI41v00hKjnHyl2oKrSAYHrY1jl6QMg88+oo4iTRXjR
         b59N3WrsD6WhUGx5j7ZdLehbe9AVDQT1cACitL3Ly+/a7i7wecaGhIJdmedrrlPNyQX4
         wlmC842SuE0xQbCjuCX4NWWn4pG8y4sHh4EXir9Xp5SV/PRwfoGarVxVqVH7eOc/EyD6
         kDLu4rPS/rAG8KeJlV+h7PtT39ytbsH+/w4tBSICk9EUxCXKMDuTVsAIIyXo/1B0EcvT
         YMiA==
X-Gm-Message-State: AOAM532Y5yNfS/HH2To6lYnqmOtwxJDD84LeJDTD4uu3Ysa1lRV0gHom
        XXaXzPKkwNvrmhY9GQC2cq5YUNEH
X-Google-Smtp-Source: ABdhPJzWaWRY823cfRQso3Y1n1VxCNnbtTIJZi5RSaHhNmZyvwoJxDx9gObI8uxj/46kWhefCDneXw==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr5703868wro.145.1591729228098;
        Tue, 09 Jun 2020 12:00:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm4542900wrf.61.2020.06.09.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:00:27 -0700 (PDT)
Message-Id: <b9b4c6f113dfb03268b391cc62abfd38bd7632e4.1591729224.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 19:00:23 +0000
Subject: [PATCH v2 3/3] Documentation: tweak git diff help slightly
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

Update the manual page synopsis to include the three-dot notation
and the combined-diff option

Make "git diff -h" print the same usage summary as the manual
page synopsis, minus the "A..B" form, which is now discouraged.

Document the usage for producing combined commits.

Signed-off-by: Chris Torek <chris.torek@gmail.com>
---
 Documentation/git-diff.txt | 21 +++++++++++++++++----
 builtin/diff.c             |  8 +++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 37781cf1755..0bce278652a 100644
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
 
@@ -67,6 +69,16 @@ two blob objects, or changes between two files on disk.
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
+'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]::
+
+	This form is to view the results of a merge commit.  The first
+	listed <commit> must be the merge itself; the remaining two or
+	more commits should be its parents.  A convenient way to produce
+	the desired set of revisions is to use the {caret}@ suffix, i.e.,
+	"git diff master master^@".  This is equivalent to running "git
+	show --format=" on the merge commit, e.g., "git show --format=
+	master".
+
 'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
@@ -196,7 +208,8 @@ linkgit:git-difftool[1],
 linkgit:git-log[1],
 linkgit:gitdiffcore[7],
 linkgit:git-format-patch[1],
-linkgit:git-apply[1]
+linkgit:git-apply[1],
+linkgit:git-show[1]
 
 GIT
 ---
diff --git a/builtin/diff.c b/builtin/diff.c
index 0b6e63dbd02..b333640082b 100644
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

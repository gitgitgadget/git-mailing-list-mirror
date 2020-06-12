Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E52DC433E1
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E916207ED
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+rRCFRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFLQUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgFLQUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 12:20:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DA3C08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:20:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so8687421wmd.5
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ExKC4h6kguz+49lAvuYDbdwfIITVNSXjbItCDp4iooo=;
        b=S+rRCFRiBxGy/a2cZKhAJUkv/f2d1sT2zkllDn/xyMDgs8CdFbAYYmZDFEmX+d2Ya8
         pxQpMU+nOU2Utf3cZJGtt4fyea/M2jzsxyGAmRmA/4WLH5SqF1kW+Ru1/iQltqoBLCNy
         +eJhpoJVsblM+5gu+wTWIajr5ac1oH1x6SLgmZmJs/amoySH4aPiYNB7xOh+OiJaCUly
         0LKnTyua2zfBqQeBgPCfCxMMzxLoIWm9bbmAI6SCq/bSyDXiIxQjMQrcAuQ+DrzF/jpT
         IPOscwT1QvgFGrOKF/N9kk/TZK73vxqHjaVegb6bOA7Ee2ba+cl4rA4Xm3IWmXuFR5dG
         5I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ExKC4h6kguz+49lAvuYDbdwfIITVNSXjbItCDp4iooo=;
        b=uC0rbsV+LvRbf5yTF3oSwknmOTJiuuGiQjsIKKdvFmOwNHST4k5teA3Ko7cCq3mgUT
         23aQK9zrbrx+fCviB86uucPhpADkd77heTIOskZ9yIgvac/g4AIR9zvf1hOud9Q3/CD7
         Htd5boQNLjJKJoZEz0/8JkZOr8HlAxrxS6t7I6fOK7uiFOz01jlRk+uV876juMYVYh67
         nkQsKsg92JPlpmIB9tbZqKsAErUpKjXpysfZ+rbBHs3CK1RmG5kEpbKCylEF2RdJKY2B
         W/ub0sv+7vMiOTGCIIYPXtwPSf0Km6v2hNjGAlQ3kAXKen/XWMjLSAl/Vkrla79ICxnA
         XXaQ==
X-Gm-Message-State: AOAM530D5Gm0N6I+qH9+rrV6KXBNSSAg0o+sJUAF3HkuGpshqBoKxkNZ
        DACHN9ISFhPFzDA8pJzsiMrq5miH
X-Google-Smtp-Source: ABdhPJzSBMaJZCEpVDiSw9kr3PosOCPt3yP6SqvwohVttALYlGfOt74qAA8KMYpK2IyapYEFkRLe8A==
X-Received: by 2002:a1c:1f48:: with SMTP id f69mr14398049wmf.67.1591978805640;
        Fri, 12 Jun 2020 09:20:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g187sm10138227wma.17.2020.06.12.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:20:05 -0700 (PDT)
Message-Id: <d7bc9aca44bdff18ec2cee4f45d34c0965dc2002.1591978801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.v4.git.git.1591978801.gitgitgadget@gmail.com>
References: <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com>
        <pull.804.v4.git.git.1591978801.gitgitgadget@gmail.com>
From:   "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 16:20:00 +0000
Subject: [PATCH v4 3/3] Documentation: usage for diff combined commits
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
index 0f48b0d3e71..b3d17340ee3 100644
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

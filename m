Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02094C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEB9206DA
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 05:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJrrySF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHCFhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgHCFhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 01:37:16 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75970C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 22:37:16 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f68so8234224ilh.12
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 22:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbwroxcY0u3Nfc0CbvZcNVPwfgDUg3C5gwatLhkS5z0=;
        b=GJrrySF961gd6Ezt6+zAf1XI0TBLyaBM9D6cy1lJZ1N2xuw96gwz5kQJm1pHhkx9GK
         RT5UyLkI3e1PyA4Hr5ubGJn+/RRtjSovmmnm8A9WTdOzc8dL0W0QyxJXxZX6bbMN6I1C
         RuiaKxV7bEC6G2zAVZiJxQqMkP6RLd4IMss/7VHXJP3/Xhd7Zixr/j9oxI0ff/dWKXL3
         9sAe3vsaQeyv+2g8IS+nsV3qZ+s2tmj5oC9Z399NFr1sHAW46nzHkaqp0fQQqy+P7vx2
         /qKlwVFKd/v7YcLwWzlJmKp/x8OrbnOqNzGGqsFPUfS1DD99iwZfMEgptXUR7CBAG7Mp
         fRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hbwroxcY0u3Nfc0CbvZcNVPwfgDUg3C5gwatLhkS5z0=;
        b=Fi4pwrVKxo1FMtURjFhwh+qC0EpBgg7kJOQwXS/lwywra0qMCSfEFZjYUolUIARdDv
         m0n5IzaDH22GBrmBpR5vf3DJOcEXmuyM7sMqOixiAR0dSHVOdXvxnGQA3B6AKeX9jAun
         5XKDuzHe6gyh6jqRmKrRZwsz11V4a0WloBUnABXHX809qL7g/KBfO4fJ45OXCUlGTKcm
         myTnpwq8eDPqksSO1zDPQQBzd5yzZ0xNiXMXU3L30+1qTocZdJ8/7mP4DsUAdTXfQra5
         qMNwmlUarH1u4ODXek42RL9wWwJsbPUnJxNtSbZriC3Uh6VZ14+97Sp0RJ8dTaNHgTGm
         GpWg==
X-Gm-Message-State: AOAM532SUgNlTOPziMNMpyXs2ve55xDsXA39Fs6e6blIxfDXvSlR53eX
        h/9ioq0WuD7j1diELpqGqxAKWnd9DCs=
X-Google-Smtp-Source: ABdhPJxy2ydasGFJgMNl1Sh3KQa0EvTGjeg2JKuNIsqsUBsbdH3rh8h8nHCT6aRje1OJvMIJQO+u5g==
X-Received: by 2002:a05:6e02:f04:: with SMTP id x4mr15421877ilj.193.1596433035093;
        Sun, 02 Aug 2020 22:37:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r6sm8183114iod.7.2020.08.02.22.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:37:14 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/4] git-worktree.txt: employ fixed-width typeface consistently
Date:   Mon,  3 Aug 2020 01:36:09 -0400
Message-Id: <20200803053612.50095-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966
In-Reply-To: <20200803053612.50095-1-sunshine@sunshineco.com>
References: <20200803053612.50095-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-worktree documentation generally does a good job of formatting
literal text using a fixed-width typeface, however, some instances of
unformatted literal text have crept in over time. Fix these.

While at it, also fix a few incorrect typefaces resulting from wrong
choice of Asciidoc quotes.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 66 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 4796c3c05e..810fc8b5e1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -51,7 +51,7 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
-If <commit-ish> is a branch name (call it `<branch>`) and is not found,
+If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
 exist a tracking branch in exactly one remote (call it `<remote>`)
 with a matching name, treat as equivalent to:
@@ -83,7 +83,7 @@ list::
 List details of each worktree.  The main worktree is listed first, followed by
 each of the linked worktrees.  The output details include if the worktree is
 bare, the revision currently checked out, and the branch currently checked out
-(or 'detached HEAD' if none).
+(or "detached HEAD" if none).
 
 lock::
 
@@ -100,7 +100,7 @@ or linked working trees containing submodules cannot be moved.
 
 prune::
 
-Prune working tree information in $GIT_DIR/worktrees.
+Prune working tree information in `$GIT_DIR/worktrees`.
 
 remove::
 
@@ -128,7 +128,7 @@ OPTIONS
 `move` refuses to move a locked working tree unless `--force` is specified
 twice. If the destination is already assigned to some other working tree but is
 missing (for instance, if `<new-path>` was deleted manually), then `--force`
-allows the move to proceed; use --force twice if the destination is locked.
+allows the move to proceed; use `--force` twice if the destination is locked.
 +
 `remove` refuses to remove an unclean working tree unless `--force` is used.
 To remove a locked working tree, specify `--force` twice.
@@ -203,8 +203,8 @@ This can also be set up as the default behaviour by using the
 +
 If the last path components in the working tree's path is unique among
 working trees, it can be used to identify worktrees. For example if
-you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
-then "ghi" or "def/ghi" is enough to point to the former working tree.
+you only have two working trees, at `/abc/def/ghi` and `/abc/def/ggg`,
+then `ghi` or `def/ghi` is enough to point to the former working tree.
 
 REFS
 ----
@@ -214,24 +214,24 @@ working trees. This section is about the sharing rules and how to access
 refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
-with "refs/" are shared. Pseudo refs are ones like HEAD which are
-directly under GIT_DIR instead of inside GIT_DIR/refs. There is one
-exception to this: refs inside refs/bisect and refs/worktree is not
+with `refs/` are shared. Pseudo refs are ones like HEAD which are
+directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There is one
+exception to this: refs inside `refs/bisect` and `refs/worktree` is not
 shared.
 
 Refs that are per working tree can still be accessed from another
-working tree via two special paths, main-worktree and worktrees. The
+working tree via two special paths, `main-worktree` and `worktrees`. The
 former gives access to per-worktree refs of the main working tree,
 while the latter to all linked working trees.
 
-For example, main-worktree/HEAD or main-worktree/refs/bisect/good
+For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
 resolve to the same value as the main working tree's HEAD and
-refs/bisect/good respectively. Similarly, worktrees/foo/HEAD or
-worktrees/bar/refs/bisect/bad are the same as
-GIT_COMMON_DIR/worktrees/foo/HEAD and
-GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
+`refs/bisect/good` respectively. Similarly, `worktrees/foo/HEAD` or
+`worktrees/bar/refs/bisect/bad` are the same as
+`$GIT_COMMON_DIR/worktrees/foo/HEAD` and
+`$GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad`.
 
-To access refs, it's best not to look inside GIT_DIR directly. Instead
+To access refs, it's best not to look inside `$GIT_DIR` directly. Instead
 use commands such as linkgit:git-rev-parse[1] or linkgit:git-update-ref[1]
 which will handle refs correctly.
 
@@ -255,7 +255,7 @@ configuration in this file with `git config --worktree`. Older Git
 versions will refuse to access repositories with this extension.
 
 Note that in this file, the exception for `core.bare` and `core.worktree`
-is gone. If you have them in $GIT_DIR/config before, you must move
+is gone. If you have them in `$GIT_DIR/config` before, you must move
 them to the `config.worktree` of the main working tree. You may also
 take this opportunity to review and move other configuration that you
 do not want to share to all working trees:
@@ -268,7 +268,7 @@ do not want to share to all working trees:
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
-$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
+`$GIT_DIR/worktrees` directory.  The private sub-directory's name is usually
 the base name of the linked working tree's path, possibly appended with a
 number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
 command `git worktree add /path/other/test-next next` creates the linked
@@ -276,51 +276,51 @@ working tree in `/path/other/test-next` and also creates a
 `$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
 if `test-next` is already taken).
 
-Within a linked working tree, $GIT_DIR is set to point to this private
+Within a linked working tree, `$GIT_DIR` is set to point to this private
 directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
-$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
+`$GIT_COMMON_DIR` is set to point back to the main working tree's `$GIT_DIR`
 (e.g. `/path/main/.git`). These settings are made in a `.git` file located at
 the top directory of the linked working tree.
 
 Path resolution via `git rev-parse --git-path` uses either
-$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
+`$GIT_DIR` or `$GIT_COMMON_DIR` depending on the path. For example, in the
 linked working tree `git rev-parse --git-path HEAD` returns
 `/path/main/.git/worktrees/test-next/HEAD` (not
 `/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
 rev-parse --git-path refs/heads/master` uses
-$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees, except refs/bisect and
-refs/worktree.
+`$GIT_COMMON_DIR` and returns `/path/main/.git/refs/heads/master`,
+since refs are shared across all working trees, except `refs/bisect` and
+`refs/worktree`.
 
 See linkgit:gitrepository-layout[5] for more information. The rule of
 thumb is do not make any assumption about whether a path belongs to
-$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
-inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
+`$GIT_DIR` or `$GIT_COMMON_DIR` when you need to directly access something
+inside `$GIT_DIR`. Use `git rev-parse --git-path` to get the final path.
 
-If you manually move a linked working tree, you need to update the 'gitdir' file
+If you manually move a linked working tree, you need to update the `gitdir` file
 in the entry's directory. For example, if a linked working tree is moved
 to `/newpath/test-next` and its `.git` file points to
 `/path/main/.git/worktrees/test-next`, then update
 `/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/test-next`
 instead.
 
-To prevent a $GIT_DIR/worktrees entry from being pruned (which
+To prevent a `$GIT_DIR/worktrees` entry from being pruned (which
 can be useful in some situations, such as when the
 entry's working tree is stored on a portable device), use the
 `git worktree lock` command, which adds a file named
-'locked' to the entry's directory. The file contains the reason in
+`locked` to the entry's directory. The file contains the reason in
 plain text. For example, if a linked working tree's `.git` file points
 to `/path/main/.git/worktrees/test-next` then a file named
 `/path/main/.git/worktrees/test-next/locked` will prevent the
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
 
-When extensions.worktreeConfig is enabled, the config file
+When `extensions.worktreeConfig` is enabled, the config file
 `.git/worktrees/<id>/config.worktree` is read after `.git/config` is.
 
 LIST OUTPUT FORMAT
 ------------------
-The worktree list command has two output formats.  The default format shows the
+The `worktree list` command has two output formats. The default format shows the
 details on a single line with columns.  For example:
 
 ------------
@@ -333,8 +333,8 @@ $ git worktree list
 Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
-label and value separated by a single space.  Boolean attributes (like 'bare'
-and 'detached') are listed as a label only, and are only present if and only
+label and value separated by a single space.  Boolean attributes (like `bare`
+and `detached`) are listed as a label only, and are only present if and only
 if the value is true.  The first attribute of a worktree is always `worktree`,
 an empty line indicates the end of the record.  For example:
 
-- 
2.28.0.236.gb10cc79966


Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0CC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB4A206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukQOFBCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgHDA4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgHDA43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 20:56:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBB8C061756
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 17:56:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k23so40451867iom.10
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/Am2cchrt0LWVMgs/INQC43mx+b9oZVcn7/zjmpPeA=;
        b=ukQOFBCeisIunp0pbhr6D3x/RKlcXV3c1Ac5mU2iGsgv6KXuZBkzSNXXw5vhHRvmkD
         mIPH7AfDAnhAHVmVBjHJfA/XqP8OpabvUYLjTCC3lyf1PfBMX9L/kpD29tOVBzDvLNzP
         mQOncTcLbpENQkwInjLp+Yvw4+ZM/u2fPve2q92cK/wx3xUNdNnxjQyF02W4x/5156Z/
         OAM6C4GfPdtQPgUsoc8XGwgpT9SXvv5GgFouZ5Ou4ttT3nyOUKrKnAyjR1hZr3TMYxCJ
         j6bSy9htKptcgFD/8Hqt6RJ56dCYe/547icboSFYlIGjQrgNCOpq88jDkQ9ErgTuMHsj
         aBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Y/Am2cchrt0LWVMgs/INQC43mx+b9oZVcn7/zjmpPeA=;
        b=EBstvhjYjv6+DEIUOnb48Mh7/9vaNMMumurCiC/o/3GB94CRRnGzJaqOhw+Zc74a5L
         wMep29nPdwHZKQoodPqFmW3GUb/Wy+/HxLPnH+sTIQMRd4dI0xlCRGSbARTFDDOnrOUV
         SZkqyfyo6GdlxDnYjcE5Rxo1VpXtBDy34UzHfs2483tK2UR+xIrm8rmL7o1t2E+F8614
         Jm3C3c7Qt1gxPCnKjzfqh+eZ7MpErXGBFAhg8NvadPwjnv/rL8wkQY2sqJ7XV/vL/By8
         RiIexcp6Yq/0VGCHz7NaP0RhXoEPeQHv0igDY2eSa21SjMiOlyEzHRRBL8o8TeuD17A5
         CkaQ==
X-Gm-Message-State: AOAM533AeETzM0YT2H/5Zzo4WmtRRQ87hXuhLaz5zp2PpKphoA0t0LYb
        Z85+vsIXZbJwzAEYAp7o1qG5QawV+Js=
X-Google-Smtp-Source: ABdhPJw96jlX50cL93GMhwB6BoAjHltCU+N82K9MPBaqk0xNP37hTPRj2sxfQZitl/TpCcSDCDdSkQ==
X-Received: by 2002:a05:6638:138a:: with SMTP id w10mr2765686jad.36.1596502586728;
        Mon, 03 Aug 2020 17:56:26 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e84sm11878453ill.60.2020.08.03.17.56.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2020 17:56:26 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/5] git-worktree.txt: employ fixed-width typeface consistently
Date:   Mon,  3 Aug 2020 20:55:31 -0400
Message-Id: <20200804005535.5126-2-sunshine@sunshineco.com>
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

git-worktree documentation generally does a good job of formatting
literal text using a fixed-width typeface, however, some instances of
unformatted literal text have crept in over time. Fix these.

While at it, also fix a few incorrect typefaces resulting from wrong
choice of Asciidoc quotes.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 96 +++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 4796c3c05e..f7c1bd34f8 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -25,8 +25,8 @@ Manage multiple working trees attached to the same repository.
 A git repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
 tree is associated with the repository.  This new working tree is called a
-"linked working tree" as opposed to the "main working tree" prepared by "git
-init" or "git clone".  A repository has one main working tree (if it's not a
+"linked working tree" as opposed to the "main working tree" prepared by `git
+init` or `git clone`.  A repository has one main working tree (if it's not a
 bare repository) and zero or more linked working trees. When you are done
 with a linked working tree, remove it with `git worktree remove`.
 
@@ -48,10 +48,10 @@ add <path> [<commit-ish>]::
 
 Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
-directory specific files such as HEAD, index, etc. `-` may also be
+directory specific files such as `HEAD`, `index`, etc. `-` may also be
 specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
-If <commit-ish> is a branch name (call it `<branch>`) and is not found,
+If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
 exist a tracking branch in exactly one remote (call it `<remote>`)
 with a matching name, treat as equivalent to:
@@ -66,13 +66,13 @@ one for the purposes of disambiguation, even if the `<branch>` isn't
 unique across all remotes. Set it to
 e.g. `checkout.defaultRemote=origin` to always checkout remote
 branches from there if `<branch>` is ambiguous but exists on the
-'origin' remote. See also `checkout.defaultRemote` in
+`origin` remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, the new worktree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
-doesn't exist, a new branch based on HEAD is automatically created as
+doesn't exist, a new branch based on `HEAD` is automatically created as
 if `-b <branch>` was given.  If `<branch>` does exist, it will be
 checked out in the new worktree, if it's not checked out anywhere
 else, otherwise the command will refuse to create the worktree (unless
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
@@ -137,13 +137,13 @@ To remove a locked working tree, specify `--force` twice.
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
 	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
-	If `<commit-ish>` is omitted, it defaults to HEAD.
+	If `<commit-ish>` is omitted, it defaults to `HEAD`.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<commit-ish>`.
 
 --detach::
-	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
+	With `add`, detach `HEAD` in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
@@ -154,7 +154,7 @@ To remove a locked working tree, specify `--force` twice.
 
 --[no-]guess-remote::
 	With `worktree add <path>`, without `<commit-ish>`, instead
-	of creating a new branch from HEAD, if there exists a tracking
+	of creating a new branch from `HEAD`, if there exists a tracking
 	branch in exactly one remote matching the basename of `<path>`,
 	base the new branch on the remote-tracking branch, and mark
 	the remote-tracking branch as "upstream" from the new branch.
@@ -166,7 +166,7 @@ This can also be set up as the default behaviour by using the
 	When creating a new branch, if `<commit-ish>` is a branch,
 	mark it as "upstream" from the new branch.  This is the
 	default if `<commit-ish>` is a remote-tracking branch.  See
-	"--track" in linkgit:git-branch[1] for details.
+	`--track` in linkgit:git-branch[1] for details.
 
 --lock::
 	Keep the working tree locked after creation. This is the
@@ -185,14 +185,14 @@ This can also be set up as the default behaviour by using the
 
 -q::
 --quiet::
-	With 'add', suppress feedback messages.
+	With `add`, suppress feedback messages.
 
 -v::
 --verbose::
 	With `prune`, report all removals.
 
 --expire <time>::
-	With `prune`, only expire unused working trees older than <time>.
+	With `prune`, only expire unused working trees older than `<time>`.
 
 --reason <string>::
 	With `lock`, an explanation why the working tree is locked.
@@ -203,47 +203,47 @@ This can also be set up as the default behaviour by using the
 +
 If the last path components in the working tree's path is unique among
 working trees, it can be used to identify worktrees. For example if
-you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
-then "ghi" or "def/ghi" is enough to point to the former working tree.
+you only have two working trees, at `/abc/def/ghi` and `/abc/def/ggg`,
+then `ghi` or `def/ghi` is enough to point to the former working tree.
 
 REFS
 ----
 In multiple working trees, some refs may be shared between all working
-trees, some refs are local. One example is HEAD is different for all
+trees, some refs are local. One example is `HEAD` is different for all
 working trees. This section is about the sharing rules and how to access
 refs of one working tree from another.
 
 In general, all pseudo refs are per working tree and all refs starting
-with "refs/" are shared. Pseudo refs are ones like HEAD which are
-directly under GIT_DIR instead of inside GIT_DIR/refs. There is one
-exception to this: refs inside refs/bisect and refs/worktree is not
+with `refs/` are shared. Pseudo refs are ones like `HEAD` which are
+directly under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There is one
+exception to this: refs inside `refs/bisect` and `refs/worktree` is not
 shared.
 
 Refs that are per working tree can still be accessed from another
-working tree via two special paths, main-worktree and worktrees. The
+working tree via two special paths, `main-worktree` and `worktrees`. The
 former gives access to per-worktree refs of the main working tree,
 while the latter to all linked working trees.
 
-For example, main-worktree/HEAD or main-worktree/refs/bisect/good
-resolve to the same value as the main working tree's HEAD and
-refs/bisect/good respectively. Similarly, worktrees/foo/HEAD or
-worktrees/bar/refs/bisect/bad are the same as
-GIT_COMMON_DIR/worktrees/foo/HEAD and
-GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad.
+For example, `main-worktree/HEAD` or `main-worktree/refs/bisect/good`
+resolve to the same value as the main working tree's `HEAD` and
+`refs/bisect/good` respectively. Similarly, `worktrees/foo/HEAD` or
+`worktrees/bar/refs/bisect/bad` are the same as
+`$GIT_COMMON_DIR/worktrees/foo/HEAD` and
+`$GIT_COMMON_DIR/worktrees/bar/refs/bisect/bad`.
 
-To access refs, it's best not to look inside GIT_DIR directly. Instead
+To access refs, it's best not to look inside `$GIT_DIR` directly. Instead
 use commands such as linkgit:git-rev-parse[1] or linkgit:git-update-ref[1]
 which will handle refs correctly.
 
 CONFIGURATION FILE
 ------------------
-By default, the repository "config" file is shared across all working
+By default, the repository `config` file is shared across all working
 trees. If the config variables `core.bare` or `core.worktree` are
 already present in the config file, they will be applied to the main
 working trees only.
 
 In order to have configuration specific to working trees, you can turn
-on "worktreeConfig" extension, e.g.:
+on `worktreeConfig` extension, e.g.:
 
 ------------
 $ git config extensions.worktreeConfig true
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


Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B791C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C954208C4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfQNcXLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgBJOp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:45:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51936 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgBJOpz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so612498wmi.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bCIqXzOckgxEsS+5cMOhrDW/Cs7AQBiXb8UMN5cEHQI=;
        b=MfQNcXLcytEuED0pKffHXmWIa/+I0EUJhPozisDi5VoKcKDQMt9IqCFe6u9ChXPm0q
         CwdeMi3zTKlqiA6ak08Ja1UkSYKDZPBzVKp4N02v7RGLFs6qYqvkbMdcCdp3taOKAY28
         o2TlumyFyTpkdUxaNS1t0kcHhPRvdtpYIgZYTXLV1LVAX6eZbFVKmhQyVmt1oPgT/DYB
         /XsJajpSdbz+VN4F8gRxNFe0cCM8Xc9VgHJk6K+/PTPpwdGzbAwZBNDeTiydElGuC5m3
         UB+N3ohBdwA5ZLpLkqFc6mtGtspZuPy3qZpkL5qOVHLOYPYwfvOuJuvsVOPCV8molCER
         o9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bCIqXzOckgxEsS+5cMOhrDW/Cs7AQBiXb8UMN5cEHQI=;
        b=WusmeEtTR0gedUQtxBJFVLV5fipnbrfl0QYC386mFfw3XpTAGYJ0TvHXKFZgTbNSip
         UvVRusSDqU6fnf86e49oBs7W9OOGdZ0qwt5Noa47KWrpgvVVcDUaGiAXLSHMugrORNpd
         /rH9dWZV01ZHfPcdLzdzKhM4mk3xHKb2EaAt7C+ubfNwZ+p5A5ChatbGTSclLRFABW1G
         UOgk654RGxgoxTs28JaMGK/hN1tWQVFeKGkcj70o70RosiuRH0ewjwwc9VMlNS8DBVhU
         BO1lGjaNccMZ5On5ScVIl1JjWq/K4Mf8rRq8vbdvJPHoCCzeebfV5/+vUERzpjtjkbev
         w9Tg==
X-Gm-Message-State: APjAAAUb1+lcDgOnnz/ECGW5eQihkOfEzolpS6y0Wr+VbBmfSTLT9UEp
        m+HqanMwQv6KFf7Ok0otUwJJX/t8
X-Google-Smtp-Source: APXvYqzjBc42+D93TKh06T0l92WXlmRZ3LAxAJ1fAgVLUrA2oL3W6SYCR0y+cprK0taaiI0GsOwvAQ==
X-Received: by 2002:a1c:6209:: with SMTP id w9mr13468432wmb.183.1581345952500;
        Mon, 10 Feb 2020 06:45:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm824341wmj.33.2020.02.10.06.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:52 -0800 (PST)
Message-Id: <db3a96720ce94cc93c8bcefe08d3340ae4e08cae.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:43 +0000
Subject: [PATCH v2 4/8] doc: stash: split options from description (2)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Together with the previous patch, this brings docs for `git stash` to
the common layout used for most other commands (see for example docs
for `git add`, `git commit`, `git checkout`, `git reset`) where all
options are documented in a separate list.

After some thinking and having a look at docs for `git svn` and
`git `submodule`, I have arrived at following conclusions:
  * Options should be described in a list rather then text to
    facilitate lookup for user.
  * Single list is better then multiple lists because it avoids
    copy&pasting descriptions between subcommands (or, without
    copy&pasting, user will have to look up missing options in other
    subcommands).
  * As a consequence, commands section should only give brief info and
    list possible options. Since options have good enough names, user
	will only need to look up the "interesting" options.
  * Every option should list which subcommands support it.

I have decided to use alphabetical sorting in the list of options to
facilitate lookup for user.

There is some text editing done to make old descriptions better fit
into the list-style format.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 92 +++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 2dedc21997..c1c16623cb 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -43,8 +43,8 @@ created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible). Stashes may also be referenced by specifying just the
 stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 
-OPTIONS
--------
+COMMANDS
+--------
 
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
@@ -86,7 +86,7 @@ show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
-	created. When no `<stash>` is given, it shows the latest one.
+	created.
 	By default, the command shows the diffstat, but it will accept any
 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
@@ -116,8 +116,7 @@ branch <branchname> [<stash>]::
 	the commit at which the `<stash>` was originally created, applies the
 	changes recorded in `<stash>` to the new working tree and index.
 	If that succeeds, and `<stash>` is a reference of the form
-	`stash@{<revision>}`, it then drops the `<stash>`. When no `<stash>`
-	is given, applies the latest one.
+	`stash@{<revision>}`, it then drops the `<stash>`.
 +
 This is useful if the branch on which you ran `git stash push` has
 changed enough that `git stash apply` fails due to conflicts. Since
@@ -133,9 +132,6 @@ clear::
 drop [-q|--quiet] [<stash>]::
 
 	Remove a single stash entry from the list of stash entries.
-	When no `<stash>` is given, it removes the latest one.
-	i.e. `stash@{0}`, otherwise `<stash>` must be a valid stash
-	log reference of the form `stash@{<revision>}`.
 
 create::
 
@@ -152,40 +148,66 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
-If the `--all` option is used instead then the
-ignored files are stashed and cleaned in addition to the untracked files.
-
-If the `--include-untracked` option is used, all untracked files are also
-stashed and then cleaned up with `git clean`, leaving the working directory
-in a very clean state.
+OPTIONS
+-------
+-a::
+--all::
+	This option is only valid for `push` and `save` commands.
++
+All ignored and untracked files are also stashed and then cleaned
+up with `git clean`.
 
-If the `--index` option is used, then tries to reinstate not only the working
-tree's changes, but also the index's ones. However, this can fail, when you
-have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
+-u::
+--include-untracked::
+	This option is only valid for `push` and `save` commands.
++
+All untracked files are also stashed and then cleaned up with
+`git clean`.
 
-If the `--keep-index` option is used, all changes already added to the
-index are left intact.
+--index::
+	This option is only valid for `pop` and `apply` commands.
++
+Tries to reinstate not only the working tree's changes, but also
+the index's ones. However, this can fail, when you have conflicts
+(which are stored in the index, where you therefore can no longer
+apply the changes as they were originally).
+
+-k::
+--keep-index::
+--no-keep-index::
+	This option is only valid for `push` and `save` commands.
++
+All changes already added to the index are left intact.
 
-With `--patch`, you can interactively select hunks from the diff
-between HEAD and the working tree to be stashed.  The stash entry is
-constructed such that its index state is the same as the index state
-of your repository, and its worktree contains only the changes you
-selected interactively.  The selected changes are then rolled back
-from your worktree. See the ``Interactive Mode'' section of
-linkgit:git-add[1] to learn how to operate the `--patch` mode.
+-p::
+--patch::
+	This option is only valid for `push` and `save` commands.
++
+Interactively select hunks from the diff between HEAD and the
+working tree to be stashed.  The stash entry is constructed such
+that its index state is the same as the index state of your
+repository, and its worktree contains only the changes you selected
+interactively.  The selected changes are then rolled back from your
+worktree. See the ``Interactive Mode'' section of linkgit:git-add[1]
+to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use 
 `--no-keep-index` to override this.
 
-When pathspec is given to 'git stash push', the new stash entry records the
-modified states only for the files that match the pathspec.  The index
-entries and working tree files are then rolled back to the state in
-HEAD only for these files, too, leaving files that do not match the
-pathspec intact.
-
-When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
-be a reference of the form `stash@{<revision>}`.
+<pathspec>...::
+	This option is only valid for `push` command.
++
+The new stash entry records the modified states only for the files
+that match the pathspec.  The index entries and working tree files
+are then rolled back to the state in HEAD only for these files,
+too, leaving files that do not match the pathspec intact.
+
+<stash>::
+	This option is only valid for `apply`, `branch`, `drop`, `pop`,
+	`show` commands.
++
+A reference of the form `stash@{<revision>}`. When no `<stash>` is
+given, the latest stash is assumed (that is, `stash@{0}`).
 
 DISCUSSION
 ----------
-- 
gitgitgadget


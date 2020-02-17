Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C505C34025
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55320801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLCxpalr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgBQRZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39463 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgBQRZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so113408wme.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s6UKQ3UVj1/6S4yg9rFPtjA48MHEQRyxGGe85J73NIo=;
        b=QLCxpalrvrnjuXTrrMs0zwtJHneI0TPLA9AGwv4VdiFTk5MewjG5X59C3p1JOcb6oU
         BnpQdWnWsme8feG20aOOLx33CbQDE3OI+wE2JUSX9xX/+9Z8YBks9ElAb1mZEZMZdCqi
         QBI4UIVVZM4yTVe5t+hjmw832CeFLYAZbTW6OcybFlRp55fuNN8BlLe3st5hG6UvqGuQ
         Uzf/vpa3Scpu9YOVxs7jOHDFx8S7TW1Lr7cPHLbS7brfuP2Su3cfKjxDaGKXTdrpfYtf
         otyMqRETAkfJM5nQP+AWohnR8YJCMRbdXp4qZPZB/8FQi+tVuQ8hGBZCtZuKXGNDHLX7
         WHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s6UKQ3UVj1/6S4yg9rFPtjA48MHEQRyxGGe85J73NIo=;
        b=cq7DR7xVSzV9EwR34Z3Wrefdwr8by2xZN4DD02F49ADtqvmZB/1aXrgZRHAtgpd2bj
         0FHRWHqv3A/Qyvtqai2nFC+GSwRA2BosNbCg8drU08sNMoE4z79hdBRIFcb02v6zHZRN
         W1DaBczmvNf0FuzWe1OoS6wssWVseXkRCVWa7Hf1FBFb3RZ48HKnrTpn5To+Bdpxx1HX
         cJPZFDEW5uiMpOUbLWCf0sT7U2HEsQO0TjXoBMeSOlxjJfZQIP5U1Vsjsf6aIwROUMp9
         sgDQTIO5nDx7klOt9nlO+u10I76eihVs+0cdLGrgng+H9ccTsbqvwgMlcVnPF9qn7IpK
         YP3w==
X-Gm-Message-State: APjAAAWE5OrVDz+UW/UWqDdxhgZFXbv39slebHLxLCQ3bQs6XY7UpVVO
        Wf7xYrax6lIK+i1/QhWbJUwUwTTj
X-Google-Smtp-Source: APXvYqydezy4V4mEeUgIcViREkNimwXNidJjpd0FI3q4xGDzzma8MIOukkOMvydmoHZWAzux++SQlg==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr60316wmh.131.1581960325853;
        Mon, 17 Feb 2020 09:25:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm1870359wrt.1.2020.02.17.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:25 -0800 (PST)
Message-Id: <bb300215d4978cf64d4c60d92c13acd7464b545b.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:17 +0000
Subject: [PATCH v3 3/8] doc: stash: split options from description (1)
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

This patch moves blocks of text as-is to make it easier to review the
next patch.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 68 +++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 53e1a1205d3..2dedc219974 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -58,31 +58,6 @@ non-option arguments are not allowed to prevent a misspelled
 subcommand from making an unwanted stash entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspecs,
 which are allowed after a double hyphen `--` for disambiguation.
-+
-When pathspec is given to 'git stash push', the new stash entry records the
-modified states only for the files that match the pathspec.  The index
-entries and working tree files are then rolled back to the state in
-HEAD only for these files, too, leaving files that do not match the
-pathspec intact.
-+
-If the `--keep-index` option is used, all changes already added to the
-index are left intact.
-+
-If the `--include-untracked` option is used, all untracked files are also
-stashed and then cleaned up with `git clean`, leaving the working directory
-in a very clean state. If the `--all` option is used instead then the
-ignored files are stashed and cleaned in addition to the untracked files.
-+
-With `--patch`, you can interactively select hunks from the diff
-between HEAD and the working tree to be stashed.  The stash entry is
-constructed such that its index state is the same as the index state
-of your repository, and its worktree contains only the changes you
-selected interactively.  The selected changes are then rolled back
-from your worktree. See the ``Interactive Mode'' section of
-linkgit:git-add[1] to learn how to operate the `--patch` mode.
-+
-The `--patch` option implies `--keep-index`.  You can use
-`--no-keep-index` to override this.
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
@@ -128,14 +103,6 @@ pop [--index] [-q|--quiet] [<stash>]::
 Applying the state can fail with conflicts; in this case, it is not
 removed from the stash list. You need to resolve the conflicts by hand
 and call `git stash drop` manually afterwards.
-+
-If the `--index` option is used, then tries to reinstate not only the working
-tree's changes, but also the index's ones. However, this can fail, when you
-have conflicts (which are stored in the index, where you therefore can no
-longer apply the changes as they were originally).
-+
-When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
-be a reference of the form `stash@{<revision>}`.
 
 apply [--index] [-q|--quiet] [<stash>]::
 
@@ -185,6 +152,41 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
+If the `--all` option is used instead then the
+ignored files are stashed and cleaned in addition to the untracked files.
+
+If the `--include-untracked` option is used, all untracked files are also
+stashed and then cleaned up with `git clean`, leaving the working directory
+in a very clean state.
+
+If the `--index` option is used, then tries to reinstate not only the working
+tree's changes, but also the index's ones. However, this can fail, when you
+have conflicts (which are stored in the index, where you therefore can no
+longer apply the changes as they were originally).
+
+If the `--keep-index` option is used, all changes already added to the
+index are left intact.
+
+With `--patch`, you can interactively select hunks from the diff
+between HEAD and the working tree to be stashed.  The stash entry is
+constructed such that its index state is the same as the index state
+of your repository, and its worktree contains only the changes you
+selected interactively.  The selected changes are then rolled back
+from your worktree. See the ``Interactive Mode'' section of
+linkgit:git-add[1] to learn how to operate the `--patch` mode.
++
+The `--patch` option implies `--keep-index`.  You can use 
+`--no-keep-index` to override this.
+
+When pathspec is given to 'git stash push', the new stash entry records the
+modified states only for the files that match the pathspec.  The index
+entries and working tree files are then rolled back to the state in
+HEAD only for these files, too, leaving files that do not match the
+pathspec intact.
+
+When no `<stash>` is given, `stash@{0}` is assumed, otherwise `<stash>` must
+be a reference of the form `stash@{<revision>}`.
+
 DISCUSSION
 ----------
 
-- 
gitgitgadget


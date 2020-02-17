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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185FFC34024
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57D120801
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzmf7ti6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgBQRZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgBQRZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so20706438wru.7
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D7gH03SwXw/yITHHsF4wOerpPkhm1CYTuLfO64Gp/zE=;
        b=lzmf7ti6Ijg3212RTUO97pv8UVbbQqSeqPvabsrLgmvaciUWRGR32qwSWjXw9Nssqz
         d5D9FmEhwyiZnFoAniUCx1+ZYLhJDWy6ek0ixxG+4m0CO6CMZYNynwf9fuO9e4RRA/To
         UZNMNngU/tUw5ZTXQhzTlOSgzeOkw+wP2xoxna0gApN6+e4lEVZgpte6H8ErT1xtHYEw
         dGseWTC7cDMYnIjGosaNt7IuXFaAfFtVWBH5NzQS05mYMkbstvKRX901pfA7opGA6XzQ
         o0kjyfvYGgOFHfQMG9chlL/efgX/qTtpuajX+DdeTWaDf0gKyNq7C6AlR57yJiAgsAt2
         5UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D7gH03SwXw/yITHHsF4wOerpPkhm1CYTuLfO64Gp/zE=;
        b=mblomFRQ2Ttcg37GCA5sVCw6r24juuTIFL7fdQaJ78K9rdItjPTGSFuAbCN5dX6gAI
         BuS0Gac80ugP+yw0qeW1tknwlafMJzVE7oSHjqeN2QXz0U8AitLLKznAUYQyTOyG8rLo
         CDqq/e5DGEocr2QcbkS8iiayEP2MLC6rI2H2F5LDT1ENbpr9xvRaVyeU9qZVjGn/7T9w
         BrUYdAb5QPZEKbJJvFMMPEKkD4xXbOEMzcLAhNQwLB4gXPFifg1RpbtP9bdgDJSnaGHq
         ppTlvHuJ9hffQCjhpxtd5HjvFMMzfyRZT7EfkFylek7i2jQS6m2b8YcevnNx+z/9T8+9
         I3Lg==
X-Gm-Message-State: APjAAAXegSFtHapqGbsKWqWrWJ3rZHZ2Rz7LkMtOuLxoAfAs1w8to1b6
        B7AeQNU4hTeeRDSlDhJqCEGPTN4p
X-Google-Smtp-Source: APXvYqyrsRYwwL0y7wx8XFWameqhULAC9+dAs38gI+H/RbvbnnmOsLdT2W4zMpuRwijUF38cHlp3Ew==
X-Received: by 2002:a05:6000:367:: with SMTP id f7mr22845508wrf.174.1581960324127;
        Mon, 17 Feb 2020 09:25:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm2051798wrt.30.2020.02.17.09.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:23 -0800 (PST)
Message-Id: <cf065e905dcd8e44a1ee87602a7525c537eab27d.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:15 +0000
Subject: [PATCH v3 1/8] doc: rm: synchronize <pathspec> description
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

This patch continues the effort that is already applied to
`git commit`, `git reset`, `git checkout` etc.

1) Changed outdated descriptions to mention pathspec instead.
2) Added reference to 'linkgit:gitglossary[7]'.
3) Removed content that merely repeated gitglossary.
4) Merged the remainder of "discussion" into `<patchspec>`.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-rm.txt | 50 +++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b5c46223c44..e02a08e5efd 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,16 +8,16 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <pathspec>...
 
 DESCRIPTION
 -----------
-Remove files from the index, or from the working tree and the index.
-`git rm` will not remove a file from just your working directory.
-(There is no option to remove a file only from the working tree
-and yet keep it in the index; use `/bin/rm` if you want to do that.)
-The files being removed have to be identical to the tip of the branch,
-and no updates to their contents can be staged in the index,
+Remove files matching pathspec from the index, or from the working tree
+and the index. `git rm` will not remove a file from just your working
+directory. (There is no option to remove a file only from the working
+tree and yet keep it in the index; use `/bin/rm` if you want to do
+that.) The files being removed have to be identical to the tip of the
+branch, and no updates to their contents can be staged in the index,
 though that default behavior can be overridden with the `-f` option.
 When `--cached` is given, the staged content has to
 match either the tip of the branch or the file on disk,
@@ -26,15 +26,20 @@ allowing the file to be removed from just the index.
 
 OPTIONS
 -------
-<file>...::
-	Files to remove.  Fileglobs (e.g. `*.c`) can be given to
-	remove all matching files.  If you want Git to expand
-	file glob characters, you may need to shell-escape them.
-	A leading directory name
-	(e.g. `dir` to remove `dir/file1` and `dir/file2`) can be
-	given to remove all files in the directory, and recursively
-	all sub-directories,
-	but this requires the `-r` option to be explicitly given.
+<pathspec>...::
+	Files to remove.  A leading directory name (e.g. `dir` to remove
+	`dir/file1` and `dir/file2`) can be given to remove all files in
+	the directory, and recursively all sub-directories, but this
+	requires the `-r` option to be explicitly given.
++
+The command removes only the paths that are known to Git.
++
+File globbing matches across directory boundaries.  Thus, given two
+directories `d` and `d2`, there is a difference between using
+`git rm 'd*'` and `git rm 'd/*'`, as the former will also remove all
+of directory `d2`.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 -f::
 --force::
@@ -69,19 +74,6 @@ OPTIONS
 	for each file removed. This option suppresses that output.
 
 
-DISCUSSION
-----------
-
-The <file> list given to the command can be exact pathnames,
-file glob patterns, or leading directory names.  The command
-removes only the paths that are known to Git.  Giving the name of
-a file that you have not told Git about does not remove that file.
-
-File globbing matches across directory boundaries.  Thus, given
-two directories `d` and `d2`, there is a difference between
-using `git rm 'd*'` and `git rm 'd/*'`, as the former will
-also remove all of directory `d2`.
-
 REMOVING FILES THAT HAVE DISAPPEARED FROM THE FILESYSTEM
 --------------------------------------------------------
 There is no option for `git rm` to remove from the index only
-- 
gitgitgadget


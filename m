Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A6CC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C8F2077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxWYR/DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAPQJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34435 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPQJa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so19747671wrr.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lWNe8ZOU5ZJwdci14t4PB6WCJ/g25rTTh2vF6pXDOIc=;
        b=SxWYR/DTzbm78IaYUzZgl6S2Ow/psmkBiU6myKq/p91BI+PriA8czmTm3GfrYtODT0
         h3o/8FHdvzDfJ0HqTV2CQRzQ9IwHtbUdIkvNL6Ud3ZpBUAcY3kXxXiU/CieTroTgnvua
         Ve6ES/07bqai6gCgwjXaw8DmKxs1rpWpJKjgg55e4CvzJjjMXZwl+OGulJpL6nI9qcSV
         dYG+0G9P6RNBQ+APHdm6GJaLWhvA97r87TBaayFWfRp5VsK8d4tY3jh1pTQc20hqkKbR
         Z+b1gfdfkNsqBgemv8KrtynT/cu6XBKx6Qpz3VQX/y595l5mjw9t58Xj0pDr5jneyK7V
         Gl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lWNe8ZOU5ZJwdci14t4PB6WCJ/g25rTTh2vF6pXDOIc=;
        b=h07luWckvd5EGucgTFPrR57NtI/yebAr7ZAOW+l1jFmHpZwd8CRiWHfNZDqpMy5iYm
         dgJ2jwTVDsZD+hJ9H6jyzfq4xL8a17vmi5xYdVxZRXIhJ00MSULNlWqDYVbwAa/vgrwq
         BC4DKnpe+z+51FYFNmoPfEkRs9O9mn6EYz+K+49PPTrO0AF2KKmPtDooIX6TwoKkfD3Y
         Hx8AeXv1c1hMWcoforo/bDw6GhtgcDtehCX0RjQZmuDmRgthHhpiEYg9aUc1yTGjO2Xp
         xDnObmO9n4rqEAmDlVVdCpfGx3cABB93/7yqMmT2VwgBSHAy623SUCv4Lf3/RmYq+3Gp
         CqCg==
X-Gm-Message-State: APjAAAWHrV7xN4raHJGYmjbGFC3p80ADJzeWHpMuEFPj7BWgVsxr45i5
        jOh8Td5XRDkvFnOQgiwOixc2bOVI
X-Google-Smtp-Source: APXvYqzJq5A/dZc01wyXFnCbNFzkbTT+OvaQBrxNTQRUDZUDgLa9I8MbMRm7+6eYfNQ0uIh8aUmLew==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr4234468wrp.182.1579190967691;
        Thu, 16 Jan 2020 08:09:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b21sm531096wmd.37.2020.01.16.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:27 -0800 (PST)
Message-Id: <23387f83912d1f5aef17a28d466db162f50fd722.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:18 +0000
Subject: [PATCH 1/8] doc: rm: synchronize <pathspec> description
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
index b5c46223c4..e02a08e5ef 100644
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


Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2244BC352BE
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36A12063A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0gTvghH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgDMRF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728895AbgDMLEm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 07:04:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17969C008748
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:56:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b72so4327094pfb.11
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9AeHGZGW1ORoBvUCyAWHRYDewYGWKc3iNoKA/udv6Y=;
        b=o0gTvghHj6507pBniZ0YF1/FioL4gM3ab6VfJJH/Zvv6ltv2nY2k7MjgRMQK6ZGngO
         gz00pvkD3tzkPz7CFbcc6SFwTGLfwWigHPU0sXKRzbNAumMwwq8kaD7tG3QhYh+jN0hx
         nGm9CgWxOMl9MU8V60lfd++c4pR3Ps2Vus+QiREdqIGS7PLBUl7v8ezxdLdZqXcIMfg9
         JriQInILNPdIyhSxTA4hFAJHI3iwp6BXIsu4d82/EDdigqzDnkhNEcx88kV4E9tYsAfY
         1Gor5cwhc5Vqj5KUAvz9wYdjZivHUSWAXmvimFdvpVAR3CUBVv3gUpdl8IDQlwEko6wh
         bDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9AeHGZGW1ORoBvUCyAWHRYDewYGWKc3iNoKA/udv6Y=;
        b=lYNkScWsuAhi1AMDVnP0/hrbGwmgmIhKRN8wMo06hIPUvAd5B8bKjCOJnGvQ/NVaPK
         gjJTG0KzRb2eihczfsIVgpZX5RZEcSbxjwhEXh+wa4bEYL/MVFy+NYZVXSNinCi4bFgm
         rLusbUKvzvHEHMWMt58hbIy9i3q75MIK3AWpP54VtfGDtG8fos2LdyKpan2WyLjUMYb5
         L3PNZscEHNB06LASUeG42os7KFqDalutrJXVIonlYJyYwl3n/ybh089tKR1YsWOjCyL4
         xrMGPMMso8cg2dDkt8wvZNkP/PulLhtXJW9ebmKB0DC1zevjAWPa47ku+uEcyuSsYM6C
         BkPg==
X-Gm-Message-State: AGi0PuYpWU7uPavGsYzIvM0ofJZtPNvTGZj/msNNKzfu0iipSsj6H61c
        iseRHqjyXx5c8bbex0B5FfmiA/fgGfOvyQ==
X-Google-Smtp-Source: APiQypLrSo3QMoVCLJDn5in0U5MaeLQWI9WBX1EIPXEx0sVazeha4PpJR2ZFV97lejAcJ5/DQGRL8g==
X-Received: by 2002:a65:6805:: with SMTP id l5mr16191469pgt.256.1586775364905;
        Mon, 13 Apr 2020 03:56:04 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id p188sm8233544pfg.184.2020.04.13.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 03:56:04 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com,
        martin.agren@gmail.com, emilyshaffer@google.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
Date:   Mon, 13 Apr 2020 16:25:29 +0530
Message-Id: <20200413105529.16693-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413105529.16693-1-shouryashukla.oo@gmail.com>
References: <20200413105529.16693-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more issues and their respective solutions in the 'Common Issues'
section of gitfaq.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 104 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 1cf83df118..fc261cbbf5 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,110 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate.  This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[rebasing-and-merging]]
+How do I know when to merge or rebase?::
+	Rebasing and merging two entirely different concepts with different utiilites.
+	In Git terms, rebasing means to place changes made in one branch over another branch
+	(called base, hence the term, rebase). The commit history of the branch wanting to rebase
+	get placed over the branch on the receiving end and it appears as if those changes took
+	place in the receiving branch itself. Merging, as the name suggests, merges the latest
+	commit of one branch onto the recent branch, making this combination appear as one separate
+	commit.
++
+Now that we have an idea of the key differences between merging and rebasing, we can look at the
+circumstances when we would want to perform them. Generally, merging is preferred when one desires
+to create a new feature, perform its integration testing with the original codebase, and finally
+integrate it if all tests are passed. One would choose to create a separate branch for this purpose
+and maybe dissolve it when the merge is done.
++
+One might want to perform a rebase when they intend to retain the changes made in a separate branch
+into their original branch. In that case, a rebase would place the former changes onto the commit tree
+of the latter.
++
+As an additional tip, one can use interactive rebasing, `git rebase -i`, to perform rebasing
+using a text editor GUI (the value of $GIT_EDITOR). Interactive rebase is an excellent utility
+to perform various functions such as editing commit messages, dropping/squashing commits, editing
+commits, etc., all in one package.
+
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they show up as changes in my staging area::
+	One uses '.gitignore' to ignore files from getting tracked in the working tree. This ignores
+	the aforementioned files for the whole lifetime of the project unless they area removed from
+	the '.gitignore'. Consequently, `git add` does not list these files as 'modified' even if any
+	change was made in them and `git status` does not bother to track the changes in these files
+	either.
+
+	But, '.gitignore' will only ignore the files which were not a part of the repository when they
+	were mentioned in the it. Hence, addition of a file to '.gitignore' after it was added to the
+	working tree will have no effect and Git will keep tracking them. To amend this mistake, i.e.,
+	to untrack and completely ignore a tracked file, one has to use `git rm --cached <file>` to
+	remove the file from the staging area(i.e. the cache) and not from the repository(presuming
+	the file has been added in the 'gitignore'). This will hence make our file behave exactly like
+	we described in the paragraph above.
+
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your changes as well as fetches
+	any new changes(if any). There might be different circumstances in which one might need to change
+	the remote:
+
+		1. One might want to update the url of their remote; in that case, the command to use is,
+		   `git remote set-url <name> <newurl>`.
+
+		2. One might want to have two different remotes for fetching and pushing; this generally
+		   happens in case of triangular workflows. In this case, it is advisable to create a
+		   separate remote just for fetching/pushing. But, another way can be to change the push
+		   url using the `--push` option in the `git set-url` command.
+
+[[fetching-and-pulling]]
+How do I know if I want to do a fetch or a pull?::
+	A fetch brings in the latest changes made upstream(i.e. the remote repository we are working on).
+	This allows us to inspect the changes made upstream and integrate all those changes(iff we want to)
+	or only cherry pick certain changes. Fetching does not have any immediate effects on the local
+	repository.
+
+	A pull is a wrapper for a fetch and merge. This means that doing a `git pull` will not only fetch the
+	changes made upstream but integrate them as well with our local repository. The merge may go smoothly
+	or have merge conflicts depending on the case. A pull does not allow you to review any changes made
+	upstream but rather merge those changes on their own.
++
+This is the reason why it is sometimes advised to fetch the changes first and then merge them accordingly
+because not every change might be of utility to the user.
+
+[[checking-out]]
+What is checking out a commit/branch? How do I perform one?::
+	In Git terminology, a 'checkout' serves three purposes, namely:
+
+		1. Go to another commit; I would be "checking out" to that commit and enter a "detached HEAD"
+		   state, meaning, that the "pointer" called HEAD which tells me where I am right now in my
+		   working tree is not where it generally should be, i.e., referring to a named branch(say, master).
+		   Instead the aforementioned pointer is referring to the specified commit. I can now work upon the
+		   checked out commit and make any changes or just inspect the files at that state.
+
+		2. Go to a different version of a particular file; let's say I want to go to a particular version
+		   of a file in my working tree. I can again "checkout" to that particular version(i.e., going to a
+		   particular commit where certain changes were made). This can be done by entering the SHA1 of the
+		   commit in question. 
+
+		3. Go to another branch or create another branch; I would be "checking out" to another tree
+		   in my local repository. One might expect to enter a detached HEAD here as well but in fact
+		   does not. This is because HEAD would point to the tip of the checked out branch, something
+		   which is not a characteristic of a detached HEAD.	
++
+To checkout to a commit, one can either pass the SHA1 of the commit to be checked out or a reference to it w.r.t.
+the HEAD. To checkout to a particular version of a file, one can use `git checkout <SHA1/reference> <file>`.
+To checkout to an already existing branch, one should use `git checkout <branch-name>`. To simultaneously create
+and checkout to a branch, one can use the `-b` option in the aforementioned command.
++
+One can observe how versatile the checkout command is, yet due to simplify things even further, two commands were
+introduced in version 2.23 of Git so as to break down the functionalities of `git checkout` and make it learning
+the command easier for a beginner. The commands being `git switch` and `git restore`.
++
+`git restore` combines the first two features of the checkout as well as functionalities of `git reset` and `git revert`
+at one place so as to improve the functionality of the command.
++
+`git switch` perfoms the third functionality of the `git checkout` command, i.e., manipulating branches(creation).
+
 Hooks
 -----
 
-- 
2.20.1


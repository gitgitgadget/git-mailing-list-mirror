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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F86C2BA2B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7F120732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcQPL0LE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgDMOJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgDMOJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:09:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F069C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:09:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z9so3833822pjd.2
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9AeHGZGW1ORoBvUCyAWHRYDewYGWKc3iNoKA/udv6Y=;
        b=fcQPL0LE0rSsDSZJTNq1mrFb7taPgqPBN+mte8w+QJaKiBJs8AB0TPjNwlzcjlrELh
         S8dXGSv6lCkC8JopNjDZh20WeVG7Je9rNxqx0pB1mldhHw/8DJ9/Uh6Bif/+oj24xUbQ
         zA098/N4HnX5fNe22wSJoK0BjcOBLapdKwzFR5foCip87RSIDQjLQgJWxvGxiXagGcz1
         ZHQagNIJK/dasAlsLDWDU98meBaUGrS08SGJHPg3LUtl8SdszfVyeiaFUrp9plXc8YVt
         8NijehBWpBbRoF1bNPGMeCfz6iNhMYRvjrLr7JSW2n2ie2XAYH8xztozBCy87OwCaaNe
         qDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9AeHGZGW1ORoBvUCyAWHRYDewYGWKc3iNoKA/udv6Y=;
        b=nAYkDu7tBZVrh2+ONmsrSSYDpR+LdSUBQ/NYFLwsa2W7wNf9PNiglAKyVphOXmapQx
         Vfrgqw1DqWMfa5WBC094NtM3Dp22YyuQ1MFLjkgY9dlLvmjWKm9jVYg/iyUDz04lcUXt
         xiQsxC0bdTyFf7mCylun+pqU6tyt587bg4EFio4WOTbHWfe2R8Z3GpZyPcToTGfyrCaP
         y7ZTEno2kpfnGHv4h1DPyCnU8D5H/98XdsJXePlgJy5uTwVjxtJz13n4r8pQPHS9A3MS
         rmVXUIC5NdxrfD6OxIVQwtWRESN4jffuC9cSNPZ9qt/WTMvXCxcpRzrJsoqM1OYgla3O
         lyFw==
X-Gm-Message-State: AGi0PuYHkOVYeBBGEoZJK1FuecXeOFx65KBqjo/ACPgZ7mjdPSL5JFIE
        /Q9qN6w7xCUJ6co7D+lh6U4Gz8/ol4//9Q==
X-Google-Smtp-Source: APiQypKGvnajAVkuWRyPS3KnNBbokodja5YQ1kVRPOwzPUTFxO1+gpQUlV0r8Z1rxBbvTh1rQMoGkw==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr17013109ple.183.1586786975469;
        Mon, 13 Apr 2020 07:09:35 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id l71sm3353233pge.3.2020.04.13.07.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:09:34 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
Date:   Mon, 13 Apr 2020 19:39:18 +0530
Message-Id: <20200413140918.4778-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
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


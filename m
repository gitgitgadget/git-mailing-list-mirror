Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D259EC2BA1E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66AB206B8
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms7Y6XlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDFSMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:12:37 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45998 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDFSMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:12:37 -0400
Received: by mail-pg1-f173.google.com with SMTP id o26so344316pgc.12
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Xi5hvAouAa5XBrLlV0ZeNNOhsRjYdgV4dp//k1MinQ=;
        b=Ms7Y6XlTIZmjTTgmSTerxX95GoQBMmwIp/UMBd1m5On+xizuQQaAMF/EGT0fQ1Hb2I
         o1saZfJH4gxQ5MUnoMHVUajjPczXtZQet/FVQf6HGVj9kFIFWvUlMrHv3AdK3+w52bvC
         br1fA/tjxFIbo6INRmBFotZuBOmzSKp3OnMHLXBl8KJzbixq3TLeZjrijARr0A7Klqqi
         2r7SiOHU33DBFTV5UAns2Y4bwE+id04VT0zpoEIwJLq1DpFC8WH+QP++5WcBWgiGALRz
         6rV1RQgYZzxt8gESEoo3fr1yzIDShyN/TlBKoTlxJRODSZY1/yMSDlKuqNhf+iguhtkk
         l5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Xi5hvAouAa5XBrLlV0ZeNNOhsRjYdgV4dp//k1MinQ=;
        b=ZhGURjFPvt0RdiBkJZ9w/HGtL25/KW6JL370/MUAHVTjA32TavBKc4wZBu/RBILp96
         po2GAZpRY8s+RSAx1sq/edFV0QmLqec++dw95ME+wlfm/y+kEdQUmShKtuajhnBX7n4H
         ClRmJfr2SN3nB3ziq22n5f7B0Pq8C/NOBDbQkx8XuU7XbizxMnN7QuUryy59h7ffD7XO
         a0QFl1NlrQDceuvrnbkJZhfma4v348IVHwWdRA2y+HgygDN2150IDGZOO0ithhfmytNe
         auqki2xVFdpBrZQ4EDafIO92nZnYHWATRGi7xr+emBxLSyROj4HW0WjLuaiAkeJwYkqN
         GOWQ==
X-Gm-Message-State: AGi0Pua4SORGvsrj5Uazd9tDnZaWmy2EZoBXcDqTbhGq4PUIdxFc+mXH
        JfvnuVBwcqmwVSr/gkBKNKpPA7/x/QvlDA==
X-Google-Smtp-Source: APiQypJLSY/p2VEeSmarCDPScCKQxMMdVkiVZP5be3vpNA5NufrrqSC7cpoFlTmVifdv+TmJL8xBig==
X-Received: by 2002:a62:5187:: with SMTP id f129mr742233pfb.144.1586196755650;
        Mon, 06 Apr 2020 11:12:35 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id l22sm246543pjq.15.2020.04.06.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:12:34 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 2/2] gitfaq: append the 'Common Issues' section
Date:   Mon,  6 Apr 2020 23:42:16 +0530
Message-Id: <20200406181216.5340-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
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
 Documentation/gitfaq.txt | 72 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 3ca16b1092..ccc14774ba 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -223,6 +223,78 @@ a file checked into the repository which is a template or set of defaults which
 can then be copied alongside and modified as appropriate. This second, modified
 file is usually ignored to prevent accidentally committing it.
 
+[[rebasing-and-merging]]
+How do I know when to merge or rebase?::
+	Rebasing and merging two entirely different concepts with different utiilites.
+	In Git terms, rebasing means to place changes made in one branch over another branch
+	(called base, hence the term rebase). The commit history of the branch wanting to rebase
+	get placed over the branch on the receiving end and it appears as if those changes took
+	place in the receiving branch itself. Merging, as the name suggests, merges the latest
+	commit of one branch onto the recent branch, making this combination appear as one separate
+	commit.
++
+As an additional tip, one can use interactive rebasing, `git rebase -i`, to perform rebasing
+using a text editor GUI (the value of $GIT_EDITOR). Interactive rebase is an excellent utility
+to perform various functions such as editing commit messages, dropping/squashing commits, editing
+commits, etc. in one package.
+
+[[files-in-.gitignore-are-tracked]]
+I asked Git to ignore various files, yet they show up as changes in my staging area::
+	One uses `.gitignore` to ignore files from getting tracked in the working tree. This ignores
+	the aforementioned files for the whole lifetime of the project unless they area removed from
+	the `.gitignore`. But, `.gitignore` will only ignore the files which were not a part of the
+	repository when they were mentioned in the `.gitignore`. Hence, addition of a file to `.gitignore`
+	after it was added to the working tree will have no effect and Git will keep tracking them.
+	To prevent this from happening, one has to use `git rm --cached <file>` to remove the file
+	from the staging area(i.e. the cache) and not from the repository. 
+
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your changes as well as fetches
+	any new changes(if any). There might be different circumstances in which one might need to change
+	the remote:
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
+	In Git terminology, checking out means updating the current working tree with a another commit or
+	even a separate tree(which would translate to a branch). This means that if I were to:
+		1. Go to another commit, to lets say modify stuff in that commit; I would be "checking out"
+		   to that commit and enter a "detached HEAD" state, meaning, that the "pointer" called HEAD
+		   which tells me where I am right now in my working tree is not where it generally should be,
+		   i.e., the latest commit(or the tip of the branch). I can now work upon the checked out
+		   commit and make any changes or just inspect the files at that state.
+
+		2. Go to another branch or create another branch; I would be "checking out" to another tree
+		   in my local repository. One might expect to enter a detached HEAD here as well but in fact
+		   does not. This is because HEAD would point to the tip of the checked out branch, something
+		   which is not a characteristic of a detached HEAD.
++
+To checkout to a commit, one can either pass the SHA1 of the commit to be checked out or a reference to it wrt
+the HEAD. To checkout to another already existing branch, one should use `git checkout <branch-name>`.
+Also, one can create a new branch as well as checkout to it at the same time using `git checkout -b <new-branch-name>`.
+
 Hooks
 -----
 
-- 
2.20.1


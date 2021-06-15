Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF48C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6276162E
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOQUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQUv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:20:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD19C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:18:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so18974535wrv.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrQyax4pURLNc/y+v1wsru5Ca4Gy7/zuBnXByrtfzBU=;
        b=Rs20eHlU6UYqI1/PxHn0Mr9KMdHN9WyJGzr+gtovPzebJpLax3wCCTF0lhLioiiIUA
         xNCSrVXWd8MVty3xi/CkKGGieku1uBMqslMClYcMOb8XvIepPttRHh/Rsl8I05bhFLYU
         ln4WCZJx+gklDAMVWQa4NEs/BLIemBYkeSzMnw9QR1XTLqniQJXpQADOeKE4g+WBjfvj
         H64yr5avBkj3Xd+WVdbLqpPkmNV+R8tc6/zebYk4dfTL8slAi0pLnbZstEstUEp/XH20
         mkgToSjNvuhNBByGx/WVAMyi6lt/a8oOdwZ22z2oxyeoEANCd6aS4KhLza/ewML2A02m
         onEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrQyax4pURLNc/y+v1wsru5Ca4Gy7/zuBnXByrtfzBU=;
        b=B8gsKfkWK+ljQqLb/iTSgrrxawEWELZQuOT7jnkVxo0QQNCVTyv8fSwHTagZwLXbTi
         ajGIi+9/n9hWKohiwrhzdPBbQzqSLptPJzTk8eEVQiLBQ6v1zJYWRiGOYw/JHX4s/r9X
         yihpOs1NXWtTNpaPLQZkD64NOv0yERRNc1WhbrBoRTYrhQB1dQvgoKDiPOtWF8xgN0L2
         fVzAlqCydF7PRLC458OjM7jnrXiVuRonQvLPsvYwOXSG1Qp+suxrd5ufuNBgNd/hJ5se
         k+iOQsktkQSSvI/VVtT7jpHNjIe53FuIzEMx6nbAQh+IdNKX2p0fld1MGm3oNHhi7dp+
         0rDA==
X-Gm-Message-State: AOAM5300chh4GllZf6WSo5A2kpnvpoviljZpeFQn+B9ekKFWuPHprgps
        UqB8XG03m3AiDH2PN50pf6ljgWt74Ff9Qg==
X-Google-Smtp-Source: ABdhPJwNTYScNR08mzHZbEHLjuoIwfSNhLAH3pyUg0o2mHPpdP1iBwGctpHMj0yp0G6am/i/HcuCAA==
X-Received: by 2002:a05:6000:10e:: with SMTP id o14mr26419499wrx.76.1623773923380;
        Tue, 15 Jun 2021 09:18:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:18:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] gittutorial doc: replace "alice" and "bob" with "you" and "www-data"
Date:   Tue, 15 Jun 2021 18:17:58 +0200
Message-Id: <patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rephrase the tutorial text added in 927a503cd07 (New tutorial,
2006-01-22) to talk about a repository "you" have, and which you'd
like to deploy a local copy of to a "www-data" user, and what it'll
take to pull and push changes between the two.

There's been some parallel work to get rid of gendered language in the
Git documentation[1] which has suggested that examples of "Alice and
Bob" should be excluded, as they're commonly used examples in
technical documentation, especially documentation that deals with
cryptography.

I don't think such an example is problematic per-se, and it certainly
has its place. But if all we're trying to achieve is a generic example
of pushing and pulling between two UIDs on the same (or different)
machine(s) it's needlessly verbose, especially to a reader who's not
in the know about the meaning of the names in crypto documentation (I
daresay that's the vast majority of our users, especially those
reading the tutorial).

To those in the know it's needlessly distracting. I for one tend do
read such documentation half-distracted as I try to remember what the
particular implicit meaning of that cast of characters is (if any). Is
there going to be an "Eve" at some point who'll serve as a stand-in
for the eavesdropper[2]?

In this case the answer is "no"; so let's replace the whole thing with
a less verbose and I think more common example of wanting to deploy a
repository in /home to some other user (the most common of which is
probably this www-data example), and pulling and pushing between the
two.

This commit also fixes the related issue of referring to an
"alice.org" domain, we really should use the RFC 2606 domain names
instead of potentially being a cause of spam to innocent bystander's
E-Mail addresses.

1. http://lore.kernel.org/git/f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com
2. https://en.wikipedia.org/wiki/Alice_and_Bob#Cast_of_characters

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gittutorial.txt | 128 +++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 65 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 59ef5cef1f0..7848888b40b 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -280,79 +280,79 @@ out.
 Using Git for collaboration
 ---------------------------
 
-Suppose that Alice has started a new project with a Git repository in
-/home/alice/project, and that Bob, who has a home directory on the
-same machine, wants to contribute.
+Suppose that you've started a new project with a Git repository in
+/home/you/project, and you'd like another user on the same local
+machine to be able to contribute to it. E.g. a www-data user to serve
+the content up with a webserver.
 
-Bob begins with:
+As the `www-data` user do:
 
 ------------------------------------------------
-bob$ git clone /home/alice/project myrepo
+www-data$ git clone /home/you/project /var/www-data/deployment
 ------------------------------------------------
 
-This creates a new directory "myrepo" containing a clone of Alice's
+This creates a new directory "deployment" containing a clone of your
 repository.  The clone is on an equal footing with the original
 project, possessing its own copy of the original project's history.
 
-Bob then makes some changes and commits them:
+As `www-data` you then makes some changes and commit them:
 
 ------------------------------------------------
 (edit files)
-bob$ git commit -a
+www-data$ git commit -a
 (repeat as necessary)
 ------------------------------------------------
 
-When he's ready, he tells Alice to pull changes from the repository
-at /home/bob/myrepo.  She does this with:
+You can then pull those changes to the checkout in your home directory
+at /home/you/project:
 
 ------------------------------------------------
-alice$ cd /home/alice/project
-alice$ git pull /home/bob/myrepo master
+you$ cd /home/you/project
+you$ git pull /var/www-data/deployment master
 ------------------------------------------------
 
-This merges the changes from Bob's "master" branch into Alice's
-current branch.  If Alice has made her own changes in the meantime,
-then she may need to manually fix any conflicts.
+This merges the changes from the deployment repo's "master" branch into your
+current branch.  If you've made other changes there in the meantime,
+you may need to manually fix any conflicts.
 
 The "pull" command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
 
-Note that in general, Alice would want her local changes committed before
-initiating this "pull".  If Bob's work conflicts with what Alice did since
-their histories forked, Alice will use her working tree and the index to
+In general you'd want changes in your home directory to be committed before
+initiating this "pull".  If your www-data work conflicts with them you
+can use your working tree and the index to
 resolve conflicts, and existing local changes will interfere with the
 conflict resolution process (Git will still perform the fetch but will
-refuse to merge --- Alice will have to get rid of her local changes in
+refuse to merge --- You'll have to get rid of your local changes in
 some way and pull again when this happens).
 
-Alice can peek at what Bob did without merging first, using the "fetch"
-command; this allows Alice to inspect what Bob did, using a special
-symbol "FETCH_HEAD", in order to determine if he has anything worth
+You can look at those changes merging first, using the "fetch"
+command; this allows you to inspect the remote state, using a special
+symbol "FETCH_HEAD", in order to determine if there's anything worth
 pulling, like this:
 
 ------------------------------------------------
-alice$ git fetch /home/bob/myrepo master
-alice$ git log -p HEAD..FETCH_HEAD
+$ git fetch /var/www-data/deployment master
+you$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------
 
-This operation is safe even if Alice has uncommitted local changes.
+This operation is safe even if you've got uncommitted local changes.
 The range notation "HEAD..FETCH_HEAD" means "show everything that is reachable
 from the FETCH_HEAD but exclude anything that is reachable from HEAD".
-Alice already knows everything that leads to her current state (HEAD),
-and reviews what Bob has in his state (FETCH_HEAD) that she has not
-seen with this command.
+You know about everything that leads to your current state (HEAD),
+and can review the state of the www-data repoistory (FETCH_HEAD).
 
-If Alice wants to visualize what Bob did since their histories forked
-she can issue the following command:
+If you want to visualize that difference
+you can issue the following command:
 
 ------------------------------------------------
 $ gitk HEAD..FETCH_HEAD
 ------------------------------------------------
 
-This uses the same two-dot range notation we saw earlier with 'git log'.
+This uses the same two-dot range notation that 'git log' does.
 
-Alice may want to view what both of them did since they forked.
-She can use three-dot form instead of the two-dot form:
+To see commits from both repositories did since they forked.
+use three-dot form instead of the two-dot form:
 
 ------------------------------------------------
 $ gitk HEAD...FETCH_HEAD
@@ -364,11 +364,11 @@ exclude anything that is reachable from both of them".
 Please note that these range notation can be used with both gitk
 and "git log".
 
-After inspecting what Bob did, if there is nothing urgent, Alice may
-decide to continue working without pulling from Bob.  If Bob's history
-does have something Alice would immediately need, Alice may choose to
-stash her work-in-progress first, do a "pull", and then finally unstash
-her work-in-progress on top of the resulting history.
+After inspecting the difference you may
+decide to continue working without pulling from www-data.  If that history
+does have something you need you can
+stash your work-in-progress first, do a "pull", and then finally unstash
+it on top of the resulting history.
 
 When you are working in a small closely knit group, it is not
 unusual to interact with the same repository over and over
@@ -376,79 +376,77 @@ again.  By defining 'remote' repository shorthand, you can make
 it easier:
 
 ------------------------------------------------
-alice$ git remote add bob /home/bob/myrepo
+you$ git remote add deployment /var/www-data/deployment
 ------------------------------------------------
 
-With this, Alice can perform the first part of the "pull" operation
-alone using the 'git fetch' command without merging them with her own
-branch, using:
+With this, you can use the "deployment" name for that remote
+as an argument to 'git pull' or 'git fetch':
 
 -------------------------------------
-alice$ git fetch bob
+you$ git fetch deployment
 -------------------------------------
 
-Unlike the longhand form, when Alice fetches from Bob using a
+Unlike the longhand form, when you fetch using a
 remote repository shorthand set up with 'git remote', what was
 fetched is stored in a remote-tracking branch, in this case
-`bob/master`.  So after this:
+`deployment/master`.  So after this:
 
 -------------------------------------
-alice$ git log -p master..bob/master
+you$ git log -p master..deployment/master
 -------------------------------------
 
-shows a list of all the changes that Bob made since he branched from
-Alice's master branch.
+shows a list of all the changes in deployment/master since it branched
+off from your master branch.
 
-After examining those changes, Alice
-could merge the changes into her master branch:
+After examining those changes, you can merge them into your master branch:
 
 -------------------------------------
-alice$ git merge bob/master
+you$ git merge deployment/master
 -------------------------------------
 
-This `merge` can also be done by 'pulling from her own remote-tracking
-branch', like this:
+This `merge` can also be done by 'pulling from the remote-tracking
+branch':
 
 -------------------------------------
-alice$ git pull . remotes/bob/master
+you$ git pull . remotes/deployment/master
 -------------------------------------
 
 Note that git pull always merges into the current branch,
 regardless of what else is given on the command line.
 
-Later, Bob can update his repo with Alice's latest changes using
+Later, the www-data clone can be updated with your latest changes using
 
 -------------------------------------
-bob$ git pull
+www-data$ git pull
 -------------------------------------
 
-Note that he doesn't need to give the path to Alice's repository;
-when Bob cloned Alice's repository, Git stored the location of her
-repository in the repository configuration, and that location is
+Note that you don't need to supply the path to the original repository;
+when you cloned it the path was stored in
+the repository configuration, and that location is
 used for pulls:
 
 -------------------------------------
-bob$ git config --get remote.origin.url
-/home/alice/project
+www-data$ git config --get remote.origin.url
+/home/you/project
 -------------------------------------
 
 (The complete configuration created by 'git clone' is visible using
 `git config -l`, and the linkgit:git-config[1] man page
 explains the meaning of each option.)
 
-Git also keeps a pristine copy of Alice's master branch under the
+That cloned repository also keeps a copy of its remote master branch under the
 name "origin/master":
 
 -------------------------------------
-bob$ git branch -r
+www-data$ git branch -r
   origin/master
 -------------------------------------
 
-If Bob later decides to work from a different host, he can still
+If you decide to move that deployment clone to a diffeent host, you can still
 perform clones and pulls using the ssh protocol:
 
 -------------------------------------
-bob$ git clone alice.org:/home/alice/project myrepo
+www-data$ git clone you.example.org:/home/you/project myrepo
 -------------------------------------
 
 Alternatively, Git has a native protocol, or can use http;
-- 
2.32.0.555.g0268d380f7b


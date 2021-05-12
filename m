Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDC8C2B9F2
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CEC961166
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbhELRoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347762AbhELR3l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBAEC06138A
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so3440279wmb.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZCsCzRk7QBxJKEuTIHYvP4SktVhXqEjOuJNubhJB0WY=;
        b=pGWZTfhqTHMjTNUUwDl6tlmcYid+OBwq7vIvaunig67OoI3lQ0WHol06LFbj+CvvwT
         nZjoqTh1HP5xPFOms+Zv8ThZlLRup83BHRA96dxCmZDkZvptrPb5zN1J2pE/bLzV4XvI
         lVRhNXobzUPePuEt+/joCS+bA01KUqxB4E1Ik8JjVGJvHnhlJs9gHvRb40n/uboruQMJ
         85opE4nstLCvtdhbiYGzxr5NKI5Fw4nr4bq/bI4qwR0eRGdRlm0sACJ5tzr0x4UJODSx
         3Q6H3UGNLVOdLsuhWDgb0CyJdTSK/xYzHl6hOKDhbZoI7l/EhMkIbR7dDs5+Iu9QV/W3
         0u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZCsCzRk7QBxJKEuTIHYvP4SktVhXqEjOuJNubhJB0WY=;
        b=YupF1KNx+N0aomY6ekHlOBchGJbiz1aj1ejYE91SOfMZg3qFNmqdJVWrBqB++tka6x
         CW1ZHyRzpXnF/XNofRFSxLFZmusqkD4OehFzFVgEGGAyeFozRw1Y97wAu36nDD1MlXOW
         mS30l/OL8omq+dHNBDn6mFN2/RCrj9euOKt2oTuoKyBDjjtq1BuNY1K3g9n4kgbAMHuC
         +wTIVE9j3r17B29ouuLVsCB9q9gK9CQ0G3Ug6I9aYSEcRARUKZ96sm2/5g63QoxyoBht
         0yk5jtLzJnS2N/wmwnM1WXXQ3UPR+Y3/xmnDEoGKdNbH/D4pN2lpj0UpThlBSlnvv+ZU
         Be+g==
X-Gm-Message-State: AOAM531zeUsqU5/eZ2z5f/DPGMfcpaUpDiCeFuOYLObQaJAMfSsuLfEh
        eko6xYvPC59+dpLqg99+rfhsFNTS+u4=
X-Google-Smtp-Source: ABdhPJyVq554MBBH1gO/y0fyRSMYmBuFIofDN2an+I0fwSrOb6/ZIxEkA3sMhiJ8LBFwwtFJBqKnsg==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr3009614wmj.109.1620840510262;
        Wed, 12 May 2021 10:28:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm288714wrw.85.2021.05.12.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:29 -0700 (PDT)
Message-Id: <ae1c9e37b21bc2f1421747dd02a311487f483f0d.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:19 +0000
Subject: [PATCH v5 6/9] dir: avoid unnecessary traversal into ignored
 directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The show_other_directories case in treat_directory() tried to handle
both excludes and untracked files with the same logic, and mishandled
both the excludes and the untracked files in the process, in different
ways.  Split that logic apart, and then focus on the logic for the
excludes; a subsequent commit will address the logic for untracked
files.

For show_other_directories, an excluded directory means that
every path underneath that directory will also be excluded.  Given that
the calling code requested to just show directories when everything
under a directory had the same state (that's what the
"DIR_SHOW_OTHER_DIRECTORIES" flag means), we generally do not need to
traverse into such directories and can just immediately mark them as
ignored (i.e. as path_excluded).  The only reason we cannot just
immediately return path_excluded is the DIR_HIDE_EMPTY_DIRECTORIES flag
and the possibility that the ignored directory is an empty directory.
The code previously treated DIR_SHOW_IGNORED_TOO in most cases as an
exception as well, which was wrong.  It can sometimes reduce the number
of cases where we need to recurse (namely if
DIR_SHOW_IGNORED_TOO_MODE_MATCHING is also set), but should not be able
to increase the number of cases where we need to recurse.  Fix the logic
accordingly.

Some sidenotes about possible confusion with dir.c:

* "ignored" often refers to an untracked ignore", i.e. a file which is
  not tracked which matches one of the ignore/exclusion rules.  But you
  can also have a "tracked ignore", a tracked file that happens to match
  one of the ignore/exclusion rules and which dir.c has to worry about
  since "git ls-files -c -i" is supposed to list them.

* The dir code often uses "ignored" and "excluded" interchangeably,
  which you need to keep in mind while reading the code.

* "exclude" is used multiple ways in the code:

  * As noted above, "exclude" is often a synonym for "ignored".

  * The logic for parsing .gitignore files was re-used in
    .git/info/sparse-checkout, except there it is used to mark paths that
    the user wants to *keep*.  This was mostly addressed by commit
    65edd96aec ("treewide: rename 'exclude' methods to 'pattern'",
    2019-09-03), but every once in a while you'll find a comment about
    "exclude" referring to these patterns that might in fact be in use
    by the sparse-checkout machinery for inclusion rules.

  * The word "EXCLUDE" is also used for pathspec negation, as in
      (pathspec->items[3].magic & PATHSPEC_EXCLUDE)
    Thus if a user had a .gitignore file containing
      *~
      *.log
      !settings.log
    And then ran
      git add -- 'settings.*' ':^settings.log'
    Then :^settings.log is a pathspec negation making settings.log not
    be requested to be added even though all other settings.* files are
    being added.  Also, !settings.log in the gitignore file is a negative
    exclude pattern meaning that settings.log is normally a file we
    want to track even though all other *.log files are ignored.

Sometimes it feels like dir.c needs its own glossary with its many
definitions, including the multiply-defined terms.

Reported-by: Jason Gore <Jason.Gore@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 44 +++++++++++++++++++++++++++++---------------
 t/t7300-clean.sh |  2 +-
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index f6dec5fd4a78..db2ae516a3aa 100644
--- a/dir.c
+++ b/dir.c
@@ -1844,6 +1844,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	}
 
 	/* This is the "show_other_directories" case */
+	assert(dir->flags & DIR_SHOW_OTHER_DIRECTORIES);
 
 	/*
 	 * If we have a pathspec which could match something _below_ this
@@ -1854,27 +1855,40 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC)
 		return path_recurse;
 
+	/* Special cases for where this directory is excluded/ignored */
+	if (excluded) {
+		/*
+		 * In the show_other_directories case, if we're not
+		 * hiding empty directories, there is no need to
+		 * recurse into an ignored directory.
+		 */
+		if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+			return path_excluded;
+
+		/*
+		 * Even if we are hiding empty directories, we can still avoid
+		 * recursing into ignored directories for DIR_SHOW_IGNORED_TOO
+		 * if DIR_SHOW_IGNORED_TOO_MODE_MATCHING is also set.
+		 */
+		if ((dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
+			return path_excluded;
+	}
+
 	/*
-	 * Other than the path_recurse case immediately above, we only need
-	 * to recurse into untracked/ignored directories if either of the
-	 * following bits is set:
+	 * Other than the path_recurse case above, we only need to
+	 * recurse into untracked directories if either of the following
+	 * bits is set:
 	 *   - DIR_SHOW_IGNORED_TOO (because then we need to determine if
 	 *                           there are ignored entries below)
 	 *   - DIR_HIDE_EMPTY_DIRECTORIES (because we have to determine if
 	 *                                 the directory is empty)
 	 */
-	if (!(dir->flags & (DIR_SHOW_IGNORED_TOO | DIR_HIDE_EMPTY_DIRECTORIES)))
-		return excluded ? path_excluded : path_untracked;
-
-	/*
-	 * ...and even if DIR_SHOW_IGNORED_TOO is set, we can still avoid
-	 * recursing into ignored directories if the path is excluded and
-	 * DIR_SHOW_IGNORED_TOO_MODE_MATCHING is also set.
-	 */
-	if (excluded &&
-	    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
-	    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
-		return path_excluded;
+	if (!excluded &&
+	    !(dir->flags & (DIR_SHOW_IGNORED_TOO |
+			    DIR_HIDE_EMPTY_DIRECTORIES))) {
+		return path_untracked;
+	}
 
 	/*
 	 * Even if we don't want to know all the paths under an untracked or
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 34c08c325407..21e48b3ba591 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -746,7 +746,7 @@ test_expect_success 'clean untracked paths by pathspec' '
 	test_must_be_empty actual
 '
 
-test_expect_failure 'avoid traversing into ignored directories' '
+test_expect_success 'avoid traversing into ignored directories' '
 	test_when_finished rm -f output error trace.* &&
 	test_create_repo avoid-traversing-deep-hierarchy &&
 	(
-- 
gitgitgadget


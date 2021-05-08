Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C9FC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF96128C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhEHUAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhEHUAP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD48C06175F
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p14-20020a05600c358eb029015c01f207d7so939864wmq.5
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Agm8GSFLhpXRd8oGL0AcvidOXI9WVRhHPELomlUmqO8=;
        b=kNuKkgwFx5AONZj3zZUWf/+mGF2QAD827BZJzK6uztgkT4BFdogTeOWQoXakZOZnnG
         jFyRaWNadMhVSwIAAZfbhHcjrlDD6bqDKU8oqtV0+FDtzeuiu0A6skmEBLGBv8U+km4y
         RKnpaH+FcrJTuZKd78sSw+2H+p1uNZwY1eEDhOxzxrV0m66Jm3TUIIcVHABUQvziT6/O
         fVtW/oydzXXHUNJW0UuENX3whmsxL1D/kRQcmpUTDTLqfLjmNHVvD7PT3oUto7LQzbUk
         6SfrJwy+sZzw/Q8KBtiUT8u9I1Y/oRFIQKRfxsB8wI/upM2jP4M1xn/bX1f8o4Vzf+/Z
         qSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Agm8GSFLhpXRd8oGL0AcvidOXI9WVRhHPELomlUmqO8=;
        b=omXnfgWiCvf249w5FZQlUD+aa1DvJmmRZvJ/OAPceDYugqCVA5QlGFbiamtHRG2Zxz
         KuGb3c6tlpLygnhCmxaliJKx9Ha1tM4DlBlnuF3G0oShHpIEALRv4UuFP5QvU45CDo6w
         wpCL7UGGh214knSMCso0q4iB9WaTeg9j/yv++3SbvcuyXTD5VHEi87hJi9cLawhGwaD3
         h/ntXhGGRj5m2gVWn6+kUIO+FZEwLtuLd2DuPr8ASxpxGqBt84oM57WkXmsYJ+rJP6fJ
         Cw50sdfZWbOCsUyyyBrfi3AUxRWHP1yAQBXeQwRwXj2wyFejJj5bKeY+sCITTf2AN/EP
         ecGw==
X-Gm-Message-State: AOAM532G2lioiZzVzrBcP+favEsTJQwZ7itLLQ6OZ5sd+czNjlTmmHxF
        Mgzz6noLExWQTb3eWmZUiU9Wm4A2sn4=
X-Google-Smtp-Source: ABdhPJxDNnikwsc78FaHkydx6AnqkQjS8K1G8ddOANATnTe3M+8vU4/u8VplRFi05o04fxR8QjGXwA==
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr26301268wmf.173.1620503951765;
        Sat, 08 May 2021 12:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22sm17632948wmo.12.2021.05.08.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:11 -0700 (PDT)
Message-Id: <66ffc7f02d08f3f07cb3cb2605b113a630f1e127.1620503945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:59:02 +0000
Subject: [PATCH v3 6/8] dir: avoid unnecessary traversal into ignored
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
  which you need to keep in mind while reading the code.  Sadly, though,
  it can get very confusing since ignore rules can have exclusions, as
  in the last of the following .gitignore rules:
      .gitignore
      *~
      *.log
      !settings.log
  In the last entry above, (pathspec->items[3].magic & PATHSPEC_EXCLUDE)
  will be true due the the '!' negating the rule.  Someone might refer
  to this as "excluded".  That means the file 'settings.log' will not
  match, and thus not be ignored.  So we won't return path_excluded for
  it.  So it's an exclude rule that prevents the file from being an
  exclude.  The non-excluded rules are the ones that result in files
  being excludes.  Great fun, eh?

Sometimes it feels like dir.c needs its own glossary with its many
definitions, including the multiply-defined terms.

Reported-by: Jason Gore <Jason.Gore@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c            | 44 +++++++++++++++++++++++++++++---------------
 t/t7300-clean.sh |  2 +-
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index dfb174227b36..3f2cfef2c2bb 100644
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
index 74d395838708..a1d695ee9fe9 100755
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CFC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB12613CE
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhEHUAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhEHUAL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE2C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so12546305wrq.6
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GLEoa5mlUijnycECdUTsetLdx6lnRJ1OuV3/tfiM5i0=;
        b=AYcAziL+sY7O3Jqt/Ts30ChxlOcvAtuSWSIQF1zowwR6RsHQ1QWrX+VAT/vtbc8J2B
         ZvovQOIkeAkrFPxtDMnphr+DEecdi+2DI6gJGeqOGFLxA0wSoO9dMrUbAEztTJCHSAXc
         3UPP5UhXs8MlfVQsP5KVN+4pR6+WKDXWfgfHeut5REaIPRplI8gZh5XcGDtQClM1MyaZ
         aa9wsab3VbsXEiNqXjOCnXrmw65i4IJ5zrvhiHzDF2rqAV5bEz0+bazsvYoQY+rB4z3i
         xcw0DQw0XSYSNPXLmwvXjIkvUV4z1ySBt05OCERqd4eYfpd+rfGLqXSqxST3vuvFcHlI
         GgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GLEoa5mlUijnycECdUTsetLdx6lnRJ1OuV3/tfiM5i0=;
        b=MakSALFdtQfGvXBHojgR8RKMjkeigkHQejOCIVAdoh/40xOELRJeHKNzTWfJGQzgds
         ggPk3nhWauGgoVRXcIJyGxjtRbG03tJLViHm8y7Pzinnr7RHd/zAJUZg5B8lQB5Fd/aH
         4PwPUUZ9AJObkHBvQ8wnx04FXWs3QQelmT7jeZK73g15ZZRJos6839eMKDkP9ywhIuTd
         b0n+P+YC4QIrB+YlC/7LmN30Tbu3yS4jhflNtUobBtfVS7FlEdzD57OG7xYHFY8R3/nb
         RP4Dszyh4kMDHEloTHMI4OZg01hPurU0RMYAz+HvJfUHnKVwTUwhddSpLK7BLumEnCqB
         c3ew==
X-Gm-Message-State: AOAM531PqO5EgEZcapx9JNW7VL+dbNLV6DK/li+w9qTGr3hkw6gsYy0c
        5KmXQBtWsl3ulGpg7FBzBfRNCcWaAY0=
X-Google-Smtp-Source: ABdhPJw0WdFysDUN0asM8o8+REZW9r6oWCQvHg/iGCZOw5kCnKhQNSYY6RDk+XPLwZ7zNHseQenX9A==
X-Received: by 2002:adf:f74d:: with SMTP id z13mr20768135wrp.147.1620503947734;
        Sat, 08 May 2021 12:59:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm21667032wmg.9.2021.05.08.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:07 -0700 (PDT)
Message-Id: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:58:56 +0000
Subject: [PATCH v3 0/8] Directory traversal fixes
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
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset fixes a few directory traversal issues, where fill_directory()
would traverse into directories that it shouldn't and not traverse into
directories that it should (one of which was originally reported on this
list at [1]). And it includes a few cleanups

Changes since v2:

 * Move the RFC patches to the front
 * Deletes all the ugly test code that stole reviewer attention away from
   the rest of the series. :-) The RFC patches being first allow the test to
   be dramatically simplified and rewritten.
 * Included cleanups suggested by Phillip Oakley and Eric Sunshine (the
   cleanups suggested by others are obsolete with the test rewrite).

Patches 1-3 are RFC because

 * (1) I'm not that familiar with trace1 & trace2; I've only used trace2 for
   region_enter() and region_leave() calls before. And I'm unsure if
   removing trace1 counts as a backward compatibility issue or not, though
   the trace2 documentation claims it's meant to replace trace1.
 * (2) The ls-files -i handling to print an error instead of operating as
   before might be considered a backward incompatible change. I want to hear
   others' opinions on that.

Also, if anyone has any ideas about a better place to put the "Some
sidenotes" from the sixth commit message rather than keeping them in a
random commit message, that might be helpful too.

[1] See
https://lore.kernel.org/git/DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com/
or alternatively https://github.com/git-for-windows/git/issues/2732.

Derrick Stolee (1):
  dir: update stale description of treat_directory()

Elijah Newren (7):
  [RFC] dir: convert trace calls to trace2 equivalents
  [RFC] dir: report number of visited directories and paths with trace2
  [RFC] ls-files: error out on -i unless -o or -c are specified
  t7300: add testcase showing unnecessary traversal into ignored
    directory
  t3001, t7300: add testcase showcasing missed directory traversal
  dir: avoid unnecessary traversal into ignored directory
  dir: traverse into untracked directories if they may have ignored
    subfiles

 builtin/ls-files.c                 |   3 +
 dir.c                              | 103 +++++++++------
 dir.h                              |   4 +
 t/t1306-xdg-files.sh               |   2 +-
 t/t3001-ls-files-others-exclude.sh |   5 +
 t/t3003-ls-files-exclude.sh        |   4 +-
 t/t7063-status-untracked-cache.sh  | 194 ++++++++++++++++-------------
 t/t7300-clean.sh                   |  41 ++++++
 t/t7519-status-fsmonitor.sh        |   8 +-
 9 files changed, 238 insertions(+), 126 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1020%2Fnewren%2Fdirectory-traversal-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1020/newren/directory-traversal-fixes-v3
Pull-Request: https://github.com/git/git/pull/1020

Range-diff vs v2:

 7:  3a2394506a53 = 1:  9f1c0d78d739 [RFC] dir: convert trace calls to trace2 equivalents
 8:  fba4d65b78c7 ! 2:  8b511f228af8 [RFC] dir: reported number of visited directories and paths with trace2
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    [RFC] dir: reported number of visited directories and paths with trace2
     +    [RFC] dir: report number of visited directories and paths with trace2
      
     -    Previously, tests that wanted to verify that we don't traverse into a
     -    deep directory hierarchy that is ignored had no easy way to verify and
     -    enforce that behavior.  Record information about the number of
     -    directories and paths we inspect while traversing the directory
     -    hierarchy in read_directory(), and when trace2 is enabled, print these
     -    statistics.
     -
     -    Make use of these statistics in t7300 to simplify (and vastly improve
     -    the performance of) the "avoid traversing into ignored directories"
     -    test.
     +    Provide more statistics in trace2 output that include the number of
     +    directories and total paths visited by the directory traversal logic.
     +    Subsequent patches will take advantage of this to ensure we do not
     +    unnecessarily traverse into ignored directories.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ t/t7063-status-untracked-cache.sh: get_relevant_traces() {
       	    | cut -d "|" -f 9 \
       	    >$OUTPUT_FILE
       }
     -
     - ## t/t7300-clean.sh ##
     -@@ t/t7300-clean.sh: test_expect_success 'clean untracked paths by pathspec' '
     - '
     - 
     - test_expect_success 'avoid traversing into ignored directories' '
     --	test_when_finished rm -f output error &&
     -+	test_when_finished rm -f output error trace.* &&
     - 	test_create_repo avoid-traversing-deep-hierarchy &&
     - 	(
     - 		cd avoid-traversing-deep-hierarchy &&
     - 
     --		>directory-random-file.txt &&
     --		# Put this file under directory400/directory399/.../directory1/
     --		depth=400 &&
     --		for x in $(test_seq 1 $depth); do
     --			mkdir "tmpdirectory$x" &&
     --			mv directory* "tmpdirectory$x" &&
     --			mv "tmpdirectory$x" "directory$x"
     --		done &&
     --
     --		git clean -ffdxn -e directory$depth >../output 2>../error &&
     --
     --		test_must_be_empty ../output &&
     --		# We especially do not want things like
     --		#   "warning: could not open directory "
     --		# appearing in the error output.  It is true that directories
     --		# that are too long cannot be opened, but we should not be
     --		# recursing into those directories anyway since the very first
     --		# level is ignored.
     --		test_must_be_empty ../error &&
     --
     --		# alpine-linux-musl fails to "rm -rf" a directory with such
     --		# a deeply nested hierarchy.  Help it out by deleting the
     --		# leading directories ourselves.  Super slow, but, what else
     --		# can we do?  Without this, we will hit a
     --		#     error: Tests passed but test cleanup failed; aborting
     --		# so do this ugly manual cleanup...
     --		while test ! -f directory-random-file.txt; do
     --			name=$(ls -d directory*) &&
     --			mv $name/* . &&
     --			rmdir $name
     --		done
     -+		mkdir -p untracked/subdir/with/a &&
     -+		>untracked/subdir/with/a/random-file.txt &&
     -+
     -+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
     -+		git clean -ffdxn -e untracked &&
     -+
     -+		grep data.*read_directo.*visited ../trace.output \
     -+			| cut -d "|" -f 9 >../trace.relevant &&
     -+		cat >../trace.expect <<-EOF &&
     -+		 directories-visited:1
     -+		 paths-visited:4
     -+		EOF
     -+		test_cmp ../trace.expect ../trace.relevant
     - 	)
     - '
     - 
 5:  3d8dd00ccd10 = 3:  44a1322c4402 [RFC] ls-files: error out on -i unless -o or -c are specified
 1:  a3bd253fa8e8 ! 4:  dc3d3f247141 t7300: add testcase showing unnecessary traversal into ignored directory
     @@ Metadata
       ## Commit message ##
          t7300: add testcase showing unnecessary traversal into ignored directory
      
     -    PNPM is apparently creating deeply nested (but ignored) directory
     -    structures; traversing them is costly performance-wise, unnecessary, and
     -    in some cases is even throwing warnings/errors because the paths are too
     -    long to handle on various platforms.  Add a testcase that demonstrates
     -    this problem.
     +    The PNPM package manager is apparently creating deeply nested (but
     +    ignored) directory structures; traversing them is costly
     +    performance-wise, unnecessary, and in some cases is even throwing
     +    warnings/errors because the paths are too long to handle on various
     +    platforms.  Add a testcase that checks for such unnecessary directory
     +    traversal.
      
     -    Initial-test-by: Jason Gore <Jason.Gore@microsoft.com>
     -    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t7300-clean.sh ##
     @@ t/t7300-clean.sh: test_expect_success 'clean untracked paths by pathspec' '
       '
       
      +test_expect_failure 'avoid traversing into ignored directories' '
     -+	test_when_finished rm -f output error &&
     ++	test_when_finished rm -f output error trace.* &&
      +	test_create_repo avoid-traversing-deep-hierarchy &&
      +	(
      +		cd avoid-traversing-deep-hierarchy &&
      +
     -+		>directory-random-file.txt &&
     -+		# Put this file under directory400/directory399/.../directory1/
     -+		depth=400 &&
     -+		for x in $(test_seq 1 $depth); do
     -+			mkdir "tmpdirectory$x" &&
     -+			mv directory* "tmpdirectory$x" &&
     -+			mv "tmpdirectory$x" "directory$x"
     -+		done &&
     ++		mkdir -p untracked/subdir/with/a &&
     ++		>untracked/subdir/with/a/random-file.txt &&
      +
     -+		git clean -ffdxn -e directory$depth >../output 2>../error &&
     ++		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
     ++		git clean -ffdxn -e untracked
     ++	) &&
      +
     -+		test_must_be_empty ../output &&
     -+		# We especially do not want things like
     -+		#   "warning: could not open directory "
     -+		# appearing in the error output.  It is true that directories
     -+		# that are too long cannot be opened, but we should not be
     -+		# recursing into those directories anyway since the very first
     -+		# level is ignored.
     -+		test_must_be_empty ../error &&
     -+
     -+		# alpine-linux-musl fails to "rm -rf" a directory with such
     -+		# a deeply nested hierarchy.  Help it out by deleting the
     -+		# leading directories ourselves.  Super slow, but, what else
     -+		# can we do?  Without this, we will hit a
     -+		#     error: Tests passed but test cleanup failed; aborting
     -+		# so do this ugly manual cleanup...
     -+		while test ! -f directory-random-file.txt; do
     -+			name=$(ls -d directory*) &&
     -+			mv $name/* . &&
     -+			rmdir $name
     -+		done
     -+	)
     ++	grep data.*read_directo.*visited trace.output \
     ++		| cut -d "|" -f 9 >trace.relevant &&
     ++	cat >trace.expect <<-EOF &&
     ++	 directories-visited:1
     ++	 paths-visited:4
     ++	EOF
     ++	test_cmp trace.expect trace.relevant
      +'
      +
       test_done
 2:  aa3a41e26eca ! 5:  73b03a1e8e05 t3001, t7300: add testcase showcasing missed directory traversal
     @@ t/t3001-ls-files-others-exclude.sh: EOF
      
       ## t/t7300-clean.sh ##
      @@ t/t7300-clean.sh: test_expect_failure 'avoid traversing into ignored directories' '
     - 	)
     + 	test_cmp trace.expect trace.relevant
       '
       
      +test_expect_failure 'traverse into directories that may have ignored entries' '
 3:  3c3f6111da13 ! 6:  66ffc7f02d08 dir: avoid unnecessary traversal into ignored directory
     @@ t/t7300-clean.sh: test_expect_success 'clean untracked paths by pathspec' '
       
      -test_expect_failure 'avoid traversing into ignored directories' '
      +test_expect_success 'avoid traversing into ignored directories' '
     - 	test_when_finished rm -f output error &&
     + 	test_when_finished rm -f output error trace.* &&
       	test_create_repo avoid-traversing-deep-hierarchy &&
       	(
 4:  fad048339b81 ! 7:  acde436b220e dir: traverse into untracked directories if they may have ignored subfiles
     @@ t/t3001-ls-files-others-exclude.sh: EOF
      
       ## t/t7300-clean.sh ##
      @@ t/t7300-clean.sh: test_expect_success 'avoid traversing into ignored directories' '
     - 	)
     + 	test_cmp trace.expect trace.relevant
       '
       
      -test_expect_failure 'traverse into directories that may have ignored entries' '
 6:  1d825dfdc70b = 8:  57135c357774 dir: update stale description of treat_directory()

-- 
gitgitgadget

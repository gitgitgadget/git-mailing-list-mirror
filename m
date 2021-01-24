Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF1C433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31863227BF
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 10:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAXKzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 05:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbhAXKzM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 05:55:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17444C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a1so9368009wrq.6
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 02:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GmhGRn/8lxhraLv+8JjTcG8CxJQeTUg3eoQMh6tBjYk=;
        b=Y21lfHsBaf7Jvzz4euwUSFe8bbSSDn7NFYNJ61mPqnFjNHUErtN4YyxKpjGLRn13pb
         AJnmzSqf1OwkmmQSzBvf2PAjTTEoBkL3QB36Fa4/IyKFKefn6ofCF0ZQGtYxxJCKRjEd
         9pzeYzMCor3XDO475bUzlcWfPieQyX5fIbJYYk6TmEqKUMbKe2jS3LGdTzi3wvb+pAI7
         96sCBTkbzRAiGNV7y/raiSKmHTuOmsO0QQo3M1D3klw+DgfkJSKNzAoMplUghvUAiY31
         AMYDPF7J8IxxhagemiARuILY/VDVKQu291dma6ibB6PnkFY2BLZgf46nXq2R+2Au4gbU
         AGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GmhGRn/8lxhraLv+8JjTcG8CxJQeTUg3eoQMh6tBjYk=;
        b=Vw1weJ+rWiQPMO+v9hHVfgEft65kZjH9rOW9y1A/TE4q4/CKU5O3gt2KxwbNXgNhLl
         6ySrlB08U8+abRyAXFUVuYa/uIALQcrjzkWyu7R1cK3HwZspjfyCqlGadVEYN99INW0S
         srB6dnCIIv8NwlMZNVhC5qLeY941qLUR0oNRPF9i1eMAX5xwvs3FM4mNAnbh1LqLEmeT
         csKJYmNxbk85dBsXhKnSgRiqdD+fy2vsCA3mYPQWC2OW0/GnZEchnpJh81ryESNvolNa
         CBM6TyxXMFvnnp9JbWMVpK+Z/P/r+OWG4MZcpYChwHWjvgukebzyzZXVxdFWfzz+wKBr
         rz1w==
X-Gm-Message-State: AOAM532AHdVKeW0xwm7U7bmZBGpA6Mq3u5hj3ztLg5nGO7K1Yf9vp2Pn
        iMRxBAGFP4ECUb24g3hY60FMxUoTT1w=
X-Google-Smtp-Source: ABdhPJwGunDBRBAicbUtN0BAiVaINwknFecEx5hHc8/+NtDXOdA+Xf8aRe6oxNEBcF1ouX/4Wb7Sbg==
X-Received: by 2002:a5d:6509:: with SMTP id x9mr17938wru.229.1611485668565;
        Sun, 24 Jan 2021 02:54:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm18060607wrt.8.2021.01.24.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 02:54:27 -0800 (PST)
Message-Id: <pull.832.v7.git.1611485667.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
References: <pull.832.v6.git.1611397210.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 24 Jan 2021 10:54:24 +0000
Subject: [PATCH v7 0/3] builtin/ls-files.c:add git ls-file --dedup option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=E8=83=A1=E5=93=B2=E5=AE=81?= <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=E9=98=BF=E5=BE=B7=E7=83=88?= <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am reading the source code of git ls-files and learned that git ls-files
may have duplicate files name when there are unmerged path in a branch merge
or when different options are used at the same time. Users may fell confuse
when they see these duplicate file names.

As Junio C Hamano said ,it have odd behaviour.

Therefore, we can provide an additional option to git ls-files to delete
those repeated information.

This fixes https://github.com/gitgitgadget/git/issues/198

Thanks!

ZheNing Hu (3):
  ls_files.c: bugfix for --deleted and --modified
  ls_files.c: consolidate two for loops into one
  ls-files.c: add --deduplicate option

 Documentation/git-ls-files.txt |  8 ++++
 builtin/ls-files.c             | 85 ++++++++++++++++++++--------------
 t/t3012-ls-files-dedup.sh      | 66 ++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 35 deletions(-)
 create mode 100755 t/t3012-ls-files-dedup.sh


base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-832%2Fadlternative%2Fls-files-dedup-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-832/adlternative/ls-files-dedup-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/832

Range-diff vs v6:

 1:  fbc38ce9075 ! 1:  8b02367a359 ls_files.c: bugfix for --deleted and --modified
     @@ Commit message
          ie_modified() when lstat() has failed.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     +    [jc: fixed misindented code]
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/ls-files.c ##
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
 2:  3997d390883 ! 2:  f9d5e44d2c0 ls_files.c: consolidate two for loops into one
     @@ Metadata
       ## Commit message ##
          ls_files.c: consolidate two for loops into one
      
     -    Refactor the two for loops into one,skip showing the ce if it
     -    has the same name as the previously shown one, only when doing so
     -    won't lose information.
     +    This will make it easier to show only one entry per filename in the
     +    next step.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     +    [jc: corrected the log message]
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## builtin/ls-files.c ##
      @@ builtin/ls-files.c: static void show_files(struct repository *repo, struct dir_struct *dir)
 3:  07b603fd97c ! 3:  384f77a4c18 ls-files.c: add --deduplicate option
     @@ Metadata
       ## Commit message ##
          ls-files.c: add --deduplicate option
      
     -    In order to provide users a better experience
     -    when viewing information about files in the index
     -    and the working tree, the `--deduplicate` option will suppress
     -    some duplicate name under some conditions.
     +    During a merge conflict, the name of a file may appear multiple
     +    times in "git ls-files" output, once for each stage.  If you use
     +    both `--delete` and `--modify` at the same time, the output may
     +    mention a deleted file twice.
      
     -    In a merge conflict, one file name of "git ls-files" output may
     -    appear multiple times. For example,now there is an unmerged path
     -    `a.c`,`a.c` will appear three times in the output of
     -    "git ls-files".We can use "git ls-files --deduplicate" to output
     -    `a.c` only one time.(unless `--stage` or `--unmerged` is
     -    used to view all the detailed information in the index)
     +    When none of the '-t', '-u', or '-s' options is in use, these
     +    duplicate entries do not add much value to the output.
      
     -    In addition, if you use both `--delete` and `--modify` at
     -    the same time, The `--deduplicate` option
     -    can also suppress file name output.
     -
     -    Additional instructions:
     -    In order to display entries information,`deduplicate` suppresses
     -    the output of duplicate file names, not the output of duplicate
     -    entries information, so under the option of `-t`, `--stage`, `--unmerge`,
     -    `--deduplicate` will have no effect.
     +    Introduce a new '--deduplicate' option to suppress them.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
     +    [jc: extended doc and rewritten commit log]
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## Documentation/git-ls-files.txt ##
      @@ Documentation/git-ls-files.txt: SYNOPSIS
     @@ Documentation/git-ls-files.txt: OPTIONS
       	See OUTPUT below for more information.
       
      +--deduplicate::
     -+	Suppress duplicate entries when there are unmerged paths in index
     -+	or `--deleted` and `--modified` are combined.
     ++	When only filenames are shown, suppress duplicates that may
     ++	come from having multiple stages during a merge, or giving
     ++	`--deleted` and `--modified` option at the same time.
     ++	When any of the `-t`, `--unmerged`, or `--stage` option is
     ++	in use, this option has no effect.
      +
       -x <pattern>::
       --exclude=<pattern>::

-- 
gitgitgadget

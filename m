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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C0C432BE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B2B608FE
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 22:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGXV00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGXV0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 17:26:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA84C061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so6333460wrq.6
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=v7dlWOl0rNKpm4/jGVBeK3DIBtzY4ykrxFcEap/17BM=;
        b=VDEe6qheVJ0rW2KQyPnT4NDvZ4dsN9h20/hkhLNMRioheJke6oS2vqQ599D8G1LOAi
         dmJlejP3NFq5Zg8OE4mPW5Sz9Ndldmm/k4sNEt/GVWjtApasdzcrwV+sM46klu1axfJf
         HegrvzX53fiTSS10jqYC4s/eLpyHMmcdZrVlIh7trv76TSHf2cF00D3VGQIQOyaPVFvM
         A+g6HMfp6PDiB3gIdH/2+6eZ1o9AUho0rJdwN1SgNe7/x/GitsN9ALTgalaqNSjJNViO
         2xoUv8L/N+dFWlXrAIy6fFKzX2iREOvO01jGyah59BzIrY8tDrramR+G0nA7mgPWaw+c
         gOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=v7dlWOl0rNKpm4/jGVBeK3DIBtzY4ykrxFcEap/17BM=;
        b=kL1pn9/blRlnDTaaRdsQhTe0mr2NVOAnZ2R1JzTTdin2TQOUFFhoHjfLQICzQf2VjH
         gvMQNv2JL1Ed/1P2cmapL9mAq1J4PnTZTA/WhIG9RkZWoL+kqypTHxdhdwbVftxOJCGT
         PDZDtpSoib53P4NklUtXrt6RbIyRXmHRrtBYRiwyKIeG/zR8OTJOH9QDVFY44fKbgQbz
         Zk5eF7QBNIIK+nsLJL5J0DugsTxgZr8HhA67+eHCbEHw5T3v2QKex80+w52eliLat5vi
         oqsw/7B94tDRrb1QMKDqW6/IlfBNBB998PW2GVFL3zNUBPn/eZPYF9YKAjXI41KBakof
         q8SA==
X-Gm-Message-State: AOAM532Uc+1Tk7Y1qFxNYaNMBNTqaSkTTtfrfJsDxb98ROEHkQ+zoMTF
        Rq86JRcIMwEQPc6W1kKSgG++qmJtg0M=
X-Google-Smtp-Source: ABdhPJwKQBsSTcsNGxckd781Nlg54hsYJ9sSBN6BqeGZPA1kPzvLNPibZdkRiKbkNrrAKq0BGAUxtQ==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr11422735wrm.220.1627164415596;
        Sat, 24 Jul 2021 15:06:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29sm29504906wms.13.2021.07.24.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 15:06:54 -0700 (PDT)
Message-Id: <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
In-Reply-To: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jul 2021 22:06:48 +0000
Subject: [PATCH v3 0/5] mingw: handle absolute paths in expand_user_path()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git for Windows, we ran with a patch "in production" for quite a while
where paths starting with a slash (i.e. looking like Unix paths, not like
Windows paths) were interpreted as being relative to the runtime prefix,
when expanded via expand_user_path().

This was sent to the Git mailing list as a discussion starter, and it was
pointed out that this is neither portable nor unambiguous.

After the dust settled, I thought about the presented ideas for a while
(quite a while...), ended up with a solution, then adapted it to Junio's
preference: any path starting with %(prefix)/ is expanded. This is ambiguous
because it could be a valid path. But then, it is unlikely, and if someone
really wants to specify such a path, it is easy to slap a ./ in front and
they're done.

Changes since v2:

 * Adjusted to Junio's preference %(...) over <...>. Of course, the
   preferred preference has the disadvantage of actually being allowed in
   Win32 filenames, but then, the workaround is as easy as on non-Windows
   platforms.
 * Since our convention of %(...) interpolation does not involve uppercase
   keywords, I now use a lowercase one.
 * Since this keyword is interpolated to the compiled-in prefix if built
   without runtime prefix support, I dropped the runtime part of the
   keyword.
 * Renamed the expand_user_path() to interpolate_path(), to remove the
   distraction as to the implementation detail which things get to be
   interpolated (because we extend it to interpolate more than just a home
   directory, which might well be unclear from the former name, anyway).
 * Adjusted the code comment above the interpolate_path() to remove a stale
   part, clarify another part, and to extend it to talk about the prefix
   expansion, too.

Changes since v1:

 * Included a test for the RUNTIME_PREFIX that I had meant to send for ages
   already, and based on which...
 * A test case was added to verify that this actually works as intended
 * It is no longer Windows-specific
 * I added some documentation

Johannes Schindelin (5):
  tests: exercise the RUNTIME_PREFIX feature
  expand_user_path(): remove stale part of the comment
  expand_user_path(): clarify the role of the `real_home` parameter
  Use a better name for the function interpolating paths
  interpolate_path(): allow specifying paths relative to the runtime
    prefix

 Documentation/config.txt   |  9 +++++++++
 Makefile                   |  5 +++++
 builtin/credential-cache.c |  2 +-
 builtin/credential-store.c |  2 +-
 builtin/gc.c               |  2 +-
 cache.h                    |  2 +-
 config.c                   |  8 ++++----
 path.c                     | 19 +++++++++++++------
 sequencer.c                |  2 +-
 t/t0060-path-utils.sh      | 26 ++++++++++++++++++++++++++
 10 files changed, 62 insertions(+), 15 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-66%2Fdscho%2Fmingw-expand-absolute-user-path-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-66/dscho/mingw-expand-absolute-user-path-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/66

Range-diff vs v2:

 1:  cc8f09baba9 = 1:  cc8f09baba9 tests: exercise the RUNTIME_PREFIX feature
 -:  ----------- > 2:  a4ff3a461bc expand_user_path(): remove stale part of the comment
 -:  ----------- > 3:  7b79ba66dd0 expand_user_path(): clarify the role of the `real_home` parameter
 -:  ----------- > 4:  19fd9c3c803 Use a better name for the function interpolating paths
 2:  66df56f5db0 ! 5:  d286583082e expand_user_path(): support specifying paths relative to the runtime prefix
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    expand_user_path(): support specifying paths relative to the runtime prefix
     +    interpolate_path(): allow specifying paths relative to the runtime prefix
      
          Ever since Git learned to detect its install location at runtime, there
          was the slightly awkward problem that it was impossible to specify paths
     @@ Commit message
          they are interpreted as absolute paths in the same drive as the current
          directory.
      
     -    After a lengthy discussion, and a way lengthier time to mull over the
     -    problem and its best solution, we decided to introduce support for the
     -    magic sequence `<RUNTIME-PREFIX>/`. If a path starts with this, the
     -    remainder is interpreted as relative to the detected runtime prefix.
     +    After a lengthy discussion, and an even lengthier time to mull over the
     +    problem and its best solution, and then more discussions, we eventually
     +    decided to introduce support for the magic sequence `%(prefix)/`. If a
     +    path starts with this, the remainder is interpreted as relative to the
     +    detected (runtime) prefix. If built without runtime prefix support, Git
     +    will simply interpolate the compiled-in prefix.
      
     -    This solves the problem, but what new problems does it stir up? Here are
     -    the two most obvious ones:
     -
     -    - What if Git was not compiled with support for a runtime prefix?
     -
     -      In that case, we will simply use the compiled-in hard-coded prefix.
     -
     -    - What if a user _wants_ to specify a path starting with the magic
     -      sequence?
     -
     -      In that case, the user will simply need to prefix the magic sequence
     -      with `./` and voilà, the path won't be expanded.
     +    If a user _wants_ to specify a path starting with the magic sequence,
     +    they can prefix the magic sequence with `./` and voilà, the path won't
     +    be expanded.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ Documentation/config.txt: pathname::
       	is expanded to the value of `$HOME`, and `~user/` to the
       	specified user's home directory.
      ++
     -+If a path starts with `<RUNTIME-PREFIX>/`, the remainder is
     -+interpreted as a path relative to Git's "runtime prefix", i.e. relative
     -+to the location where Git itself was installed. For example,
     -+`<RUNTIME-PREFIX>/bin/` refers to the directory in which the Git
     -+executable itself lives. If Git was compiled without runtime prefix
     -+support, the compiled-in prefix will be subsituted instead. In the
     -+unlikely event that a literal path needs to be specified that should
     -+_not_ be expanded, it needs to be prefixed by `./`, like so:
     -+`./<RUNTIME-PREFIX>/bin`.
     ++If a path starts with `%(prefix)/`, the remainder is interpreted as a
     ++path relative to Git's "runtime prefix", i.e. relative to the location
     ++where Git itself was installed. For example, `%(prefix)/bin/` refers to
     ++the directory in which the Git executable itself lives. If Git was
     ++compiled without runtime prefix support, the compiled-in prefix will be
     ++subsituted instead. In the unlikely event that a literal path needs to
     ++be specified that should _not_ be expanded, it needs to be prefixed by
     ++`./`, like so: `./%(prefix)/bin`.
       
       
       Variables
     @@ path.c
       
       static int get_st_mode_bits(const char *path, int *mode)
       {
     -@@ path.c: char *expand_user_path(const char *path, int real_home)
     +@@ path.c: static struct passwd *getpw_str(const char *username, size_t len)
     +  * failure or if path is NULL.
     +  *
     +  * If real_home is true, strbuf_realpath($HOME) is used in the `~/` expansion.
     ++ *
     ++ * If the path starts with `%(prefix)/`, the remainder is interpreted as
     ++ * relative to where Git is installed, and expanded to the absolute path.
     +  */
     + char *interpolate_path(const char *path, int real_home)
     + {
     +@@ path.c: char *interpolate_path(const char *path, int real_home)
       
       	if (path == NULL)
       		goto return_null;
      +
     -+	if (skip_prefix(path, "<RUNTIME-PREFIX>/", &path))
     ++	if (skip_prefix(path, "%(prefix)/", &path))
      +		return system_path(path);
      +
       	if (path[0] == '~') {
     @@ t/t0060-path-utils.sh: test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD 'RUNTI
       	echo HERE >expect &&
      +	test_cmp expect actual'
      +
     -+test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '<RUNTIME-PREFIX>/ works' '
     ++test_expect_success RUNTIME_PREFIX,CAN_EXEC_IN_PWD '%(prefix)/ works' '
      +	mkdir -p pretend/bin &&
      +	cp "$GIT_EXEC_PATH"/git$X pretend/bin/ &&
     -+	git config yes.path "<RUNTIME-PREFIX>/yes" &&
     ++	git config yes.path "%(prefix)/yes" &&
      +	GIT_EXEC_PATH= ./pretend/bin/git config --path yes.path >actual &&
      +	echo "$(pwd)/pretend/yes" >expect &&
       	test_cmp expect actual

-- 
gitgitgadget

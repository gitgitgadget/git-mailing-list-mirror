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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C4C4320A
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7FA60E73
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhH1As0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhH1AsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 20:48:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC14C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:47:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q14so12916136wrp.3
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=dCVpkggRR21X8e2pNKqatpP4fzXr4lrrQHBvtlhSA78=;
        b=ZWmRQjHCqx+77nJXUWhnQCJsr9IZnPHa7c/eNAaX3EgVmOQ0BgV2xYJCN+wr79jLvM
         xtVcZY5lKt7+9SswWuuKZsLN8a61A2WD3dyqW3mCfeLFfVBwAvV7X74hLQMPLfOruLNO
         NUXcbE9N+IANAmNGE9bi25HM2hVTrlz+aF7sLO4uhdOHeHutjkpE0WyJ6u2LSwT8FW9R
         2U9dwvJqsiJZuoNOe2C+Dr7mFMf72xZqJ6Pgb3LJyKkK3/byYoJ/xao7uv3w6IScaK8E
         Co0sKECvXSzx73bcma8B5roMLMNj/WMegM1zjv8YHWejdXebI/Kf0dGsssJEDd3DvD05
         PdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=dCVpkggRR21X8e2pNKqatpP4fzXr4lrrQHBvtlhSA78=;
        b=ccXkMaLfK+gPehggZPzeGGkYaMjmYl+gRTgVniN72pV+HQHcIGONbS3LOAnpMk3bF8
         l1/TAVdKi8PFZPGWUrecruHWe4sQ0ZZ/NUtEclQrOccrcwy16yQ5o5MutDQ81oW958PP
         6uro+47apeCZRdFZ0LEtJS+RvRx1C0Apj/V2T2qLHyk2svSaL0+EpH93tEaUhX8YfZ3I
         rtURqSh8Yok+syonFUuS2iaqAKObBPJaxZt4ONCbgubSMia1ZQyDR3/rG1MoVpKHgcob
         pZag049SlqkpFK1ZjnBLfOf+PjLwhfLqfi8m99lx35jyfYkwDj6rvx4NTRQ3cZ8PA2Be
         77gg==
X-Gm-Message-State: AOAM533DeZp63pJXdUJAoL53NbTudcdon1GnflNI87ZOWgklnsMjLcuE
        Er9vk+zypEkj4pdL8AIoX//gewM64v4=
X-Google-Smtp-Source: ABdhPJzSYY4B+ANKv571TJ87OAUwqXTEmok6ffw9tT71SbK+U6gnklWyOahgBt27Mx2ZMIXmVOufJA==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr13409323wrs.325.1630111654460;
        Fri, 27 Aug 2021 17:47:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm6546970wrb.22.2021.08.27.17.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 17:47:34 -0700 (PDT)
Message-Id: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
References: <pull.1022.git.1629393395.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Aug 2021 00:47:30 +0000
Subject: [PATCH v2 0/3] test-lib-functions.sh: keep user's HOME, TERM and SHELL for 'test_pause' and
 'debug'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

 * added 1/3 as a preliminary step to use TEST_SHELL_PATH in test_pause
   instead of SHELL_PATH, as suggested by Carlos
 * implemented the change in behaviour through optional flags in both
   test_pause and debug. This seemed to be the simplest way to keep the
   current behaviour but also provide a way to improve the UX.

v1: This series proposes two small quality-of-life improvements (in my
opinion) to the 'test_pause' and 'debug' test functions: using the original
values of HOME and TERM (before they are changed by the test framework) and
using SHELL instead of SHELL_PATH.

The later might be too big of a change, but I think it makes sense. We could
add a new GIT_TEST_* to conditionnaly change the behaviour, but I kept it
simple for v1.

Cheers, Philippe.

Philippe Blain (3):
  test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
  test-lib-functions: optionally keep HOME, TERM and SHELL in
    'test_pause'
  test-lib-functions: optionally keep HOME and TERM in 'debug'

 t/test-lib-functions.sh | 91 ++++++++++++++++++++++++++++++++++-------
 t/test-lib.sh           |  6 ++-
 2 files changed, 80 insertions(+), 17 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1022%2Fphil-blain%2Ftest-pause-and-debug-easier-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1022/phil-blain/test-pause-and-debug-easier-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1022

Range-diff vs v1:

 -:  ----------- > 1:  2f566f330e0 test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
 1:  bf916ad98cc ! 2:  00211457ece test-lib-functions: use user's SHELL, HOME and TERM for 'test_pause'
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    test-lib-functions: use user's SHELL, HOME and TERM for 'test_pause'
     +    test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
      
          The 'test_pause' function, which is designed to help interactive
          debugging and exploration of tests, currently inherits the value of HOME
          and TERM set by 'test-lib.sh': HOME="$TRASH_DIRECTORY" and TERM=dumb. It
     -    also invokes the shell defined by SHELL_PATH, which defaults to /bin/sh.
     +    also invokes the shell defined by TEST_SHELL_PATH, which defaults to
     +    /bin/sh (through SHELL_PATH).
      
          Changing the value of HOME means that any customization configured in a
          developers' shell startup files and any Git aliases defined in their
     @@ Commit message
      
          To make the interactive command line experience in the shell invoked by
          'test_pause' more pleasant, save the values of HOME and TERM in
     -    USER_HOME and USER_TERM before changing them in test-lib.sh, and use
     -    these variables to invoke the shell in 'test_pause'. Also, invoke SHELL
     -    instead of SHELL_PATH, so that developer's interactive shell is used.
     +    USER_HOME and USER_TERM before changing them in test-lib.sh, and add
     +    options to 'test_pause' to optionally use these variables to invoke the
     +    shell. Also add an option to invoke SHELL instead of TEST_SHELL_PATH, so
     +    that developer's interactive shell is used.
     +
     +    We use options instead of changing the behaviour unconditionally since
     +    these three variables can break test reproducibility. Moreover, using the
     +    original HOME means tests could overwrite files in a user's home
     +    directory. Be explicit about these caveats in the new 'Usage' section in
     +    test-lib-functions.sh.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_tick () {
     + # Stop execution and start a shell. This is useful for debugging tests.
     + #
       # Be sure to remove all invocations of this command before submitting.
     ++#
     ++# Usage: test_pause [options]
     ++#   -t
     ++#	Use your original TERM instead of test-lib.sh's "dumb".
     ++#	This usually restores color output in the invoked shell.
     ++#	WARNING: this can break test reproducibility.
     ++#   -s
     ++#	Invoke $SHELL instead of $TEST_SHELL_PATH
     ++#	WARNING: this can break test reproducibility.
     ++#   -h
     ++#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
     ++#	This allows you to use your regular shell environment and Git aliases.
     ++#	WARNING: this can break test reproducibility.
     ++#	CAUTION: this can overwrite files in your HOME.
       
       test_pause () {
     --	"$SHELL_PATH" <&6 >&5 2>&7
     -+	TERM="$USER_TERM" HOME="$USER_HOME" "$SHELL" <&6 >&5 2>&7
     +-	"$TEST_SHELL_PATH" <&6 >&5 2>&7
     ++	PAUSE_TERM=$TERM &&
     ++	PAUSE_SHELL=$TEST_SHELL_PATH &&
     ++	PAUSE_HOME=$HOME &&
     ++	while test $# != 0
     ++	do
     ++		case "$1" in
     ++		-t)
     ++			PAUSE_TERM="$USER_TERM"
     ++			;;
     ++		-s)
     ++			PAUSE_SHELL="$SHELL"
     ++			;;
     ++		-h)
     ++			PAUSE_HOME="$USER_HOME"
     ++			;;
     ++		*)
     ++			break
     ++			;;
     ++		esac
     ++		shift
     ++	done &&
     ++	TERM="$PAUSE_TERM" HOME="$PAUSE_HOME" "$PAUSE_SHELL" <&6 >&5 2>&7
       }
       
       # Wrap git with a debugger. Adding this to a command can make it easier
 2:  d51d0db6e25 < -:  ----------- test-lib-functions: use user's TERM and HOME for 'debug'
 -:  ----------- > 3:  1fac9baec1d test-lib-functions: optionally keep HOME and TERM in 'debug'

-- 
gitgitgadget

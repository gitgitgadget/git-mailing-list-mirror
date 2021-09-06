Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B12C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A94860FBF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhIFEVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhIFEVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:21:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E27C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:20:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u16so7720826wrn.5
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=UBDbCT58N3KL2mK5p3RGH3vVS56sgnyQ1TF+iSzrAWA=;
        b=MGykcybS8KlCq5uXO1CFQmgzJVKQBncZ+QsuVxszxPKzg8g0M3b1QIMht2wzSeUwnT
         nEespto7DZXSGvXJl6DLFMVilVX0VqPByyzOcaKwybwOg8Lpm9lzEolayfz/bgBIMxBQ
         yQyJw+v3t2yxOmI21U0vKo2HPvwfGDogcLuTY6GK4JJ86VNBXjzg8ULGsVWMqkoy5NuG
         wEwS0OSwY9Hs8PLJgYn8xA8Bd6ZG2qMhqNQcF9mm02s8+UH86ERzA728eJveKHM1+RCw
         xP50j8lNMCafj9Z6tyizwQDRTVKxD5XaMZhP7CFgIdV2nG1EoDjoQhHV8agJeBOglawz
         2Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=UBDbCT58N3KL2mK5p3RGH3vVS56sgnyQ1TF+iSzrAWA=;
        b=i4uC2+HLuS34zaslWRHAFTgSIr19NauMn3KQcYSaQhjkf4EPsHfXcM+dJ2CHkw/M4X
         RV4b5VqBQfrUoEQ9gs/Eg5PIezweYKf5jT1Q2i+wkVozk4gM5VOLTuCcBivlm5pQ0qoP
         un+09QDuBX3dWT8d9qtQCsrfP+so2+3Q9q5NPg8PEWfIkFCXqq19a75Oi/5RxaCQklhA
         kZDliGgYWkTOAAcTRB/FI1uvC7/jZrH0QyXSBRIzqqNZTP6j0TbwojRPISCZAMGDRzOR
         LJXr2FPcBByoJHPI8I3WelQ+vWsbCnjl5kk2X2fKBGtpCbBXpEMaMwjUo9D8HsQ8SEEf
         dJjw==
X-Gm-Message-State: AOAM531Rd0RconFUKIUjTUu2rxCYQ94jk2XP9HyF9hcRcTG5hSJbRnOM
        uZBRdm4f8SUXhvAdWKd6DTpPEF1rbs0=
X-Google-Smtp-Source: ABdhPJwCHA+634a4zrTVa7G+TF/5E/c2HIRkSrojmH7kGC/E8AznfLOADrDrYjSJv3XT1Eo61wZ7oQ==
X-Received: by 2002:a5d:5107:: with SMTP id s7mr10584171wrt.283.1630902007867;
        Sun, 05 Sep 2021 21:20:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f23sm5148474wmc.3.2021.09.05.21.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:20:07 -0700 (PDT)
Message-Id: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
References: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:20:03 +0000
Subject: [PATCH v4 0/3] test-lib-functions.sh: keep user's HOME, TERM and SHELL for 'test_pause' and
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

Changes since v3:

 * 2/3: improved the wording for the warning and caution as suggested by
   Elijah,, and moved the warning so it relates to the use of test_pause
   itself, not just the new flags, as suggested by Junio. Adapted the commit
   messages accordingly.
 * 3/3: changed the approach: instead of changing HOME, just copy ~/.gdbinit
   and ~/.lldbinit to the test HOME, as suggested by Carlo. This seems safer
   as this way $USER_HOME/.gitconfig does not interfere with the behaviour
   of the command being debugged (as Junio remarked in [1], but for
   test_pause). If other config files are needed for other debuggers, they
   can be added when the need arises.
 * [23]/3: also adapted the synopsys of 'test_pause' and 'debug' in t/README
   for better discoverability of the new features.

[1] https://lore.kernel.org/git/xmqqa6kvoptx.fsf@gitster.g/

v3:

 * Added '-a' flag as suggested by Elijah, equivalent to '-t -s -h' for
   'test_pause' and to '-t -h' for 'debug'

v2:

 * added 1/3 as a preliminary step to use TEST_SHELL_PATH in test_pause
   instead of SHELL_PATH, as suggested by Carlo
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
  test-lib-functions: keep user's debugger config files and TERM in
    'debug'

 t/README                |  11 ++--
 t/test-lib-functions.sh | 113 ++++++++++++++++++++++++++++++++++------
 t/test-lib.sh           |   6 ++-
 3 files changed, 109 insertions(+), 21 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1022%2Fphil-blain%2Ftest-pause-and-debug-easier-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1022/phil-blain/test-pause-and-debug-easier-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1022

Range-diff vs v3:

 1:  2f566f330e0 = 1:  2f566f330e0 test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
 2:  328b5d6e76f ! 2:  a231d560e68 test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
     @@ Commit message
          that developer's interactive shell is used.
      
          We use options instead of changing the behaviour unconditionally since
     -    these three variables can break test reproducibility. Moreover, using the
     -    original HOME means tests could overwrite files in a user's home
     -    directory. Be explicit about these caveats in the new 'Usage' section in
     -    test-lib-functions.sh.
     +    these three variables can slightly change command behaviour. Moreover,
     +    using the original HOME means commands could overwrite files in a user's
     +    home directory. Be explicit about these caveats in the new 'Usage'
     +    section in test-lib-functions.sh.
      
     +    Finally, add '[options]' to the test_pause synopsys in t/README, and
     +    mention that the full list of helper functions and their options can be
     +    found in test-lib-functions.sh.
     +
     +    Helped-by: Elijah Newren <newren@gmail.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     + ## t/README ##
     +@@ t/README: Test harness library
     + --------------------
     + 
     + There are a handful helper functions defined in the test harness
     +-library for your script to use.
     ++library for your script to use. Some of them are listed below;
     ++see test-lib-functions.sh for the full list and their options.
     + 
     +  - test_expect_success [<prereq>] <message> <script>
     + 
     +@@ t/README: library for your script to use.
     + 	EOF
     + 
     + 
     +- - test_pause
     ++ - test_pause [options]
     + 
     + 	This command is useful for writing and debugging tests and must be
     + 	removed before submitting. It halts the execution of the test and
     +
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_tick () {
       # Stop execution and start a shell. This is useful for debugging tests.
       #
       # Be sure to remove all invocations of this command before submitting.
     ++# WARNING: the shell invoked by this helper does not have the same environment
     ++# as the one running the tests (shell variables and functions are not
     ++# available, and the options below further modify the environment). As such,
     ++# commands copied from a test script might behave differently than when
     ++# running the test.
      +#
      +# Usage: test_pause [options]
      +#   -t
      +#	Use your original TERM instead of test-lib.sh's "dumb".
      +#	This usually restores color output in the invoked shell.
     -+#	WARNING: this can break test reproducibility.
      +#   -s
     -+#	Invoke $SHELL instead of $TEST_SHELL_PATH
     -+#	WARNING: this can break test reproducibility.
     ++#	Invoke $SHELL instead of $TEST_SHELL_PATH.
      +#   -h
      +#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
      +#	This allows you to use your regular shell environment and Git aliases.
     -+#	WARNING: this can break test reproducibility.
     -+#	CAUTION: this can overwrite files in your HOME.
     ++#	CAUTION: running commands copied from a test script into the paused shell
     ++#	might result in files in your HOME being overwritten.
      +#   -a
      +#	Shortcut for -t -s -h
       
 3:  4e43bd086b5 ! 3:  a8b12788fa4 test-lib-functions: optionally keep HOME and TERM in 'debug'
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    test-lib-functions: optionally keep HOME and TERM in 'debug'
     +    test-lib-functions: keep user's debugger config files and TERM in 'debug'
      
          The 'debug' function in test-lib-functions.sh is used to invoke a
          debugger at a specific line in a test. It inherits the value of HOME and
     @@ Commit message
          is disabled in the debugger.
      
          To make the debugging experience with 'debug' more pleasant, leverage
     -    the variables USER_HOME and USER_TERM, added in the previous commit, to
     -    optionally set HOME and TERM before invoking the debugger.
     +    the variable USER_HOME, added in the previous commit, to copy a
     +    developer's ~/.gdbinit and ~/.lldbinit to the test HOME. We do not set
     +    HOME to USER_HOME as in 'test_pause' to avoid user configuration in
     +    $USER_HOME/.gitconfig from interfering with the command being debugged.
      
     -    Add the same warnings as for 'test_pause' in the "Usage" section.
     +    Note that we use a while loop and a heredoc to protect against
     +    $USER_HOME containing spaces.
      
     +    Also, add a flag to launch the debugger with the original value of
     +    TERM, and add the same warning as for 'test_pause'.
     +
     +    Helped-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     + ## t/README ##
     +@@ t/README: see test-lib-functions.sh for the full list and their options.
     +    argument.  This is primarily meant for use during the
     +    development of a new test script.
     + 
     +- - debug <git-command>
     ++ - debug [options] <git-command>
     + 
     +    Run a git command inside a debugger. This is primarily meant for
     +-   use when debugging a failing test script.
     ++   use when debugging a failing test script. With '-t', use your
     ++   original TERM instead of test-lib.sh's "dumb", so that your
     ++   debugger interface has colors.
     + 
     +  - test_done
     + 
     +
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_pause () {
       # Wrap git with a debugger. Adding this to a command can make it easier
       # to understand what is going on in a failing test.
       #
     -+# Usage: debug [options] [git command]
     ++# Usage: debug [options] <git command>
      +#   -d <debugger>
      +#   --debugger=<debugger>
      +#	Use <debugger> instead of GDB
      +#   -t
      +#	Use your original TERM instead of test-lib.sh's "dumb".
      +#	This usually restores color output in the debugger.
     -+#	WARNING: this can break test reproducibility.
     -+#   -h
     -+#	Use your original HOME instead of test-lib.sh's "$TRASH_DIRECTORY".
     -+#	This allows your debugger to find its config file in your home.
     -+#	WARNING: this can break test reproducibility.
     -+#	CAUTION: this can overwrite files in your HOME.
     -+#   -a
     -+#	Shortcut for -t -h
     ++#	WARNING: the command being debugged might behave differently than when
     ++#	running the test.
      +#
       # Examples:
       #     debug git checkout master
     @@ t/test-lib-functions.sh: test_pause () {
      -	GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
      +	GIT_DEBUGGER=1 &&
      +	DEBUG_TERM=$TERM &&
     -+	DEBUG_HOME=$HOME &&
      +	while test $# != 0
      +	do
      +		case "$1" in
      +		-t)
      +			DEBUG_TERM="$USER_TERM"
      +			;;
     -+		-h)
     -+			DEBUG_HOME="$USER_HOME"
     -+			;;
     -+		-a)
     -+			DEBUG_TERM="$USER_TERM"
     -+			DEBUG_HOME="$USER_HOME"
     -+			;;
      +		-d)
      +			GIT_DEBUGGER="$2" &&
      +			shift
     @@ t/test-lib-functions.sh: test_pause () {
      +		esac
      +		shift
      +	done &&
     -+	TERM="$DEBUG_TERM" HOME="$DEBUG_HOME" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7
     ++
     ++	dotfiles="
     ++	.gdbinit
     ++	.lldbinit
     ++	"
     ++	while read -r dotfile
     ++	do
     ++		dotfile="$USER_HOME/$dotfile" &&
     ++		test -f "$dotfile" && cp "$dotfile" "$HOME" || :
     ++	done <<-EOF &&
     ++	$dotfiles
     ++	EOF
     ++
     ++	TERM="$DEBUG_TERM" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7 &&
     ++
     ++	while read -r dotfile
     ++	do
     ++		rm -f "$HOME/$dotfile"
     ++	done <<-EOF
     ++	$dotfiles
     ++	EOF
       }
       
       # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]

-- 
gitgitgadget

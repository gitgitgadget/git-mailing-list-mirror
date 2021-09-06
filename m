Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BAC433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5344B61039
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 04:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIFEkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 00:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIFEkH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 00:40:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536B0C061575
        for <git@vger.kernel.org>; Sun,  5 Sep 2021 21:39:03 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso3956922wms.3
        for <git@vger.kernel.org>; Sun, 05 Sep 2021 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MW3tSBFwhsYbOeZIB6QntgjRnTj9zpYEAbpIiSgoGcw=;
        b=h64IBRomz7j8M46O8pQOxiusS9zPeUKznsmzzUnZ/24ZfzZS23czf0eLY73gpb+ZnC
         CSaBr3YKdFC3ol9ROFwChJCDxiWN/87tUO3v7Du3c2CuKXeQWWDzH5JTFiMUBfdmau3w
         Pov0vmWzFWbThgFMwdWWubz0CN96JycV1G8F2u/eg1jBKYo0UcomhNqLUNKja24Q7WFA
         mwOb8fh4pMe7hClXpuMZThl4MCYwqQllvxfWqQx6ml2x3mso9xvDtlONV4ZLwtmsG897
         6feGF/EXhCqr7itnQ0QLyUS2+O7FYtJiieUuXCXlJ6jPlwnxW1lGw7spvn5lKp/hgQAv
         Bypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=MW3tSBFwhsYbOeZIB6QntgjRnTj9zpYEAbpIiSgoGcw=;
        b=k+FHfo1FtlaEjs4ODx1iL4toBSNDeoKCMMK+LQO5inNbmsX5TbjR5JyYGHxXchn+y/
         R5oscY+ZeejyjfhEfOxzSF6NYjUsn3DqRtnDCZCx53zIW3Ge5jQyDzxDRuySXnPk25Oy
         eRaDKPB8pG4re6mspBAgbFMuwk7t0QVAgNDVhQ2Jb/5l0h5NJC6t3jmnYQGaG5khVhsu
         495UQ8C9s4KYYmkiomkmscXQbpehhGxNloqH0m3CSyfqpDHd4JP+D5F5TH8T/pkTtq7A
         bghRUJSFaAGNNSGj5oBXLH2pAcLCbXfSsDcLmVWTkXZP4TSLl8t6qPKSyM4vVT0irLIR
         BKQA==
X-Gm-Message-State: AOAM531nytLEKlQog6w5W8P9n/OIQSl0k/+wAbud3YhtrE7HvM8X3Vij
        u0oa999o9kXLDGtxxVeILcu0qLbOzsM=
X-Google-Smtp-Source: ABdhPJx+RwsckuRWSiUKCMCCRz5SqEwZJ5LV0DHoL42PkzQe1emYUBoo7nGsb6rz4sDWExiXt36jgw==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr9128879wmq.154.1630903141950;
        Sun, 05 Sep 2021 21:39:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q85sm6116574wme.23.2021.09.05.21.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:39:01 -0700 (PDT)
Message-Id: <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
References: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 04:38:57 +0000
Subject: [PATCH v5 0/3] test-lib-functions.sh: keep user's HOME, TERM and SHELL for 'test_pause' and
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

Changes since v4:

 * 3/3: use a for loop instead of while loop + heredoc, it's simpler and the
   need for the later did not match the code.

v4:

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

 t/README                |  11 +++--
 t/test-lib-functions.sh | 107 ++++++++++++++++++++++++++++++++++------
 t/test-lib.sh           |   6 ++-
 3 files changed, 103 insertions(+), 21 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1022%2Fphil-blain%2Ftest-pause-and-debug-easier-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1022/phil-blain/test-pause-and-debug-easier-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1022

Range-diff vs v4:

 1:  2f566f330e0 = 1:  2f566f330e0 test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
 2:  a231d560e68 = 2:  a231d560e68 test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
 3:  a8b12788fa4 ! 3:  ebf92b6b2c3 test-lib-functions: keep user's debugger config files and TERM in 'debug'
     @@ Commit message
          HOME to USER_HOME as in 'test_pause' to avoid user configuration in
          $USER_HOME/.gitconfig from interfering with the command being debugged.
      
     -    Note that we use a while loop and a heredoc to protect against
     -    $USER_HOME containing spaces.
     -
          Also, add a flag to launch the debugger with the original value of
          TERM, and add the same warning as for 'test_pause'.
      
     @@ t/test-lib-functions.sh: test_pause () {
      +		shift
      +	done &&
      +
     -+	dotfiles="
     -+	.gdbinit
     -+	.lldbinit
     -+	"
     -+	while read -r dotfile
     ++	dotfiles=".gdbinit .lldbinit"
     ++
     ++	for dotfile in $dotfiles
      +	do
      +		dotfile="$USER_HOME/$dotfile" &&
      +		test -f "$dotfile" && cp "$dotfile" "$HOME" || :
     -+	done <<-EOF &&
     -+	$dotfiles
     -+	EOF
     ++	done &&
      +
      +	TERM="$DEBUG_TERM" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7 &&
      +
     -+	while read -r dotfile
     ++	for dotfile in $dotfiles
      +	do
      +		rm -f "$HOME/$dotfile"
     -+	done <<-EOF
     -+	$dotfiles
     -+	EOF
     ++	done
       }
       
       # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]

-- 
gitgitgadget

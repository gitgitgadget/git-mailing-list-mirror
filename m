Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55FC63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 04:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AA120809
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 04:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbotdLkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgK3EoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 23:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgK3EoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 23:44:09 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28154C0613CF
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 20:43:29 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id v3so10052935ilo.5
        for <git@vger.kernel.org>; Sun, 29 Nov 2020 20:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTu79IEzcQ1s9Z71uoGNhtmWYOC6m/D6axf9fl5Ei/A=;
        b=IbotdLkOEjV1Z1IesioSMK/yTkVM9puGibQWwznOFy+HqW0w0VPQo9PCBZ0oQjSoeE
         RulRYg7TA/WJQdzXIugBpD+c6JCoN1BexU/uo+XHrz38IzxUKasV4EFKzYjw2xDrchHz
         L+VcabHQPDzPuMAT/sw3ohg72k88HaflJ7lgCBwc/FQZjibcXR1Dk2vQJsk6yLpkBDHX
         xD63s9kf0CyFo7N+zlAEdVgfzZKkeYw9NCT/BCt7NVFMjdnp/wZpIvMb/jNQdY3VF+Hm
         RoSkQhChKIwfN7Sd37IXBhVArv5vMOi1iTptm4dX0liKV1s40vEf2T+7x4Y01cRuUmxC
         vOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qTu79IEzcQ1s9Z71uoGNhtmWYOC6m/D6axf9fl5Ei/A=;
        b=DOTX52E3/7m4Dp6KVR6TyIYWmPHfBJElQR11G8l1MlrJAXpazF8qVfYZPSEPSwn/Le
         ovxaI6FRTsa0ioi56WAJy8rUdo+vOrfdKhikjGs6vf97YzIwCnCrsIQKSwbagtVX/a6o
         tQxhL/Y9Muw3597ocfmiri5LTToSYbJDxTD/3jcsCibsrclcRZzcZwMegYlbXWffFPMk
         lFfO+YbxZjYRSnY4ReNFOWmedGNats8oTtBCPrxSLK6SghWIU+hojCILz50wAZsoBzfU
         POpoRSCb15ARPof5p0VehmLWEyZkrV4Si4ZyDMruYsr6nob8wlTBKw6LKm/rNeUkq4fj
         CGcQ==
X-Gm-Message-State: AOAM532lO/5RxcGJrgm+lAWbxbZx+vKShbKWM/fuHsjn25TwY3exRwHT
        DfoRzPb4t8npAQJ01IKZW1Gk4PvysUc=
X-Google-Smtp-Source: ABdhPJy/ll0YhQut/5b+DwN6ssrDFBowFZn6kF0uUrjYjhKh9ZmxrUMctEC0Fc8dfY0NC4TN7Q7OOQ==
X-Received: by 2002:a92:da87:: with SMTP id u7mr17333401iln.230.1606711407670;
        Sun, 29 Nov 2020 20:43:27 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id h16sm9754285ile.14.2020.11.29.20.43.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 20:43:27 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/2] make macOS `git maintenance` test work on Windows
Date:   Sun, 29 Nov 2020 23:42:22 -0500
Message-Id: <20201130044224.12298-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which makes the macOS-specific test of `git
maintenance start` and `git maintenance stop` work correctly on Windows
(since the tests have been otherwise carefully crafted to work on any
platform even though the `start` and `stop` commands themselves are
necessarily platform-specific).

v2 makes the macOS-specific test in t7900 UID-agnostic, as suggested by
Ævar[2], thus the patch which added `test-tool getuid` has been dropped.

This series is built atop ds/maintenance-part-4.

[1]: https://lore.kernel.org/git/20201127075054.31174-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/87o8jikfh7.fsf@evledraar.gmail.com/

Eric Sunshine (2):
  t7900: fix test failures when invoked individually via --run
  t7900: make macOS-specific test work on Windows

 t/t7900-maintenance.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  9f9b26de93 = 1:  d535669fb9 t7900: fix test failures when invoked individually via --run
2:  07c9e9bd69 < -:  ---------- test-tool: add `getuid` subcommand
3:  01c6a3229d ! 2:  8561d08bcd t7900: make macOS-specific test work on Windows
    @@ Commit message
         invoke platform-specific scheduling utilities, their related tests have
         been carefully crafted -- with one minor exception -- to work correctly
         on any platform, thus improving overall coverage. The exception is that
    -    the macOS-specific test fails on Windows due to unportable use of
    -    `$(id -u)` and comparison involving the value of $HOME which suffers
    -    from the typical shortcoming on that platform in which the same path may
    -    be represented two different ways depending upon its source (i.e. as a
    -    Windows path `C:/git-sdk-64/usr/src/git/foo` versus as a Unix path
    -    `/usr/src/git/foo`). Fix both problems and drop the !MINGW prerequisite
    -    from the macOS-specific test, thus allowing the test to run on Windows,
    -    as well.
    +    the macOS-specific test fails on Windows due to non-portable use of
    +    `$(id -u)` and comparison involving the value of $HOME.
     
    +    In particular, on Windows, the value of getuid() called by the C code is
    +    not guaranteed to be the same as `$(id -u)` invoked by the test. This is
    +    because `git.exe` is a native Windows program, whereas the utility
    +    programs run by the test script mostly utilize the MSYS2 runtime, which
    +    emulates a POSIX-like environment. Since the purpose of the test is to
    +    check that the input to the hook is well-formed, the actual user ID is
    +    immaterial, thus we can work around the problem by making the the test
    +    UID-agnostic.
    +
    +    As for comparison of $HOME, it suffers from the typical shortcoming on
    +    Windows in which the same path may be represented two different ways
    +    depending upon its source (i.e. as a Windows path
    +    `C:/git-sdk-64/usr/src/git/foo` versus as a Unix path
    +    `/usr/src/git/foo`).
    +
    +    Fix both problems and drop the !MINGW prerequisite from the
    +    macOS-specific test, thus allowing the test to run on Windows, as well.
    +
    +    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
     
      ## t/t7900-maintenance.sh ##
    @@ t/t7900-maintenance.sh: test_expect_success 'start preserves existing schedule'
     -test_expect_success !MINGW 'start and stop macOS maintenance' '
     -	uid=$(id -u) &&
     +test_expect_success 'start and stop macOS maintenance' '
    -+	uid=$(test-tool getuid) &&
     +	# ensure $HOME can be compared against hook arguments on all platforms
     +	pfx=$(cd "$HOME" && pwd) &&
      
      	write_script print-args <<-\EOF &&
    - 	echo $* >>args
    +-	echo $* >>args
    ++	echo $* | sed "s:gui/[0-9][0-9]*:gui/[UID]:" >>args
    + 	EOF
    + 
    + 	rm -f args &&
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS maintenance' '
      	rm -f expect &&
      	for frequency in hourly daily weekly
    @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS mainten
     +		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
      		test_xmllint "$PLIST" &&
      		grep schedule=$frequency "$PLIST" &&
    - 		echo "bootout gui/$uid $PLIST" >>expect &&
    +-		echo "bootout gui/$uid $PLIST" >>expect &&
    +-		echo "bootstrap gui/$uid $PLIST" >>expect || return 1
    ++		echo "bootout gui/[UID] $PLIST" >>expect &&
    ++		echo "bootstrap gui/[UID] $PLIST" >>expect || return 1
    + 	done &&
    + 	test_cmp expect args &&
    + 
     @@ t/t7900-maintenance.sh: test_expect_success !MINGW 'start and stop macOS maintenance' '
      	# stop does not unregister the repo
      	git config --get --global maintenance.repo "$(pwd)" &&
      
     -	printf "bootout gui/$uid $HOME/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
    -+	printf "bootout gui/$uid $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
    ++	printf "bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
      		hourly daily weekly >expect &&
      	test_cmp expect args &&
      	ls "$HOME/Library/LaunchAgents" >actual &&
-- 
2.29.2.576.ga3fc446d84


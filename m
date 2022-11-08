Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A408C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiKHOKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiKHOKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:10:51 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DC62D1
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v27so22668309eda.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ha5u80qVYg0W3dzuTMSyyLOFWynzGpBI32HpUFUappk=;
        b=lyTDe5uaqZJK+aGX5HoRLVvJ6nQMCaBOEKDJXY1tLXBySQ7zVAajXySE+nreuZOujX
         KSvD7azBvvslHca/4DDClDBPXc+FE3734teAV+Pmh2TtEyyxBv/Mrnou1DAVAWX3zAWz
         Bld8HjTxAXzSttFSsEFxViL/Kx2mhFRkRgkz6x+zDDHFjCCAoZS06+GQ0+4Ti+HZxZ9r
         R4lAXGv931XK7GmwiIZ2V612iDq4hVvE5RA7AI+ahKfss6dyR4qSjSLnIetQ77e7jm1D
         +K/QIb2UWz9PPZe6+HLEUujMsFNdSQaMArsbPczr0Ui8kUOu1TjvA0W5GmNrIy93CQLH
         2SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ha5u80qVYg0W3dzuTMSyyLOFWynzGpBI32HpUFUappk=;
        b=lCr3lmAjIG/ln4CDUIF3defDYjNH6aajXMMJDvhWe0GmlMFAKGw1SbykRqL3pG2rfn
         tYp6MMPREqhcgJn68MW+4jqiPxlk+Or6TgwuEA516fHerlJ8RjCqMuRg5SkQL6lCJ751
         WA3A9l+A0YlJU1rn76RfjwZnUoXPjzitIrWuUGVhgBgX0wSlPgcfOOgXHO2GjeZGlL80
         tmQyvsFjHiELwE4zVsFBN8KlPJDydJPUOAIgzH8lI94vFIgXJCuLBxB+SOGB/lLeZ7hM
         j+Zerd3doB8hq3RAsgPniDHakYoHHrtsflgqTlb9L8Hp5vFUtLaYhl9woKNjz28qa+yl
         QgVw==
X-Gm-Message-State: ACrzQf3a5q/B7dYOys3+6s1Z8rNcwbQhc6ku6Y7xJ6Wtn37V2FutP7hQ
        tweEshlG/WzlvSCrOS3FzSEEmKO3do1khA==
X-Google-Smtp-Source: AMsMyM6zi1oLi3ieaXBErXrnXOZ5W/CH09L+4QTa/pyJ/Qd5D2KxhDEaNyFccJ1kKEhH6+OpDAjnqA==
X-Received: by 2002:aa7:ca50:0:b0:461:9845:d9d2 with SMTP id j16-20020aa7ca50000000b004619845d9d2mr55354130edt.163.1667916648049;
        Tue, 08 Nov 2022 06:10:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] submodule: tests, cleanup to prepare for built-in
Date:   Tue,  8 Nov 2022 15:10:31 +0100
Message-Id: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in the v1[1] this is a prep series for getting us to a
built-in submodule.c, with a "git rm git-submodule.sh". As noted in
the v1 discussion (e.g. Taylor's [2]) this was mostly ready, but just
needed some final finishing touches.

Changes since v1:

* Noted the history of when "submodule--helper config" was last used,
  per Glen's comment.
* Re-titled the tests htat no longer use the now-removed
  "submodule--helper config", per Glen's comment.
* I removed _() from a string in what's left of "submodule--helper
  config", which is now a test helper. We should not be translating
  test helper strings.
* Fixed a buggy for-loop in the t7422-submodule-output.sh test I'm
  adding.
* Fixed a trivial typo in a comment in that test & in another nearby
  comment.

Passing CI run & branch for this available at[3].

1. https://lore.kernel.org/git/cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com/
2. https://lore.kernel.org/git/Y2Vi95r+RqHPwbw8@nand.local/
3. https://github.com/avar/git/tree/avar/submodule-builtin-final-prep-2

Ævar Arnfjörð Bjarmason (9):
  submodule--helper: move "config" to a test-tool
  submodule tests: add tests for top-level flag output
  submodule--helper: fix  a memory leak in "status"
  submodule tests: test for a "foreach" blind-spot
  submodule.c: refactor recursive block out of absorb function
  submodule API & "absorbgitdirs": remove "----recursive" option
  submodule--helper: remove --prefix from "absorbgitdirs"
  submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
  submodule--helper: use OPT_SUBCOMMAND() API

 builtin/rm.c                           |   3 +-
 builtin/submodule--helper.c            | 146 +++++++--------------
 git-submodule.sh                       |   3 +-
 git.c                                  |   2 +-
 submodule.c                            |  41 +++---
 submodule.h                            |   4 +-
 t/helper/test-submodule.c              |  84 ++++++++++++
 t/t7400-submodule-basic.sh             |  10 ++
 t/t7407-submodule-foreach.sh           |   5 +
 t/t7411-submodule-config.sh            |  36 +++---
 t/t7418-submodule-sparse-gitmodules.sh |   4 +-
 t/t7422-submodule-output.sh            | 170 +++++++++++++++++++++++++
 12 files changed, 358 insertions(+), 150 deletions(-)
 create mode 100755 t/t7422-submodule-output.sh

Range-diff against v1:
 1:  b2649f96715 !  1:  ca8f8b4bf63 submodule--helper: move "config" to a test-tool
    @@ Commit message
         'ab/submodule-helper-prep', 2022-09-13) the "config" sub-command was
         only used by our own tests.
     
    +    It was last used by "git submodule" itself in code that went away with
    +    a6226fd772b (submodule--helper: convert the bulk of cmd_add() to C,
    +    2021-08-10).
    +
         Let's move it over, and while doing so make it easier to reason about
         by splitting up the various uses for it into separate sub-commands, so
         that we don't need to count arguments to see what it does.
     
    +    This also has the advantage that we stop wasting future translator
    +    time on this command, currently the usage information for this
    +    internal-only tool has been translated into several languages. The use
    +    of the "_" function has also been removed from the "please make
    +    sure..." message.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/submodule--helper.c ##
    @@ t/helper/test-submodule.c: static int cmd__submodule_resolve_relative_url(int ar
     +	/* Equivalent to ACTION_SET in builtin/config.c */
     +	if (argc == 3) {
     +		if (!is_writing_gitmodules_ok())
    -+			die(_("please make sure that the .gitmodules file is in the working tree"));
    ++			die("please make sure that the .gitmodules file is in the working tree");
     +
     +		return config_set_in_gitmodules_file_gently(argv[1], argv[2]);
     +	}
    @@ t/helper/test-submodule.c: static int cmd__submodule_resolve_relative_url(int ar
     +
     +	if (argc == 2) {
     +		if (!is_writing_gitmodules_ok())
    -+			die(_("please make sure that the .gitmodules file is in the working tree"));
    ++			die("please make sure that the .gitmodules file is in the working tree");
     +		return config_set_in_gitmodules_file_gently(argv[1], NULL);
     +	}
     +	usage_with_options(usage, options);
    @@ t/helper/test-submodule.c: static int cmd__submodule_resolve_relative_url(int ar
     
      ## t/t7411-submodule-config.sh ##
     @@ t/t7411-submodule-config.sh: test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
    - test_expect_success 'reading submodules config from the working tree with "submodule--helper config"' '
    + 	)
    + '
    + 
    +-test_expect_success 'reading submodules config from the working tree with "submodule--helper config"' '
    ++test_expect_success 'reading submodules config from the working tree' '
      	(cd super &&
      		echo "../submodule" >expect &&
     -		git submodule--helper config submodule.submodule.url >actual &&
    @@ t/t7411-submodule-config.sh: test_expect_success 'error in history in fetchrecur
      	)
      '
      
    - test_expect_success 'unsetting submodules config from the working tree with "submodule--helper config --unset"' '
    +-test_expect_success 'unsetting submodules config from the working tree with "submodule--helper config --unset"' '
    ++test_expect_success 'unsetting submodules config from the working tree' '
      	(cd super &&
     -		git submodule--helper config --unset submodule.submodule.url &&
     -		git submodule--helper config submodule.submodule.url >actual &&
    @@ t/t7411-submodule-config.sh: test_expect_success 'error in history in fetchrecur
      		test_must_be_empty actual
      	)
      '
    -@@ t/t7411-submodule-config.sh: test_expect_success 'unsetting submodules config from the working tree with "sub
    - test_expect_success 'writing submodules config with "submodule--helper config"' '
    + 
    + 
    +-test_expect_success 'writing submodules config with "submodule--helper config"' '
    ++test_expect_success 'writing submodules config' '
      	(cd super &&
      		echo "new_url" >expect &&
     -		git submodule--helper config submodule.submodule.url "new_url" &&
    @@ t/t7411-submodule-config.sh: test_expect_success 'unsetting submodules config fr
      		test_cmp expect actual
      	)
      '
    -@@ t/t7411-submodule-config.sh: test_expect_success 'overwriting unstaged submodules config with "submodule--hel
    + 
    +-test_expect_success 'overwriting unstaged submodules config with "submodule--helper config"' '
    ++test_expect_success 'overwriting unstaged submodules config' '
      	test_when_finished "git -C super checkout .gitmodules" &&
      	(cd super &&
      		echo "newer_url" >expect &&
 2:  cda36b5b6e0 !  2:  5508c27f653 submodule tests: add tests for top-level flag output
    @@ t/t7422-submodule-output.sh (new)
     +	git -C X pull &&
     +	GIT_ALLOW_PROTOCOL=file git -C X submodule update --init &&
     +
    -+	# dirty p
    ++	# dirty
     +	for d in S.D X/S.D
     +	do
    -+		echo dirty >S.D/A.t || return 1
    ++		echo dirty >"$d"/A.t || return 1
     +	done &&
     +
     +	# commit (for --cached)
    @@ t/t7422-submodule-output.sh (new)
     +
     +	for ref in A B C
     +	do
    -+		# Not different with SHA-1 and SHA-256, just (ab)usign
    ++		# Not different with SHA-1 and SHA-256, just (ab)using
     +		# test_oid_cache as a variable bag to avoid using
     +		# $(git rev-parse ...).
     +		oid=$(git rev-parse $ref) &&
 -:  ----------- >  3:  a3529d7f9e0 submodule--helper: fix  a memory leak in "status"
 3:  0ed1fc7fdf8 =  4:  c14cc0e14b8 submodule tests: test for a "foreach" blind-spot
 4:  f7adfbc13ae =  5:  459ea25125b submodule.c: refactor recursive block out of absorb function
 5:  2b8afd73b9b =  6:  322a02c30fc submodule API & "absorbgitdirs": remove "----recursive" option
 6:  91208241070 =  7:  d1f4ac20a4f submodule--helper: remove --prefix from "absorbgitdirs"
 7:  77d4d5a6c09 =  8:  ac9ff05ef68 submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
 8:  105853cd358 =  9:  cccd92a829c submodule--helper: use OPT_SUBCOMMAND() API
-- 
2.38.0.1464.gea6794aacbc


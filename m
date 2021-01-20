Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DAC433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8383D20575
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbhATSk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 13:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391913AbhATS2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 13:28:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C8C0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:28:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so20582356wrt.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=op+wwz6fF9edAqfaBA4dgipSAN648thAbADbreeaI9E=;
        b=RItBeLJL6SiLVd08AsM1zENwf189OX+bZNkQT1xmzrp47ccOj0hq14ywf2E5DODi9V
         XVGP+p/eUyhthpzFMqITOrE6urscfLc10yCS2WzSdSxmTk9NdMXg7Km1OaE5RkiDKVtG
         TBlEUKyDEg0SOtuJcVmnAsBDfdgO9yYt9nV8As6OYXpSZJL/OsfW7RhIRa6qIOETCHwf
         Hu0+wF6HiiH3qsNWODoGY0XY3bTmAIJ1tIAYMTDvxCUJ3u8uHjB/BGk650eGcS6xG/3S
         MSz0MDBsc0UoG2lbegVN9JxEWOysqU7Hx4Lf4wDgbI4PVtB+tWFsV+XIUOE8fzz1xiH0
         dvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=op+wwz6fF9edAqfaBA4dgipSAN648thAbADbreeaI9E=;
        b=HMrI7dI9B3Wy2ILasKbx7+ff0atZ+1asCFwwcX1VqlE6AJSbIgCaXKNxjWn4zRSzFX
         YIgdv/vBPJMggFj6KDJKsEVQ2ADfbrcFFcMKIfXOiUXJzqJ4nn2Re4Ltnah8l0eE5uOm
         7l7E7E0d7Y2fpqYlQrpGrF3I9BQj9mtSR7001Z/ambVfNOYgnW9b8lVny9aC3gpYfFN3
         RsQ2sQLXR8bKVgsZyUyDGnkWL1+cmcIezdmAYTMeiCzrBim0WKJArG1yJsxjLmGoLgCS
         12TBvadzZ/OqMovJ1OkssX9hvHzUkCW8opmvXCzwPUjTStpHv0tRnaXmxT7jewkm/n+X
         IThg==
X-Gm-Message-State: AOAM532Gm5kzveITRsQycJmSznak9LLp5DoBGDuRN+F+/yBWdldY/Kwi
        ivyKbCXvrhjPAnDiamwfDoRZtIL9QOM=
X-Google-Smtp-Source: ABdhPJxqX/bnkBI2LdDDhbefClMREEQ6E2waUn8df7yKnPIMnaDykk8v9Tg5k31LYb72ZAthLHGSQA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr10682193wrt.42.1611167283375;
        Wed, 20 Jan 2021 10:28:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18sm5920942wrp.74.2021.01.20.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:28:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] Remove GIT_TEST_GETTEXT_POISON facility
Date:   Wed, 20 Jan 2021 19:27:56 +0100
Message-Id: <20210120182759.31102-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210111144740.6092-1-avarab@gmail.com>
References: <20210111144740.6092-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A slimmed-down and much easier to read version of v1 which addresses
the feedback on v1.

I'm not removing any test_i18ngrep etc. uses here in this series,
because SZEDER indicated in <20210120152132.GC8396@szeder.dev> that he
likes the test_i18ngrep error reporting. This leaves the door open to
him submitting some related series to add a
s/test_i18ngrep/test_grep/g helper or whatever.

As before I'll leave whether we *should* do this to list consensus. My
reading of it is that Junio/Jeff/SZEDER are leaning more towards this
approach, and Johannes more towards the rot13 alternate.

I certainly don't want to stomp on Johannes's toes with implementing
the rot13 alternative, and if this series were accepted that facilty
would need to start by mostly reverting this, so if the consensus is
leaning towards that approach this series should be dropped. Johannes
doesn't have time to work on that right now, but there's no rush here
either way.

But if it's leaning more towards "meh, let's just nuke it" we can
apply this.

Ævar Arnfjörð Bjarmason (3):
  ci: remove GETTEXT_POISON jobs
  tests: remove support for GIT_TEST_GETTEXT_POISON
  tests: remove uses of GIT_TEST_GETTEXT_POISON=false

 .github/workflows/main.yml            |  2 +-
 .travis.yml                           |  2 +-
 Documentation/MyFirstContribution.txt |  2 +-
 ci/install-dependencies.sh            |  2 +-
 ci/lib.sh                             |  3 +--
 config.c                              |  9 -------
 gettext.c                             | 10 -------
 gettext.h                             |  7 +----
 git-sh-i18n.sh                        | 22 +--------------
 po/README                             | 22 ++-------------
 t/README                              |  6 -----
 t/lib-gettext.sh                      |  2 +-
 t/lib-rebase.sh                       |  1 -
 t/t0017-env-helper.sh                 |  8 +++---
 t/t0205-gettext-poison.sh             | 39 ---------------------------
 t/t1305-config-include.sh             |  4 +--
 t/t3406-rebase-message.sh             |  7 -----
 t/t5411/common-functions.sh           |  5 ++--
 t/t7201-co.sh                         |  2 +-
 t/t9902-completion.sh                 |  1 -
 t/test-lib-functions.sh               | 23 +++++-----------
 t/test-lib.sh                         | 23 +++-------------
 22 files changed, 29 insertions(+), 173 deletions(-)
 delete mode 100755 t/t0205-gettext-poison.sh

Range-diff:
1:  00c5326694 ! 1:  164296c7d6 ci: remove GETTEXT_POISON jobs
    @@ Commit message
         by removing the CI jobs that enable the option.
     
         We cannot just remove the job because the CI is implicitly depending
    -    on the "poison" job being a sort of "default" job. Let's instead add a
    -    "default" job.
    +    on the "poison" job being a sort of "default" job in the sense that
    +    it's the job that was otherwise run with the default compiler, no
    +    other GIT_TEST_* options etc. So let's keep it under the name
    +    "linux-gcc-default".
     
         This means we can remove the initial "make test" from the "linux-gcc"
         job (it does another one after setting a bunch of GIT_TEST_*
2:  ac0f3a78d7 ! 2:  5c6299cde8 tests: remove support for GIT_TEST_GETTEXT_POISON
    @@ Commit message
         we still have a lot of test_i18n, C_LOCALE_OUTPUT
         etc. uses. Subsequent commits will remove those too.
     
    +    The change to t/lib-rebase.sh is a selective revert of the relevant
    +    part of f2d17068fd (i18n: rebase-interactive: mark comments of squash
    +    for translation, 2016-06-17), and the comment in
    +    t/t3406-rebase-message.sh is from c7108bf9ed (i18n: rebase: mark
    +    messages for translation, 2012-07-25).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/MyFirstContribution.txt ##
    @@ po/README: Perl:
     -something in the test suite might still depend on the US English
     -version of the strings, e.g. to grep some error message or other
     -output.
    -+Git's tests are run under LANG=C LC_ALL=C. So the tests do not need be
    -+changed to account for translations as they're added.
    - 
    +-
     -To smoke out issues like these, Git tested with a translation mode that
     -emits gibberish on every call to gettext. To use it run the test suite
     -with it, e.g.:
    -+Testing whether marked strings are used by plumbing
    -+---------------------------------------------------
    - 
    +-
     -    cd t && GIT_TEST_GETTEXT_POISON=true prove -j 9 ./t[0-9]*.sh
    -+It may be useful to use the test suite to smoke out any strings that
    -+shouldn't be translated, because they are used by plumbing or
    -+otherwise part of machine-readable output.
    - 
    +-
     -If tests break with it you should inspect them manually and see if
     -what you're translating is sane, i.e. that you're not translating
    -+This is most useful in cases where e.g. library function might return
    -+a string like _("tree"), and the developer marking strings for
    -+translation wishes to check that they're not inadvertently translating
    - plumbing output.
    - 
    +-plumbing output.
    +-
     -If not you should replace calls to grep with test_i18ngrep, or
     -test_cmp calls with test_i18ncmp. If that's not enough you can skip
     -the whole test by making it depend on the C_LOCALE_OUTPUT
     -prerequisite. See existing test files with this prerequisite for
     -examples.
    -+There used to be a GIT_TEST_GETTEXT_POISON=true test mode to replace
    -+translated strings with gibberish to facilitate this. Maintaining it
    -+and annotating tests appropriately was considered too high of a burden
    -+for its usefulness.
    -+
    -+It's still possible to do a one-off test of where a string might be
    -+used in the tests by simply replacing the "some hardcoded string" with
    -+something like "POISON ME" locally and running the tests, before
    -+finally converting it to _("some hardcoded string").
    ++Git's tests are run under LANG=C LC_ALL=C. So the tests do not need be
    ++changed to account for translations as they're added.
     
      ## t/README ##
     @@ t/README: whether this mode is active, and e.g. skip some tests that are hard to
    @@ t/lib-gettext.sh: else
      	# is_IS.UTF-8 on Solaris and FreeBSD, is_IS.utf8 on Debian
      	is_IS_locale=$(locale -a 2>/dev/null |
     
    + ## t/lib-rebase.sh ##
    +@@ t/lib-rebase.sh: set_fake_editor () {
    + 	*/COMMIT_EDITMSG)
    + 		test -z "$EXPECT_HEADER_COUNT" ||
    + 			test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
    +-			test "# # GETTEXT POISON #" = "$(sed -n '1p' < "$1")" ||
    + 			exit
    + 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
    + 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
    +
      ## t/t0017-env-helper.sh ##
     @@ t/t0017-env-helper.sh: test_expect_success 'env--helper reads config thanks to trace2' '
      	git config -f home/cycle include.path .gitconfig &&
    @@ t/t0205-gettext-poison.sh (deleted)
     -
     -test_done
     
    + ## t/t3406-rebase-message.sh ##
    +@@ t/t3406-rebase-message.sh: test_expect_success 'rebase -n overrides config rebase.stat config' '
    + 	! grep "^ fileX |  *1 +$" diffstat.txt
    + '
    + 
    +-# Output to stderr:
    +-#
    +-#     "Does not point to a valid commit: invalid-ref"
    +-#
    +-# NEEDSWORK: This "grep" is fine in real non-C locales, but
    +-# GIT_TEST_GETTEXT_POISON poisons the refname along with the enclosing
    +-# error message.
    + test_expect_success 'rebase --onto outputs the invalid ref' '
    + 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
    + 	test_i18ngrep "invalid-ref" err
    +
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_cmp_bin () {
      	cmp "$@"
3:  8bdf8d9513 < -:  ---------- tests: remove misc use of test_i18n{cmp,grep}
4:  ead017acc8 < -:  ---------- tests: (almost) remove use of "test_i18ngrep !"
5:  b1113122d0 < -:  ---------- tests: (almost) remove C_LOCALE_OUTPUT prerequisites
6:  9226c3a2df = 3:  7f982be41d tests: remove uses of GIT_TEST_GETTEXT_POISON=false
-- 
2.29.2.222.g5d2a92d10f8


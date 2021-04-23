Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B903C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04DC61450
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbhDWHWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhDWHWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B0C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id x12so51706628ejc.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pfpQKgy/RFqjXHLzkkIMU/3A0jGWJj+64k9w7A2nWOs=;
        b=oDSFaoHflMTS27EDlEzBgSgW0w3drhu46mUDbEEVl/tCLq0lRK8OXwa0N354sKDJ6n
         HeMB8gMF5SFtAT8er+iD+Ixql6yH+rJwE4GpFkUOtotNfBWvJ5EMPRjUOQjHSws60gXB
         gqo65h0qNiulotjQPMkcsYbV6xAmn4pU+OYekILAJ1pqnjgKXVdEjSv8DCxjPJhvb1T5
         AdYZH4Dzd8Lf4NQp9nJ7TyROS5rhyKpsxaVgE4zu+A7U8FERMCZUSiCH+r39MtwWtbCr
         9uBDgn7t1OwHvNPojrhvpo/LQ1W4VE3kKVS6A82jBmIsdYi7zHUeoPNT8wuluazNid1h
         /Q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfpQKgy/RFqjXHLzkkIMU/3A0jGWJj+64k9w7A2nWOs=;
        b=FmqXUZiXlaSuXl8oYigup7sJwmpYBqUYjomkA5PGfF4WEOP/BZz3TOf/et1zS5ZLjh
         gCLEXPHqYfNl40z2lp4dxyj9j9ZB6QQfvJeGIDo8apLkCPI9N0XZmbaDuubN9VA5VMtC
         I5MknkJic/4FzPsrGdkkevn3Pg1Myskxt9E5CH9BKpfRstsGpbAD62u34PiBaZjTiBWr
         X2VarenwVTFlH62dgjppY4AQd2iqmp9ItRZ4pgYKUohox6w2uC0OFtPcdJML2g/w0H/0
         yRrXF0LqMW6KNGG2U54E95EnMAcoVjdys/N2pKqokcuBTvC0lIDhn9bseBZlxrAhjTtw
         ZHDg==
X-Gm-Message-State: AOAM532+ffL3CwG936ikMCNtwcTm5HdJBRo0QZprwhsCz+akjPMFih4C
        8TuNskKxUNzFlj4uraAzaXL7FauaoJs=
X-Google-Smtp-Source: ABdhPJwqI/KW+EqbloBhbc7+O1Qw9S1m3vQlGT4D4i0hgmw1yuVq7VvyHIIrwIG7lOkoz2UnCgFvug==
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr2598981ejz.259.1619162482410;
        Fri, 23 Apr 2021 00:21:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/11] test-lib.sh: new test_commit args, simplification & fixes
Date:   Fri, 23 Apr 2021 09:21:04 +0200
Message-Id: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v4: Only a commit message change/re-wording per
<87v98e1oj7.fsf@evledraar.gmail.com>.

Ævar Arnfjörð Bjarmason (11):
  test-lib: bring $remove_trash out of retirement
  test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
  test-lib-functions: reword "test_commit --append" docs
  test-lib-functions: document test_commit --no-tag
  test-lib functions: add an --annotated option to "test_commit"
  describe tests: convert setup to use test_commit
  test-lib functions: add --printf option to test_commit
  submodule tests: use symbolic-ref --short to discover branch name
  test-lib: reformat argument list in test_create_repo()
  test-lib: do not show advice about init.defaultBranch under --verbose
  test-lib: split up and deprecate test_create_repo()

 t/lib-submodule-update.sh           |  3 +-
 t/t0000-basic.sh                    |  4 --
 t/t1307-config-blob.sh              |  4 +-
 t/t1403-show-ref.sh                 |  6 +--
 t/t2030-unresolve-info.sh           |  3 +-
 t/t4006-diff-mode.sh                |  6 +--
 t/t4030-diff-textconv.sh            |  8 +---
 t/t5406-remote-rejects.sh           |  1 -
 t/t5407-post-rewrite-hook.sh        |  2 -
 t/t5409-colorize-remote-messages.sh |  1 -
 t/t5520-pull.sh                     | 10 +----
 t/t6120-describe.sh                 | 58 +++++++---------------------
 t/test-lib-functions.sh             | 60 ++++++++++++++++++-----------
 t/test-lib.sh                       | 40 +++++++++++--------
 14 files changed, 87 insertions(+), 119 deletions(-)

Range-diff against v4:
 1:  a76ea749bb6 =  1:  75667f98f3a test-lib: bring $remove_trash out of retirement
 2:  de7be7844ea =  2:  55c9413f9cd test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 3:  709bc773fb0 =  3:  361e34654e9 test-lib-functions: reword "test_commit --append" docs
 4:  b67654334e6 =  4:  2db68a4ac7c test-lib-functions: document test_commit --no-tag
 5:  3a166c92063 =  5:  4ceba3d404b test-lib functions: add an --annotated option to "test_commit"
 6:  981fc43ee69 =  6:  589eaf7a078 describe tests: convert setup to use test_commit
 7:  15057cdecfe =  7:  a0fe0640148 test-lib functions: add --printf option to test_commit
 8:  5d437f53ec8 =  8:  7fb8849ce66 submodule tests: use symbolic-ref --short to discover branch name
 9:  9ee13ee71bc =  9:  f67245ba40d test-lib: reformat argument list in test_create_repo()
10:  6ba568df9f4 = 10:  37338c88300 test-lib: do not show advice about init.defaultBranch under --verbose
11:  311a9dba36b ! 11:  7793311e5f1 test-lib: split up and deprecate test_create_repo()
    @@ Commit message
             from "mkdir .git/hooks" changes various tests needed to re-setup
             that directory. Now they no longer do.
     
    -     5. Since we don't need to move the .git/hooks directory we don't need
    -        the subshell here either.
    -
    -        See 0d314ce834 for when the subshell use got introduced for the
    -        convenience of not having to "cd" back and forth while setting up
    -        the hooks.
    +        This makes us implicitly depend on the default hooks being
    +        disabled, which is a good thing. If and when we'd have any
    +        on-by-default hooks (I see no reason we ever would) we'd want to
    +        see the subtle and not so subtle ways that would break the test
    +        suite.
    +
    +     5. We don't need to "cd" to the "$repo" directory at all anymore.
    +
    +        In the code being removed here we both "cd"'d to the repository
    +        before calling "init", and did so in a subshell.
    +
    +        It's not important to do either, so both of those can be
    +        removed. We cd'd because this code grew from test-lib.sh code
    +        where we'd have done so already, see eedf8f97e58 (Abstract
    +        test_create_repo out for use in tests., 2006-02-17), and later
    +        "cd"'d inside a subshell since 0d314ce834d to avoid having to keep
    +        track of an "old pwd" variable to cd back after the setup.
    +
    +        Being in the repository directory made moving the hooks around
    +        easier (we wouldn't have to fully qualify the path). Since we're
    +        not moving the hooks per #4 above we don't need to "cd" for that
    +        reason either.
     
          6. We can drop the --template argument and instead rely on the
             GIT_TEMPLATE_DIR set to the same path earlier in test-lib.sh. See
-- 
2.31.1.737.g98b508eba36


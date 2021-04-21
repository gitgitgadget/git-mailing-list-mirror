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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFEC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FD56142F
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhDUKQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbhDUKP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:15:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9BC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d200-20020a1c1dd10000b02901384767d4a5so963694wmd.3
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGy/Box3bUitAju7QE86CrJDSc0QEFF1BgngfeSslG8=;
        b=A8b9QyY+JD+x3QBjfPOc51ZV47PHT/XEes3DIRIEsRmkakzODIbUeZ9N8/w75OxYcX
         StmprV8+a1yAju+1qIWubedbUZBji68GCHGaCNunB3J9kUS0g0U1PtWt/a5toBw2jTlo
         A3LCOAbJ/mtOqlK33gxxrSW88zdawxW0mVudd5mPT1b50h3sk4GtHQiGpYL7G9YkCNbX
         QWubPU3Rx/JhMPVmrjslKoSshaLWVtb+68RpvLDLVsQQN6Twwl/4em4HNSo4B4F1mdu7
         vNQ9FqHtIogmZJZ5dYidTQGt14lr69nytFr55q49UgsmCmB5zDdJamsbWrvlaRr1tdYo
         sTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGy/Box3bUitAju7QE86CrJDSc0QEFF1BgngfeSslG8=;
        b=mPBuwy7EMkxcIhGxaWb3/UDRCpS7fjH3/2UZAjN9mK6Lt+45g7JIFJC3sLFHCo7pCC
         iD/TaGULm6YO55D1HSPvWHjHskINRleNXUM0PcnqzlRpuhsYZri+F3Dxyu0x5nCqxSnL
         CX9yPcL+f1Ykb4BYVgvQCygAKV4fMUyQcvIAbtpZrgDbqNvrgeoQlhTmZVYI6bXs1VRT
         0Q6cCocSWN7aS0uUvp5j0VL5q+/9SvGiQ2IaRixfwGl+fX+ZluRwtYJoerOcSHZHP2T3
         aApKWNw4Luvq2AwxgDfu/gG93pEM9M9WoGroRU2r+AxqoY5DG/sBWWTS31/PPHkaDHh8
         xo3w==
X-Gm-Message-State: AOAM533rbSs/hjQNweVj4zKpntNwPcexSeC8j/SOG6SiAUJFZ6W/COjZ
        0iGHAZjXZpmweMGMZFY3nwdViFmPkKxAcQ==
X-Google-Smtp-Source: ABdhPJzWX4L8sndQhz/UXMugAlpRFs0mhIUcJSZpjl4WMZ6N6DnqcFNda+XzoyuMwT38vGJIqokxEw==
X-Received: by 2002:a05:600c:d9:: with SMTP id u25mr9192465wmm.151.1619000119302;
        Wed, 21 Apr 2021 03:15:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:18 -0700 (PDT)
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
Subject: [PATCH v4 00/11] test-lib.sh: new test_commit args, simplification & fixes
Date:   Wed, 21 Apr 2021 12:15:05 +0200
Message-Id: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A fast re-roll of this test topic that a few things depend on, per
https://lore.kernel.org/git/xmqqk0ow1plt.fsf@gitster.g/

Changes since v3:

 * Dropped the check-non-portable-shell change

   As noted in
   https://lore.kernel.org/git/87r1j42ffz.fsf@evledraar.gmail.com/ it
   wasn't needed for the rest of this series, so let's not hold it up
   for the discussion of if/how to check "-a" and "-o" invocations of
   "test".

 * Set the remove_trash= variable so we won't leak it from the
   environment.

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

Range-diff against v3:
 1:  a8b483bc77 <  -:  ---------- check-non-portable-shell: check for "test <cond> -a/-o <cond>"
 2:  39759d00ad !  1:  a76ea749bb test-lib: bring $remove_trash out of retirement
    @@ Commit message
         variable, 2017-04-23) and move the decision about whether to skip all
         tests earlier.
     
    +    Let's also fix a bug that was with us since abc5d372ec (Enable
    +    parallel tests, 2008-08-08): we would leak $remove_trash from the
    +    environment. We don't want this to error out, so let's reset it to the
    +    empty string first:
    +
    +         remove_trash=t GIT_SKIP_TESTS=t0001 ./t0001-init.sh
    +
         I tested this with --debug, see 4d0912a206 (test-lib.sh: do not barf
         under --debug at the end of the test, 2017-04-24) for a bug we don't
         want to re-introduce.
    @@ t/test-lib.sh: then
      fi
      
     +# Are we running this test at all?
    ++remove_trash=
     +this_test=${0##*/}
     +this_test=${this_test%%-*}
     +if match_pattern_list "$this_test" $GIT_SKIP_TESTS
 3:  d669ce3196 =  2:  de7be7844e test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 4:  9313d35bf8 =  3:  709bc773fb test-lib-functions: reword "test_commit --append" docs
 5:  c916d648e4 =  4:  b67654334e test-lib-functions: document test_commit --no-tag
 6:  9b6bf65ce1 =  5:  3a166c9206 test-lib functions: add an --annotated option to "test_commit"
 7:  683b3ba3dd =  6:  981fc43ee6 describe tests: convert setup to use test_commit
 8:  dc0a863db7 =  7:  15057cdecf test-lib functions: add --printf option to test_commit
 9:  90bf55d2d4 =  8:  5d437f53ec submodule tests: use symbolic-ref --short to discover branch name
10:  e0a1e2fd52 =  9:  9ee13ee71b test-lib: reformat argument list in test_create_repo()
11:  cedf5d383b = 10:  6ba568df9f test-lib: do not show advice about init.defaultBranch under --verbose
12:  0dc0da9490 = 11:  311a9dba36 test-lib: split up and deprecate test_create_repo()
-- 
2.31.1.721.gbeb6a21927


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BCC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbiBPABV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBPABT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C7CA70D
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i14so633377wrc.10
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4xinuDeLit5puR27/XM8JydghcY/G0i3Y5TsZ1lQM8=;
        b=hcp9tpOIFoVcSn6EYhzR/nFco7bP0rIG16o9a2GZNhrGBrJ5Nx/9n6T36v/lJ5T383
         kvDZ7UtTKKxQyDUIfdwV8GrdUAb2uLwDh7FSLYgwobnSe/WJ1bg6qN8KaDV4fr/qR3ME
         9MEBo+Dk73RPj/qgN+X11djStW2Q30VLDyCv1nhAlbgbPqxsu3v5Kmo3Xb7slROG/Kmu
         QcI/Z9Dd5uKcKBigk9plF744IZkTjewOkCA5rY7nbukrRTQMZjpkqG9z/YS2UjdZNAIR
         HCrhHbJcIG2H2mMTdMMIfw+R8domt7tQ8aYca+7NVz1j3WL+Qm7fPzNEdGGjj6prSYLX
         qV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4xinuDeLit5puR27/XM8JydghcY/G0i3Y5TsZ1lQM8=;
        b=vHZQ16JUZASQpuoAKn7mPqL/Ju4OAnzLXR7+SHRWq479jP0ArAfRdSz8cQiJ/knu3F
         godqew2lvM/8Q4iw4c/w8g8nROtlvh0gVgldz4M4BciIOESiDu7B1K5PSHe1BWemkCAK
         UMWuyR1xo5RjHyhoCRP1sj7FgWG+4KowDMR/2sBltTIN0AKN2TznKfe9DiSzu+9Gwfu7
         b+TQJXoq4nBzBv7gZA2ZIe9QSyNfmKDFSPBhGD4Bhis+5SE8cJfBCGkpq09w52AWF6jO
         KHTEGcCAi/1f8xCwMcSohP5B9NsXn2ftmSorVFj3fFZNRcaMq9yg4GSF1l8ynFIO9eXe
         rQIg==
X-Gm-Message-State: AOAM533XsYBh+X3H/ism0FRtWOVq1tGt5QkB75wTYep0YYH3yPpk1B57
        cAAG8Mt1ljvMb4JABVRlWZraOwGYwuE=
X-Google-Smtp-Source: ABdhPJyhQtdy4w5DfR5oQVV0V1p6TBvljrogNsHkVhxz3v1DDGo36kvcjHs/AiCiHCdSYEK/zPiLPQ==
X-Received: by 2002:adf:f001:0:b0:1e4:b7b1:87c1 with SMTP id j1-20020adff001000000b001e4b7b187c1mr310195wro.238.1644969666769;
        Tue, 15 Feb 2022 16:01:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 00/10] grep: simplify & delete "init" & "config" code
Date:   Wed, 16 Feb 2022 01:00:29 +0100
Message-Id: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes using the grep.[ch] API easier, by having it follow
the usual pattern of being initialized with:

    defaults -> config -> command-line

This is to make some follow-up work easier, this is a net code
deletion if we exclude newly added tests.

Changes since v9:

  * A new 3/10 and 4/10 hopefully address the comments about the test
    code. I ended up just adding a helper to reduce the existing and
    new verbosity of the tests, which should make it easier to reason
    about them.

Ævar Arnfjörð Bjarmason (10):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: create a helper function for "BRE" or "ERE"
  grep tests: add missing "grep.patternType" config tests
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep.h: make "grep_opt.pattern_type_option" use its enum
  grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
  grep: simplify config parsing and option parsing

 builtin/grep.c    |  27 +++----
 builtin/log.c     |  13 +++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 113 ++++------------------------
 grep.h            |  31 ++++++--
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 ++++++
 t/t7810-grep.sh   | 186 ++++++++++++++++++++++++++--------------------
 9 files changed, 195 insertions(+), 206 deletions(-)

Range-diff against v10:
 1:  184f7e0c5bd =  1:  67af9123727 grep.h: remove unused "regex_t regexp" from grep_opt
 2:  ac397cc6a18 =  2:  b275d23f0a8 log tests: check if grep_config() is called by "log"-like cmds
 3:  3464c76cfd7 <  -:  ----------- grep tests: add missing "grep.patternType" config tests
 -:  ----------- >  3:  b0f91bf7e4a grep tests: create a helper function for "BRE" or "ERE"
 -:  ----------- >  4:  9906edd4f58 grep tests: add missing "grep.patternType" config tests
 4:  c6ada96298a =  5:  7389f767388 built-ins: trust the "prefix" from run_builtin()
 5:  1f09de53e07 =  6:  38bfa0ed5f9 grep.c: don't pass along NULL callback value
 6:  ce646154538 =  7:  a4c1ee91dc9 grep API: call grep_config() after grep_init()
 7:  6446b4f0f33 =  8:  fa0da3a9fba grep.h: make "grep_opt.pattern_type_option" use its enum
 8:  df8ba5aba68 =  9:  243ceccc1ad grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
 9:  ccbdfa48315 = 10:  38bc5dc9461 grep: simplify config parsing and option parsing
-- 
2.35.1.1028.g9479bb34b83


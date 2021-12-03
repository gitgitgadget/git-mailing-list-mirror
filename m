Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282EFC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 10:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379823AbhLCKXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379807AbhLCKXb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 05:23:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24EAC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 02:20:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1862374wmb.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 02:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRnWvwQ14fiU38YrZ/GFPu+ukqY9W4r81RTiB62wP0Q=;
        b=EFCHcmQAVDXp2Uj2HXk3yUPoO1emCZj5h4Xm7ouBlJijq2V3kAzz/lYoeZsSqYhQ6M
         UGjz7rYqPOPRN9Aqr1eiaV0XYYfvIEkOZVz1IlEBBGbP+jOE2s7njDTb0rm5J88ZWyto
         h0KE0Oa5uZpezH9l1tUny4RnAWT7vD6ZB88fPctNOcCPV9d6k02Tx6Fy2UvRWeO8zPSF
         mQrg3mV+OoEEXxVj8Pb3hh+z/QMQXOhnUb7OhWdsl58WOk8ZO+TbDEvuTmhpC8e2Jec7
         PzbV4xm4v6wyzvY9R9+F2jaEGXYPG3aDZCDBBNEeWWbznJz6+mf6tp9YT7RZcEf8pg05
         JlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRnWvwQ14fiU38YrZ/GFPu+ukqY9W4r81RTiB62wP0Q=;
        b=tce6HfjvFDbpdhuYAJmsoi1bCbbP//9euDo+dwQ0h7EPMCJ8O5Z4I4V8zGqFXKulE2
         XyAxMEv/MxKDDks8fHL12t/t7mVXxttRZ03WCkNn5bJp7nZpX8HDqZrGAIYtbWrm3itD
         81ByeO9GMZKyqARzQJwJ4K808x0yLyJmhdZObQu0ui15kUzov67tt6LJFYjlZUIS9NR/
         mCh2bAv67bK1Sh2sGLmlQLCvgG+gIAH8f42c671+JjNELsBN5FHTit/ucLPyFws1Ll+h
         frLKIjqeLph+Hh2AsALvHX6LLScFROelxI8o3BsEDVNNrqaycCeTLmCB1q+GxWIg4DeH
         PiwA==
X-Gm-Message-State: AOAM53168CekXWuTJ3SOWNpnjlt9tZsK3LD3V80o1cNTjypssYX1SKn7
        G3WJrLMKhqPaa/JARqTbu1mtYVKPUAcp/Q==
X-Google-Smtp-Source: ABdhPJyGQ3hRvhP59dX1Qt3mjzY0W80XeswZae138t3WeUqcUhIgsVTTPj9+O9iIpZIg0eSZV2vL5A==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr13857865wms.180.1638526806158;
        Fri, 03 Dec 2021 02:20:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r8sm2798448wrz.43.2021.12.03.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:20:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/7] grep: simplify & delete "init" & "config" code
Date:   Fri,  3 Dec 2021 11:19:47 +0100
Message-Id: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.875.gb925cffed1e
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simplification and code deletion of the overly complex setup for the
grep API, no behavior changes. For v3 see:
https://lore.kernel.org/git/cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com/

As Junio notes in
https://lore.kernel.org/git/xmqqbl22634q.fsf@gitster.g/ my previous
3/7 had entirely the wrong commit message for the change it was
making, i.e. the code itself was correct, but I somehow got things
reversed in my head when writing the explanation.

That's fixed here, and for good measure I added another related test
to the same commit for the same existing behavior.

Ævar Arnfjörð Bjarmason (7):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: add missing "grep.patternType" config test
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep: simplify config parsing and option parsing

 builtin/grep.c    |  27 +++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 124 ++++++++--------------------------------------
 grep.h            |  33 ++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 +++++++++
 t/t7810-grep.sh   |  19 +++++++
 9 files changed, 116 insertions(+), 131 deletions(-)

Range-diff against v3:
1:  71ff51cb3c9 = 1:  d7d232b2b52 grep.h: remove unused "regex_t regexp" from grep_opt
2:  ec8e42ced1a = 2:  f853d669682 log tests: check if grep_config() is called by "log"-like cmds
3:  fcad1b1664b ! 3:  a97b7de3a3c grep tests: add missing "grep.patternType" config test
    @@ Commit message
     
         Extend the grep tests to assert that setting
         "grep.patternType=extended" followed by "grep.patternType=default"
    -    will behave as if "--extended-regexp" was provided, and not as
    -    "--basic-regexp". In a subsequent commit we'll need to treat
    +    will behave as if "--basic-regexp" was provided, and not as
    +    "--extended-regexp". In a subsequent commit we'll need to treat
         "grep.patternType=default" as a special-case, but let's make sure we
    -    don't ignore it if "grep.patternType" was set to a non-"default" value
    -    before.
    +    ignore it if it's being set to "default" following an earlier
    +    non-"default" "grep.patternType" setting.
    +
    +    Let's also test what happens when we have a sequence of "extended"
    +    followed by "default" and "fixed". In that case the "fixed" should
    +    prevail.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t7810-grep.sh: do
     +			grep "a+b*c" $H ab >actual &&
     +		test_cmp expected actual
     +	'
    ++
    ++	test_expect_success "grep $L with grep.patternType=[extended -> default -> fixed]" '
    ++		echo "${HC}ab:a+b*c" >expected &&
    ++		git \
    ++			-c grep.patternType=extended \
    ++			-c grep.patternType=default \
    ++			-c grep.patternType=fixed \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
     +
      	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
      		echo "${HC}ab:abc" >expected &&
4:  854ffe8d0b9 = 4:  f7d995a5a80 built-ins: trust the "prefix" from run_builtin()
5:  2536eae2c32 = 5:  ab1685f0dad grep.c: don't pass along NULL callback value
6:  4e1be7c165b = 6:  8ffa22df8c7 grep API: call grep_config() after grep_init()
7:  f40ab932cb1 = 7:  efbd1c50b43 grep: simplify config parsing and option parsing
-- 
2.34.1.875.gb925cffed1e


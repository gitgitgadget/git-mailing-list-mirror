Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421A6C433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhLZWh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhLZWh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:37:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25524C061401
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso7564140wmc.3
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOFUJImd4rkzTNFYkpTICtlLpq0jJSHqbuG0ikuRAgw=;
        b=OWCIMBMUwuQycFl4vTUYIsui91gNXgqpvE3reXJrmYCzZgaywSK3yz3/Eetsmscoav
         Z7l2EYm26/7VEpxyBJZa1t/UBs6X+6A+O36jICJPshm+QlvK16IjfwhblxaOwyRcrGZt
         6PmCMFKsOlbn6t4NfPMdQ9Bxuq/uCr2lCJ7EItsFKueDXjm2hWUs8LEpe73ZYux4U2Kd
         E3c3M5eB2ENYM6wp7zu/EZQo1bYbWArWq4dh57rWcQv6WASZoU9qeZFp9lrH4gs6QHg8
         +dsad1Jb2rjLJkJql0IIvwu+tmqTDhpHEyzLzoJHFCzldS8AJoTnVoeLQzc4F7HV3HWN
         1x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOFUJImd4rkzTNFYkpTICtlLpq0jJSHqbuG0ikuRAgw=;
        b=PwY1rXeD2i4FeU5Me2zIllssT3bFnoMQETehSZEovexIlkgIiRc3z3BJl2dz+LIH/l
         P+0ERJ3gWtGMaoOe4Chskv9Y1Z0H6r8RWsLvV9XwPryH1QD5JYsitV5DpYbEKQugP8k/
         WrtzwGJZtlH7bh4/8u1qcyUdcl/+QyFKd/k2lnZZwi6qFNtu4jqqfOyX0MBWqFkYcuuz
         vX9uSDrF/TM3Ha7c+Ehtb8OzJgDbykhGTalKfKrzvcbKhXcVHfPrlIvV8gA2Cl/Em+TJ
         3DXfMX2+XBCO9PU6rHD/lCfSaShZKaCCfphoLiAQA5RrMFZVeTEr4vB9e2iavnRYhDf0
         DOfA==
X-Gm-Message-State: AOAM530A2JmsiR0BeVxoJjCYCaxc5UABBTHWeck73G6yjvphKR4Gp7xa
        JyHvNdPy5iEcG8Tiv4eeWz8pv3IyNFK2lA==
X-Google-Smtp-Source: ABdhPJyY2Fokt8m7it3nuNF538b5ckVi7k7++zJxzUvL/RYoHD2ciZ0Pvd45hzCCvb0UO2HjgMdCxg==
X-Received: by 2002:a7b:ce15:: with SMTP id m21mr11140499wmc.147.1640558245488;
        Sun, 26 Dec 2021 14:37:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay29sm16289861wmb.13.2021.12.26.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:37:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 0/7] grep: simplify & delete "init" & "config" code
Date:   Sun, 26 Dec 2021 23:37:12 +0100
Message-Id: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1239.g84ae229c870
In-Reply-To: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A simplification and code deletion of the overly complex setup for the
grep API, no behavior changes. For v5 see:
https://lore.kernel.org/git/cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com

Changes since v4:

 * As Junio pointed out there were behavior changes in the v4. I
   integrated/squashed the change he added to the
   gitster/ab/grep-patterntype branch to add the tests, and a fixed
   7/7 correctly handles the case of a flip-flopping
   grep.extendedRegexp now.

 * Some commit message additions/rewording that I hope will address
   relevant comments from Junio.

Ævar Arnfjörð Bjarmason (7):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: add missing "grep.patternType" config tests
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep: simplify config parsing and option parsing

 builtin/grep.c    |  27 +++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 126 +++++++++-------------------------------------
 grep.h            |  33 ++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 +++++++++
 t/t7810-grep.sh   |  39 ++++++++++++++
 9 files changed, 138 insertions(+), 131 deletions(-)

Range-diff against v5:
1:  b6a3e0e2e08 = 1:  b62e6b6162a grep.h: remove unused "regex_t regexp" from grep_opt
2:  c0d77b2683f = 2:  0edcdb50afd log tests: check if grep_config() is called by "log"-like cmds
3:  f02f246aa23 ! 3:  1b724d5e2e9 grep tests: add missing "grep.patternType" config test
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    grep tests: add missing "grep.patternType" config test
    +    grep tests: add missing "grep.patternType" config tests
     
         Extend the grep tests to assert that setting
         "grep.patternType=extended" followed by "grep.patternType=default"
    @@ Commit message
     
         Let's also test what happens when we have a sequence of "extended"
         followed by "default" and "fixed". In that case the "fixed" should
    -    prevail.
    +    prevail, as well as tests to check that a "grep.extendedRegexp=true"
    +    followed by a "grep.extendedRegexp=false" behaves as though
    +    "grep.extendedRegexp" wasn't provided.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/t7810-grep.sh ##
     @@ t/t7810-grep.sh: do
      		test_cmp expected actual
      	'
      
    ++	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins" '
    ++		echo "${HC}ab:a+bc" >expected &&
    ++		git \
    ++			-c grep.extendedRegexp=true \
    ++			-c grep.patternType=basic \
    ++			-c grep.extendedRegexp=false \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    ++	test_expect_success "grep $L with grep.extendedRegexp is last-one-wins & defers to grep.patternType" '
    ++		echo "${HC}ab:abc" >expected &&
    ++		git \
    ++			-c grep.extendedRegexp=true \
    ++			-c grep.patternType=extended \
    ++			-c grep.extendedRegexp=false \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
     +	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
     +		echo "${HC}ab:a+bc" >expected &&
     +		git \
4:  a542a352eab = 4:  f4876552771 built-ins: trust the "prefix" from run_builtin()
5:  a33b00a247e = 5:  069b0339146 grep.c: don't pass along NULL callback value
6:  92b1c3958fa = 6:  e38eca56959 grep API: call grep_config() after grep_init()
7:  63de643ebc2 ! 7:  88dfd40bf9e grep: simplify config parsing and option parsing
    @@ Commit message
          1. You can set "grep.patternType", and "[setting it to] 'default'
             will return to the default matching behavior".
     
    +        In that context "the default" meant whatever the configuration
    +        system specified before that change, i.e. via grep.extendedRegexp.
    +
          2. We'd support the existing "grep.extendedRegexp" option, but ignore
             it when the new "grep.patternType" option is set. We said we'd
             only ignore the older "grep.extendedRegexp" option "when the
    @@ Commit message
         grep_init(), which means that much of the complexity here can go
         away.
     
    -    Now as before when we only understand a "grep.extendedRegexp" setting
    -    of "true", and if "grep.patterntype=default" is set we'll interpret it
    -    as "grep.patterntype=basic", except if we previously saw a
    -    "grep.extendedRegexp", then it's interpreted as
    -    "grep.patterntype=extended".
    +    As before "grep.extendedRegexp" is a last-one-wins variable. We need
    +    to maintain state inside parse_pattern_type_arg() to ignore it if a
    +    non-"default" grep.patternType was seen, but otherwise flip between
    +    BRE and ERE for "grep.extendedRegexp=[false|true]".
     
         See my 07a3d411739 (grep: remove regflags from the public grep_opt
         API, 2017-06-29) for addition of the two comments being removed here,
    @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
      		return -1;
      
      	if (!strcmp(var, "grep.extendedregexp")) {
    -+		if (opt->extended_regexp_option)
    ++		if (opt->extended_regexp_option == -1)
     +			return 0;
      		opt->extended_regexp_option = git_config_bool(var, value);
     +		if (opt->extended_regexp_option)
     +			opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
    ++		else
    ++			opt->pattern_type_option = GREP_PATTERN_TYPE_BRE;
     +		return 0;
     +	}
     +
-- 
2.34.1.1239.g84ae229c870


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7CFC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A4D64DFF
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBOSZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBOSZC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:25:02 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFFC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:24:22 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id f18so3541554qvm.9
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86Q4H0fo0IdhJTc8pwH5bXrSvvXB/pm1wrvrXweEDkI=;
        b=QkA3qw6k0Q/hbVM383lyL6TyFE9rPR4Oa1xUgvi+rR4Kyiqefcc0jHEnE0cjESKpx7
         kJyDfQek2vfw7XVfu9QmIILybKwMX71FlLXLwWTmBSzLntKHJg/zbU+QuPG6ej+mlMwf
         AXTdm6oyEXA7NuD39uUAVXAnMUAaS4klWurZnqxRpoUEwCZKW7MLg1V4XiWgKI0GZm6z
         7t+DqioKisvb0I+Ei6YgCRHNd3oPZf+eKYvlfQXawvOOTLjpkLdo7Og1OvhGycExiWRs
         +RsHktdp5o551Wz2gdgHjfZjp49qvu6tRYZKDzC1xnbD9znS1ePEN5t8wX81ZQjPoUyQ
         h2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86Q4H0fo0IdhJTc8pwH5bXrSvvXB/pm1wrvrXweEDkI=;
        b=TDzF3CL9uknp12KemD4uudyMuMMxczgtXtkhil5RqUwmIsA4jiKnfApznkhB/bVK70
         +w8Ng8cWwAs/DEw2PYtA83/QsV4EkYFsBeBb9+Ue3j5fWoJOmonbm/FzjNhwX7a/atDc
         b70yU/rO1NHDOSuEt4GXR6VbO2QvdeXGumLsUA66cPcZofDnH8eU0b6ydTOXdFnlzuIK
         knTzEStTBY4jRe6QsQLL/VaQVMgoEY+Rd2oT1fG0c7XddQS6K2b+1UFI/SnkybHWSF5V
         X7UUfnYPkN5RnLMWqTV9Tlia+qAKM3GhMHrqSszi1lpFDCed5Xct1yCDYyIxd0UV1zF1
         RqWw==
X-Gm-Message-State: AOAM531PS2tHR6pLRJrQHyAnGpFMg2R03HqesVQmznMU7/W5zlgLW2uT
        lkB003HAoS5sC+Yfm3RwjaRk63s8Xtul+Q==
X-Google-Smtp-Source: ABdhPJx0smrShI2FYYTRTtc8zqMyFuB72C77lHV6omnWm+NgpyTOe/wHeZFdufCsc800+++QeHnjPQ==
X-Received: by 2002:a0c:b418:: with SMTP id u24mr15921051qve.20.1613413461273;
        Mon, 15 Feb 2021 10:24:21 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o5sm12305716qkh.59.2021.02.15.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:24:20 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 0/2] checkout-index: some cleanups to --temp and --prefix outputs
Date:   Mon, 15 Feb 2021 15:24:11 -0300
Message-Id: <cover.1613411136.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612812581.git.matheus.bernardino@usp.br>
References: <cover.1612812581.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
- Added regression tests in first patch.
- Left the `topath[]` cleanup outside the if block on patch 2, to make
  it easier to read.

Matheus Tavares (2):
  write_entry(): fix misuses of `path` in error messages
  checkout-index: omit entries with no tempname from --temp output

 builtin/checkout-index.c        | 35 ++++++++++++++++++++++-----------
 entry.c                         |  8 ++++----
 t/t2006-checkout-index-basic.sh | 23 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  d52bcad326 ! 1:  bdda5f99d0 write_entry(): fix misuses of `path` in error messages
    @@ Commit message
         writing to a tempfile. (In fact, `path` will be either empty or dirty
         when writing to a tempfile.) Therefore, these variables cannot be used
         interchangeably. In this sense, fix wrong uses of `path` in error
    -    messages where it should really be `ce->name`. (There doesn't seem to be
    -    any misuse in the other way around.)
    +    messages where it should really be `ce->name`, and add some regression
    +    tests. (Note: there doesn't seem to be any misuse in the other way
    +    around.)
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    @@ entry.c: static int write_entry(struct cache_entry *ce,
      	}
      
      finish:
    +
    + ## t/t2006-checkout-index-basic.sh ##
    +@@ t/t2006-checkout-index-basic.sh: test_expect_success 'checkout-index reports errors (stdin)' '
    + 	test_i18ngrep not.in.the.cache stderr
    + '
    + 
    ++test_expect_success 'checkout-index --temp correctly reports error on missing blobs' '
    ++	test_when_finished git reset --hard &&
    ++	missing_blob=$(git hash-object --stdin </dev/null) &&
    ++	cat >objs <<-EOF &&
    ++	100644 $missing_blob	file
    ++	120000 $missing_blob	symlink
    ++	EOF
    ++	git update-index --index-info <objs &&
    ++
    ++	test_must_fail git checkout-index --temp symlink file 2>stderr &&
    ++	test_i18ngrep "unable to read sha1 file of file ($missing_blob)" stderr &&
    ++	test_i18ngrep "unable to read sha1 file of symlink ($missing_blob)" stderr
    ++'
    ++
    ++test_expect_success 'checkout-index --temp correctly reports error for submodules' '
    ++	git init sub &&
    ++	test_commit -C sub file &&
    ++	git submodule add ./sub &&
    ++	git commit -m sub &&
    ++	test_must_fail git checkout-index --temp sub 2>stderr &&
    ++	test_i18ngrep "cannot create temporary submodule sub" stderr
    ++'
    ++
    + test_done
2:  1275701345 ! 2:  6ece1947c1 checkout-index: omit entries with no tempname from --temp output
    @@ builtin/checkout-index.c: static struct checkout state = CHECKOUT_INIT;
     +		putchar('\t');
     +		write_name_quoted_relative(name, prefix, stdout,
     +					   nul_term_line ? '\0' : '\n');
    ++	}
      
    --	for (i = 0; i < 4; i++) {
    --		topath[i][0] = 0;
    -+		for (i = 0; i < 4; i++) {
    -+			topath[i][0] = 0;
    -+		}
    - 	}
    - }
    - 
    + 	for (i = 0; i < 4; i++) {
    + 		topath[i][0] = 0;
-- 
2.29.2


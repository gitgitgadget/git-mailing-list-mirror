Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA9C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CAF64F93
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhBCPyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbhBCPfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:35:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BAFC061788
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f16so37802wmq.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y0uDEyR14HxwPOKcctVpZM3ozMX0T1PFIs+TId3VyUE=;
        b=fRv03Wn90dnBibEOi4butTaeapSX5pUEkMnttAunVLZcdJnhlHA0BY74XIipL9Gy1K
         wdLQEtVHDhp09965CbehVQXibbZGHxESN96pTHSOKek4rWsOn/s1ESbO+oKwqKiw2zPR
         wOCRLSiOJl9aKylCAk7ezJL3wAgIJ0r4QoZE74fXlDp0rMmFK/wPuyHe/rzPrIpnaz2i
         TDTR+xNnTJgZjv28Wm50Zbps6FnoQ6giDnQJGp7z3IIvUZcTcbXCskV+PMpfaG3S2/s/
         NkCrjeq7mepzIzll5YrsB91BF4zcQR9LUdXjT9tGBU0og6yK5Gye5wvLXeKpfVxsd0CF
         VCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y0uDEyR14HxwPOKcctVpZM3ozMX0T1PFIs+TId3VyUE=;
        b=HUf/mW/5koWh8K/EWgm4nKcYMwFauyIZ5EVahJKFpIzFa/68z+UUNpE/vdtgiolkzf
         Bu4OmZzhzr7uhIhbXdu7oyzQkMcTC9CgS8khoWC2aQhvNCWK6zC6oLcz2G0F3kH+9Nh+
         bC48EXsPsg9npkRHMsJLxHSh56Lw4oNBNkxmhXdUN4KmXDhZUO97wsG/JlKg4YLArhhX
         wJO7wbjfPsj66pdicBeUcLP18W5Lo+HbhRN9FmTMhy3oThpUsvPCpKc0J1qEAeDeqXHS
         jNooOplIpiSOyzoRD0cn6IEnAEzZwdBco6RiPHxByv91D6xOJTUIhJfZVWM8W6z3JQEH
         nLaw==
X-Gm-Message-State: AOAM532jHE9Kj2Djit4oj//UXWkLV24pzHlnOTN9ecfPKqNa7sAPBBmf
        pkLM5SlRPikKLiQP3f30jFl/m6AhCHo=
X-Google-Smtp-Source: ABdhPJwrtvjlKmNxt6MbMHVjOcnduSmq5+6foR84yifAvBdagiifssVzlojKgaZYFc6qjMd13qGyNA==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr3358006wml.100.1612366491829;
        Wed, 03 Feb 2021 07:34:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm3129938wmf.15.2021.02.03.07.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:51 -0800 (PST)
Message-Id: <pull.860.v2.git.1612366490.gitgitgadget@gmail.com>
In-Reply-To: <pull.860.git.1612216941.gitgitgadget@gmail.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 15:34:39 +0000
Subject: [PATCH v2 00/11] FSMonitor Preliminary Commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 2 of this series.

In version 1, I replaced the non-portable "xargs -d" with "xargs -0", but it
turns out that that too is not universally available. In this version I
replace the need for either one by filtering out the problematic paths (such
as ones with LFs) and quoting paths to handle whitespace. The resulting
paths can be passed to xargs without any arguments.

Also, I updated the test to use test-tool chmtime rather than touch to
ensure that the files actually look dirty on low-resolution file systems.

Jeff Hostetler (10):
  p7519: do not rely on "xargs -d" in test
  p7519: fix watchman watch-list test on Windows
  p7519: move watchman cleanup earlier in the test
  p7519: add trace logging during perf test
  preload-index: log the number of lstat calls to trace2
  read-cache: log the number of lstat calls to trace2
  read-cache: log the number of scanned files to trace2
  fsmonitor: log invocation of FSMonitor hook to trace2
  fsmonitor: log FSMN token when reading and writing the index
  fsmonitor: refactor initialization of fsmonitor_last_update token

Kevin Willford (1):
  fsmonitor: allow all entries for a folder to be invalidated

 fsmonitor.c               | 107 ++++++++++++++++++++++++++++++++++----
 fsmonitor.h               |   5 ++
 preload-index.c           |  10 ++++
 read-cache.c              |  24 +++++++--
 t/perf/.gitignore         |   1 +
 t/perf/Makefile           |   4 +-
 t/perf/p7519-fsmonitor.sh |  71 +++++++++++++++++++++----
 7 files changed, 196 insertions(+), 26 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-860%2Fjeffhostetler%2Ffsmonitor-prework-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-860/jeffhostetler/fsmonitor-prework-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/860

Range-diff vs v1:

  1:  cf252e24b8c !  1:  e570f7316cc p7519: use xargs -0 rather than -d in test
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    p7519: use xargs -0 rather than -d in test
     +    p7519: do not rely on "xargs -d" in test
      
     -    The Mac version of xargs does not support the "-d" option.  Convert the test
     -    setup to pipe the data set thru `lf_to_nul | xargs -0` instead.
     +    Convert the test to use a more portable method to update the mtime on a
     +    large number of files under version control.
     +
     +    The Mac version of xargs does not support the "-d" option.
     +    Likewise, the "-0" and "--null" options are not portable.
     +
     +    Furthermore, use `test-tool chmtime` rather than `touch` to update the
     +    mtime to ensure that it is actually updated (especially on file systems
     +    with only whole second resolution).
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
      @@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
     + 		git status -uall
       	'
       
     ++	# Update the mtimes on upto 100k files to make status think
     ++	# that they are dirty.  For simplicity, omit any files with
     ++	# LFs (i.e. anything that ls-files thinks it needs to dquote).
     ++	# Then fully backslash-quote the paths to capture any
     ++	# whitespace so that they pass thru xargs properly.
     ++	#
       	test_perf_w_drop_caches "status (dirty) ($DESC)" '
      -		git ls-files | head -100000 | xargs -d "\n" touch -h &&
     -+		git ls-files | head -100000 | lf_to_nul | xargs -0 touch -h &&
     ++		git ls-files | \
     ++			head -100000 | \
     ++			grep -v \" | \
     ++			sed '\''s/\(.\)/\\\1/g'\'' | \
     ++			xargs test-tool chmtime -300 &&
       		git status
       	'
       
  2:  a641f9e357c =  2:  3042fc92fe6 p7519: fix watchman watch-list test on Windows
  3:  2af6858716f =  3:  9ceba5e6942 p7519: move watchman cleanup earlier in the test
  4:  8de9985a706 =  4:  f6ea0a51f50 p7519: add trace logging during perf test
  5:  cdd49f1fdb1 =  5:  3c5035e4649 preload-index: log the number of lstat calls to trace2
  6:  65488f7a1bf =  6:  d150a2d4576 read-cache: log the number of lstat calls to trace2
  7:  c84531f6244 =  7:  33cc0b838fa read-cache: log the number of scanned files to trace2
  8:  ef64b60c7a0 =  8:  c043bccc8af fsmonitor: log invocation of FSMonitor hook to trace2
  9:  edb88ffe39e =  9:  6ec4a4468f6 fsmonitor: log FSMN token when reading and writing the index
 10:  384d2eff863 = 10:  2ac66f07a59 fsmonitor: allow all entries for a folder to be invalidated
 11:  4686196bbc6 = 11:  5410d3ab61d fsmonitor: refactor initialization of fsmonitor_last_update token

-- 
gitgitgadget

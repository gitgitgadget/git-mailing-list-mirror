Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6FC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8B20BED
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 02:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEW32XCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgIJCTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgIJCRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 22:17:45 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5EC0613ED
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 19:17:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so4907433wrl.12
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 19:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+b8vL3+qYpPeWLPoCfNDS9wNNEydpgrnj+/rFK0l/Qo=;
        b=mEW32XCs0vaG7qsGreBSBqE4z6tTfqtk+xl8S0qk7QcrI/9MlImQ/9nHYUob0Y9dlf
         TJVE9oJ7PyPqpJaQ/WfeO4weAgP6mgClG7TxOcMh8gX6vYAGMwT/TMxyQEfGhaJScD6r
         1v/rpyv0o+36e2m6prlpyNGj8ISwEXIPrIA0bKnlhgN4HU8ZjekxMFqE+pREY0tqaS33
         zrhTRqx+QKEMYpDC47F12AOhUEdVeLXA+3OPzrERtROW0sNF6qt+zp9ZhEiXnpkZuQ1J
         GvHp3d7FF/+KH4OSjTxVwGV9DmVTEeQ8Wj+6VgQIiVimIo24Y1FJ34eIlGM0oU3GYdq/
         ql/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+b8vL3+qYpPeWLPoCfNDS9wNNEydpgrnj+/rFK0l/Qo=;
        b=LfIHW4iuRC9VaJ1uBxp4AhLRY50Tvnbv7pk0mahuuJRrUD5IoxsOjIaKwnRLPrVQU6
         RhfUrscZpDWsK7yKX/vfJYkI7JPftwiSkJ7TPjJdh3PgcCCDH2dF8mx3Yy/lIFWY9EuL
         U+zPX5+lpL4c8uSf4gLm+OW+vTSU90i/l+f4frtVJ2aAeKcuFJdwR7NJPE0k7bSchRxm
         sIb8iu4nuvNblGq+HV9c6z0xoyIWFymX18ZM04hWZVM/xCcl9DPzGWLaSp9sLVuDL1gE
         pT3zKgAZcMZraktnm8DqpxCTABhsDqx6H52HUWOhuqCgWWzrQVoknM8dyyh+d/18ofh7
         jerA==
X-Gm-Message-State: AOAM530cWqbDLAijoMHr9TzYpD2E7XIX6c7rA9VadWbL2tuU2I31Bc0A
        Y3vSdlf2yhsG06ZSr4QQCGBltRH4BLw=
X-Google-Smtp-Source: ABdhPJxDrInZ0l/ijKW2EmArxhEaNt2ES53+p+7oKbYP3FKgcUQROe+3xx7oKOGnVpSWMEzKI0kZ1Q==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr7072198wro.249.1599704263408;
        Wed, 09 Sep 2020 19:17:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l9sm1305476wmh.1.2020.09.09.19.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 19:17:42 -0700 (PDT)
Message-Id: <pull.694.v3.git.1599704262.gitgitgadget@gmail.com>
In-Reply-To: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
References: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
From:   "KADOTA, Kyohei via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Sep 2020 02:17:40 +0000
Subject: [PATCH v3 0/2] Fit the building tools to Plan 9 environment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "KADOTA, Kyohei" <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've posted some commits for porting git to Plan 9.

This pull request is thing that cut off building scripts from #305 and is
re-constructed that.

I expect this don't change any artifacts.

differ from v1
==============

 * drop some adapters, printf, cut, expr or tar
 * drop using SHELL_PATH instead of sh
 * use real name at Signed-off-by signature

Kyohei Kadota (2):
  Fit to Plan 9's ANSI/POSIX compatibility layer
  Use $(LD) instead of $(CC) for linking the object files

 .github/workflows/main.yml |  1 +
 Makefile                   | 15 +++++----
 ci/lib.sh                  |  8 ++++-
 config.mak.in              |  1 +
 config.mak.uname           |  6 ++++
 generate-cmdlist.sh        |  2 +-
 t/chainlint.sed            | 66 +++++++++++++++++++-------------------
 7 files changed, 57 insertions(+), 42 deletions(-)


base-commit: 3a238e539bcdfe3f9eb5010fd218640c1b499f7a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-694%2Flufia%2Fcompat-p9-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-694/lufia/compat-p9-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/694

Range-diff vs v2:

 1:  c850888c25 ! 1:  534378c4e5 Fit to Plan 9's ANSI/POSIX compatibility layer
     @@ generate-cmdlist.sh: command_list () {
       	grep -v '^$' |
       	sort |
       	uniq
     -@@ generate-cmdlist.sh: category_list () {
     - 
     - get_synopsis () {
     - 	sed -n '
     --		/^NAME/,/'"$1"'/H
     -+		/^NAME/,/'"$1"'/h
     - 		${
     - 			x
     - 			s/.*'"$1"' - \(.*\)/N_("\1")/
      
       ## t/chainlint.sed ##
      @@
 2:  6f35562965 = 2:  7d33e11867 Use $(LD) instead of $(CC) for linking the object files

-- 
gitgitgadget

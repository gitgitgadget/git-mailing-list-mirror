Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ECAC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9B460200
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbhIANco (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243187AbhIANcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 09:32:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BE2C061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 06:31:45 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q11so4518333wrr.9
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=65fW0JupRUc5GH5pVTzBG1P+SGEtv/XF5CQ0Tx1iHPY=;
        b=M7iAhas9rxE/fWQr+HPFNAe6UDaKHVXIQvCw3zOTC9Uk02HimVBfjIxzWDjhYWUBzI
         R3tM62142LbIqU1bVhZ043CZN8v/9yO0y2n+m8hTAMqu5tq03/nGHm9ikrN940KEvWDR
         zdOMBK5sPeDjWahQlU7YtW3QmYh07me8RiFcoLgJFBS85+gUKwldGGnfwdE5FXLHhmj0
         zRFNcQ+r0Ke1oaAv3nm9WDgosMYFO/DkMN6GbQDfBKTxMeuxMd6wy7g6ryA/Sb5QnF4I
         UnwlB5lO01Wa/0oMg/rHKq5B0un8RIIfROAbpdUZ5kksmRHCycuOIHs3M/UeV6n5kebj
         VNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=65fW0JupRUc5GH5pVTzBG1P+SGEtv/XF5CQ0Tx1iHPY=;
        b=Zwmjd/iiIp7R816Px40OE1cGRLjr2F71kYUVknUIwPiDgGVrDIJxy3ob1XuQStNcHW
         RVl75fH+eVKw4m00JZENP6OzWpApJ01u9a0YwvUdCo6E+dfEMrbNEYDrfGdj2m3LkZYj
         T4MCqktnAZY+9vofIGD404KJ9tfGJY2G9i8MZSHiiA/2V4TzrjDHnP9iUErxkIHAlBVN
         YRPPKUuUfIXJiHD5JEbhTQ3ldNU9SWbmEOXc/h3aZb/nEVOCBhH4nukRpVbiXhiXzLxd
         9X00JGRF1tcXSoUUp0SpPwYuxWDIJMqZl2ERU43DyWR1h3qxwh0SYN9PSu3ev6CpQY77
         YReQ==
X-Gm-Message-State: AOAM532cYyYgf52IEmJJ1qBvRAQ1scO88WfvL31aTL2zVElSYe6a30XB
        3VMx73CeJ/h0pKbwFheKdK0m/lrEqwo=
X-Google-Smtp-Source: ABdhPJyGgNwXL3rynpQWYhrUgayXrJPz0n3M7SOZCoCnjTjCblGkysl/WSRyfVRxdqdtfgX6tGz+6g==
X-Received: by 2002:adf:c442:: with SMTP id a2mr38377942wrg.228.1630503104096;
        Wed, 01 Sep 2021 06:31:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm21723345wru.41.2021.09.01.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 06:31:43 -0700 (PDT)
Message-Id: <pull.1022.v3.git.1630503102.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
References: <pull.1022.v2.git.1630111653.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 13:31:39 +0000
Subject: [PATCH v3 0/3] test-lib-functions.sh: keep user's HOME, TERM and SHELL for 'test_pause' and
 'debug'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Added '-a' flag as suggested by Elijah, equivalent to '-t -s -h' for
   'test_pause' and to '-t -h' for 'debug'

v2:

 * added 1/3 as a preliminary step to use TEST_SHELL_PATH in test_pause
   instead of SHELL_PATH, as suggested by Carlo
 * implemented the change in behaviour through optional flags in both
   test_pause and debug. This seemed to be the simplest way to keep the
   current behaviour but also provide a way to improve the UX.

v1: This series proposes two small quality-of-life improvements (in my
opinion) to the 'test_pause' and 'debug' test functions: using the original
values of HOME and TERM (before they are changed by the test framework) and
using SHELL instead of SHELL_PATH.

The later might be too big of a change, but I think it makes sense. We could
add a new GIT_TEST_* to conditionnaly change the behaviour, but I kept it
simple for v1.

Cheers, Philippe.

Philippe Blain (3):
  test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
  test-lib-functions: optionally keep HOME, TERM and SHELL in
    'test_pause'
  test-lib-functions: optionally keep HOME and TERM in 'debug'

 t/test-lib-functions.sh | 104 ++++++++++++++++++++++++++++++++++------
 t/test-lib.sh           |   6 ++-
 2 files changed, 93 insertions(+), 17 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1022%2Fphil-blain%2Ftest-pause-and-debug-easier-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1022/phil-blain/test-pause-and-debug-easier-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1022

Range-diff vs v2:

 1:  2f566f330e0 = 1:  2f566f330e0 test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
 2:  00211457ece ! 2:  328b5d6e76f test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
     @@ t/test-lib-functions.sh: test_tick () {
      +#	This allows you to use your regular shell environment and Git aliases.
      +#	WARNING: this can break test reproducibility.
      +#	CAUTION: this can overwrite files in your HOME.
     ++#   -a
     ++#	Shortcut for -t -s -h
       
       test_pause () {
      -	"$TEST_SHELL_PATH" <&6 >&5 2>&7
     @@ t/test-lib-functions.sh: test_tick () {
      +		-h)
      +			PAUSE_HOME="$USER_HOME"
      +			;;
     ++		-a)
     ++			PAUSE_TERM="$USER_TERM"
     ++			PAUSE_SHELL="$SHELL"
     ++			PAUSE_HOME="$USER_HOME"
     ++			;;
      +		*)
      +			break
      +			;;
 3:  1fac9baec1d ! 3:  4e43bd086b5 test-lib-functions: optionally keep HOME and TERM in 'debug'
     @@ t/test-lib-functions.sh: test_pause () {
      +#	This allows your debugger to find its config file in your home.
      +#	WARNING: this can break test reproducibility.
      +#	CAUTION: this can overwrite files in your HOME.
     ++#   -a
     ++#	Shortcut for -t -h
      +#
       # Examples:
       #     debug git checkout master
     @@ t/test-lib-functions.sh: test_pause () {
      +		-h)
      +			DEBUG_HOME="$USER_HOME"
      +			;;
     ++		-a)
     ++			DEBUG_TERM="$USER_TERM"
     ++			DEBUG_HOME="$USER_HOME"
     ++			;;
      +		-d)
      +			GIT_DEBUGGER="$2" &&
      +			shift

-- 
gitgitgadget

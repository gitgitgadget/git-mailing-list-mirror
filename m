Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3AC43461
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1251613C4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhDTMaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhDTMaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:30:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D74C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cq11so1201299edb.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZgNqdNgIVLT3llcyxrPcZTQ/J1SMQlG+R/PpbAGS6Y=;
        b=tpLzC9IslPc3C+mKyJijkE+H/FwWsEU4i7xImKWtZAN0rRArU3H+GSRXNkHC9SW5tZ
         q7J1WfuRd6IGwqnnme+pmARdl8wBORW1l+kkkGWbt4cn8tYDBZxn++CFdDlEgHadYRHF
         q4sGKPNRPv2MNZuJP9tdm4QmlGVDlzBA672c8yZd8WGR+18j3+CVBdes5Rn9izG9mkG3
         nImhG0dymiVX/XY1XAt2at4pxy7cucrKphkcGhX3TWdYic1+IXxgwxIgNyS03iLHx902
         jvsmEOB86G3I7Dd98+IP15E1G3JowewNWfE8YiHuWaWPyM5u95tLwAog6j2AHDdkkWAM
         aBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZgNqdNgIVLT3llcyxrPcZTQ/J1SMQlG+R/PpbAGS6Y=;
        b=Kjuj3TdR/Rhpqcn35yn6nQ//KS2iMTT1EgX5fBjRaA3TLB0exUw0he0aOpxRCzxntz
         4qHdr3Sko008MlYAu1pHznLr8059Ske2NDn6ENisZUJETrm7WQNWnpFD7miInSb7hxgN
         fHslDONPXO/fTbDDiUjG54i1/FIsQPEMsGtWvASswBxcNSPIsaRQjYk3wDcR3kzAqmm1
         SFFXFHzbKq7bMv3bZQqJD+puVPV6AlveqlKWAD3nZqQYRGWf3yUzgXxHpuMThY8bvVQ3
         Q14HkNKQ1Oom1/UKh1zzjTlAFtcfX9KepMui4DEeztGNkVIpvA5TV7Sl8txYS+TMpHY9
         VzBA==
X-Gm-Message-State: AOAM532dUncKPQ92QF5JbjJOMoNmfl82akJCZOzn6mdd/MLU/mMAMGoe
        dM6Ma8CZ9aHGEIhI8N7TQIETaEpSceB8Bw==
X-Google-Smtp-Source: ABdhPJwCpAMmmvhQltPLNEG7e0/gZ4O9Z3JpKv7lUbqK3CtNd7wvUxWazE5FgAN3yEUcrIueUWq6qQ==
X-Received: by 2002:a05:6402:26c3:: with SMTP id x3mr32993874edd.126.1618921777919;
        Tue, 20 Apr 2021 05:29:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f1sm10898031edz.60.2021.04.20.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:29:37 -0700 (PDT)
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
Subject: [PATCH v2 0/3] test-lib-functions.sh: trickery to make -x less verbose
Date:   Tue, 20 Apr 2021 14:29:27 +0200
Message-Id: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the "-x" output less verbose for our various helper
functions, mainly using the trickery of feeding "$@" to "test" to rely
on it to die when given too many arguments.

Since v1 the only change is adding a comment as suggested by Eric
Sunshine, it's not ideal as noted in
<87pmyp2led.fsf@evledraar.gmail.com> (I wish these were just in one
file, so we could have a comment at the top), but will aid future
maintenance anyway.

Ævar Arnfjörð Bjarmason (3):
  test-lib-functions: normalize test_path_is_missing() debugging
  Revert and amend "test-lib-functions: assert correct parameter count"
  test-lib-functions: remove last two parameter count assertions

 t/test-lib-functions.sh | 72 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

Range-diff against v1:
1:  a3e20ef18f < -:  ---------- test-lib: split up and deprecate test_create_repo()
2:  c22e3f7764 = 1:  fd33f6d71f test-lib-functions: normalize test_path_is_missing() debugging
3:  6f9e09a201 ! 2:  67ddd821df Revert and amend "test-lib-functions: assert correct parameter count"
    @@ Commit message
     
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_external_without_stderr () {
    + }
    + 
      # debugging-friendly alternatives to "test [-f|-d|-e]"
    - # The commands test the existence or non-existence of $1
    +-# The commands test the existence or non-existence of $1
    ++# The commands test the existence or non-existence of
    ++# a given argument.
    ++#
    ++# The pattern of using "$@" to "test" instead of "$1" is not a bug. We
    ++# are counting on "test" to error on too many arguments if more than
    ++# one is given. Checking "$#" explicitly would lead to overly verbose
    ++# -x output.
      test_path_is_file () {
     -	test "$#" -ne 1 && BUG "1 param"
     -	if ! test -f "$1"
4:  b7b11a60bc = 3:  8fd51861b5 test-lib-functions: remove last two parameter count assertions
-- 
2.31.1.723.gf6bad1b9ba1


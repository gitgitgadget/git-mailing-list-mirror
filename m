Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F0C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiKHOVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiKHOVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:21:09 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D16C8A1F
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:21:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s12so13081771edd.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEPJb96jkZ1q3KOuMSxWa6s4oHDJiTqIEjm90K0iw+I=;
        b=CNsGnOBPdVaLEq9JoQmgvFJFinx6OXkpcvA3N5WL/SMHv4qCIFbauPqNIrAgpTHXHV
         oo53n1Q8wUvowaGBRRqffSfXDqTqh9TQT07kjyGKsqfbyl2/C1n1+ebd8csrYJpsyoNO
         kEWuf3gLBCc3MhZ0QlMpGJRM9aRir+Zu5H0oXS5Y4No7PnfRdgL621hkLRnxFrtbf5pO
         bZMLHFtX1Rt4JY2WXBqM5V+x30mi0jXvQPAdy9oZTyrsOTY3I0Rjt1n1N8oQ77xaZSm9
         2Xx15q1r0Sui/tKu/5ILG1YtCHLADM3S1y0cfGxQ+9bVsD0fd4XBqZ3q7vYHBucBTUxf
         rGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEPJb96jkZ1q3KOuMSxWa6s4oHDJiTqIEjm90K0iw+I=;
        b=KcKX9TY2zAfn0pF98IKYWVfDTSJ0vYOePBVj5CfAYheyUl9ICItH40yZ89PLhWibYS
         ewg2uMVCGHdFbUCUJvZgnRv2P7geuBaelwHwGfEHRX6utWyjTRWjnK1CgY70qJwztSBJ
         PF/jWMk8d/GZ6bQpJbZ/tpvflSgres7Xgpqf+ea0lfaKnNU6VCbKrlPqFQsKbzywgirR
         oZ6Xee3wpx9eIeV2/2XLMCtkQBcezPouMMyeXQ1fPb/H50cpdgeTlZgHq1sfWWXl7Uki
         oVaGwSC1dbZo085/GL9n2ew5gNQJv/nqIkO0sAdfPGAANPiMM+CHU3etaFmRvhNA/mKt
         ZtsQ==
X-Gm-Message-State: ACrzQf3LH/3szNXoNxp17M7CHiinD875+cb6T7xtwxpnbv4zj76MWq1f
        nEks0LYUAIc27IMaxIwRULSplq5vQWWYmQ==
X-Google-Smtp-Source: AMsMyM67YYa/mjTPvr9vSLmw1cxpYQwO10PTo0zmQTCkYRYah9ES+FUiZVCmKcOyaS9Q+TkqUbAHlA==
X-Received: by 2002:a05:6402:2989:b0:44e:90d0:b9ff with SMTP id eq9-20020a056402298900b0044e90d0b9ffmr54769779edb.110.1667917260715;
        Tue, 08 Nov 2022 06:21:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id sd26-20020a1709076e1a00b007ae035374a0sm4794806ejc.214.2022.11.08.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:21:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osPTH-000ZrA-2j;
        Tue, 08 Nov 2022 15:20:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: ab/cmake-nix-and-ci (was: What's cooking in git.git (Nov 2022, #01;
 Thu, 3))
Date:   Tue, 08 Nov 2022 15:14:50 +0100
References: <Y2RldUHTwNzmez73@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2RldUHTwNzmez73@nand.local>
Message-ID: <221108.86cz9xsf1w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Taylor Blau wrote:

> * ab/cmake-nix-and-ci (2022-11-02) 12 commits
>  - CI: add a "linux-cmake-test" to run cmake & ctest on linux
>  - cmake: copy over git-p4.py for t983[56] perforce test
>  - cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>  - Makefile + cmake: use environment, not GIT-BUILD-DIR
>  - test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>  - cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>  - cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>  - cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>  - cmake: don't copy chainlint.pl to build directory
>  - cmake: update instructions for portable CMakeLists.txt
>  - cmake: don't "mkdir -p" and "cd" in build instructions
>  - cmake: increase test timeout on Windows only
>
>  Fix assorted issues with CTest on *nix machines.
>
>  Waiting for review.
>  source: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>

I think the v4[1] you've since picked up should be ready, and I think
addressed the outstanding comments, except as noted in "let's pursue
that separately" in [2].

1. https://lore.kernel.org/git/cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com/
2. https://lore.kernel.org/git/221103.86a6581129.gmgdl@evledraar.gmail.com/

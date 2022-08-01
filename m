Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A06C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 12:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiHAMZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiHAMYm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 08:24:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D7060EB
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 05:05:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f22so2442792edc.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=cLkRKAVAHQGWornY+OJC32M/Z/Rp0cJDXCigppwLAPw=;
        b=CbmFrY943T3EtVU8ftSyIHbE/aLUDgIdUttZX0mrs954xeSn8Fk9wftrjDwFQkOdoC
         lP6RAcO2LJWenqTK0bn1PqY7LCWlCRZk8Wh31J6UQjMDyfcvBNJOo16xvtZopFWID0JF
         8WIQRYMYpsU4CRlv1djzSdFuWukjUio90LiMEyKvPf6I9bd+pQlA739X6LDLXrtjqzR8
         rm5XFuEvtUS+FCE/8jLtcKL9Lr4Cq6k2qWTB7So+2xlxsYjdHq+wpBowInF+a8+kvARj
         f9VC07K81jntXHivvgrYcKPqC5pCEwa/JNNun1Fa3j9ZLD7D9NKQspwu73I4SdaZiZJT
         wEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cLkRKAVAHQGWornY+OJC32M/Z/Rp0cJDXCigppwLAPw=;
        b=aOsK+4uRfnRtIR0QMB7yU36TXnADs5r6WE3+/bSLK65CZwGQiGWnGWqOi1ifZMx7tm
         n5lv1EXzE+UO6MPxBRjhQQB/lNOLq2VoRz+zwhOIqYzvWN79NPCqitf1gzHjmRcEZXol
         y5doAWzF/UHT33gJsSAtNS+5duhDaIJbRnaRtNt8k/KL8gKUwSiBoFc4FRv3JLhjO1RT
         v4fhulqrO5515zFpFB+RMXXOcGETtMpnDFq8BAVB0NSOGFnLNHYkGJc30T0kGa1Fpjmo
         rUsf7uc4++rEbcL1fkHy2DfM5H/oF7C3SOfU/6PXeezRzce/pprVoXHXKJe9ujgbOJNv
         nM0Q==
X-Gm-Message-State: AJIora+g33I6Q0mtdA3BPabc69+U7YiyvyI11aZdz6VLkeB6WUO3UG1E
        f78B8UAJg9Gp8S0KihQGct7bjtWrw94=
X-Google-Smtp-Source: AGRyM1vDwhNhdNqIM1WuFQNvncONTNephL4PP13OhUdDsNTbohuAFkiiVk4hrgFRebdLPPZuh1GWlg==
X-Received: by 2002:a05:6402:500b:b0:431:78d0:bf9d with SMTP id p11-20020a056402500b00b0043178d0bf9dmr15462032eda.184.1659355516209;
        Mon, 01 Aug 2022 05:05:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906380e00b007262b9f7120sm5063120ejc.167.2022.08.01.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:05:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oIUAc-008lsD-WD;
        Mon, 01 Aug 2022 14:05:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/leak-check (was: What's cooking in git.git (Jul 2022, #08; Fri,
 29))
Date:   Mon, 01 Aug 2022 14:01:01 +0200
References: <xmqq7d3v33to.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d3v33to.fsf@gitster.g>
Message-ID: <220801.868ro8i2yt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 29 2022, Junio C Hamano wrote:

> * ab/leak-check (2022-07-27) 15 commits
>  - CI: use "GIT_TEST_SANITIZE_LEAK_LOG=true" in linux-leaks
>  - upload-pack: fix a memory leak in create_pack_file()
>  - leak tests: mark passing SANITIZE=leak tests as leak-free
>  - leak tests: don't skip some tests under SANITIZE=leak
>  - test-lib: have the "check" mode for SANITIZE=leak consider leak logs
>  - test-lib: add a GIT_TEST_PASSING_SANITIZE_LEAK=check mode
>  - test-lib: simplify by removing test_external
>  - tests: move copy/pasted PERL + Test::More checks to a lib-perl.sh
>  - t/Makefile: don't remove test-results in "clean-except-prove-cache"
>  - test-lib: add a SANITIZE=leak logging mode
>  - t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
>  - test-lib: add a --invert-exit-code switch
>  - test-lib: fix GIT_EXIT_OK logic errors, use BAIL_OUT
>  - test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
>  - test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
>
>  Plugging more leaks.
>  source: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>

Just a note on the summary: This isn't "plugging more leaks" (although
one leak is plugged as it's trivial, and stands in the way of 15/15.

Suggestion: New test instrumentation for extending SANITIZE=leak
checking, and marking some existing tests as leak-free.

I think this should otherwise be ready for "next", the "linux-leaks" job
now passes with this (there was a conflict with another topic). This
topic is fairly self-contained to just the test code we run for
"linux-leaks".

To the extent that we have had a bit of churn with these sorts of
changes it's been because they've lingered in "seen", as new changes get
sent based on "master" or "next", which inadvertently add leaks to
existing now-leak-free tests...

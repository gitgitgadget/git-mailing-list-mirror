Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86BC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F01464F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCQNid (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhCQNi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:38:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61807C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:38:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r17so2616845ejy.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D73dYZkT0WF0uMuNbY9aUyuG5Ce4xnXduTJbOXaQjSk=;
        b=Ve8vNwhqRWEqn2RKuQOe8N1skEk9DzZg5eK/ogMDPG6MORlumneywumeC082TXNFH3
         qP8CAmm6u8MePd4QRdl/EAkbLoyuIE0Qq9CFD6/cMji/5q30jUrmiHdYYcNIbobKuiUO
         RVoZ8A0bKGItfyaPPsv9aD/lXBtGIRuScvMrhX11MOt6Qn8/+lBk9k66xt/kIiyh1hc1
         MfJbPkaEHL6aNnIbcXkRnYVwTHYiAurxOWyTUKinDkp9QOxaT2YitcpTf2h6sh2hsWAa
         iO+wvTdhvTCTi0S55oCFYw2VTSAt+jgqjJwPttNScpaH501goLofcLNxgOik6AJzQewa
         JNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D73dYZkT0WF0uMuNbY9aUyuG5Ce4xnXduTJbOXaQjSk=;
        b=QGTqgF8L3ZLygYziBRnvpZ3/JAL4oxTJLLi62rHq0vhCKdVeXZVaMl7Rm8MAgwAn7k
         /stRygkiNIDQi/cGhBWrFHpFtIofCkXx3zpXc1QIXPtp2DSppuRmTeZ7QK0As+w4QbrI
         8ycjfJCurCm5iCzoVfQT5+mMCwnNOlJ3EaX3eEnL+de57BUMukuAUG2XHVJpL3uQR51R
         cCtyLvFn4kqYJGXwA0p0EaSh1nJyTVLQ0RFfhg0lYxxjdERayifPg3tgNfdGHiy/v9Lv
         0csAW9J7NmOLHVw876Mj3p+3yyyDtDrADWz837LyWJHsmWD/4SiXESEGH0wkU5J1KnQG
         dVwg==
X-Gm-Message-State: AOAM5309H5316NqsLr+QqsHY860RNtasqHSEDunuIHtJW8tNmODuzrAE
        4gic18lgFMwOA/ohsz99SMg=
X-Google-Smtp-Source: ABdhPJzrxi+d+awgBLgn95lBLkw/53VchoS/GK1S66rEYUphUTfOxLzDYecb4ow/pC9ad6euBYzpbw==
X-Received: by 2002:a17:906:8614:: with SMTP id o20mr34345080ejx.386.1615988301086;
        Wed, 17 Mar 2021 06:38:21 -0700 (PDT)
Received: from C02YX140LVDN.corpad.adbkng.com ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id cf4sm7037421edb.19.2021.03.17.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:38:20 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:38:18 +0100
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: Tests failed with GIT_TEST_FAIL_PREREQS and/or
 GIT_TEST_PROTOCOL_VERSION
Message-ID: <YFIGSo3U5u7zy9fq@C02YX140LVDN.corpad.adbkng.com>
References: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
 <YFC33vfLb36pRCO6@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFC33vfLb36pRCO6@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Tue, Mar 16, 2021 at 09:52:47AM -0400, Taylor Blau wrote:
> Hi,
> 
> Is it possible that your bisection script doesn't report success
> properly? Bisecting the same range (v2.30.0..v2.31.0) with
> 
>     $ cat run.sh
>     #!/bin/sh
>     false
> 
> does say that my 3b1ca60f8f (ewah/ewah_bitmap.c: avoid open-coding
> ALLOC_GROW(), 2020-12-08) is the first bad commit.

You are spot on.  It was a busy day and I only had a few minutes to
look at our internal pipeline of the test suite.  I guess I was doing
something along the line of.

      $ git bisect start HEAD v2.30.0
      $ git bisect run 'cd t && GIT_TEST_PROTOCOL_VERSION=1 ./t5606-clone-options.sh'

Which does indeed errored out and pointed to your commit.

> 
> Thanks,
> Taylor

I have properly re-run the bisection in a './test.sh' bash script and
here are the suspicious commits:

1. For t7810 and t5300 failing when GIT_TEST_FAIL_PREREQS=1:

    a926c4b904bdc339568c2898af955cdc61b31542 is the first bad commit
    commit a926c4b904bdc339568c2898af955cdc61b31542
    Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    Date:   Thu Feb 11 02:53:51 2021 +0100

        tests: remove most uses of C_LOCALE_OUTPUT

        As a follow-up to d162b25f956 (tests: remove support for
        GIT_TEST_GETTEXT_POISON, 2021-01-20) remove those uses of the now
        always true C_LOCALE_OUTPUT prerequisite from those tests which
        declare it as an argument to test_expect_{success,failure}.

        Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

2. For failing t5606 while 'GIT_TEST_PROTOCOL_VERSION=1' was used:

    4f37d45706514a4b3d0259d26f719678a0cf3521 is the first bad commit
    commit 4f37d45706514a4b3d0259d26f719678a0cf3521
    Author: Jonathan Tan <jonathantanmy@google.com>
    Date:   Fri Feb 5 12:48:49 2021 -0800

        clone: respect remote unborn HEAD

        Teach Git to use the "unborn" feature introduced in a previous patch as
        follows: Git will always send the "unborn" argument if it is supported
        by the server. During "git clone", if cloning an empty repository, Git
        will use the new information to determine the local branch to create. In
        all other cases, Git will ignore it.

        Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

     Documentation/config/init.txt |  2 +-
     builtin/clone.c               | 16 ++++++++++++++--
     connect.c                     | 28 ++++++++++++++++++++++++++--
     t/t5606-clone-options.sh      |  8 +++++---
     t/t5702-protocol-v2.sh        | 25 +++++++++++++++++++++++++
     transport.h                   |  8 ++++++++
     6 files changed, 79 insertions(+), 8 deletions(-)


Thanks,
Son Luong.

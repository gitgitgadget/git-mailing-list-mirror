Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F24C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5098C60232
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 13:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhCPNxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbhCPNwu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 09:52:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A2C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 06:52:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id g9so12749221ilc.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y82LxAaUWkgG2ulTWTXEFS6VX5p+SEiXEu8L8jD/chE=;
        b=jI8LdyHC45mUpAZWe52+wwnFPTpJoy57vZjBKdM4HYT7chDsSUnbh+JMkQ4cb8aN4v
         lsBLMtWuF/eDcvxGZ+3waSxmUmifHJZwCRq0vEzrD9OhH5gEhW3DVm7wv8rfDCZ7pJB1
         3g85zfozWBGsna+ACQEJFle+6l4QXaNoP1tJIJmzND5Ydzc1NZk8O5suGEoJkWjNqipG
         vKaGR/WMR5iQ3OHGvKVV8j0pvBzUonzJttKy57HL7cQLQX55SRPO5ogfaXqIAIqPGr42
         3+DUi1N/y7eoawiT2Ya2+fvgLbAYxjJxUB6d9etGhVCgK0c+ZRPFR5SIyp5W5+Fjwik7
         ZOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y82LxAaUWkgG2ulTWTXEFS6VX5p+SEiXEu8L8jD/chE=;
        b=VKfb1YJCacQlvpVb9/2qpbhsK++HybQ+We4+MSTbinGc5ohh/SCFDAJ4/ZNKMN483z
         RtkAkB7vByiGnuir5qJDquIbn2R4jWT1yYPFVbUdsDkA7kH88hq4YMDeNwKwJUWai3wi
         fw4OJ2XKv/Ye3TQ5VMjNLZaJKsGx7ziGjt2myjeltjV35o98YvfwZuWsCU2tHUNCYi9r
         zZawfZWrL71kVkY1X0Rq8loEk3NaFwShjQMChoJQvLmaXDKAaqRzNH3s3+grMKTgwSe+
         t4G76Bcp26lVdqQO/15urZrFgdncFaforB9iHz5hapTVcdt8IxcsmXQjm8Fx+lmu+lBM
         V6uA==
X-Gm-Message-State: AOAM533UDz120lpGNB6iDW9gTcHEYkoCUv4iEs8zCGUqNM8Ce0+3pEdX
        vQSXtxJdjdryRB6u6XaWiMAIwg==
X-Google-Smtp-Source: ABdhPJx7T2kP00fiW3+ZN8pWwyR2BuRFKh5gNrw2yj2NYnNplDg4hyLqonl15xPvUIlQNCFa2FVcVg==
X-Received: by 2002:a92:6b0e:: with SMTP id g14mr3993044ilc.246.1615902769636;
        Tue, 16 Mar 2021 06:52:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:aa35:f9c6:aa86:b530])
        by smtp.gmail.com with ESMTPSA id k125sm8702149iof.14.2021.03.16.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 06:52:49 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:52:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Tests failed with GIT_TEST_FAIL_PREREQS and/or
 GIT_TEST_PROTOCOL_VERSION
Message-ID: <YFC33vfLb36pRCO6@nand.local>
References: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3xRKfSXDd0ucO4zaM5_WZeQfq10Hqpyk3nL+Zw8ttgfN0ZhA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 16, 2021 at 10:45:20AM +0100, Son Luong Ngoc wrote:
> Hi folks,
>
> Running the test suit with GIT_TEST_FAIL_PREREQS=1 on master (and
> next) seem to result in some failures:

Ack, thanks for reporting.

> A quick git-bisect run seems to point back to this commit:
>
> 3b1ca60f8f317b483c8c1805ab500ff2b014cbec is the first bad commit
> commit 3b1ca60f8f317b483c8c1805ab500ff2b014cbec
> Author: Taylor Blau <me@ttaylorr.com>
> Date:   Tue Dec 8 17:03:14 2020 -0500

Hmm. I get a different result.

    $ cat run.sh
    #!/bin/sh
    make -j20 DEVELOPER=1 O=0 && cd t && GIT_TEST_FAIL_PREREQS=1 ./t5300-*.sh -i
    $ git bisect start
    $ git bisect bad
    $ git bisect good v2.30.0
    Bisecting: 453 revisions left to test after this (roughly 9 steps)
    $ git bisect run $PWD/run.sh
    [snip]
    a926c4b904bdc339568c2898af955cdc61b31542 is the first bad commit
    commit a926c4b904bdc339568c2898af955cdc61b31542
    Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    Date:   Thu Feb 11 02:53:51 2021 +0100

        tests: remove most uses of C_LOCALE_OUTPUT

>     ewah/ewah_bitmap.c: avoid open-coding ALLOC_GROW()

I'll take a look at what's going on here, but Ævar (cc'd) will probably
beat me to it.

Is it possible that your bisection script doesn't report success
properly? Bisecting the same range (v2.30.0..v2.31.0) with

    $ cat run.sh
    #!/bin/sh
    false

does say that my 3b1ca60f8f (ewah/ewah_bitmap.c: avoid open-coding
ALLOC_GROW(), 2020-12-08) is the first bad commit.

Thanks,
Taylor

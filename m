Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 09:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiCDJ2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiCDJ2w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 04:28:52 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F141154D24
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 01:28:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i11so9931325eda.9
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 01:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Zwej+a+bW4I98b6XLRNIucsdyyVEx7B3OztZWRt9QVQ=;
        b=pb/KsIv86TXH64VDyr2xmuO9lID9zQgECUCcTNOj5K4I7hUkSIqPn+2BStoSk7idow
         cqEwSP523D8de0F9gDDZRcwhmkGW5FrT2/VxvJUhR0vAqBCCuxCyiHGkEHZ3A0aHXoPm
         GF3YdZBbjb+xcQkuNihvQs7yVbujQCumv1umrex2oQZP2x45EwMivFd5pIL7ooUs4yhe
         wAC9nZIUXKvy6wVeKVY/+oSqxfe9S1wO21h4i2rPsx3kWtTWm7q23fKQRAm3IAdaYGbA
         8DLT1CoAHxe8E2Vbf1g1gDaGWsAUDZ3urxenEFIvgD3FBXAdbWrR0jTqRXyNk7u0TnUF
         L83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Zwej+a+bW4I98b6XLRNIucsdyyVEx7B3OztZWRt9QVQ=;
        b=ZjRFJuxpXNqcBvyyenxQILrwIwIOIjoFiGZBoMcHFRHae5U22Md5dfjCN42juySaoQ
         R73567TLRfNRcGQe36YxGFz6f+GOWcNEDRmm9JOhMnnq1JmBs9yoRl5UVUGD0vsnyl6d
         5V/kwKlRd1f+MMuo+1+PXU+5ej9VoYTaAarwHdeYsVaF8JUkEjA3DfCfIrwU4+z/HZlC
         0Lafjq2N4nCD+pGv2CCdsXhjF/pXONkxDZe10Ttvc3pZgQNsx2MBKQGSnzG3aVjO+Vai
         nHI4fAru3iC1Ngiq51+DUcVxoDwIB+Ta0MC8IpY5ODsL4Xna/sapE2APAgTnjTBeUNIS
         Lqag==
X-Gm-Message-State: AOAM533VYi4oLYPYTcmx1fBkDN/zizIz8QVPu9XN7P8CvlGpoW5Q4D9z
        gKkJ0sQs5RXhPRnjw0CJAOO7ik8FszzvOA==
X-Google-Smtp-Source: ABdhPJxHdS+bftZXvBMkbR5lSzxrY88vrM9lH8KZJXFHqpYhpHFI6JFJoD48nAwufc/WQBsuWsHRRw==
X-Received: by 2002:a05:6402:177b:b0:413:2822:1705 with SMTP id da27-20020a056402177b00b0041328221705mr38154941edb.270.1646386083334;
        Fri, 04 Mar 2022 01:28:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm1911330edb.73.2022.03.04.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 01:28:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ4ED-000Bk8-Ua;
        Fri, 04 Mar 2022 10:28:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
Date:   Fri, 04 Mar 2022 10:04:23 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
 <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
 <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqee3i2mlw.fsf_-_@gitster.g>
Message-ID: <220304.86mti6f4ny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Junio C Hamano wrote:

> GitHub CI seems to fail due to lack of "paste" for win+VS job.  This
> was somewhat unexpected, as our test scripts seem to make liberal
> use of "cut" that goes together with it.
>
>     https://github.com/git/git/runs/5415486631?check_suite_focus=true#step:5:6199
>
> The particular failure at the URL comes from the use of "paste" in
> 5ea4f3a5 (name-rev: use generation numbers if available,
> 2022-02-28), but it hardly is the first use of the command.  There
> is one use of it in t/aggregate-results.sh in 'master/main' already.

I think it's the first use, the t/aggregate-results.sh is run on
"DEFAULT_TEST_TARGET=test make -C t", but we use
"DEFAULT_TEST_TARGET=prove".

Re your upthread:

> I personally do not care about the initial latency when viewing the
> output from CI run that may have happened a few dozens of minutes
> ago (I do not sit in front of GitHub CI UI and wait until it
> finishes). 

I think this URL is a good example of what I noted in [1]. Your link
loads relatively quickly, but I then saw a "linux-TEST-vars" failure and
clicked on it, wanting to see why that fails.

It opens relatively quickly, but no failure can be seen. It stalls with
a spinner next to "t/run-build-and-test.sh", and stalled like that for
75[2] seconds before finally loading past line ~3.5k to line ~70k
showing the relevant failure in t6120*.sh.

I really don't think it's a reasonable claim to say that only "veterans"
of git development[3] are likely to find the workflow of seeing a CI
failure right away useful, or wanting to browse through the N different
"job" failures without having to pre-open them, go find something else
to do, then come back to it etc.

I also noted in [1] that it takes a lot more CPU now, so even if that is
your workflow for looking at CI you'll need a fairly performant machine
if you have a few job failures (which isn't a typical), as each tab will
be pegging a CPU core at ~100% for a while.

I have fairly normally spec'd quad-core laptop that I almost never hear,
and this new CI UI is pretty reliable in making it sound as though it's
about to take flight.

1. https://lore.kernel.org/git/220222.86tucr6kz5.gmgdl@evledraar.gmail.com/
2. I reported large N seconds, but nothing so bad before. For some reason
   this one's particularly bad, but in [1] it was the same CPU use with ~20s
   etc (but that one was 1/2 the amount of lines)
3. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2203011111150.11118@tvgsbejvaqbjf.bet/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9771F453
	for <e@80x24.org>; Mon, 29 Oct 2018 03:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeJ2Mbx (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 08:31:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35130 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbeJ2Mbx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 08:31:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so7066203wrt.2
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 20:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=jVvxh/VCL5IJ/bnSZ+DE8hTNHRcF44dxuVuPkNUKvdk=;
        b=bTUI+qBrqjrDboLN3Rw0fGgVCaIZO03GzLS4QvCPbdVFIPtwVkQmhj64eFYHp//8rm
         eiI866R11M07sMLqKmW9PfsAZeGW8640DG8gCAKwFneaoGJQziF5dPEcKOn5igLKE79E
         aV/UI00c5P+KPLvvJ+tA0u10va9mrXc6bmlA8zyrwqRWgIVIZka+2+RtNLLWFaKelM5h
         WUdYjS08vzbiCIfKde4++PfM6TltxgtrOwfL8RgpE9URc0pOPlXbk7nigYgrZ1oN1yGu
         0h6hk8FCRyZ6hc+e0MCTbjC+iZzU6GKeu89+cFS/o+mHRauDMmcvPKEI25p61X84UDRc
         pjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=jVvxh/VCL5IJ/bnSZ+DE8hTNHRcF44dxuVuPkNUKvdk=;
        b=hozHNZxisQIiH/a7ZOB+yuU0GfEQIuJh+mb1Y1C9rPiG7ay2xQsMkMkRfKGbnuo5aB
         4BMQhiBKSing/AotlCa7RpoYsMdK9boSvWRWhNaQjYmxvRS0Rm0GbGIXOVj8w5UFkqIi
         EnTaeaxtn6gFGq+5EktqoSwsf/iG7Xt7nBB0YEla2kD8jG/Fonep+Yo8kNwdmyP/OVMl
         GaQkZANOsPmAs+qTrumC5mIIcfsJxIVw/4vKd+snqc9Nk9/ogkG1dl1sydRsX9YTIwvx
         Be9lwpI7M4XjHe9xMgvtAIIR5GI2P/e9ljn9I9GklSnF5wGJ2DqkNuUrKt4Um6W1Zhvr
         4A/Q==
X-Gm-Message-State: AGRZ1gLck7n2PmnA2JUe5GedFmWGbfYUvYSjxLygoaaah9lape5EIi0R
        vsHBpmiqTcoFpYuPKUgeiCpR7mMIbh0=
X-Google-Smtp-Source: AJdET5ejkwNRFa+iagkMCGxUyY7YEkpdRjUSnxr2evhbKeR7cklVcPf//t6etzuHaAqxNJu0SZwrBg==
X-Received: by 2002:adf:8065:: with SMTP id 92-v6mr12753708wrk.23.1540784700337;
        Sun, 28 Oct 2018 20:45:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 191-v6sm11021606wmk.30.2018.10.28.20.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:44:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] alias: detect loops in mixed execution mode
References: <87o9dar9qc.fsf@evledraar.gmail.com>
        <20181018225739.28857-1-avarab@gmail.com>
        <20181019220755.GA31563@sigill.intra.peff.net>
        <87ftx0dg4r.fsf@evledraar.gmail.com>
        <20181020185852.GA6234@sigill.intra.peff.net>
        <20181026083905.GA1705@sigill.intra.peff.net>
Date:   Mon, 29 Oct 2018 12:44:58 +0900
Message-ID: <xmqqefc976x1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmph. So I was speaking before purely hypothetically, but now that your
> patch is in 'next', it is part of my daily build. And indeed, I hit a
> false positive within 5 minutes of building it. ;)

Sounds like somebody is having not-so-fun-a-time having "I told you
so" moment.  The 'dotgit' thing already feels bit convoluted but I
would say that it is still within the realm of reasonable workflow
elements.

> ...
> With your patch, step 3 complains:
>
>   $ git dotgit ll
>   fatal: alias loop detected: expansion of 'dotgit' does not terminate:
>   dotgit <==
>   ll ==>
>
> So I would really prefer a depth counter that can be set sufficiently
> high to make this case work. ;)

Sounds like a concrete enough case to demonstrate why one-level deep
loop detector is not sufficient X-<.

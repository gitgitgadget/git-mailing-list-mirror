Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 000311F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeGFVfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:35:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38676 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753714AbeGFVfc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:35:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so15513488wmf.3
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mafn8YpPnkDK7oNfm2L3fB/Pa4iyPootvKtwEjqtQaY=;
        b=vhKLanY/XWFFtMSKNYzrPiuk9a4WkhnXR/deFIywdNB4bghDkIUdAKzR3KCLE2BxlR
         /Rxh0meaIZwpb270Cgx7TAmhWAKASlr8h5juXTcmYLf7hfJHPUDRyZp8knjz/Z3Emjg5
         /F/J3+QNR+EiXk8XES5JBmo3TUvHELzlf2WHxuqINVfmXi04JuF7DU8FaR54GuBhyEan
         0oLYHl+1G5WUqVO3E/BjHPGKoKxEubaBjTZ9gHy966tsTUl+RTiNYxwwgPxmgfS0DdTf
         xBnPaRwr6m/Di2KQaBIcZ7X0OmgNneGkQkHefj8JocbSlhOujVQJV7C0iGzXufV9vC9Y
         FvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mafn8YpPnkDK7oNfm2L3fB/Pa4iyPootvKtwEjqtQaY=;
        b=SiU0gkiCvqClzNRmsTr+nroxfVJkssjvUp8oIseeRHOeCN+xvw3qlI/DeJ6Np3H3W/
         13rA2C/wT9pOt9mF+J7LNB5NSDpS3W563KveFHHDqDu1Vyspu64sNUJYW8/z/wzJzIz2
         ZF4B2LP7b5VKU2pthMC7RkHSdh0/9iqVZ3gR8D7Ua/K6ogzxwPjKYxaug/H0BG3AGRcI
         1ONaHoi1PU1tuVAfF+fbJqE9B92VgF2ArRQ5PQlwM/XFBQm6uP7p9rWfQa+zv7bLF9Ry
         vaEvDKfMYGNW8vmypRS6SMnK4FfZw4Gf9mcZGh2shO9pOgify320FoSx6NW413iTsrg4
         JGyQ==
X-Gm-Message-State: APt69E0YDGOsyWVul5MJiA9DP3wzD99/lpSAa0XiBzORyoLvDwp40M/m
        tNheKCfw4Tn6pko9aehyAJc=
X-Google-Smtp-Source: AAOMgpeUGfSwtQ6EY2xHd/q0Kt2NPOQBbPQ41W5ACTLgqmDOsChT95O5WhorViKfMjD6yNKljAZnMw==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr7147277wme.20.1530912930731;
        Fri, 06 Jul 2018 14:35:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i14-v6sm7186375wro.11.2018.07.06.14.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:35:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] builtin/receive-pack: use check_signature from gpg-interface
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1530616446.git.henning.schild@siemens.com>
        <xmqqsh4wjg7b.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 06 Jul 2018 14:35:29 -0700
In-Reply-To: <xmqqsh4wjg7b.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 06 Jul 2018 12:51:20 -0700")
Message-ID: <xmqqk1q8hwta.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Henning Schild <henning.schild@siemens.com> writes:
>
>> The combination of verify_signed_buffer followed by parse_gpg_output is
>> available as check_signature. Use that instead of implementing it again.
>>
>> Signed-off-by: Henning Schild <henning.schild@siemens.com>
>> ---
>
> Makes sense.  
>
> When d05b9618 ("receive-pack: GPG-validate push certificates",
> 2014-08-14) implemented the check, there wasn't check_signature()
> available.  The commit probably should have done what a4cc18f2
> ("verify-tag: share code with verify-commit", 2015-06-21) later did
> to introduce the check_signature() function by factoring it out of
> commit.c::check_commit_signature() as a preparatory step.
>
> Will queue.  Thanks.

Well, I guess I won't queue this version that would waste others'
time, as you'd be rerolling to update variable names and such, so
I'd wait for that (and you in turn would wait for the names and
other discussions to settle).

Thanks anyway.


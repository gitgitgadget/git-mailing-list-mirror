Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF2C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 13:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhLHNKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbhLHNKc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 08:10:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF91C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 05:07:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l25so8059937eda.11
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 05:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=2hiAPTM5i0+RsXVVJqBMJ4cJtkoDkDeipvr88i+5WWc=;
        b=fUUBZbFZnnztolkL29V3aGefmlP5nJfIoKsV/hERgvsvxSYOUtTzSCTwxPFL0e8cyC
         fLvW6ipoRmkEbXmUOeU0mkXDgVoTdlRxJ3qqr0VWh+VTVO03SY0M5xrQEXtwTouJlm/K
         JLcNM8oqqwFRDggdlY8jyU9M2U6wrMJHOPgRJaiaqROPRk2R8VXm/Dq6KMawylR41apN
         YlT5VuqiZbJeqZDa2t0KGHI8+ECBi5KYzfPsOODjcOwg0PZ0IkFA2YO/gd0LMJi/5Y9B
         +ItLvXbgR4ACHd1NWHjmoyC1zb3haNr5z1uBLnhU5Fy5cs1AAP2GJHwf52FCtbk/fcMA
         sJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=2hiAPTM5i0+RsXVVJqBMJ4cJtkoDkDeipvr88i+5WWc=;
        b=CR5Yzk6xLR3l9SM8GVY9UC0dzzRgryOBuQHDfMUY62qzNrXyC414L0+D+hjnup2kZk
         2dzmDBY9QxYb2hi9GGRB1fMnPIz/FEMevWmydPm6WrNzgDwASeAPMuOuir8ysGgnq4cs
         a/ehNRnzZUi1ZeO5fIVEFQ3XcZHhn25KwUONff65UqMSLetTAhuIXm50dx73oYwMfCKj
         ht9zJu1+8APhHczdTKScPtmtzQ/hAuLRPO4AjjD3fB34gTbPLjPiqg+QRT/so1D1LqmT
         r6bq04jG4+y6/HELZDLb1ph3Lnu2bPaMzdOaa2kchmPOz4mWYW2DX/G2ZVu8sMAMTMy4
         13IA==
X-Gm-Message-State: AOAM531WaXdY38VXVyZb5K2LPkBGir/iIHwC7EouU7Vl3P4shKwYY/Vj
        yCR+WNp4d09rpAZSoHp4dC0=
X-Google-Smtp-Source: ABdhPJw+K5YdXJdUYtKNsidRJd2Yvoo7EpyrCdX/wyuTmYQNecNqPYvLKbCS3R4pINElnZju6/mw3g==
X-Received: by 2002:a50:fb16:: with SMTP id d22mr19292648edq.367.1638968818611;
        Wed, 08 Dec 2021 05:06:58 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y15sm2387177eda.13.2021.12.08.05.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:06:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muwev-001QkC-9e;
        Wed, 08 Dec 2021 14:06:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
Date:   Wed, 08 Dec 2021 14:04:53 +0100
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
Message-ID: <211208.86k0gfkzym.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Johannes Schindelin wrote:

> Hi Junio,
>
> On Sun, 5 Dec 2021, Junio C Hamano wrote:
>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > From your wording it sounds like the plan might not include moving
>> > these tests over.  Perhaps it doesn't make sense to move them all
>> > over, but since they've caught problems in both Scalar and core Git,
>> > it would be nice to see many of those tests come to Git as well as
>> > part of a future follow on series.
>>
>> Yeah, we may be initially queuing this without tests for expediency,
>> but a production code cannot go forever without CI tests to ensure
>> continued code health.  People make changes in other parts of the
>> system Scalar may depend on and unknowingly break some assumption
>> Scalar makes on it.
>
> The Scalar Functional Tests were designed with Azure Repos in mind, i.e.
> they specifically verify that the `gvfs-helper` (emulating Partial Clone
> using the predecessor of Partial Clone, the GVFS protocol) manages to
> access the repositories in the intended way.
>
> I do not know off-hand how entangled the GVFS part is in the test suite,
> but from what I recall, every single test starts with cloning a test
> repository. From Azure Repos. Using the `gvfs-helper`.
>
> Which means that the `gvfs-helper` would need to be upstreamed and be
> maintained in the git.git repository proper.
>
> Previously I was under the impression that that might be met with grumpy
> rejection.
>
> I do realize, though, that clarity of intention has been missing from this
> mail thread all around, so let me ask point blank: Junio, do you want me
> to include upstreaming `gvfs-helper` in the overall Scalar plan?

An alternate way would be be to have our own tests build git, and then
clone and build those third party repos and test them.

I had a patch to do that for git-annex. I think it would be a good idea
to pursue it in general for prominent downstream projects as part of
some extended integration testing:
https://lore.kernel.org/git/20170516203712.15921-1-avarab@gmail.com/

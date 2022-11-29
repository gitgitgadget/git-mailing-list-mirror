Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D735AC4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 02:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiK2Cii (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 21:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiK2Cie (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 21:38:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AF31EF2
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 18:38:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mv18so11380958pjb.0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 18:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6qmqe/qD1weelfEdDrdJ8e99VEDCbl2CDW3gzgiHj4=;
        b=GfDnJfurjRyROdO51OzKkiaj7dOARyG2R0lXek8TdUWrJ3DGSbm1FwDzHEYR8JiSan
         BcK7isLDhO7xxRWHhpffB2E3FpWHlzXWUjfoGH659NL/3d1DC9YPceGZUDH2kWuxeG2c
         P4jZYg4pg0xVxixPrHh7J8eZkM/nkoGVZ5WQ9KjJcG5D11xrJFyxBsibnfXCmfCoV2BW
         Vh9N9OYhYOjGj/YtGWCTrpyPQItmjiXTkgbr1ts5lNrHrtEGGJ6WK88G32+9bkjWAMnz
         5FjMwEzfUOwcG3y45Ea14hjNT1D3tOd+w883M17IQ0SSOTAa9bXjvUX68LbiBBSkAbCp
         tZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6qmqe/qD1weelfEdDrdJ8e99VEDCbl2CDW3gzgiHj4=;
        b=axhm+B8IYtxSPqgN0M4fF9c4ZzINCC0egnXiGcLrjj1KsyUYX6oyMeMCJvdyJcnKVJ
         cEbx3ZHy6sAb9PwiZy6Ae3x4opKSFiXpM8fWWkj3d8b9xo5yLTvU0ANuy00+K+CTT3e5
         PYG251Jq9KCHTmnfvYHi4Aqws5xq1AkURnWX28nGsfz1O5B/a0dT6VPrpK58KmNv80nH
         zVUFQKnxgg2DULmK56378isD3yupK1xkT52fHeJmojBqlwODQNNxXCv3oq2jm+hqPquU
         9O0l6mSn5qVSds7PvxcDZH0QVwSxuX2cgZ4igPMvxPxce15QpAejQ36CWIjBarTvauch
         Yulg==
X-Gm-Message-State: ANoB5pmYcWNJBIX77+YZwSPkIZdxxYcA4rkAeWvKz59tc/vx4u5fE8AS
        Ik8ZiGV8Wtz1G7nyPRVNqmw=
X-Google-Smtp-Source: AA0mqf5hD1iAGjRlNhsQwiS2j9xEe7apYEH0rP0PaaYJjh21Hym1yTOjrEP4C8Te7+CltGGEaCY2Lg==
X-Received: by 2002:a17:90a:aa93:b0:218:94ff:ce1f with SMTP id l19-20020a17090aaa9300b0021894ffce1fmr48661047pjq.217.1669689513351;
        Mon, 28 Nov 2022 18:38:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b00189548573a2sm9593802plg.161.2022.11.28.18.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 18:38:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Cc:     git@vger.kernel.org, Alison Winters <alisonatwork@outlook.com>
Subject: Re: [PATCH 0/2] add case insensitivity option to bash completion
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
Date:   Tue, 29 Nov 2022 11:38:32 +0900
In-Reply-To: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com> (Alison
        Winters via GitGitGadget's message of "Sat, 05 Nov 2022 17:28:33
        +0000")
Message-ID: <xmqqedtm4h93.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alison Winters via GitGitGadget" <gitgitgadget@gmail.com> writes:

> In 3bb16a8bf2 (tag, branch, for-each-ref: add --ignore-case for sorting and
> filtering, 2016-12-04), support was added for filtering and sorting refs in
> a case insensitive way. This is a behavior that seems appropriate to enable
> with shell completion. Many shells provide case insensitive completion as an
> option, even on filesystems that remain case sensitive.
>
> This patch adds a new variable that, when set, will allow Bash completion to
> use the --ignore-case option to match refs. Additionally, some basic support
> is implemented to match pseudorefs like HEAD.

I did not try to figure out the reason but the topic with its tests
seem to break in 'seen' the linux-cmake-ctest CI job.

  https://github.com/git/git/actions/runs/3570230611/jobs/6001013549

but the same test does not break under usual "make test".

Can people who are interested in the cmake-ctest stuff take a look?

It is tempting to eject the ab/cmake-nix-and-ci topic that is
already in 'next', under the theory that what that topic does to the
tests "works" for some tests but not for others, and this topic is
an unfortunate collateral damage whose tests weren't something the
other topic supports well.  If the cmake-ctest stuff is in such a
shape, then it may have been a bit premature to merge it down.

Thanks.

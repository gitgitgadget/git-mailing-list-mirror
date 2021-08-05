Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C4C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 03:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B06561073
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 03:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhHEDBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 23:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhHEDBo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 23:01:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2CCC0613C1
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 20:01:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ec13so6320655edb.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 20:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OoP5flbwFH35JkLoyafRyF0AcJosKEAHZTOwGTPcQ+k=;
        b=LdgspTzPqImtTbcxEsJL9FhrAvnPNcVIYscDjhTYUvJZFD/XgZPBN4379xiUVwPmG4
         W5nBC/dlDQ9uWaPxLPKWD1wrEwofKdbazoaTVOS15sxoAfDG04YfJSfTidNLfF8rLhtq
         bYFUF+7ErqVE87vzWU6QHQLvLH6AeuPVK64jviigK343PtcIZylJlm8HkYwO0wJsG0SW
         3QykVKjJzuOw1iTcZPuDd0oXZ2/3hbg5uQGxBz9eBg8gC5ZqjyMRK8hnQWfG6UXHudqW
         PVQMVqoe+z+bs2tcOyCkDs5HWZHNiAEVA8SVkj8BLPK3lY19aIsnvYzuhD8hjIw/D7+W
         uvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OoP5flbwFH35JkLoyafRyF0AcJosKEAHZTOwGTPcQ+k=;
        b=X/rC+eUvWZ5YhJ+4L3xnR6ttpFswOkPbA8eSPDOszpoudV4O78DpOX4deURyCoWgQ3
         NyGdkEqHcYBu6/o4y4oc6Wq+ctHweABsZhKNIwPLoG/NBCoUI5sq9VKuxaANXKxznU8j
         qacESU5zDEyblfRGaVfK2huNEfXFLnBwim3XH1dr5cxgfqERErGEo0STr/HcYeccoo1B
         dXn4gNbw3bMocbf9IQAsuHOeR6CpiiSim30e1demZ4vSnkZ45p2bmbIxfTKGc+hxUs6J
         d4gVs2OLu5Bfrcnwfh6a65FRImGjyVPxcWc/0OWKZYxyUBW1n4BCvPXpquXqSHP3WiYF
         QIfw==
X-Gm-Message-State: AOAM533ZqEVigURppMp1yCAfW1L1zF8J0aYF1rvQUUVS8XpD9nAWYMZU
        oG1s7Bzmc+jT4EDUs4oq+W8=
X-Google-Smtp-Source: ABdhPJytHDnRKtN7cu6JA0hhcPnQ+FOpqZkwJg48QZGBh8aZhU6k/F7WyVfai96cho342fLywYxuzg==
X-Received: by 2002:aa7:db15:: with SMTP id t21mr3489612eds.261.1628132488320;
        Wed, 04 Aug 2021 20:01:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p18sm1662242edu.8.2021.08.04.20.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 20:01:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Date:   Thu, 05 Aug 2021 04:53:12 +0200
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com> <xmqq4kc5ozi7.fsf@gitster.g>
 <87lf5hm0v7.fsf@evledraar.gmail.com> <20210804212825.GH23408@szeder.dev>
 <87fsvon5xm.fsf@evledraar.gmail.com> <xmqq4kc4myme.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq4kc4myme.fsf@gitster.g>
Message-ID: <871r78mw6w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> By narrowly targeting a fix at one specific shell's cleverness around
>> COLUMNS we'll leave open a window where we'll fail on other shells if
>> they introduce similar cleverness.
>>
>> It hardly seems like a stretch that once bash starts doing that sort of
>> thing other shells might think to follow suit, and all have their own
>> non-standard way to turn it off.
>
> Hmph. Wouldn't the same argument apply to the much simpler single
> liner "shopt -u" solution?  When writing new tests, there is nothing
> to remember, and a new shell that needs a different trick to defeat
> the auto-COLUMNS would be detected quickly by running the tests in a
> terminal whose width is different from 80, no?

It's different in the "bisecting" case I mentioned. I.e. "shopt -u" is a
shell-specific solution, the approach I'm suggesting bypasses any sort
of shell-specific solutions, both current and future ones.


>> You also didn't address the other rationale for it, namely that it's
>> also future-proofing us for submarine breakages in non-git programs
>> which'll understand the new COLUMNS=3D10, but not GIT_TEST_COLUMNS=3D80.
>
> Isn't that another downside of the approach you are advocating?
>
> If we make Git rely on GIT_TEST_COLUMNS, we may honor it while
> everybody else ignores it.  If we only have to deal with COLUMNS
> like everybody else does, Git and other tools that are used in our
> tests will be affected the same way by overly-clever shells, no?

I think it's an upside. We know how git handles the combination of
GIT_TEST_COLUMNS, COLUMNS and TIOCGWINSZ. We have no idea how any
third-party program decides to behave.

So by intentionally spoiling COLUMNS=3D* and only having our tests pay
attention to GIT_TEST_COLUMNS we pretty much guarantee that we won't
grow some dependency on a non-git program's handling of COLUMNS, which
e.g. could differ from platform to platform.

I don't know about any such case, and spoiling COLUMNS didn't reveal
any. I just thought it was worthwhile to once-and-for-all get us away
from any sort of shell or 3rd party code cleverness around COLUMNS, as
opposed to a very narrow bugfix for just the issue we've spotted with
bash recently.

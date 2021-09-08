Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEE4C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AF461100
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350667AbhIHTcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350652AbhIHTck (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:32:40 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1015C06175F
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:31:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id x11so6478533ejv.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fvGTVcXSxKv3mYvVL4q5Jh5RgCDLhz0niJVwvJ17fK4=;
        b=CCLfIQ2jVkZC/M5ATUzMLJYtLXBt5NBPk+hTZzIbSHaZkeSCka8IsAeplnxWlubaT8
         Ved1CGBZwZGcikFAsbW9FyRAnQpx8TDSKCD9uIEmGhnYUDRfd96urc+zq7Qddc7qQnet
         WbvaEsrNhsGT5kxkG9/3TL9NjPjWbNJsWdlWmwcdfgVaGl1mIcFDJCEfQ/VaPCx+LyCH
         PXvJoq2ivtz4sTaJy//zGqm3xOtxyev9G8IwwGpfmIrknSMj3PoPVvKLfY7px9Aw1x3J
         l/+BR38nAaGIyB8SUrpeRfOc/lxpRXbwfKUF9lLLV9O41IR7w8YwjC5DRQT/tKWWgE+P
         H0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fvGTVcXSxKv3mYvVL4q5Jh5RgCDLhz0niJVwvJ17fK4=;
        b=ifcqbNsnhLyEhLEcF2ujlv8cyDVLPOP+tLmp0Yu791z3lIYWwCYK3kn9ict6ElOo3S
         qkkBFsUAehL5oQ+Ytz7KRQS+aGX/lBRw6ZorJiL0Hq5nQILWXbWKjefJLBQLkz+TXVn0
         qz1ScnFsbQAeWq46oQaox+d4ZPgZEbSZhFf/b9uh/CcRh18LVh3gGIcoqDDMZM0OaQYM
         8bFsLFbeq8BWjYmWtPQnJ6Xkbqbx7fQjLXoh2i9Hi4dgtWznPeBF81mYMfI3Gu9PMFJ6
         UreZq05W/Az4urqjULxzxnF+KuGzhoBxqLZ6zSMokvfCAcvcOrn7gniV1NqUDPpuBLsl
         9ppQ==
X-Gm-Message-State: AOAM532eTq1rACUaUZvwBGIxnSDO+pYLgGt7MdO3KfAc0g1+Fkbwh5r7
        iVqwu2VRd4LsrKwYo11/xLU=
X-Google-Smtp-Source: ABdhPJwmG6mm0dTaJWZZ3c9qEDn8ZYqD4MQiROJ4h1IWdJnuDzizToQVHLsw3yWHOps8YZCB0nSdYQ==
X-Received: by 2002:a17:906:63ca:: with SMTP id u10mr1502444ejk.411.1631129490165;
        Wed, 08 Sep 2021 12:31:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm1sm1514994ejb.38.2021.09.08.12.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:31:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
Date:   Wed, 08 Sep 2021 21:23:05 +0200
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
 <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com>
 <xmqqmton7ehn.fsf@gitster.g>
 <CANQDOddQsf4Jj+634mdnJXaPG=2idCbCHd1iXO2qm1EMGcDmXg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CANQDOddQsf4Jj+634mdnJXaPG=2idCbCHd1iXO2qm1EMGcDmXg@mail.gmail.com>
Message-ID: <87k0jqhnji.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 08 2021, Neeraj Singh wrote:

> On Tue, Sep 7, 2021 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Neeraj Singh <nksingh85@gmail.com> writes:
>>
>> > BTW, I updated the github PR to enable batch mode everywhere, and all
>> > the tests passed, which is good news to me.
>>
>> I doubt that fsyncObjectFiles is something we can reliably test in
>> CI, either with the new batched thing or with the original "when we
>> close one, make sure the changes hit the disk platter" approach.  So
>> I am not sure what conclusion we should draw from such an experiment,
>> other than "ok, it compiles cleanly."  After all, unless we cause
>> system crashes, what we thought we have written and close(2) would
>> be seen by another process that we spawn after that, with or without
>> sync, no?
>
> The main failure mode I was worried about is that some test or other part
> of Git is relying on a loose object being immediately available after it is
> added to the ODB. With batch mode, the loose objects aren't actually
> available until the bulk checkin is unplugged.
>
> I agree that it is not easy to test whether the data is actually going
> to durable
> storage at the expected time.  FWIW, I did take a disk IO trace on Windows to
> verify that we are issuing disk writes and flushes at the right time.
> But that's a
> one-time test that would be hard to make automated.

I have some semi-related patches I need to dig up and finish sometime
which add a "git gc" test mode to the test suite, i.e. any time we call
"git gc --auto" it will go ahead and actually run, and some adversarial
options to run always, right away, prune with --expire=now. It found
some false positives, but also some genuine races and bugs at the time.

Similarly, I think a good longer term goal for better fsync() and data
integrity in git is to refactor the various codepaths where we write to
disk (grepping for fsync_or_die() is a good start to find those) to all
live in one place, we could then easily instrument that code to run in a
hostile test mode.

E.g. make anything that expects to write out a "foo" file actually write
out "foo.not-synced-yet" as long as fsync() etc. hasn't been called, or
with signals/timers/atexit() handlers fake up known FS edge cases such
as a write of "foo" only renaming "foo.not-synced-yet" to "foo" 1s after
the last close() call not followed by an fsync, etc.

Anyway, I expect given your occupation that you may have better ideas in
that area, presumably needing to instrument and test behavior under I/O
pressure, deferred syncs etc. is something mature FS's need to deal with
as part of their own regression tests...

1. https://lore.kernel.org/git/cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com/

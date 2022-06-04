Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23319C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiFDQfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238573AbiFDQfD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 12:35:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB1D4EA15
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 09:35:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so14114495ejx.3
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iwqhYQCjOJ1/jBKtwQDHNj7hymae4XmERKiu+Zk7OEQ=;
        b=XmRvGsZjfSUYeBxsNr6QTQXW8iYv8GRtj6hnyB7+emA+jUQj1Nwv/hMurt/0CKBi9b
         +XeZKW88oUGU+SuhxRdiCWN41Wgt6sP35GdpfNO6IV/rWQhVoTBnmdNjDVjayj9LzuR7
         Lr0d58NAl6ZkWWprsya8mvrRHMQgPL9eBhnsip+Ohv2M0QE5HOu0i3Z64zNM6kh155z6
         YBUserTgZQaFhSYkBCVpNVrIDlj6kDBPHjJAA+wwLowYWgHAtIHW5rgiDrDDUoQrkmVn
         Eq79svdNiWwuIS/gXeBCQvayz0iNW1vdju+dmwwfM1WEMO6DpeZULSFq46+ow0Y5nHJE
         qtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iwqhYQCjOJ1/jBKtwQDHNj7hymae4XmERKiu+Zk7OEQ=;
        b=sim2KT5ZPfZqddf1DxUZR2SR6wkuyZitL+bWybhrCzPmb4iTOtycuaYQi2T/J4Hweu
         EZvDW0misCEu0+Gk1bUAfmtWxHlEOlZNpvYRVYE6wt3g5V8okaob+/nSri0k+kEMRX0a
         pSjQHkITje6UtFMo4SZPkTnZsI2dC/3Rkx5w2qlEKAwog4+MkMKJOMHPZncPcbZyx0Kt
         g4nQB0ag+6a2U10yn1VjtD/rr6OHL6s7SCL3EH2OjU7I/sE6i5L04FZCEVzFqTxc8dmz
         z9SPyFU4iTY06m5qj/SYtSD/y0eYbBrCz5imengAGL3qs4i9/Bnx90azfE+yKnEfNSGE
         JMdA==
X-Gm-Message-State: AOAM530fffN8NGLElaySr5XzeTyc7fJRTNWpF2V+Qpt+Iepo1r8q5ydC
        kYOwzP0EcVidRMmaPkhTdj0=
X-Google-Smtp-Source: ABdhPJyOFhU1nwKbfbqupHuvzLCTgxNHLEZHxxfZfr22+8mm+5atmIwlk6bHmzi14uuhFKVDxLv/gw==
X-Received: by 2002:a17:906:1492:b0:70e:294c:c37e with SMTP id x18-20020a170906149200b0070e294cc37emr7916343ejc.574.1654360500959;
        Sat, 04 Jun 2022 09:35:00 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y22-20020aa7ca16000000b0042dcbc3f302sm5614919eds.36.2022.06.04.09.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 09:35:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxWjr-0020Sm-Jg;
        Sat, 04 Jun 2022 18:34:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Date:   Sat, 04 Jun 2022 18:23:13 +0200
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
 <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
 <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
 <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
Message-ID: <220604.868rqcwfnw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 04 2022, Ren=C3=A9 Scharfe wrote:

> Am 04.06.22 um 02:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> To your comment here & some others (e.g. FREE_AND_NULL()): I was really
>> trying to focus on narrowly addressing these -fanalyzer issues without
>> digressing into the larger topics "what is this code *really* doing, and
>> does it make sense?". It was pretty unavoidable in 13/15 though.
>>
>> Which isn't to say that I shouldn't fix some of it, e.g. your
>> s/return/BUG()/ suggestion, but I think it's best to view these patches
>> with an eye towards us already having these issues, and in most cases
>> making -fanalyzer happy is a small cost.
>>
>> And by doing so and getting a "clean build" we'll be able to turn it on
>> in CI, and thus notice when we run into new -fanalyzer issues.
>
> Future analyzer reports are likely of the same quality as the current
> ones.  If the goal is to shush them then we should just not use the
> analyzer.  If reports contain a helpful signal, e.g. pointing to a real
> bug or to overly complicated code, then we better address these issues.
>
> We can think about automating the analyzer once we have a certain number
> of commits with improvements that would not have been made without it.

We might decide not to go with -fanalyzer in CI or whatever, but I
really think that your line of reasoning here is just the wrong way to
evaluate the cost/benefit of -fanalyzer, a new warning or whatever.

There's ~15 commits in this series addressing things -fanalyzer brought
up, and it would be ~20 if the remaining issues I punted on were
addressed.

The question shouldn't be whether those things in particular were worth
the effort, but whether the added safety of getting the new diagnostic
going forward is worth the one-time cost.

Some of these commits are fixing issues going back to 2007-ish, $(git
log --no-merges --oneline -- '*.[ch]' | wc -l) is ~25k lines. And
looking at it like that 20/25K isn't that bad of a ratio :)

FWIW I spotted a couple of bugs in my own unsubmitted code from running
all of it through -fanalyzer, and that POV is also worth thinking about,
i.e. it's not just about improving git's current code, or even commits
that might land in git.git in the future.

But also to provide a development aid so that when we're writing patches
we spot issues earlier, even if they're ones we might spot before we
send the patch, or in review before it gets applied.

It's also a much faster way of spotting certain issues, if you take into
account that we've already been spotting some of these with the likes of
SANITIZE=3Daddress, valgrind runs, or coverity.

I find the warning output from -fanalyzer to be *really useful*. It's
scarily verbose at first, but it's basically doing most of the work for
you in terms of exhaustively describing how the control flow got to a
given location. With e.g. SANITIZE=3Daddress and valgrind (to the extent
that they overlap) you might get a stacktrace or two, but you generally
have to chase all that down yourself.


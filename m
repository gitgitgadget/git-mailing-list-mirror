Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF63C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126A224698
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 07:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N390d3kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgKSHfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKSHfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 02:35:15 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AEDC0613CF
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 23:35:15 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lv15so634693ejb.12
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 23:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Oo8Dw6H1jD2LC7+wha0hIE/SZPf6LQKcTPRztk928ww=;
        b=N390d3kvvohKWUqIgroVAC5icY3W04M8pdGaU/qXTfRrLL2YRZw57rSdGOoogHijpE
         CExAndUzj8vPp28p0HaAt6i+/utbH2HKsQTzkFtFW5jLMLUbqjO6Pu/7bTkMsVwKfDZn
         +LAdFLu+d3UPvZJWO89tCeS1oZ3GOx1hWNwtG+VB2KsjK4XUqagoY+yXz5mRNl1tmYac
         qEiel2B6IvWRwM26gZENKroxF8evLyDIC55DAdqd8mu2lDvMMWBiYA4+8+suwWb4h3LG
         9rcY2C6QJlxfdl1qPQxnGE6q9O8MKjUyOsdBQqeIZ/JS4McKwDpDVnfcj/K1DgNQdmUX
         wMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Oo8Dw6H1jD2LC7+wha0hIE/SZPf6LQKcTPRztk928ww=;
        b=FAXkviWdSJaQQ2ZHzkbhlGUWuQ1MF6BRry+Gxw0m5GFzLCaiRNSFHorNe6z+k+nhgn
         yPc8ESdvrd63IuyzgU0FSr1s/5gy4flfjVbRJE+LZJ5t9MiBzY5w5rW1XKA3OgHIJk97
         ZrKbVtBF3TaEqXr+f4wCf9KeQsisAHKD2MMllCNYsjlAMFpCJxJnG0gl095qzpL6m6Pi
         28fiOR4+89f94UR1MeufphVjEuU6qkkFInhaBjHYKBhDeyvszedFUdJIz+LR4rI6MOTt
         bJMt720hljd8sx2uvxgZCaKwp3Oh6Xvuo5WDZLoWSW8YeCTkZo0DDHvqyA6CYx4FK/Gf
         QYNQ==
X-Gm-Message-State: AOAM531SHp/xJzMl77yCDReJAee6flJJYvcs9PrFQZuiun8eeU+hFF6a
        67ITRQiyM0P/eO1gPhX35CA=
X-Google-Smtp-Source: ABdhPJyyNVkbd9641xpmtLkKz/5IsyHKBuZrrPekTuHn9shFmu6qj1mKAd4J++q1YNFnW/9SbbbF4Q==
X-Received: by 2002:a17:906:4104:: with SMTP id j4mr28320914ejk.439.1605771313648;
        Wed, 18 Nov 2020 23:35:13 -0800 (PST)
Received: from evledraar (ip18-11-210-87.adsl2.static.versatel.nl. [87.210.11.18])
        by smtp.gmail.com with ESMTPSA id fy4sm2817415ejb.91.2020.11.18.23.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 23:35:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1309: use a non-loaded branch name in the `onbranch` test cases
References: <pull.791.git.1605709410465.gitgitgadget@gmail.com> <87a6vera3q.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2011190107160.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <nycvar.QRO.7.76.6.2011190107160.56@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Nov 2020 08:35:12 +0100
Message-ID: <874kllre8f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 19 2020, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 18 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Nov 18 2020, Johannes Schindelin via GitGitGadget wrote:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > The `onbranch` test cases in question do not actually want to include
>> > anything; Instead, they want to verify that the `onbranch` code path
>> > does not regress in the early-config case or in the non-Git case, where
>> > the `onbranch` include is actually ignored.
>>
>> It's unclear to me what this patch is for & why it's needed.
>
> Well, the entire idea of switching to a new default branch name is to
> avoid using words that we know cause undue emotional harm. In the grand
> scheme, therefore, I want to avoid having any mention of such words in our
> test suite.

I meant why there were two conflicting patches on-list that changed the
same hunks in different ways, both of which resulted in passing tests
and seemingly fulfilled the goal you're noting here.

Later you sent a v3 of the main series, which clarified this question:
https://public-inbox.org/git/pull.762.v3.git.1605743086.gitgitgadget@gmail.=
com/

>> Yesterday in your v2 27/27 series you sent a different one that changed
>> this from s/master/main/g:
>> https://lore.kernel.org/git/b8fa037791683b50c3efb01aa6ac0d3f7b888a2b.160=
5629548.git.gitgitgadget@gmail.com/
>>
>> That's on top of "next", but this one is on "master", the two would
>> conflict, and the 02/27 one seems like the right thing to do.
>
> Yeah, I hadn't made it clear yet at the time you wrote this that my
> intention was to give in to your and Junio's suggestion to restrict the
> `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME` assignments to _just_ the test
> scripts that don't work with arbitrary default branch names.
>
> I had hoped that mentioning gitgitgadget PR 762 (which is that 27-strong
> patch series) would be indicator enough that I was in the process of
> revamping it into a v3, and that this here patch is one part that I
> separated out into its own patch.
>
>> > Therefore, the actual branch name does not matter at all. We might just
>> > as well avoid racially-charged names here.
>>
>> It seems to me the actual name matters a lot, and it must whatever the
>> default branch name is.
>
> Nope. Not at all. Because what we're exercising is the code paths when we
> _don't_ have a branch name to work with.
>
> In the non-Git case, this is trivial to see. There is not even a
> repository! How can there be a branch?
>
> In the early config case, it is too early to access the refs. I meant to
> reference (but forgot) the commit 85fe0e800ca (config: work around bug
> with includeif:onbranch and early config, 2019-07-31) because that
> commit's commit message describes the catch-22 that is the reason why the
> early config cannot see the current branch name (if any).
>
> I should probably have thought of referencing 22932d9169f (config: stop
> checking whether the_repository is NULL, 2019-08-06) for the second test
> case, too.
>
> So again, these two test cases do _not_ exercise the code path where
> another config file is included. To the contrary, they try to prevent a
> regression where `onbranch` would segfault in one case, and BUG in the
> other (in both cases because the now-fixed code used to try to look at the
> current branch name _anyway_).
>
>> I.e. what the test is doing is producing intentionally broken config,
>> and asserting that we don't read it at an early stage.
>>
>> Therefore if we regressed and started doing that the test wouldn't catch
>> it, because the default branch name is "master", or "main" if/when that
>> refs.c change lands, neither of which is "topic".
>
> No, if we regressed, the code would start to throw a BUG, or a segfault,
> respectively.
>
> We never expect these two test cases to look at any branch name at all.


Thanks. I mis(understood|read) it.

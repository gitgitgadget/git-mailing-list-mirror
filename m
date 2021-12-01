Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08859C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbhLAOSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhLAOSA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 09:18:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE79C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 06:14:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so101686972eds.10
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 06:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ka/H533UyHm6E7r669IkSqVldFRLk8cLi4xzRhngnNY=;
        b=Y/luwars2+x7KcroyYnvNSd0wBmn5FPDHc5crtktGYcy8sabm2V79/tNAWRkpE/4vZ
         UJNfD7BC0pJzeTcwVJ4B0vVSKKynWEuXwmD5VtHShThJM/2zNUeGflGRDgZQRzNdu6aL
         mCCwrvGdlBYYeF5jSPPNQGLVuMaNgD4UgNK3ciS9Y7qIJf/Hy/vMJirWA9ScvpTUtaCs
         w9qTv3D+g+/jI3jsHo+v/zjT+kggr+uDxFsyZ85gpdBq1aokr9tasWLQEevQN7eL1W/8
         yD0TtofLjOPlG2rUQB05qilJZUWDgVluL9Bygq240BS7963luBauvKLlChZ7gxDHAsbr
         ehpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ka/H533UyHm6E7r669IkSqVldFRLk8cLi4xzRhngnNY=;
        b=Ku4AkZv90Tk3NJ4OEra/xfJkPcztTY641Z9qPT48mbq51BLI8anYCTuLEtQyIyN611
         lC2+9wuv57rghF4hZDcER0RcrhbrhZkYWf4f107JSYTrilUp0wFETwG26Ug8mPwiEbS4
         T43j2vO8lo8dptlxoLzK7XOBrUnpQwWobZWn7QXpND9JGCTQteDPLHEW2S+qOOxA5b06
         LxEe5EMss6y7ils5M+uhF/YLzH1InnHsta7cEo3q4qS9hMNv19LjZlLb6j/kWh+FHDTB
         JOibLM1pgsflD0fT+DDR546HPR9pfVKe3So6PywD54DdSF855tKCqo0DNsisE5Do2pai
         ATVA==
X-Gm-Message-State: AOAM5306e2OzMu9zmJgISRNjeo5UNT3xSmBAuVgcwiuxV3oOJT35xt4Y
        Wh9dihzsGB9ObduPbl8GQVQ=
X-Google-Smtp-Source: ABdhPJxwGvoLI/gVfaL0s7ZVuyHhYXFvfmXJwH0wOUP3F8bSZujHqRVv0z78nwTcEKvpdlfSpIxE+w==
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr8719111edt.280.1638368077703;
        Wed, 01 Dec 2021 06:14:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z25sm10569568ejd.80.2021.12.01.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:14:36 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msQNY-001GNS-A7;
        Wed, 01 Dec 2021 15:14:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove
 BASH_XTRACEFD
Date:   Wed, 01 Dec 2021 15:06:44 +0100
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
 <20211130224435.GA1991@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211130224435.GA1991@szeder.dev>
Message-ID: <211201.868rx4beer.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, SZEDER G=C3=A1bor wrote:

> On Tue, Nov 30, 2021 at 04:08:48PM -0500, Jeff King wrote:
>> On Mon, Nov 29, 2021 at 09:13:23PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>=20
>> > Once that's been removed we can dig deeper and see that we only have
>> > "BASH_XTRACEFD" due to an earlier attempt to work around the same
>> > issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
>> > 2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
>> > bash, 2017-12-08) follow-up.
>> >
>> > I.e. we had redirection in "test_eval_" to get more relevant trace
>> > output under bash, which in turn was only needed because
>> > BASH_XTRACEFD=3D1 was set, which in turn was trying to work around test
>> > failures under "set -x".
>> >=20
>> > It's better if our test suite works the same way on all shells, rather
>> > than getting a passing run under "bash", only to have it fail with
>> > "-x" under say "dash". As the deleted code shows this is much simpler
>> > to implement across our supported POSIX shells.
>>=20
>> I'm mildly negative on dropping BASH_XTRACEFD.
>
> I agree, using BASH_XTRACEFD is the most robust (and least hacky) way
> to get reliable trace from our test scripts, and we should definitely
> keep it.
>
>> IMHO it is not worth the
>> maintenance headache to have to remain vigilant against any shell
>> function's stderr being examined, when there is single-line solution
>> that fixes everything. Yes, the cost of using bash is high on some
>> platforms, but "-x" is an optional feature (though I am sympathetic to
>> people who are _surprised_ when "-x" breaks things, because it really is
>> a subtle thing, and knowing "you should try using bash" is not
>> immediately obvious).
>>=20
>> Some folks (like G=C3=A1bor) disagree and have done the work so far to m=
ake
>> sure that we pass even with "-x". But it feels like this is committing
>> the whole project to that maintenance. I dunno.
>
> It's not that I disagree but rather it's in our best interest to keep
> '-x' working with non-Bash shells as well, because:
>
>   - We run our tests with '-x' in CI, because we want to get as much
>     information out of test failures as possible.
>
>   - We run our tests with dash in the Ubuntu jobs not only because
>     that's the default /bin/sh, but more importantly because we want
>     to avoid bashisms in our test suite.

I don't really mind keeping BASH_XTRACEFD if it's doing something
useful, but I feel like I'm missing something here. Is it really doing
something useful?

AFAICT the ony case where it mattered was t1510-repo-setup.sh, which
with my upthread
<patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com> now works with
-x, at the trivial cost of skipping a small bi of the test with -x.

I suppose we could move this BASH_XTRACEFD to tht file in particular if
anyone feel strongly about the trivial loss of tracing that entails. I
figured just skipping it under "-x" and adding a "say" to that effect
was a better trade-off.

For the rest of the test suite BASH_XTRACEFD effectively didn't matter,
since all our tests had to work under --verbose-log -x anyway under
dash.

Am I just wrong about this line of thinking, or is it purely that you
two would like to keep BASH_XTRACEFD in case some hypothetical future
caller wants to make use of "test_untraceable=3DUnfortunatelyYes" again?


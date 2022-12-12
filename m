Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B575BC4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiLLWgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiLLWgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:36:23 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C83A15705
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:36:20 -0800 (PST)
Date:   Mon, 12 Dec 2022 22:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670884577; x=1671143777;
        bh=RuyhMQuBiSxsD+mYYzhFh8ykqv42CyJuU37XOooiOog=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HJJJC8N+S/pbAoEet6ktPrD0S3nWJ4E8/OaxnpgIwZCFYAFx3TVMxGl5nfj/E7lhn
         AhcQ0KVhRCm5NEiTQ1zR3AMC2BKgEPAq3NsgS0Agc4h7l3u78mbqEDFwxLN+I4aeI3
         RkRJ8xeD2Qv64kruZkziGHbsz/VtjUDEU667bHpWJtKfmmkAZFHNhn8VEigkAE9KEr
         tteQeOQjbxgQOI4E6qUFQwpqPg3+9TVzEyPKssxFokcnG23YtBczpq+J+dh/wrRm5R
         igGbPY7l3kr5EPYISVHUyFwZBYn0SvMkCM6Zj+kgN15pmm8cCxvw8uxnd1JoByttpW
         OGTP9N45ITr0Q==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v4 3/3] worktree add: Add hint to use --orphan when bad ref
Message-ID: <20221212223547.awuqa6xhwd2juuah@phi>
In-Reply-To: <CAPig+cQP4mBFaLX+DtAWHR59WM3vQM+ZHrLkLeZrsxosVwkdTQ@mail.gmail.com>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221212014003.20290-4-jacobabel@nullpo.dev> <221212.86pmcp57w4.gmgdl@evledraar.gmail.com> <20221212145913.aftjeq6kn55zbkai@phi> <221212.86zgbs4h9f.gmgdl@evledraar.gmail.com> <CAPig+cQP4mBFaLX+DtAWHR59WM3vQM+ZHrLkLeZrsxosVwkdTQ@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/12 01:35PM, Eric Sunshine wrote:
> On Mon, Dec 12, 2022 at 1:19 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Mon, Dec 12 2022, Jacob Abel wrote:
> > > Also, Is there an easier way to debug the `test_expect_success` state=
ments? I
> > > tried enabling tracing mode but it doesn't seem to trace into those s=
tatements.
> >
> > Not really, other than just enabling "-x" for the test-lib.sh itself, i=
.e.:
> >
> >         sh -x ./t0001-init.sh
> >
> > I *think* that should work, but I didn't test it...
>
> Isn't the question here how to debug the body of a
> test_expect_success? If that's the case, then running the test with -x
> and -i should help:
>
>     ./t001-init.sh -x -i
>
> The -x makes it print all the output as it's executing the body of the
> test_expect_success rather than suppressing it, and -i makes it stop
> as soon as it encounters a failing test, which makes it easier to
> examine the state of that test. After the script aborts (via -i), look
> inside the "trash*" directory. Also, you can insert calls to
> test_pause in the body of a test, which will make it drop into an
> interactive shell session in the trash directory at the point of the
> test_pause, so you can examine the state of the test directly as it
> exists at that point (as opposed to examining it after the test
> failed, as with -i).

This works fantastically. I'm not sure why `sh -x ./tXXXX-script.sh` doesn'=
t
work but `./tXXXX-script.sh -x` does but this makes debugging a lot simpler=
. The
`-i` flag is also super useful here. Appreciated.


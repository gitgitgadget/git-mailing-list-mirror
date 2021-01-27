Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65905C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 07:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3279920731
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 07:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhA0HLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317729AbhA0AsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 19:48:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3424FC061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 16:47:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z22so289157edb.9
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 16:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BqKdj/BGUe3hcTPdbOcfGDjjiVkiuZWel0+yNGd4D0Q=;
        b=VPwOl40tW8eR3YK2Y99aqmzyIrcJWAp0pdTBQCghAdq3zU3b/zNYPTDODCu2Jbqojt
         XswhR9mX9jQ/TlrUbCWnIbE3OPJ+izo2rds9dWvp+CFJTZm/KPKfl555GXHLcaY8ZKeU
         1Fy+F+kSs27nD3j+2nc+DCkIu3xo4rrUZtdYyiNjjJME/bzyD6BvU42m1JBI0aH6cKaE
         wHY+SaJ+1lpAdCLwrlnqUIxv7hImEf5cs3Chylo0I0rXPUkOEpM9MWiWdAHVqQy/wtWY
         wobhWz9mmeaecYl65NTQqzWYOqGbv5dP0d61/Pb/MtG/jxhMMTF0EH7Oz+pyoelkGTHu
         aVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BqKdj/BGUe3hcTPdbOcfGDjjiVkiuZWel0+yNGd4D0Q=;
        b=SXFft9hTIVrO3Qqti+qjdE+VB9sxlbqtQRCrWdwhIh92mfe0/PS+t9vG1pX4YiG6mS
         PDC7mTJFl0AmIkrE+uJ7+UrZBgJKs40mCPBQp+Ro0aoBibRAMJGW/00OybM4A3019KSS
         kT0Dk0ry8IunvTt5JHkWkpXnyfkYsWFkSzWSoqtoAtXxqgJdOrnXlbQLNfEbkIw60+7O
         cHoejaAwS4Kd6D6hSzdz7sn9BNeBn5fsMvBf710egUBceqT1E/7UfZ9s/Mk35s3+BCC2
         57I2Xqu+ecMPIgo6mrHBrRbcC13ONcO8/xdOrMrb8C3PJY04fUesS+XHI7BC1JQR7vy3
         Qn0w==
X-Gm-Message-State: AOAM532ymSZbwP14Lar6JG17hPT9d6gzSCypaGSBSdt+tjwuajlf73gv
        Ye0FMAvz/IAmGRWEvvRw3We2qwASV52ltQ==
X-Google-Smtp-Source: ABdhPJwL+F2lelUM0ppBdLq8gFq7EnGAOC9vGl8i97fpArvANuUgm8EivabvuySVY8HFSEkwCmH+7w==
X-Received: by 2002:a05:6402:78f:: with SMTP id d15mr6446735edy.362.1611708448702;
        Tue, 26 Jan 2021 16:47:28 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id e27sm97752ejl.122.2021.01.26.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 16:47:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/6] ci: remove GETTEXT_POISON jobs
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
 <20210111144740.6092-2-avarab@gmail.com>
 <20210112085051.GV8396@szeder.dev> <87a6t38p71.fsf@evledraar.gmail.com>
 <20210120191406.GE8396@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210120191406.GE8396@szeder.dev>
Date:   Wed, 27 Jan 2021 01:47:27 +0100
Message-ID: <87pn1rp5nk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 20 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Jan 20, 2021 at 06:59:14PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Tue, Jan 12 2021, SZEDER G=C3=A1bor wrote:
>>=20
>> > On Mon, Jan 11, 2021 at 03:47:35PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> A subsequent commit will remove GETTEXT_POISON entirely, let's start
>> >> by removing the CI jobs that enable the option.
>> >>=20
>> >> We cannot just remove the job because the CI is implicitly depending
>> >> on the "poison" job being a sort of "default" job.
>> >
>> > I don't understand what you mean here with a "default job" that the CI
>> > is implicitly depending on.  There is certainly no such default job on
>> > Travis CI, and I don't think there is one on the GitHub thing.
>>=20
>> I'll reword this. I meant that the poison job was using the default
>> compiler etc., whereas the other ones were setting custom values.
>>=20
>> I vaguely remember some list traffic about this in the past, i.e. the
>> reliance on the poison job not just for that, but also as "the default
>> OS image" setup.
>
> Oh, I didn't mean that the commit message should be clarified.  I
> meant that the GETTEXT_POISON job can simply be deleted.  Sorry for
> not being clear enough.

I still don't get it, and my patch still seems fine as it is to me. But
I'm probably missing something.

I'm looking at these, both pointing at e6362826a04 (The fourth batch,
2021-01-25):

    # Currently says "Please be aware travis-ci.org will be shutting
    # down in several weeks"
    https://www.travis-ci.org/github/git/git/builds/756176098

    https://github.com/git/git/actions/runs/510676142

For the GitHub one, there's only two things that are linux && gcc. The
linux-gcc job, and GETTEXT_POISON (renamed to linux-gcc-default in this
series).

In ci/install-dependencies.sh we install GCC 8 for linux-gcc, but also
perforce, apache, git-lfs etc.

Then in ci/lib.sh we set CC=3Dgcc-8 on linux-gcc, but retain the default
on GETTEXT_POISON. We also set GIT_TEST_HTTPD=3Dtrue.

So hence "linux-gcc-default", we're running as close to a default set of
packages we can get and build/run git at all. I.e. just "apt install
$UBUNTU_COMMON_PKGS".

Then in ci/run-build-and-tests.sh the "linux-gcc" job is also our "let's
turn on every GIT_TEST_* option you've heard of" job. Whereas on the
GETTEXT_POISON job we just ran "make test", well, with
GIT_TEST_GETTEXT_POISON=3Dtrue before this series, but that was the only
non-default, now we've got no non-defaults.

I can see why we'd want this on top:
=20=20=20=20
    diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
    index 50e0b90073f..3071099eaca 100755
    --- a/ci/run-build-and-tests.sh
    +++ b/ci/run-build-and-tests.sh
    @@ -32,11 +32,6 @@ linux-clang)
            export GIT_TEST_DEFAULT_HASH=3Dsha256
            make test
            ;;
    -linux-gcc-4.8)
    -       # Don't run the tests; we only care about whether Git can be
    -       # built with GCC 4.8, as it errors out on some undesired (C99)
    -       # constructs that newer compilers seem to quietly accept.
    -       ;;
     *)
            make test
            ;;

Because there we're skipping tests on linux-gcc-4.8, but on travis it's
the only Ubuntu Trusty image (default is Xenial), so yes we build with
gcc 4.8, but we're also missing out in seeing if our tests are working
on a slightly older Ubuntu.

Also on GitHub's page the GETTEXT_POISON job finishes in ~10m but all
the other ones in ~30m, I see some run "make test" twice, as an aside is
there some limit on jobs but not overall CPU? Otherwise those would
finish faster if that was split up.

But "make test" twice doesn't account for a ~3x increase, so it's got to
be the extra tests we're running, i.e. svn tests, httpd etc.

It seems to me to provide value in itself to run some shorter version of
the CI for people using it as a poor man's edit/push/ci/edit loop.

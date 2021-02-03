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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6630DC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2465E64E46
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 12:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhBCMOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhBCMOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 07:14:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182BDC061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 04:13:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bl23so35351284ejb.5
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JC0q4YlKNS8AqOUSYaUnz+SoO+ZBixa+vUnzHFFbJB4=;
        b=Whw6Jv6uRXEDdHBzo+LCSaX8KIWe30AWP/n4MDPXKsdZjiHgosl6fsaGjwA6kOi0yS
         yVJ+jmf3C8VQuEww82mGBafpYUJtZDtIlt5cct2XOZjHAl9BYSFSWYWTivaliilDiaJJ
         LQV4AI09WqKSDlbac2YXi2wWX9bGNZ4Q3yU9hhNP9sNZOlpOpAc1nE+8U0chK8+sUyNV
         7SL4M/bARfzYstSTk8nu6Qh4+EsH7b3+nwDaKkknOJSXCGX2F6PlYAOsWvTw2aKDTfPl
         cHBkAOzT0bU8zfHdOq+4J5MwWIsxBn29f56eZtDjGQepAwQlv1Cih9U7IqHVbixitnRT
         muVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JC0q4YlKNS8AqOUSYaUnz+SoO+ZBixa+vUnzHFFbJB4=;
        b=IGLgVKgjSxz/VKP4NDf4V0HJk8hpmb024AHLKrnBnu4eZzqrn3mZP1W7HClsYdmo/Y
         menFJ3rP+8ySTJyM6kz9zxVnw57hFd9A9SSWc1a20dhzs7hNAi/2BdTOa1xldvfdv9HG
         lJWGDc5UTMhhm6Mr0rT3a+3UmPEXU6DOe8o3d3NIQoF4/dzhdAtRmclQlV5gjxIIiWLD
         YX6FFZkBr9ste/URIFY3I992TUILH2RBIgwYRYo/77Wwpr/kmTLtqzymtgVrCWU3pwvA
         e1b96kl2uHIkuzuN2FGzYBZxD5kvDibFnKuJliSis50tY8tgsnQhElTxlGKA5kB5dBnp
         Wh+A==
X-Gm-Message-State: AOAM531pWITKC4vAtqDGWDNI4JqMDSKj7t27H3yR4XLIPBCsrKfhrXaU
        ayuXkk17GcuSgCOWEWdE48CFEhxHBn4tXw==
X-Google-Smtp-Source: ABdhPJxiOuUgfwcMkAdnoM04N9r3tI+mA1OVpGSXADjatTiCd0MhEAtIurJCldlBNmqaSWNYuny4Zg==
X-Received: by 2002:a17:906:37c1:: with SMTP id o1mr2796789ejc.488.1612354414353;
        Wed, 03 Feb 2021 04:13:34 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id f11sm934813eje.114.2021.02.03.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:13:33 -0800 (PST)
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
 <20210120191406.GE8396@szeder.dev> <87pn1rp5nk.fsf@evledraar.gmail.com>
 <20210201220437.GB2091@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210201220437.GB2091@szeder.dev>
Date:   Wed, 03 Feb 2021 13:13:32 +0100
Message-ID: <87ft2de4cz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 01 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Jan 27, 2021 at 01:47:27AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, Jan 20 2021, SZEDER G=C3=A1bor wrote:
>>=20
>> > On Wed, Jan 20, 2021 at 06:59:14PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>=20
>> >> On Tue, Jan 12 2021, SZEDER G=C3=A1bor wrote:
>> >>=20
>> >> > On Mon, Jan 11, 2021 at 03:47:35PM +0100, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >> >> A subsequent commit will remove GETTEXT_POISON entirely, let's sta=
rt
>> >> >> by removing the CI jobs that enable the option.
>> >> >>=20
>> >> >> We cannot just remove the job because the CI is implicitly dependi=
ng
>> >> >> on the "poison" job being a sort of "default" job.
>> >> >
>> >> > I don't understand what you mean here with a "default job" that the=
 CI
>> >> > is implicitly depending on.  There is certainly no such default job=
 on
>> >> > Travis CI, and I don't think there is one on the GitHub thing.
>> >>=20
>> >> I'll reword this. I meant that the poison job was using the default
>> >> compiler etc., whereas the other ones were setting custom values.
>> >>=20
>> >> I vaguely remember some list traffic about this in the past, i.e. the
>> >> reliance on the poison job not just for that, but also as "the default
>> >> OS image" setup.
>> >
>> > Oh, I didn't mean that the commit message should be clarified.  I
>> > meant that the GETTEXT_POISON job can simply be deleted.  Sorry for
>> > not being clear enough.
>>=20
>> I still don't get it, and my patch still seems fine as it is to me. But
>> I'm probably missing something.
>>=20
>> I'm looking at these, both pointing at e6362826a04 (The fourth batch,
>> 2021-01-25):
>>=20
>>     # Currently says "Please be aware travis-ci.org will be shutting
>>     # down in several weeks"
>
> ... and continues with:
>
>   "with all accounts migrating to travis-ci.com.  Please stay tuned
>    here for more information."
>
> FWIW, I recently migrated manually, and apart from the different TLD
> haven't noticed anything different (though somehow the jobs in my .org
> builds sometimes took a while to start lately, but on .com they all
> started real fast so far, as they should).
>
>>     https://www.travis-ci.org/github/git/git/builds/756176098
>>=20
>>     https://github.com/git/git/actions/runs/510676142
>>=20
>> For the GitHub one, there's only two things that are linux && gcc. The
>> linux-gcc job, and GETTEXT_POISON (renamed to linux-gcc-default in this
>> series).
>>=20
>> In ci/install-dependencies.sh we install GCC 8 for linux-gcc, but also
>> perforce, apache, git-lfs etc.
>>=20
>> Then in ci/lib.sh we set CC=3Dgcc-8 on linux-gcc, but retain the default
>> on GETTEXT_POISON. We also set GIT_TEST_HTTPD=3Dtrue.
>>=20
>> So hence "linux-gcc-default", we're running as close to a default set of
>> packages we can get and build/run git at all. I.e. just "apt install
>> $UBUNTU_COMMON_PKGS".
>
> We started installing newer compilers, because we wanted to benefit
> from their better error reporting and improved warnings.  The reason
> we did that in existing CI jobs without adding a "default" job was
> that we don't care enough about the default compiler and configuration
> to justify its additional runtime, because we run the test suite
> enough times already.

So in summary, you'd like it removed because the combination of
GETTEXT_POISON + old compiler is no longer worth it, but while we were
running with GETTEXT_POISON anyway we might as well run it on the old
compiler?

> Considering that the number of CI jobs has grown since then, I would
> rather see the build complete faster than a default job running the
> test suite for the N+1th time.

[...]

>> Then in ci/run-build-and-tests.sh the "linux-gcc" job is also our "let's
>> turn on every GIT_TEST_* option you've heard of" job. Whereas on the
>> GETTEXT_POISON job we just ran "make test", well, with
>> GIT_TEST_GETTEXT_POISON=3Dtrue before this series, but that was the only
>> non-default, now we've got no non-defaults.
>>=20
>> I can see why we'd want this on top:
>>=20=20=20=20=20
>>     diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>>     index 50e0b90073f..3071099eaca 100755
>>     --- a/ci/run-build-and-tests.sh
>>     +++ b/ci/run-build-and-tests.sh
>>     @@ -32,11 +32,6 @@ linux-clang)
>>             export GIT_TEST_DEFAULT_HASH=3Dsha256
>>             make test
>>             ;;
>>     -linux-gcc-4.8)
>>     -       # Don't run the tests; we only care about whether Git can be
>>     -       # built with GCC 4.8, as it errors out on some undesired (C9=
9)
>>     -       # constructs that newer compilers seem to quietly accept.
>>     -       ;;
>>      *)
>>             make test
>>             ;;
>>=20
>> Because there we're skipping tests on linux-gcc-4.8, but on travis it's
>> the only Ubuntu Trusty image (default is Xenial), so yes we build with
>> gcc 4.8, but we're also missing out in seeing if our tests are working
>> on a slightly older Ubuntu.
>
> The above comment you propose to remove explains why you should not
> remove it...  And, again, running the test suite doesn't seem to worth
> the extra runtime.

How is it extra runtime in any meaningful sense?

Yes, we spend more CPU time, but as far as I can tell (and I'm looking
at an ongoing run on GitHub now) these jobs are run concurrently. Some
of that was covered in the quoted paragraph below that you didn't reply
to.

I.e. if I push a commit I don't care if 10 minutes of CPU time are being
wasted by a machine sitting in some rack somewhere, the important part
is that I may be saving 20 minutes of my time, since the faster 10
minute test (running concurrently with the ~30m tests) might fail
earlier.

Or are there some job limits involved here that I'm missing?

As I was writing this the CI job for GETTEXT_POISON just finished in
10m16s showing OK=3Dgreen, and the rest are still churning.

>> Also on GitHub's page the GETTEXT_POISON job finishes in ~10m but all
>> the other ones in ~30m, I see some run "make test" twice, as an aside is
>> there some limit on jobs but not overall CPU? Otherwise those would
>> finish faster if that was split up.
>>=20
>> But "make test" twice doesn't account for a ~3x increase, so it's got to
>> be the extra tests we're running, i.e. svn tests, httpd etc.
>>=20
>> It seems to me to provide value in itself to run some shorter version of
>> the CI for people using it as a poor man's edit/push/ci/edit loop.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54159C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiBVPat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBVPas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:30:48 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32A15FCAF
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:30:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c6so34942876edk.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZDZGnpd9a98TgxH+fyHl8PtV/xCv0LP+obtmeDZ5N0E=;
        b=kliUg6lJ6sZLNDQblu4yZbuFn4zD2dQ9djB+kN0DvW42b8dQ7kSzV0AUi2CjbZNREy
         DrkWw8VKZ5HfRp/8IZHKbJZTupDDK8W8v2kmxIHKMG24ZKLZtI+6juG3HSH2+5YFkvID
         7wbrEXa/9srTkZVb2a5eiw0A9FCFwp6DGQWHe8e9Ip4OYScqmc7ZM/HV2x23HV2XSAo0
         5u55VCuVlekOz7BJDj7RZnZrqE/J9DZGzlmKbF+kyLKabckxuQA69UshMzWD19d6uFqa
         VY1aUjYL0UzR20YINDnLtFeIYlTbic2ImWIi214VuQbaJVOrmdvTHLW09RG9Na+u+9zt
         8Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZDZGnpd9a98TgxH+fyHl8PtV/xCv0LP+obtmeDZ5N0E=;
        b=prWrnZild2AmlmN8hYUxFqxeN1gbLbWXFthPDqsNK4WKbgWkVEWox37PWSHnprndsb
         gwOatjZVtlJ4kqMG5CpwA6uGLWBIkIwyLu+LoWzQoCnLPaj2RQk+bjRjq4aBdQzRUF+F
         h3+UeW2kRGcPDECiohJCFpa6K7YffFDmjdyyMo82At0X4fwx2QZvi/vK8rxqTiS45A3h
         7VaRzgELXLFAnB/5Csy/OXmBFbZvd0t361afsr3sfo8eKs6wK64EZAuWesgjRXa/aqDt
         6LKH/YNwOkc/ND5S+OQCeXh0YBmeQLnCihidOTO8BTQFakz4B2IRqszebRIQdM5xj58f
         6cdw==
X-Gm-Message-State: AOAM531iqV5CkRavTPtp5mdhaGKQOSr+QSf6EvZrqYCBIGJ1zYYtpggJ
        w4lvb3ugNwpq2wye/xsju/A=
X-Google-Smtp-Source: ABdhPJyZNH5bQEqDV29OuNhQjONNaZefQoKKlz4n2CeearSrO1m+zshL1Y08j+w8Q9Y5TXKowhTWjg==
X-Received: by 2002:a50:9996:0:b0:413:2db7:6f87 with SMTP id m22-20020a509996000000b004132db76f87mr132539edb.132.1645543820940;
        Tue, 22 Feb 2022 07:30:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gj7sm6302815ejc.90.2022.02.22.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:30:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMX7L-006AsZ-FV;
        Tue, 22 Feb 2022 16:30:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 3/3] test-lib.sh: remove "BASH_XTRACEFD"
Date:   Tue, 22 Feb 2022 16:14:19 +0100
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
 <patch-v4-3.3-8b5ae33376e-20211213T013559Z-avarab@gmail.com>
 <20220221231121.GB1658@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220221231121.GB1658@szeder.dev>
Message-ID: <220222.86h78q7wc4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, SZEDER G=C3=A1bor wrote:

> On Mon, Dec 13, 2021 at 02:38:36AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Stop setting "BASH_XTRACEFD=3D4" to direct "-x" output to file
>> descriptor 4 under bash.
>>=20
>> When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
>> automatically, 2016-05-11) it was needed as a workaround for various
>> tests that didn't pass cleanly under "-x".
>>=20
>> Most of those were later fixed in 71e472dc43 (Merge branch
>> 'sg/test-x', 2018-03-14), and in the preceding commits we've fixed the
>> final remaining and removed the "test_untraceable" facility.
>
> Those commits made the test suite pass with '-x' without BASH_XTRACEFD
> only when all went well, but during development that's often not the
> case.  So let's not forget about c5c39f4e34 (test-lib: fix interrupt
> handling with 'dash' and '--verbose-log -x', 2019-03-13), before which
> dash was not really suitable to run tests involving daemon processes
> with '-x' during development.  If dash were to announce redirections
> in its '-x' trace, like many not as quite as popular shells do, then
> the workaround in that commit wouldn't work at all.
>
> In general, between POSIX leaving a lot of things explicitly
> unspecified, or, worse, silently unspecified, shells not conforming to
> POSIX, being buggy, and/or implementing their own extensions, I am
> actually quite surprised that it works as well as it does with so many
> shell.  At least as far as we know it, and I wouldn't at all be
> surprised if there were unknown issues lurking in some corner cases
> and/or with some more exotic shells.
>
>> We could retain "BASH_XTRACEFD=3D4" anyway, but doing so is bad because:
>>=20
>>  1) Since we're caring about "-x" passing in CI under "dash" on Ubuntu
>>     using "BASH_XTRACEFD=3D4" will amount to hiding an error we'll run
>>     into eventually. Tests will pass locally with "bash", but fail in
>>     CI with "dash" (or under other non-"bash" shells).
>
> This is not "bad", this is exactly what we use CI for.  This is the
> smae case as when the test suite passes on a developer's Linux box,
> but breaks on OSX or Windows in CI.

Yes we could definitely live with it. My aim here was to tighten up the
cycle of testing, submitting/pushing a patch, having CI fail because
that test was on bash only etc.

> Furthermore, while I fully agree that keeping the whole test suite
> passing with '-x' without BASH_XTRACEFD is desirable, I do think it's
> a bad idea to forbid developers from using it while hacking away to
> scratch their itches.  I for one sometimes deliberately use various
> bashisms in my tests, including 'test_cmp'-ing the stderr of loops and
> functions, because they make writing tests then and there easier, when
> at that point I'd rather focus my attention on getting the C changes
> right, and clean them up eventually when I deem the changes worthy for
> submission.
>
>
> Overall I consider this patch as a cleanup solely for cleanup's sake,
> without any benefits at all.
>
> I'm kind of low on time myself as well, at least to argue about this
> any further.  Therefore, as the one who did the vast majority of work
> to make '-x' work even without BASH_XTRACEFD, I leave here my firm:
>
>   Not-Acked-By: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> to any patch that attempts to remove support for BASH_XTRACEFD.

Sure, if you feel that strongly about it I'm fine with dropping this
version and submitting a re-roll without the test-lib.sh changes.

I just genuinely didn't grok why you wanted to keep it before.

But I get it now, thanks.

I think it's fair to say that it's for the exact same reason I'd like to
get rid of it, you just think of it as a feature, not a bug :)

I.e. the "landmine" of getting something working under bash, only to
find out later that it fails on other shells.

But everyone's workflow is different. It sounds as though you sometimes
start hacking tests to use bash-specific features that you later distill
down to POSIX-compatibility.

Which I don't think I've ever done, since doing so is going to require a
rewrite anyway I might as well struggle to get it POSIX-ly working in
the first place.

But I can see how that's useful, and I don't want to take that away from
you.

Do you feel equally strongly that this mode of operation must be the
default under bash, or that it would be OK to have it be opt-in under a
knob like GIT_TEST_BASHISMS=3Dtrue, or something like that?

The reason I ran into this in the first place was because I saw such
unexplained behavior changes with bash v.s. non-bash, only to arrive at
this part of test-lib.sh (which I'm sure I'd read N times before, but
had forgotten about).

I don't want to make your local workflow harder, but I'd think it would
be fair to say that the average git.git developer won't be as keenly
aware of shell differences as you, and would be better served by having
this subtlety be opt-in.

I.e. it's surely more likely that someone is to write POSIX-compatible
test code for ML submission, than intentionally using a bash-only
feature for prototyping, which will start breaking once it's exposed to
dash et al in CI.

Or, if you feel strongly about that too I wouldn't mind much if
"GIT_TEST_BASHISMS=3Dtrue" was the default, as long as I can set it to
"GIT_TEST_BASHISMS=3Dfalse" and /other/ bash-specific behavior without
further opting it in to optional bash-only behavior that's off by
default.

Assuming you'd reply "no" to not wanting such a knob *and* having it by
off by default, would that be a "yes" to having the knob and needing to
turn it off?

Thanks!

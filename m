Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC90C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B96061C76
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhF2MZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhF2MZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 08:25:31 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1D8C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:23:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w13so25063623edc.0
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=fjNLZwn38ZXMilyLvxqgfE5Nb0Otjnq4I2QcIzd3Uy4=;
        b=JGjP0rFEFm+McaNGiTIVtMZ40kmZm7k44R4jGGFZrDTdiKJebnvUMrvCqwfqS+tSKX
         76v5YmrprX2yc7dboP1cel0FD6SLj+z7xGCRJdZ8lSzzat0UXVH18PXzmQSX05SvPEcv
         hugthBdilnnWu3/LQrCKQ3Wam4HI2kdEMWLdBa1dWiRFlvWfTNFEsLuXVgHKo3VAA5qI
         aMoBP/yYFtTAD97km13fI2LHOb6KEnYfz1dTMLFIsvYwYToDxijfutBkagCBAEtsG6J2
         VY6nAUM5VqqGULFHVnwP+IJHb3tZLq/DKFf/Qmj2nsMdR9YmCJWlhLh/B5O8Zbcc3ys7
         aupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=fjNLZwn38ZXMilyLvxqgfE5Nb0Otjnq4I2QcIzd3Uy4=;
        b=O4+y/FWPp9nUR4r9kCIXRvGbQNBjdIpzOOMQmfp3o2fVvMsnZzTMEOMfHp5kqXw17C
         tfZj+rVsqNThLSzD8yyYzBkMbTB4c+nFcKe4//y+c0s1jlPrctlne7/zs6WrXbdH4z80
         4ED5R0h+wm/rlFbAvDSYixXzYrJ1EKR256UYdRZZ2wm1D70/iCaERCs9/PF9ODtbqGH2
         jDzhEBQkhpsZVFdeNF1DTqseDO1980kRYUHc6NqGftk3VLJk8aECP3R57fX257mNsVqe
         ffIDWbE1x27wXfUucjDkUc0ffmXN0Nxz+j7N7oYXnYD0xmQao9BEbw1jAo/zrR42WAWu
         oPAQ==
X-Gm-Message-State: AOAM530LVef3WPjAmX4V6UPGFGFOXlkajNUdazGerMGR5spGfhxgro+9
        L9LXqaRAaRgGHGcuDvEZqIg=
X-Google-Smtp-Source: ABdhPJxEb3MCj+FGUZAecAs59tZSwtfIiGb4MjGk0z1GbQ1cNKyrqU/O12MFJWIHu70waKg35PKLng==
X-Received: by 2002:a05:6402:90a:: with SMTP id g10mr39748450edz.365.1624969381888;
        Tue, 29 Jun 2021 05:23:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r23sm9540236edv.26.2021.06.29.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:23:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] p5400: add perf tests for git-receive-pack(1)
Date:   Tue, 29 Jun 2021 14:09:25 +0200
References: <cover.1624858240.git.ps@pks.im>
 <2f6c4e3d102e71104d7d00c78631b149b880609a.1624858240.git.ps@pks.im>
 <871r8mxvvx.fsf@evledraar.gmail.com> <YNq7MD/fMQp05I21@ncase>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YNq7MD/fMQp05I21@ncase>
Message-ID: <87r1gkg8rf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 29 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Mon, Jun 28, 2021 at 09:49:54AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Mon, Jun 28 2021, Patrick Steinhardt wrote:
>>=20
>> > [[PGP Signed Part:Undecided]]
>> > We'll the connectivity check logic for git-receive-pack(1) in the
>> > following commits to make it perform better. As a preparatory step, add
>> > some benchmarks such that we can measure these changes.
>> >
>> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> > ---
>> >  t/perf/p5400-receive-pack.sh | 97 ++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 97 insertions(+)
>> >  create mode 100755 t/perf/p5400-receive-pack.sh
>> >
>> > diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.=
sh
>> > new file mode 100755
>> > index 0000000000..a945e014a3
>> > --- /dev/null
>> > +++ b/t/perf/p5400-receive-pack.sh
>> > @@ -0,0 +1,97 @@
>> > +#!/bin/sh
>> > +
>> > +test_description=3D"Tests performance of receive-pack"
>> > +
>> > +. ./perf-lib.sh
>> > +
>> > +test_perf_large_repo
>>=20
>> From the runtime I think this just needs test_perf_default_repo, no?
>> I.e. we should only have *_large_* for cases where git.git is too small
>> to produce meaningful results.
>>=20
>> Part of th problem is that git.git has become larger over time...
>
> I did these tests for 3/3 with git.git first, and results were
> significantly different. The performance issues I'm trying to fix with
> the connectivity check really only start to show up with largish
> repositories.
>
>> > +test_expect_success 'setup' '
>> > +	# Create a main branch such that we do not have to rely on any speci=
fic
>> > +	# branch to exist in the perf repository.
>> > +	git switch --force-create main &&
>> > +
>> > +	# Set up a pre-receive hook such that no refs will ever be changed.
>> > +	# This easily allows multiple perf runs, but still exercises
>> > +	# server-side reference negotiation and checking for consistency.
>> > +	mkdir hooks &&
>> > +	write_script hooks/pre-receive <<-EOF &&
>> > +		#!/bin/sh
>>=20
>> You don't need the #!/bin/sh here, and it won't be used. write_script()
>> adds it (or the wanted shell path).
>
> Makes sense.
>
>> > +		echo "failed in pre-receive hook"
>> > +		exit 1
>> > +	EOF
>> > +	cat >config <<-EOF &&
>> > +		[core]
>> > +			hooksPath=3D$(pwd)/hooks
>> > +	EOF
>>=20
>> Easier understood IMO as:
>>=20
>>     git config -f config core.hooksPath ...
>
> Yup, will change.
>
>> > +	GIT_CONFIG_GLOBAL=3D"$(pwd)/config" &&
>> > +	export GIT_CONFIG_GLOBAL &&
>> > +
>> > +	git switch --create updated &&
>> > +	test_commit --no-tag updated
>> > +'
>> > +
>> > +setup_empty() {
>> > +	git init --bare "$2"
>> > +}
>>=20
>> I searched ahead for setup_empty, looked unused, but...
>>=20
>> > +setup_clone() {
>> > +	git clone --bare --no-local --branch main "$1" "$2"
>> > +}
>> > +
>> > +setup_clone_bitmap() {
>> > +	git clone --bare --no-local --branch main "$1" "$2" &&
>> > +	git -C "$2" repack -Adb
>> > +}
>> > +
>> > +# Create a reference for each commit in the target repository with ex=
tra-refs.
>> > +# While this may be an atypical setup, biggish repositories easily en=
d up with
>> > +# hundreds of thousands of refs, and this is a good enough approximat=
ion.
>> > +setup_extrarefs() {
>> > +	git clone --bare --no-local --branch main "$1" "$2" &&
>> > +	git -C "$2" log --all --format=3D"tformat:create refs/commit/%h %H" |
>> > +		git -C "$2" update-ref --stdin
>> > +}
>> > +
>> > +# Create a reference for each commit in the target repository with ex=
tra-refs.
>> > +# While this may be an atypical setup, biggish repositories easily en=
d up with
>> > +# hundreds of thousands of refs, and this is a good enough approximat=
ion.
>> > +setup_extrarefs_bitmap() {
>> > +	git clone --bare --no-local --branch main "$1" "$2" &&
>> > +	git -C "$2" log --all --format=3D"tformat:create refs/commit/%h %H" |
>> > +		git -C "$2" update-ref --stdin &&
>> > +	git -C "$2" repack -Adb
>> > +}
>> > +
>> > +for repo in empty clone clone_bitmap extrarefs extrarefs_bitmap
>> > +do
>> > +	test_expect_success "$repo setup" '
>>=20
>> > +		rm -rf target.git &&
>> > +		setup_$repo "$(pwd)" target.git
>>=20
>> ...here we use it via interpolation.
>>=20
>> I'd find this whole pattern much easier to understand if the setups were
>> just a bunch of test_expect_success that created a repo_empty.git,
>> repo_extrarefs.git etc. Then this loop would be:
>>=20
>>     for repo in repo*.git ...
>>=20
>> I'd think that would also give you more meaningful perf data, as now the
>> OS will churn between the clone & the subsequent push tests, better to
>> do all the setup, then all the different perf tests.
>>=20
>> Perhaps there's also a way to re-use this setup across different runs, I
>> don't know/can't remember if t/perf has a less transient thing than the
>> normal trash directory to use for that.
>
> I originally had code like this, but the issue with first creating all
> the repos is that it requires lots of disk space with large repos given
> that we'll clone it once per setup. Combined with the fact that I
> often run tests in tmpfs, this led to out-of-memory situations quite
> fast given that I had 3x6GB repositories plus the seeded packfiles in
> RAM.
>
> This is why I've changed the setup to do the setup as we go, to bring
> disk usage down to something sane.
>
> Patrick
>
> [[End of PGP Signed Part]]

Ah, I see. In that case wouldn't it be even better/faster with/without
my suggestion to not use "clone" here, which would either be manually
set up with alternates, or removing the --no-local flag.

You'd then share bulk of the object database, and just have different
references. B.t.w. you'll probably get less noise/more relevant results
if you then do a "pack-refs" after creating those N references.

So you should have:

 0. Your "big" test repop (not used directly)
 1. An empty repo
 2. The "big" test repo itself, but just the HEAD branch, using
    alternates to point to #0
 3. Ditto, but we create a crapload of refs for each commit for a
    version of #2.
 4. Ditto #3 (could even "cp" over the packed refs file to save time),
    but add a bitmap on top.

Well, presumably for #4 we'd actually want to do the "git repack -Adb"
for #2 (or enforce that #0 must have it), then just move the *.bitmap
file(s) to #4. Now the test case conflates whether we have bitmaps with
how well (re)packed something is.

I think this might also allow you to get rid of the pre-receive hook for
a "real" push test, since the side-repos would be so cheap at this point
that you could perhaps setup N of them to push into.

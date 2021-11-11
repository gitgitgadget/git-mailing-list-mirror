Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB1CC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298D361268
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhKKRst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:48:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58790 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhKKRsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:48:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 393FB166D4E;
        Thu, 11 Nov 2021 12:45:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5uTx+jJtiIAk
        75i/WZ5ubQS2s+onjIr1bhYq1ypSJEQ=; b=wROi2MWRmwxtg1eIXhYiee3Ko0AT
        ROmapTViCTBNAVqrVO6+oVuHC+CvnV/M2CkmgRQSHXM0TRs9HfalDgzWFQTLMhw1
        OZWtH+LJYxeBE55t8SMu229yCxmsBcgLbY2dktfHXLc1jhdnPSCW31OQLnQIaJVQ
        PwRZJbCGdB1E108=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 314F3166D4D;
        Thu, 11 Nov 2021 12:45:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91718166D4C;
        Thu, 11 Nov 2021 12:45:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] maintenance tests: fix systemd v2.34.0-rc* test
 regression
References: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
        <patch-v2-1.1-44f0cafa16e-20211110T035103Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2111101422030.21127@tvgsbejvaqbjf.bet>
        <211110.86ilx0gdx8.gmgdl@evledraar.gmail.com>
Date:   Thu, 11 Nov 2021 09:45:52 -0800
In-Reply-To: <211110.86ilx0gdx8.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 10 Nov 2021 17:22:09 +0100")
Message-ID: <xmqqsfw2mvqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 37801F4A-4317-11EC-A896-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 10 2021, Johannes Schindelin wrote:
>
>> Hi =C3=86var,
>>
>> On Wed, 10 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> Fix tests added in b681b191f92 (maintenance: add support for systemd
>>> timers on Linux, 2021-09-04) to run successfully on systems where
>>> systemd-analyze is installed, but on which there's a discrepancy
>>> between a FILE argument of "/lib/systemd/system/basic.target" and
>>> "systemd/user/git-maintenance@.service" succeeding.
>>
>> Could you try to rephrase `there's a discrepancy between a FILE argume=
nt
>> of "/lib/systemd/system/basic.target" and
>> "systemd/user/git-maintenance@.service" succeeding` more clearly?
>
> Sure. Briefly to test if X works our prereq should test if X can work,
> not if Y can work. Will try to update it.

Thanks.

>>>  test_systemd_analyze_verify () {
>>> -	if test_have_prereq SYSTEMD_ANALYZE
>>> -	then
>>> -		systemd-analyze verify "$@"
>>> -	fi
>>> +	# Ignoring any errors from systemd-analyze is intentional
>>> +	systemd-analyze verify "$@" >systemd.out 2>systemd.err;
>>
>> The semicolon is superfluous.
>
> We use it in other places as shorthand for "I mean to not have && here"=
.

That is news to me (not the presense of unnecessary semicolons; I do
not think we have "when you want to make it clear that you
deliberately did not write &&, write ;" in any of the guidelines,
and I am not sure if such a guideline is a good idea).

>> It is a bit sad that we're now doing unnecessary work when
>> `systemd-analyze` does not even exist.
>
> It's a chicken & egg problem. How do you figure out if you're able to
> run the command & get the output you expect without doing that?

I read "It is a bit sad" to imply "... but it probalby is the best
we can do, and more importantly, it is not worse than the problem it
is solving".

> +		-e '/git-maintenance@i*\.service:/x' \
>>
>> Lines containing `git-maintenance@.service:` (or the same pattern with=
 an
>> arbitrary number of `i`s after the `@` character???) are exchanged wit=
h
>> hold space.
>>
>> That does not look right.
>
> It'll emit @.service or @i.service. I have no idea why, yeah the regex
> is overly generous, but it doesn't hurt anything in this case (see
> below)>
>
>> Since this is a `sed -n` call, we would need an explicit `p` command t=
o
>> print anything. Therefore, the current code is a pretty expensive
>> equivalent to calling `true >&6`: it succeeds, and it does not print
>> anything.
>
> Yes, like the buggy "if the prereq succeeds" code it replaced.

If both are buggy, then there is no point replacing old with new.
Let's have a non-buggy improved new and replace buggy old with it ;-)

> Because I really don't know. Is it broken on literally one machine in
> the world that I happened to have tested on, or more generally on the
> sorts of OS version/whatever that has that systemd? No idea.
>
> But the worst we'll do here is not run a test on some obscure setup.
>
> Since the value of having the test is there if we just run it on some
> setups that's fine. We should lean towards over-suppressing it to not
> have "make test" in v2.34.0 fail on some platforms.

Hmph, if we _know_ (or _think_) the platforms that would fail a
particular test is rare enough *and* if we know we _don't_
understand why the test fails on them, wouldn't we want to know the
extent of the damage first by not suppressing the test and let it
break on these platforms that may help us after the release to
understand the breakage and deal with it?  The resolution may end up
to suppress the test after all, but with the approach we can do so
knowing why we are doing so, no?

This is different from OpenSSH 8.7 thing that we _know_ why the test
breaks, and we _know_ that there will be tons of instances with that
broken version.  Suppressing the test for them does make sense.

Thanks.

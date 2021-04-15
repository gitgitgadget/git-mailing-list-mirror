Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480FC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 13:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D878611AC
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 13:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhDONVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDONVk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 09:21:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7125DC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 06:21:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r9so36826951ejj.3
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4Ns+p2WXg6lhXwZFqSdAadLtz+tyMbveK3g/mjzul5Y=;
        b=po+I155R4AT5RF1EWF2+rArIAyeYy3WXz1IRltyWq2s35GNrOfjhZ6Xdba0QNfb2oc
         EvZsSbLUXmGzcIqtq3dkAYTxaUIMUfrJYdgn2cQ4PHPSrJwpFoiYCMHbaRbERM36mlQi
         QcpddkBuEWKNzP1ETUUBfhbOe14y00AJb20SPyy/A4ctv5KkTAhfsu88o3fZGcViAvIu
         3eY7hCDz42kNcWKR8/diLA3qdNVKiop0nwhvwmhypDLT9ygf7K0gsgtI4QxeOHOvwDl4
         YENxBNKZQT58S0dQDUitdnF7sIX+d7XFNwScBzvRJkUJYY6/4zw86Rcmxm9bfXp4cIr0
         9Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4Ns+p2WXg6lhXwZFqSdAadLtz+tyMbveK3g/mjzul5Y=;
        b=UKoFqe+35s8PDI4QsupirFXxQZFxI/tz0GZg/lAyaBpAkEFihLb0Oj5lSFo12GZzlR
         Yj4loHrplVqKH9Yje89xzKFKP5eljGK6HhxGwPMhyqXosz0UI2a28C/Kwe5hSLd4puAc
         NXV7ZnJkgmibVY3e0HY63Au+YFPkDGsGFnSbx7uM7N0VG889Hb4+IvxDlNk3hUJPc1iC
         lYNSA7R9tYf6dTEzgf0gj7h0ucZKoTainsCLvvK+gz/DRNTx4Xyp9dBM++Ao3vp5a0X3
         3M2fUQlOVcXW4DUmhfeivJb2CfZLOdZw9aG0FO2lqvtgJqqFvrnA0Y9QjVSGrY7Nv5CP
         bxGA==
X-Gm-Message-State: AOAM533f+8zyqnNBUbsL/EJKaUpzVe/kPPujpAMvm3q+mYpfFKXYkFN1
        10m/FXPy/WJWnvLCKevFU8o=
X-Google-Smtp-Source: ABdhPJwp0qBNlRW0guOic7p6Wcr15EZ2DJNjQcZu3jLrZfazbvbaAJ2N61J/20JAbfLvM03NMhcxSQ==
X-Received: by 2002:a17:906:fa07:: with SMTP id lo7mr3446287ejb.321.1618492875094;
        Thu, 15 Apr 2021 06:21:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r18sm1917540ejd.106.2021.04.15.06.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:21:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        <874kg92xn0.fsf@evledraar.gmail.com> <xmqqim4pz83e.fsf@gitster.g>
        <871rbd2u47.fsf@evledraar.gmail.com> <xmqqblahz4hx.fsf@gitster.g>
        <87y2dl18mg.fsf@evledraar.gmail.com> <xmqqlf9krmkx.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqlf9krmkx.fsf@gitster.g>
Date:   Thu, 15 Apr 2021 15:21:14 +0200
Message-ID: <8735vrvg39.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 15 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> What I am saying is that it's incompatible to have:
>>
>>  1. Failing tests
>>  2. Not removing scratch files that would otherwise be removed
>>
>> And:
>>
>>  3. Knowing that the rest of the tests pass in the case of #1 without
>>     reading them all.
>>
>> Hence the suggestion that we should use test_when_finished without
>> exception for such patterns.
>
> I disagree with the above; t4013's "read magic cmd" part is designed
> to be independent from each other; I do not think you need to read
> all of the parts enclosed in << ... EOF to understand that.
>
> In short,
>
>  * "test_when_finished 'rm ...'" is a good tool to ensure something
>    gets removed no matter what else happens in the same test.  Since
>    it does not run the clean-up under "-i", it can even be used on
>    files that would be useful in diagnosing failures.  But under
>    "-d", it does clean-up to avoid affecting the following test.
>
>  * $actual was made unique so that even under "-d", a failing test
>    would not negatively affect the subsequent ones. [...]

I don't mind disagreeing with you, but I do feel like we're just talking
past each other, either that or we've got a different understanding of
"negatively affect the subsequent ones".

I'm saying that yes I agree that *right now* it doesn't negatively
affect any of the subsequent ones, but that you can only know that if
you need all the tests in the file past the one you're modifying.

I.e. imagine if we added, obviously contrived, but a stand-in for "we
expect consistent state":
=09
	diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
	index 6cca8b84a6b..a326968e8f3 100755
	--- a/t/t4013-diff-various.sh
	+++ b/t/t4013-diff-various.sh
	@@ -526,4 +526,9 @@ test_expect_success 'diff -I<regex>: detect malformed =
regex' '
	 	test_i18ngrep "invalid regex given to -I: " error
	 '
=09=20
	+test_expect_success 'stuff' '
	+	find * -type f >actual &&
	+	test_line_count =3D 9 actual
	+'
	+
	 test_done

Now run it, and you'll pass them all, now break one of the earlier tests
with:

    >t4013/diff.log_-GF_-p_--pickaxe-all_master

You'll fail two tests (the expected one, and the new one), instead of
just one, which is purely an artifact of the earlier test's cleanup /
state being different as a result of whether it passes or not.

With my patch you'll fail just the one earlier test, because we do the
same cleanup no matter whether we failed midway through it or not.

So yes, while this small series amounts to re-arranging some deck chairs
on the Titanic I do think not being able to rely on consistent state is
a big anti-pattern in the test suite in general.

It's a big part of the reason for why you can't reliably use --run=3DN or
GIT_SKIP_TESTS (especially in cases of partial failures) to selectively
skip things without what amounts to bespoke analysis of each test you'd
like to run a subset of.

Now, of course test_when_finished won't get us there by itself, we'd
also need consistently use some "test_expect_setup" to clearly delineate
"setup" and other "this must run" state changes from "just consumes
existing state and resets". But consistently writing new/modified tests
as "just consumes existing state and resets" will slowly get us there.

>    [...] Removing it for
>    failure cases is actively wrong, so use of test_when_finished,
>    which may be an expedient way to remove artifact that would
>    negatively affect later test pieces, does not apply --- existing
>    code is doing better than test_when_finished can offer, and
>    replacing it with test_when_finished is a regression.

Aside from whether we agree or disagree on whether test_when_finished
should be consistently used to clean up state I genuinely still don't
see how the sum total of replacing the current "rm && cp" with
"test_when_finished && BUG" leaves us worse off.

Are you thinking of the case where someone wants to add N new lines to
the "while read magic cmd" loop?

That's the only case I can think of that would arguably be worse, but I
think it's far outweighed by the more obvious failure mode, and a "git
blame" on the lines it consumes shows that additions are very occasional
(and not in large batches).

Other than that, under e.g. -vixd having the test suite stop on the
specific line that failed (the test_cmp, not a "false" after some "cp")
is how most other tests works, and I think makes things much more
readable and understandable at a glance.

>  * And the most important part: the unnecessary removal of $actual
>    was not even part of the "flakyness-causing" bug you started this
>    topic to fix anyway.  We should just remove the regression caused
>    by unnecessary use of test_when_finished and focus on the "don't
>    place the actual output from a brand new test under the file used
>    for the expectation the next time---instead place it under
>    temporary file and call for attention" part, which was the real
>    improvement.

I see your point and agree in theory that the "we write into the
t/t4013/ directory" and "we inconsistently clear up the trash directory
on OK/NOK" are in principle different issues.

But in this case we always removed or copied "$actual" away from its
original name before, we do the same now (just more reliably, and in a
way that doesn't cause flakyness in the "cp" case).

So I don't really see how to split up those two arguably different
changes in a way that would make sense.

The only case where "$actual" was left before was (I think) a clear of
leaking state unnecessarily outside of --immediate.

>>> Please do not advocate for and encourage newbies who would be
>>> reading the discussion from sidelines to use test_when_finished out
>>> of dogmatic principle without thinking.
>>
>> Is Matheus the newbie here? I think he's contributed enough to form his
>> own opinion.
>
> No, those "reading the discussion from sidelines" are not on To: or
> Cc:, but are eager to learn by reading what is available to git@
> subscribers (including the lore archive).  I do not want those of us
> whose name appear often in the list archive to be sending a wrong
> signal to them.

I'll endeavor to make it clear that my opinion is just my opinion
etc. in the future, I thought it was clear from the context :)

>> In any case, I think it's best to just drop this series.
>
> That is a sad and wrong conclusion.  We should just realize what we
> really wanted to fix in the first place and keep the improvement;
> otherwise all the review time was wasted.

To be clear that's not some "I can't have the change I want so I'm
taking my toys and going home" tantrum. I don't mind making changes in
response to reviews etc.

As noted above I'm genuinely still unable to see how I'd selectively
untangle the change I made in a way that both wouldn't either fix bugs
in the test, or introduce new bugs while I was at it, and that I'd be
comfortable putting my name behind.

Hence the suggestion that since we're already we past the point of just
having come up with two independent approaches to this in terms of time
investment, that doing so would be a better thing overall.

I do think (and would be willing to work on) that t/README should have
some summary of best practices for new/updated tests that we should be
striving for. Looking at our "test_when_finished" there's at least tow
independent bugs[1] in it, so ther's some room for improvement.

1. It creates a ref with echo, but removes it with update-ref -d, which
   e.g. couldn't delete a corrupt ref (if rev-parse is buggy); and more
   importantly if rev-parse dies midway through we're left with a
   corrupt repo, the "test_when_finished ... update-ref -d" should come
   *first*.


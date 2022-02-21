Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB56C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 22:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbiBUWwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 17:52:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiBUWwO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 17:52:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F53DEEB
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 14:51:48 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hw13so36760132ejc.9
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 14:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=J2caHvY5Z4uyo9Py+WaIic8L6leQGhM+fkfCBv287g4=;
        b=a+noYyI6BzBe9bzggZ02ViIlgt7y2fOczo/1ADKGxVWo3b+6EkPAxyL6vud4PkjXQ1
         unrERD64w/V4biPBFaMm+gjX3uTandJ2RP/dajimivip7EaN99Yj4TrSaxOgOil140q6
         m2xZCI+8VEnAkI6d/H+FAjqfpAJ/f/YrmT46agwmOPJZFG+m6bbv9lDdSEarVZipmMOD
         Ajp9qsY8W0CiytRkWka9w7IAZp3MYilKZ8ZsRLr9JiarUM861yqbp6P69G/3CS7QAVNB
         9aI6MqTI3XPHP7OJf3oWl2yoasE1gFG83S39ca4JKiE2DBHfMa/Poh5Xd8bB46FwTYN1
         P/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=J2caHvY5Z4uyo9Py+WaIic8L6leQGhM+fkfCBv287g4=;
        b=7q830JUM3kszgWHo1I+w+69AH7muolnTD0PSHvw//PVrx+YORpNPs4tRQFquhq68Mx
         04oHE/Kuk13jTXUWIRNIx2+ujcRmHwIxVKR1R6fzpKM9HO4Op0Pz8I+w89DV72SlpFWF
         oRA60+7dsdmXJu8AWZISSf2HPYMyBBG4cCufOVOS4ykN1CywlwOQZaWbIhozEB/mSr1/
         lSbKvXsOE8w9a3PUOEz6nJQypEtqgbZFuM307EZlQKI8Pz15EYY50uNyAjYkkDWWlK9p
         TW63QntFOozYwFTsVcHiGjEfTWm94/v2p0GzLJvwwjP5+r4cRM/DgirWAb09cdZc7RRK
         ocXA==
X-Gm-Message-State: AOAM533ESJIfcI6vud7JjaJcYHRtolSxAtvBuS/4tYgqtiUpXWfAHSNT
        w+Ce+84SAyXpZbYmFlQuQCs=
X-Google-Smtp-Source: ABdhPJyqOIOt6WxDgzAwLWpC7/uIggmHRbZp5lt1L76InWv82VlcmtMj7/upXyR/gqKOP/bIF0bwDA==
X-Received: by 2002:a17:906:2719:b0:6cf:37ec:d47f with SMTP id z25-20020a170906271900b006cf37ecd47fmr18090031ejc.401.1645483907284;
        Mon, 21 Feb 2022 14:51:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 2sm5686816ejl.2.2022.02.21.14.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 14:51:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMHWz-005qBE-CL;
        Mon, 21 Feb 2022 23:51:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/3] test-lib.sh: have all tests pass under "-x",
 remove BASH_XTRACEFD
Date:   Mon, 21 Feb 2022 23:41:01 +0100
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
        <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
        <20211213054353.GC3400@szeder.dev>
        <220221.86v8x89ebo.gmgdl@evledraar.gmail.com>
        <20220221210319.GA1658@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220221210319.GA1658@szeder.dev>
Message-ID: <220221.86ee3val4u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, SZEDER G=C3=A1bor wrote:

> On Mon, Feb 21, 2022 at 08:52:18PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> [Junio: If you'd like to pick up this series it still cleanly applies,
>> and merges cleanly with "seen"]
>>=20
>> On Mon, Dec 13 2021, SZEDER G=C3=A1bor wrote:
>>=20
>> Sorry about the late reply, things getting lost around the holidays
>> etc.
>>=20
>> > On Mon, Dec 13, 2021 at 02:38:33AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> A re-arrangement-only change to v3[1]. The previous 2/2 is now split
>> >> into two commits, as requested by SZEDER[2] in the removal of
>> >> BASH_XTRACEFD is now its own commit & the rationale for doing so is
>> >> outlined in detail.
>> >
>> > I'm afraid I wasn't clear.  What I meant was that if we were to remove
>> > BASH_XTRACEFD, then it should be done its own commit.
>>=20
>> Aside from whether you think removing it is a good idea, isn't that what
>> this v4 does?
>
> Well, yes, but I now realize that I wasn't sufficiently clear the
> second time around, either, and emphasis doesn't travel well over
> email.  What I meant was that: _if_ at all we were to remove it, then
> it should be a separate patch, but since we should most definitely
> keep it, those hunks should be simply dropped.

I understand, thanks.

>> In 1/3 I fix -x under non-BASH_XTRACEFD, 2/3 removes test_untraceable,
>> and 3/3 the use of BASH_XTRACEFD.
>>=20
>> > But again: BASH_XTRACEFD is the only simple yet reliable and robust
>> > way to get -x trace from our tests, so do not remove it.
>>=20
>> Just to tie off this loose end, I re-read the thread ending in [1] (sent
>> after this reply of yours) and I think my [1] addresses this.
>
> It doesn't at all; "if CI passes without it, then we can remove it" is
> not a convincing argument.

Yes I agree that would be a bad argument, but it's not the one I'm
making.

The one I am making is in
https://lore.kernel.org/git/211216.864k78bsjs.gmgdl@evledraar.gmail.com

I.e. I agree that it's a useful feature, and I wish in the abstract that we
could make real use of it.

But that would mean a hard dependency on bash, which I don't think would
be acceptable, or something anyone's advocating for.

As long as we're not going down that road I don't see the point in using
it.

The only practical use of it in the test suite is to support a
special-case I'm making un-special in 1/3, because I wanted "-x" output
without needing to run bash. As it turned out it wasn't hard to do, and
is consistent with how other tests are written).

So what's your argument for it? I.e. how are we practically going to use
it in a way that makes a difference?

I only see us not really using it, because our behavior in practice will
1=3D1 mirror non-bash shells.

By keeping it around we're only exposing ourselves to edge cases and
hiding bugs that we'd like to fix sooner than later anyway (and which
are fixed as of this 1/3, and before that mostly were in your earlier
series).

So would test code that depended on bash and BASH_XTRACEFD be more
"reliable and robust"? Absolutely, you wouldn't need to worry about some
interpolated $(pwd) or whatever in a string getting into your -x output
when you didn't expect it.

But with how we're using it it's doing the opposite of that. It'll only
hide those bugs for non-bash users.

I may be entirely wrong, or perhaps I haven't considered some edge case
or trade-off you have in mind. But I'm not able to bridge that gap with
your rather terse replies :)

>> Maybe you still disagree, but I don't see how that squares with
>> "reliable and robust" here.
>>=20
>> I.e. unless we're talking about carrying bash-specific code in the test
>> suite we can't make any real use of the feature, as our tests will need
>> to be compatible with other POSIX shells.
>>=20
>> I mean, the code changed in 1/3 *was* that bash-specific code, but as
>> that change shows it was rather easily made non-bash-specific. And
>> unless we think we'll add other bash-specific tests (I don't see why,
>> the cross-shell -x support is rather easy to do) ....
>>=20
>> 1. https://lore.kernel.org/git/211216.864k78bsjs.gmgdl@evledraar.gmail.c=
om/
>>=20
>> >> 1. https://lore.kernel.org/git/cover-v3-0.2-00000000000-20211210T1005=
12Z-avarab@gmail.com/
>> >> 2. https://lore.kernel.org/git/20211212201441.GB3400@szeder.dev/
>> >>=20
>> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>> >>   t1510: remove need for "test_untraceable", retain coverage
>> >>   test-lib.sh: remove the now-unused "test_untraceable" facility
>> >>   test-lib.sh: remove "BASH_XTRACEFD"
>> >>=20
>> >>  t/README              |  3 --
>> >>  t/t1510-repo-setup.sh | 85 +++++++++++++++++++++--------------------=
--
>> >>  t/test-lib.sh         | 66 ++++-----------------------------
>> >>  3 files changed, 49 insertions(+), 105 deletions(-)
>> >>=20
>> >> Range-diff against v3:
>> >> 1:  7876202c5b0 =3D 1:  9e7b089dc50 t1510: remove need for "test_untr=
aceable", retain coverage
>> >> -:  ----------- > 2:  60883fd95cb test-lib.sh: remove the now-unused =
"test_untraceable" facility
>> >> 2:  a7fc794e20d ! 3:  8b5ae33376e test-lib.sh: remove the now-unused =
"test_untraceable" facility
>> >>     @@ Metadata
>> >>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> >>=20=20=20=20=20=20
>> >>       ## Commit message ##
>> >>     -    test-lib.sh: remove the now-unused "test_untraceable" facili=
ty
>> >>     +    test-lib.sh: remove "BASH_XTRACEFD"
>> >>=20=20=20=20=20=20
>> >>     -    In the preceding commit the use of "test_untraceable=3DUnfor=
tunatelyYes"
>> >>     -    was removed from "t1510-repo-setup.sh" in favor of more narr=
ow
>> >>     -    redirections of the output of specific commands (and not ent=
ire
>> >>     -    sub-shells or functions).
>> >>     +    Stop setting "BASH_XTRACEFD=3D4" to direct "-x" output to fi=
le
>> >>     +    descriptor 4 under bash.
>> >>=20=20=20=20=20=20
>> >>     -    This is in line with the fixes in the series that introduced=
 the
>> >>     -    "test_untraceable" facility. See 571e472dc43 (Merge branch
>> >>     -    'sg/test-x', 2018-03-14) for the series as a whole, and
>> >>     -    e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr o=
f a
>> >>     -    subshell, 2018-02-24) for a commit that's in line with the c=
hanges in
>> >>     -    the preceding commit.
>> >>     +    When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
>> >>     +    automatically, 2016-05-11) it was needed as a workaround for=
 various
>> >>     +    tests that didn't pass cleanly under "-x".
>> >>=20=20=20=20=20=20
>> >>     -    We've thus solved the TODO item noted when "test_untraceable=
" was
>> >>     -    added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-se=
tup: mark
>> >>     -    as untraceable with '-x', 2018-02-24).
>> >>     +    Most of those were later fixed in 71e472dc43 (Merge branch
>> >>     +    'sg/test-x', 2018-03-14), and in the preceding commits we've=
 fixed the
>> >>     +    final remaining and removed the "test_untraceable" facility.
>> >>=20=20=20=20=20=20
>> >>     -    So let's remove the feature entirely. Not only is it current=
ly unused,
>> >>     -    but it actively encourages an anti-pattern in our tests. We =
should be
>> >>     -    testing the output of specific commands, not entire subshell=
s or
>> >>     -    functions.
>> >>     +    The reason we don't need this anymore is becomes clear from =
reading
>> >>     +    the rationale in d88785e424a and applying those arguments to=
 the
>> >>     +    current state of the codebase. In particular it said (with "=
this" and
>> >>     +    "it" referring to the problem of tests failing under "-x"):
>> >>=20=20=20=20=20=20
>> >>     -    That the "-x" output had to be disabled as a result is only =
one
>> >>     -    symptom, but even under bash those tests will be harder to d=
ebug as
>> >>     -    the subsequent check of the redirected file will be far remo=
ved from
>> >>     -    the command that emitted the output.
>> >>     +        "there here isn't a portable or scalable solution to thi=
s [...] we
>> >>     +        can work around it by pointing the "set -x" output to our
>> >>     +        descriptor 4"
>> >>=20=20=20=20=20=20
>> >>     -    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com>
>> >>     +    And finally that:
>> >>=20=20=20=20=20=20
>> >>     - ## t/README ##
>> >>     -@@ t/README: appropriately before running "make". Short options =
can be bundled, i.e.
>> >>     - -x::
>> >>     - 	Turn on shell tracing (i.e., `set -x`) during the tests
>> >>     - 	themselves. Implies `--verbose`.
>> >>     --	Ignored in test scripts that set the variable 'test_untraceabl=
e'
>> >>     --	to a non-empty value, unless it's run with a Bash version
>> >>     --	supporting BASH_XTRACEFD, i.e. v4.1 or later.
>> >>     -=20
>> >>     - -d::
>> >>     - --debug::
>> >>     +        "Automatic tests for our "-x" option may be a bit too me=
ta"
>> >>     +
>> >>     +    Those tests are exactly what we've had since aedffe95250 (tr=
avis-ci:
>> >>     +    run tests with '-x' tracing, 2018-02-24), so punting on fixi=
ng issues
>> >>     +    with "-x" by using "BASH_XTRACEFD=3D4" isn't needed anymore,=
 we're now
>> >>     +    committing to maintaining the test suite in a way that won't=
 break
>> >>     +    under "-x".
>> >>     +
>> >>     +    We could retain "BASH_XTRACEFD=3D4" anyway, but doing so is =
bad because:
>> >>     +
>> >>     +     1) Since we're caring about "-x" passing in CI under "dash"=
 on Ubuntu
>> >>     +        using "BASH_XTRACEFD=3D4" will amount to hiding an error=
 we'll run
>> >>     +        into eventually. Tests will pass locally with "bash", bu=
t fail in
>> >>     +        CI with "dash" (or under other non-"bash" shells).
>> >>     +
>> >>     +     2) As the amended code in "test_eval_" shows (an amended re=
vert to
>> >>     +        the pre-image of d88785e424a) it's simpler to not have t=
o take
>> >>     +        this "bash" special-case into account.
>> >>     +
>> >>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com>
>> >>=20=20=20=20=20=20
>> >>       ## t/test-lib.sh ##
>> >>     -@@ t/test-lib.sh: then
>> >>     - 	exit
>> >>     - fi
>> >>     -=20
>> >>     --if test -n "$trace" && test -n "$test_untraceable"
>> >>     --then
>> >>     --	# '-x' tracing requested, but this test script can't be reliab=
ly
>> >>     --	# traced, unless it is run with a Bash version supporting
>> >>     --	# BASH_XTRACEFD (introduced in Bash v4.1).
>> >>     --	#
>> >>     --	# Perform this version check _after_ the test script was
>> >>     --	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
>> >>     --	# '--verbose-log', so the right shell is checked and the
>> >>     --	# warning is issued only once.
>> >>     --	if test -n "$BASH_VERSION" && eval '
>> >>     --	     test ${BASH_VERSINFO[0]} -gt 4 || {
>> >>     --	       test ${BASH_VERSINFO[0]} -eq 4 &&
>> >>     --	       test ${BASH_VERSINFO[1]} -ge 1
>> >>     --	     }
>> >>     --	   '
>> >>     --	then
>> >>     --		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
>> >>     --	else
>> >>     --		echo >&2 "warning: ignoring -x; '$0' is untraceable without B=
ASH_XTRACEFD"
>> >>     --		trace=3D
>> >>     --	fi
>> >>     --fi
>> >>     - if test -n "$trace" && test -z "$verbose_log"
>> >>     - then
>> >>     - 	verbose=3Dt
>> >>      @@ t/test-lib.sh: else
>> >>       	exec 4>/dev/null 3>/dev/null
>> >>       fi
>> >> --=20
>> >> 2.34.1.1024.g573f2f4b767
>> >>=20
>>=20
>> o


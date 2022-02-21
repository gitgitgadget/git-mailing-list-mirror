Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C11C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 20:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiBUUEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:04:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiBUUEk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 15:04:40 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A301237CD
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:04:15 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id r13so12944394ejd.5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RS7EQqvpsQEoXk+CUHdQkT6U8HTT+O+YZ+zksb9I14E=;
        b=ZW7Ms8NVAH9aGJ9dfH4eDG1nXJHyWbnzthPh80IVuYxsdlBBbFyxw09ClbH2JT9rOx
         UEbfy3hA4lwKNzko+B0G3+Z16G37yz3D4QD0rye5mstLwnh47jjeDTv/BuhSGKwvbPZZ
         iVUGAm8ANhc64oCFYJE+JOqoE/rpq9F7cXaKQ7IeeGFudiEm+Y0NVmXWjw/qH8MUgCHH
         hQHewOaa27iZ5hrhoHM6bWywMyPcT5lxaZf41KTI7/5pSQBz/jnDOcGdy1GY+eDlsWy5
         pcgaQaowC84edg6hXhX4ycB0ww5UbMWuXrdie2mrx9t/g7ufv/IHpxSaKwEhf+Ras89y
         JBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RS7EQqvpsQEoXk+CUHdQkT6U8HTT+O+YZ+zksb9I14E=;
        b=IyrqG7T2iyLEnet4DQkUTE65WLsqeBH1ngRaaRgJB2dwuwkojb277KjVjqSigf+bty
         ykiWvb2Kz6YZto0S9T3q6yW+wDJJTCPySDN+trkDv/Z958foLfuJvUvN2oi9TLVq+cMv
         P3m86jNXGgypuftQVT9UIJP+7MqHyv/O4ht99+AuIsc0SR5Rq+OtkFPOWjcHjTzsAq4o
         dgw6RvJWurC5obh7/VO+kQHqKVvf7QrkrILe5k/MLlWkdpvBw193h3QaC+vhtPbUHTuG
         yeApvQKNlf4ybv1LcD3agsWGLvbe+7vjCff5PNmrssF9yyKM8d8LXE5MJYHbfbQoB64x
         JhYQ==
X-Gm-Message-State: AOAM531y9RJ6myXzs/kzp1KhIRTiK6aLj/y2aXOVaZnUuHGWd0Bv3kif
        EVAvdjq+NkmAjO8N9dOaRek=
X-Google-Smtp-Source: ABdhPJyEMpsfth1wmFmMFatNnpkERIX0yhNCAQooy2/mhrbAZv4SXU2mQ4ELjeZNEaVcBzq29T6fCA==
X-Received: by 2002:a17:906:2f94:b0:6cf:e4f7:13a with SMTP id w20-20020a1709062f9400b006cfe4f7013amr16457764eji.269.1645473853442;
        Mon, 21 Feb 2022 12:04:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n25sm8999040eds.89.2022.02.21.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 12:04:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMEup-005nzk-Ci;
        Mon, 21 Feb 2022 21:04:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 0/3] test-lib.sh: have all tests pass under "-x",
 remove BASH_XTRACEFD
Date:   Mon, 21 Feb 2022 20:52:18 +0100
References: <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <cover-v4-0.3-00000000000-20211213T013559Z-avarab@gmail.com>
 <20211213054353.GC3400@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211213054353.GC3400@szeder.dev>
Message-ID: <220221.86v8x89ebo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Junio: If you'd like to pick up this series it still cleanly applies,
and merges cleanly with "seen"]

On Mon, Dec 13 2021, SZEDER G=C3=A1bor wrote:

Sorry about the late reply, things getting lost around the holidays
etc.

> On Mon, Dec 13, 2021 at 02:38:33AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> A re-arrangement-only change to v3[1]. The previous 2/2 is now split
>> into two commits, as requested by SZEDER[2] in the removal of
>> BASH_XTRACEFD is now its own commit & the rationale for doing so is
>> outlined in detail.
>
> I'm afraid I wasn't clear.  What I meant was that if we were to remove
> BASH_XTRACEFD, then it should be done its own commit.

Aside from whether you think removing it is a good idea, isn't that what
this v4 does?

In 1/3 I fix -x under non-BASH_XTRACEFD, 2/3 removes test_untraceable,
and 3/3 the use of BASH_XTRACEFD.

> But again: BASH_XTRACEFD is the only simple yet reliable and robust
> way to get -x trace from our tests, so do not remove it.

Just to tie off this loose end, I re-read the thread ending in [1] (sent
after this reply of yours) and I think my [1] addresses this.

Maybe you still disagree, but I don't see how that squares with
"reliable and robust" here.

I.e. unless we're talking about carrying bash-specific code in the test
suite we can't make any real use of the feature, as our tests will need
to be compatible with other POSIX shells.

I mean, the code changed in 1/3 *was* that bash-specific code, but as
that change shows it was rather easily made non-bash-specific. And
unless we think we'll add other bash-specific tests (I don't see why,
the cross-shell -x support is rather easy to do) ....

1. https://lore.kernel.org/git/211216.864k78bsjs.gmgdl@evledraar.gmail.com/

>> 1. https://lore.kernel.org/git/cover-v3-0.2-00000000000-20211210T100512Z=
-avarab@gmail.com/
>> 2. https://lore.kernel.org/git/20211212201441.GB3400@szeder.dev/
>>=20
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>>   t1510: remove need for "test_untraceable", retain coverage
>>   test-lib.sh: remove the now-unused "test_untraceable" facility
>>   test-lib.sh: remove "BASH_XTRACEFD"
>>=20
>>  t/README              |  3 --
>>  t/t1510-repo-setup.sh | 85 +++++++++++++++++++++----------------------
>>  t/test-lib.sh         | 66 ++++-----------------------------
>>  3 files changed, 49 insertions(+), 105 deletions(-)
>>=20
>> Range-diff against v3:
>> 1:  7876202c5b0 =3D 1:  9e7b089dc50 t1510: remove need for "test_untrace=
able", retain coverage
>> -:  ----------- > 2:  60883fd95cb test-lib.sh: remove the now-unused "te=
st_untraceable" facility
>> 2:  a7fc794e20d ! 3:  8b5ae33376e test-lib.sh: remove the now-unused "te=
st_untraceable" facility
>>     @@ Metadata
>>      Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>=20=20=20=20=20=20
>>       ## Commit message ##
>>     -    test-lib.sh: remove the now-unused "test_untraceable" facility
>>     +    test-lib.sh: remove "BASH_XTRACEFD"
>>=20=20=20=20=20=20
>>     -    In the preceding commit the use of "test_untraceable=3DUnfortun=
atelyYes"
>>     -    was removed from "t1510-repo-setup.sh" in favor of more narrow
>>     -    redirections of the output of specific commands (and not entire
>>     -    sub-shells or functions).
>>     +    Stop setting "BASH_XTRACEFD=3D4" to direct "-x" output to file
>>     +    descriptor 4 under bash.
>>=20=20=20=20=20=20
>>     -    This is in line with the fixes in the series that introduced the
>>     -    "test_untraceable" facility. See 571e472dc43 (Merge branch
>>     -    'sg/test-x', 2018-03-14) for the series as a whole, and
>>     -    e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
>>     -    subshell, 2018-02-24) for a commit that's in line with the chan=
ges in
>>     -    the preceding commit.
>>     +    When it was added in d88785e424a (test-lib: set BASH_XTRACEFD
>>     +    automatically, 2016-05-11) it was needed as a workaround for va=
rious
>>     +    tests that didn't pass cleanly under "-x".
>>=20=20=20=20=20=20
>>     -    We've thus solved the TODO item noted when "test_untraceable" w=
as
>>     -    added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup=
: mark
>>     -    as untraceable with '-x', 2018-02-24).
>>     +    Most of those were later fixed in 71e472dc43 (Merge branch
>>     +    'sg/test-x', 2018-03-14), and in the preceding commits we've fi=
xed the
>>     +    final remaining and removed the "test_untraceable" facility.
>>=20=20=20=20=20=20
>>     -    So let's remove the feature entirely. Not only is it currently =
unused,
>>     -    but it actively encourages an anti-pattern in our tests. We sho=
uld be
>>     -    testing the output of specific commands, not entire subshells or
>>     -    functions.
>>     +    The reason we don't need this anymore is becomes clear from rea=
ding
>>     +    the rationale in d88785e424a and applying those arguments to the
>>     +    current state of the codebase. In particular it said (with "thi=
s" and
>>     +    "it" referring to the problem of tests failing under "-x"):
>>=20=20=20=20=20=20
>>     -    That the "-x" output had to be disabled as a result is only one
>>     -    symptom, but even under bash those tests will be harder to debu=
g as
>>     -    the subsequent check of the redirected file will be far removed=
 from
>>     -    the command that emitted the output.
>>     +        "there here isn't a portable or scalable solution to this [=
...] we
>>     +        can work around it by pointing the "set -x" output to our
>>     +        descriptor 4"
>>=20=20=20=20=20=20
>>     -    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>>     +    And finally that:
>>=20=20=20=20=20=20
>>     - ## t/README ##
>>     -@@ t/README: appropriately before running "make". Short options can=
 be bundled, i.e.
>>     - -x::
>>     - 	Turn on shell tracing (i.e., `set -x`) during the tests
>>     - 	themselves. Implies `--verbose`.
>>     --	Ignored in test scripts that set the variable 'test_untraceable'
>>     --	to a non-empty value, unless it's run with a Bash version
>>     --	supporting BASH_XTRACEFD, i.e. v4.1 or later.
>>     -=20
>>     - -d::
>>     - --debug::
>>     +        "Automatic tests for our "-x" option may be a bit too meta"
>>     +
>>     +    Those tests are exactly what we've had since aedffe95250 (travi=
s-ci:
>>     +    run tests with '-x' tracing, 2018-02-24), so punting on fixing =
issues
>>     +    with "-x" by using "BASH_XTRACEFD=3D4" isn't needed anymore, we=
're now
>>     +    committing to maintaining the test suite in a way that won't br=
eak
>>     +    under "-x".
>>     +
>>     +    We could retain "BASH_XTRACEFD=3D4" anyway, but doing so is bad=
 because:
>>     +
>>     +     1) Since we're caring about "-x" passing in CI under "dash" on=
 Ubuntu
>>     +        using "BASH_XTRACEFD=3D4" will amount to hiding an error we=
'll run
>>     +        into eventually. Tests will pass locally with "bash", but f=
ail in
>>     +        CI with "dash" (or under other non-"bash" shells).
>>     +
>>     +     2) As the amended code in "test_eval_" shows (an amended rever=
t to
>>     +        the pre-image of d88785e424a) it's simpler to not have to t=
ake
>>     +        this "bash" special-case into account.
>>     +
>>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
>>=20=20=20=20=20=20
>>       ## t/test-lib.sh ##
>>     -@@ t/test-lib.sh: then
>>     - 	exit
>>     - fi
>>     -=20
>>     --if test -n "$trace" && test -n "$test_untraceable"
>>     --then
>>     --	# '-x' tracing requested, but this test script can't be reliably
>>     --	# traced, unless it is run with a Bash version supporting
>>     --	# BASH_XTRACEFD (introduced in Bash v4.1).
>>     --	#
>>     --	# Perform this version check _after_ the test script was
>>     --	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
>>     --	# '--verbose-log', so the right shell is checked and the
>>     --	# warning is issued only once.
>>     --	if test -n "$BASH_VERSION" && eval '
>>     --	     test ${BASH_VERSINFO[0]} -gt 4 || {
>>     --	       test ${BASH_VERSINFO[0]} -eq 4 &&
>>     --	       test ${BASH_VERSINFO[1]} -ge 1
>>     --	     }
>>     --	   '
>>     --	then
>>     --		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
>>     --	else
>>     --		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH=
_XTRACEFD"
>>     --		trace=3D
>>     --	fi
>>     --fi
>>     - if test -n "$trace" && test -z "$verbose_log"
>>     - then
>>     - 	verbose=3Dt
>>      @@ t/test-lib.sh: else
>>       	exec 4>/dev/null 3>/dev/null
>>       fi
>> --=20
>> 2.34.1.1024.g573f2f4b767
>>=20

o

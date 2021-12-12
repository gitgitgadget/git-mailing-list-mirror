Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF5C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhLLRHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhLLRHl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 12:07:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25447C061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 09:07:41 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so44739739edd.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gefq2k/h/gRm4WrGGjDR+TWgEhntdv0POsZJ4BKsUKQ=;
        b=QkNi7I54UTh8ElC58Pz7OMGin7fTHsHIIa7uFMyzdCi+H4PJQIA49cI+fKEa+426cG
         2r19Ql83WcbHQlei7+gYMrgUbYMSk43i/RhaTiKVSvMJhHknXy8Moxmw/FJitSFkSs//
         f/4sleV25/+xaSFC2rN5gd9ZWnn4iGfkng1uv9D1nbenQYT1ixra/P+DmSEzxCWLKYU9
         rXgscaGyQ79TqBILJszohoOFtZ4Stk9EdV41njoFkxueKMj/tCkAWutD1UPR6QJvsYB4
         1i1Bi1ChyECovTyH2TfrIlgubIqzeZixQAf67+755qvUR2aI4Gp2c9TKywMqiqNt1603
         kEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gefq2k/h/gRm4WrGGjDR+TWgEhntdv0POsZJ4BKsUKQ=;
        b=wp62MU5Waias7uJdy66J0EDOd5GeLuBVbFduqXpIZubIE758aSYHuhN5T2iCQnPI5P
         UW6YvTCAfJTE3+9j0veFYlZEOJoSB7pPWZU7znVmBJXfHfJqJq5yfhten1+OJuGnHFMP
         yTzXprBGTH1Q8AfrKjI/5VyCr9kfafQ4AL2CDJb3tJ1Gy8Kn/tQV84CcSmiX3kbNnzIN
         qDOyHrP9aAb+26wruShtzR7E8x659uNAK7iqINuh2yH8r5j1mT/JQfESPV4TZ8xz/o62
         YNqgTwA1ZC2dNTX5CnO+tjffn0syjNzBFKmxQ2zWt/R85WgMmyeozjH3KGWBvwLT5BQv
         mTyw==
X-Gm-Message-State: AOAM5329EU60N6pEMbHkm9SjaguShVXFE/iLM4xSN6F8aG4g9jRTexvh
        QxoGloSmfKMPZref2X2CDpaSK7HXg6E=
X-Google-Smtp-Source: ABdhPJyW8BtlNHE0Y52rlLEJjIrPIrti0K9fkn6oA9JrTKneXN+TlA2YR7fZY/ps7FD6t4rUWr5SkA==
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr57078691edd.123.1639328859514;
        Sun, 12 Dec 2021 09:07:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qf8sm4651945ejc.8.2021.12.12.09.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 09:07:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwSK2-000Wrw-4D;
        Sun, 12 Dec 2021 18:07:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
Date:   Sun, 12 Dec 2021 18:06:31 +0100
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
 <20211212163207.GA3400@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211212163207.GA3400@szeder.dev>
Message-ID: <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 12 2021, SZEDER G=C3=A1bor wrote:

> On Fri, Dec 10, 2021 at 11:07:55AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> In the preceding commit the use of "test_untraceable=3DUnfortunatelyYes"
>> was removed from "t1510-repo-setup.sh" in favor of more narrow
>> redirections of the output of specific commands (and not entire
>> sub-shells or functions).
>>=20
>> This is in line with the fixes in the series that introduced the
>> "test_untraceable" facility. See 571e472dc43 (Merge branch
>> 'sg/test-x', 2018-03-14) for the series as a whole, and
>> e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
>> subshell, 2018-02-24) for a commit that's in line with the changes in
>> the preceding commit.
>>=20
>> We've thus solved the TODO item noted when "test_untraceable" was
>> added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
>> as untraceable with '-x', 2018-02-24).
>>=20
>> So let's remove the feature entirely. Not only is it currently unused,
>> but it actively encourages an anti-pattern in our tests. We should be
>> testing the output of specific commands, not entire subshells or
>> functions.
>>=20
>> That the "-x" output had to be disabled as a result is only one
>> symptom, but even under bash those tests will be harder to debug as
>> the subsequent check of the redirected file will be far removed from
>> the command that emitted the output.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/README      |  3 ---
>>  t/test-lib.sh | 66 ++++++---------------------------------------------
>>  2 files changed, 7 insertions(+), 62 deletions(-)
>>=20
>> diff --git a/t/README b/t/README
>> index 29f72354bf1..3d30bbff34a 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -86,9 +86,6 @@ appropriately before running "make". Short options can=
 be bundled, i.e.
>>  -x::
>>  	Turn on shell tracing (i.e., `set -x`) during the tests
>>  	themselves. Implies `--verbose`.
>> -	Ignored in test scripts that set the variable 'test_untraceable'
>> -	to a non-empty value, unless it's run with a Bash version
>> -	supporting BASH_XTRACEFD, i.e. v4.1 or later.
>>=20=20
>>  -d::
>>  --debug::
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 57efcc5e97a..b008716917b 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -381,29 +381,6 @@ then
>>  	exit
>>  fi
>>=20=20
>> -if test -n "$trace" && test -n "$test_untraceable"
>> -then
>> -	# '-x' tracing requested, but this test script can't be reliably
>> -	# traced, unless it is run with a Bash version supporting
>> -	# BASH_XTRACEFD (introduced in Bash v4.1).
>> -	#
>> -	# Perform this version check _after_ the test script was
>> -	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
>> -	# '--verbose-log', so the right shell is checked and the
>> -	# warning is issued only once.
>> -	if test -n "$BASH_VERSION" && eval '
>> -	     test ${BASH_VERSINFO[0]} -gt 4 || {
>> -	       test ${BASH_VERSINFO[0]} -eq 4 &&
>> -	       test ${BASH_VERSINFO[1]} -ge 1
>> -	     }
>> -	   '
>> -	then
>> -		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
>> -	else
>> -		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRA=
CEFD"
>> -		trace=3D
>> -	fi
>> -fi
>>  if test -n "$trace" && test -z "$verbose_log"
>>  then
>>  	verbose=3Dt
>> @@ -650,19 +627,6 @@ else
>>  	exec 4>/dev/null 3>/dev/null
>>  fi
>>=20=20
>> -# Send any "-x" output directly to stderr to avoid polluting tests
>> -# which capture stderr. We can do this unconditionally since it
>> -# has no effect if tracing isn't turned on.
>> -#
>> -# Note that this sets up the trace fd as soon as we assign the variable=
, so it
>> -# must come after the creation of descriptor 4 above. Likewise, we must=
 never
>> -# unset this, as it has the side effect of closing descriptor 4, which =
we
>> -# use to show verbose tests to the user.
>> -#
>> -# Note also that we don't need or want to export it. The tracing is loc=
al to
>> -# this shell, and we would not want to influence any shells we exec.
>> -BASH_XTRACEFD=3D4
>
> Please do not remove BASH_XTRACEFD.  And especially not like this,
> without even mentioning it in the commit message.

I can re-roll with an amended commit message that explicitly mentions
it, but that doesn't address your "please do not remove",

Do you see reason to keep it at the end-state fo this series? E.g. a
counter-argument to
https://lore.kernel.org/git/211210.86pmq4daxm.gmgdl@evledraar.gmail.com/?

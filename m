Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DADC433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793F6610FC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 23:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhDPXiz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhDPXiz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 19:38:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E0AC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:38:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u21so44419495ejo.13
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qBQ+ojVDLKnFR+MP2Sq/Bve2qhvrtBViCwLLvP0Awek=;
        b=quNObuWwnuH2vlziSY0vJKb+YAqkxo3SqtK5bBD5TaS0RqTS6wG+ibrcPIh1WHNFla
         O0j65Ae/kW7ZgfZuSJDog1dKjb4fbfAuM8i2WyZ5y+UfQlmog2AR7xhriz7zY1xJ3kDW
         JvcM7pNVzb9MAOnkApJSKDd7p9MCqguHZI91w78yTtRb0Kbsi6NueiQv4NJNcBQkVVWA
         0A0UrO+2jjKmTTdY5Vuf/9CPwQ1lCQUKE0Qh8fz9N5y+jn2ElIiwjdndAoTDi/CKGIln
         dq/pRb4nJVLh1rNA5hhgNkdiWLFtMDtkA582ymYot1AL5/qkaRm8ok07EzTV4Ij7auCu
         C42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qBQ+ojVDLKnFR+MP2Sq/Bve2qhvrtBViCwLLvP0Awek=;
        b=RWBDZqkmHrK0v53wZqNSPlWsSgaM/sVQlCf3S7k8rf3TOnkiO7txw9xCFkJZtSw/xV
         IdiFyRnXAXcsqGdVl7r+1OBvqOH9GAiPpBMSVYaCVgWkDF4RlhvhpOIxVKSjxdUMS+kD
         GLyO9rHme0X1IpbtbOcJZi7Ds8646JccUpc3Iyr38mV9Un4lLbtjJDUyMDAj7cXgkH4W
         gO6QVe3kxC87X+DXTw1325JBwR66Ek9VDSsCs74GjcleM3qqxVKV1o+gQZBDcb2x4lKc
         Nzm0xK4hrVE+O6OusVlzi9w0cSsol/rtp7H+L4Qqb99InGc3gZDyOrTXjqB80271HIvb
         JGKQ==
X-Gm-Message-State: AOAM530BuNmz1LUhFKjGRpgN07SrTdlFzbuE3uhvogWhAcs+jK5K9mjM
        o96DtnRpkkz744CZo68vJ+w=
X-Google-Smtp-Source: ABdhPJyu1Z+dC9S6A3w7/Zisa5MinzIIy/INhszsyiltQNu3ErsKHvFEmvI5hMpHL3/YBFWUafoB3g==
X-Received: by 2002:a17:906:6bc8:: with SMTP id t8mr10821510ejs.115.1618616308417;
        Fri, 16 Apr 2021 16:38:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w1sm6704007edt.89.2021.04.16.16.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:38:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/16] test-lib: modernize test_create_repo() function
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
 <20210415211013.GM2947267@szeder.dev>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210415211013.GM2947267@szeder.dev>
Date:   Sat, 17 Apr 2021 01:38:27 +0200
Message-ID: <87wnt12424.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 15 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Apr 12, 2021 at 01:09:01PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Remove redundant "mkdir -p", argument number checking', test
>> environment sanity checking, and disabling of hooks from
>> test_create_repo(). As we'll see below these were all either redundant
>> to other test other framework code, or to changes in git itself.
>>=20
>> Respectively:
>>=20
>>  1. "mkdir -p" isn't needed because "git init" itself will create
>>     leading directories if needed.
>>=20
>>  2. We don't need to check the number of arguments anymore, instead
>>     we'll feed "git init" with "$@". It will die if given too many
>>     arguments.
>
> Or it will succeed if invoked as e.g. 'test_create_repo --bare repo'.

Which is fine, no? I'll make it clearer in the commit message, but I'm
aiming to address plausible bugs due to these functions not erroring out
in one way or another, if you call it with "--bare repo" that's clearly
what you wanted, as opposed to "foo bar" and we don't create a repo
under "bar".

>>  3. We won't ever hit that "Cannot setup test environment"
>>     error.
>
> ENOSPC?  Some rogue background process on Windows still desperately
> clinging to an open file descriptor to some file in the same
> directory, preventing 'rm -rf "$TRASH_DIRECTORY"' near the beginning
> of 'test-lib.sh' and interfering with 'git init'?

I mean to say we won't hit it for the reasons we'd have that error there
in the first place.

Of course "git init" can still error, but we'll catch that in other
ways.

>>     Checking the test environment sanity when doing "git init" dates
>>     back to eea420693be (t0000: catch trivial pilot errors.,
>>     2005-12-10) and 2ccd2027b01 (trivial: check, if t/trash directory
>>     was successfully created, 2006-01-05).
>>=20
>>     We can also see it in another form a bit later in my own
>>     0d314ce834d (test-lib: use subshell instead of cd $new && .. && cd
>>     $old, 2010-08-30).
>>=20
>>     But since 2006f0adaee (t/test-lib: make sure Git has already been
>>     built, 2012-09-17) we already check if we have a built git
>>     earlier.
>>=20
>>     The one thing this was testing after that 2012 change was that
>>     we'd just built "git", but not "git-init", but since
>>     3af4c7156c4 (tests: respect GIT_TEST_INSTALLED when initializing
>>     repositories, 2018-11-12) we invoke "git", not "git-init".
>>=20
>>     So all of that's been checked already, and we don't need to
>>     re-check it here.
>
> I agree that if we already have a 'git' binary that can run 'git
> version', then we can safely assume that it will be able to run 'git
> init' as well.  It might be that 'git init' is buggy and segfaults,
> but that is not a "have you built things yet?" kind of error.

*nod*

>>  4. We don't need to move .git/hooks out of the way.
>>=20
>>     That dates back to c09a69a83e3 (Disable hooks during tests.,
>>     2005-10-16), since then hooks became disabled by default in
>>     f98f8cbac01 (Ship sample hooks with .sample suffix, 2008-06-24).
>>=20
>>     So the hooks were already disabled by default, but as can be seen
>>     from "mkdir .git/hooks" changes various tests needed to re-setup
>>     that directory. Now they no longer do.
>>=20
>>  5. Since we don't need to move the .git/hooks directory we don't need
>>     the subshell here either.
>
> We needed the subshell because we changed directory in
> 'test_create_repo' (even you referenced 0d314ce834d above), not
> because we moved the hooks directory.

Well, yes and no, a minor point but we'd need to do some juggling with
saving the $PWD in a variable etc. if it wasn't for the subshell, I
think that's why it got added in the first place.

>> In the end it turns out that all we needed was a plain "git init"
>> invocation with a custom --template directory.
>
> We don't need '--template', either; see below.

Ah, interesting.

>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index c81726acb9e..1258329fdd8 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1252,18 +1252,9 @@ test_atexit () {
>>  # Most tests can use the created repository, but some may need to creat=
e more.
>>  # Usage: test_create_repo <directory>
>>  test_create_repo () {
>> -	test "$#" =3D 1 ||
>> -	BUG "not 1 parameter to test-create-repo"
>> -	repo=3D"$1"
>> -	mkdir -p "$repo"
>> -	(
>> -		cd "$repo" || error "Cannot setup test environment"
>> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
>> -			init \
>> -			"--template=3D$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
>> -		error "cannot run git init -- have you built things yet?"
>> -		mv .git/hooks .git/hooks-disabled
>> -	) || exit
>
> This patch removes this '|| exit', which is...
>
>   - good: if 'test_create_repo' is invoked in a test case (and not in
>     a subshell) and if it were to fail for some reason, then it won't
>     abort the whole test script, but will fail only that test case.

*nod*

>   - bad: 'test_create_repo' is responsible for creating the repository
>     in the trash directory as well; if that were to fail for any
>     reason, then the test script will not be aborted early.
>
> I think the 'exit' on error should be removed from 'test_create_repo',
> but the callsite in 'test-lib.sh' should become 'test_create_repo ||
> exit 1'.
>
> In any case, removing this '|| exit' is not mentioned in the commit
> message.

I'll fix that code. FWIW I the "|| exit 1" is effectively not removed in
almost all cases where "git init" would error, because in test-lib.sh we
cd to the just-init-ed directory, and if we can't we'll fail.

But yes, it won't catch e.g. git-init dying midway through, us running
out of space while populating that directory etc.

>> +	"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
>
> PATH is already set up to start with GIT_TEST_INSTALLED and/or
> GIT_EXEC_PATH before 'test_create_repo' is called to init the repo in
> the trash directory, so we could simply run 'git' and rely on PATH
> lookup choosing the right executable.

>> +		init \
>> +		"--template=3D$GIT_BUILD_DIR/templates/blt/" "$@" >&3 2>&4
>
> Likewise, GIT_TEMPLATE_DIR is already set up to the same value as in
> this '--template=3D...' option, so we could omit this option as well.
>
> And after that all that would remain in this function is:
>
>   git init "$1" >&3 2>&4
>
> And those redirections are only needed when this function is called to
> initialize the repo in the trash directory, but not when it creates a
> repo in a test case.  This makes me question the value of having this
> 'test_create_repo' helper function at all; there are already over 800
> cases where we run plain 'git init' outside of 't0001-init.sh' instead
> of 'test_create_repo', though removing it would be definitely cause
> some churn with over 300 callsites.

I'd missed how GIT_TEMPLATE_DIR was being set, that allows us to make
this much simpler indeed!

>>  }
>>=20=20
>>  # This function helps on symlink challenged file systems when it is not
>> --=20
>> 2.31.1.634.gb41287a30b0
>>=20


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E5C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6998B60EE9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhJYLNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhJYLNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:13:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B042CC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:11:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j205so9640074wmj.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QR1Jpt6/yp6lLVC0wYIALorTydjcDrTPhhr3RF0oARA=;
        b=kh8aO/dsSMTRUVmfNLE/WiwAKWt0mpRjgd2K1RsuIuubDCcpJsi1sr/hUFYLjaCz3h
         kSYAE0yehBX7NcdKk2zLRwhsaQjM+8YNvJl8hy/IJRDvhGuR7UdwiyINspxIU+14KYtL
         gEdpE/5HvJQsZiPYVMmLIOIPE72Ae5oOh/SLryWWJxzXoO0Q9jtk6AbAgLEiinsa8g0Z
         ArOQ7Su3x0q3DN0g+2fHlUfqtAq7lX/7wFzQF8PGhtO2ouKGtUCxpokBBhlDz1JwWDGJ
         lxpguPbJVUvwrDcHR0BwqiRT6QYwztVJb6WBTt6NY2v9wsDdqfnVsilvKUy4abX9ng3E
         IsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QR1Jpt6/yp6lLVC0wYIALorTydjcDrTPhhr3RF0oARA=;
        b=0nnDfu3p7GcCb1IxF7hVvw/2XEx6zxsu0Ld7yLaYSV664KPoOtUtN7K5lTCFfgWPU5
         21f3aZEjA9rkpPLFx5N4JAXklx0FYH/yzL5suUea/SMGfQVvFvGiwquUlCP6k51Dodrf
         m8TmiTTNfkbVlZTAgXMH4ftxvjHg3GYKIeD+rmOqPCdiruIgrxXoFAbCurSTCF69Kvnn
         5xj04ioQLdmLwQjNS8tEdrSBFbo122TRd7Wjq4zpT52YYSjSWQIl/LxZDnjfe2gHs5P2
         u+W02Br9IFPDxLKwwwO6NdXxs5427gT32hCpEosX9l/LC2umWxMX5L8RnoB6ZTLPwvsM
         2gyA==
X-Gm-Message-State: AOAM530lgGGDG9DnaKbFXVFuAZQa631InxEhiy6Y5um2izFikJpR2cqF
        cLKtEgejQd9FRl1lUZgWR3s=
X-Google-Smtp-Source: ABdhPJzNpy6HhUV1TAxanK0FVzY41jdxHQDy2mp+nvypkf4lkNQznUBPc4w3LWWoxZzXEGv4NHhLWw==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr48234477wmq.97.1635160277078;
        Mon, 25 Oct 2021 04:11:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c145sm7043420wme.31.2021.10.25.04.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:11:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mexsp-001Uwc-SX;
        Mon, 25 Oct 2021 13:11:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 10/10] progress.c: add & assert a "global_progress"
 variable
Date:   Mon, 25 Oct 2021 13:06:03 +0200
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <patch-v3-10.10-01d5bbfce76-20211013T222329Z-avarab@gmail.com>
 <20211025050202.GC2101@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211025050202.GC2101@szeder.dev>
Message-ID: <211025.867de1icks.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 25 2021, SZEDER G=C3=A1bor wrote:

> On Thu, Oct 14, 2021 at 12:28:26AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> The progress.c code makes a hard assumption that only one progress bar
>> be active at a time (see [1] for a bug where this wasn't the
>> case). Add a BUG() that'll trigger if we ever regress on that promise
>> and have two progress bars active at the same time.
>
> I still very much dislike the idea of a BUG() in the progress code
> that can trigger outside of the test suite, because the progress line
> is only a UI gimmick and not a crucial part of any Git operation, and
> even though a progress line might be buggy, the underlying Git
> operation is not affected by it and would still finish successfully,
> as was the case with the dozen of so progress line bugs in the past.
>
>> There was an alternative test-only approach to doing the same
>> thing[2], but by doing this outside of a GIT_TEST_* mode we'll know
>> we've put a hard stop to this particular API misuse.
>>=20
>> It will also establish scaffolding to address current fundamental
>> limitations in the progress output: The current output must be
>> "driven" by calls to the likes of display_progress().
>
> Please elaborate why that is a "fundamental limitation"; I don't see
> any drawback of the current approach.
>
>> Once we have a
>> global current progress object we'll be able to update that object via
>> SIGALRM.
>
> What are the supposed benefits of doing that?  I do see its drawbacks,
> considering that we have progress lines that are updated from multiple
> threads.

I've updated the commit messages in a re-roll I have incoming to
hopefully clear this up.

>> See [3] for early code to do that.
>>=20
>> It's conceivable that this change will hit the BUG() condition in some
>> scenario that we don't currently have tests for, this would be very
>> bad. If that happened we'd die just because we couldn't emit some
>> pretty output.
>>=20
>> See [4] for a discussion of why our test coverage is lacking; our
>> progress display is hidden behind isatty(2) checks in many cases, so
>> the test suite doesn't cover it unless individual tests are run in
>> "--verbose" mode, we might also have multi-threaded use of the API, so
>> two progress bars stopping and starting would only be visible due to a
>> race condition.
>>=20
>> Despite that, I think that this change won't introduce such
>> regressions, because:
>>=20
>>  1. I've read all the code using the progress API (and have modified a
>>     large part of it in some WIP code I have). Almost all of it is really
>>     simple, the parts that aren't[5] are complex in the display_progress=
() part,
>>     not in starting or stopping the progress bar.
>>=20
>>  2. The entire test suite passes when instrumented with an ad-hoc
>>     Linux-specific mode (it uses gettid()) to die if progress bars are
>>     ever started or stopped on anything but the main thread[6].
>>=20
>>     Extending that to die if display_progress() is called in a thread
>>     reveals that we have exactly two users of the progress bar under
>>     threaded conditions, "git index-pack" and "git pack-objects". Both
>>     uses are straightforward, and they don't start/stop the progress
>>     bar when threads are active.
>>=20
>>  3. I've likewise done an ad-hoc test to force progress bars to be
>>     displayed with:
>>=20
>>         perl -pi -e 's[isatty\(2\)][1]g' $(git grep -l -F 'isatty(2)')
>>=20
>>     I.e. to replace all checks (not just for progress) of checking
>>     whether STDERR is connected to a TTY, and then monkeypatching
>>     is_foreground_fd() in progress.c to always "return 1". Running the
>>     tests with those applied, interactively and under -V reveals via:
>>=20
>>         $ grep -e set_progress_signal -e clear_progress_signal test-resu=
lts/*out
>>=20
>>     That nothing our tests cover hits the BUG conditions added here,
>>     except the expected "BUG: start two concurrent progress bars" test
>>     being added here.
>>=20
>>     That isn't entirely true since we won't be getting 100% coverage
>>     due to cascading failures from tests that expected no progress
>>     output on stderr. To make sure I covered 100% I also tried making
>>     the display() function in progress.c a NOOP on top of that (it's
>>     the calls to start_progress_delay() and stop_progress()) that
>>     matter.
>>=20
>>     That doesn't hit the BUG() either. Some tests fail in that mode
>>     due to a combination of the overzealous isatty(2) munging noted
>>     above, and the tests that are testing that the progress output
>>     itself is present (but for testing I'd made display() a NOOP).
>>=20
>> Between those three points I think it's safe to go ahead with this
>> change.
>
> The above analysis only considers _our_ _current_ codebase.
>
> However, even though this might be safe now, it doesn't mean that it
> will remain safe in the future, as we might add new progress lines
> that lack test coverage (though hopefully won't), and would hit that
> BUG() at a user.
>
> Furthermore, even though this might be safe in our codebase, it
> doesn't mean that it is safe in some 20+k forks of Git that exist on
> GitHub alone (I for one have a git command or two with in my fork
> which output progress lines but, sadly, have zero test coverage).
>
> But more importantly, even though it might be safe to do so, that
> doesn't mean that it's a good idea to do so.  The commit message does
> little to justify why it is conceptually a good idea to add this BUG()
> to the progress code in a way that it can trigger outside of the test
> suite.

I think partially I've addressed this above (i.e. in the incoming
re-roll's update commit message), but I might not for the question of
whether this is worth it overall. I'll update the commit message to
address this specific case, which was missing from it.

>> 1. 6f9d5f2fda1 (commit-graph: fix progress of reachable commits, 2020-07=
-09)
>> 2. https://lore.kernel.org/git/20210620200303.2328957-3-szeder.dev@gmail=
.com
>> 3. https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-=
avarab@gmail.com/
>> 4. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-=
avarab@gmail.com/
>> 5. b50c37aa44d (Merge branch 'ab/progress-users-adjust-counters' into
>>    next, 2021-09-10)
>> 6. https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  progress.c                  | 18 ++++++++++++++----
>>  t/t0500-progress-display.sh | 11 +++++++++++
>>  2 files changed, 25 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/progress.c b/progress.c
>> index b9369e9a264..a31500f8b2b 100644
>> --- a/progress.c
>> +++ b/progress.c
>> @@ -46,6 +46,7 @@ struct progress {
>>  };
>>=20=20
>>  static volatile sig_atomic_t progress_update;
>> +static struct progress *global_progress;
>>=20=20
>>  /*
>>   * These are only intended for testing the progress output, i.e. exclus=
ively
>> @@ -219,11 +220,16 @@ void progress_test_force_update(void)
>>  	progress_interval(SIGALRM);
>>  }
>>=20=20
>> -static void set_progress_signal(void)
>> +static void set_progress_signal(struct progress *progress)
>>  {
>>  	struct sigaction sa;
>>  	struct itimerval v;
>>=20=20
>> +	if (global_progress)
>> +		BUG("'%s' progress still active when trying to start '%s'",
>> +		    global_progress->title, progress->title);
>> +	global_progress =3D progress;
>
> This function is called set_progress_signal(), so checking and setting
> 'global_progress' feels out of place here; it would be better to do
> that in start_progress_delay().
>
>> +
>>  	if (progress_testing)
>>  		return;
>>=20=20
>> @@ -241,10 +247,14 @@ static void set_progress_signal(void)
>>  	setitimer(ITIMER_REAL, &v, NULL);
>>  }
>>=20=20
>> -static void clear_progress_signal(void)
>> +static void clear_progress_signal(struct progress *progress)
>>  {
>>  	struct itimerval v =3D {{0,},};
>>=20=20
>> +	if (!global_progress)
>> +		BUG("should have active global_progress when cleaning up");
>> +	global_progress =3D NULL;
>
> Likewise.

*Nod* cleaned up this whole part, which became much simpler overall as a
result, thank you.

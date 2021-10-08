Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF90C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAF160551
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhJHHX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJHHX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 03:23:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEDC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 00:21:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so32749138edv.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=z3A32bN7P6EShBhAGe3BF+iY/CGm3mJ126XfQiFg99I=;
        b=IzD1WpEBI9V2LuqU4lFm1W7uxEuAiNwfsKV4hisl5AFMYwirX74VCtDJcP535q81HA
         yYURqtHZB0M2VOLKmhU6oCcFs7BOejsYUKkozUO0kQq9NZvMyc38cCvOqDn/0xZ5At2x
         K7HM7UgDYHp6lsy4cXSdtDzdEcQ2UoGkbTp6qtYUMAHQs8TNSG5WFZjOLk3PJ1shlm8H
         ajuB/aJARjhU+dI9knjotexbILmYidxf5vl+2zjf3zLiPC1YSVvg1Y26wPpVp+wUa3y/
         iN4b5WpOxZh1qCkW59ULoqKeZn4cUwGPBVf/lxvT+Epn7wOPCt6IAIGBvLL0YRiYLtzg
         JSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=z3A32bN7P6EShBhAGe3BF+iY/CGm3mJ126XfQiFg99I=;
        b=zrrHdbNkNrkZ6OFMs1CW8bVBjWVfR6CXu0V+2YBG47YGGjVDKKgUeyU+Wu/pwFmLS0
         Dy+8/rLEVNRjcw/nl2L+Il6OBB1ATOAGXIez8XDJOKGjCvRzWb7RwkGyAv70/EgXiXSB
         +gxyZ/9KZaOzyIdjS057MAZgORIwLrAOjizAYH/WTDGethay66zo2M5pnae6syGWcT3x
         NpGicbEwEVG5s6g6BKrhzKW0qEptdHVh2o3bn4Tp1W/sWadEwrTZsKcwZOI97CYTYiZY
         XytgxAthgztTd4N8mdo1kUYe2X3TnSJFL/xG/QOtsl/oQdOWwbHWda7KT0RsDVxp5oxW
         Mozw==
X-Gm-Message-State: AOAM530th0B4jsikHV9tesWNA1ekmbE8ycZFUzNp4xWLehwgBFcn7o66
        5ly7xSRceggHwviYau4cp/s=
X-Google-Smtp-Source: ABdhPJxQ+OKkBgRVijVQg4DXY4fyA8YI91eCKTF41uoDc5Iqzl2rjJtWwBK9YjD+XJ8SW4PlwwQ2tA==
X-Received: by 2002:a17:906:9b46:: with SMTP id ep6mr2152552ejc.226.1633677691952;
        Fri, 08 Oct 2021 00:21:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o3sm596615eju.123.2021.10.08.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 00:21:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 8/8] progress.c: add & assert a "global_progress"
 variable
Date:   Fri, 08 Oct 2021 09:15:19 +0200
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-8.8-1bd285eba0d-20210920T225701Z-avarab@gmail.com>
 <YV/Gndf9e4MbFgYM@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV/Gndf9e4MbFgYM@google.com>
Message-ID: <87y274f0ck.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Emily Shaffer wrote:

> On Tue, Sep 21, 2021 at 01:09:29AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> The progress.c code makes a hard assumption that only one progress bar
>> be active at a time (see [1] for a bug where this wasn't the
>> case). Add a BUG() that'll trigger if we ever regress on that promise
>> and have two progress bars active at the same time.
>>=20
>> There was an alternative test-only approach to doing the same
>> thing[2], but by doing this outside of a GIT_TEST_* mode we'll know
>> we've put a hard stop to this particular API misuse.
>>=20
>> It will also establish scaffolding to address current fundamental
>> limitations in the progress output: The current output must be
>> "driven" by calls to the likes of display_progress(). Once we have a
>> global current progress object we'll be able to update that object via
>> SIGALRM. See [3] for early code to do that.
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
>>         perl -pi -e 's[isatty\((?:STDERR_FILENO|2)\)][1]g' $(git grep -l=
 'isatty\((STDERR_FILENO|2)\)')
>
> I think your ad-hoc test might be a little more compelling if it was
> easier to understand, which is to say, maybe if your Perl oneliner was
> on more than one line, or had comments, or was in a different language.
> Although you explain it right after, we kind of have to take your word
> for it.

I'll see if I can use sed or something, which is easy enough in this
case. I just write Perl out of habit for this sort of thing
(e.g. balanced braces & Perl-regexes make it much nicer).

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
> One worry I had was that we might be painting ourselves into a corner
> here if we did want to support the ability to do multiple progress bars
> simultaneously (for example if we want to pull from multiple CDNs at the
> same time when we're using promisor packfiles, and we expect those packs
> to be large enough that we'd need to show a progress bar for each one).
> However, I think the pattern - hang onto a pointer to the progress
> objects, and complain if we get a signal and there are any still valid -
> still holds well enough, so I'm ok with this change.

Yes, and that's a thing I'd really like the progress code to be able to
do too, and I've got some follow-up patches, but (somewhat
paradoxically) in order to display multiple progress bars you need to
first have a step like this to ensure that there is only ever one
progress bar.

The user only has one terminal, so we'll need to serialize our N
progress bars to one "emitter", we'll need to teach the progress
accounting to either have N parallel progress lines, or to simply make N
number of "slave" "struct progress *" hang off it. I'm leaning towards
the latter.

> There are a couple patches in the middle which I didn't reply to, but I
> did read them, and they were so tiny and mechanical that I did not have
> useful comments to add.
>
> Thanks, it's nice to see progress here (ha ha ha).

:)

> Preferably with the BUG() message nit below,
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
>
>>=20
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
>>  progress.c                  | 17 +++++++++++++----
>>  t/t0500-progress-display.sh | 11 +++++++++++
>>  2 files changed, 24 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/progress.c b/progress.c
>> index 1ab7d19deb8..14a023f4b43 100644
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
>> @@ -221,11 +222,15 @@ void progress_test_force_update(void)
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
>> +		BUG("should have no global_progress in set_progress_signal()");
>> +	global_progress =3D progress;
>
> Can we make the BUG() message a little clearer? Even in the context of
> the code, it's not clear that what this BUG() really means is "hey, you
> forgot to call stop_progress on something" or "hey, you can't have two
> progress bars at the same time". Even if you were to change the name of
> 'global_progress' to 'existing_progress_bar' or something, I think that
> would make the message more understandable.

Willdo, thanks.

>> +
>>  	if (progress_testing)
>>  		return;
>>=20=20
>> @@ -243,10 +248,14 @@ static void set_progress_signal(void)
>>  	setitimer(ITIMER_REAL, &v, NULL);
>>  }
>>=20=20
>> -static void clear_progress_signal(void)
>> +static void clear_progress_signal(struct progress *progress)
>>  {
>>  	struct itimerval v =3D {{0,},};
>>=20=20
>> +	if (!global_progress)
>> +		BUG("should have a global_progress in clear_progress_signal()");
>> +	global_progress =3D NULL;
>> +
>>  	if (progress_testing)
>>  		return;
>>=20=20
>> @@ -270,7 +279,7 @@ static struct progress *start_progress_delay(const c=
har *title, uint64_t total,
>>  	strbuf_init(&progress->counters_sb, 0);
>>  	progress->title_len =3D utf8_strwidth(title);
>>  	progress->split =3D 0;
>> -	set_progress_signal();
>> +	set_progress_signal(progress);
>>  	trace2_region_enter("progress", title, the_repository);
>>  	return progress;
>>  }
>> @@ -374,7 +383,7 @@ void stop_progress_msg(struct progress **p_progress,=
 const char *msg)
>>  		display(progress, progress->last_value, buf);
>>  		free(buf);
>>  	}
>> -	clear_progress_signal();
>> +	clear_progress_signal(progress);
>>  	strbuf_release(&progress->counters_sb);
>>  	if (progress->throughput)
>>  		strbuf_release(&progress->throughput->display);
>> diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
>> index ffa819ca1db..124d33c96b3 100755
>> --- a/t/t0500-progress-display.sh
>> +++ b/t/t0500-progress-display.sh
>> @@ -296,6 +296,17 @@ test_expect_success 'cover up after throughput shor=
tens a lot' '
>>  	test_cmp expect out
>>  '
>>=20=20
>> +test_expect_success 'BUG: start two concurrent progress bars' '
>> +	cat >in <<-\EOF &&
>> +	start 0 one
>> +	start 0 two
>> +	EOF
>> +
>> +	test_must_fail test-tool progress \
>> +		<in 2>stderr &&
>> +	grep -E "^BUG: .*: should have no global_progress in set_progress_sign=
al\(\)$" stderr
>> +'
>> +
>>  test_expect_success 'progress generates traces' '
>>  	cat >in <<-\EOF &&
>>  	start 40
>> --=20
>> 2.33.0.1098.gf02a64c1a2d
>>=20


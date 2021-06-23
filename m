Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B09C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B81611AC
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFWRuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWRus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18372C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so2857281wrt.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSaKQHPADdOVWrUp2fYPpkIbvrD8cxf0TckAe4fAubI=;
        b=vVn7TYwVJVC+HUZKbMaBOD8gH9k5nVcCOjCBhIGzXcm3vRbK3G5ajpIs88KhiJVxg0
         HmvVfjp8dY9wDcz02wORv+0w0Cnmz3rNaWqp/abSvgdqNpgkvn9+tmRkG/OkbaY/IbOr
         3a2GbilcZ3ZdagLfJ0zkqzp3okB1Zdm1MXD1PGeV6fMKRyLR++4ZcPY+gW1rVGBKnF5e
         6y1h97RVeZUBWHYKIQ74/l7bCZVzqHnHwpfezAqZYfMsQPSP+2IJbzFZ/wjgMImK4g43
         i5pvqeD/Qi7xH6MHWZz0AErZZ8DbKf/zuStpm4+8bdExQqU8fn71Biej6glqS8ZPeohv
         jtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSaKQHPADdOVWrUp2fYPpkIbvrD8cxf0TckAe4fAubI=;
        b=M+KAs8R+c9SZOtIXnRzArbsMkhu8z9zNGAeuvXizzDd2ZPALlq8UrIKaqdhosloSt1
         azX4Lut7UCxWAj6v7GP4kgV7HrCtFg9VFVkIl/M0Y/Uzs7pFmcLyrwLgszL9Jjv+uqi0
         MjFOqqpIz2PG99jZpC/PS8UlM4NvJLW0/x48ZRIsyA5y7cSxxWbVtGLdO1lI9YIT1qHQ
         TnWt1OPpeaaqDsQrntIH/741xRFWZe6cKv37k0i7R8BEqazqpRxWrrKZxwPkuwe7AyES
         PWok0lw0F67qtFcP6NRumN4p/F1Obix0pVsrXDpXuwYpanKkRB3EMISHIrc5gP+WwRuL
         c/1w==
X-Gm-Message-State: AOAM530zzz3Ia5Cz6ivvfi3E7ny4JjF9w0ItztYSJnu8b4LZmxDe/9Hs
        zFXgpW+ysYzE1hDaE1NDd7eurSOoe3M=
X-Google-Smtp-Source: ABdhPJxmtaMqoJipC9ICTJ7ANTYB920qMP4WfLOTwIHEhJCUTfZIpf33URSscThgvMv5rX8d/OIW6g==
X-Received: by 2002:adf:e38c:: with SMTP id e12mr1499521wrm.404.1624470509228;
        Wed, 23 Jun 2021 10:48:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/25] progress.c: various fixes + SZEDER's RFC code
Date:   Wed, 23 Jun 2021 19:48:00 +0200
Message-Id: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <YNKWsTsQgB2Ijxu7@nand.local>
References: <YNKWsTsQgB2Ijxu7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Jun 21, 2021 at 02:59:53AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Sun, Jun 20 2021, SZEDER Gábor wrote:
>>
>> > Splitting off from:
>> >
>> >   https://public-inbox.org/git/cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com/T/#me5d3176914d4268fd9f2a96fc63f4e41beb26bd6
>> >
>> > On Tue, Jun 08, 2021 at 06:14:42PM +0200, René Scharfe wrote:
>> >> I wonder (only in a semi-curious way, though) if we can detect
>> >> off-by-one errors by adding an assertion to display_progress() that
>> >> requires the first update to have the value 0, and in stop_progress()
>> >> one that requires the previous display_progress() call to have a value
>> >> equal to the total number of work items.  Not sure it'd be worth the
>> >> hassle..
>> >
>> > I fixed and reported a number of bogus progress lines in the past, the
>> > last one during v2.31.0-rc phase, so I've looked into whether progress
>> > counters could be automatically validated in our tests, and came up
>> > with these patches a few months ago.  It turned out that progress
>> > counters can be checked easily and transparently in case of progress
>> > lines that are shown in the tests, i.e. that are shown even when
>> > stderr is not a terminal or are forced with '--progress'.  (In other
>> > cases it's still fairly easy but not quite transparent, as I think we
>> > need changes to the progress API; more on that later in a separate
>> > series.)
>>
>> I've also been working on some progress.[ch] patches that are mostly
>> finished, and I'm some 20 patches in at the moment. I wasn't sure about
>> whether to send an alternate 20-patch "let's do this (mostly) instead?"
>> series, hence this message.
>>
>> Much of what you're doing here becomes easier after that series,
>> e.g. your global process struct in 2/7 is something I ended up
>> implementing as part of a general feature to allow progress to be driven
>> by either display_progress() *or* the signal handler itself.
>
> It's difficult to know who should rebase onto who without seeing one
> half of the patches.

I was sort of hoping he'd take me word for it, but here it is. Don't
say I didn't warn you :)

> I couldn't find a link to them anywhere (even if
> they are only available in your fork in a pre-polished state) despite
> looking, but my apologies if they are available and I'm just missing
> them.

FWIW it's avar-szeder/progress-bar-assertions in
https://github.com/avar/git.git, that repo contains various
functioning and not-so-functioning code.

https://github.com/avar/git/tree/meta/ is my version of the crappy
scripts we probably all have some version of for building my own git,
things that are uncommented in series.conf is what I build my own git
from.

> In general, I think that these patches are clear and are helpful in
> pinning down issues with the progress API (which I have made a hadnful
> of times in the past), so I would be happy to see them picked up.

Here's all 25 patches (well, around 20 before) that I had queued up
locally and fixed up a bit.

The 01/25 is something I submitted already as
https://lore.kernel.org/git/patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com;
hoping to get this in incrementally.

The 12/25 is my own version of that "global progress struct, 11/25 is
the first of many bugs SZEDER missed in his :)

18/25 is the first step of the UI I was going for, the signal handler
can now drive the progress bar, so e.g. during "git gc" we show (at
least for me, on git.git), a "stalled" message just before we start
the actual count of "Enumerating Objects".

After that was in I was planning on adding config-driven support to
show a "spinner" when we stalled in that way, config-driven because
you could just scrape
e.g. https://github.com/sindresorhus/cli-spinners/blob/main/spinners.json
into your own config. See
https://jsfiddle.net/sindresorhus/2eLtsbey/embedded/result/ :)

19-23/25 is my grabbing of SZEDER's patches that I'm comfortable
labeling as "PATCH", I think they work, but no BUG() assertions yet. I
left out the GIT_TEST_CHECK_PROGRESS parts, since my earlier works set
things up to do any BUG() we trust by default.

22/25 is what I think we should do instead of SZEDER's 6/7
(http://lore.kernel.org/git/20210620200303.2328957-7-szeder.dev@gmail.com)
I don't think this "our total doesn't match at the end" is something
we should always BUG() on, for reasons explained there.

I am sympathetic to doing it by default though, hence the
stop_progress_early() API, that's there to allow select callers to
bypass his BUG(...) assertion.

24/25 and 25/25 are "RFC" and a rebased+modified version of SZEDER's
BUG(...) assertions.

His series passes the test suite, but actually severely break things
things. It'll make e.g. "git commit-graph write" BUG(...) out. The
reason the tests don't catch it is because we have a blind spot in the
tests.

Namely, that most things that use the progress bar API use isatty() to
check if they should start_progress(). If you run the tests as
e.g. (better ways to do this, especially in parallel, most welcome):

    for t in t[0-9]*.sh; do if ! ./$t -vixd; then echo $t bad; break; fi; done

You can discover various things that his series BUG()'s on, I fixed a
couple of those myself, it's an early part of this series.

But we'll still have various untested for BUG()'s even then, this is
because you *also* have to have the test actually emit a "naked"
progress bar on stderr, if the test itself e.g. pipes fd 2 to a file
it won't work.

I created a shitty-and-mostly-broken throwaway change to
search-replace all the guards of "start_progress(...)" to run
unconditionally, and convert all the "delayed" to the non-delayed
version. That'll find even more BUG()'s where SZEDER's series still
needs to be fixed (and also some unrelated segfaults, I gave up on it
soon after).

Even if we fix that I wouldn't trust it, because a lot of the progress
bars we have depend on the size and shape of the data we're
processing, e.g. the bug I fixed in 11/25. If people find this BUG()
approach worth pursuing I think it would be better to make it an
opt-in flag we convert one caller at a time to.

For some it's really clear that we could assert it, for others such as
the commit-graph it's much more subtle, we're in some callback after
setting a "total", that callback does a "break", "continue" etc. in
various places, all depending on repository data.

It's not easy to reason about that and be certain that we can hold to
the estimate. If we get it wrong someone's repo in the wild won't
fully GC because of the overly eager BUG().

If SZEDER wants to pursue it I think it'll be easier on top of this
series, but personally I really don't see the point of spending effort
on it.

We should really be going in the other direction, of having more fuzzy
ETAs, not less.

E.g. we often have enough data at the start of "Enumerating Objects"
to give a good-enough target value, that it's 5-10% off isn't really
the point, but that the user looking at it sees something better than
a dumb count-up, and can instead see that they'll probably be looking
at it for about a minute. Now our API is to give no ETA/target if
we're not 100% sure, it's not good UX.

So trying to get the current exact count/exact percentage right seems
like a distraction to me in the longer term. If anything we should
just be rounding those numbers, showing fuzzy ETAs instead of
percentages if we can etc.

SZEDER Gábor (4):
  commit-graph: fix bogus counter in "Scanning merged commits" progress
    line
  entry: show finer-grained counter in "Filtering content" progress line
  progress: assert last update in stop_progress()
  progress: assert counting upwards in display()

Ævar Arnfjörð Bjarmason (21):
  progress.c tests: fix breakage with COLUMNS != 80
  progress.c tests: make start/stop verbs on stdin
  progress.c tests: test some invalid usage
  progress.c tests: add a "signal" verb
  progress.c: move signal handler functions lower
  progress.c: call progress_interval() from progress_test_force_update()
  progress.c: stop eagerly fflush(stderr) when not a terminal
  progress.c: add temporary variable from progress struct
  midx perf: add a perf test for multi-pack-index
  progress.c: remove the "sparse" mode nano-optimization
  pack-bitmap-write.c: add a missing stop_progress()
  progress.c: add & assert a "global_progress" variable
  progress.[ch]: move the "struct progress" to the header
  progress.[ch]: move test-only code away from "extern" variables
  progress.c: pass "is done?" (again) to display()
  progress.[ch]: convert "title" to "struct strbuf"
  progress.c: refactor display() for less confusion, and fix bug
  progress.c: emit progress on first signal, show "stalled"
  midx: don't provide a total for QSORT() progress
  progress.c: add a stop_progress_early() function
  entry: deal with unexpected "Filtering content" total

 cache.h                          |   1 -
 commit-graph.c                   |   2 +-
 csum-file.h                      |   2 -
 entry.c                          |  12 +-
 midx.c                           |  25 +-
 pack-bitmap-write.c              |   1 +
 pack.h                           |   1 -
 parallel-checkout.h              |   1 -
 progress.c                       | 391 ++++++++++++++++++-------------
 progress.h                       |  50 +++-
 reachable.h                      |   1 -
 t/helper/test-progress.c         |  54 +++--
 t/perf/p5319-multi-pack-index.sh |  21 ++
 t/t0500-progress-display.sh      | 247 ++++++++++++++-----
 14 files changed, 537 insertions(+), 272 deletions(-)
 create mode 100755 t/perf/p5319-multi-pack-index.sh

-- 
2.32.0.599.g3967b4fa4ac


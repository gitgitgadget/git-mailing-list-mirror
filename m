Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE262C43219
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13DC6126A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347949AbhIUCWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbhIUBvw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26BC0386C1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so26997198wri.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuE8xbSIXckorLltUvwHtQqHU7X2zGRC4HhvRFO7rBE=;
        b=QMgr8o8urRhRM2BuPwH3RLvizIg9caOJNxKNyqZSv6bJQzoDqMp3H9YrAVtrZ/Oqpl
         Md4fF4uaQs5q1PpHjkzBoWZ1ecUBAZQteqymg9yRXzYWnVAVNEzW6Gm1mG/ZRg5WPaDJ
         bAJgvFXTBjJjUgUARy99CzH5rBbP0qOFO3g1EShR1meRqfXTS2vOlD1e1/+6UHrFv0kr
         jNMeBla3XjLs2F2U0AP3l/vI7AtvQ6GHnOIazvSGQYwle3tv+an9CX+pIB9SpwEZibqO
         EjSM4bPcRXOeYYO/FOLiDUn6Spir2ek9rDukRsxcC6NRkhf+fNwLngeEItsNEVSIX7hQ
         hSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuE8xbSIXckorLltUvwHtQqHU7X2zGRC4HhvRFO7rBE=;
        b=gS7g2ZZrkdWXzNR/mfXFIlVuymz1sKJu3UkEFUpePTvDpgd7a3CLrpN5426tCWV1mu
         bhs9SjJfZOFCeMs2tNOKexQBaAGD7zhckfmSD4xRDkeShj5gmFZtedBVfmSnOhTKVdw6
         3Zdfluo1KB26jBnJCSoqPLf4wHqzPC1ltoHpv5foX/Yww/tGQfJ8L/ino1BXXdbm2wCg
         r1s3KoXRvqVgUwDBCb0u8OV7e7x45dPD8r8OoyYFAy5VlFDJRulywVkr2F+rcGka75ll
         kf8NzbVh5D0ikR5YQbyb5+5EbGOgJpajYCkqKf+f21sIMRlS1WpbOQMrRxBk9NegHIvR
         pdZg==
X-Gm-Message-State: AOAM531MDcENSVc+ekadHdISP2yJ3WbKtXI07WWH7gOPIxCpGvD6swih
        pkGTKigdSTHUqNVFYTxBuKzHuxE01/OfFA==
X-Google-Smtp-Source: ABdhPJw1jGREAm5yE7YVfJY93AKhcyOafggiyBzpSlMPBMtN4H/s7K7amuC7hmuwGgZqV+01ydnkEw==
X-Received: by 2002:a05:6000:18a2:: with SMTP id b2mr19386511wri.342.1632179377958;
        Mon, 20 Sep 2021 16:09:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm10409154wru.30.2021.09.20.16.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:09:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] progress: assert "global_progress" + test fixes / cleanup
Date:   Tue, 21 Sep 2021 01:09:21 +0200
Message-Id: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches improve the progress.c tests, fix a couple of
miscellaneous nits in 5/8 and 6/8, and 7/8 and 8/8/ then fix what I
believe is the last in a class of bug that 8/8 adds a new BUG() assert
for: We should not be starting two progress bars at the same time.


This series has been held off since September 1st on SZEDER's comment
that he "found some issues with it" in[1].

He's been relatively inactive on list recently, but I belive based on
a recent discussion in the thread-at-large that those comments didn't
refer to any unreported bug, but a general concern that we might be
getting things wrong and had cases where the BUG() might trigger that
we haven't thought of.

I think my [2] and the updated commit message of 8/8 cover in detail
why I think this is safe to do. SZEDER didn't reply to my [2] yet, so
perhaps there really is some specific issue I'm not aware of (i.e. the
BUG() being hit), but I don't think there is based on the information
I have now.

SZEDER also had comments rightly pointing out some issues[3] in the
earlier 25-patch series I'd submitted[2]. Those will need to be
addressed or fixed if I re-submit those, but they're not part of this
series.

1. https://lore.kernel.org/git/20210901050406.GB76263@szeder.dev/
2. https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/
3. https://lore.kernel.org/git/20210916183711.GE76263@szeder.dev/

Ævar Arnfjörð Bjarmason (8):
  progress.c tests: make start/stop verbs on stdin
  progress.c tests: test some invalid usage
  progress.c: move signal handler functions lower
  progress.c: call progress_interval() from progress_test_force_update()
  progress.c: stop eagerly fflush(stderr) when not a terminal
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: add a missing stop_progress()
  progress.c: add & assert a "global_progress" variable

 pack-bitmap-write.c         |   1 +
 progress.c                  | 116 ++++++++++++++++++++----------------
 t/helper/test-progress.c    |  43 +++++++++----
 t/t0500-progress-display.sh | 103 +++++++++++++++++++++++++-------
 4 files changed, 178 insertions(+), 85 deletions(-)

Range-diff against v1:
1:  e0a294eb479 = 1:  e0a294eb479 progress.c tests: make start/stop verbs on stdin
2:  7b1220b641e = 2:  7b1220b641e progress.c tests: test some invalid usage
3:  f1b8bf1dbde = 3:  f1b8bf1dbde progress.c: move signal handler functions lower
4:  74057b0046a = 4:  74057b0046a progress.c: call progress_interval() from progress_test_force_update()
5:  250e50667c2 = 5:  250e50667c2 progress.c: stop eagerly fflush(stderr) when not a terminal
6:  d4e9ff1de73 = 6:  d4e9ff1de73 progress.c: add temporary variable from progress struct
7:  a3f133ca7ad = 7:  a3f133ca7ad pack-bitmap-write.c: add a missing stop_progress()
8:  4fd2754caeb ! 8:  1bd285eba0d progress.c: add & assert a "global_progress" variable
    @@ Commit message
         progress.c: add & assert a "global_progress" variable
     
         The progress.c code makes a hard assumption that only one progress bar
    -    be active at a time (see [1] for a bug where this wasn't the case),
    -    but nothing has asserted that that's the case. Let's add a BUG()
    -    that'll trigger if two progress bars are active at the same time.
    -
    -    There's an alternate test-only approach to doing the same thing[2],
    -    but by doing this for all progress bars we'll have a canary to check
    -    if we have any unexpected interaction between the "sig_atomic_t
    -    progress_update" variable and this global struct.
    -
    -    I am then planning on using this scaffolding in the future to fix a
    -    limitation in the progress output, namely the current limitation of
    -    the progress.c bar code that any update must pro-actively go through
    -    the likes of display_progress().
    -
    -    If we e.g. hang forever before the first display_progress(), or in the
    -    middle of a loop that would call display_progress() the user will only
    -    see either no output, or output frozen at the last display_progress()
    -    that would have done an update (e.g. in cases where progress_update
    -    was "1" due to an earlier signal).
    -
    -    This change does not fix that, but sets up the structure for solving
    -    that and other related problems by juggling this "global_progress"
    -    struct. Later changes will make more use of the "global_progress" than
    -    only using it for these assertions.
    +    be active at a time (see [1] for a bug where this wasn't the
    +    case). Add a BUG() that'll trigger if we ever regress on that promise
    +    and have two progress bars active at the same time.
    +
    +    There was an alternative test-only approach to doing the same
    +    thing[2], but by doing this outside of a GIT_TEST_* mode we'll know
    +    we've put a hard stop to this particular API misuse.
    +
    +    It will also establish scaffolding to address current fundamental
    +    limitations in the progress output: The current output must be
    +    "driven" by calls to the likes of display_progress(). Once we have a
    +    global current progress object we'll be able to update that object via
    +    SIGALRM. See [3] for early code to do that.
    +
    +    It's conceivable that this change will hit the BUG() condition in some
    +    scenario that we don't currently have tests for, this would be very
    +    bad. If that happened we'd die just because we couldn't emit some
    +    pretty output.
    +
    +    See [4] for a discussion of why our test coverage is lacking; our
    +    progress display is hidden behind isatty(2) checks in many cases, so
    +    the test suite doesn't cover it unless individual tests are run in
    +    "--verbose" mode, we might also have multi-threaded use of the API, so
    +    two progress bars stopping and starting would only be visible due to a
    +    race condition.
    +
    +    Despite that, I think that this change won't introduce such
    +    regressions, because:
    +
    +     1. I've read all the code using the progress API (and have modified a
    +        large part of it in some WIP code I have). Almost all of it is really
    +        simple, the parts that aren't[5] are complex in the display_progress() part,
    +        not in starting or stopping the progress bar.
    +
    +     2. The entire test suite passes when instrumented with an ad-hoc
    +        Linux-specific mode (it uses gettid()) to die if progress bars are
    +        ever started or stopped on anything but the main thread[6].
    +
    +        Extending that to die if display_progress() is called in a thread
    +        reveals that we have exactly two users of the progress bar under
    +        threaded conditions, "git index-pack" and "git pack-objects". Both
    +        uses are straightforward, and they don't start/stop the progress
    +        bar when threads are active.
    +
    +     3. I've likewise done an ad-hoc test to force progress bars to be
    +        displayed with:
    +
    +            perl -pi -e 's[isatty\((?:STDERR_FILENO|2)\)][1]g' $(git grep -l 'isatty\((STDERR_FILENO|2)\)')
    +
    +        I.e. to replace all checks (not just for progress) of checking
    +        whether STDERR is connected to a TTY, and then monkeypatching
    +        is_foreground_fd() in progress.c to always "return 1". Running the
    +        tests with those applied, interactively and under -V reveals via:
    +
    +            $ grep -e set_progress_signal -e clear_progress_signal test-results/*out
    +
    +        That nothing our tests cover hits the BUG conditions added here,
    +        except the expected "BUG: start two concurrent progress bars" test
    +        being added here.
    +
    +        That isn't entirely true since we won't be getting 100% coverage
    +        due to cascading failures from tests that expected no progress
    +        output on stderr. To make sure I covered 100% I also tried making
    +        the display() function in progress.c a NOOP on top of that (it's
    +        the calls to start_progress_delay() and stop_progress()) that
    +        matter.
    +
    +        That doesn't hit the BUG() either. Some tests fail in that mode
    +        due to a combination of the overzealous isatty(2) munging noted
    +        above, and the tests that are testing that the progress output
    +        itself is present (but for testing I'd made display() a NOOP).
    +
    +    Between those three points I think it's safe to go ahead with this
    +    change.
     
         1. 6f9d5f2fda1 (commit-graph: fix progress of reachable commits, 2020-07-09)
         2. https://lore.kernel.org/git/20210620200303.2328957-3-szeder.dev@gmail.com
    +    3. https://lore.kernel.org/git/patch-18.25-e21fc66623f-20210623T155626Z-avarab@gmail.com/
    +    4. https://lore.kernel.org/git/cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com/
    +    5. b50c37aa44d (Merge branch 'ab/progress-users-adjust-counters' into
    +       next, 2021-09-10)
    +    6. https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.33.0.1098.gf02a64c1a2d


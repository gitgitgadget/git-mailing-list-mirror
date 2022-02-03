Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF67C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiBCVk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiBCVk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:40:26 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034FC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:40:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e8so7677352wrc.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tbi38KU6M+X1DgCs1K3LEog/foYqNMtILYZtfR/ECPA=;
        b=iuDAGUUhUHzzk2kxkarnc2axmkhjUIlqBRhtq4h8Otg8MqX4Q7d6gvVbFTGCm8K1Lx
         CUY9pEK58fBIRQPtTRbo15zvgZwE8rCvJAJiVp0h0fssMBC3Tj4k9lGGJfAfjMJSdDzY
         LPfbUDzxTh1X62KuO8UZ/L7sw17qcjh+nyEVFcedVWn8uhtpjpCE0vypakiNEDkbIJ3G
         yRhV564p8AQ0TbO2c4dZp82idsWeM710OSVAmuni4RHgyE7coKubMP1I6uCnoI/pXPfc
         69i5/3RUPGySPbMfkqfDfLdzdN/u84xzAFxKG3LIJe0/1H0amXBjx94A5316+qzftyTJ
         aWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tbi38KU6M+X1DgCs1K3LEog/foYqNMtILYZtfR/ECPA=;
        b=p8NfJnlxw8NCFywVdihWO8054bTk/IQIkor4ANIh5LwLU051tIQ4gIru7rL/rDXj3R
         LhS/+4x2CJL9X3k0/Si6rG5tXMu/bGCm2XBw9/v66TBaSvF+cj+4Qmvq1gEzNFF5BJj7
         Av+Ceijm+OOrOsE2PNIFsYBylboibKj8jMnyAeiS9d0JPjdt+8tSxU64y2bkHW9NW+DP
         6Kh2qgFdzQ15KKIsmUu8L+S222qRD6FahKCdA+VXjuppAgmeJjaIgv/xL59SLq1Dki6W
         UEelkik+V7Tqn8qttX/VhD7AtPs4wRaYmI5PLMWe15AeXk0DHr2aDPKRC8MebE5lkt8z
         Mn3A==
X-Gm-Message-State: AOAM530zM9IboOcUcEYzt8nak7uZ5nCup5DzxP97koNCCXdyl0aeo59H
        JqO8o24jhkkTiuTMpqEBhudJnGPh8q4=
X-Google-Smtp-Source: ABdhPJz+LV0mk10ZKgRh5ydB1ac8kHVk4Pp8Im6PSeD+LDIDaBHV7N+hJvzJ5FPdNLCzprAd4YKUoQ==
X-Received: by 2002:adf:fb8b:: with SMTP id a11mr30652316wrr.692.1643924424225;
        Thu, 03 Feb 2022 13:40:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13sm10637wrf.3.2022.02.03.13.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:40:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 0/9] progress: test fixes / cleanup
Date:   Thu,  3 Feb 2022 22:40:10 +0100
Message-Id: <cover-v9-0.9-00000000000-20220203T213350Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.939.g42bf83caa3d
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of this series of various basic fixes to the progress API.

This addresses all the comments brought up on v8, thanks a lot to René
and Johannes Altmanninger. It just took me about to a month to get
around to re-rolling this.

There's various small fixes early in the series. I amended some commit
messages, added a mising promised test etc.

But most significantly as René pointed out stop_progress() and
stop_progress_msg() should really be unified. This series does that,
which fixes a long-standing bug with the trace2 region not being ended
if the stop_progress_msg() variant was called.

This is a reply to the v6, which is the thread this was originally
in[1]. In v7[2] I didn't add In-Reply-T, and in v8[3] I ended up
replying to the wrong thread! Sorry about that.

I then ejected the isatty() change. That was done for a final addition
of a BUG() assertion that's now gone, but which I plan to submit after
this series. I can re-visit that if and when I re-roll that.

1. https://lore.kernel.org/git/cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com
2. https://lore.kernel.org/git/cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com
3. https://lore.kernel.org/git/cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (9):
  leak tests: fix a memory leak in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop commands on stdin
  progress.c tests: test some invalid usage
  progress.h: format and be consistent with progress.c naming
  progress.c: use dereferenced "progress" variable, not "(*p_progress)"
  progress.c: refactor stop_progress{,_msg}() to use helpers
  progress API: unify stop_progress{,_msg}(), fix trace2 bug
  pack-bitmap-write.c: don't return without stop_progress()

 pack-bitmap-write.c         |   6 +-
 progress.c                  |  66 ++++++++++------------
 progress.h                  |   9 ++-
 t/helper/test-progress.c    |  50 ++++++++++++-----
 t/t0500-progress-display.sh | 109 +++++++++++++++++++++++++++++-------
 t/t5316-pack-delta-depth.sh |   6 +-
 6 files changed, 170 insertions(+), 76 deletions(-)

Range-diff against v8:
 1:  aa08dab654d =  1:  dc304df9468 leak tests: fix a memory leak in "test-progress" helper
 2:  3ecdab074b6 =  2:  6951c059aa9 progress.c test helper: add missing braces
 3:  271f6d7ec3b !  3:  4548144a0b4 progress.c tests: make start/stop commands on stdin
    @@ t/helper/test-progress.c
     +		if (skip_prefix(line.buf, "start ", (const char **) &end)) {
     +			uint64_t total = strtoull(end, &end, 10);
     +			const char *title;
    -+			const char *str;
     +
     +			/*
     +			 * We can't use "end + 1" as an argument to
    @@ t/helper/test-progress.c
     +			else
     +				die("invalid input: '%s'\n", line.buf);
     +
    -+			str = title ? title : default_title;
    -+			progress = start_progress(str, total);
    ++			progress = start_progress(title, total);
     +		} else if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
      			uint64_t item_count = strtoull(end, &end, 10);
      			if (*end != '\0')
 4:  7c1b8b287c5 !  4:  965d4ba7b54 progress.c tests: test some invalid usage
    @@ Commit message
         progress.c tests: test some invalid usage
     
         Test what happens when we "stop" without a "start", omit the "stop"
    -    after a "start", or try to start two concurrent progress bars. This
    +    after a "start", or start two concurrent progress bars. This
         extends the trace2 tests added in 98a13647408 (trace2: log progress
         time and throughput, 2020-05-12).
     
    @@ t/t0500-progress-display.sh: test_expect_success 'progress generates traces' '
     +	stop
     +	EOF
     +
    -+	GIT_TRACE2_EVENT="$(pwd)/trace-startstop.event" test-tool progress \
    ++	GIT_TRACE2_EVENT="$PWD/trace-startstop.event" test-tool progress \
     +		<in 2>stderr &&
     +	test_region progress "Working hard" trace-startstop.event
     +'
    @@ t/t0500-progress-display.sh: test_expect_success 'progress generates traces' '
     +	start 0
     +	EOF
     +
    -+	GIT_TRACE2_EVENT="$(pwd)/trace-start.event" \
    ++	GIT_TRACE2_EVENT="$PWD/trace-start.event" \
     +	LSAN_OPTIONS=detect_leaks=0 \
     +	test-tool progress \
     +		<in 2>stderr &&
    @@ t/t0500-progress-display.sh: test_expect_success 'progress generates traces' '
     +	stop
     +	EOF
     +
    -+	GIT_TRACE2_EVENT="$(pwd)/trace-stop.event" test-tool progress \
    ++	GIT_TRACE2_EVENT="$PWD/trace-stop.event" test-tool progress \
     +		<in 2>stderr &&
     +	! grep region_enter.*progress trace-stop.event &&
     +	! grep region_leave.*progress trace-stop.event
     +'
    ++
    ++test_expect_success 'progress generates traces: start with active progress bar (no stops)' '
    ++	cat >in <<-\EOF &&
    ++	start 0 One
    ++	start 0 Two
    ++	EOF
    ++
    ++	GIT_TRACE2_EVENT="$PWD/trace-2start.event" \
    ++	LSAN_OPTIONS=detect_leaks=0 \
    ++	test-tool progress \
    ++		<in 2>stderr &&
    ++	grep region_enter.*progress.*One trace-2start.event &&
    ++	grep region_enter.*progress.*Two trace-2start.event &&
    ++	! grep region_leave trace-2start.event
    ++'
     +
      test_done
 -:  ----------- >  5:  4ab4eb3a20a progress.h: format and be consistent with progress.c naming
 5:  72a31bd7191 !  6:  ab24cb78d73 progress.c: add temporary variable from progress struct
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    progress.c: add temporary variable from progress struct
    +    progress.c: use dereferenced "progress" variable, not "(*p_progress)"
     
         Since 98a13647408 (trace2: log progress time and throughput,
         2020-05-12) stop_progress() dereferences a "struct progress **"
    -    parameter in several places. Extract a dereferenced variable (like in
    -    stop_progress_msg()) to reduce clutter and make it clearer who needs
    -    to write to this parameter.
    +    parameter in several places. Extract a dereferenced variable to reduce
    +    clutter and make it clearer who needs to write to this parameter.
     
         Now instead of using "*p_progress" several times in stop_progress() we
         check it once for NULL and then use a dereferenced "progress" variable
    -    thereafter. This continues the same pattern used in the above
    -    stop_progress() function, see ac900fddb7f (progress: don't dereference
    -    before checking for NULL, 2020-08-10).
    +    thereafter. This uses the same pattern as the adjacent
    +    stop_progress_msg() function, see ac900fddb7f (progress: don't
    +    dereference before checking for NULL, 2020-08-10).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ progress.c: static void finish_if_sparse(struct progress *progress)
      void stop_progress(struct progress **p_progress)
      {
     +	struct progress *progress;
    ++
      	if (!p_progress)
      		BUG("don't provide NULL to stop_progress");
     +	progress = *p_progress;
 -:  ----------- >  7:  3406d71b499 progress.c: refactor stop_progress{,_msg}() to use helpers
 -:  ----------- >  8:  62a93bb98b0 progress API: unify stop_progress{,_msg}(), fix trace2 bug
 6:  0bd08e1b018 =  9:  0b2248a2d74 pack-bitmap-write.c: don't return without stop_progress()
 7:  060483fb5ce <  -:  ----------- *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
-- 
2.35.1.939.g42bf83caa3d


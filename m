Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF721C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 08:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiF3I44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiF3I4y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 04:56:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC842A28
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 01:56:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id cl1so2500649wrb.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LC3QJULUQG85rcIHiCy6aFjp4t+6n4ODnJjg4kdX+ZU=;
        b=kScAc3TQWtaKR0Sbtprc299rsoDCsx7zMI9gCgB4uHuUWWewgm14Y5Yws0t4gR43E7
         mWkg5Op5BDAVYQZVcrocQRsa1lqYVCFNWMDj4XQCe3qOknmFHpITdPB7Y79uUdPyBLIN
         +/m6JcMk/Wo6rCPNCR4GjNH6+l/WmktGZ753Kl5A45HU47rQ3wRlsDYpWSf+LjhUztJI
         LMa1NT+JHP6SLTxryVh8fW7x7wJmstOuW8H3sfAzARSV8PiTNMdChzk/NDxDzhGY7JNl
         9qZw4bqfhh/uEojUBBNim8Glcvf6PPA2UL6czObPyz1fatgVGq0ic4k1krlDKIDtN3g5
         3pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC3QJULUQG85rcIHiCy6aFjp4t+6n4ODnJjg4kdX+ZU=;
        b=ZcU2HLPRAdbn4vKzZbpKHYbLguAkY6KkC8Nj7VnblgK4boTN7XElOMXD+MCTg9DQ3J
         lGNLmzGN91cGz0EbDHntww3bZ7b7CJFCUBMy1QajBRLqH4kW1W7VDPOH4cub0zWjmkj/
         NqlOpmVQSti8p/Dsh4dobiwGWppZgX5fpBlUqIOItl7Vu7H9wC5Yus27roVZqZ4e+Bvg
         O3Kq/j0jEyz1EuDZQ3Sr4F89E2nn8VjXXQAtBz+vmjPvjAvVmgwOFpAS4wRTRqwvBhwh
         xpNAHA25Ac+eihSX4tj3sqXcHcVp0FGgBEgpa+KzTxrlw5rG4sJcncxmzvnaI2z4VoAW
         QeoQ==
X-Gm-Message-State: AJIora9aYo+PI4Bn2Hp8TB3jCuBYK6ZxtJg/gbGEyqFvORYjEilmkEbB
        wESoAeTaKx/f+5qiJumKU/Yw00z+8/I=
X-Google-Smtp-Source: AGRyM1vu2dWSnYVbrCwnuhMjewYX3hVKahnotcG4zoyUuRXke/nWjysppOmraIL7h1VlgCc/TUa/9A==
X-Received: by 2002:a5d:4cc7:0:b0:21b:9cfd:ee18 with SMTP id c7-20020a5d4cc7000000b0021b9cfdee18mr7733480wrt.355.1656579411019;
        Thu, 30 Jun 2022 01:56:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f190-20020a1c38c7000000b0039c5328ad92sm1850710wma.41.2022.06.30.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:56:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] trace2: don't include "fsync" events in all trace2 logs
Date:   Thu, 30 Jun 2022 10:56:47 +0200
Message-Id: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
References: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the overly verbose trace2 logging added in 9a4987677d3 (trace2:
add stats for fsync operations, 2022-03-30) (first released with
v2.36.0).

Since that change every single "git" command invocation has included
these "data" events, even though we'll only make use of these with
core.fsyncMethod=batch, and even then only have non-zero values if
we're writing object data to disk. See c0f4752ed2f (core.fsyncmethod:
batched disk flushes for loose-objects, 2022-04-04) for that feature.

As we're needing to indent the trace2_data_intmax() lines let's
introduce helper variables to ensure that our resulting lines (which
were already too) don't exceed the recommendations of the
CodingGuidelines. Doing that requires either wrapping them twice, or
introducing short throwaway variable names, let's do the latter.

The result was that e.g. "git version" would previously emit a total
of 6 trace2 events with the GIT_TRACE2_EVENT target (version, start,
cmd_ancestry, cmd_name, exit, atexit), but afterwards would emit
8. We'd emit 2 "data" events before the "exit" event.

The reason we didn't catch this was that the trace2 unit tests added
in a15860dca3f (trace2: t/helper/test-trace2, t0210.sh, t0211.sh,
t0212.sh, 2019-02-22) would omit any "data" events that weren't the
ones it cared about. Before this change to the C code 6/7 of our
"t/t0212-trace2-event.sh" tests would fail if this change was applied
to "t/t0212/parse_events.perl".

Let's make the trace2 testing more strict, and further append any new
events types we don't know about in "t/t0212/parse_events.perl". Since
we only invoke the "test-tool trace2" there's no guarantee that we'll
catch other overly verbose events in the future, but we'll at least
notice if we start emitting new events that are issues every time we
log anything with trace2's JSON target.

We exclude the "data_json" event type, we'd otherwise would fail on
both "win test" and "win+VS test" CI due to the logging added in
353d3d77f4f (trace2: collect Windows-specific process information,
2019-02-22). It looks like that logging should really be using
trace2_cmd_ancestry() instead, which was introduced later in
2f732bf15e6 (tr2: log parent process name, 2021-07-21), but let's
leave it for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I think this re-roll addresses the concerns Junio brought up in:
https://lore.kernel.org/git/xmqqh74byy19.fsf@gitster.g/; As to the
larger question of:

On Thu, Jun 23 2022, Junio C Hamano wrote:

> I am not sure if it is a good solution in the longer term, but this
> implementation may be a good-enough way to squelch the immediate
> loudness issue.

I think a better long-term solution in this case, per the initial
feedback on the patch would be to have a generic facility to trace2
log how often we call a given syscall:

	https://lore.kernel.org/git/220330.86zgl7o8l8.gmgdl@evledraar.gmail.com/

I.e. in most (all?) other cases our trace2 logging is logging git's
"business logic", but in this case the logging is functionally the
same as a more dumb interception of an arbitrary system call, and then
having some generic "syscall stats" trace2 event.

In this case such a generic logger would need to be a bit smarter than
just a dumb wrapper, i.e. we'd need:

    fsync() != EINTR /* due to fsync_loop() */
    sync_file_range()

That still wouldn't be the same as the current logging if implemented
correctly, but I think in a good way. E.g. now we'll log a failed
fsync() the same as a successful one, as we increment the counter
before seeing what the return value was.

But anyway, as noted in the original thread Neeraj didn't have time to
look into that, neither do I, and the patch is now a part of git. So
let's solve the immediate issue of verbose logging, and leave any
other improvements for the future.

Range-diff against v1:
1:  df87e515efd ! 1:  a1fc37de947 trace2: don't include "fsync" events in all trace2 logs
    @@ Commit message
         we're writing object data to disk. See c0f4752ed2f (core.fsyncmethod:
         batched disk flushes for loose-objects, 2022-04-04) for that feature.
     
    +    As we're needing to indent the trace2_data_intmax() lines let's
    +    introduce helper variables to ensure that our resulting lines (which
    +    were already too) don't exceed the recommendations of the
    +    CodingGuidelines. Doing that requires either wrapping them twice, or
    +    introducing short throwaway variable names, let's do the latter.
    +
         The result was that e.g. "git version" would previously emit a total
         of 6 trace2 events with the GIT_TRACE2_EVENT target (version, start,
         cmd_ancestry, cmd_name, exit, atexit), but afterwards would emit
    @@ t/t0212/parse_events.perl
     +    }
     +
     +    elsif ($event eq 'data_json') {
    -+	# Ignore due to compat/win32/trace2_win32_process_info.c
    ++	# NEEDSWORK: Ignore due to
    ++	# compat/win32/trace2_win32_process_info.c, which should log a
    ++	# "cmd_ancestry" event instead.
     +    }
     +
     +    else {
    @@ wrapper.c: int git_fsync(int fd, enum fsync_action action)
      
      void trace_git_fsync_stats(void)
      {
    -+	if (!count_fsync_writeout_only && !count_fsync_hardware_flush)
    -+		return;
    +-	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
    +-	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
    ++	const struct repository *r = the_repository;
    ++	const intmax_t cfwo = count_fsync_writeout_only;
    ++	const intmax_t cfhf = count_fsync_hardware_flush;
     +
    - 	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
    - 	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
    ++	if (cfwo)
    ++		trace2_data_intmax("fsync", r, "fsync/writeout-only", cfwo);
    ++	if (cfhf)
    ++		trace2_data_intmax("fsync", r, "fsync/hardware-flush", cfhf);
      }
    + 
    + static int warn_if_unremovable(const char *op, const char *file, int rc)

 t/t0212/parse_events.perl | 19 +++++++++++++------
 wrapper.c                 | 10 ++++++++--
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/t/t0212/parse_events.perl b/t/t0212/parse_events.perl
index b6408560c0c..30a9f51e9f1 100644
--- a/t/t0212/parse_events.perl
+++ b/t/t0212/parse_events.perl
@@ -216,12 +216,19 @@
 
     elsif ($event eq 'data') {
 	my $cat = $line->{'category'};
-	if ($cat eq 'test_category') {
-	    
-	    my $key = $line->{'key'};
-	    my $value = $line->{'value'};
-	    $processes->{$sid}->{'data'}->{$cat}->{$key} = $value;
-	}
+	my $key = $line->{'key'};
+	my $value = $line->{'value'};
+	$processes->{$sid}->{'data'}->{$cat}->{$key} = $value;
+    }
+
+    elsif ($event eq 'data_json') {
+	# NEEDSWORK: Ignore due to
+	# compat/win32/trace2_win32_process_info.c, which should log a
+	# "cmd_ancestry" event instead.
+    }
+
+    else {
+	push @{$processes->{$sid}->{$event}} => $line->{value};
     }
 
     # This trace2 target does not emit 'printf' events.
diff --git a/wrapper.c b/wrapper.c
index 1c3c970080b..67727f95411 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -618,8 +618,14 @@ int git_fsync(int fd, enum fsync_action action)
 
 void trace_git_fsync_stats(void)
 {
-	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
-	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
+	const struct repository *r = the_repository;
+	const intmax_t cfwo = count_fsync_writeout_only;
+	const intmax_t cfhf = count_fsync_hardware_flush;
+
+	if (cfwo)
+		trace2_data_intmax("fsync", r, "fsync/writeout-only", cfwo);
+	if (cfhf)
+		trace2_data_intmax("fsync", r, "fsync/hardware-flush", cfhf);
 }
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
-- 
2.37.0.880.gf07d56b18ba


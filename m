Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D4C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 10:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGRKcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 06:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiGRKb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 06:31:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1771DA5F
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 03:31:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so7457855wmb.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 03:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvtGsoaPF8xPL4CA8ZTntw0LBZGQ2jgueOMpA/n7RfA=;
        b=nyzQvH1B2mlw3gTNiqdktY0Hh1q70QZi1EnY0dZ3eKzEUY3/oC0c2CEI6INmcHZwKI
         Z9quTWZVmWvvA0fmDB6Cdlyb31oNQUP9L9z2uybbpmqNZtCitQwnK9SPnkTzDUIaxYhM
         m73ZEIRBeeiNk1KbzhyoFYJIGXJbmJdGdfxodT62fwoRiIHqR5mxNYNZCk3Jhyk0MH/W
         KW/vmNLT9yibDU10aJgJLay+za/UT698OF1yeeDjK1UKizqjX7HalU1fcagtvmo3Lrj2
         7u1DmNaC9IiNur4xkmJ+asZckaRngdfovXi2iB3JgxtSKSWBvQX8KH8vyH+VKjShhs5/
         WvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvtGsoaPF8xPL4CA8ZTntw0LBZGQ2jgueOMpA/n7RfA=;
        b=Pb7LDoehhMlUYareTN06WxbbRmua9wxh+EBG+CrRDxWD+iFe6RuOxTjXEMrZ8fRPE4
         FQKLWYN1kCA8HNrPAhU5hc4One0MrlqJUYo6DECF7FjFqkGnvGvgKE3/UMFbWrw/eU9o
         ZWFonkEJUscAITVFY9pQp/MiEeLZrIchopnBPO7w8JiKiaBDTlD6b1jz4bAHMsQkny4R
         8bqUL2hjV0DNMSDveKfwx8gx/bAotpXS10Meddi9eM8hq2JTG31eDxywsHJ1304q+/Yb
         1nZFUD+nWHua9Dm4+tBl/l07xzlFoPa2FJb3moiVwfNqGF7+IAtof4SpqR57Zujvna2P
         +OpA==
X-Gm-Message-State: AJIora9D3B+jDZbtGqUdzLHSXkd+Q5W+XrTPfwtK6S4JOyz+o6QztmS8
        4bRSa608L+BFOAbySGmkKUzeWSmqCl8=
X-Google-Smtp-Source: AGRyM1tNaAVHwIRtgPR3zJg96Om0m0J7cKGd3q3G8nhkG1JQ2vowXSY/T7hXI3p6pm7LBaRifGVatQ==
X-Received: by 2002:a05:600c:358c:b0:3a3:1dfb:a21e with SMTP id p12-20020a05600c358c00b003a31dfba21emr1642517wmq.60.1658140314832;
        Mon, 18 Jul 2022 03:31:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p129-20020a1c2987000000b003a2d47d3051sm16866977wmp.41.2022.07.18.03.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 03:31:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Han Xin <chiyutianyi@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] trace2: only include "fsync" events if we git_fsync()
Date:   Mon, 18 Jul 2022 12:31:52 +0200
Message-Id: <patch-v3-1.1-979dea5956a-20220718T102747Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
References: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
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

The fix-up to aaf81223f48 (unpack-objects: use stream_loose_object()
to unpack large objects, 2022-06-11) is needed because we're changing
the behavior of these events as discussed above. Since we'd always
emit a "hardware-flush" event the test added in aaf81223f48 wasn't
testing anything except that this trace2 data was unconditionally
logged. Even if "core.fsyncMethod" wasn't set to "batch" we'd pass the
test.

Now we'll check the expected number of "writeout" v.s. "flush" calls
under "core.fsyncMethod=batch", but note that this doesn't actually
test if we carried out the sync using that method, on a platform where
we'd have to fall back to fsync() each of those "writeout" would
really be a "flush" (i.e. a full fsync()).

But in this case what we're testing is that the logic in
"unpack-objects" behaves as expected, not the OS-specific question of
whether we actually were able to use the "bulk" method.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This v3:

 * Fixes the failing tests, due to a merge with
   hx/unpack-streaming. See details at:
   https://lore.kernel.org/git/220715.86bktqzdb8.gmgdl@evledraar.gmail.com/

   We now test how many "writeout" and "flush" sync events we emit,
   rather than the (meaningless) previous behavior (see above)>

 * Creates a log_trace_fsync_if() helper in wrapper.c, to avoid both
   the duplication and line-wrapping issues previous rounds tried to
   address more verbosely.

Range-diff against v2:
1:  a1fc37de947 ! 1:  979dea5956a trace2: don't include "fsync" events in all trace2 logs
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    trace2: don't include "fsync" events in all trace2 logs
    +    trace2: only include "fsync" events if we git_fsync()
     
         Fix the overly verbose trace2 logging added in 9a4987677d3 (trace2:
         add stats for fsync operations, 2022-03-30) (first released with
    @@ Commit message
         2f732bf15e6 (tr2: log parent process name, 2021-07-21), but let's
         leave it for now.
     
    +    The fix-up to aaf81223f48 (unpack-objects: use stream_loose_object()
    +    to unpack large objects, 2022-06-11) is needed because we're changing
    +    the behavior of these events as discussed above. Since we'd always
    +    emit a "hardware-flush" event the test added in aaf81223f48 wasn't
    +    testing anything except that this trace2 data was unconditionally
    +    logged. Even if "core.fsyncMethod" wasn't set to "batch" we'd pass the
    +    test.
    +
    +    Now we'll check the expected number of "writeout" v.s. "flush" calls
    +    under "core.fsyncMethod=batch", but note that this doesn't actually
    +    test if we carried out the sync using that method, on a platform where
    +    we'd have to fall back to fsync() each of those "writeout" would
    +    really be a "flush" (i.e. a full fsync()).
    +
    +    But in this case what we're testing is that the logic in
    +    "unpack-objects" behaves as expected, not the OS-specific question of
    +    whether we actually were able to use the "bulk" method.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0212/parse_events.perl ##
    @@ t/t0212/parse_events.perl
      
          # This trace2 target does not emit 'printf' events.
     
    + ## t/t5351-unpack-large-objects.sh ##
    +@@ t/t5351-unpack-large-objects.sh: test_expect_success 'unpack big object in stream' '
    + 	test_dir_is_empty dest.git/objects/pack
    + '
    + 
    ++check_fsync_events () {
    ++	local trace="$1" &&
    ++	shift &&
    ++
    ++	cat >expect &&
    ++	sed -n \
    ++		-e '/^{"event":"data",.*"category":"fsync",/ {
    ++			s/.*"category":"fsync",//;
    ++			s/}$//;
    ++			p;
    ++		}' \
    ++		<"$trace" >actual &&
    ++	test_cmp expect actual
    ++}
    ++
    + BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
    + 
    + test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
    + 	prepare_dest 1m &&
    + 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
    ++	GIT_TEST_FSYNC=true \
    + 		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
    +-	grep fsync/hardware-flush trace2.txt &&
    ++	check_fsync_events trace2.txt <<-\EOF &&
    ++	"key":"fsync/writeout-only","value":"6"
    ++	"key":"fsync/hardware-flush","value":"1"
    ++	EOF
    ++
    + 	test_dir_is_empty dest.git/objects/pack &&
    + 	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
    + 	cmp obj-list current
    +
      ## wrapper.c ##
     @@ wrapper.c: int git_fsync(int fd, enum fsync_action action)
    + 	}
    + }
      
    ++static void log_trace_fsync_if(const char *key, intmax_t value)
    ++{
    ++	if (value)
    ++		trace2_data_intmax("fsync", the_repository, key, value);
    ++}
    ++
      void trace_git_fsync_stats(void)
      {
     -	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
     -	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
    -+	const struct repository *r = the_repository;
    -+	const intmax_t cfwo = count_fsync_writeout_only;
    -+	const intmax_t cfhf = count_fsync_hardware_flush;
    -+
    -+	if (cfwo)
    -+		trace2_data_intmax("fsync", r, "fsync/writeout-only", cfwo);
    -+	if (cfhf)
    -+		trace2_data_intmax("fsync", r, "fsync/hardware-flush", cfhf);
    ++	log_trace_fsync_if("fsync/writeout-only", count_fsync_writeout_only);
    ++	log_trace_fsync_if("fsync/hardware-flush", count_fsync_hardware_flush);
      }
      
      static int warn_if_unremovable(const char *op, const char *file, int rc)

 t/t0212/parse_events.perl       | 19 +++++++++++++------
 t/t5351-unpack-large-objects.sh | 22 +++++++++++++++++++++-
 wrapper.c                       | 10 ++++++++--
 3 files changed, 42 insertions(+), 9 deletions(-)

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
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 8ce8aa3b147..f785cb06173 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -48,13 +48,33 @@ test_expect_success 'unpack big object in stream' '
 	test_dir_is_empty dest.git/objects/pack
 '
 
+check_fsync_events () {
+	local trace="$1" &&
+	shift &&
+
+	cat >expect &&
+	sed -n \
+		-e '/^{"event":"data",.*"category":"fsync",/ {
+			s/.*"category":"fsync",//;
+			s/}$//;
+			p;
+		}' \
+		<"$trace" >actual &&
+	test_cmp expect actual
+}
+
 BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
 
 test_expect_success 'unpack big object in stream (core.fsyncmethod=batch)' '
 	prepare_dest 1m &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
+	GIT_TEST_FSYNC=true \
 		git -C dest.git $BATCH_CONFIGURATION unpack-objects <pack-$PACK.pack &&
-	grep fsync/hardware-flush trace2.txt &&
+	check_fsync_events trace2.txt <<-\EOF &&
+	"key":"fsync/writeout-only","value":"6"
+	"key":"fsync/hardware-flush","value":"1"
+	EOF
+
 	test_dir_is_empty dest.git/objects/pack &&
 	git -C dest.git cat-file --batch-check="%(objectname)" <obj-list >current &&
 	cmp obj-list current
diff --git a/wrapper.c b/wrapper.c
index 1c3c970080b..cfe79bd081f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -616,10 +616,16 @@ int git_fsync(int fd, enum fsync_action action)
 	}
 }
 
+static void log_trace_fsync_if(const char *key, intmax_t value)
+{
+	if (value)
+		trace2_data_intmax("fsync", the_repository, key, value);
+}
+
 void trace_git_fsync_stats(void)
 {
-	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", count_fsync_writeout_only);
-	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", count_fsync_hardware_flush);
+	log_trace_fsync_if("fsync/writeout-only", count_fsync_writeout_only);
+	log_trace_fsync_if("fsync/hardware-flush", count_fsync_hardware_flush);
 }
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
-- 
2.37.1.1032.gb00b5447790


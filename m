Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A96C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiKHSS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiKHSSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC42314A
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a5so23741283edb.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYcu8Mtqs7JkoFMa44WNWMccggFTHIUUG9SsyNCxnbw=;
        b=dCDTMZvQpFTUdZkDowukWLLxoauTSPcmUcxgXgWitryUK5kCzClsO5Ti33CvlPefgR
         2UnEpU3oyI/+RwBjHn3yHdeK2xFhLcKZsA1WD+uow1KbwI8lINrGbGniDj03v0UheasU
         PlemIu+DZHykN/89Ms5dHRZOSFGwKYCAQl8VcLtQ29HbaYOF95gQSvJbT46/PTQiTmlV
         RyAOlycJlBE5QG/2Z+Zg1aYu35SGBAQ0K/JreAWJiob1ZtC08G8cRYTzxX/w6K3n646z
         t8u6gKv7Ylm0e6V4YsvWWadWYTooB/enJ5mncay0waBL8Iyjnh4xEcXnGJjtj3wglAed
         2P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYcu8Mtqs7JkoFMa44WNWMccggFTHIUUG9SsyNCxnbw=;
        b=QSOR2H9ozsVhEiHifMvB9cjYR8K/0D6tjItZFJoX6UPlrL4iYShhWVsZaYFOE7afvy
         MKusDLQxb8swaxDcDrdlQkkqrHgZoR8Rn6iu2mgvYyNf01YMN2hXfWMckpJUlVkBtJ4Y
         aG/50MVYLNKxEkEtrV2VruQc3BPMqa3UygDgcRxotswlLomREy7fsEFzO8jAPaamT5aC
         5NwFeqTYG3E2RqRccF60l6PR01SfrMmbnE7GVHaXi1fqaVXc01hjAla4dlvoKgGAG+lD
         5Suc9Y8F/dw1/WiysYy6WI6GhH6MDHDUOh8TbiOh3NxgAyB5Pxr4pyYT/xi7jZxE8/Ph
         AAaA==
X-Gm-Message-State: ACrzQf0VlNL5wBFz13KYgW0hneEoX4pLrT6isw0OIs2neoNB/qDkLK/j
        hpqgLJQPpQCk3OItKci7xlubr9dw5Q0Fug==
X-Google-Smtp-Source: AMsMyM7ES8POowhEcD1897mcies+YLHrb1dz8ldQ2U0b5ImRigCk/kb43kVitt+B0PXNlseTGEaweQ==
X-Received: by 2002:aa7:d694:0:b0:461:7638:bde5 with SMTP id d20-20020aa7d694000000b004617638bde5mr57781737edr.105.1667931481875;
        Tue, 08 Nov 2022 10:18:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/15] sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
Date:   Tue,  8 Nov 2022 19:17:46 +0100
Message-Id: <patch-v2-10.15-243ab74120b-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "read_strategy_opts()" is called we may have populated the
"opts->strategy" before, so we'll need to free() it to avoid leaking
memory.

We populate it before because we cal get_replay_opts() from within
"rebase.c" with an already populated "opts", which we then copy. Then
if we're doing a "rebase -i" the sequencer API itself will promptly
clobber our alloc'd version of it with its own.

If this code is changed to do, instead of the added free() here a:

	if (opts->strategy)
		opts->strategy = xstrdup("another leak");

We get a couple of stacktraces from -fsanitize=leak showing how we
ended up clobbering the already allocated value, i.e.:

	Direct leak of 6 byte(s) in 1 object(s) allocated from:
	    #0 0x7f2e8cd45545 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
	    #1 0x7f2e8cb0fcaa in __GI___strdup string/strdup.c:42
	    #2 0x6c4778 in xstrdup wrapper.c:39
	    #3 0x66bcb8 in read_strategy_opts sequencer.c:2902
	    #4 0x66bf7b in read_populate_opts sequencer.c:2969
	    #5 0x6723f9 in sequencer_continue sequencer.c:5063
	    #6 0x4a4f74 in run_sequencer_rebase builtin/rebase.c:348
	    #7 0x4a64c8 in run_specific_rebase builtin/rebase.c:753
	    #8 0x4a9b8b in cmd_rebase builtin/rebase.c:1824
	    #9 0x407a32 in run_builtin git.c:466
	    #10 0x407e0a in handle_builtin git.c:721
	    #11 0x40803d in run_argv git.c:788
	    #12 0x40850f in cmd_main git.c:923
	    #13 0x4eee79 in main common-main.c:57
	    #14 0x7f2e8ca9f209 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
	    #15 0x7f2e8ca9f2bb in __libc_start_main_impl ../csu/libc-start.c:389
	    #16 0x405fd0 in _start (git+0x405fd0)

	Direct leak of 4 byte(s) in 1 object(s) allocated from:
	    #0 0x7f2e8cd45545 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
	    #1 0x7f2e8cb0fcaa in __GI___strdup string/strdup.c:42
	    #2 0x6c4778 in xstrdup wrapper.c:39
	    #3 0x4a3c31 in xstrdup_or_null git-compat-util.h:1169
	    #4 0x4a447a in get_replay_opts builtin/rebase.c:163
	    #5 0x4a4f5b in run_sequencer_rebase builtin/rebase.c:346
	    #6 0x4a64c8 in run_specific_rebase builtin/rebase.c:753
	    #7 0x4a9b8b in cmd_rebase builtin/rebase.c:1824
	    #8 0x407a32 in run_builtin git.c:466
	    #9 0x407e0a in handle_builtin git.c:721
	    #10 0x40803d in run_argv git.c:788
	    #11 0x40850f in cmd_main git.c:923
	    #12 0x4eee79 in main common-main.c:57
	    #13 0x7f2e8ca9f209 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
	    #14 0x7f2e8ca9f2bb in __libc_start_main_impl ../csu/libc-start.c:389
	    #15 0x405fd0 in _start (git+0x405fd0)

This can be seen in e.g. the 4th test of
"t3404-rebase-interactive.sh".

In the larger picture the ownership of the "struct replay_opts" is
quite a mess, e.g. in this case rebase.c's static "get_replay_opts()"
function partially creates it, but nothing in rebase.c will free()
it. The structure is "mostly owned" by the sequencer API, but it also
expects to get these partially populated versions of it.

It would be better to have rebase keep track of what it allocated, and
free() that, and to pass that as a "const" to the sequencer API, which
would copy what it needs to its own version, and to free() that.

But doing so is a much larger change, and however messy the ownership
boundary is here is consistent with what we're doing already, so let's
just free() this to fix the leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index e23f6f0b718..433fec21562 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2897,6 +2897,7 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 		return;
+	free(opts->strategy);
 	opts->strategy = strbuf_detach(buf, NULL);
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
-- 
2.38.0.1467.g709fbdff1a9


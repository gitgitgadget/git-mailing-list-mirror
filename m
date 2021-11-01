Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4161C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA2760F46
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhKATLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhKATLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EB7C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so593488wmz.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asZRZcY5DAOjxvF5C4f7T5GU7CpiPAAqj3QGk47VAuc=;
        b=XhKc/ZIO5bVYGoD+QG5TKGUN4i+Y5xJW2gEp8f6yY42UUAb+St6o2fSdXlR618w47L
         OrbFogFagvyOxihWxkD2XRv4OZSRRrqx7xb7gqKbb/7ZMzOzP+DkvvgjBACLEiWtHBlT
         p9r/tCV/Ef6M4PEoxxqE8wQsw7Aqz3VwiGyVREkSSnfU7ArDoLga+zU9nrnVZeke/Jcb
         DkWyiBzTa5ROvVjcbcZK0jT1IpoJdWGf1zTglCKhW9bek9qmznqURUaahl/khkFRJFIx
         ipqHnz1XdQ2sUXd8LGt/t3FMhG30dU0/DI1JTtciYup3nDmqFccH2C3m5bt21sCnXMzR
         3a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asZRZcY5DAOjxvF5C4f7T5GU7CpiPAAqj3QGk47VAuc=;
        b=ou91Wh3iP2jHEcGFgMxCPhzP+kakiHB66hHMilVZ6hmLlzhZFMRKCFEwf3HU2rp7gL
         KPnxZGUWMA/bPldzp+VUoqKVF4x2YBW1O1s2KT7ZNGjlgaG+z3vJfpKDySFlKY/iuX5B
         sV5SK3O0rUuTdbDwZVxtMakwdABGXPsu9vndybrMoLKhP7OFzWmzyZb8L6/b5cOnJKiC
         AOkeslyIL+4A2mG9O6d4lcIj5It2LDXY3Fbc+6pg1aIZY10nLa8B8AHw1vLSfqUZYPLT
         ZziFCMIX+pulhKE15hildqbs017RjXXiW8C3S47Z3r3gzJu7RAcxc9VBxWcR4kRBv6CK
         ErPw==
X-Gm-Message-State: AOAM530Bd9YQJ/DoB2heLsDk7w4SYiydK5EnZpQS7P8c/Tze50uDEuox
        ilyVOKqCnUhnbyq9Ya42VAwPjiMiCwbpVWKF
X-Google-Smtp-Source: ABdhPJzCdkILF2d/y40D72nEOvzCs8Kr53Eg+Ub4RqB7l6PgArNn88ckEpBD6/lb5MrJvisBnAnuLQ==
X-Received: by 2002:a05:600c:4f4b:: with SMTP id m11mr854237wmq.151.1635793757872;
        Mon, 01 Nov 2021 12:09:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/8] progress: assert "global_progress" + test fixes / cleanup
Date:   Mon,  1 Nov 2021 20:09:06 +0100
Message-Id: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a commit-message only update of v4[1]. It was pointed out on
v4 that linked-to POC code discussed in the commit message wasn't safe
for running inside a signal handler.

That's correct, but achieving the same goals would be possible while
retaining signal safety on some platforms, so update the commit
message discussion to note that.

In any case that part of the commit message is discussing future
side-benefits of the change, the change as it is isn't doing anything
novel with signal handlers in the progress.c code.

1. https://lore.kernel.org/git/cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com/
2. https://lore.kernel.org/git/c65c0a54-b66f-a043-01d9-192f9ca1efde@kdbg.org/

Ævar Arnfjörð Bjarmason (8):
  leak tests: fix a memory leaks in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop commands on stdin
  progress.c tests: test some invalid usage
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: don't return without stop_progress()
  various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
  progress.c: add & assert a "global_progress" variable

 builtin/bisect--helper.c    |   2 +-
 builtin/bundle.c            |   2 +-
 compat/mingw.c              |   2 +-
 pack-bitmap-write.c         |   6 +--
 progress.c                  |  23 +++++++-
 t/helper/test-progress.c    |  52 +++++++++++++-----
 t/t0500-progress-display.sh | 105 ++++++++++++++++++++++++++++--------
 7 files changed, 150 insertions(+), 42 deletions(-)

Range-diff against v4:
1:  a3bd032d1eb = 1:  0c0e5bfc656 leak tests: fix a memory leaks in "test-progress" helper
2:  e441cfea7c5 = 2:  0ae86e40e16 progress.c test helper: add missing braces
3:  1c5f9bdfe6d = 3:  767aa010026 progress.c tests: make start/stop commands on stdin
4:  474ce31f9d2 = 4:  9bcc8cfc9d2 progress.c tests: test some invalid usage
5:  ff039742148 = 5:  3a95613cd04 progress.c: add temporary variable from progress struct
6:  3dfe31decff = 6:  0300b802dcb pack-bitmap-write.c: don't return without stop_progress()
7:  8a18eb40fae = 7:  4795d4835b0 various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
8:  06124e8ac5e ! 8:  e58f4a0c1b9 progress.c: add & assert a "global_progress" variable
    @@ Commit message
     
         It will also establish scaffolding to address current fundamental
         limitations in the progress output: The current output must be
    -    "driven" by calls to the likes of display_progress(). Once we have a
    -    global current progress object we'll be able to update that object via
    -    SIGALRM, this will cover cases where we're busy, but either haven't
    -    invoked our first display_progress() yet, or the time between
    -    display_progress() is too long. See [3] for early code to do that.
    +    "driven" by calls to the likes of display_progress().
    +
    +    Once we have a global current progress object we'll be able to update
    +    that object via SIGALRM, this will cover cases where we're busy, but
    +    either haven't invoked our first display_progress() yet, or the time
    +    between display_progress() is too long. See [3] for early code to do
    +    that.
    +
    +    The linked code in [3] is WIP and not signal-safe since among other
    +    things it calls sprintf() from within a signal handler, see e.g. "man
    +    7 signal-safety". But on some platforms a real implementation of it
    +    would be able to write() out a prepared-formatted progress update from
    +    within a signal handler. That would be sufficient to e.g. show that
    +    we're "stalled", or to display something like a simple pre-formatted
    +    "spinner".
     
         It's conceivable that this change will hit the BUG() condition in some
         scenario that we don't currently have tests for, this would be very
-- 
2.33.1.1570.g069344fdd45


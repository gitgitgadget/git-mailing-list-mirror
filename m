Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51402C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 09:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3222461214
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 09:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbhIWJWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 05:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbhIWJWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 05:22:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF85AC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 02:20:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w17so15108272wrv.10
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Opwj0D3o4XIQt8xpFcLnkc5zCs1SM8RUSPW1ILQE/k8=;
        b=Tvf/OQ9HNoEDbq4xbaEoupeEKihBlPwa9NC2vOLcBfXQALNTzy+1nb3FKUxnwDhkTB
         kd71S+7F+rvHWD4ffVPop1l2Vjw7Sw2qVS8OtWOYfHu4kbOzE47UXoj3BNeiGCxwfBig
         T4CfkEBQmmWw8sV73T9q8f7/T5VhWmysYltS8oqdJHxfcdpsSS28MjljYxnGzC8ME3oL
         5aronGgdixHGkQdkTw49Mrfl5nu9FvsCqmSK8VjEgDqcceCpQTtiOwA0yuMNzMrcX73c
         MwTkuFiQoVN/wQuTHl6w+LDswZ1CxsigMfeaYv3WTCe8cFL171Jxn+0JMfN+yPIe3Xrs
         owJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Opwj0D3o4XIQt8xpFcLnkc5zCs1SM8RUSPW1ILQE/k8=;
        b=8PwQ+EizxmgZiWZpFdDumnHrMvkxg82IlgxW3BDpZ2GWIvW7egM+2ISdhC9n2YS9EH
         9nYym1Ht5XuGRLbU2UPOBZwY+Oc98rZf2TdgGv9J6CgKkwBQGC5DuJQs2o5bVCOQV4Us
         64Ae9u1zeE4sY131igiuK0a4hVkx3+GOdqGUVig3etVP5mcAEFhpiFZ24jcz6GQtVR5i
         91X6+oq4KXsMCmA5qsJHEokBfl7KaiXQKY5QeKHNTB9bZoOqiHKEEtoQ5hsuSXHFceY6
         Ro9QWAv+B80NIgG74Bx4pLx8EQTfEvV8cnVfB3mZ4PREFFDqXFx9f/mLZQt/ZA98an8t
         zgRg==
X-Gm-Message-State: AOAM5325tvrOCy8T/ess+ztqwJ8/ANwEsa3SKexvUOQrX6DBZr3Tk/HY
        +ZqjFDUdNQr1GfTP/gUHF1Md0rheWqYN/A==
X-Google-Smtp-Source: ABdhPJzZ2zwBKPfeaa0RkIyEnAh+8iz4CxCxq6R1j4upad3STsnUz0e1iSM7IezEaJ/Wm3k3jBwX2g==
X-Received: by 2002:a7b:c184:: with SMTP id y4mr1801969wmi.128.1632388850204;
        Thu, 23 Sep 2021 02:20:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66sm4540669wmn.2.2021.09.23.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 02:20:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 0/2] add a test mode for SANITIZE=leak, run it in CI
Date:   Thu, 23 Sep 2021 11:20:44 +0200
Message-Id: <cover-v8-0.2-00000000000-20210923T091819Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1228.gdc65525c655
In-Reply-To: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
References: <cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a small beachhead of tests we run in CI that we
assert to be memory-leak free with the SANITIZE=leak test mode. Once
it lands the intent is to expand the parts of the test suite we
whitelist as memory-leak free.

For the v7 see:
https://lore.kernel.org/git/cover-v7-0.2-00000000000-20210919T075619Z-avarab@gmail.com/

This v8 fixes a test failure that happened in combination with the
sg/test-split-index-fix topic, which just unearthed an old
GIT_TEST_SPLIT_INDEX=true memory leak.

Carlo Marcelo Arenas Belón had a fixup for it (that's currently
applied to the v7) here:
https://lore.kernel.org/git/20210922111741.82142-1-carenas@gmail.com/

I acked it in
https://lore.kernel.org/git/87h7ec59m7.fsf@evledraar.gmail.com/; but
on second thought I think this is a better solution for the reasons
noted in the updated commit message.

Ævar Arnfjörð Bjarmason (2):
  Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
  tests: add a test mode for SANITIZE=leak, run it in CI

 .github/workflows/main.yml |  3 +++
 Makefile                   |  5 +++++
 ci/install-dependencies.sh |  2 +-
 ci/lib.sh                  |  9 ++++++++-
 t/README                   |  7 +++++++
 t/t0004-unwritable.sh      |  3 ++-
 t/t0011-hashmap.sh         |  2 ++
 t/t0016-oidmap.sh          |  2 ++
 t/t0017-env-helper.sh      |  1 +
 t/t0018-advice.sh          |  1 +
 t/t0030-stripspace.sh      |  1 +
 t/t0063-string-list.sh     |  1 +
 t/t0091-bugreport.sh       |  1 +
 t/test-lib.sh              | 21 +++++++++++++++++++++
 14 files changed, 56 insertions(+), 3 deletions(-)

Range-diff against v7:
1:  fc7ba4cb1c3 = 1:  c68a7108dc4 Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
2:  56592952db5 ! 2:  90ecd49c910 tests: add a test mode for SANITIZE=leak, run it in CI
    @@ Commit message
         The intent is to add more TEST_PASSES_SANITIZE_LEAK=true annotations
         as follow-up change, but let's start small to begin with.
     
    +    In ci/run-build-and-tests.sh we make use of the default "*" case to
    +    run "make test" without any GIT_TEST_* modes. SANITIZE=leak is known
    +    to fail in combination with GIT_TEST_SPLIT_INDEX=true in
    +    t0016-oidmap.sh, and we're likely to have other such failures in
    +    various GIT_TEST_* modes. Let's focus on getting the base tests
    +    passing, we can expand coverage to GIT_TEST_* modes later.
    +
         It would also be possible to implement a more lightweight version of
         this by only relying on setting "LSAN_OPTIONS". See
         <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>[1] and
    @@ ci/lib.sh: linux-musl)
     +
      MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
     
    - ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: fi
    - 
    - make
    - case "$jobname" in
    --linux-gcc)
    -+linux-gcc|linux-leaks)
    - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - 	make test
    - 	export GIT_TEST_SPLIT_INDEX=yes
    -
      ## t/README ##
     @@ t/README: excluded as so much relies on it, but this might change in the future.
      GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
-- 
2.33.0.1228.gdc65525c655


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA420C433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BCF61960
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 16:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhC2QcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhC2Qb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 12:31:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8670AC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:31:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k8so13505515wrc.3
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ci4Gjf/9/AMzEQl39glx5X6xSzCGnAhABxjt24UU0V8=;
        b=CM0HyjhGk/RnoFtfCcP8gB7DXwuI80nFhUPGKCTFyoBwaL3oDKWwd3qctQPCsyn/1L
         uVCDHkpNllFADTgvjuImxl8xMTLWxKE/rYKHzelsCt7JXkqXh8USRwuZcC9rGKysDOK0
         olzRbHkZW7sED9rkkGsOXfJ8/mDVw3uuD0UgX9Dj+W+M/JPIqHUNiidSGKlPvF+jhW6A
         mQAdXE0paZr+hCdlIxALRZwphvKHzC4PVPbTrNdOcOZYeEBouc3SBwtZpoeikD01mlqm
         xbqWTw/fRJ47EDNHRgtChW7j688fOdvjA14YoJmQnX5EF4We5a7B2lpHtsCcbBoJMLAS
         OQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ci4Gjf/9/AMzEQl39glx5X6xSzCGnAhABxjt24UU0V8=;
        b=LOKH6dwR1Qb7AA9bVjf2tQiTa8Q1bstUvGtBNWun6ZMmou2MOzFa+14UlaRloZGU5Y
         TA35NFU2djJ+5aBdUwc4Ba6EYT605TByES5n3Agkx5lpYXMwGWm8ipTCZ6GLtbYqBn9c
         AU8G+VxlS0osvO2DmJPAqCL6C9IB76BNzWklylKiLJB0f1iy5taqtQ4L9GNVoRb1AM9v
         Z76rWr7CtYjjZfCHKTtSHiILw9fuyy7Ibn/+/7qQte782AP+Uw7MW/6AyKg6J+hZ8BAv
         KxnGJOSmNh93gPmw/NX7QJ59Tg/EuJ6JslMPb+dIYh30cZb6jupmJ89H9yGawikcMmEc
         93PA==
X-Gm-Message-State: AOAM532m/Qo1ZnFFxJ2hSLkPjQtP18wMTo2HJFhFlN3IqO1ZkM6cm8U9
        +s0l7y55N3uiI3w5tSehme4raSwdUCBvVw==
X-Google-Smtp-Source: ABdhPJwjQRpCgoPY+Lv+6jIFbOayNkty0rXQb6ZXNKl0kGg46OvnvUbMdJ8h75XPFggAqJwcRlXeaA==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr18096171wru.286.1617035516005;
        Mon, 29 Mar 2021 09:31:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm25410464wmg.41.2021.03.29.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:31:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <andreas.faerber@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] Makefile: make non-symlink & non-hardlink install sane
Date:   Mon, 29 Mar 2021 18:31:38 +0200
Message-Id: <cover-0.7-00000000000-20210329T162327Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.461.gd47399f6574
In-Reply-To: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on top of my just-submitted "Makefile: don't die on AIX with
open ./git" series: [1]

This series introduces no "real" behavior changes I'd expect anyone to
notice, but refactors a lengthy copy/pasted test/if/else in the
Makefile into a simple helper script.

The "real" behavior change is that we no longer ask the user how
they'd like to install (symlinks, hardlinks, neither?) and then
proceed to ignore what was asked of us and optimistically fallback in
case of errors. I.e. the inability to create symlinks or hardlinks.

Instead we'll just die, the old behavior is still available as
INSTALL_FALLBACK_LN_CP. In practice I think exactly nobody actually
wanted the existing behavior.

It's just something that emerged over almost 2 decades of first
wanting to have the ability to specify such a fallback, and then
adding e.g. support for INSTALL_SYMLINKS along the way.

There's also side-discussion of a bug I discovered along the way in
SKIP_DASHED_BUILT_INS in 4/6. This series doesn't make that bug better
or worse, but it interacts with the flags being changed here.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com/
   In practice they apply independently, but since they're touching
   some very adjacent code I'm saying it's "on top" in case a re-roll
   makes it so, and also for ease of local testing.

   I'm trying a new thing of splitting my serieses up a bit, so if
   there's outstanding feedback on the later parts, hopefully the
   former part can proceed independently...

Ævar Arnfjörð Bjarmason (6):
  Makefile: symlink the same way under "symlinks" and "no hardlinks"
  Makefile: begin refactoring out "ln || ln -s || cp" pattern
  Makefile: refactor out "ln || ln -s || cp" pattern
  Makefile: make INSTALL_SYMLINKS affect the build directory
  Makefile: use "ln -f" instead of "rm && ln"
  Makefile: add a INSTALL_FALLBACK_LN_CP mode

 .gitignore  |  1 +
 Makefile    | 91 +++++++++++++++++++++++++++++++----------------------
 ln-or-cp.sh | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 38 deletions(-)
 create mode 100755 ln-or-cp.sh

-- 
2.31.1.461.gd47399f6574


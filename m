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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78793C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D64A23A6C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbhANXgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhANXgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C78C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 91so7508616wrj.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4S1yZ8Ud6cC86wUXXeuVL8lFF8Vk24t6NsOpNZpr1I=;
        b=rn6kC0obgfcjWjpYjoV/84SxjDOp+OhJ4pBZ/o23a0A6IxE+FnQ+epMoHPkqSsHjpF
         mR8C3zLR+KGiGBUfK+AOXKV0lUJ9oSk2qeQ2jB+pDL8rS6Of9pwQGuwMMtm7WRPcUoA2
         NcuRUFhGlridBQPkJJ0Pr9RSBjZcXr7rCOemWYtoTjzJFQ42VxXzRiIjH4w4LB4DPfyI
         gZ1s/f7Vp+BbFth81Qjv9+xM8RMXAqOMuv8WCS3uxbtOMPCWuvfmqENeCKifaqtEvHFO
         83JS1GMpYkDhbRAcykD/Q14bXCVbASZJLFcfJEl1CpBqNMaQxql5xiRQ+f1ST8Q99ayu
         3oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4S1yZ8Ud6cC86wUXXeuVL8lFF8Vk24t6NsOpNZpr1I=;
        b=aNKLQu72ErQCrm6p3bMrhyBvxumaSsxIF5MNyL9oKK8ZwADywsBsoxptZxxLXdAQ5n
         vG6sG+ukw+G4vag2D9xAhFpC/hHn9jko/Mayy10Y5Woi2NC7rH6TbysWB61YOtDKMJXv
         YG1zsPUqASJkH62bKAG2SjXuZGxebJHFdGAs2yOTyvgcbyZDcxaKfGkndf7T1VfFIkrY
         xDqSa7PaArYZz6u3hPazXkoM6jTErO9S4eep5j95g6NvKzpIhC6C8Tw37VwDgeuPEbtl
         20hyNh5KDbvAmFu2iv1Xc7hkBtqtqEHzgVmadB+PogOufE0JuK6khW33j+WMDPJT84Yk
         tO4A==
X-Gm-Message-State: AOAM530O0NZhIWQzRD0o5mWwjAjugqaPu1BdAHnDRYEtDfHu2mocylMU
        IzGowx+O5YgAk4kj99oJYspma9/IPHC/Qw==
X-Google-Smtp-Source: ABdhPJwlT5rXYjYnl1eVrSWdsHSpjqxIXCEF/w7kapHpG8Bkj/KIcw1DSlPIOf1ggpCRqvkvnie8sw==
X-Received: by 2002:adf:dd92:: with SMTP id x18mr10327624wrl.311.1610667320180;
        Thu, 14 Jan 2021 15:35:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] tests: add a bash "set -o pipefail" test mode
Date:   Fri, 15 Jan 2021 00:35:09 +0100
Message-Id: <20210114233515.31298-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's been past attempts to add a "set -o pipefail" test mode. I
suspect it can't be done in any sane way the way it works in bash
now. See 6/6 for details.

This series makes it work because I patched it to work sanely in bash
itself when it comes to SIGPIPE. I'm partially submitting this so I
can prod the bash maintainer with a link to this thread.

But also because even though you need to patch your bash to benefit
from this new test mode, it doesn't break anything for anyone who
doesn't have the patch (we guard it with a detection for the sane
behavior), and at the very least 4/6 (or maybe just to 2/6) are
generally sane fixes even without the rest.

1. https://lore.kernel.org/git/cover.1573779465.git.liu.denton@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  test-lib: add tests for test_might_fail
  test-lib: add ok=* support to test_might_fail
  test_lib: allow test_{must,might}_fail to accept non-git on "sigpipe"
  tests: use "test_might_fail ok=sigpipe grep" when appropriate
  tests: split up bash detection library
  tests: add a "set -o pipefail" for a patched bash

 t/README                           |  6 +++++
 t/lib-bash-detection.sh            |  8 +++++++
 t/lib-bash.sh                      |  4 +++-
 t/t0000-basic.sh                   | 38 ++++++++++++++++++++++++++++++
 t/t0005-signals.sh                 |  4 ++--
 t/t0090-cache-tree.sh              |  2 +-
 t/t5000-tar-tree.sh                |  2 +-
 t/t5703-upload-pack-ref-in-want.sh |  2 +-
 t/t9151-svn-mergeinfo.sh           |  6 ++---
 t/t9902-completion.sh              |  5 ++++
 t/test-lib-functions.sh            | 24 ++++++++++++++++++-
 t/test-lib.sh                      | 29 +++++++++++++++++++++++
 12 files changed, 120 insertions(+), 10 deletions(-)
 create mode 100644 t/lib-bash-detection.sh

-- 
2.29.2.222.g5d2a92d10f8


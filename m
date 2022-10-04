Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B5C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiJDNYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJDNYD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA1352E75
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:23:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so15944138wrr.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktSYxbnRuDqJ9tFuiHIx8TaUEBHEnBnK88Mi291je3M=;
        b=kBSXrXPaXOU7NKgauYlL3hXpDpUSfjqb5psCswTmIrWS/mCAfYCL06bhRZBoLr2d5R
         bL3XqbEsnwIDWnQixbV1DpfwsrxYMjF1lv9Qs/H48tgLWc+OqdMcP6pP0lymGUno/SKE
         S/WTlXUh2XXG1TrpGBxeqCqyPuoS6bdPaMS/iPhrD0mU+GW/ISZ56SrLqMfrrOPO1ioF
         Y3QJ8KAki04WrBBrSKSDzuXzxnBmg6SYuQ642AWgpXTvwJGD99IT2FKhnhcwG014ALVM
         b+RHghtYjQndYuO/V13jR/cKk+OM8oZ0uAIgiXmO49w6tLy3URKX9X+ZMdv9KLNw4zQX
         Qsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktSYxbnRuDqJ9tFuiHIx8TaUEBHEnBnK88Mi291je3M=;
        b=qo+jSwOmUG//6J4pfXkvmxelL3m/38sLyr7p65bu/OylFBGL5eOBe/HgW7hBoDcz5B
         L3bgkF1bCjrDD+Wb0jhaUztFXm+vdZIQpl8QZ3vHFNsn3U/VvSmMWE1g3EQ+e5vrYtbr
         coD/4Mr0oJlCd2KcYa2QQwYzml0VumPydbSo2I4R8GW/T3Qt/O9syq8YtnCyCbhzsHOL
         akw+LS8osyesrnPsixunRofBCNVNi3rQmVtll/lSWZ2hcr//frA97Yfn4EFbjvVqoFVm
         bkXyn2IP+TeXu/UsjImY/y4G7hO3Eu/3yRl+1Ok5pmKKgjpGHchuo01+6oTTvP2yFFaK
         TVPQ==
X-Gm-Message-State: ACrzQf0AF501aTWh4JhPxv3IMNuJXanIaF1BhZEXjaPKmnkdljU4/ZFV
        FcdmUda2kkSZud1mSfxe8YTBkc3yF8RDGw==
X-Google-Smtp-Source: AMsMyM7XXINNsEVtDyFflrZCZv+9Gn84q2MXu4gQ2LaWXNF08Nx+c39VTW0t78EOyhLjy/poxW2hHg==
X-Received: by 2002:adf:dbcc:0:b0:22c:c8ef:2bf0 with SMTP id e12-20020adfdbcc000000b0022cc8ef2bf0mr16467761wrj.254.1664889837230;
        Tue, 04 Oct 2022 06:23:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/34] doc SYNOPSIS: don't use ' for subcommands
Date:   Tue,  4 Oct 2022 15:23:19 +0200
Message-Id: <patch-v4-05.34-ac437d4eee5-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Almost all of our documentation doesn't use "'" syntax for
subcommands, but these did, let's make them consistent with the
rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-reflog.txt | 2 +-
 Documentation/git-rerere.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index db9d46edfa9..0537d4645be 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog' ['show'] [<log-options>] [<ref>]
+'git reflog' [show] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4cfc8833780..4b613d4140c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
+'git rerere' [clear|forget <pathspec>|diff|remaining|status|gc]
 
 DESCRIPTION
 -----------
-- 
2.38.0.rc2.935.g6b421ae1592


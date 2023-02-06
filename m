Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435D6C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBFW7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjBFW72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:59:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7F230E91
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:59:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so11912916wrr.9
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1BRMSt25SeOLWoL4w5aQXzasJQqv73qcMwtwFQZeVU=;
        b=i6QIXJD3ku4/6Y6eqBdke/6iROoF0y0weZxal++iNAfWrcfWYBhMD1XReXUGQfYK1T
         aWC7r5FLBjhSfTkDsBw6Irc41SE2DO2Df9Ttsepdf4iLUILEH69Sj67fpG03F0Rpe2nT
         fcJK/7zATMS/PHuMxJOoxZZSJuXzziH1c+ZJmclMSBt2qUFt8LguUxlGXiOD8AgkxRET
         mkq4+oZ+jxU5Fi5kS23e3T5pWZmaxwbXMbtE4xT1sOrV4OCEhYclri8XjRmy434umRSG
         LiUlKIkSqiS4XGfKgK6eGipQRTl1Srz04pBluqLnaQW4BCWZB6QSWHeh7kGRYW4ypkgJ
         pRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1BRMSt25SeOLWoL4w5aQXzasJQqv73qcMwtwFQZeVU=;
        b=xoWjODCBNaU1N5r7mCO1D+fPihhagSwffwp7SNF6DrvkfKbRxL0Co7MKUnIDqaA6IC
         A02H6FFmW5ZYFffPTPxd+i/1FNiVheE1VelSJ7BzNWbTyWewAcciaIaFfZZDvJGKR1dy
         T9EZXgd6IhREUWJp0MwpwMxDnRnFjEO3SMM9B1QAbyz1a4zHQv47ZKycBgIQ8S86GH62
         yDT0eC5WYyUF66iuz1/82O/lpJwr37OwbJlX0hVGCfoPmhWFbTlL3kDLEEGL57BDA1Rl
         bHWc8HYpAOlxanVfF3iyhfsNlmJRZSy93obOrrfM2Lf7/Bj8d0EUCqyCBbRXpWd7hnBh
         +ceg==
X-Gm-Message-State: AO0yUKUtDd6EvFUeLxzYKjFBey8KuxOSrwZWd+e+phKO2CeI1rSOYr1k
        nlJ2r57a8VVtq1dxmVsmnJAd9LKy1gDEyjNH
X-Google-Smtp-Source: AK7set+NZpKOoW7CZnT4XaMbhMyZWf9pnIC3fGimywAhHhqY1UanmwSkNszCSWCOMoo6XXhQSXAODw==
X-Received: by 2002:a05:6000:12cb:b0:2c3:4ef0:343e with SMTP id l11-20020a05600012cb00b002c34ef0343emr525815wrx.5.1675724344136;
        Mon, 06 Feb 2023 14:59:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y17-20020adfd091000000b002c3ea68c58asm3170055wrh.1.2023.02.06.14.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:59:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] add: remove Perl version of "git add -[pi]"
Date:   Mon,  6 Feb 2023 23:58:55 +0100
Message-Id: <cover-v2-0.3-00000000000-20230206T225639Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've given the "git add -i" migration away from Perl to a built-in
enough time to remove the old Perl code.

For v1, see:
https://lore.kernel.org/git/cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com/

Branch & CI for this at:
https://github.com/avar/git/tree/avar/nuke-perl-add--interactive-2

The only change from v1 is to squash in a suggested change from
Philippe Blain, thanks!

Ævar Arnfjörð Bjarmason (3):
  add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"
  add API: remove run_add_interactive() wrapper function
  docs & comments: replace mentions of "git-add--interactive.perl"

 .gitignore                   |    1 -
 Documentation/config/add.txt |    7 +-
 Documentation/git-add.txt    |    6 +-
 INSTALL                      |    2 +-
 Makefile                     |    1 -
 builtin/add.c                |   61 +-
 builtin/checkout.c           |   12 +-
 builtin/clean.c              |    2 +-
 builtin/reset.c              |    4 +-
 builtin/stash.c              |    3 +-
 ci/run-build-and-tests.sh    |    1 -
 commit.h                     |    2 -
 git-add--interactive.perl    | 1920 ----------------------------------
 pathspec.c                   |    2 +-
 t/README                     |    4 -
 t/t2016-checkout-patch.sh    |    6 -
 t/t3701-add-interactive.sh   |   29 +-
 t/t6132-pathspec-exclude.sh  |    6 +-
 t/test-lib.sh                |    4 -
 19 files changed, 50 insertions(+), 2023 deletions(-)
 delete mode 100755 git-add--interactive.perl

Range-diff against v1:
1:  f39dde93011 ! 1:  71c7922b25f add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"
    @@ Documentation/config/add.txt: add.ignore-errors (deprecated)::
     +	interactive mode, which then became the default in Git
     +	versions v2.37.0 to v2.39.0.
     
    + ## INSTALL ##
    +@@ INSTALL: Issues of note:
    + 	  for everyday use (e.g. "bisect", "request-pull").
    + 
    + 	- "Perl" version 5.8 or later is needed to use some of the
    +-	  features (e.g. preparing a partial commit using "git add -i/-p",
    ++	  features (e.g. sending patches using "git send-email",
    + 	  interacting with svn repositories with "git svn").  If you can
    + 	  live without these, use NO_PERL.  Note that recent releases of
    + 	  Redhat/Fedora are reported to ship Perl binary package with some
    +
      ## Makefile ##
     @@ Makefile: SCRIPT_LIB += git-mergetool--lib
      SCRIPT_LIB += git-sh-i18n
2:  fb0dafaf4a4 = 2:  9299f22cc2c add API: remove run_add_interactive() wrapper function
3:  6ee56de1371 = 3:  09bece75c22 docs & comments: replace mentions of "git-add--interactive.perl"
-- 
2.39.1.1425.gac85d95d48c


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AEFC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E087922583
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgLDGRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDGRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:06 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617D0C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:26 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id t18so4235199otk.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UVqyzH8CEqB/hrUc3lSaLAF9ax0HjH4B/5b4VR50H4=;
        b=QX7eOmb8cMlrl6n+UH+piNIbUOotp97vrMBLEbMXGneMfUag3fZaZQk7rQR+GKLA02
         FAHZqbnzmleP74BdBcUcEPg7FvEAGCmDledpzSusPP2gcVRD4EDBIKgBoG+dYmaAiWsH
         AlyFHu3zZ9fDADqOoHoJZuwqL4eXsrbL1SReTB5eOimYbIW+Fju64cyoGcz1mmdjA1TB
         losQgbXBHVlmEJC4iPAppA2yRd4KidINkQkLn23BddrLP158zsprmnqmy1eiENeFrnn5
         3+f8jC42wojUItH5hlDzuM6FcmYFCiE8ZM9FasEycsltXvYEBVEGu3RaA68bLcpxRWZo
         5A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5UVqyzH8CEqB/hrUc3lSaLAF9ax0HjH4B/5b4VR50H4=;
        b=sPQzDntwHF2UXGrBZtc0qq+QWoqoIfDlmhWueGXpL58OsZShk4moI2S6jvR6kaZOBM
         TblSsee4/1qBKDaSshp7fRipHkcuS1If4jkHntN//Gx/tH+zgh7nB6xdQJXAAgYZplKz
         ZqDKCJHtOvr2Dzvpfc76Z7T3VHarBRFTjM9UYhiD7byQU3VPoIU1x1H7wlmS7lPAfwJd
         aQXpLvovEBOPsdu4t7kHgfS4/pKS438vlcO85g+2kvNboCgF41x/Ssa/OYOZE9ulThGN
         tYZCIGe18tI2nJUXFV2uDkpOYubJi0i4TjJDqElXazmt2i0hOWXB3AGeDIvD1jmZNraT
         rwcA==
X-Gm-Message-State: AOAM530T/FJb9ggk6y+92BO27LUrWrNEvmwHRQwhv5woVrA7/nylUGbW
        ewkorr5wrRa6t3JTl/lhVgXRXyb7NSeqpg==
X-Google-Smtp-Source: ABdhPJwlqtU7uSfeCYGvN1nvQExy/wV7HuTr5AQwMbqAdim4pHCK85P6jgay5LoWLCq5KrxylF+PZw==
X-Received: by 2002:a05:6830:1518:: with SMTP id k24mr2575590otp.366.1607062585533;
        Thu, 03 Dec 2020 22:16:25 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r4sm429763otd.66.2020.12.03.22.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:24 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 00/14] pull: default warning improvements
Date:   Fri,  4 Dec 2020 00:16:09 -0600
Message-Id: <20201204061623.1170745-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old thread "Pull is Mostly Evil" [1] came to haunt us back again.

The main solution--reject non-fast-forward merges by default--seems to have lost traction (again).

There are multiple approaches floating around, but no clear path forward.

This patch series attempts to fix as much as possible of the current situation without committing to
any particular solution.

It does:

1. Improve the current documentation
2. Improve the current default warning
3. Minimize the instances where we display the default warning
4. Add a --merge option
5. Improve the error message with --ff-only
6. Fix the behavior of the warning with --ff

And tentatively (and this should be the only controversial change):

7. Change the semantics of -ff-only

It does not:

* Introduce the suggested pull.mode
* Change the current default (still --ff)

It is not a complete solution, but should improve the current situation.

[1] https://lore.kernel.org/git/5363BB9F.40102@xiplink.com/


Felipe Contreras (14):
  doc: pull: explain what is a fast-forward
  pull: improve default warning
  pull: refactor fast-forward check
  pull: cleanup autostash check
  pull: trivial cleanup
  pull: move default warning
  pull: display default warning only when non-ff
  pull: trivial whitespace style fix
  pull: introduce --merge option
  pull: add proper error with --ff-only
  tentative: pull: change the semantics of --ff-only
  pull: show warning with --ff
  test: merge-pull-config: trivial cleanup
  test: pull-options: revert unnecessary changes

 Documentation/git-pull.txt   | 24 ++++++++-
 builtin/pull.c               | 98 ++++++++++++++++++++++--------------
 t/t5520-pull.sh              | 62 +++++++++++++++++++++++
 t/t5521-pull-options.sh      | 22 ++++----
 t/t7601-merge-pull-config.sh | 35 +++++++------
 5 files changed, 174 insertions(+), 67 deletions(-)

-- 
2.29.2


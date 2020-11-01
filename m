Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC740C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5668E208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2+uMK5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKATeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKATeF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:05 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4BEC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:04 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o13so4348472ljj.11
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUo6lEOunhjenjOeX9inqQWTBHFG6qpQfZs4YKElddw=;
        b=L2+uMK5Km5pk5WZyajDNCenIQfGLNGMaWpuxC0hFHQDLeapDn7rAPJSQ7GPrq7aCIT
         vOLHyTgBmdT2UytoW7i5xlk6kJ8a48OhBP9VFpqRyAo5MxqFulS5QFmSuMEC3D9pxbMX
         ASLpBBGUZRX5ehrbRyzF2nWMraE+c763Li+LV88R9Zss0mZoLNTPWYOaGCzU3wNSQ1Ii
         y6kZ597alIynZIv4uLtTiT20ie2HVgZ2TUMT9cA5RRYs118Ws1aSg7CMV1/dFSK/2UJk
         Uxnyj0LAe9Vje/dQ42vMoigYJ7XmHO4ataAP4zKl4mn4GhHMdROWfivZgUeriU1s0DoI
         4cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUo6lEOunhjenjOeX9inqQWTBHFG6qpQfZs4YKElddw=;
        b=M29DKtr0wZOLpZTCfFn0lxc85GLuwDWqr2xMYdJeX6hm2/vcPc2rGqj6ilMYTD0C97
         p26ANSpvDRIffBK5WuOC6Lp4hphXhVDmTPcXPp4cYbX749l2DUhOlrJiGYFBp9kwLF0u
         mwOu1VJz+Z3nGAy3jk3GMmpOGhtBPK28bI9ssAFroKAC3uddqQc7pfjJbw9DIMkuT7h1
         1eSlVAYCvB20F0a7e+JTRv745l9XCeWMrHbttbai1wntjeknEplafF1ui5iqZxgM6uoX
         /NLBlY4DycM9KhOgXhCQw8jEX67qRaibVqyXCEz1xFH8L8SkeQA0V2cG3Ro3Xe+BTpgs
         K4sQ==
X-Gm-Message-State: AOAM533gplET7+01Xb2pRFcOH9e18FG3hqxQSmrF+goGxukK8T8Kngjz
        NM6yE2JbaXFkYm/RKLaQiA8=
X-Google-Smtp-Source: ABdhPJzZoL8YTdFp3l6swNpNMh8EtquN1p487bBpoP4um/3Ff1RRWH0K/2H5ecSVEUjlzPFdzJSR+w==
X-Received: by 2002:a2e:894a:: with SMTP id b10mr5360051ljk.159.1604259243270;
        Sun, 01 Nov 2020 11:34:03 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:02 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 00/26] git-log: implement new --diff-merge options
Date:   Sun,  1 Nov 2020 22:33:04 +0300
Message-Id: <20201101193330.24775-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patch series implement new set of options governing the diff output
of merge commits, all under the umbrella of the single --diff-merges=<mode>
option. Most of the new options being synonyms for -m/-c/--cc options,
there is also additional functionality provided, allowing to get the format
of "-p --first-parent" without change in history traversal that
--first-parent option causes.

The net result of these series are the following new options:

--diff-merges=	 |  old equivalent
-----------------+----------------
first-parent     | --first-parent (only format implications)
separate         | -m
combined         | -c
dense-combined   | --cc

The series also cleanup logic of handling of diff merges options and fix an
issue found in the original implementation where logically mutually
exclusive options -m/-c/--cc failed to actually override each other.

The series start with the set of pure refactoring commits that are expected
to introduce no functional changes. These are all commits up to and
including:

"diff-merges: revise revs->diff flag handling"

The aim of these commits is to isolate options handling for diff merges so
that it could be easily understood and tweaked to ease introduction of the
new options.

Then the fix of -m/-c/-cc overriding issue follows, starting with a failing
test and followed by the fix.

Then follows a little bit of additional refactoring in order to prepare for
introduction of the new options, and finally the series are finished by the
implementation, testing, and documentation update for the new options.

Sergey Organov (26):
  revision: factor out parsing of diff-merge related options
  revision: factor out setup of diff-merge related settings
  revision: factor out initialization of diff-merge related settings
  revision: provide implementation for diff merges tweaks
  revision: move diff merges functions to its own diff-merges.c
  diff-merges: rename all functions to have common prefix
  diff-merges: move checks for first_parent_only out of the module
  diff-merges: rename diff_merges_default_to_enable() to match semantics
  diff-merges: re-arrange functions to match the order they are called
    in
  diff-merges: new function diff_merges_suppress()
  diff-merges: new function diff_merges_set_dense_combined_if_unset()
  diff-merges: introduce revs->first_parent_merges flag
  diff-merges: revise revs->diff flag handling
  t4013: support test_expect_failure through ':failure' magic
  t4013: add tests for -m failing to override -c/--cc
  diff-merges: fix -m to properly override -c/--cc
  diff-merges: split 'ignore_merges' field
  diff-merges: group diff-merge flags next to each other inside
    'rev_info'
  diff-merges: get rid of now empty diff_merges_init_revs()
  diff-merges: refactor opt settings into separate functions
  diff-merges: make -m/-c/--cc explicitly mutually exclusive
  diff-merges: implement new values for --diff-merges
  t4013: add test for --diff-merges=first-parent
  doc/git-log: describe new --diff-merges options
  doc/diff-generate-patch: mention new --diff-merges option
  doc/rev-list-options: document --first-parent implies
    --diff-merges=first-parent

 Documentation/diff-generate-patch.txt         |   6 +-
 Documentation/git-log.txt                     |  79 ++++---
 Documentation/rev-list-options.txt            |   3 +
 Makefile                                      |   1 +
 builtin/diff-files.c                          |   5 +-
 builtin/diff.c                                |   9 +-
 builtin/log.c                                 |  18 +-
 builtin/merge.c                               |   3 +-
 diff-merges.c                                 | 120 +++++++++++
 diff-merges.h                                 |  18 ++
 fmt-merge-msg.c                               |   3 +-
 log-tree.c                                    |  17 +-
 revision.c                                    |  38 +---
 revision.h                                    |   7 +-
 t/t4013-diff-various.sh                       |  10 +-
 t/t4013/diff.log_--cc_-m_-p_master            | 200 ++++++++++++++++++
 t/t4013/diff.log_-c_-m_-p_master              | 200 ++++++++++++++++++
 ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++
 18 files changed, 774 insertions(+), 100 deletions(-)
 create mode 100644 diff-merges.c
 create mode 100644 diff-merges.h
 create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
 create mode 100644 t/t4013/diff.log_-c_-m_-p_master
 create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master

-- 
2.25.1


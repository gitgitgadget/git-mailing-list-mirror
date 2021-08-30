Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A45C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027C260FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhH3HXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 03:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhH3HXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 03:23:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96FC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:51 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x5so14997918ill.3
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tJKC3EGRfiObSqyf2wNkwJWMSuIFUIKLPajWkV0tBQ=;
        b=Akl5218gShcwa5RHDslMwkMNU4jpcXToAJA5e9qAYJKntQqK21TA/mVIGS+FrcL2by
         CSGCrfBBx5pQxRQcoN6yVvCmU9SzTqO/LN5cIG0vF0Wq+4j6PIiWYW5r0Uy2zDpcdZ6u
         SN5dFvsuNPWvO4niEmzvR+NVjHZzFDwDRqDaPs450wXFnJujVAip4EJKJ4EpBmcQx6aX
         CG3Zms2xD1UjsYrZUphS/0r+qdHx4mHBuVjN6/IvAnemNfPLNMWy3dWnxzRbMpRZeJi7
         k//rQjS/Su1E4PPu5SnOTSfGOwReIcWBMy82EYKqgPMdss/FMoOlamR+UhyQRRY0rMLH
         vcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/tJKC3EGRfiObSqyf2wNkwJWMSuIFUIKLPajWkV0tBQ=;
        b=n6diNwSJUtG0J3EvYe84/0TFQwngAeyU5fiLtZfx74wxchFLqRA+M8lbkk/MfjobaS
         gtVOSiFD5ysEIhuZrxi2Q1KSIoaNy7Rjm1Xaemnds3PsLcYl7rCtS8DOC3IeSUmNaa/h
         6RUzt4XFwnMu/70yFz1+8Mk9oQyF4yGHqjFKKVQcERKiJEFIKELRh4faoXI8JakDs8iQ
         xJVl1J5i1rYTlP1yhWUDi3qCAiIBovOhp7P+HUkhF2UAQ2BKf5QjMkweZw5GKiIsp9SQ
         Sl6arA74HLQ+YTv4LD0Q1/yH/1K6vVHddgWg3OCU4Vp80ucUZ6wX2wAy5Cd35J1/+wiI
         toug==
X-Gm-Message-State: AOAM533uEi85DkGpR9Cg7FlQqIylphN4whevzc87CXxfp/qqPxmmc2C4
        UO/HyiJ9sU/GPF+bljDwoiteWUsXxwo=
X-Google-Smtp-Source: ABdhPJxjQehhnjXW1/cqxnUGVyfe3u7bifwjnjvvghovbdBWRwN9Z3lq8A5qSq/uDcipgCKL3CcU2w==
X-Received: by 2002:a92:d94c:: with SMTP id l12mr15038467ilq.101.1630308170425;
        Mon, 30 Aug 2021 00:22:50 -0700 (PDT)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id a6sm7903840ilb.59.2021.08.30.00.22.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 00:22:49 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] suppress trailing whitespace on empty "notes" lines
Date:   Mon, 30 Aug 2021 03:21:15 -0400
Message-Id: <20210830072118.91921-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes a problem in which `git format-patch --notes`
and `git log` unconditionally indent _all_ "notes" lines, including
those which are empty, which ends up leaving (unwanted) trailing
whitespace on the previously empty lines. The first couple patches
adjust some existing notes-related tests -- which undesirably hard-code
those indented blank notes lines -- to be less brittle since they would
otherwise break by the change made in the final patch which fixes the
actual problem.

Eric Sunshine (3):
  t3301: tolerate minor notes-related presentation changes
  t3303/t9301: make `notes` tests less brittle
  notes: don't indent empty lines

 notes.c                      |   2 +-
 t/t3301-notes.sh             | 321 ++++++++++++++++++-----------------
 t/t3303-notes-subtrees.sh    |  13 +-
 t/t4014-format-patch.sh      |  17 ++
 t/t9301-fast-import-notes.sh |  36 ++--
 5 files changed, 207 insertions(+), 182 deletions(-)

-- 
2.33.0.153.gba50c8fa24


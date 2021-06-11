Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83519C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FDA610F8
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFKUaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFKUaU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 16:30:20 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E46C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:28:21 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w127so7046058oig.12
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0M+npTlnpqALwyeSQhg7Zxc/jvy5vgCSIaToCOjZ09s=;
        b=T8UJ/acA0viQkQotBlgoxqwVfChE/DG7kzD9PJP9DVdwyP4vXSaI5pU4xTJLCJp/1B
         mrxoAuHUiJHRhHK8ewVyqH4MZ0a/OAYEAMetXJ0NdlCG227oRFR7VYjc6elza9TsgpUL
         1uSp1Kzk/S/6dR/HzT9HdDI6NK1cNp3bwC3JD3rFp0fazREw5E8cTW563pE4VK7jBR8H
         /pSsaoJh0nN2xEnbXLoU/QeSEKTgktDmEXPg3/mPfaPgB6A0qOig25ExkDXo4ejLXKqO
         HUqZGHCP6SyTPMyegoWf1p6B/mits2komtOHJ4Zgb/ZELQJYasO77rAjZW5YPVrggwdd
         Cd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0M+npTlnpqALwyeSQhg7Zxc/jvy5vgCSIaToCOjZ09s=;
        b=RSjGv3YzAUBnBHqI3d0feItoygVrBlIIDutQXFL+38LoHbMrfpkWZ2nvfzNiM5R5Hm
         F2UmS6hMUyprIDR4EMi/6gVNRNre+JOtRlaWtwXGmkGdfGjwnNT3r6k7mq08aUzLZkuG
         xeyzqUhrsRT7sQjyI+7/ywKu9a/u6OWvEixOJ/UygszXxt3is/r/MjfiXfssC2I9ESmc
         mx0fCwiucdNRNWQDlfmcdi1VijQ0lwLUev68XUqRhONT76Ra2PjwU6EIjcy9dM4FMg0Z
         hicYDpadWIjc1MolOL6MAVYLWNY4w47dOhScDRXbOX/A1x6Wh6YIJbkHG2YT+ECE7E81
         USXA==
X-Gm-Message-State: AOAM533K3IVsH9BK9X+ig+AHJm2G4tBrEcj7C6D81PKx87HUGn6C4oMD
        czj0/sRxZ3grJTFPwolhlPjo+gu9EEdzxw==
X-Google-Smtp-Source: ABdhPJwzxeRNbhBBqazjoPT8xssfn8A38IO7zr/zE+qo5AVuJvv3GGnt1lE1FaXBcIuJ6h31LQPl9g==
X-Received: by 2002:a05:6808:319:: with SMTP id i25mr2248324oie.95.1623443300974;
        Fri, 11 Jun 2021 13:28:20 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c11sm1375149oot.25.2021.06.11.13.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:28:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] Avoid gender pronouns
Date:   Fri, 11 Jun 2021 15:28:17 -0500
Message-Id: <20210611202819.47077-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest solution looking for a problem [1] is to use the actively
debated among linguists singular "they" [2].

Leaving aside the linguistic intricacies that not all singular "they" are
equal [3], and the overwhelming sentiment that these kinds of political
discussions don't provide value for this community [4], the "issue" can
be easily solved by simply using different wording.

  - The reviewer herself
  + The reviewers themselves

Problem solved.

Cheers.

[1] https://lore.kernel.org/git/pull.975.git.1623085069.gitgitgadget@gmail.com/
[2] https://www.theatlantic.com/culture/archive/2013/01/singular-their-affront-good-writing/319329/
[3] https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they
[4] https://lore.kernel.org/git/87wnrooa17.fsf@evledraar.gmail.com/

Felipe Contreras (2):
  doc: avoid using the gender of other people
  comments: avoid using the gender of our users

 Documentation/SubmittingPatches | 5 ++---
 Documentation/git-push.txt      | 4 ++--
 Documentation/user-manual.txt   | 2 +-
 commit.c                        | 2 +-
 config.h                        | 4 ++--
 date.c                          | 2 +-
 pathspec.h                      | 2 +-
 strbuf.h                        | 4 ++--
 wt-status.c                     | 2 +-
 9 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.32.0


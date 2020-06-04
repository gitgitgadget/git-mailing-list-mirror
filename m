Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A241C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06AC22072E
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0a3mtOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgFDH35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgFDH3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 03:29:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038CC03E96D
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 00:29:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fs4so777902pjb.5
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=byd0gGNYcZs5Lu1o1LS8Bip8Y2M2F0v2LBuZ4W7/qG8=;
        b=Y0a3mtOA9wPbjWh4fpEItRIIwphFA6btw49PYxmn0z047fLsBfRj/TJiRVfsjN1GJl
         da14wNt9UjJxwqT+TgrVbMAlo4DHCteXu09W7Y0DNbL4WIeDkktIX/hYnWc9JAZUYIy7
         7/XMH2ZDJmb5GQLXq9puoakdlKdcOOMjvYsao/XrgYnaiX/7tsSkqcjs3S/3YHa6QdKd
         ykcFPDpGULI4HWPqnSjdL1igZ/EBbeDhmAYhQE6Hfex9grbT0i63V+9rLDWseDIT9ur6
         uGmggWyHcV9nukr2VW6dnLcnVM42t9laBa0M7zAq+srdxsYS/00yKwxVBGe7ri2E77vr
         XmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=byd0gGNYcZs5Lu1o1LS8Bip8Y2M2F0v2LBuZ4W7/qG8=;
        b=Q4fbkmqHxSfCHJDJhMXCHtmCiJCnG0fPCUurEQUxmRS43cNCgCPQ27qqD0la9HvQZd
         DLOjZPEVgVdtk1OzlHJUnwVrzGXjwlNy7KKUql8zYwQM8Jz0kHjgmqChW/0GvkslS/Ve
         HFvX9a7yjUIZtD+sCLkD7xiFKm21xaTAHdC+a9gdLhcyDSQmv05ufO87KnCXDm6ysW0w
         A7tOcLtSxVTCxH6oj3vtAmmnYj6LyKZfnbGm4TnqCi6uGgiVRJbflpF4nxvgsE0jCE6p
         8wYJy8mY+JK4NPiwEqLHPsCNUJrXefXp5Iv+qjeadkO3FOq0Eiu3RyaVQOAo2m7e0eu1
         L0uw==
X-Gm-Message-State: AOAM533pi++rSqnoG494PQTXgy15WL2k72KFz+8amQeSuyoM+ONvncpF
        NbMeui6YAnkZeqH6YKWNoYhf4mUX
X-Google-Smtp-Source: ABdhPJzBQpigpZVX6wrvLvIuG3Zp8O4HN9oXgmr9hspAm43G38Jn2IdCzFI9kKedGoABqTE2mtMdNQ==
X-Received: by 2002:a17:90a:8d11:: with SMTP id c17mr4433562pjo.201.1591255787644;
        Thu, 04 Jun 2020 00:29:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:4064:2480:9552:2003:1696:484d:e269])
        by smtp.gmail.com with ESMTPSA id c12sm3335108pgt.91.2020.06.04.00.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:29:46 -0700 (PDT)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSoC Patch 0/3] Move generation, graph_pos to a slab
Date:   Thu,  4 Jun 2020 12:57:56 +0530
Message-Id: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The struct commit is used in many contexts. However, members generation
and graph_pos are only used for commit-graph related operations and
otherwise waste memory.

This wastage would have been more pronounced as transistion to
generation number v2, which uses 64-bit generation number instead of
current 32-bits.

The third patch ("commit: convert commit->graph_pos to a slab",
2020-06-04) is currently failing diff-submodule related tests (t4041,
t4059 and t4060) for gcc [1]. I am going to send a second version soon,
fixing that.

[1]: https://travis-ci.com/github/abhishekkumar2718/git/jobs/343441189

Abhishek Kumar (3):
  commit: introduce helpers for generation slab
  commit: convert commit->generation to a slab
  commit: convert commit->graph_pos to a slab

 alloc.c                             |   2 -
 blame.c                             |   2 +-
 bloom.c                             |   6 +-
 commit-graph.c                      | 116 +++++++++++++++++++++-------
 commit-graph.h                      |   8 ++
 commit-reach.c                      |  50 ++++++------
 commit.c                            |   6 +-
 commit.h                            |   6 --
 contrib/coccinelle/generation.cocci |  12 +++
 contrib/coccinelle/graph_pos.cocci  |  12 +++
 revision.c                          |  16 ++--
 11 files changed, 158 insertions(+), 78 deletions(-)
 create mode 100644 contrib/coccinelle/generation.cocci
 create mode 100644 contrib/coccinelle/graph_pos.cocci

-- 
2.27.0


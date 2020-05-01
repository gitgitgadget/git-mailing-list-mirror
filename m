Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE038C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2E20643
	for <git@archiver.kernel.org>; Fri,  1 May 2020 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkNGPf9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEAI2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAI2y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 04:28:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE846C035494
        for <git@vger.kernel.org>; Fri,  1 May 2020 01:28:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h124so8575283qke.11
        for <git@vger.kernel.org>; Fri, 01 May 2020 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Khlg2zZ9hEOC9hxrFnQWyFD1fmXzBO/5+mTX298o2o=;
        b=tkNGPf9L0mudfQe0JZMh4uRmCTbfJp8nHLAZGGuT9Z5D35ry8F1OhJIjOuYgcG+M+R
         H97Sbrp1ypPuq9APgU4TFOC+KsNMOicZwsmb3DBLUifmOxsDa2FoRecAJJAp7KcYJNg5
         1B2UzNRmsi3yHxuibDzSZm3VTPIke6/nHPGdmqrpd/QHnu9CW9SWlgONGYwdWih6esQ0
         y+cE38BsOZzgwbcGqLmZq1mRKeod9W1zGVs/X4H2GN5Cb6L0V4YfSKgyVyAKeqDTs9PX
         xLde4PxP7UMPZ4GqTdxM2fuq1U/MqQGae/4/Rfz08KJrmFQbZ4Kb38VMDFdCyQnht6zL
         0Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0Khlg2zZ9hEOC9hxrFnQWyFD1fmXzBO/5+mTX298o2o=;
        b=UOqmLXEHt1zyuAR0HhZZzTkC2oSsVDRFaxnwRzcVVO/lfv9Q6qp/7qDce25TCf9x8c
         tCJvD/H5Au4u7qLI5cgAt+6zOy9k+g9ugdsPwzh3fetJPx7fls8hn0vnP8ZrGpXDfcC1
         SNHYRcCqEiI2I5eHDyl9vpx6twD6NfEapchQxbYn+InedLvOrLoFa7PIN9AmnIwXj9aa
         ja1woOk8utXcF5Pqjl7VlAJWFmL9QF9cSVAUSPcO+yXezIjSclipvggLMNB9kVFYboce
         OGc9VBeHJgdH7ntNbndF4Ocrc2pN2mcqkrijbLZLCeM/Jr80CXcWovY4BdBF+hfRgLzL
         F9QA==
X-Gm-Message-State: AGi0Puaxp7IYp2PbL5de6kieV7iWZj1E52kAohvgoQ7hpRteAoLva/dM
        1OappdNXr4CllHwxjgLk2zNKwNPc
X-Google-Smtp-Source: APiQypKhW1m2/3TYUogBc5hA+WjOjEYzh+2nd7ogLyIIXk1XFJhUMs/32A7cWZM7rWZ4b0dlLGtW0g==
X-Received: by 2002:a37:61cf:: with SMTP id v198mr2267237qkb.485.1588321733427;
        Fri, 01 May 2020 01:28:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id 70sm2258138qkh.67.2020.05.01.01.28.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 01:28:52 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Harri=20Meht=C3=A4l=C3=A4?= <harri.mehtala@finago.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] enhance "git restore --worktree --staged" behavior
Date:   Fri,  1 May 2020 04:27:44 -0400
Message-Id: <20200501082746.23943-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series addresses a shortcoming or two when git-restore's --worktree
and --staged options are combined. The first patch tightens the
implementation to match the documentation. The second patch loosens the
documented restriction by adding a bit of DWIMing to make it more
convenient to combine the two options.

Although the second patch effectively throws away the changes of the
first patch, I kept them separate in case someone comes up with a good
objection to the new DWIMing (which escaped me), in which case the first
patch can be kept and the second thrown away.

Eric Sunshine (2):
  restore: require --source when combining --worktree and --staged
  restore: default to HEAD when combining --worktree and --staged

 Documentation/git-restore.txt | 13 +++++++------
 builtin/checkout.c            |  6 +++---
 t/t2070-restore.sh            | 11 +++++++++++
 3 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.26.2.526.g744177e7f7


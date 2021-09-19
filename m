Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002FFC433EF
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04A261004
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 20:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhISUkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhISUkD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 16:40:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9054C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 13:38:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n2so7091276plk.12
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/yR0WWj3vqTzVyeoUyHH2du3l2TWZ3ytgQwKnPCalc=;
        b=juG2OypXg20WSRtATYyNVI9SLGPOJ1PWR34FTOjGl6y+O1+V5cAdjVKtT1rmAV9htW
         kRaj8CAxJyILQYBXtb37RiAQ8OOiGW6dD/O2fptRvuXrDAxHLd8S39++Q/hjPIprAM43
         fbB1xEbdyLyXhypiN0NFk8roGW7uRC02tXVWVOqqy4GM4/zGLJiAmpin/Y0FMP+f2ApM
         DKzFnCrDkfxVxllRU60BZ7UJwLfAw50+3uW9dECHU3xputKch2aOdcxY59bB7TEEO15C
         /6mml9W5arFHvrHprTW/19mxXJa514RB60gcsz1cH+8R97C30CCo+ENjBAQdtVnjr862
         ahWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/yR0WWj3vqTzVyeoUyHH2du3l2TWZ3ytgQwKnPCalc=;
        b=B2G0xOSVL6xOtnGFulCP9hnLTItNYuZ9PVBn+yMT0eEA5BTuskXI/zJULzeiGvVaSY
         6jSBYmO2mPiOpxGTFT0GjuGkg1ZBSKbUZxFm6keNZGenTFjMthqo2+QCc3T4xg6u1Ep3
         QMEtVy1tBo5UH/gQ8nfzwoILlnGkzqh/y3pSJOT82+d2OpPKkAWOP9Q/fdvolVPE9kVu
         4L7DVfH9cDWzI73V3HJbwRKAgLziQsO73uGQL3D/nY5hE6o3mSFedlveUxGQcXvmx1pp
         bzphxJNouFJ5cX+4YdgUENJ3Z9x6YlONI0T1mQmwr5bIJPYZF+A7huh9iognTmhkQXgx
         Vo6g==
X-Gm-Message-State: AOAM532Pct6o3xJ3xiZ5htQkaIyenAnm5EO8T4eO/SIZS/7qh6hG3Efm
        F7UPkOVLOkCVHts0tohbGXU=
X-Google-Smtp-Source: ABdhPJw2xloxscaXE4ebT6ofoXXj7LdftEMFTM7Yj3fsPxWcfPmJH0F21L1z+BHifL/GTaCnt1v2mQ==
X-Received: by 2002:a17:902:d492:b0:13b:7935:d990 with SMTP id c18-20020a170902d49200b0013b7935d990mr19613997plg.7.1632083917290;
        Sun, 19 Sep 2021 13:38:37 -0700 (PDT)
Received: from sarawiggum.fas.fa.disney.com ([198.187.190.10])
        by smtp.gmail.com with ESMTPSA id v4sm12132073pff.11.2021.09.19.13.38.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Sep 2021 13:38:36 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 0/3] difftool dir-diff symlink bug fix and cleanup patches
Date:   Sun, 19 Sep 2021 13:38:29 -0700
Message-Id: <20210919203832.91207-1-davvid@gmail.com>
X-Mailer: git-send-email 2.33.0.720.g5b0b3ce580
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes a regression in difftool that can lead to data loss.
The symlink-file writing in difftool's dir-diff mode has been fixed to no
longer write-through to the symlink targets.

Please consider patching older Git versions with the fix from 1/3.

Changes since last time:
- This series has been reordered so that 1/3 is the patch that fixes the bug.
  The subsequent patches are cleanup.
- Patch 1/4 from before, which removed the tmp test repos, has been dropped.
- Patch 1/3 was updated to not remove its tmp test repo.
- Patch 1/3 was updated to consistently use "echo" in its tests.
- Patch 1/3 was updated to fix a "syminks" -> "symlinks" test comment typo.
- Patch 2/3 was reworded to improve the repeated slashes justification.
- Patch 3/3 "add a missing space to the ... comments" is unchanged.

David Aguilar (3):
  difftool: fix symlink-file writing in dir-diff mode
  difftool: use a strbuf to create a tmpdir path without double-slashes
  difftool: add a missing space to the run_dir_diff() comments

 builtin/difftool.c  | 32 ++++++++++---------
 t/t7800-difftool.sh | 75 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 16 deletions(-)

-- 
2.33.0.720.g5b0b3ce580


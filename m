Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A627AC07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8601D6115B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356074AbhGSRa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380072AbhGSR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D622C0617A9
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so23136713wrw.5
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EEewG4YRoL+SnpurObv/agrEEUJHxMXhN9m+5eSTKHU=;
        b=rf4Ra3/+x/hAhG5KfL/2PxSwQJFkqmQc32vd5DtFHQRvp/+ZreIx6GnoniuV+yQepj
         IppI0dZvOcbaR0y3AHB8JoGsy7Z1Hhuy7mqRS51E55te3z0x/mybTP0kCPMqu65zsf/h
         UjHhUUO3mIxR0qYWmFmxnv8/tlKN+Opl8yM+/xyiteetFDJm+QGw7WzOFACmYETXjcy9
         zbtsqHeYN0gdqojJikYPCVZ3TkLZFnj9EN0jycl/WF413fJOThrEkOOBThTFOUho5UXh
         Yx8+Uuzcs8Ee/NFLy3l6lBWlcmYGrUTP/LpqiuCHSWW1T9p8bmgkIYgVeDI/TOqdEDSI
         hGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EEewG4YRoL+SnpurObv/agrEEUJHxMXhN9m+5eSTKHU=;
        b=EIuQ8z3dTda34SQvfCB2gMLlbATidevKdAX8QBTlKNdIMutdbsawflYPzVKO820NWU
         oYN0+s12KTmfRJS5hZ4kBUkkWInW0nUSM2mHZ1riKH/rPf9pacz2pqtN/R5D68sJG3BG
         0ET40HHVGK0PBVnbORESY1ehOQ5S09mqWdBn2T6UURjwl3MacffE+tR/UWSh93J9aW97
         ORH+zG92hrcgYx5PibqAf87s0dPugFLUj59UQTTIQ4Jhe5VlEryITi3LhJ/wQESpULEs
         R7Bq3Ol+Q2vZor6QmyguWn95jXFttFs/CGSs4RPuqSF20mZTgqgEfFOYIFNO3Xbf2MHm
         20Jg==
X-Gm-Message-State: AOAM530+YClMA0TlnitxdLxxXWwj8AIUhapoK/X7svtUjTZORpyiUw/y
        yNFND+XDVl8XKBessRkiPxcRKqEPdjk=
X-Google-Smtp-Source: ABdhPJz7ZhVJPcoosXziBlTh6rBAytFS7VxOQvd9qs7lTRCy6x7ilY2LW9FEXhz9qfBASRHvZMjtyQ==
X-Received: by 2002:a05:6000:1886:: with SMTP id a6mr15237951wri.17.1626718051527;
        Mon, 19 Jul 2021 11:07:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm20228970wrt.89.2021.07.19.11.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:31 -0700 (PDT)
Message-Id: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:24 +0000
Subject: [PATCH 0/6] Fix direct filesystem access in various test files.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a few test failures in the reftable series.

Han-Wen Nienhuys (6):
  t6050: use git-update-ref rather than filesystem access
  t1503: mark symlink test as REFFILES
  t6120: use git-update-ref rather than filesystem access
  t7509: use git-update-ref rather than filesystem access
  t3320: use git-symbolic-ref rather than filesystem access
  t2402: use ref-store test helper to create broken symlink

 t/t1503-rev-parse-verify.sh      |  2 +-
 t/t2402-worktree-list.sh         |  2 +-
 t/t3320-notes-merge-worktrees.sh | 12 +++++++-----
 t/t6050-replace.sh               |  2 +-
 t/t6120-describe.sh              |  6 ++++--
 t/t7509-commit-authorship.sh     |  4 ++--
 6 files changed, 16 insertions(+), 12 deletions(-)


base-commit: 75ae10bc75336db031ee58d13c5037b929235912
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1052%2Fhanwen%2Ftest-fixes-v3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1052/hanwen/test-fixes-v3-v1
Pull-Request: https://github.com/git/git/pull/1052
-- 
gitgitgadget

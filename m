Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8ADC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AF621527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttZSeHld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbgJWQB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464808AbgJWQB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:01:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A04C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so2222366wmi.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=evTSpWUmPYVHU/AdwAv7ryIWZaIVz+umoMNQEqbBQXo=;
        b=ttZSeHldsMO1VStu+iPyH1znFNjvAYXrYDcpEfvCuXSLadTuTgtRP4LU1M42lexYg6
         U7uh1P5UDNGzeoHmamgJ8Y9HNxpTWzBbd/Gx0a91XmJwU/iRzWDjZ3Dch495tVMdUyAi
         Vc6oouiuytTbboY07FkbE9U8yths0C7T/GeNZ1vyXrsZlw/gpoWTlxNXRjlFtQKqCK5L
         +Qz+3UvvQ4/lXi45UoqQyzqZcdV9jQEqQDirwLg+A3G/pj1YI0+MTcyefSNSg2BPzLYY
         NUeL1s6vF3zGgcLfcC3/Jb//SsIVBrPwma5UaOA+0AeW0/5s6yhCJGHCn2XJLMmTQJGj
         Ubpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=evTSpWUmPYVHU/AdwAv7ryIWZaIVz+umoMNQEqbBQXo=;
        b=FyLXabZlB6poqSGPMZjYGlQ6vtYlcVm51YznAA2JVxOgteTotpoU1rtbxhDL8DMP1j
         v1iNofYPwAXxL22WKLw/6mfFL4rMO6jQXYyxPElUsLvmsGHTWXFVCcbwFFfAFI0k3eEe
         xQHfB79tyct6jNHCej5ImQXP8Iwo4t5TnSqd86IPiDkUAfcCHek5tJuVDGlbDR44QNfG
         SZP4OIbMAk396wMEPkAJrPGSXE7W27zIa4VOoJ3Q7Vl4Wn6h7BHY3chvrcW2V5maPwT3
         StZWS1IID8fjGslEdN4QGo+5xyLZ1xi5gUDadwx3TEjhB2NZGNA2f39fzW+8xGjnlVSR
         lF9Q==
X-Gm-Message-State: AOAM531rll+dZzrSJPN6j9D3ZpMNqukdjVTkIDxeDVPu5faPIGEsd+cm
        JeIqEYWe8HgJVUKJb3h2KX0xSI3helU=
X-Google-Smtp-Source: ABdhPJx2DZgfNDaod1tZXvD3wWBns/rcATSgSZ1RfrT9FeNoAD73GfNMRQ4ajXNdRhESKznoBZr+uQ==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr2897531wma.3.1603468886262;
        Fri, 23 Oct 2020 09:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4sm4092599wrp.47.2020.10.23.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:01:25 -0700 (PDT)
Message-Id: <pull.769.git.1603468885.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 16:01:15 +0000
Subject: [PATCH 0/9] Support both merge backends in the testsuite, via environment variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series builds on top of en/dir-rename-tests. It can be applied
independent of my "new merge-ort" API series I submitted a couple days
ago[1], but this series uses the same environment variable as patch 4 of
that series. [Also, if gitgitgadget emails more than 8 patches, then my
attempts to use it to send out a patch series based on en/dir-rename-tests
went wrong.]

As promised, here is a series that makes the testsuite changes needed to
simultaneously support both merge backends, keyed off a
GIT_TEST_MERGE_ALGORITHM environment variable setting.

NOTE: The tests do not yet pass with GIT_TEST_MERGE_ALGORITHM=ort, because I
haven't submitted the implementation of the merge-ort functions -- yet. I
figured they are useful as a high level overview of the differences in
behavior between the two backends, and thus am providing these before the
implementation.

[1] 
https://lore.kernel.org/git/pull.895.git.git.1603286555.gitgitgadget@gmail.com/

Elijah Newren (9):
  t/: new helper for tests that pass with ort but fail with recursive
  merge tests: expect improved directory/file conflict handling in ort
  t6416: correct expectation for rename/rename(1to2) + directory/file
  t6404, t6423: expect improved rename/delete handling in ort backend
  t6423: expect improved conflict markers labels in the ort backend
  merge tests: expect slight differences in output for recursive vs. ort
  t6423, t6436: note improved ort handling with dirty files
  t6423: note improved ort handling with untracked files
  t6423: add more details about direct resolution of directories

 t/lib-merge.sh                         |  15 +
 t/t6400-merge-df.sh                    |  14 +-
 t/t6402-merge-rename.sh                | 122 ++++-
 t/t6404-recursive-merge.sh             |  14 +-
 t/t6416-recursive-corner-cases.sh      | 200 ++++---
 t/t6422-merge-rename-corner-cases.sh   |  37 +-
 t/t6423-merge-rename-directories.sh    | 704 +++++++++++++++----------
 t/t6426-merge-skip-unneeded-updates.sh |   3 +-
 t/t6430-merge-recursive.sh             |   3 +-
 t/t6436-merge-overwrite.sh             |  18 +-
 t/t6437-submodule-merge.sh             |  25 +-
 t/t7602-merge-octopus-many.sh          |   4 +
 t/t7610-mergetool.sh                   |  32 +-
 13 files changed, 805 insertions(+), 386 deletions(-)
 create mode 100644 t/lib-merge.sh


base-commit: c64432aacda9054459ce550eca95929897c301bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-769%2Fnewren%2Ftests-support-both-merge-backends-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-769/newren/tests-support-both-merge-backends-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/769
-- 
gitgitgadget

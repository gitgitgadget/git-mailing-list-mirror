Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC9EC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F34E20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRumEyw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHRMSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgHRMSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 08:18:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C6C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 05:18:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so18061880wrm.6
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=C33iccOWB+LmI7pWzHnUcLmYyftgjtyVYMaI00iJPDw=;
        b=VRumEyw/4BaYN9Tb1qC8dnIlFBcpNheS0imKAcwCofg3dQLnPtjbShl40RbBkcwv0u
         8eCZ4EfFJTHm0vKSA8N6/8tMi1qrs7yRfBwxzXogy+vQ9kTBuC0ZBozImtFUy6PO/P53
         RE0gBzB9D68RE3DHW2ZEpKb1Gb048bwipBjAIkKLoUa1swCxZjsbUgI8kO2b3ngaNKZY
         Af4q2Mng20K+ZxYVmkI4UO0SboAZhQe0ce9PeyAS8vi2arhrQARbe848MU9S5t/oTYVD
         SSDpLTgIHyTJcoo2ZaHc1U5uptlPQBzVZOOtdVjWsJkGmeA1drsnSMjSTIiNgVsbHIZB
         plMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C33iccOWB+LmI7pWzHnUcLmYyftgjtyVYMaI00iJPDw=;
        b=oqQSeLWyVnJTHiAiTSdOd62J9bP6K1Zq6r5HgJVIYqjD6dE9ae+4t6e5eU1Uyv52Me
         N2yEZmt2KQZ16yjncnE5LWosYbpKiCEg67qwblNtGdcORnGz5ic9yGAq0TkGcQzxazh9
         NhBD92Ohr7Ruu0XisCKE8TXbdd4E22auPTlYVgWEsVk8h1Q3VZSz1FoKI8Br2ZX0tLHG
         GvP0DOazmHE9Z/taBX3BcRXYM779M//Uy291CVgBijzPMIoaH/HnqC6PYRk78l0E6wD0
         Ubcy+UAvpRchOJNG9cG1HTXQhO357SWb5RdNCOWUQFeVWbm1s0OjaUiPVvUgRk+7oX2d
         0LMw==
X-Gm-Message-State: AOAM533JrGcKasD574UVSi+hjwMyNH4roBmPzCmYOwraW8pSPuCp///f
        8v7BAxesGmhZOg3QhySZcVf7i2i9Fpg=
X-Google-Smtp-Source: ABdhPJyfxV6XilQKCs8s0tXLgCENQ/IxPFPuK0qDB6xWOsAFdgsIDPjfXad74bSSAnpLVM8gF2vByg==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr21505791wrg.254.1597753077162;
        Tue, 18 Aug 2020 05:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b77sm2234545wmb.3.2020.08.18.05.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 05:17:56 -0700 (PDT)
Message-Id: <pull.706.git.1597753075.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 12:17:52 +0000
Subject: [PATCH 0/3] Use refs API for handling sundry pseudorefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the handling of CHERRY_PICK_HEAD and REVERT_HEAD to use
the refs API, as a preliminary refactor for reftable. 

No functional changes.

Han-Wen Nienhuys (3):
  Make refs_ref_exists public
  Treat CHERRY_PICK_HEAD as a pseudo ref
  Treat REVERT_HEAD as a pseudo ref

 builtin/commit.c | 34 ++++++++++++++++-------------
 builtin/merge.c  |  2 +-
 path.c           |  2 --
 path.h           |  9 ++++----
 refs.c           |  2 +-
 refs.h           |  2 ++
 sequencer.c      | 56 +++++++++++++++++++++++++++++-------------------
 wt-status.c      |  6 +++---
 8 files changed, 64 insertions(+), 49 deletions(-)


base-commit: 2befe97201e1f3175cce557866c5822793624b5a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-706%2Fhanwen%2Fstray-pseudorefs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-706/hanwen/stray-pseudorefs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/706
-- 
gitgitgadget

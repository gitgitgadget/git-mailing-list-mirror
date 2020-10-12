Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185FFC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9BF20878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 23:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKimVUgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgJLX0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgJLX0I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 19:26:08 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F9C0613D1
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so21458943wrp.10
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i93HAMYtcSP4u8Uv0bFm7VUYocqbCMfLSgFR4CyGCj4=;
        b=WKimVUgtZLIRCz6lSUaVz3Qu1o3dJRSm+5bGNzSDTVMbWD8mOGX0QwuS7RWqqVDxNH
         wDbVszOuHwQWD8i4F6NbjiplkET7WjSec0+VR6KUaX5yPR2QiNRJPOM2AqF0KdiDdl/x
         jgIAWMIXlM7IH9IX1PcPUAK7/Z9SPIO29CZH76tXFtin11ZDdqI7q1Uvgr+j++vq2aiR
         m338Agz4c5pUG7UR+i1ikVK27uv8akhjmrGEM0RiCQ5QmeNQpZr0zptaoExwsCnlqVeS
         wKnmOZu1+Uxggcieh8QS204nwtoq3DV37AU9ZAItPbfypT2aUPrcM2/GmgjEsMM/OyTM
         yfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i93HAMYtcSP4u8Uv0bFm7VUYocqbCMfLSgFR4CyGCj4=;
        b=qEcsHFHXr0WdJtPhhSpoUV+ZCu0si25oXmQAeJKlLmkNT6r320Bqmgc0v6m6ZlkV5b
         Tm9nv43i7Z1zCd6MeGeRV3NkP+/9aYjfayyD2t/takdrDcwBGYQYWgdB4jR7h1Km5Cf9
         dRqi5+C7BUb3mawFOx0FJzTsmTiP1CYiuTdYdkmvALcgml1T3ZO8fzgA/EzkikYALlVg
         K9quMQxb/Af5zUmVCVcJOImnKWomBroyBMeK5fUtdC1sSta0uFVdC/wm6agbqj3kigan
         R0sjnDyMjkAxKoi9xIcBRkvjiNf5Eo2ev+xR+sAlyQ1lq1heZb3txCBh0A5mz0BTEexl
         A3Xg==
X-Gm-Message-State: AOAM531hv67dJt8BQbtsZDpORSjczKHv/5iA8m4XHilBmmoAFsq+BBvN
        ulFL4mRT/meQcRbAjHnBOecoEdFxp5E=
X-Google-Smtp-Source: ABdhPJzb/AXcjCSb4eSDZ38M5fdukmsnwfTGbIEYOr10yLdmQZUl6ehb5CPPVW1Xd7uKVWAGdTq7yQ==
X-Received: by 2002:a5d:63cb:: with SMTP id c11mr26650839wrw.243.1602545165665;
        Mon, 12 Oct 2020 16:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15sm29713828wrr.36.2020.10.12.16.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 16:26:05 -0700 (PDT)
Message-Id: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 23:26:01 +0000
Subject: [PATCH 0/3] Make test selection easier by specifying description substrings instead of
 just numeric counters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables me to change

 ./t9999-my-test.sh --run=1-3,5,17,19

into

 ./t9999-my-test.sh --run=setup,rename,symlink

and have it pick out tests with "setup", "rename", or "symlink" in their
description and run those. Saves me a lot of time, especially since numbers
for tests aren't readily accessible. The easiest way for me to get the
numbers corresponding to the tests I want to run, is to run all the tests
and look at the output to match up the descriptions with their numbers --
thus defeating the point of selecting just a subset of the tests to run in
the first place.

Elijah Newren (3):
  test-lib: allow selecting tests by substring/regex with --run
  t6006, t6012: adjust tests to use 'setup' instead of synonyms
  test-lib: reduce verbosity of skipped tests

 t/README                     | 26 +++++++++++++++++------
 t/t0000-basic.sh             | 41 ++++++++++++++++++++++--------------
 t/t6006-rev-list-format.sh   |  2 +-
 t/t6012-rev-list-simplify.sh |  2 +-
 t/test-lib.sh                | 15 +++++++------
 5 files changed, 54 insertions(+), 32 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-878%2Fnewren%2Ftest-selection-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-878/newren/test-selection-v1
Pull-Request: https://github.com/git/git/pull/878
-- 
gitgitgadget

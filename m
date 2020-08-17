Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81966C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5215F2076E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyrQS/ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgHQNXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgHQNXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 09:23:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D343C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:23:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p20so15004898wrf.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vOaRj4AKmqqh+QHctgwT1s3ZZ2gQA/YjhMpXBlRegGY=;
        b=CyrQS/msgcq/GrHySyuybnl0Wj6XKn37Gp1pG9vnRUUNJouJibZnho2R+PfphO5p9N
         CmZb5jM4pjSdarUN5Yiz4KXKf3E3ziGG0JJskOYe/WEd5vhsO895qq9B+iHv4KA/abi8
         Ko8GlaaP/+w6B7B7g+vszkpmBNy40W0rqPnQgOLmjWc6W76IYzEIaQEnzIzYGY3vHo5S
         Wx36FDT2G3HqQ3bXgzBxtJIcVFI1QrU+7pR4eNOeJ65qKEgnRBnRX8gYbTeW4HfCtkaL
         RwCotl/ClJ82RLUUR7cCBwq/PMKwsTfOz7S7ZcsoCYzi19v+0VuDpjSeRVomy/KFe/QZ
         nobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vOaRj4AKmqqh+QHctgwT1s3ZZ2gQA/YjhMpXBlRegGY=;
        b=oR7OGuuIWHgjLThrTPERS0ipXFF8Qu5hwafXaeMEfz6KVQUwIfnQO2oiG+I/oxSciY
         VPqCNhVFTVpb/yGOhazo+t0k5wGrQGkPjYLYGnfTaDf2tlgrMwwEJ5O/jh5IrkBFsOy1
         y+nCj9LjTxDX7uGSCbt+Ut5FFOYcTgKfNeli9scgQUbIO1VixRvM/OA4DVV7vHTD3dL5
         57k6etsZfDwuhw9zn43FYu7sBROIn3OdK/q6KBJaNKCV/VmkhLeEaRyi703ENX8DyhLy
         LOZdmy8+n9TEKyPvaNO5v8kuG2+YOix9OWTT2t228x3LqyjLa12zVyd24cqRDlovW/mQ
         114Q==
X-Gm-Message-State: AOAM531wnV21RUVYWlLn/PxblK4w5tV0f7B+uwYCR0/3dSFr3YDIN27p
        B02aKnf/z/Fo06aeLTestUe39lr+tX8=
X-Google-Smtp-Source: ABdhPJzYPx7RFbe6CQXZzBiedf6rx0xfG+cL/1of++v11PIJ7vTtHl4kDY3Bpwn5c7HaH4dWgNDuvQ==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr15419141wru.21.1597670589944;
        Mon, 17 Aug 2020 06:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm31261906wrv.50.2020.08.17.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 06:23:09 -0700 (PDT)
Message-Id: <pull.702.git.1597670589.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 13:23:06 +0000
Subject: [PATCH 0/2] add p in C tweaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A code cleanup and small bug fix for the C version of add -p

dscho has pointed out that the bug fix in the second patch gets lost in the
other changes and suggested adding the last member of the enum (which fixes
the bug with handling 'e') as a separate patch. I'm unsure as it feels odd
to split up the introduction of the flags - I'd be interested to hear what
others think.

Phillip Wood (2):
  add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
  add -p: fix checking of user input

 add-patch.c | 67 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 25 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-702%2Fphillipwood%2Fwip%2Fadd-p-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-702/phillipwood/wip/add-p-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/702
-- 
gitgitgadget

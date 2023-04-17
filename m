Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D48C77B7A
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjDQQVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDQQVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3064A524A
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q5so14090474wmo.4
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748503; x=1684340503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RtqwLQ+7j1OvGvzxYvYSspqVyshl7NVzaFj9mAubh2E=;
        b=TZJlfcalCA4mLmeApj8T0/gku6sb508Y6tiy2ac2ZaU3bdyodQlvxGU/upQNpHY2dY
         ICEo4CtmTnM9eonQQEZqAl+mVgTYdtZL58aUpsrRQ3LmfG2wOwwjgwk4v5bV9ny00TEq
         4n6lnrJ74Xqn6PCs+54HqS6SElZMw/DteYi2CI2b3SCbp3XeXCPaADvJ/ghW2NJ4Dvay
         DH0uMpACd1oMxrdvF2ziuweaOXKk7++NYEssmu7QDiFxFXlAGpFALe84f2R9dXAsVMCB
         CHj68Tsxphvuvh72cSxuYRLDaZRprluXyRKQgX4tx3rhYrRvSkF5ovqgV7bE64gYuHNh
         EoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748503; x=1684340503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtqwLQ+7j1OvGvzxYvYSspqVyshl7NVzaFj9mAubh2E=;
        b=lA1o6VaZHKKnMktWWMsLvofYrwoU9W5PPiQ5okQ9rO4gA/XXBR5ubr9TXDpxMyLVty
         2Quw17ynaq7DoRq8GNV2RT7OuvLPgGzTGORU4zL1CU0sNTqIsTw3kse7Az8M4edbHdbq
         jYrLN8/m82Scme+9kUEyLKMX7r6U0xRyJYdA54S8GvGDrtFOgbQIn61e1Y7jlNoSB2m3
         0JZgA+A62hWFayJ5t4+Vk7fNZP/EI4Z0iDzZE5o1gyMTh1u5zjnouQgfcG+8YVM41nz9
         4G4LeUpHGsJN+qd+9mTD2/vPARuBgf+jSwApTn5rCDnkLucrd1IowprTsTBF67yaEXUn
         eTKg==
X-Gm-Message-State: AAQBX9fR/B2xIeQnLAtOs7udqP/Xkpi8wWhM6+d1UfwRX6xYDQyuPlL1
        pn6h8CfwIoZi2LCX5tHJEg/4qTwzeQg=
X-Google-Smtp-Source: AKy350alz0+pgZ7qGMAQutHG0y+P2cDjCS5T51WZIMFygG87zxTKDO/QePOVyeQMLQv2uisMd36Jsg==
X-Received: by 2002:a05:600c:2153:b0:3f1:74c5:5cc5 with SMTP id v19-20020a05600c215300b003f174c55cc5mr2129592wml.3.1681748503334;
        Mon, 17 Apr 2023 09:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c4f4400b003f0ae957fcesm10452132wmq.42.2023.04.17.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:21:42 -0700 (PDT)
Message-Id: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 16:21:37 +0000
Subject: [PATCH 0/4] git fsck: check pack rev-index files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on tb/pack-revindex-on-disk.

The git fsck builtin does not look at the .rev files that pair with .pack
and .idx files, but should. If these files suffer a bit flip on disk, then
the invalid data may cause fetches and clones from that repository to start
failing. The fix is simple: delete the .rev file (and regenerate, if
necessary), but detection is the first step.

This series adds those checks. The initial check to verify the checksum is
probably sufficient for most real-world scenarios, but going the extra mile
to verify the rev-index contents against an in-memory rev-index helps us be
sure that there isn't a bug in the rev-index writing code of Git (which
would result in a valid checksum). Much like other file formats, an invalid
header needs to be handled separately as a malformed header may prevent the
data structures from being initialized in the first place.

This series does not validate a multi-pack-index-<hash>.rev file or the
rev-index chunk of a multi-pack-index file. These could be fast-follows,
except that there is no existing equivalent for an in-memory rev-index for
easy comparison. The rev-index chunk (which is the most-common way for a
multi-pack-index to have this information) is already covered by existing
checksum validation, at least.

Thanks, -Stolee

Derrick Stolee (4):
  fsck: create scaffolding for rev-index checks
  fsck: check rev-index checksums
  fsck: check rev-index position values
  fsck: validate .rev file header

 builtin/fsck.c           | 36 +++++++++++++++++++
 pack-bitmap.c            |  4 +--
 pack-revindex.c          | 43 +++++++++++++++++++++--
 pack-revindex.h          | 16 +++++++++
 t/t5325-reverse-index.sh | 74 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 4 deletions(-)


base-commit: 9f7f10a282d8adeb9da0990aa0eb2adf93a47ca7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1512%2Fderrickstolee%2Ffsck-rev-indexes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1512/derrickstolee/fsck-rev-indexes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1512
-- 
gitgitgadget

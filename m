Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E68C63706
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 17:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLGR0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 12:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLGR0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 12:26:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8A654DB
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 09:26:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so29057096wrh.7
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0okznoq/2UX40Uti0jI1Gi5SxlnYHP4FH3MBXXSDU3U=;
        b=Fw3S1cWp+Vov85ePRHtdatOo6jPAW0AtVIstGzaBB9wr+HJ03iafc4k/SdK3nslHpR
         22nzOPWJcN2dPGfCJjV1hziVhOKelnd6DAgXm8NqB+Dx62Ui2f0DEpG4LbwbTuzIKtZn
         7N+VqUFmSlnSy1/1Pz7t+kCB4uNIxHAu5iff8bNpTAXK/6vnLF1tXQaR9wuiBwFdx8M0
         pY5j8fU4NjaAr4XGNB+UwRYB/V+rnfavQB56FYECByHNjqyebsJ8mx4zN9tj8PfDEEWH
         8OuGoT/UHHWwmBh2iwAuEQib1r8lOmmzanfoQ4ZrjgW7xmds1TRMbpdRJYoqHXRlCzB+
         dt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0okznoq/2UX40Uti0jI1Gi5SxlnYHP4FH3MBXXSDU3U=;
        b=3Ye6NsYQETcrVY11X/Ef/9QqpHmOwO+0eglWUoDYnruho06onSUd/TWug29p6eHecV
         Ky1ZApD3DlnW71K5FohKIbFnYKujlHzOZ1XHfZR07o76QpoRUlFsyM8kGapF4onnn8QT
         7zrDtqAYnD2G3HtNPnsbwi1B2R1Sbw0Z68RAYuJAjluLWVSV+a/JTxMGtiKh3NZzNJBx
         4BgjIXY8EUkClwtTK795ymFa/9lKy9uKxvy3MOohRtkND6efDY2J8Tk/CHXr2HbhVMb/
         U92xUxWScmdiFSY0EPF7OAbI3c93llT4hN2Tv0w3V+uXlUUuxKSt3Qkb+SMsVpIAXAh9
         S98Q==
X-Gm-Message-State: ANoB5pmK8H3BJPoEsOwsa9/qaah73I8jNXOy2EDDuh5XfXCmXNuVVE3S
        CzmzSVbmOjvAKG3X+Zj6OItlkB7Kzfs=
X-Google-Smtp-Source: AA0mqf5avGoCUd2yCxvuQj4Bjv+KpzR+db7CTafI68Oad7Lu60T6+L9RAH7nmirqpv8FKEUN6S3eDg==
X-Received: by 2002:a5d:6b0d:0:b0:241:cb64:e260 with SMTP id v13-20020a5d6b0d000000b00241cb64e260mr47462897wrw.126.1670433959524;
        Wed, 07 Dec 2022 09:25:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k32-20020a05600c1ca000b003b4ff30e566sm7978587wms.3.2022.12.07.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:25:59 -0800 (PST)
Message-Id: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Dec 2022 17:25:54 +0000
Subject: [PATCH 0/4] Optionally skip hashing index on write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Writing the index is a critical action that takes place in multiple Git
commands. The recent performance improvements available with the sparse
index show how often the I/O costs around the index can affect different Git
commands, although reading the index takes place more often than a write.

The index is written through the hashfile API, both as a buffered write and
as a computation of its trailing hash. This trailing hash is an expectation
of the file format: several optional index extensions are provided using
indicators immediately preceding the trailing hash. 'git fsck' will complain
if the trailing hash does not match the contents of the file up to that
point.

However, computing the hash is expensive. This is even more expensive now
that we've moved to sha1dc instead of hardware-accelerated SHA1
computations.

This series provides a new config option, index.skipHash, that allows users
to disable computing the hash as Git writes the index. In this case, the
trailing hash is stored as the null hash (all bytes are zero).

The implementation is rather simple, but the patches organize different
aspects in a way that we could split things out:

 * Patch 1 adds a 'skip_hash' option to 'struct hashfile' that creates this
   as a general option to the hashwrite API.
 * The motivation in Patch 1 avoids the talk about the chunk-format API and
   instead focuses on the index as the first example that could make use of
   this.
 * Patch 2 creates the index.skipHash config option and updates 'git fsck'
   to ignore a null hash on the index. This is demonstrated by a very simple
   test.
 * Patch 3 creates a test helper to get the trailing hash of a file, and
   adds a concrete check on the trailing hash when index.skipHash=true.
 * Patch 4 (which could be deferred until later) adds index.skipHash=true as
   an implication of feature.manyFiles and as a setting in Scalar.

The end result is that index writes speed up significantly, enough that 'git
update-index --force-write' improves by 1.75x.

Similar patches appeared in my earlier refs RFC [1].

[1]
https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/


Updates since RFC
=================

 * The config name is now index.skipHash to make it more clear that the
   default is to not skip the hash, and choosing this option requires a true
   value.
 * Use oidread() instead of an ad-hoc loop.
 * Patches 3 and 4 are new. 3 adds some extra test verification that wasn't
   in the RFC.
 * I think that patch 4 is helpful to see now, but I could understand if we
   wanted to defer that patch until after index.skipHash has had more time
   to bake.

Thanks, -Stolee

Derrick Stolee (4):
  hashfile: allow skipping the hash function
  read-cache: add index.skipHash config option
  test-lib-functions: add helper for trailing hash
  features: feature.manyFiles implies fast index writes

 Documentation/config/feature.txt |  3 +++
 Documentation/config/index.txt   |  8 ++++++++
 csum-file.c                      | 14 +++++++++++---
 csum-file.h                      |  7 +++++++
 read-cache.c                     | 15 ++++++++++++++-
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 22 ++++++++++++++++++++++
 t/test-lib-functions.sh          |  8 ++++++++
 10 files changed, 77 insertions(+), 4 deletions(-)


base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1439%2Fderrickstolee%2Fhashfile-skip-hash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1439/derrickstolee/hashfile-skip-hash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1439
-- 
gitgitgadget

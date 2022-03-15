Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D4DC433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351920AbiCOVcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350379AbiCOVcP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868B5BE44
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso1843582wms.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rPZA0a2q74W3/PP5PZ3Ceh0u20GCaYbtNHsiDWZCDTo=;
        b=J/Kz1TXQ/7sSAnHiY4Ox6jTbrsEJ5h7pyKa3rSSgX62HsBoO0kuKSGjjb4BpV63jKM
         VHWguaI4ptMZWHWR6tYzs9tXbsW2Wxb0wPFu8QanPw2jilaUXCRrPpfmFuOiF3QmhnVg
         NzPql5Zmnhb5KyLe6Yg3SKdcxOz6bRZ/1BHQHh3fOyB4u9ddu85hfQGyRCsAy6gzFMnU
         YAURZmnJLhZdzyQITqmceNg3O2odWPGcipqbLtPDpiZs2qRwrX0Gv+FmH70TR1EHK94b
         oQXR1xuZMYzZK2MkK3+QVV+J5yBN1pj0UI89wX4U7lRmf2K9G4nLxoRKdghYXfEAoS/S
         kI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rPZA0a2q74W3/PP5PZ3Ceh0u20GCaYbtNHsiDWZCDTo=;
        b=23pdmpUvofeRGMXcclxrB5+sC0Z8OUWGIXqkmFPSoRrFcKj9fjlSCSTsgxGWYwwnbT
         G5KPSZaG83sKidbaET0cwfW0KrfAEarQJ+/YveuARDqoHX74w+o8IePUXbCrCN0HzCoJ
         UWvbm5vqTFxj7oZA49/4wcbn/GhgqenHc2sTvBC8FAgwVMQmpZXQIjNo8/r7nBOY+RV0
         edIyOW/wl0OjY84QVUWtx00SB0eO7z+5czGIm3pZRNMVW8i+e20STyM/jy5DpM9/MN0D
         Q7f70+HSF3XasQJHL5Srt9S5YBqM051u9AcBidVmVX3dF0Tzv/IVl6mv3hUYUulvbPVy
         EwZw==
X-Gm-Message-State: AOAM530VO+7DHiKsFhr8TpAYZao+StW9W5qrAtVpRO1JKyGp5u97p5VQ
        PcoDojPU14XIWe3BwQLOPzPmbV4uEZk=
X-Google-Smtp-Source: ABdhPJwyczIP4Qtbeyb3F/CeFQqL93VITuIY7Tsmxe6Korx9aPMVCtn2bpWt/DUuUlHqp8MTptXgog==
X-Received: by 2002:a7b:c395:0:b0:38c:6cb1:cc50 with SMTP id s21-20020a7bc395000000b0038c6cb1cc50mr582363wmj.107.1647379860912;
        Tue, 15 Mar 2022 14:31:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm3177229wmc.22.2022.03.15.14.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:00 -0700 (PDT)
Message-Id: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:52 +0000
Subject: [PATCH 0/7] core.fsyncmethod: add 'batch' mode for faster fsyncing of multiple objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When core.fsync includes loose-object, we issue an fsync after every written
object. For a 'git-add' or similar command that adds a lot of files to the
repo, the costs of these fsyncs adds up. One major factor in this cost is
the time it takes for the physical storage controller to flush its caches to
durable media.

This series takes advantage of the writeout-only mode of git_fsync to issue
OS cache writebacks for all of the objects being added to the repository
followed by a single fsync to a dummy file, which should trigger a
filesystem log flush and storage controller cache flush. This mechanism is
known to be safe on common Windows filesystems and expected to be safe on
macOS. Some linux filesystems, such as XFS, will probably do the right thing
as well. See [1] for previous discussion on the predecessor of this patch
series.

This series is important on Windows, where loose-objects are included in the
fsync set by default in Git-For-Windows. In this series, I'm also setting
the default mode for Windows to turn on loose object fsyncing with batch
mode, so that we can get CI coverage of the actual git-for-windows
configuration upstream. We still don't actually issue fsyncs for the test
suite since GIT_TEST_FSYNC is set to 0, but we exercise all of the
surrounding batch mode code.

This work is based on 'seen' at 367f447f0f0cf39e9830c865e8373e42a3c45303.
It's dependent on ns/core-fsyncmethod.

[1]
https://lore.kernel.org/git/2c1ddef6057157d85da74a7274e03eacf0374e45.1629856293.git.gitgitgadget@gmail.com/

Neeraj Singh (7):
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncmethod: batched disk flushes for loose-objects
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsync: use batch mode and sync loose objects by default on
    Windows
  core.fsyncmethod: tests for batch mode
  core.fsyncmethod: performance tests for add and stash

 Documentation/config/core.txt |  5 ++
 builtin/unpack-objects.c      |  3 ++
 builtin/update-index.c        |  6 +++
 bulk-checkin.c                | 89 +++++++++++++++++++++++++++++++----
 bulk-checkin.h                |  2 +
 cache.h                       | 12 ++++-
 compat/mingw.h                |  3 ++
 config.c                      |  4 +-
 git-compat-util.h             |  2 +
 object-file.c                 |  2 +
 t/lib-unique-files.sh         | 36 ++++++++++++++
 t/perf/p3700-add.sh           | 59 +++++++++++++++++++++++
 t/perf/p3900-stash.sh         | 62 ++++++++++++++++++++++++
 t/perf/perf-lib.sh            |  4 +-
 t/t3700-add.sh                | 22 +++++++++
 t/t3903-stash.sh              | 17 +++++++
 t/t5300-pack-object.sh        | 32 ++++++++-----
 17 files changed, 335 insertions(+), 25 deletions(-)
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 367f447f0f0cf39e9830c865e8373e42a3c45303
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1134%2Fneerajsi-msft%2Fns%2Fbatched-fsync-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1134/neerajsi-msft/ns/batched-fsync-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1134
-- 
gitgitgadget

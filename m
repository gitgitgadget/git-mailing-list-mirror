Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD7FC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 03:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354704AbhLDDbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 22:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244876AbhLDDbw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 22:31:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15950C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 19:28:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so9701059wrs.12
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 19:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=V8Sl40LhahziWtiGC1rx2w7VlYwiX5it6djMdSjUCE4=;
        b=B7cTwQFKeQkiwFiSiwaefmC/T22VzFBL1Rrja6xWGOKvlKNR698pnm8CniJC8oqBRv
         ZeFzyl9NCx7TpyALayvd2wY83i73Bns1XJVUpLP48ZdAds5a7QaxlJrjmOldYoRsIDlN
         QUKibxm9hp1uw8zDjmH0pzmCszQCGX2jGV32LvM+wzgVIHatAikxGtqb1UvE07HyJPrc
         mfKd5X5+86Bm3WkxVqcCgG7RkqSXvUTSBlWWZCOgNFOZSWas/XV/NsKg16UmUTabaodi
         V+QQg7qGZ209F90pamdJ4bnO7VLHL8faeznRKy0Lc9grZNymm4ORkg7Ki75HHQJlkVHc
         jpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V8Sl40LhahziWtiGC1rx2w7VlYwiX5it6djMdSjUCE4=;
        b=2ffjwd9W7Za9U1PBgExz88/xYfm+7BLZXB5liI1wxFDUplOqY4nQf+ViWJrgV1hxTX
         D9UbxnexlVnoRMa0gj4JCOBNLxcj9fUsgX9J5AGyFkiJ8CJpHbDKfSqSj3Fr2CLLEwgW
         T5sw+8r79pBzDpDn8WXVyl452rcbE+ay847g1Cdd+lIQtWpKteUmjtErR/LWYucgIroX
         iU7Bmz7p0NzgJCQlB3XUd4x2TdcuzxO3JoKN/3mlLWCxL2KCm5/mojKUFoT694dyyJnR
         U7zLX7yJoklSVkWllVJx16WDe4ChKWVbsfsfdiKpBFzRlGCxHimvB1PFLpyDtTu+vEMz
         9G7g==
X-Gm-Message-State: AOAM531v7X9szzmuyZwZaTbeYY9MtqtOUFAIyfOS5tKFazfNTvV+6y0d
        quMrQccbHDzog0DcBpjg6TDBTIdlTe0=
X-Google-Smtp-Source: ABdhPJzdpGfL3lpk4+MXyvc3U3Xgs/YZYSOMVetknlhFt/bGm/9xyZ0cCCRSe7r5RmNscStsArH4sw==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr26409157wrf.197.1638588505433;
        Fri, 03 Dec 2021 19:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm4283608wrs.48.2021.12.03.19.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 19:28:25 -0800 (PST)
Message-Id: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 03:28:21 +0000
Subject: [PATCH 0/2] A design for future-proofing fsync() configuration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an implementation of an extensible configuration mechanism for
fsyncing persistent components of a repo.

The main goals are to separate the "what" to sync from the "how". There are
now two settings: core.fsync - Control the 'what', including the index.
core.fsyncMethod - Control the 'how'. Currently we support writeout-only and
full fsync.

Syncing of refs can be layered on top of core.fsync. And batch mode will be
layered on core.fsyncMethod.

core.fsyncobjectfiles is removed and will issue a deprecation warning if
it's seen.

I'd like to get agreement on this direction before redoing batch mode on top
of this change.

As of this writing, the change isn't tested in detail. I'll be making sure
with strace that each component has the desired effect.

Please see [1], [2], and [3] for discussions that led to this series.

[1] https://lore.kernel.org/git/211110.86r1bogg27.gmgdl@evledraar.gmail.com/
[2]
https://lore.kernel.org/git/dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im/
[3]
https://lore.kernel.org/git/pull.1076.git.git.1629856292.gitgitgadget@gmail.com/

Neeraj Singh (2):
  fsync: add writeout-only mode for fsyncing repo data
  core.fsync: introduce granular fsync control

 Documentation/config/core.txt       | 35 +++++++++---
 builtin/fast-import.c               |  2 +-
 builtin/index-pack.c                |  4 +-
 builtin/pack-objects.c              |  8 ++-
 bulk-checkin.c                      |  5 +-
 cache.h                             | 48 +++++++++++++++-
 commit-graph.c                      |  3 +-
 compat/mingw.h                      |  3 +
 compat/win32/flush.c                | 28 +++++++++
 config.c                            | 89 ++++++++++++++++++++++++++++-
 config.mak.uname                    |  3 +
 configure.ac                        |  8 +++
 contrib/buildsystems/CMakeLists.txt |  3 +-
 csum-file.c                         |  5 +-
 csum-file.h                         |  2 +-
 environment.c                       |  3 +-
 git-compat-util.h                   | 24 ++++++++
 midx.c                              |  3 +-
 object-file.c                       |  3 +-
 pack-bitmap-write.c                 |  3 +-
 pack-write.c                        | 12 ++--
 read-cache.c                        | 19 ++++--
 wrapper.c                           | 56 ++++++++++++++++++
 write-or-die.c                      | 10 ++--
 24 files changed, 337 insertions(+), 42 deletions(-)
 create mode 100644 compat/win32/flush.c


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1093%2Fneerajsi-msft%2Fns%2Fcore-fsync-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1093/neerajsi-msft/ns/core-fsync-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1093
-- 
gitgitgadget

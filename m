Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE228C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7B520771
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGlGpz+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392846AbgFSPVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392831AbgFSPVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:21:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9D0C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so10076525wrt.5
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+5njcMo7JTbAmQ/oASrUdJ9ktmT4P0toNmrrXObOYDw=;
        b=nGlGpz+q8695lcEf/dbmDoAzWY/sWdh0SyQr4W97mkpX3ocHbPr6VIWbvhibfuiuzK
         Ig63EDJC32P3RQbX4PlfNJd18EiawL8ow6zM65RB9yesZ6TWSnzqvbS0iT8b719T5lRq
         COANzWE3ofvkXn1qi947sQIhNK6bR3cwIYa1rzju2r+uUCtVe0F04xCDxouO6tTpjpOI
         XgbxWRrDJgRvbVoxEfPPUmTnBJd0eaeAXrN1ic32T31k2KO+us3segtlBegFaS9LaKm3
         u7rtKwKKRowZfJaBhxoVRKj9R+B+2W0LFIKgCJ+TX2kbnkNFCvWAQPMxlrkLGi12n26D
         Xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+5njcMo7JTbAmQ/oASrUdJ9ktmT4P0toNmrrXObOYDw=;
        b=sLJprFnIXjfmvcMOxMLBQIpS0B7XZGR2yaA+R5Pyq7lsAYJlOvti32+9vS4fYlERXb
         CFFahaVZC41uQH2FmOrll/BT4mEt/0uwEb6nfTjcpD+OEoYSvYQe3xBbP/A4WZBjVhYZ
         SbpUj+KSZ8U4ogH/Mv9nqHkmyAJFfkkB4qOMtmd5EYzA3/NsxuGMdrWm4iEnN3n5RKAH
         afptD6x5gI0tfjfIP2G5dAXB5mOu9AUJZieHwry+0qrnXxC86BLJ5Yx5SvI9TCjIEHYH
         TJq4FmAcedIw0YpNj32614fBNDerNgCli1b1AcNBnE2kGqDM4/fzFaxp2dhi8suTNcDG
         aZ+A==
X-Gm-Message-State: AOAM530fLudiQfAHl9UEpGVPfav4Y9xNjvOpY9UrKm6wV9v04oG7X2sZ
        n9nWqZuAZ3RpVDBxgpuC1eKQy6R1
X-Google-Smtp-Source: ABdhPJySvhcI2MMjxzeDxYyHIrj5LQ3BLq8d/+yvU0YtZNnRtmP+VKdb9Yv+5EMqdkP5oeHtLRBflw==
X-Received: by 2002:adf:82d0:: with SMTP id 74mr4395104wrc.138.1592580073137;
        Fri, 19 Jun 2020 08:21:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o82sm7299044wmo.40.2020.06.19.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 08:21:12 -0700 (PDT)
Message-Id: <pull.665.git.1592580071.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Jun 2020 15:21:07 +0000
Subject: [PATCH 0/3] update delete_ref(), update_ref() and ref_exists() to take a struct
 repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code handling pseudo refs such as BISECT_HEAD or CHERRY_PICK_HEAD
assumes that they are files and uses unlink() and file_exists() on the
corresponding paths rather than using the ref api. In repositories using
reftable to store references this will not work. This patch series is a
preparatory step that updates some reference functions to take a struct
repository in preparation for converting code that handles pseudo refs to
the ref api. The conversion will be handled by a separate series

These patches could each be split in two (thereby making the individual
patches smaller) by changing the callers to pass the_repository first and
then changing the call chain to pass a struct repository around if desired.

This series is based on master - 101b3204f3 ("The third batch", 2020-06-17).
When merging into pu there are non-trivial conflicts with
jx/proc-receive-hook, dr/push-remoteref-fix and mr/bisect-in-c-2. I have
prepared a conflict resolution [1] I'm happy to rebase on top of a merge of
master and those three branches if that is helpful.

[1] tag merge-repo-refs-into-pu/v1 at https://github.com/phillipwood/git.git

Phillip Wood (3):
  refs: update delete_ref() to take a struct repository
  refs: update update_ref() to take a struct repository
  refs: update ref_exists() to take a struct repository

 bisect.c                 | 18 ++++++----
 branch.c                 | 14 ++++----
 branch.h                 |  6 ++--
 builtin/am.c             | 19 +++++-----
 builtin/bisect--helper.c |  8 ++---
 builtin/branch.c         | 23 ++++++------
 builtin/checkout.c       | 17 +++++----
 builtin/clone.c          | 16 ++++-----
 builtin/commit.c         |  4 +--
 builtin/for-each-ref.c   |  4 +--
 builtin/log.c            |  6 ++--
 builtin/ls-remote.c      |  2 +-
 builtin/merge.c          | 12 +++----
 builtin/notes.c          | 15 ++++----
 builtin/pull.c           |  5 +--
 builtin/rebase.c         | 10 +++---
 builtin/receive-pack.c   |  2 +-
 builtin/remote.c         | 11 +++---
 builtin/replace.c        |  2 +-
 builtin/reset.c          | 10 +++---
 builtin/revert.c         |  2 +-
 builtin/send-pack.c      |  3 +-
 builtin/stash.c          |  8 ++---
 builtin/symbolic-ref.c   |  3 +-
 builtin/tag.c            |  8 ++---
 builtin/update-ref.c     |  5 +--
 builtin/verify-tag.c     |  2 +-
 builtin/worktree.c       |  8 ++---
 diff.c                   |  2 +-
 fast-import.c            |  2 +-
 notes-cache.c            |  4 +--
 notes-cache.h            |  2 +-
 notes-utils.c            |  2 +-
 ref-filter.c             | 76 +++++++++++++++++++++++++---------------
 ref-filter.h             | 11 +++---
 refs.c                   | 14 ++++----
 refs.h                   |  6 ++--
 remote.c                 | 30 +++++++++-------
 remote.h                 | 13 ++++---
 reset.c                  |  8 ++---
 sequencer.c              | 41 +++++++++++-----------
 sequencer.h              |  2 +-
 sha1-name.c              |  5 +--
 transport-helper.c       | 32 +++++++++--------
 transport-internal.h     |  4 ++-
 transport.c              | 15 ++++----
 transport.h              |  3 +-
 wt-status.c              | 41 ++++++++++++----------
 wt-status.h              |  2 +-
 49 files changed, 314 insertions(+), 244 deletions(-)


base-commit: 101b3204f37606972b40fc17dec84560c22f69f6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-665%2Fphillipwood%2Fwip%2Frepo-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-665/phillipwood/wip/repo-refs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/665
-- 
gitgitgadget

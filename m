Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86909C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiBJEl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:41:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBJElz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:41:55 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741313E
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:41:56 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q16-20020a170902edd000b0014d6be8d4b7so668681plk.18
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XjT9ln21+cvdK2DN68UAdjlaES7PccwGlyDOSXsCGGw=;
        b=r4ZfGoWc9jeo17sM8HBc65jyRYSBB2UWscKHOUJxMFuazaMfWFPZ4NFHqKjfTJa8KV
         DqNu/twk+yQrPgo3Vu6x3BT/aX+1loA2cocjLg17EDeoCBCAgudNcbRs0rWAGfSHsdqJ
         3ZyHAVv5B3pYKcsjw6+m6DjaZNKbw8dCObhceFVrPpkFZGDfGMYyM7Gmk5aHRcVDyoQu
         Uwn6pXaI8WC+JStTbbCPYZVu3Zw6+aagm6Jb/41XWgxIA1XoULGD7wm53M5AOVB3PVnV
         hCryQGNuqCtLdSfHN+v9qGo0xkF90ybzvx5ZyI4sd9hQ5qd6bpDBl0LrwFUGiKjYWD0Y
         Dcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XjT9ln21+cvdK2DN68UAdjlaES7PccwGlyDOSXsCGGw=;
        b=xOjJrCK2hLtBM8HQlMVmDTU9+wKVWYFWkPcfkJjNSJyOgy5HHqHgQcc6eGIOMIuW3v
         BAcbmiY5f1KU0ZEycWlHppUMu29WUEOmnort/YPkAZRSxSOySyKKGJbRBaAhGkmFpE2C
         HXU9sZptWiiSIf/yNkyEsexJLq5KkVuSR85PXS0tQ33phL5Zg0Q5eyO9POm6nUxF4XcT
         kwRkRRR5VcjLAMkkhft3862wtilASfjH5ZL39NbiwisoQQHm1zLKrJTlJGss4TAYIJTO
         ZXFu9NMFteIMFa/wkpTdxoWauWv6qNpMt6uo+w3wNbIj/U9xRXOH4cwT+H5lTnat1O8T
         aoFA==
X-Gm-Message-State: AOAM533TeDy/+V+z0l220g2ealCmwx+0g8DsO3MHTx/i/6i5kF+DUbBe
        DPsGrBt/elUS3Ih6WnPmVImbJ9xBry49EjbiXZNttNKLsIjqzwtebmHTWhLrtmCyhg3YjpUAztP
        1aMpx946y7LFfiOXKkqy0TSrGB0C0k4bZl2o6xYqKwD93aBcz6KFxB8tQNVdwH20=
X-Google-Smtp-Source: ABdhPJzS0BN9Vap6G/Lz6HMYTvQBCmVSDXgDAz0QiY9PTG1cCXcBp1FmBYTowcbS/SMbgjx7vjPrDqSaIgumtA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ecca:: with SMTP id
 a10mr5673743plh.68.1644468115357; Wed, 09 Feb 2022 20:41:55 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:44 +0800
Message-Id: <20220210044152.78352-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 0/8] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Background

When fetching submodule commits, "git fetch --recurse-submodules" only
considers populated submodules, and not all of the submodules in
$GIT_DIR/modules as one might expect. As a result, "git fetch
--recurse-submodules" behaves differently based on which commit is
checked out.

This can be a problem, for instance, if the user has a branch with
submodules and a branch without:

  # the submodules were initialized at some point in history..
  git checkout -b branch-with-submodules origin/branch-with-submodules
  git submodule update --init

  # later down the road..
  git checkout --recurse-submodules branch-without-submodules
  # no submodules are fetched!
  git fetch --recurse-submodules
  # if origin/branch-with-submodules has new submodule commits, this
  # checkout will fail because we never fetched the submodule
  git checkout --recurse-submodules branch-with-submodules

This series makes "git fetch" fetch the right submodules regardless of
which commit is checked out, as long as the submodule has already been
cloned. In particular, "git fetch" learns to:

1. read submodules from the relevant superproject commit instead of
   the file system
2. fetch all changed submodules, even if they are not populated

= Patch organization

- Patches 1-3 teach "git fetch" to read .gitmodules from the
  superproject commit.
- Patches 4-5 are quality-of-life improvements to the test suite that
  make it easier to write the tests in patch 7.
- Patch 6 separates the steps of "finding which submodules to fetch" and
  "fetching the submodules", making it easier to tell "git fetch" to
  fetch unpopulated submodules.
- Patch 7 teaches "git fetch" to fetch changed, unpopulated submodules
  in addition to populated submodules.
- Patch 8 is an optional bugfix + cleanup of the "git fetch" code that
  removes the last caller of the deprecated "add_submodule_odb()".

= Future work

Even with this series, there is no guarantee that "git fetch" will fetch
every necessary submodule commit because a superproject commit can
introduce new submodules, and since those submodules are not cloned, "git
fetch" cannot fetch those commits yet. This series should get us closer
to that goal because "git fetch" can read submodules from the
superproject commit, which is a necessary precursor to figuring out
whether to clone submodules from superproject commits.

Glen Choo (8):
  submodule: inline submodule_commits() into caller
  submodule: store new submodule commits oid_array in a struct
  submodule: make static functions read submodules from commits
  t5526: introduce test helper to assert on fetches
  t5526: use grep to assert on fetches
  submodule: extract get_fetch_task()
  fetch: fetch unpopulated, changed submodules
  submodule: fix bug and remove add_submodule_odb()

 Documentation/fetch-options.txt |  26 ++-
 Documentation/git-fetch.txt     |  10 +-
 submodule.c                     | 316 ++++++++++++++++----------
 submodule.h                     |   9 +-
 t/t5526-fetch-submodules.sh     | 386 ++++++++++++++++++++++++--------
 5 files changed, 524 insertions(+), 223 deletions(-)


base-commit: 679e3693aba0c17af60c031f7eef68f2296b8dad
-- 
2.33.GIT


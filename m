Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662A9C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjBMSWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBMSV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:21:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B413506
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:21:46 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id i14-20020a17090aee8e00b00233f1a535e0so1283193pjz.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4RZ86Q9piYfcOIapQIi7O57k8HE95HW9+7z8FNrFjXU=;
        b=K4VPum5h18NOrEklctM86BT6/FXDvbufDznNUr9VYvtIwTN29ER7kXpRCrqYB/JG6h
         a+4UkM1ar6zgyS1XBXUkayccWH87f8n3gkzWKRq1nVXkZjDTNGrqKM6UDv/Xmz8lEPmq
         gBoOxICeBLBBVZohffvrW+TEdNZRWKOIBPhREpyGHeiZdIUpJG/D299YpdGpZD3LE2gR
         b9P1/6YQcYesYN5ZRuw8MG6QJTVVTroiSP6ay197wwIHGu/YAVB/yTFCSN95AB03wKMs
         PFDZ9GkAFW0R4Qh0wVCBb4IvaIsJW1EMneEqJJfxZ6ttx1N05rid4Iyj8Gce26LgJHjC
         IeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RZ86Q9piYfcOIapQIi7O57k8HE95HW9+7z8FNrFjXU=;
        b=pNMUfAZfkrHIVcXFpED75FVFDeKYLfD6wN31V3MOxZQqj9aMPcrPKVq+MCUoeGTRcU
         l7vMp/1dkwdYScOLxDyvozLSeqAaIsLAhE8idbfBZZzpkxI4RHbxvkX+IolHd6UYMAHk
         2MHVkgITfKnT6IG+vfOYfTu4RoC6xz4WUnMT+e0uwynwsShf9mXIrSvX4VlPiNpjZZGA
         JP+Cvf5JpL7jHiTqsibF8bpUyuile9PAl55MCuDVKQXEIRRlwxgjOy1I/dxrai39OHZC
         bH+ge2dGxXhB4OoswJjxsH4YxaCY+YIrTfDAt7jT8LiklZDpuDfGg+lnACcwQep8sgU7
         2C/A==
X-Gm-Message-State: AO0yUKUvGNhZ438m9DjaQsyX557cMxHcSqMJ9QpqTb6dzCS5fhLOV3Q9
        J85k8Ko9bufrlOIZ/6Cm4cElj87sCXXB25Yg/UvV6OYKLVXt7LQT2elTfH7UKoyHVRmLXyMm5Kw
        r1bqGCcX4UIhzu2prStMrp5+qh/wesV1MTaFdj6MwVTA0AV+dUYLY5v06hVb6IVjG3w==
X-Google-Smtp-Source: AK7set+n6yYu1AmVF668PCFd/gVCsK+VBpiI4DUCB83y1zhh4yEMLp3UY+lgWpj6M2PclLCQyqe/TYWExZyz1S4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:be48:0:b0:4fb:2c72:9168 with SMTP id
 g8-20020a63be48000000b004fb2c729168mr3892625pgo.85.1676312506119; Mon, 13 Feb
 2023 10:21:46 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-1-calvinwan@google.com>
Subject: [RFC PATCH 0/6] add: block invalid submodules
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I will be taking over a series that Josh was working on before he
went on parental leave. For this RFC, I was wondering whether this
approach to blocking users from eventually commiting invalid
submodules is feasible. Eg. should we block at commit time instead?
And if so, how would that approach look?

=== Cover letter ===

At $dayjob, we believe that we need to change the default behavior
around adding embedded repositories. Currently, we issue advice that
embedded repositories cannot be checked out when the top-level repo is
cloned, and that the user should probably use a submodule instead.

However, our experience is that many users ignore this advice, and
commit embedded repositories to shared projects. This causes toil for
repo administrators who must correct these mistakes.

The main point of this series is to change the warning issued in this
case into a fatal error. However, this breaks lots of test cases that
were implemented prior to the original creation of the warning, so the
bulk of the changes are test cleanups.

For reviewer convenience, I've tried to group the test changes with
similar structure into the same commits:
* Patch 1: Fixes a leak in submodule-config.c
* Patch 2: Move setup code into test_expect blocks
* Patch 3: Substitute `git submodule add` instead of `git add` for
  simple cases (no other adjustments necessary)
* Patch 4: As in patch 2, but also adjust expected diff output
* Patch 5: As in patch 2, but also adjust expected status output
* Patch 6: Change the embedded repo warning to a fatal error

An open question:
* Currently we can bypass the embedded repo check with
  `--no-warn-embedded-repo`. I've kept the name of the flag the same for
  backwards compatibility. Should we instead rename the flag?

Calvin Wan (1):
  leak fix: cache_put_path

Josh Steadmon (5):
  t4041, t4060: modernize test style
  tests: Use `git submodule add` instead of `git add`
  tests: use `git submodule add` and fix expected diffs
  tests: use `git submodule add` and fix expected status
  add: reject nested repositories

 Documentation/git-add.txt                    |   7 +-
 builtin/add.c                                |  28 ++-
 submodule-config.c                           |   4 +-
 t/t0008-ignores.sh                           |   2 +-
 t/t2013-checkout-submodule.sh                |   4 +-
 t/t2103-update-index-ignore-missing.sh       |   2 +-
 t/t2107-update-index-basic.sh                |   2 +-
 t/t3040-subprojects-basic.sh                 |   5 +-
 t/t3050-subprojects-fetch.sh                 |   3 +-
 t/t3404-rebase-interactive.sh                |   3 +-
 t/t3701-add-interactive.sh                   |   5 +-
 t/t4010-diff-pathspec.sh                     |   2 +-
 t/t4020-diff-external.sh                     |   2 +-
 t/t4027-diff-submodule.sh                    |  17 +-
 t/t4035-diff-quiet.sh                        |   1 +
 t/t4041-diff-submodule-option.sh             | 228 +++++++++++++++----
 t/t4060-diff-submodule-option-diff-format.sh | 224 +++++++++++++-----
 t/t5531-deep-submodule-push.sh               |   4 +-
 t/t6416-recursive-corner-cases.sh            |  12 +-
 t/t6430-merge-recursive.sh                   |   1 +
 t/t6437-submodule-merge.sh                   |  12 +-
 t/t7400-submodule-basic.sh                   |   4 +-
 t/t7401-submodule-summary.sh                 |   4 +-
 t/t7402-submodule-rebase.sh                  |   2 +-
 t/t7412-submodule-absorbgitdirs.sh           |   2 +-
 t/t7414-submodule-mistakes.sh                |  21 +-
 t/t7450-bad-git-dotfiles.sh                  |   2 +-
 t/t7506-status-submodule.sh                  |  15 +-
 t/t7508-status.sh                            | 134 +++++++++--
 29 files changed, 569 insertions(+), 183 deletions(-)

-- 
2.39.1.581.gbfd45094c4-goog


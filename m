Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5C6C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 06:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiBIGxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 01:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbiBIGxC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 01:53:02 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72086C05CB98
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 22:53:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e7-20020a170902ef4700b0014d2b420f1fso1137092plx.17
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 22:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oyckZn974V6v50XYAOXIJBMX2p+nv+4X5fIwASq3W+A=;
        b=WzDQetbAMZh8jsPEmDsqssAnmTFLyKuITM2dWyUkH/nyOgaAVoWmp5yr+jCJ+Jm79B
         TSJqL6vG101KgHTHUBn0uXnXQZKEFCEWEPwlgbttFiq25Eh1hV8v3hPf6xp/9HYQPiwH
         VwKgPTMNblbJeIBJGt02Y5XBAnRXhGfc1JJ7QL4A059YAaZiY7KT0XJg8bQR68Iz7yqp
         iGzb2tcQq5Roh7nYhk2+IJwZP3uiSvBW9D9MUmB1eOo2XEeZdlg+Cf3wzvD5Z/xxzmoa
         gEdCg4YKrD7l1A2fKqOQi/IyTFiEW0cKncPc/SXlLXs4pb5llx9l0hRTQCWMyA0Cn3f1
         BMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oyckZn974V6v50XYAOXIJBMX2p+nv+4X5fIwASq3W+A=;
        b=tLopHKkyBRpEMMWzHnYb3uOzCHo8T2k6nujPa6+Wzt18QEbYhdymgmzuep1Si2RVtZ
         y62Eqk7GAi2zblMsndlc0IFrP05O9sZ5xs5OUMQTyY12qBI1Sivz23Jw1v3v2D8HXWHT
         Nmc+2NWEJ/ozLkNh4WSpLou9bocEAVcn+nv2X2I9Afdmb6lDixL6cJj7dEhseVmATaRq
         5eH3m34Y0zHtts/UohxzYkG6zIqsYn1mHLY0Kzyn2J+BikEGebQE1aeSxIwiuGHBB0FN
         /xQCiywQvKOVLYEYBTAW8DcA3Z/evE6LXdOFRfeUoq3uWGvN5+DakJrHxw6TTVx/m7ET
         xZmQ==
X-Gm-Message-State: AOAM530m7LYZYtUhpWXSV+3TaCaFZHA0Dub2nGMVeJhzi0xP5kHhyzPB
        Ek2aASnsqUIhh8qoPNT3u5tD191K/h4+EjG9iHOgTzoLZ94Ig8wbEWPXRhwodKRVHcrPxyJ1DQH
        4KOSFgnxHv1vbnmGLzAtIMpOHmS9niJWu5/WhMM391/Qpu7yxhHWNGfhp7rgpipU=
X-Google-Smtp-Source: ABdhPJxW6iO0yWW177KcJomHYMYCazgfu7wWmZFc01WfQDwn+kEkqHVKCupAXoigGKGlOFFZD4lXngtK9aA2Rw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1513:: with SMTP id
 q19mr853130pfu.12.1644389581752; Tue, 08 Feb 2022 22:53:01 -0800 (PST)
Date:   Wed,  9 Feb 2022 14:52:35 +0800
Message-Id: <20220209065236.36494-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 0/1] checkout: teach "git checkout" to checkout submodule branches
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, rsbecker@nexbridge.com,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on gc/branch-recurse-submodules.

Since gc/branch-recurse-submodules is queued for next, I was hoping to
get some feedback on a followup feature - teaching "git checkout
--recurse-submodules" to checkout the branches created by "git branch
--recurse-submodules".

When "git branch --recurse-submodules" was introduced [1], we noted that
existing Git commands ignore submodule branches and that we would teach
them to respect submodule branches if submodule.propagateBranches=true.

This series teaches "git checkout" to understand
submodule.propagateBranches=true so that "git checkout" checks out the
branches created by "git branch --recurse-submodules". Specifically,
the behavior of "git checkout" follows the proposal laid out in the
submodule branching RFC [2] (an abridged description can also be found
in the commit message).

This series isn't ready for full review yet (see "Future work"), but the
approach is unusual enough that I thought it would be useful to get
early feedback and evaluate alternatives (instead of polishing a
potentially bad approach).

I'd appreciate any feedback, though I'd like for reviewers to focus on
fleshing out the design space. This could include answering the
questions in "Questions", or providing additional context to "git
checkout" that I missed.

(Cc-ed some people who have shown some interest in submodules in the
past)

= Approach

Presently, "git checkout" updates the superproject/submodule HEAD and
trees using different machinery:

- unpack-trees updates the superproject tree, submodule tree and
  submodule HEAD
- cmd_checkout() porcelain (specifically, update_refs_for_switch()),
  updates the superproject HEAD

This works well if we assume that "git checkout" always leaves
submodule's HEAD pointing to a commit id, but this is no longer true
with submodule.propagateBranches=true, so this series updates submodules
differently:

- disable submodule updating in unpack-trees, so that neither the
  submodule HEAD nor submodule tree are updated
- update the submodules' HEAD and tree using a "git checkout" subprocess
  in the cmd_checkout() porcelain (specifically,
  update_refs_for_switch())

Doing work in the cmd_checkout() porcelain lets us support complicated,
"git checkout" workflows that don't make sense in unpack-trees:

- updating the submodule's tree using the submodule's "topic" branch
  instead of the gitlink of the superproject's "topic" branch
- updating the submodule's HEAD to a ref instead of a commit id
- checking out the gitlink when the submodule's HEAD points to a branch
  pointing to the same commit (unpack-trees will ignore the submodule if
  it notices that the HEAD's oid does not change)
- preventing a checkout if a submodule is in detached HEAD and not
  pointing to the superproject gitlink (Future work, see RFC for more
  details [2])

The tradeoffs are:

- we lose atomicity guarantees because we run multiple subprocesses
  instead of a single unpack_trees()
- overhead of spawning child processes
- blurring of the lines between cmd_checkout() porcelain and
  unpack-trees - superproject trees and HEAD are still updated
  in different code locations (by cmd_checkout() porcelain and
  unpack-trees respectively), but submodule trees and HEAD are both
  updated by a single "git checkout" subprocess.

= Questions

- Is this an accurate summary of benefits and tradeoffs? Am I missing
  something?
- What alternatives exist and how viable are they?

= Future work

- Prevent a submodule checkout when the submodule's HEAD is detached and
  not pointing to the superproject gitlink
- Implement the checkout -b/-B flags i.e. create a new branch
  recursively and check it out.
- Refactor out the common bits between this series and "git branch
  --recurse-submodules".
- Check for checkout options that are incompatible with
  --recurse-submodules
- Parallelize the submodule checkout
- Handle the submodule.recurse config value
- Possibly refactor out the "find submodules in the index" logic from
  builtin/submodule--helper.

[1] 961b130d20 (branch: add --recurse-submodules option for branch creation, 2022-01-28)
[2] https://lore.kernel.org/git/kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com

Glen Choo (1):
  checkout --recurse-submodules: checkout branches if configured

 builtin/checkout.c            | 142 +++++++++++++++++++++++++++++++++-
 submodule.c                   |   6 ++
 submodule.h                   |   9 +++
 t/t2013-checkout-submodule.sh |  90 +++++++++++++++++++++
 4 files changed, 243 insertions(+), 4 deletions(-)


base-commit: 679e3693aba0c17af60c031f7eef68f2296b8dad
-- 
2.33.GIT


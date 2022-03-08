Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5347C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbiCHHks (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiCHHks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:48 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB9939834
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:39:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so26983710wra.12
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=zbCaBCtDhJWdeZpL+X0rdDU8KnPQwTrgcoSjMZKac8k=;
        b=SX+HLTBcCOk7yPoImjObo4wDSpVGyvz2vJoKQ1mFiAWKHw8Yrr4vpD5YAh5YAiQ8w4
         3hGx+xbd2kn0Dx0d1+9xBgd2JHXQRkBHVKmn7Hq9my8xnwRG5yZSJoGWWy0opa9QawhR
         p6LuOStOcaZFqUGH1nKudWpED/q4tpW+SJyaC+WzVxQffEt9WBzseZmwPtYxsuTqRRkG
         VjU0WwK8Wx+onnk7srfBtVvE/7l19N5raotgJNWEB9DaMeUgIp84rPmFgS/Gm/7Tsf2O
         uhk8cC1Pn8HsTtun+NCfxXIEz80Dw4TjoxM788D5v4V/aDTwNK05LYx1zC12CA2A+nrn
         VzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zbCaBCtDhJWdeZpL+X0rdDU8KnPQwTrgcoSjMZKac8k=;
        b=SAm5fJZ2yRKATfx/80PuX8WBx/3a26m7iwtOGkYEfgNOKgLQdAsBvqgzYFFtisAlYM
         Xvjl3CY+oa9LDD2JEiNqpesAYGRfk97VvwnE2rDzG0/gQcWG+z8t0ikCqOwS3elu9kah
         VJsOgHqdZ83pxvSmapEDD6D9wpVQDWiuNakGW5bh0IvqIjpUqug+v69ZImM03JRMw0Qf
         4V6+68Ur1oW/QdG6PT1GJHqGv831pG+ID6c5eoswatZSTm0H8+KXcSfahsQ4mucWSA8k
         klhjxvGyN/6Nm2dZDyQNMVm/3e8UvQ73fgnx93yvvPg6HIHb4UIHMHt/4z6XX2JvlZtr
         /dfQ==
X-Gm-Message-State: AOAM532+fx2f6pg+bP0ez5v+5ERtfpKK7/onJOmByaGHR2VYJFzzcL97
        smbQGSPh08Vx++LS+OTIRMQzOTXhzIU=
X-Google-Smtp-Source: ABdhPJyL2wXsa4wO8anAvgVo0lxJ5O95QKdWJruSziqkS0SeREoPXQRXEgDIaQadBb/PHrdWOK6cYA==
X-Received: by 2002:adf:d1e2:0:b0:1f1:d702:72c1 with SMTP id g2-20020adfd1e2000000b001f1d70272c1mr10965994wrd.687.1646725189919;
        Mon, 07 Mar 2022 23:39:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm1342059wmh.31.2022.03.07.23.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:49 -0800 (PST)
Message-Id: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:39 +0000
Subject: [PATCH 0/9] sparse-checkout: make cone mode the default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Maintainer Note ==

Depends on a merge of en/present-despite-skipped into master.

== Overview ==

This patch changes the default mode for sparse-checkout from non-cone mode
to cone-mode, and marks non-cone mode as deprecated. There is no plan to
remove non-cone mode, we are merely recommending against its use.

The code change is pretty small, and most of this series is about
documentation updates -- to focus on directories rather than patterns, to
explain the new default, to explain why we are deprecating non-cone mode
(the final patch), and to make other related cleanups to simplify the
manual.

Patch 1: Update tests to not assume cone-mode is the default Patch 2: Make
cone-mode the default Patches 3-9: Various updates to
git-sparse-checkout.txt, divided up for ease of review

== Alternative ==

There is one primary alternative to this series: make sparse-checkout error
when neither --cone nor --no-cone are specified (so that there is no
default), and wait until a future date to make --cone the default. That'd be
reasonable, but I had three reason to avoid going this route (note that item
2 means there's little practical difference between cone-mode-as-default and
no-mode-is-default):

 1. git-sparse-checkout.txt has the following huge warning early in the
    manual:

""" THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN THE
FUTURE. """

 2. If users are unaware of the default change and attempt to provide
    patterns instead of directories, then they will get error messages added
    from en/sparse-checkout-fixes. They can learn at that time to get around
    the error messages by providing --no-cone.

 3. If users are unaware of the default change and provide directories, then
    that's where non-cone mode and cone mode overlap and things happen to
    work. (There is a slight difference in that cone mode will include files
    from parent directories of any specified directory, but that means the
    user gets a few more files in their sparse-checkout with cone mode than
    they would with non-cone mode.)

== CCs ==

Elijah Newren (9):
  tests: stop assuming --no-cone is the default mode for sparse-checkout
  sparse-checkout: make --cone the default
  git-sparse-checkout.txt: wording updates for the cone mode default
  git-sparse-checkout.txt: update docs for deprecation of 'init'
  git-sparse-checkout.txt: shuffle some sections and mark as internal
  git-sparse-checkout.txt: add a new EXAMPLES section
  git-sparse-checkout.txt: flesh out non-cone mode pattern discussion a
    bit
  git-sparse-checkout.txt: mark non-cone mode as deprecated
  Documentation: some sparsity wording clarifications

 Documentation/git-read-tree.txt       |   9 +-
 Documentation/git-sparse-checkout.txt | 248 +++++++++++++++++++-------
 builtin/sparse-checkout.c             |   2 +-
 t/t1091-sparse-checkout-builtin.sh    |  15 +-
 t/t3602-rm-sparse-checkout.sh         |   6 +-
 t/t3705-add-sparse-checkout.sh        |   4 +-
 t/t6428-merge-conflicts-sparse.sh     |   4 +-
 t/t7002-mv-sparse-checkout.sh         |   2 +-
 t/t7012-skip-worktree-writing.sh      |   2 +-
 9 files changed, 206 insertions(+), 86 deletions(-)


base-commit: af002ccf9fe2ce6cce9111323423f1d4739bcf0d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1148%2Fnewren%2Fsparse-checkout-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1148/newren/sparse-checkout-default-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1148
-- 
gitgitgadget

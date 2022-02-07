Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4394FC4707A
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbiBHBFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343712AbiBGXuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:50:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE7C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:50:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n8so11005361wmk.3
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 15:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+yXXkkIXclFH64qj0B7QIRjbZQDdYOHXKrzRUNUzGFI=;
        b=HHm9K7neLXf1+4YUu/9kdTs37pv1sbUdaovY3wtf9Xtzpcz4KuEclknYFcZmqQ3sYu
         F01yTxdZmcVbBCcBGF0q8K3K1yI6vZ8zgDqhTL1ugzQLvDlsYA4ABCChlN6ObrnDQdt7
         XaIFRbaQTFK9c8mVL+z5TT1pwd8WR3uywVcP4ccXoAptwJTcPb1uTzfT2UEQqoDzEgbM
         Py5wT1CwgFUQgdKKSfAxotRqx81+DliBAgxx45TXLxk10gKPbUYcD8hN6Az6ZN0QlAAI
         K1WwosK8G2wSm29BzfvyNS20K8t0bZJBjguAnBPTbbJXdw5OcPxizy+320pvGhnnpiUB
         UA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+yXXkkIXclFH64qj0B7QIRjbZQDdYOHXKrzRUNUzGFI=;
        b=y+wwD6B5DN6K7dILDuZ0303p7r6K6aTy7RsFZpY7VcdORxlljBO+xZr+3xvrzhMCAc
         plt6akBIu0XUFIHS6d9VD34gKubAD6N08PnhxgNsgiskBObQD2vjnT1mfELvBpHh393k
         K+zvkC1sDPGmURyj50zwvBlTZGMFcGyqKJ3SFUH3zHCjEfILCB1R4l3/lt+mFA1UQP9Y
         ZpsxUvtVUtdupKb9xP2B7CQz2O+ip7P0xsc33rjTLPLxMEVFKIMXmXIUEv+GXHLiQX2W
         bzdS+DN7lWp9OV3Yru2pXBUSpwOfu3FYnoez9tNchPGt7JwexLy1drFt2MyXMwfcYuqv
         FLyQ==
X-Gm-Message-State: AOAM531KiYpeU7GLV4FQvtXAp6Tmvr21yvCErf7j5E3TUxUqOEzHp7kv
        POZa8t7KUtGFQSLDZcagU8AxdJMCZek=
X-Google-Smtp-Source: ABdhPJx7JjnKLYTIG+QwCxe/Zvt99SfU/32fi5dBQMXkdmIcrHElQHbxNdZKBAFQlRPV7klpr3uDPA==
X-Received: by 2002:a05:600c:1ca8:: with SMTP id k40mr983185wms.62.1644277798528;
        Mon, 07 Feb 2022 15:49:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm662913wmq.0.2022.02.07.15.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:49:57 -0800 (PST)
Message-Id: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 23:49:55 +0000
Subject: [PATCH 0/2] checkout/fetch/pull/pack-objects: allow -h outside a repository again
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported in https://github.com/git-for-windows/git/issues/3688, calling
git fetch -h outside a repository now results in a very ugly

 BUG: repo-settings.c:23: Cannot add settings for uninitialized repository


The reason is that the prepare_repo_settings() calls (that we introduced to
support sparse index) assume that there is a gitdir, but the hack to allow
parse_options() to handle -h even outside a repository invalidates that
assumption.

One strategy I considered was to move the prepare_repo_settings() calls
after parse_options(). This would work because when parse_options() handles
-h, it exits without returning.

However, this strategy failed in my tests because e.g. cmd_unpack_objects()
does need the pack_use_sparse to be populated correctly before even parsing
the options so that it can be overridden via --sparse/--no-sparse.

Hence the current strategy where the code that prepares the repo settings
and then accesses them is guarded behind the condition that we must have a
gitdir to do so.

Note: There are other instances where prepare_repo_settings() is called
before parse_options(), e.g. in cmd_status(), in seen there are even more
instances (e.g. cmd_checkout_index()). All of those instances that are not
touched by this here patch do have special code to handle -h early, though,
before calling prepare_repo_settings() let alone parse_options().

Johannes Schindelin (2):
  checkout/fetch/pull/pack-objects: allow `-h` outside a repository
  t0012: verify that built-ins handle `-h` even without gitdir

 builtin/checkout.c     | 7 ++++---
 builtin/fetch.c        | 7 +++++--
 builtin/pack-objects.c | 8 +++++---
 builtin/pull.c         | 6 ++++--
 t/t0012-help.sh        | 7 ++++++-
 5 files changed, 24 insertions(+), 11 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1139%2Fdscho%2Fprepare_repo_settings-after-parse_options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1139/dscho/prepare_repo_settings-after-parse_options-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1139
-- 
gitgitgadget

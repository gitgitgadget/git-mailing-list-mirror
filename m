Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD581FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbcLCAaw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:30:52 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32953 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so112881816pgd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/wlwYhQR9x8nm4I6VRxbC0Hh+zjdhthhKWZ2VkZHWjg=;
        b=NtLvnVQYXa26QxTHBRWs9aa5DCYd9v2x0oTvdZ43C1Qnlw6bXxa6rMM6iBoOfWTRDY
         4sWjvPmjvf4H5Tm4Y0ZY2tOI7HdsajORVEZN8dNtZXbV8swgfKrjhCVcWHlMyKZXKULw
         xrLy8zvD6Hq27a3ZGMiCOc6E0tCJR0Vn+8nfbsnYEowTq9wslzvgbaPRg4jClJfzIqiu
         pEmnF/mLr8GCHSKfzeEn2dfFdlqLlqsN4pMFF+S3lqpTf314eOT4MUrL8DPDi4f+7Vsn
         r0IwuqCJ9Yf+ZfXcvxIf6oCxK7gdmGtqBskBWW46W4Em9HC2x//3TYM6pvp0K4uugsAo
         vwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/wlwYhQR9x8nm4I6VRxbC0Hh+zjdhthhKWZ2VkZHWjg=;
        b=glupW+J7kl5cb6ygXvLozjv/tC/dxD2BCIZsjmpGAoocPF72i1CLyhzNFNPv9PLEmk
         ONbA5V71z57KmSsB3x+mJGJDTTS0JJHCeNla91DsCOLTQmWEhHqd5KOkw1WU8dlBOhLp
         X3E7jf/B36lF10P/Woll6UIDwCpKBZxic1JXyLKdVjoAaQbGFzbbSxkHAcm6iF1tLPgI
         xmLQDTBjDPwDof1FIL5dAiPUi0fabYyRkOvsUfeRsXbdnryfKICpmYPcp77vDKfBdAYu
         QiNdXmMKc/tYrxZ+LUJdnLZa1U9bIE/P8fXu/zAjPmFWUAEptTfgu33OJZ0uwGXcNiAF
         eDJQ==
X-Gm-Message-State: AKaTC03Lv3LJfELiy0nRLD4xPYar4QzaVFZmlelelBChGCoFzAQjIvYJs1LiiUEFo8l5/vnK
X-Received: by 10.99.0.194 with SMTP id 185mr83681260pga.111.1480725034022;
        Fri, 02 Dec 2016 16:30:34 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id p13sm10171232pgf.47.2016.12.02.16.30.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 00/17] Checkout aware of Submodules!
Date:   Fri,  2 Dec 2016 16:30:05 -0800
Message-Id: <20161203003022.29797-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* based on top of the series sent out an hour ago
  "[PATCHv4 0/5] submodule embedgitdirs"
* Try to embed a submodule if we need to remove it.
* Strictly do not change behavior if not giving the new flag.
* I think I missed some review comments from v1, but I'd like to get
  the current state out over the weekend, as a lot has changed so far.
  On Monday I'll go through the previous discussion with a comb to see
  if I missed something.
  
v1:
When working with submodules, nearly anytime after checking out
a different state of the projects, that has submodules changed
you'd run "git submodule update" with a current version of Git.

There are two problems with this approach:

* The "submodule update" command is dangerous as it
  doesn't check for work that may be lost in the submodule
  (e.g. a dangling commit).
* you may forget to run the command as checkout is supposed
  to do all the work for you.

Integrate updating the submodules into git checkout, with the same
safety promises that git-checkout has, i.e. not throw away data unless
asked to. This is done by first checking if the submodule is at the same
sha1 as it is recorded in the superproject. If there are changes we stop
proceeding the checkout just like it is when checking out a file that
has local changes.

The integration happens in the code that is also used in other commands
such that it will be easier in the future to make other commands aware
of submodule.

This also solves d/f conflicts in case you replace a file/directory
with a submodule or vice versa.

The patches are still a bit rough, but the overall series seems
promising enough to me that I want to put it out here.

Any review, specifically on the design level welcome!

Thanks,
Stefan


Stefan Beller (17):
  submodule.h: add extern keyword to functions
  submodule: modernize ok_to_remove_submodule to use argv_array
  update submodules: move up prepare_submodule_repo_env
  update submodules: add is_submodule_populated
  update submodules: add submodule config parsing
  update submodules: add a config option to determine if submodules are
    updated
  update submodules: introduce submodule_is_interesting
  update submodules: add depopulate_submodule
  update submodules: add scheduling to update submodules
  update submodules: is_submodule_checkout_safe
  unpack-trees: teach verify_clean_submodule to inspect submodules
  unpack-trees: remove submodule contents if interesting
  entry: write_entry to write populate submodules
  submodule: teach unpack_trees() to update submodules
  checkout: recurse into submodules if asked to
  completion: add '--recurse-submodules' to checkout
  checkout: add config option to recurse into submodules by default

 Documentation/config.txt               |   6 +
 Documentation/git-checkout.txt         |   8 +
 builtin/checkout.c                     |  31 +++-
 cache.h                                |   2 +
 contrib/completion/git-completion.bash |   2 +-
 entry.c                                |  14 +-
 submodule-config.c                     |  22 +++
 submodule-config.h                     |  17 +-
 submodule.c                            | 292 +++++++++++++++++++++++++++++---
 submodule.h                            |  74 ++++++---
 t/t2013-checkout-submodule.sh          | 293 ++++++++++++++++++++++++++++++++-
 t/t9902-completion.sh                  |   1 +
 unpack-trees.c                         |  92 ++++++++---
 unpack-trees.h                         |   1 +
 14 files changed, 768 insertions(+), 87 deletions(-)

-- 
2.11.0.rc2.28.g2673dad


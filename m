Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993032013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbdBPAi2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:28 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36503 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756241AbdBPAiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:25 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so781153pfu.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AQjOW5b+28SdeXlX61yVTgvUfUoz/3KZq9kS0LJDOQk=;
        b=I4aD7fkuQr5hta2Tc7AIbIfHjinBqFrdRymhWAePS6emZm5mKgMzz4ch7fxSAwX8zc
         6vTBokVi4TvHsWWow9A/ty4AnL7w218yAGh7a0kd3GHOcP6F1qtxGDe24HDfHdKPFZSr
         0CaYbWHujCGaQwMNmJRJyK0rU/ViEMn/QOSyozcMinW3x1H5XFj2NSjbI3lXbsbfmjp5
         Lxn9qjSF75DwTpGDKGt4ADCoWWg4m62buBu4EnDRS5iYqraOfCtStk2rmep+kJpE2FXV
         NgHiQBD5R3Rm3jEq3pdYRyjuGqv8KAY+md0N5EOisSVs7/XS6F9M+/Z+PdILt4dtnch1
         UP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AQjOW5b+28SdeXlX61yVTgvUfUoz/3KZq9kS0LJDOQk=;
        b=U3Y+cndHwRYrgQKgGPsc3zHH+TCh8Z3Xn3stTgVWvc9ZNgRn9CAQUG14epJN8QvRSI
         QGxpxl52xbwjBY+xUPkIAd8CJGJmcohKtgBrYMiL3cQjyyuTkGo26ls/D9rcOnR2Gsf6
         JkFrJjcRAruexcXwbOpvgQtXIIHMS9IwjgtdFN/7QjKtOpjrXdfv8v1nezplKXKmjsAK
         cVgGQyUy3EDwquDh7lbApQEPFLQnl6SGEavF4qiRxWFpKQuYFtTjq8VT6fTP+LxC2zsL
         m4rsH8wJyN/XpLR9DY6nBrJHSmxp5R3oRpUYkTmSQ9tP3LLV7xeIfrTAFNO+XByJsaI7
         PN6A==
X-Gm-Message-State: AMke39n0uoM3/W1JFDcLZ0KZkDVvSoiO9gOukE6Xn34cMusfetEp9gIL+xFJ8jMiOwKMcYER
X-Received: by 10.99.125.17 with SMTP id y17mr42161814pgc.27.1487205499858;
        Wed, 15 Feb 2017 16:38:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id g70sm9553501pfb.50.2017.02.15.16.38.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFCv4 PATCH 00/14] Checkout aware of Submodules!
Date:   Wed, 15 Feb 2017 16:37:56 -0800
Message-Id: <20170216003811.18273-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous work:
https://public-inbox.org/git/20161203003022.29797-1-sbeller@google.com/

v4:
 * addressed all comments of Brian, Junio and Brandon.
 Thanks!
 * one major point of change is the introduction of another patch
   "lib-submodule-update.sh: do not use ./. as submodule remote",
   as that took some time to track down the existing bug.
 
v3:
 * moved tests from t2013 to the generic submodule library.
 * factored out the refactoring patches to be up front
 * As I redid the complete implementation, I have the impression this time
   it is cleaner than previous versions.
 
 I think we still have to fix the corner cases of directory/file/submodule 
 conflicts before merging, but this serves as a status update on my current
 way of thinking how to implement the worktree commands being aware of
 submodules.
 
Thanks,
Stefan

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


Stefan Beller (14):
  lib-submodule-update.sh: reorder create_lib_submodule_repo
  lib-submodule-update.sh: define tests for recursing into submodules
  make is_submodule_populated gently
  connect_work_tree_and_git_dir: safely create leading directories
  update submodules: add submodule config parsing
  update submodules: add a config option to determine if submodules are
    updated
  update submodules: introduce is_interesting_submodule
  update submodules: move up prepare_submodule_repo_env
  update submodules: add submodule_go_from_to
  unpack-trees: pass old oid to verify_clean_submodule
  unpack-trees: check if we can perform the operation for submodules
  read-cache: remove_marked_cache_entries to wipe selected submodules.
  entry.c: update submodules when interesting
  builtin/checkout: add --recurse-submodules switch

 Documentation/git-checkout.txt |   7 +
 builtin/checkout.c             |  28 +++
 builtin/grep.c                 |   2 +-
 dir.c                          |   2 +
 entry.c                        |  28 +++
 read-cache.c                   |   3 +
 submodule-config.c             |  22 ++
 submodule-config.h             |  17 +-
 submodule.c                    | 216 +++++++++++++++--
 submodule.h                    |  16 +-
 t/lib-submodule-update.sh      | 534 +++++++++++++++++++++++++++++++++++++++--
 t/t2013-checkout-submodule.sh  |   5 +
 unpack-trees.c                 | 115 +++++++--
 unpack-trees.h                 |   1 +
 14 files changed, 936 insertions(+), 60 deletions(-)

-- 
2.12.0.rc0.16.gd1691994b4.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB4A2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdBOAfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:06 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:33598 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAfF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:05 -0500
Received: by mail-io0-f175.google.com with SMTP id g18so1948603ioe.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SHiHQqc6L3VNzAIWanfMNSGbmRAgHmUG8W8l8yv31+A=;
        b=ocKhDW/6D0DBuDt3EumEkXZ0wp4b3VmknogyapoDhIfR7QZVqatVyYePh19bZWNos3
         EKRoUzPn0x1Yn/FFSVmKPRxZRGrk1T9WvSxsXVeHD7h9mLIvdyvCrGOES02xsW2yXVsi
         arrxgjA3f8tZie/+AlIkJ+IRTsQ77pTj+4L9zmLqPTAGpVeW0kx60WL6T4Uy6Td0RBV0
         svBc2ahRMgQ97VmriqxkPY1OJxh5gbd/SRYBG4Rmk3LgyKVh9eeAhiCoClJ5xkKxYRvv
         FBrynh9O66kApCWiv7esdN67GAYntJ/yuHNkO2mwQXbmzsh1lIhae4lPLDbsr3slM5cc
         JuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SHiHQqc6L3VNzAIWanfMNSGbmRAgHmUG8W8l8yv31+A=;
        b=p0mzxh+2UcyFhzQK2NlUqkYksDSF2XvlRcxgJGCb1FpaeeL1onmcoqRyI0FeIZIXvT
         +aSDHRI79n5+ZfO7I75LvCDg8DpTk2dU2TL3zYbzZlzYnmPWD38ewuF7/nIN2WJUfGcS
         0T3ILdcja90tHftF+OKOIEXOKS4p7/BIyZptnR8CgjKbFz04tUFRVkTNLMg6XjvyZ1qa
         55eNUIxReqAKWPRCvnDIiViGWLzjxcmv/w7R+vcV1j2pOcoglyZTvwy62T3sUKGbmKhz
         EBUdEVYHgjevhrqOYLf2UYM+zjV4JjZ9NUzt3Rf/vxtHOkac+NNwgxjvSpcAd+tdTvpO
         v1DA==
X-Gm-Message-State: AMke39mhuk669taFUVrcwiTM9SaRaHCq+e1SQwgfn0jgqbZ9JIzmQ1VTXhWQQ3aOG+Ih/YSi
X-Received: by 10.98.102.21 with SMTP id a21mr34288356pfc.29.1487118904094;
        Tue, 14 Feb 2017 16:35:04 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id q90sm3308059pfk.73.2017.02.14.16.35.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:03 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFCv3 PATCH 00/14] Checkout aware of Submodules!
Date:   Tue, 14 Feb 2017 16:34:09 -0800
Message-Id: <20170215003423.20245-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

previous work:
https://public-inbox.org/git/20161203003022.29797-1-sbeller@google.com/

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


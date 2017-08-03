Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F7291F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdHCSUJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:09 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35617 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdHCSUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:07 -0400
Received: by mail-pf0-f174.google.com with SMTP id t86so9378312pfe.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CFDB6f6opk0OACnTh7SbMBuZoebCgTAt+Wgv3VCuGfQ=;
        b=lcTYFL5XRzXag62xUCEtDEnVDaZuqG8j3F+8R76voXnDercQ/cLOWwmw8hgRIvQrv/
         o7JVb13kCxY/W7sBflB1Ti8xuSlUtlWVyYR3Tt5JrRC1EKOqz4bb+ZC5g3f2sQOZagF9
         jwRDfhfcidJm8R+4s3mYmtsXBDNruSuPLsU7BhLTDq22qnJRAD8sqPOTQUmpjaP5PvR8
         Bj3Tx6jvhROH+zIGehwP4vIbs4poGvmGRTB5R6U43kwnShjHIoSCidmcEWpY1i/F3Knw
         trSZf8DaMt3M8uZvctR5n1WKahJrXdkthow9fJ6/Wqw6sUsym78IZEsnwL9qtdbBzIDH
         /5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CFDB6f6opk0OACnTh7SbMBuZoebCgTAt+Wgv3VCuGfQ=;
        b=pcyw6mrxo5jAD2znhLLs/q2DepOlLgIKzbN9C2NJ0UtTMh4il75zR7qfXz5Ed4onv8
         DtNsJIZsz2GBid247w4pFZdPvKj9sfb5JX4k+Z6O0JPlICCLLgA9kHhZx1UR0PN61XAC
         dZ5DC7LB28oUi/xqZH2hkfebgNctM29BRr3oHS3iIQee8BBbKd0ccw99E+XhvcpfoHBQ
         GcZawQb72m7HcOKLqo9fKT4cntQu6or98aQJrVjOighBSBEBoqCjiS9Fcpm+DPpREZK7
         WXLDh+P8GTR+E8XnxYRlbTHeM7UtuleVhM7/0or6tR0LRejV5GKSCqgiEB3TITBSgL+u
         z9Cw==
X-Gm-Message-State: AIVw113Ed/g6bbze0wwZrRt4UbBazC/oyaCcxajaCsdyTKH5DTQKCaiq
        Gs/H4ZCXD8KvTj/tqv0pBg==
X-Received: by 10.84.179.165 with SMTP id b34mr2874302plc.455.1501784405967;
        Thu, 03 Aug 2017 11:20:05 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:04 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 00/15] submodule-config cleanup
Date:   Thu,  3 Aug 2017 11:19:45 -0700
Message-Id: <20170803182000.179328-1-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 * Rebased on latest 'bw/grep-recurse-submodules' branch (Still also requires
   the 'bc/object-id' series).
 * Changed unpack-trees.c (checkout command) so that it no longer respects the
   'submodule.<name>.update' config since it really didn't make much sense for
   it to respect it.
 * The above point also enabled me to fix some issues that coverity found with
   how I was overlaying the repo config with the submodule update strategy.
   Instead the update strategy parsing logic is separated into two functions so
   that just the enum can be determined from a string (which is all
   update-clone needed).

Brandon Williams (15):
  t7411: check configuration parsing errors
  submodule: don't use submodule_from_name
  add, reset: ensure submodules can be added or reset
  submodule--helper: don't overlay config in remote_submodule_branch
  submodule--helper: don't overlay config in update-clone
  fetch: don't overlay config with submodule-config
  submodule: don't rely on overlayed config when setting diffopts
  unpack-trees: don't respect submodule.update
  submodule: remove submodule_config callback routine
  diff: stop allowing diff to have submodules configured in .git/config
  submodule-config: remove support for overlaying repository config
  submodule-config: move submodule-config functions to
    submodule-config.c
  submodule-config: lazy-load a repository's .gitmodules file
  unpack-trees: improve loading of .gitmodules
  submodule: remove gitmodules_config

 builtin/add.c                    |   1 +
 builtin/checkout.c               |   3 +-
 builtin/commit.c                 |   1 -
 builtin/diff-files.c             |   1 -
 builtin/diff-index.c             |   1 -
 builtin/diff-tree.c              |   1 -
 builtin/diff.c                   |   2 -
 builtin/fetch.c                  |   5 --
 builtin/grep.c                   |   4 --
 builtin/ls-files.c               |   6 +-
 builtin/mv.c                     |   1 -
 builtin/read-tree.c              |   2 -
 builtin/reset.c                  |   3 +-
 builtin/rm.c                     |   1 -
 builtin/submodule--helper.c      |  51 ++++++++------
 diff.c                           |   3 -
 submodule-config.c               |  65 +++++++++++++----
 submodule-config.h               |   8 +--
 submodule.c                      | 148 ++++++++++++++-------------------------
 submodule.h                      |   6 +-
 t/helper/test-submodule-config.c |   7 --
 t/t4027-diff-submodule.sh        |  67 ------------------
 t/t7400-submodule-basic.sh       |  10 ---
 t/t7411-submodule-config.sh      |  87 ++++-------------------
 unpack-trees.c                   |  81 +++++++++------------
 25 files changed, 192 insertions(+), 373 deletions(-)

-- 
2.14.0.rc1.383.gd1ce394fe2-goog


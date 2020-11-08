Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC4C388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4953820656
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5qBBKqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKHVlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:21 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A801C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:21 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so1791901ljh.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TmeWXwKGo4+1kPsuXtDLZh8dp/d2ottRoOvy0+NEm/s=;
        b=p5qBBKqikfS6KJMXjURWKiVQ2RCpWJG+i8JUPslXc6ttO9ej6ANfhcQvaWlsZCJWOQ
         M0Lz9GpmBMXBWYk+fsZLfBEVVc/teEb76oeneDm11xfn9wMi0fWU5+JhEnlsEr9jKd9l
         HiKBBYU0G2r1mDc9ii4gOlvqx00LsutHfFlaWbTlHHpFjbOeVmOE32wi4tdbu+8KUqKq
         +e2DJjYxSFksnafMpU20rF0zLXpB5RMbRNgY6TcsRKdK7p+OwH4tOvqoW5rQ6wmBgYUS
         4RBpw9cS/glMc8hjuVzvFlS9uzvoOOiHhDaeDgIDFvqPbudu8wryU56V/RxdF/rx4ef1
         oj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TmeWXwKGo4+1kPsuXtDLZh8dp/d2ottRoOvy0+NEm/s=;
        b=T7TCx5r61+TDxSBGx390EndVAKIamk98qCWx6H8PkCpNHriwi8rXEISb3LOrFB3qO1
         2c2sC5GjZpLMngeycIVmrShE1G+a5zY92+XVhiJpqdctLscGudXtpoLNtggWUUvMEe0j
         XSzTpW1uUupijAUMvhki/hqoPcbA+uXPtqOJWelw6sz3mlxHFWfAD+dD11zpEYgcxuwW
         1w4axWrCqlWd1u79ZZm7hxq4PKifPh4j85Wz6HB6Xhj5ycSuFTeIQwrGubB/Mj07tSk3
         OkKHLgaerxHUs95AZZ1IpMwx3TMnfJBV5c+91M8jBEk8IkKnXGsqX7c8EFGZwvM56ISE
         Zitw==
X-Gm-Message-State: AOAM530re/16XhwelznVk+j4+FKhsIoU32V5Y0lKA3DmT8oJn336QWI8
        zOE3oK1VdN/OaOOfVRNm96E=
X-Google-Smtp-Source: ABdhPJzG20ENYCWMwYw+X1i9v8J1lf1DpbvYl8aBfE13EGivPyL8y783rY4ix5zEz9yZVE/zoT7reA==
X-Received: by 2002:a2e:bc04:: with SMTP id b4mr3974638ljf.101.1604871679712;
        Sun, 08 Nov 2020 13:41:19 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:18 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 00/27] git-log: implement new --diff-merge options
Date:   Mon,  9 Nov 2020 00:38:11 +0300
Message-Id: <20201108213838.4880-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patch series implement new set of options governing the diff output
of merge commits, all under the umbrella of the single --diff-merges=<mode>
option. Most of the new options being synonyms for -m/-c/--cc options,
there is also additional functionality provided, allowing to get the format
of "-p --first-parent" without change in history traversal that
--first-parent option causes.

The net result of these series are the following new options:

--diff-merges=	 |  old equivalent
-----------------+----------------
first-parent     | --first-parent (only format implications)
separate         | -m
combined         | -c
dense-combined   | --cc

The series also cleanup logic of handling of diff merges options and fix an
issue found in the original implementation where logically mutually
exclusive options -m/-c/--cc failed to actually override each other.

The series start with the set of pure refactoring commits that are expected
to introduce no functional changes. These are all commits up to and
including:

"diff-merges: revise revs->diff flag handling"

The aim of these commits is to isolate options handling for diff merges so
that it could be easily understood and tweaked to ease introduction of the
new options.

Then the fix of -m/-c/-cc overriding issue follows, starting with a failing
test and followed by the fix.

Then follows a little bit of additional refactoring in order to prepare for
introduction of the new options, and finally the series are finished by the
implementation, testing, and documentation update for the new options.

Updates in v1:

	* Added documentation fix for git-show to include --diff-merges.
	* Fixed typos in commit messages noticed by Philip Oakley.

Sergey Organov (27):
  revision: factor out parsing of diff-merge related options
  revision: factor out setup of diff-merge related settings
  revision: factor out initialization of diff-merge related settings
  revision: provide implementation for diff merges tweaks
  revision: move diff merges functions to its own diff-merges.c
  diff-merges: rename all functions to have common prefix
  diff-merges: move checks for first_parent_only out of the module
  diff-merges: rename diff_merges_default_to_enable() to match semantics
  diff-merges: re-arrange functions to match the order they are called
    in
  diff-merges: new function diff_merges_suppress()
  diff-merges: new function diff_merges_set_dense_combined_if_unset()
  diff-merges: introduce revs->first_parent_merges flag
  diff-merges: revise revs->diff flag handling
  t4013: support test_expect_failure through ':failure' magic
  t4013: add tests for -m failing to override -c/--cc
  diff-merges: fix -m to properly override -c/--cc
  diff-merges: split 'ignore_merges' field
  diff-merges: group diff-merge flags next to each other inside
    'rev_info'
  diff-merges: get rid of now empty diff_merges_init_revs()
  diff-merges: refactor opt settings into separate functions
  diff-merges: make -m/-c/--cc explicitly mutually exclusive
  diff-merges: implement new values for --diff-merges
  t4013: add test for --diff-merges=first-parent
  doc/git-log: describe new --diff-merges options
  doc/diff-generate-patch: mention new --diff-merges option
  doc/rev-list-options: document --first-parent implies
    --diff-merges=first-parent
  doc/git-show: include --diff-merges description

 Documentation/diff-generate-patch.txt         |   6 +-
 Documentation/diff-options.txt                |  54 +++++
 Documentation/git-log.txt                     |  39 ----
 Documentation/git-show.txt                    |   8 +-
 Documentation/rev-list-options.txt            |   3 +
 Makefile                                      |   1 +
 builtin/diff-files.c                          |   5 +-
 builtin/diff.c                                |   9 +-
 builtin/log.c                                 |  18 +-
 builtin/merge.c                               |   3 +-
 diff-merges.c                                 | 120 +++++++++++
 diff-merges.h                                 |  18 ++
 fmt-merge-msg.c                               |   3 +-
 log-tree.c                                    |  17 +-
 revision.c                                    |  38 +---
 revision.h                                    |   7 +-
 t/t4013-diff-various.sh                       |  10 +-
 t/t4013/diff.log_--cc_-m_-p_master            | 200 ++++++++++++++++++
 t/t4013/diff.log_-c_-m_-p_master              | 200 ++++++++++++++++++
 ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++
 20 files changed, 788 insertions(+), 108 deletions(-)
 create mode 100644 diff-merges.c
 create mode 100644 diff-merges.h
 create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
 create mode 100644 t/t4013/diff.log_-c_-m_-p_master
 create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master

-- 
2.25.1


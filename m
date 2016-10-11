Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6007820989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbcJKAVY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:24 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33739 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbcJKAVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:23 -0400
Received: by mail-pa0-f51.google.com with SMTP id vu5so3981173pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5K3dHdfA22pKCCHL9OZQ1/DKN7mDttNToiE+Vbrm/Jc=;
        b=nrP/h7cslTMNv2K46GwYkAAJDvzvSa8tswefjrdtMSxmcL93+cfmM4kRm+zZlOJGQN
         eAWypHahbQWuMcF/UYucSpi5IrafZVIqj/mknGjgsrQAd/wn73xDkSSC5jfDV7YVFnRZ
         4lOI5RIxtvTrjUylbkqh58OG3huuCUtGJAR99pE+aE2SyCFlxlt1KcHfJhEHsE1hrGMF
         59DsUudC4NnbrrhQ4FR6O5c480bq6u1SLcTmnBKrzXmbTpoJXzg2N7QxL9b0fBVf3DgZ
         RhGVAQpdcbd2zN5JiMQoyNtzeJ/52QhXkp2A7B1Mf+hmWfyQadKvnuOHYQdq5+rGXdVb
         li4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5K3dHdfA22pKCCHL9OZQ1/DKN7mDttNToiE+Vbrm/Jc=;
        b=fEYjLcd7Cfwzoq+Xa2s2PsTPH2hcSEI6PiRdHgXk1vsIkbtGzAjGXf7CGRz3z89KRN
         r7KdRg7GrS4tPlILnJ7ABZP1Yuu2kEYTEZvycwvl7Z3+zN9DUlPlGVhFnPo+tVLv84ON
         BM4c6k+y2UrFG1MYnX3KeOmg8MRGW2el6lX71fy/tmbq5IM4fYolA7Nai/Qx56ZJqzzy
         gfbxbkhqcIW07/gYdJN2yyha7KKApQDqLgai5IwfrnB3fojOnOAALetGU8s2b8F9cvnb
         Yb3QwAvZd5xEWY/SZsIyJUsDyK9Rv7KHJhMqBT7I1HW+e8LVjymrxUAgjgBf2qZ8ZrKt
         UaUQ==
X-Gm-Message-State: AA6/9RnAt4bQRgnyn+DVzo3PVVxRFqoBc1JarQXLmFGwVMm9BvHoZNjvGCSpydHEcVQ4cxX0
X-Received: by 10.66.193.199 with SMTP id hq7mr1738230pac.70.1476145282157;
        Mon, 10 Oct 2016 17:21:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id o82sm531985pfk.24.2016.10.10.17.21.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:21 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/28] Revamping the attr subsystem!
Date:   Mon, 10 Oct 2016 17:20:47 -0700
Message-Id: <20161011002115.23312-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series that
* replaces jc/attr-more. I did merge one fixup! commit at the appropriate place,
  as well as resolving a minor merge conflict when rebasing to the latest master
* revamps the API of the attr subsystem, such that it can be made thread safe
  in a later step easily, because the expected changes are only in attr.c
  
I think this is a start to the minimal set of changes such that we can rebase
sb/pathspec-label and sb/submodule-default-paths on top of these eventually.

Thanks,
Stefan

Junio C Hamano (24):
  commit.c: use strchrnul() to scan for one line
  attr.c: use strchrnul() to scan for one line
  attr.c: update a stale comment on "struct match_attr"
  attr.c: explain the lack of attr-name syntax check in parse_attr()
  attr.c: complete a sentence in a comment
  attr.c: mark where #if DEBUG ends more clearly
  attr.c: simplify macroexpand_one()
  attr.c: tighten constness around "git_attr" structure
  attr.c: plug small leak in parse_attr_line()
  attr: rename function and struct related to checking attributes
  attr: (re)introduce git_check_attr() and struct git_attr_check
  attr: convert git_all_attrs() to use "struct git_attr_check"
  attr: convert git_check_attrs() callers to use the new API
  attr: retire git_check_attrs() API
  attr: add counted string version of git_check_attr()
  attr: add counted string version of git_attr()
  attr: expose validity check for attribute names
  attr.c: add push_stack() helper
  attr.c: pass struct git_attr_check down the callchain
  attr.c: rename a local variable check
  attr.c: correct ugly hack for git_all_attrs()
  attr.c: introduce empty_attr_check_elems()
  attr.c: always pass check[] to collect_some_attrs()
  attr.c: outline the future plans by heavily commenting

Nguyễn Thái Ngọc Duy (1):
  attr: support quoting pathname patterns in C style

Stefan Beller (3):
  attr: make git_attr_counted static
  attr: make git_check_attr_counted static
  attr: convert to new threadsafe API

 Documentation/gitattributes.txt               |   8 +-
 Documentation/technical/api-gitattributes.txt | 114 +++++--
 archive.c                                     |  27 +-
 attr.c                                        | 413 ++++++++++++++++++--------
 attr.h                                        |  69 +++--
 builtin/check-attr.c                          |  59 ++--
 builtin/pack-objects.c                        |  22 +-
 commit.c                                      |   3 +-
 convert.c                                     |  44 ++-
 ll-merge.c                                    |  38 +--
 t/t0003-attributes.sh                         |  26 ++
 userdiff.c                                    |  22 +-
 ws.c                                          |  22 +-
 13 files changed, 561 insertions(+), 306 deletions(-)

-- 
2.10.1.382.ga23ca1b.dirty


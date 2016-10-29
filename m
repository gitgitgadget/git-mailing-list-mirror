Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88CA72035F
	for <e@80x24.org>; Sat, 29 Oct 2016 00:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754955AbcJ2AFQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 20:05:16 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34785 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbcJ2AFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 20:05:16 -0400
Received: by mail-pf0-f177.google.com with SMTP id n85so44900464pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 17:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZMh0AVBI7l9ynq46KTZeTwEwCobTYPlZ58WegV38mqE=;
        b=EVBz4hXLVk7ymyuIznGob6OgTByXbD63OWiygJI0mTIlZ72+if/Otf/Jy8cG0Zy09c
         0E6V+iSbry+ABmCWMA4LSJ3vQBA2Zf5nuWipuXKnzs01guGsO17V/2XRdV6JQyEUxEoj
         VDpbgeIMbmurZ6j6YqJdQtMrluYnUdPIjdmuSD8272G6b32JbrU0cbVT3u68MOjHB3mn
         tAY04nRvNjQpKpz0KZp9cDzjQFT0H+qf7miQhgIF5akRHWjmM7KkCxb1g4gJOpkUT4F1
         cYy6HnWF0Ati/5J3RUoMESKSOHLzGzDmSrHURpH7ZK7UN/dyQgNNH7suOga4xJCtBcY2
         ax6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZMh0AVBI7l9ynq46KTZeTwEwCobTYPlZ58WegV38mqE=;
        b=FyPNu9LIqS7KUXMRqgDnvMo8P3m/QuBRyHe4SpJuyAVKYaEwyHzkiO4TQkC8je1bY4
         6o2J04WdQDu8fucvzNQtaTPAxGgGDHhBwLHl2j2vszx4Ef2KoS2qlcTZlUwoZV5taPJq
         cp6zmMqAYZWYWpgR600OxC5iYcCBVaLfU/1di2oqzOAuSRrDaLuZqxBBxXY0uFLOBs3D
         G+3ZFwAO3O2PkSFR16GLB9A+Ii9mp/m1X0NFBjjLQmD3niJGPMBfQyhXoPJrMp9QhDds
         nNtpveJJY7o5x/Gm5TXgkV27B6J0wQntf+2jOdHlSoqW3K9OWSWo+4sNCCbawyCDk/Qv
         XAhA==
X-Gm-Message-State: ABUngvcBVuV4iy78YHx2hfRYxbgNAFFjeAgeCoTFdHPSSby2ThhykpjytOpgrYqKL4o0jgLF
X-Received: by 10.98.44.212 with SMTP id s203mr29296689pfs.84.1477699515162;
        Fri, 28 Oct 2016 17:05:15 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id b66sm21356750pfg.10.2016.10.28.17.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 17:05:14 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/4] Make other git commands use trailer layout
Date:   Fri, 28 Oct 2016 17:05:07 -0700
Message-Id: <cover.1477698917.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is built off jt/trailer-with-cruft (commit 60ef86a).

This patch set makes "commit -s", "cherry-pick -x", and
"format-patch --signoff" use the new trailer definition implemented in
jt/trailer-with-cruft, with some refactoring along the way. With this
patch set, the aforementioned commands would now handle trailers like
those described in [1].

[1] <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>

Jonathan Tan (4):
  commit: make ignore_non_trailer take buf/len
  trailer: avoid unnecessary splitting on lines
  trailer: have function to describe trailer layout
  sequencer: use trailer's trailer layout

 builtin/commit.c         |   2 +-
 commit.c                 |  22 ++--
 commit.h                 |   2 +-
 sequencer.c              |  75 +++---------
 t/t3511-cherry-pick-x.sh |  16 ++-
 t/t4014-format-patch.sh  |  40 +++++--
 t/t7501-commit.sh        |  36 ++++++
 trailer.c                | 295 ++++++++++++++++++++++++++++-------------------
 trailer.h                |  25 ++++
 9 files changed, 313 insertions(+), 200 deletions(-)

-- 
2.8.0.rc3.226.g39d4020


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302E920323
	for <e@80x24.org>; Sat, 18 Mar 2017 10:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbdCRKMb (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 06:12:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34225 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdCRKM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 06:12:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id b5so13174143pgg.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 03:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Y36LrsVx1oA5OntK/iuIFJ8d6Q1RSXst3jR9+lBv58=;
        b=rkeyJm+pROJeVrVTtveJ4d+11FQGfUHsB9RveCruRQ/u4jgYP1j1bnY+cFcS5Pz9jO
         ictooiP1Z/K1Tqa5F/osWb2p6T2NuLNtk4wzt2jjizPKRkSLAu8ugaLWCDO0eDbKa3R1
         Ldj+z+XbhXaIdff2xtB+bMdP1vC3bj95dAklTlobgb0KOzQlaNKXF1J5Ql1Hs42s1JBn
         6DEpVlePvOPxgeNQ3O8A7XniiOZQvj9eDYeYfJXuWnBHHx54fdDQsgTMV/0QS+9DUVbt
         nxzDEqC0nVOySMSgbVqSCcjzLFb02n4xxC28sj+7mqyA+ZuSKKtQHl6D6X0fryZr6DPD
         baTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Y36LrsVx1oA5OntK/iuIFJ8d6Q1RSXst3jR9+lBv58=;
        b=JL05ASg4vNihvuvqdU7/ejouRHuY0gosP8nv8n43HQLfLchIZ3v6NUfOSjrRdus6Rp
         SLt/ukL2rtNuGAOlCZkNZGTNKxOPWe4m3x2+7kxjwL0syuL/2AHzk2L3EWvhicdmskbH
         jwpRdouDHgtR6WXBlt6IJ7J5T6ocd0twb+xYq2soBlOMtZqkYyKrL7edQ/5d6altAaV2
         fWuDdzScmqM2ePJCiAshXLYvEC+89ATQp18kgtPTHBhwbv4qxg00I/em7+g3+rDvRa9T
         yLb6yzNJqUj009YqRAjslbShdMiXc7mGk/kjfZvMXQpTUtDBORMl2TYc3lzjHkYNximN
         dO0w==
X-Gm-Message-State: AFeK/H0A4Tar3S/tYB0/3UV0n9dSW59Xz4QwOnIr8kSlhRyh7k6tC4TgU/obOjT7q7dJmg==
X-Received: by 10.99.188.10 with SMTP id q10mr20902642pge.106.1489831921096;
        Sat, 18 Mar 2017 03:12:01 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y184sm21936418pgd.45.2017.03.18.03.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:12:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:11:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/12] Fix git-gc losing objects in multi worktree
Date:   Sat, 18 Mar 2017 17:11:41 +0700
Message-Id: <20170318101153.6901-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is basically a rebased version after a lot of changes in
nd/files-backend-git-dir. Thanks to test-ref-store.c, I found and
fixed a bug in for_each_reflog in v1 code.

This series needs latest nd/worktree-kill-parse-ref [1]. But you can
get everything on my github fork, branch prune-in-worktrees-2.

[1] http://public-inbox.org/git/%3C20170318100206.5980-1-pclouds@gmail.com%3E/

Nguyễn Thái Ngọc Duy (12):
  revision.h: new flag in struct rev_info wrt. worktree-related refs
  revision.c: refactor add_index_objects_to_pending()
  revision.c: --indexed-objects add objects from all worktrees
  refs.c: refactor get_submodule_ref_store(), share common free block
  refs: move submodule slash stripping code to get_submodule_ref_store
  refs: add refs_head_ref()
  revision.c: use refs_for_each*() instead of for_each_*_submodule()
  refs: remove dead for_each_*_submodule()
  revision.c: --all adds HEAD from all worktrees
  files-backend: make reflog iterator go through per-worktree reflog
  revision.c: --reflog add HEAD reflog from all worktrees
  rev-list: expose and document --single-worktree

 Documentation/rev-list-options.txt |   8 +++
 reachable.c                        |   1 +
 refs.c                             | 110 +++++++++++++++----------------
 refs.h                             |  12 +---
 refs/files-backend.c               |  46 +++++++++----
 revision.c                         | 130 ++++++++++++++++++++++++++++++-------
 revision.h                         |   1 +
 submodule.c                        |   2 +
 t/t1407-worktree-ref-store.sh      |  30 +++++++++
 t/t5304-prune.sh                   |  37 +++++++++++
 10 files changed, 277 insertions(+), 100 deletions(-)

-- 
2.11.0.157.gd943d85


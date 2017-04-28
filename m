Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CC3207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2997758AbdD1XyV (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 19:54:21 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36618 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948134AbdD1XyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 19:54:12 -0400
Received: by mail-pf0-f173.google.com with SMTP id q66so10741439pfi.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fQcSP/yqspPaD0Old+huIoGc/Rw/46RKpnRtzKLEXHw=;
        b=jHWxkjNglIRilf+MdATcesToDILkKpyhY54ztDaq3ypbVUjlKt1bKwbtJGseoaOsyJ
         Er2lwqpYI81m3j6SH5CLZef/RaCilD4CifAfqjqLtZ6fASLMixfb2zb3RLe1YutDnHKx
         g9am2z1SdHi+xmsCeLDqWjFgzJ9qhXNC7UUyVLrEU5bFEZ2Hr7EdaC3nhf87mS50fONe
         GY+aXfPpHgAM79xFdSTJGiCJzj4sE9uGVh7niISp7vCn0B2IJPThCO4NCIqNitGqu1qp
         zcqwkTAkNp5/fgJdBA8TQgycsALhyrkt1Eegj+Z0Sm4Scp+L6iw/2iK7W2W+ZrDbkYuW
         CYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fQcSP/yqspPaD0Old+huIoGc/Rw/46RKpnRtzKLEXHw=;
        b=Emer5M84RXLaNy4No6/0mHioc2VaNdW5mDT7XFkm9HLrExStGxYj0Qf1ytx1U2D53q
         MS/W6fcjl++NrXIADYVa8s3AcMlwo1P1iIuN990hh9U0TS7SioVq1jrE+JQRzB0E9jLa
         7ISE6qdoQqOXVNzj0/n6SMqtLGAopqZn/KLOvtls+GH4sp0oYRNGveB4ojELCyQMJQnd
         RGYrNJT8EH1yHSeYrEM5yGKyIXvfV9G8XQ5w2Z82ApknagrlEhg7At2xJKqd6I848KjW
         /bCvdZBTEQDTm88HiBclf5UBk5fLnM0Uf8nMqJxCl8FMN+1fm7A5PVwvua6KK3Kjq7UL
         2hIA==
X-Gm-Message-State: AN3rC/48o8blg24QyC8HuRpsO2CrpXwjC0lTblRAv+NyG/7mv3i5FrP1
        5bedPNAL9nV9smykaJRy6Q==
X-Received: by 10.98.79.214 with SMTP id f83mr14614113pfj.201.1493423650568;
        Fri, 28 Apr 2017 16:54:10 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 188sm5332429pfu.15.2017.04.28.16.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 16:54:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/6] changed submodules
Date:   Fri, 28 Apr 2017 16:53:56 -0700
Message-Id: <20170428235402.162251-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A little bit ago I was looking for a function in our code base which would be
able to give me a list of all the submodules which changed across a number of
commits.  I stumbled upon some of that logic in both our recurisve fetch and
pull code paths.  Problem is both of these code paths were performing almost
identical tasks, without sharing any code.

This series is meant as a cleanup to submodule.c in order to unify these two
code paths as well as make it easier for future callers to be able to query for
submodules which have chagned across a number of commits.

Brandon Williams (6):
  submodule: rename add_sha1_to_array
  submodule: rename free_submodules_sha1s
  submodule: remove add_oid_to_argv
  submodule: change string_list changed_submodule_paths
  submodule: improve submodule_has_commits
  submodule: refactor logic to determine changed submodules

 submodule.c | 295 ++++++++++++++++++++++++++++--------------------------------
 1 file changed, 139 insertions(+), 156 deletions(-)

-- 
2.13.0.rc0.306.g87b477812d-goog


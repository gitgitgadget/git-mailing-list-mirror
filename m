Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354AF1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 06:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeGUH0L (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 03:26:11 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34254 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeGUH0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 03:26:11 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so5472602ybq.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cd9Blh1jytQskkY6EAWWk6fk9oUbGU7dF6M2J02c9dA=;
        b=T8pwRlAHWGNa+KLr6dSrhhnfSC0puSRO6gMylgeIICtGSBAFKof16gjw5qwpXXQIqp
         9DmBYnB0STtqy6rGs9Y2xoxB+Mb73IkGPw+Usf+idJgXDA4/womqIH2y1FC3IBbgwr5I
         Z0fMh48IMHLrZdsNSCN03BS9s6O7Ru4C0TA5SomyGu1Kbd3XaL00vVTXx7C4nZrNTwYC
         QBLACty4NThAbhbcdFzHiY5Rb4wDRiQ4j6JJiF8eh0TBKa9g8TcCx5iBW/7VQJoUSnGu
         3jQ6yE7fYhpE1V0fo23G1u9lDzx3y34l4dIDEKxAlsG9T1pS7Sc674zUVpSuhg8Rv/wU
         hifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cd9Blh1jytQskkY6EAWWk6fk9oUbGU7dF6M2J02c9dA=;
        b=N0ZyuQgXeHlpaO2QI9e8VooOFKvspdFGd/kg4eVTjx9AkiHesrwdo/UogjZbPaawh7
         ou33tSl+eBTrQ1DXlDoQPZEAwE8x4FJ6ZxQdsCjgb0TfR9zjx0jLJJrIvjhP7DOh+3u0
         jRKaL5VbknirrX+N1H04/ixYn8QzrWbGB9i+OZ5w/P1eiGBF0lEAofTrstK6jeo7HvIz
         TrWhajBHqmwKxODSn9zhe26Jc58vD11CL4uWoTcfZC7g6SHOZoIeNZm/HXGVRDtMKyRZ
         1/yXyty07ny9+Db9ZYRMtlBz/rADMZTme9LnUrwUHHRVstmWsDfBP87Dw8qDOW1jT5ZQ
         im9Q==
X-Gm-Message-State: AOUpUlGAWCgHSHoeUHhooRXCEgCBijPagNd2QB84ZNuP4VvKFQGwJOFY
        2sO5JYO+vzQk54aX0BXbRiooNS/X
X-Google-Smtp-Source: AAOMgpdqbS57vN8Mt8FOxv5cy2hdf1kbXxLM3SxKSSp/IRoyCDWg8mIs1Je3fSCGOiq7X84aWm42xQ==
X-Received: by 2002:a25:6806:: with SMTP id d6-v6mr2593623ybc.276.1532154876789;
        Fri, 20 Jul 2018 23:34:36 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id w199-v6sm1739509ywd.104.2018.07.20.23.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 23:34:36 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, kewillf@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Preserve skip_worktree bit in merges when necessary
Date:   Fri, 20 Jul 2018 23:34:26 -0700
Message-Id: <20180721063428.20518-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.234.g2d1e6cefb
In-Reply-To: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge-recursive used to update files in the working tree
unnecessarily.  This was reported by Linus in the 2.18.0 cycle and
fixed in commit 1de70dbd1 ("merge-recursive: fix check for skipability
of working tree updates", 2018-04-19).  Unfortunately, this bug masked
another one: that merge-recursive cleared the skip_worktree bit for any
files marked as unmerged by unpack_trees(), even if a file-level merge
was clean.

This series fixes the clearing of the skip_worktree bit for files that
merge cleanly and match HEAD.  A future possible improvement exists to
also avoid clearing the skip_worktree bit for files that merge cleanly
but do not match HEAD (for such cases we'd still want to write those
files to the index, but stop updating them in the working tree).

This series applies cleanly to either maint or master (or next or pu).

Two important notes:
  - Need a sign-off from Ben for the first patch
  - I'm out on vacation next week, so I won't be able to respond to
    feedback or handle any necessary re-rolls until I return.

Ben Peart (1):
  t3507: add a testcase showing failure with sparse checkout

Elijah Newren (1):
  merge-recursive: preserve skip_worktree bit when necessary

 merge-recursive.c               | 16 ++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 13 +++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.18.0.234.g2d1e6cefb

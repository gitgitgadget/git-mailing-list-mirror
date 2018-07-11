Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957801F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 05:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeGKFVI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 01:21:08 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34252 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeGKFVI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 01:21:08 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so9545122ybq.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 22:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lQOOQSm2ZHt0FtQG/TrmPlZDcIUDH9ixcD7gx49bMJU=;
        b=SLwXm6Rz0m/ILgm5peivCHNytQx9AAm9V5r2R/1E924oB6K4R59wIXyEdlNtcAUiil
         JN0hRTlbUoLXOLsaCA9DslktkS0b65vofuVnS+aUn6SKrTl+4tL/t8Jo958dp85M0Uul
         G7B5NjqsL90caEPARDbRC6WRA0HHFw1mtTNBSD72hNsbc02l3zaxLL/EI8LA7cDOGLL4
         bH4IyXh3PXrYkICdr8ThT/s3r8Pf9qFZ+cGbe4gIqwk86TVp/G0cf81xYXL4sZQZL8ci
         FopO2lNqLbar8VAc8s1xBeyLgGYgUSK5I95PH+Kg+nMCDwKNWBkRAy7rk2V8+/qxgdSe
         RhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lQOOQSm2ZHt0FtQG/TrmPlZDcIUDH9ixcD7gx49bMJU=;
        b=YVnBxcvZ/v3POE716sZGI2LR/oilgAU6oGGZZq3DoijLsxW19sdddZsXTWq7i5tP9F
         rvoVJg267PUm53IqNz+bu5fj0LgT/Wm9wdkVPh7bb++InQtDZbq1upvRRZcz9l48rH6N
         GcQeUSyuyZmBdAam7i57XnBI3mc0f+kus/rMyvYUztOav6GzTrBCbtJcE7iw7Z0pF8Ue
         bJhigGBbBsCBvkvdqKjaTudu4zMFNGimAs6lPjA++hbzqVk6TRFE03Rr0qXq3pB4Gv1S
         kZdb6aGf9z4pKSFdMbbdl/QHqT9DD1kQroX7SxdilQxmris3rhQkvuBUH1mK4m1utT94
         /7UA==
X-Gm-Message-State: APt69E1p/Klj88kLBk+99sZRQD4rBGwuQdSkl8FGYOlJRRHoVY9etcmc
        TSf8ykkAuAFy5Qu7GC6b4uxSrg==
X-Google-Smtp-Source: AAOMgpdXuzTqxAI31ZXed3Py5dGVSCAFIWqk68rxQ1+mqnj+fbGOKyNWZpWB2o4EBImzcDLS5YOgfA==
X-Received: by 2002:a25:13c2:: with SMTP id 185-v6mr14468213ybt.331.1531286319757;
        Tue, 10 Jul 2018 22:18:39 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x185-v6sm7561851ywb.69.2018.07.10.22.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:18:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Address recovery failures with directory/file conflicts
Date:   Tue, 10 Jul 2018 22:18:32 -0700
Message-Id: <20180711051834.28181-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several "recovery" commands outright fail or do not fully recover
when directory-file conflicts are present.  This includes:
   * git read-tree --reset HEAD
   * git am --skip
   * git am --abort
   * git merge --abort (or git reset --merge)
   * git reset --hard

It turns out that multiple invocations of 'git reset --hard' can serve as
a functional workaround, but I've been annoyed with that workaround for
years.  This time, I found the problem, and this patch series provides a
fix for all of these.


Elijah Newren (2):
  t1015: demonstrate directory/file conflict recovery failures
  read-cache: fix directory/file conflict handling in read_index_unmerged()

 read-cache.c                         |  13 +--
 t/t1015-read-index-unmerged.sh       | 123 +++++++++++++++++++++++++++
 t/t6020-merge-df.sh                  |   3 -
 t/t6042-merge-rename-corner-cases.sh |   1 -
 4 files changed, 131 insertions(+), 9 deletions(-)
 create mode 100755 t/t1015-read-index-unmerged.sh

-- 
2.18.0.138.g557c5d94c.dirty


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4131A201A0
	for <e@80x24.org>; Sat,  1 Jul 2017 00:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbdGAA2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 20:28:43 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34237 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGAA2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 20:28:43 -0400
Received: by mail-pg0-f48.google.com with SMTP id t186so70725779pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 17:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=webGV+0KTekT92llcKvVd65izfVtTFdW0HAwZymblmg=;
        b=dNEHMJ+Mu1+NMweqc+Svyx4jkgnG6ne1fZerA1pjs/7OMpE1XUdWRPz4Dc0dEkbw6B
         sDoCdszT8ndD1koGjXTiHJTiDmxgYfOVqq2uz10l6bN+UUM5GoqjXXd9Kr0sbqYGLrUk
         tdImjNshQe4m2DzQMzo3MSC9+0cDQCMwLqXdkkOC+LmMMcYi/GyFKjR0f9sa8RKv9X9T
         XdBegilavm2+kBvY6qrGWtSMn7ybUYP8861fccG5QbtzN17Nq1boqF6n5uM8xqPwGnIH
         1cmsU5Ixrr3xr9Ycdq/qBKhwyN2zaDldGK0JxSru5bEbXNbfLZOlq7x1vDIbCe4bGOII
         HoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=webGV+0KTekT92llcKvVd65izfVtTFdW0HAwZymblmg=;
        b=rO8F1rLqGkhHY+QeTmK2iefAdWhGUPmyDveFVQJscMVuQb8CQ0GKB/KcvACsFia8ke
         VVsIhK/AofcsVuD/WED4nlKNJTkhd/vOTx+GuXKyB0bDcoIIGwaJHLCO8ZzQ7onqB7IE
         1dOxoGlz71os+rTCzxFMOaeZ0tcI8iZxugDJD1QBYgk+/X5sQDFmYRm6UGIe/RV/jqy2
         Vr3xgOg8r8bxNGubFOKlY533VoVZMcWVlJIHKY0qIPSP9rnpcn75u5dIMSSRd6tgToBG
         zm7E0/Dqz8BBMTXiNLoi1Re6tGOv440SCuBfPrZgrswUkvNs8866SOFyoUmT1i0Hzc2P
         v2Jg==
X-Gm-Message-State: AKS2vOw8764BRjIATwIKQOqUI67sy6efQ08+kun8Bp1xRebMItF9u9oR
        gfJ8bx5A2KdgpOsFbb+HRA==
X-Received: by 10.99.96.204 with SMTP id u195mr23482144pgb.125.1498868922023;
        Fri, 30 Jun 2017 17:28:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:cc8b:7c8c:8e14:f9b5])
        by smtp.gmail.com with ESMTPSA id w85sm25198355pfj.115.2017.06.30.17.28.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 17:28:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/10] Friday night special: hash map cleanup
Date:   Fri, 30 Jun 2017 17:28:28 -0700
Message-Id: <20170701002838.22785-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of sb/hashmap-customize-comparison.
No functional impact but a pure cleanup series:
No casts to hashmap_cmp_fn in the whole code base any more.

This revealed another interesting thing, which is not a bug per se:
The const correctness of hashmap_cmp_fn as it requires all its void
pointers to be const!

We violate this in patch-ids.c as we modify the `fndata` at some
uncritical part (a part that doesn't change the equal-functionality
AFAICT).

Thanks,
Stefan

Stefan Beller (10):
  attr.c: drop hashmap_cmp_fn cast
  builtin/difftool.c: drop hashmap_cmp_fn cast
  builtin/describe: drop hashmap_cmp_fn cast
  config.c: drop hashmap_cmp_fn cast
  convert/sub-process: drop cast to hashmap_cmp_fn
  patch-ids.c: drop hashmap_cmp_fn cast
  remote.c: drop hashmap_cmp_fn cast
  submodule-config.c: drop hashmap_cmp_fn cast
  name-hash.c: drop hashmap_cmp_fn cast
  t/helper/test-hashmap: use custom data instead of duplicate cmp
    functions

 attr.c                  | 12 +++++++-----
 builtin/describe.c      |  9 ++++++---
 builtin/difftool.c      | 37 ++++++++++++++++++++++---------------
 config.c                | 10 ++++++----
 convert.c               |  3 +--
 name-hash.c             | 22 +++++++++++++---------
 patch-ids.c             | 14 +++++++++-----
 remote.c                | 12 ++++++++----
 sub-process.c           |  7 +++++--
 sub-process.h           |  4 ++--
 submodule-config.c      | 18 ++++++++++++------
 t/helper/test-hashmap.c | 34 ++++++++++++++++------------------
 12 files changed, 107 insertions(+), 75 deletions(-)

-- 
2.13.0.31.g9b732c453e


Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793F9C54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5006220BED
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 22:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Fj5U+L6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDTWvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 18:51:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FAC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 18so2043230pfx.6
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=C1C9ZGHg+Y3/wjtkvQLuUr56SYnSOnlIZoHYvqwSPCg=;
        b=Fj5U+L6UpxwGtiyR6xUvHN7WO4+kLDgELkxbSohqlDYhEc4uY3aAZ1zSi1itd80G5i
         QOuAbFz2H+BpyqwX513ns/K5kKv/W+ZivR3UpO8Y4sNm95BTyV4ZHxynMgWc/s8sPTGO
         wM8zIYe6bogBr7pTyFXt2ky8F1/gQZA7A2AViz6ahDxU1JYNB4seh4bDQySnpnGEYhf5
         dcr+4z3xZWC6kr61u8dHY2TPotJ43p8u7TLefMVy5CqziszVcFpld2JlPel2Az3ZMUJl
         YvmX6ScFVQs5lmRFA3FPbmQws+un52hZ8yrD5Kno4WIKKp+pYciOYFkJvYWajI20YYj7
         YYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=C1C9ZGHg+Y3/wjtkvQLuUr56SYnSOnlIZoHYvqwSPCg=;
        b=sI2oNKnse5nMi6UO21qS+moxXDrUhbdXYeN3iv4rVOfzIVkd7+tJuNlyhWnuFHnpPK
         /4D+mXK5vHrGBHHnkyifp6yAT0IL1xRBXxIfQx0isdtvH6p4WUCBVErm9rWxT1oSmrQg
         wKZz+Kd/5Q+80s277Ran8Gb4TfNl8N6PL0w0xJaADbxUNKJ3kt55VAxQlFy5RxiLLc9p
         PgVFCGPbawu5V3YQWKk264IdHfon0+WXSwURxsRVAPY7pcwYrI0t2E2qc6GcjM+zClYx
         KxN4A+0ulAgvTgm66ud9B5zZsoT01SyouH1jNxw4TXgG8lSSPaG6cDz/f2E584T7c2Pr
         SPRQ==
X-Gm-Message-State: AGi0Pub2JwaSWZKTcy30maLxKle7lhMeRugSMazIDSt0S+JPFOVOX/JY
        Nskfi80DheMxi8486BT41jpSBz7XzgX8bA==
X-Google-Smtp-Source: APiQypIEyPPV3+Nlt3WuuaXu53Xuq1g796Lh1cMLSQhsDp3K38wDbmxg3Uc6S3XbIWtu9zi7OTwb+g==
X-Received: by 2002:a63:c70e:: with SMTP id n14mr18471636pgg.249.1587423060117;
        Mon, 20 Apr 2020 15:51:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b7sm525314pft.147.2020.04.20.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:50:59 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:50:55 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, mhagger@alum.mit.edu, peff@peff.net
Subject: [PATCH 0/3] commit-graph: write non-split graphs as read-only
Message-ID: <cover.1587422630.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A colleague of mine pointed out they had occasionally observed that some
layers of a commit-graph chain appear to be have both read and write
permission bits for the user, while others are marked as read-only.

After some investigation, I realized that this only happens to the first
layer in a commit-graph-chain, and occurs when we move a non-split graph
into a chain as the new base. Since write_commit_graph() just renames in
this case, we carry over the 0644 permissions that we create non-split
graphs with, even though split graphs are created to be read-only.

Initially, I resolved this by 'chmod(graph, 0444)'-ing the graph after
renaming it into place, but it ends up being much cleaner if we
introduce an additional parameter in 'hold_lock_file_for_update' for a
mode.

The first two patches set this up, and the third patch uses it in
commit-graph.c, and corrects some test fallout. Eventually, we may want
to take another look at all of this and always create lockfiles with
permission 0444, but that change is much larger than this one and could
instead be done over time.

Thanks,
Taylor

Taylor Blau (3):
  tempfile.c: introduce 'create_tempfile_mode'
  lockfile.c: introduce 'hold_lock_file_for_update_mode'
  commit-graph.c: write non-split graphs as read-only

 commit-graph.c          |  3 ++-
 lockfile.c              | 18 ++++++++++--------
 lockfile.h              | 19 +++++++++++++++++--
 t/t5318-commit-graph.sh | 11 ++++++++++-
 t/t6600-test-reach.sh   |  2 ++
 tempfile.c              |  6 +++---
 tempfile.h              |  7 ++++++-
 7 files changed, 50 insertions(+), 16 deletions(-)

--
2.26.1.108.gadb95c98e4

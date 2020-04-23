Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B9FC54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CAD2074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="t9xVwZ8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWVlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:41:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1921BC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so2865305plp.13
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7AWHJJaSc684L9Q8J85/EV64P2hymigkar6uAU5qrmY=;
        b=t9xVwZ8JMFyCwaVb2N+as1k++Z8BIg+q70g6pD1MUplHWyEhYKoTK+m7gG66jqyRlz
         GXwjFCHOWyDnuuNiUflt7RzPKbwvFQ2EfDz0D/X/da6Hil6mDAq9TK7RktFmAmTNBGGf
         XYy9W7mebvdgh5RIwavEYyLdMFzwCda/bRG64BBJQODVmYFPQ+QC7LfU/8/NvNlpt+0c
         41Bku0L4kgbY64ThzHUQDAEbCDxyDBlx24Ev9ADAySWAZ1bOJO9nKXoa454FV/jldZMH
         B4WDjm5vqVWsOkmG4Ej6ik26MHHa/T41Gcq3u2o9Ylxz68LZP5mor6OldsMZy2nXjfw8
         t+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7AWHJJaSc684L9Q8J85/EV64P2hymigkar6uAU5qrmY=;
        b=Yrqz6KHW4SE9JdN9eHcQCIgK0CffiI9IKN8XVsXd+Yzaq/vRhg6wM78j9X1cilQ1UV
         yY570fVJ9AOKblb598PdvSczaxBH1PNbdaaQPexi4cOtFCzRPEiu+oyHBxb8YzUfPqTu
         5CR72d4eoCx1uWN2P7JpTV9SApMePAbGcjx5sVE8Xpq2CsJQvGTMfaUDXmYNgWir9bob
         WisS5rakDc+9cbb7CO98wyo2qUX7PrY3PnkecW4Mbh0MRbUYzLgemVhgDMJXoxj9apgO
         m/YWn1GuwHMd/e2gHfRp8RvWXbgpOYpVkcn+ZvWk8zlCz2H45bwKWzdYIlhAPfGIFTD7
         wHFg==
X-Gm-Message-State: AGi0Pua5mIr7OoVYJqds2QFEWqnAc0aKUyWMM6RgyTUYu6PQGTFdU3G6
        q6kAUxBHhwpddALSFgOiE2IjaePXCttcqw==
X-Google-Smtp-Source: APiQypI0ePhJWHFtevOyzLnGj06E1b9fBRelnkw3kNWQHlObod1weKK2EJsXbt0SwOZFZ5ynfALXkA==
X-Received: by 2002:a17:90a:24ea:: with SMTP id i97mr2796975pje.189.1587678060022;
        Thu, 23 Apr 2020 14:41:00 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b20sm3565079pff.8.2020.04.23.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:40:58 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:40:57 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH 0/4] commit-graph: handle file descriptor exhaustion
Message-ID: <cover.1587677671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is another series to handle an issue we started seeing at GitHub on
repositories that have too many commit-graph layers.

This issue evaded me for several days, but the gist is that having too
many descriptors open caused us to fail 'git_mkstemp_mode', which in
turn left some values in 'ctx->commit_graph_filenames_after'
uninitialized. This in turn caused a general protection fault when
trying to free these uninitialized entries. Frustratingly, it causes
stray 'commit-graph-chain.lock' files to stick around even after the
process has gone away, causing all subsequent commit-graph write
operations to fail.

The first two patches are semi-related cleanups and other preparation.
The third patch fixes the main issue described here. Peff contributed
the fourth patch which teaches the commit-graph machinery to be more
willing to close file descriptors.

These patches are very much owed to the help that Stolee and Peff
provided while writing them and for their willingness to let me bounce
some ideas off of them.

Thanks in advance for your review.

Jeff King (1):
  commit-graph: close descriptors after mmap

Taylor Blau (3):
  commit-graph.c: don't use discarded graph_name in error
  t/test-lib.sh: make ULIMIT_FILE_DESCRIPTORS available to tests
  commit-graph.c: gracefully handle file descriptor exhaustion

 commit-graph.c                | 21 ++++++++-------------
 commit-graph.h                |  3 +--
 fuzz-commit-graph.c           |  5 ++---
 t/t1400-update-ref.sh         |  9 ---------
 t/t5324-split-commit-graph.sh | 13 +++++++++++++
 t/test-lib.sh                 |  9 +++++++++
 6 files changed, 33 insertions(+), 27 deletions(-)

--
2.26.0.113.ge9739cdccc

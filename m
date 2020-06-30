Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3CCC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1511120772
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pVQukomi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbgF3RRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgF3RRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00AC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:40 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so16140765qtr.9
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MOYGQHKmt3opTBol8bZEJwpZCdkrnBYmdL1/ylsga7o=;
        b=pVQukomighhe7cWuDPMmx/O/RQQiMbUh8o11q/BxEIfKptP6ywI0dtBFGg1/d8fHok
         V3hV9HBsSGLHC58jIcbq5bZfYR3rKcEh2MJJeELVq2LxZjMubBk8QcW3zocx7AhOVOgg
         rim2wv0dGAiOamwewl2lQyZ0VUpxrYQS74acVWi8bcxJ5mztSYgt7VpUXGrwQo7ikXxn
         eLWrYZlCZLB7StUJGYVnbGSswQSTesKlwQ1rLTckDWieu5eSmO2ZAUo/cwG4sjnat5Hd
         WiiNag0kupPItlaLzKO/JehnG2NOQ6jzJNHLYd7g5W5NvKmiXrkC7np7AF9W50qujTjS
         yzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MOYGQHKmt3opTBol8bZEJwpZCdkrnBYmdL1/ylsga7o=;
        b=YJHb8pL4rFWM6ZdzjEgrpet7BIMf/v9zmu/Obsviw3qVDZ9DSxTjQRFPt3QQNQoeTQ
         86PhY9QgpHRoNXebTTtoVgvYu40rtTKcgpthJWktdqAj3HTqTpn35Vj9t6hJ4+2hsSS7
         7ZmdFX7BP9NxhKwQp+LyJvhoRAVU6VxmA7ak2EQKMhImTA7uz1Zzq7WdQyD+KT/JuKv6
         kDXCNKImH32nF4nkbk8IwqKhUI0QhjYUcsxtfIfYIIWJWxAxf1IKd+wB5AA22gBXINbO
         +XVSNcXd62uRodI3iDYF4GJGrn6NM5/ikGZZ8XTl9GQAcHy5YyNHXJiqhjCS62/2hRL9
         pN7Q==
X-Gm-Message-State: AOAM532r6DkMJJcs2DmaZTelAPREeMbWX01MC8pL6XuTAqEnlqF3fUMe
        jtxp/Xqgywl8VJQ4x3FhMCP37PaUPECiVg==
X-Google-Smtp-Source: ABdhPJxR97KtLvhP9lgRkXGTGFD763aN7vY64HgdNhRBnhp6LQPVtt58n87ZkTgGnPmeGR1qs4iSNA==
X-Received: by 2002:ac8:4b63:: with SMTP id g3mr21695472qts.229.1593537459200;
        Tue, 30 Jun 2020 10:17:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f0ef:6367:5d8f:d7c])
        by smtp.gmail.com with ESMTPSA id f203sm3619756qke.135.2020.06.30.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:38 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:17:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 0/3] commit-graph: introduce 'core.useBloomFilters'
Message-ID: <cover.1593536481.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here are some patches that we have been using at GitHub to control
whether or not Bloom filters stored in commit-graphs are read during
normal operation.

We're planning on using these patches as part of a two-phase roll-out of
changed-path Bloom filters, where the first phase conditions whether or
not repositories *write* Bloom filters, and the second phase (controlled
via the new 'core.useBloomFilters') controls whether repositories *read*
their Bloom filters.

This can also be handy for debugging purposes, say, for e.g., if Bloom
filters are suspected to be corrupt, they can be softly disabled without
dropping the rest of the data in the commit-graph.

Thanks in advance for your review.

-Taylor

Taylor Blau (3):
  commit-graph: pass a 'struct repository *' in more places
  t4216: fix broken '&&'-chain
  commit-graph: respect 'core.useBloomFilters'

 Documentation/config/core.txt |  5 +++++
 builtin/commit-graph.c        |  2 +-
 commit-graph.c                | 17 ++++++++++-------
 commit-graph.h                |  4 +++-
 fuzz-commit-graph.c           |  5 +++--
 repo-settings.c               |  3 +++
 repository.h                  |  1 +
 t/helper/test-read-graph.c    |  3 ++-
 t/t4216-log-bloom.sh          |  6 ++++--
 9 files changed, 32 insertions(+), 14 deletions(-)

--
2.27.0.224.g4cfa086e50

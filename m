Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1FDC4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 129DD60E09
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 02:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGaCmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 22:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGaCmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 22:42:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C9C06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c9so11288454qkc.13
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exVpAd6V96+5p7rDxlS4Axz3OrdrVn8X5c7ZOPebYao=;
        b=EERovquboBzjwjHaADe+9ak0LwwRMm/a7rV65yr+xEOnxrVfbX1eitzennQU5bmv+f
         mlUSEhsXiSPDm/Zb4IHLe7PP0MMjfIwqjqd93KSXrjMG7HYgnnSHESMdRxpgDBZVDTyb
         sPht54E0v1XkTr+1pp0TMksQA23TG+uJzVeIFZYcxNeaCkBf4g7VvBRMMOxdCAFAKXZA
         56QZk8NgZJvTUKw5M8B9b/eSVBPDWPSpgrahwxVAffBXmvFhOUjp3FeU3tgstAskEC8f
         ScQXbQ732WD0Au2tBXuv13u/p655KzZRqyXh3nWUqORfU8AXs1I49DJIxm9RaPgYQU5H
         OqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exVpAd6V96+5p7rDxlS4Axz3OrdrVn8X5c7ZOPebYao=;
        b=Bhp1xQWKzDtG/RSzdpOykOWl87EeKDAHXo2Yj/sB0pqbyUcTgGc8Oum6AZQSv5HM9F
         LOl2iwSIDionMOcHmoPEeOgz4gfnVCl4/tGd3ZlCtTKVMJtCzX6nwABbrEVdfbUrw+Xt
         /9RiqTHMO/77+7lFd4tSpzjVRQ55+a8m8lidKpDKnRtOxof5NMcQMcGy5uY6vzb6BcIi
         yvzwb3bCedjb5dQS2EwhWhxX4xFS4mCf8hKXtsIh20677ulyh4PMwE7sdno2g4UDnc5F
         CKIOBf2GdVK2KKjlJCcu5cfkHQ+WQsn1daf4Srr6OFCYBT0WQUKGz2l9MaQSNWDpUeD/
         l65Q==
X-Gm-Message-State: AOAM53316/V8tDLIfFQUrUfSj8YVPKzgpfKZuQxiCwskzS43LXp5wYhC
        yKcNeoxQmWlWIZFZ9byPqTMVBkoTTfqPMA==
X-Google-Smtp-Source: ABdhPJwbhAGdwjAUUMENYpkgiVWLBZUrKtkWJUAtZvLDPNdNea46PyqPHbkUd016/gwRLWMciv/JCw==
X-Received: by 2002:a05:620a:13f8:: with SMTP id h24mr5241402qkl.350.1627699348598;
        Fri, 30 Jul 2021 19:42:28 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id v17sm1419405qtk.83.2021.07.30.19.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 19:42:28 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 0/6] globals: clean up some global usages
Date:   Fri, 30 Jul 2021 22:42:15 -0400
Message-Id: <20210731024221.2113906-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This patchset moves a few of the configuration parsing functions around
so that they live in the source file which uses the variables that are
initialized through those functions. This allows the variables involved
to be `static` rather than global variables.

Additionally, a global which is only written to is removed
(`core_compression_level`), a file-local variable declared `extern` is
now `static`, and explicit `0` initialization of globals is removed.

In the course of making this patch, I found a number of other global
variables which could be moved into being static if more configuration
parsing functions were created and moved to the relevant file instead of
being parsed as part of, say, "all `core.*` settings" in a single
function. If wanted, I can prepare a patchset for these as well (or
provide the list for discussion of how best to proceed, but it is
currently just stored in a WIP commit I have locally as comments on each
variable).

Thanks,

--Ben

---

Ben Boeckel (6):
  branch: move `git_default_branch_config` to `branch.c`
  mailmap: move `git_default_mailmap_config` to `mailmap.c`
  apply: move `apply_default_*whitespace` to `apply.c`
  config: remove `core_compression_level`
  refs/debug: declare file-local variable to be static
  globals: remove explicit `0` initialization from globals

 apply.c       |  3 +++
 branch.c      | 32 ++++++++++++++++++++++++++++++++
 branch.h      |  5 +++++
 cache.h       |  6 ------
 config.c      | 43 +------------------------------------------
 environment.c |  4 ----
 mailmap.c     | 16 ++++++++++++++--
 mailmap.h     |  2 ++
 object-file.c |  2 +-
 progress.c    |  2 +-
 refs/debug.c  |  4 ++--
 11 files changed, 61 insertions(+), 58 deletions(-)


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
-- 
2.31.1


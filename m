Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F07C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 08:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CC92087E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 08:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ1fQHMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgJAIV2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 04:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAIV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 04:21:28 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7317C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 01:21:27 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id cy2so2495009qvb.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3FlZS5Ku2gQmgKPRUbrJUdwFz31FITToerAxmNjRVI=;
        b=aQ1fQHMY2SIuGSFavKrdufjDP50n+k5h7av5QHLHowO7EQKBovkGBm4zuuO9lc0Q4E
         iCgNpPOwkqDLvZL4pN2VVhEL4uQ7DdPsniOq2FE4klEvLEBY1odpcknb66E6ZlGhQi6k
         FWEEToFhe7zYw3C2REihz2o3MaoddNlnn8u7O6vRN9aBTndFuWElikCiPRZgNOronyB0
         aq4qy7ytwAjueUeXosdoq+wWhQ2KZ9VtmecQdMoX9ULCTuJDW17ArCpA1N+TQqNgZICV
         N64Vgux2E9otqQuKU6b42Mk7Awd969M11sKmfOy4tTuOTgYo035nV8otZRuZsyLvZQhH
         yxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3FlZS5Ku2gQmgKPRUbrJUdwFz31FITToerAxmNjRVI=;
        b=cZRh6ezEbmqs4qocx7nTCZiimJK5TlAGcBnzGAdAj4omwR/BIVMf3IjtXB8c3w7dFG
         dc4IWwwstDD8cMcnTFvThbF+Piqkt5SGzNvkVbHhdxfjryOhZNucaV4RRsOo8TWFw7L+
         zFYzFzz2G8yOgpnm1NJXOijKxO5dROGkAKOTCuqJF/OzEoTgb6g3SePEZfGSKWvGI06B
         DY4Q8skFHlGG3mwT4pL1XPI4dVjZ0tSHqhQ5tV4AD6kZdac//1H9cZT/xFrY7LFbCs4Q
         5KfGbVn4/dS3CZgczxban1SYgJvgbIqFa29RHoteLe1aH9+CDsYLJ8zVNOhQun1eynBh
         GJUw==
X-Gm-Message-State: AOAM533xE/DkxJl1iIl73+O+MduGusjIrEPZcrqhuDdNv3SwZIFjJiTE
        PqoQhhqLztxtVqad6SyPL35EfczneAT/ag==
X-Google-Smtp-Source: ABdhPJwgELyEz+0EImlE+SyDXdqavM6EPJ5tfVu9BZYzHzU6SO35Pek4gX1ht3PfL22SKlua8DSSkg==
X-Received: by 2002:a0c:e5cf:: with SMTP id u15mr6499750qvm.24.1601540486268;
        Thu, 01 Oct 2020 01:21:26 -0700 (PDT)
Received: from localhost.localdomain ([124.123.104.31])
        by smtp.gmail.com with ESMTPSA id y21sm5274805qkj.97.2020.10.01.01.21.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 01:21:25 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
Date:   Thu,  1 Oct 2020 13:51:15 +0530
Message-Id: <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new option: "--force-if-includes" to "git-push" where forced
updates are allowed only if the tip of the remote-tracking ref has
been integrated locally, by verifying if the tip of the remote-tracking
ref -- on which a local branch has based on -- is reachable from at
least one of the "reflog" entries of the branch about to be updated
by force on the remote.

This option can be used with "--force-with-lease" with setups where
the remote-tracking refs of the repository are implicitly updated in
the background to help prevent unintended remote overwrites.

If a local branch is based on a remote ref for a rewrite, and if that
remote-tracking ref is updated by a push from another repository after
it has been checked out locally, force updating that branch to remote
with "--force-with-lease[=<refname>[:<expect>]]" without specifying
the "<expect>" value, can cause the update that happened in-between
the checkout and forced push to be lost.

Changes since v8:
  - Disable "commit-graph" when "in_merge_bases_many()" is called
    for this check, because it returns different results depending
    on whether "commit-graph" is enabled [1].

  - Rename the commit list name, remove redundant comments and fix
    some typos.

Srinidhi Kaushik (3):
  push: add reflog check for "--force-if-includes"
  push: parse and set flag for "--force-if-includes"
  t, doc: update tests, reference for "--force-if-includes"

 Documentation/config/advice.txt |   9 +-
 Documentation/config/push.txt   |   6 +
 Documentation/git-push.txt      |  26 ++++-
 advice.c                        |   3 +
 advice.h                        |   2 +
 builtin/push.c                  |  27 +++++
 builtin/send-pack.c             |  12 ++
 remote-curl.c                   |  14 ++-
 remote.c                        | 198 ++++++++++++++++++++++++++++++--
 remote.h                        |  12 +-
 send-pack.c                     |   1 +
 t/t5533-push-cas.sh             | 137 ++++++++++++++++++++++
 transport-helper.c              |  10 ++
 transport.c                     |   8 ++
 transport.h                     |  15 ++-
 15 files changed, 462 insertions(+), 18 deletions(-)

base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
[1] https://public-inbox.org/git/xmqqtuvhn6yx.fsf@gitster.c.googlers.com

--
2.28.0

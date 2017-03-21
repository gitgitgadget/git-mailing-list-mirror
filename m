Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1602095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932740AbdCUWMV (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:12:21 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33269 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757730AbdCUWMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:12:18 -0400
Received: by mail-wr0-f193.google.com with SMTP id g10so24428720wrg.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aEQZvE/7+MCxLggeDcgch8awA6p7c/Nbn6bFg/UCpGw=;
        b=lPu8aF/Yy4FWU0oW/9KJUOaOv6kU/b0NWdZ9QwZmWYLZVlC6BlKxU8cfCjqNX3+YwJ
         hiuY3esKK3XdP1VEB7jo1rnlurqSLjLcBmYXoLmiyV4Sttt2l7JvZl5K37gWUlzgSXn0
         I+qYJCwn2cShy3Akh6q6SFtR3SJYTB26ail+yoQ0GwoenHJCkNG2uf2iJ69QHnEco9BS
         PD2ceKRVPDk43ZjTdAea8DxjeqxREkAGcVVH1buJUg0Q5dvAvWGV4advv6AfAa4+znbR
         8WbY6onhpRjwu94WItE3Lb61NEniUWOaCmnf5EppWanWBpXtX1odT7+tqfc8lh2v3Z0l
         IVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aEQZvE/7+MCxLggeDcgch8awA6p7c/Nbn6bFg/UCpGw=;
        b=gEN0wkPcXC86xodPQuFHBHdHswAKsE9xLlc52Fg8cd0r8J8X5JwrG/ZvMkesrHKpUQ
         1ZETxK1ZyIDBa4vTLCrMcGKJhbPoo8pzcbqR8mbqg3dXBARRbOXCy2Vyo9sWDj1vnw4+
         rKVQrdxFlD1aIHfpXvjY31vYgI0rul2N1WJg/NbkNiBgHX1L58wP7p63a2rwKNk1rj2d
         dNHMi6cjtaw9TmpIg2szcXrXgrXlfdaQlNRpVtg0WyX3gA3rkkmWxG9jTGscNBVfqc/C
         8b6P50x6SK76clM+Ag3qoYW7xq9vyxtSfZwqNSr0mHoWEyB+SbGK4Y6FedV9AJV0Z/pg
         4AuA==
X-Gm-Message-State: AFeK/H3PcJXS7rKe2wJFY/RMOOl14EPvbnoSjIzcdq2x9JBrosLjU+MDn94X5tkspzKpqw==
X-Received: by 10.223.154.50 with SMTP id z47mr32105582wrb.76.1490134326237;
        Tue, 21 Mar 2017 15:12:06 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id s17sm26696569wrc.25.2017.03.21.15.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Mar 2017 15:12:05 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] Re: [BUG] "git stash -- path" reports wrong unstaged changes
Date:   Tue, 21 Mar 2017 22:12:16 +0000
Message-Id: <20170321221219.28041-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.401.g98d3b1bb99.dirty
In-Reply-To: <20170319202351.8825-1-t.gummerer@gmail.com>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio and Peff for comments and suggestions on the previous
round.

Changes since v1:
- 1/3 now contains the changes that were previously split up into 1/3
  and 2/3, and also makes git reset --hard in the simple 'git stash'
  case quiet unconditionally.
- 2/3 is what was 3/3 in the previous round, and now includes a test
  for the expected behaviour.
- 3/3 is the fix for the bug Peff noticed for git stash -k with
  changes that are not yet in the index.

Thomas Gummerer (3):
  stash: don't show internal implementation details
  stash: pass the pathspec argument to git reset
  stash: keep untracked files intact in stash -k

 git-stash.sh           | 12 +++++++-----
 t/t3903-stash.sh       | 16 +++++++++++++++-
 t/t3904-stash-patch.sh |  8 ++++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.12.0.401.g98d3b1bb99.dirty


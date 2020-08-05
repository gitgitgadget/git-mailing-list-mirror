Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51875C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BB220842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gL9tjknU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHEBVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgHEBVA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:21:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51BC061756
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:21:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id ba2so31259777plb.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y3TJIPgSlOhpPXMQgeJ+p+hOSwozEm0cC28n1jZmGVc=;
        b=gL9tjknUCigwoKaOLFhouvIRhJBrT1ARbuqe86JGMI/hgA3041j/dfiW2nKk4mR/Eh
         sGUv0ezAgd7FkP+awRSvoxNYoh7vkRUMu4+7L9pJKX+zlWlCShrOMWm/uuwH+DFdKibv
         5dO3DR+Oh8I4QmOwuNsbN9LplCNMkuhlv2DCCcPNAs42IKQ4TuHhY2NX40RgpT9SBRPE
         KrOPYB7UN5h2f09oAGi7qEoC6AhDfU57jwgYocah2TIfdKXp/8ekjYqppVQLWtOLYz2/
         F5NIKuRut7yMXks+tHlBOfFry1zKIRO7OTuz5hIBKw4DOu4lOzOyUjx7ccIxMYK1S2I+
         u3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y3TJIPgSlOhpPXMQgeJ+p+hOSwozEm0cC28n1jZmGVc=;
        b=DtEdlrSN7Je85WRr0mVdpcoboVpD+aIFB+AKidmre8+a8MtEn4j7gG1tjJUHykFcre
         WMbFs00/OrGRhDo2bScxLxr0iHEk09Y0yJl3fx7mSH5wCuqArogNjuGJAjwz6lTi4hb4
         /KImBvMefr8uEsL2abmzMZPQW5dSnKIjB5LlnmEnmpJhwB/Y1Laq9C5tKIr5R5shyQLe
         me1TFFpPwqll82K5aojeZoX9G1q58DnHA08LvH9VymHIqe4dYyVa5sEKD6JEnBeKgZV6
         StkOjOJELXTNWTWPSWqWuZkpyq+T2VOlg1dc9wTR0ZO6AREoLkwKPBdUPlLx1OHkBqfJ
         pdyg==
X-Gm-Message-State: AOAM530DxdYx5OkgGqfbkUNbPEc2WaJPYFVbyiX0XuNB4luXL1N/fdlq
        ajQuRqO+6SnT4sR8RrWSzKVL5DyXwwV5UoqfbtFqaZFSL4coNp6VUtZPlyXBYQ2bMmuUGsbyjsp
        xLPImvm01gnDIdgVNAgU/lQxl+LuYJcEGrMWoWRLhQQt2lgNQa8eH+EsfUEuK/6ZiuEAjEn8s5/
        8F
X-Google-Smtp-Source: ABdhPJzobJ/qUqqj45o/JLArtGwu2pnjPWfe0z1DxY0AQOs8Z01v6mE6Ks4NZ3cp5Kc39QTVaEHfRC4zbiBW68tXJ74P
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr746912pjb.0.1596590459026;
 Tue, 04 Aug 2020 18:20:59 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:45 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <401227c2220b6b45d80e21b52e29b6821ca139f9.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 2/7] fetch-pack: allow NULL negotiator->known_common
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a subsequent patch, a null fetch negotiator will be introduced. This
negotiator, among other things, will not need any information about
common objects and will have a NULL known_common. Teach fetch-pack to
allow this.

[NEEDSWORK]
Optimizing out the ref iteration also affects the execution
of everything_local(), which relies on COMPLETE being set. (Having said
that, the typical use case - lazy fetching - would be fine with
everything_local() always returning that not everything is local.)

This optimization is needed so that in the future, fetch_pack() can be
used to lazily fetch in a partial clone (without the no_dependents
flag). This means that fetch_pack() needs a way to execute without
relying on any targets of refs being present, and thus it cannot use the
ref iterator (because it checks and lazy-fetches any missing targets).
(Git currently does not have this problem because we use the
no_dependents flag, but lazy-fetching will in a subsequent patch be
changed to use the user-facing fetch command, which does not use this
flag.)
[/NEEDSWORK]

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6c786f5970..5f5474dbed 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -677,6 +677,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
 
+	if (!negotiator->known_common)
+		return;
+
 	save_commit_buffer = 0;
 
 	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
-- 
2.28.0.163.g6104cc2f0b6-goog


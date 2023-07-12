Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B8EB64DD
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjGLXjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjGLXio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00767271D
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5701eaf0d04so82685297b3.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205097; x=1691797097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/yCMnBjZ80OCGsH7OzR4KkM/rLSwaeYmCJWm+5iPbA=;
        b=TlJFs+EsCjQ871PIpmfwQ5eQbdR6OmZySa29sfWWdF3txtDczPVmVrN7vXGeINaajp
         ryIo2J6kPQ8B12+LliN0j2V2YmBOGHMOjy29Zf5le+txFzBMekPFOxAl8aweiLPUILx2
         X0hIZacLDUAekVVb77NFzYo4nNRt8U4MlMGu3+/Lh5g3LwM6dgbsyv/87gEV+cwuQpoK
         7fT/LUL4PlWBT1tMF8cK53L7aDMvRxbHj8ZUyztVYxD0SIsyAKf8pRfMlD2tNmrdmMyY
         V2923WavukvqCZM+3b9rQt3a0/FkggaLvBUwZdIgBtBv50sDBfQytw2+TW6RIE/ImKun
         ZoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205097; x=1691797097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/yCMnBjZ80OCGsH7OzR4KkM/rLSwaeYmCJWm+5iPbA=;
        b=lBny9bKuBJ932PTK/KltKKamQEBVufTQUhho/EYnip9/D9mu/uaNhX+Bwfjkrldw5c
         BU2VNR+iWwhAe48FiPhpzFQwgSiN9hNgY3md4CH/mMVsr5qLSAs0co1fuU4caheej7eF
         0UVulhk+OPjim/xnSoOIslnrOUJjzTHwlCrMQqfgHSIYeJwqOIIfXgGcVZVODiHuR8Ze
         hRV2xScrExNlBbGtOwuRN5eay6KkSpG7xdG8X1WRWRcmPbFAFx0U8kqEHWs/UVhRLjZD
         mxJ2ek2T+8Ry6kL9Ut6tYZxAn7eyib20KoEXC+V+E+TjRLw5EtbyAT5lvDeMKX8qwkuh
         x89g==
X-Gm-Message-State: ABy/qLZL5ZNNObDp4MkpIE4cA9aoNKEmMzJ00ONO2hJZCBq6yhl7mdcj
        C2iZXotwJmCbmgBexRL/via0Uf4zQItM578F8yCsmw==
X-Google-Smtp-Source: APBJJlGsLk8RCBkf9thnADcVDUGy2+UCHUO+u7dtWYUODcOGFn2xSvUsOxNurqCiy7zGjqV2GO3EvQ==
X-Received: by 2002:a0d:c986:0:b0:561:d1ef:3723 with SMTP id l128-20020a0dc986000000b00561d1ef3723mr102933ywd.38.1689205097716;
        Wed, 12 Jul 2023 16:38:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b126-20020a0dc084000000b0056d443372f0sm1467412ywd.119.2023.07.12.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:17 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 19/20] commit-graph.c: prevent overflow in
 `write_commit_graph()`
Message-ID: <9f66e1e6eeb7386010d7387c37766260bf38b338.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
when trying to read an existing OID while writing a new commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index c679d1d633..20d9296c8b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2453,7 +2453,7 @@ int write_commit_graph(struct object_directory *odb,
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 		for (i = 0; i < g->num_commits; i++) {
 			struct object_id oid;
-			oidread(&oid, g->chunk_oid_lookup + g->hash_len * i);
+			oidread(&oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
 			oid_array_append(&ctx->oids, &oid);
 		}
 	}
-- 
2.41.0.347.g7b976b8871f


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735FEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjGLXip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjGLXic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A285212F
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so2017743276.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205089; x=1691797089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ga1luYXgMtsLKHbLTP+7HbaJb+4veI1jkAMoUVnFic=;
        b=GRmvqpCQG7zsuTK8Nx79t3qTWwm/t+vpvMGtrsV7UOiuC3gD0WvZ5Q3M9GQU1BM7iL
         laap+l+PbjIkpI4vat5JaIaCbq0L3S8M9FKetCOwD/7PFArXy8wk/FIWXVQotk/CvDLx
         siu67wDgZp3Fo/HPfJoCnFCFC1gohjCP92AU4kg9YH3X320vqR817yOgNXCFxdw8kfJf
         ZuTHqSOSzCWNXwpj506OfU809kHV4+K27XzNHQYU+akOMZa7OAzdOWQBtb9OH5RaoAMJ
         BPN1DrUpwzjFvekfke+/GxjDmK9ZclpVcwhjpH1w50Oh5JJe2csEgUAUIA+Gn61he7Vs
         rsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205089; x=1691797089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ga1luYXgMtsLKHbLTP+7HbaJb+4veI1jkAMoUVnFic=;
        b=cxwzeNSjuHP5LQFznrnHGqeUvcTsI5RPUWg8s70eR5nJlMBjHx5naClbkOCSrBqwSt
         +sL85V9Q4HHPGaZtnJSuLsSUHhtRuEATmvhgfsrEXOYPkoX+i/l7jjr+EbCQ1fMRh0uR
         gJqIu1jhN3VVgOYIa1IRgDhaStnihFIJf9GDSm9SQHF7s7meK8SMs11wtuVdYp+8Ofep
         +0rCXbU1ToEWeb+R2nj/IpS9m3A54tYNoGRAux3GTwqrdbA2VlCQPx0o4cJOzyBsYJai
         aUi4OWr6nc2fuaoanFOAjsEwmlqWP4jDC3SfisuGxQYqGQjiKjQvMn53V5vKheCe3Rga
         EaaQ==
X-Gm-Message-State: ABy/qLa2BQbhW9OGHIvWDo82u3cEBj/Wx++h4F/kweXqrAmy8IHpTG+g
        1aeupA1ytIx5vPxbV146A1hISAKngn6XqmKnzI7HQg==
X-Google-Smtp-Source: APBJJlG7M4wZXEr/H2Ehiu8nThOC0U3XpzNETLOwQiJnBGCFQYhDu2I5e4OVOZomx8bOr5VHdyqyrA==
X-Received: by 2002:a81:488a:0:b0:56c:f547:e058 with SMTP id v132-20020a81488a000000b0056cf547e058mr4019724ywa.18.1689205089318;
        Wed, 12 Jul 2023 16:38:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i65-20020a819144000000b0057072e7fa77sm1454074ywg.95.2023.07.12.16.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:09 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 16/20] commit-graph.c: prevent overflow in
 `load_tree_for_commit()`
Message-ID: <32c046e684acd27df254b8e500e0b64ec76b197d.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
when computing an offset into the commit_data chunk when the (relative)
graph position exceeds 2^32-1/GRAPH_DATA_WIDTH.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index ca1d997516..35f700273b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -979,7 +979,7 @@ static struct tree *load_tree_for_commit(struct repository *r,
 		g = g->base_graph;
 
 	commit_data = g->chunk_commit_data +
-			GRAPH_DATA_WIDTH * (graph_pos - g->num_commits_in_base);
+			st_mult(GRAPH_DATA_WIDTH, graph_pos - g->num_commits_in_base);
 
 	oidread(&oid, commit_data);
 	set_commit_tree(c, lookup_tree(r, &oid));
-- 
2.41.0.347.g7b976b8871f


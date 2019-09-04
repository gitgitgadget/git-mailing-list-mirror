Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C311F461
	for <e@80x24.org>; Wed,  4 Sep 2019 02:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfIDCXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 22:23:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32922 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfIDCW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 22:22:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so8071613qkb.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sz357SDRFNwGKZI7qIlMEkFgfd0kxZ1xDqwY8s7Hmo=;
        b=OWwpi2cQcy8bK83bvIsWCk0OkGd+LE7PJPiFUcJyq4/P954z8I4+uLyTXEvLlpZFzQ
         AaD9WezfEuuSBzm85KzkhcQTKVsKOoUtyYwMPPyAQwXxLawOKqS2s9a3zJF+EmBFvEYR
         j3/9hIfefiH1s4Fxp8wbzwJ6OqpPdLDO+mI59Zoq73fQw29rMd7lIeWaWrJ6UjWdSXIM
         NTi4zQFed2+Gp8AY6w50wFxJR5TZd+tzwitn4BjvjlgDg7ISDDSm6PRaustbaWUKscv5
         23LoRoXfK4XfUYqO6fCQ17MivH3CZldZKjmHspSTiaJ89/h7BG/wFKXta34FC/usiSsV
         rSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sz357SDRFNwGKZI7qIlMEkFgfd0kxZ1xDqwY8s7Hmo=;
        b=iOZg2P251MK+7UAahwTcEjQiBrd/s7l0mvODfG6uXEiTwCksMafrD6mTMH0tRDDL+t
         TW8f76PNZhVRa4URIwDZegONBthnHTk0sAaJbwgLFXlzPbG1ojq6NRb7fP2CXR8coGpM
         MF7OibMUq24ekZ6093MqBc4i3Snq+bjlsQuZ97d32TGvyJ+PJcN6WwxhFhqs4gw+Z/LP
         oZSPBz1FhKlit7zu3N/Fh6q8p15/0IQ/XmANsV99I1OJlGWtRuRtQhzqy366TSO+MMtB
         9ut1tinHwh6itqht4iGrfANiVDCOrDXV6lorh6nyUMllqqOLs6TM8ZjJYOXowtTPLRvj
         +jeQ==
X-Gm-Message-State: APjAAAUOdTwcfPD4Hq/2/s4t994jaAi/9Rzb9KJROw1OCwDY/3s31mT4
        jw/WgsyVYaRhkVB1jaxcAgtSr6PYKiE=
X-Google-Smtp-Source: APXvYqw5wjo89qlQ1e3+AiYampqn7HqsEWM+q7l3uIRwWXbmO/5lJbv+s5EBPbBu12RF/ML8MThMog==
X-Received: by 2002:ae9:dd81:: with SMTP id r123mr5848603qkf.103.1567563778713;
        Tue, 03 Sep 2019 19:22:58 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:24fd:2e2b:8aac:d853])
        by smtp.gmail.com with ESMTPSA id 43sm2990043qts.47.2019.09.03.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 19:22:58 -0700 (PDT)
Date:   Tue, 3 Sep 2019 22:22:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
References: <cover.1567563244.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567563244.git.me@ttaylorr.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write a commit graph chunk, we process a given list of 'struct
commit *'s and parse out the parent(s) and tree OID in order to write
out its information.

We do this by calling 'parse_commit_no_graph', and then checking the
result of 'get_commit_tree_oid' to write the tree OID. This process
assumes that 'parse_commit_no_graph' parses the commit successfully.
When this isn't the case, 'get_commit_tree_oid(*list)' may return NULL,
in which case trying to '->hash' it causes a SIGSEGV.

Instead, teach 'write_graph_chunk_data' to stop when a commit isn't able
to be parsed, at the peril of failing to write a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index f2888c203b..6aa6998ecd 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -843,7 +843,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
 		uint32_t packedDate[2];
 		display_progress(ctx->progress, ++ctx->progress_cnt);
 
-		parse_commit_no_graph(*list);
+		if (parse_commit_no_graph(*list))
+			die(_("unable to parse commit %s"),
+				oid_to_hex(&(*list)->object.oid));
 		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
 
 		parent = (*list)->parents;
-- 
2.22.0

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D90D1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeAEUDU (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:03:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46168 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeAEUDN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:03:13 -0500
Received: by mail-pg0-f67.google.com with SMTP id r2so2365375pgq.13
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7nzCDD5PCQbKHk8Qcy8boDSUT94K0KHjQTit04i9dwk=;
        b=PYPhYiFJ64rQK5/odIwCH4zib/laMVhgnsgaRIxpn0wBbBFl6WMHbG0R1fYJk+qlzC
         tDdkve9v5csXWNApoKKxZ4u5zheDg7k3BciIX7K/qNnsCq29Eqvg3+LhDUbJHp7IWTRU
         AVSQvzd/tqsHo+kfSnqt25vl7kzyklKgmK4a/JHsTp+z6eUcKY50ViKPywCixY7861M5
         SDu5WwpSOiTBEtO/suqDfXyZUjNJqavJBmec/KdbjcdlMlqqBZ9qGJHTN8NNVcqk24Wd
         hVo07KZjLZCZLCx4yWU5MjuMeHC8BLqCPSC8yjND9/7VGvD/S6ZxYgmhnt4kpU2jUri3
         X+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7nzCDD5PCQbKHk8Qcy8boDSUT94K0KHjQTit04i9dwk=;
        b=Qng008SZ0zSd3LMkIyzkTTqTzkIDIuDspX7EW1XeYkBBby43MuB5Erx3mhrtQyd+dD
         9sgcnMWtq1R4n2PqGol+BeFyySUjDjFV9B1mGaZ0Ojbm2P+77KyyzJ5iwFM1lbkhaIlS
         y2JiVsP2CDrsybWjVZ/lTRHtJAsHFuO2Xg5IM50rfQ/u4ZPXgWvbbjPpl7fX9L8K9Sru
         dh5zJ1fn2LJ/GFp1lpWASjx+bVNSod5fBZFrGTF9diKm25D0Ftv/TPyXdAWGTMZ3kbQi
         y9M7ovNkGTKDKqg9EbUW4bDEfS+MaYFo4MXyElEmW0bKAXBl7ab4uzmUoRxDYXmPF3EG
         TidQ==
X-Gm-Message-State: AKGB3mIkO0niQemZDv66ebx/w2HvCHPqJQ5CUHytinqxX53K43lMZ+Oo
        BBO5F+tP1LrXplp1GEBK7+61og==
X-Google-Smtp-Source: ACJfBosD8YKoOtQ/5LHxBZ/i9iYQprcG+yHMN0SlseRsagU9XiRAbDQnWcjFZq2y3R4oGPCaQu8ybQ==
X-Received: by 10.101.97.85 with SMTP id o21mr3423323pgv.256.1515182592684;
        Fri, 05 Jan 2018 12:03:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 13sm15557761pfs.112.2018.01.05.12.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:03:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/4] unpack-trees: oneway_merge to update submodules
Date:   Fri,  5 Jan 2018 12:03:03 -0800
Message-Id: <20180105200304.34173-4-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180105200304.34173-1-sbeller@google.com>
References: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
 <20180105200304.34173-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When there is a one way merge, each submodule needs to be one way merged
as well, if we're asked to recurse into submodules.

In case of a submodule, check if it is up-to-date, otherwise set the
flag CE_UPDATE, which will trigger an update of it in the phase updating
the tree later.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 unpack-trees.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index bf8b602901..96c3327f19 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2139,6 +2139,9 @@ int oneway_merge(const struct cache_entry * const *src,
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
 		}
+		if (o->update && S_ISGITLINK(old->ce_mode) &&
+		    should_update_submodules() && !verify_uptodate(old, o))
+			update |= CE_UPDATE;
 		add_entry(o, old, update, 0);
 		return 0;
 	}
-- 
2.16.0.rc0.223.g4a4ac83678-goog


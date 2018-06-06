Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3712B1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 20:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeFFUrt (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 16:47:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34292 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFFUr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 16:47:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id a63-v6so3715768pfl.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZKzyvyjHV+vWMTAUK8dVNcKRzgDoPYCuHz4pU+rePE=;
        b=K6cT80f//hM8+qbeRDM1nOzmz/xxYDtFNoi8qpYuA2WTfUBt2pMNg/ZJEhic6sAHJ1
         hcEEldaOfVmscs9V2cuwG9ifaaeWOGdSxehYyv5TY5+FXnw+3YEq6bXYezc4+mngsG60
         bTKu52P1SwsuYVZKQ02aFB4OK23uWwvXHZjD6RFjM+m7q87qVquC6GKk6QC31HUeIH2v
         BX+t/8NyLRe8IqfG7UE8V0uQf2zg4Ghe9sWHKy06yRo1g6UdTZGOt6hT8hhR5Vl4Ug2C
         CfVkLAljs6lPlcEe3jSQJeZb9+CxjyPzIg5MwrZXI7yzyrA9JMEGYkshLrdqsXr5ZUZW
         ZvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZKzyvyjHV+vWMTAUK8dVNcKRzgDoPYCuHz4pU+rePE=;
        b=STvPrYFxggQlTdgrJP94bNJaMfex/rKAB201HMz+xtJGdsgz0EmbdDyH6EfXvLBcTQ
         Ry4jUCFocM5H5XglUgRtVJKkp6qs9rEMBH13VnxKdwi5yBTUe6QRqAcNNKPLAgFqAqrb
         ypua9GfLGEc+IkhGjc/k6e2LH6jhyK6mu7XpepgCCIJK3Y3QKEHgfRddPsbX+gWrOQ0+
         9Z6jXthmRU+9vG9bw8bgQBB5m23LhPkDQbj9L7Pas5DUFOaVsJMxXfiiFrntS0NaDP1j
         ASr80ySN8E2gVtVu2x9K0EuMO5ikGPOPYvOJ92XdyXhoE38sEpFao+LehlpccX/lXDxc
         f/sQ==
X-Gm-Message-State: APt69E1bMzpEUUKeDIY8S4N+mYCiGufqCAD/YGg0piBF36NNxzRbpgwo
        29Wa9VKe9nQVZ8fo1dAlxdpbs+tJ8Jk=
X-Google-Smtp-Source: ADUXVKJoevI+LiBPM72tv77KxLLhJffijyv7JmgHZPLoFNNZyxA+/9D8pl37kO9gU2nUlMkev5UVcg==
X-Received: by 2002:a63:3c07:: with SMTP id j7-v6mr3757544pga.440.1528318046591;
        Wed, 06 Jun 2018 13:47:26 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m1-v6sm20703323pfh.155.2018.06.06.13.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:47:25 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 3/8] fetch-pack: directly end negotiation if ACK ready
Date:   Wed,  6 Jun 2018 13:47:09 -0700
Message-Id: <fda04a33c38907388fd6d2166730928d78774c22.1528317619.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528317619.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1528317619.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "ACK %s ready" is received, find_common() clears rev_list in an
attempt to stop further "have" lines from being sent [1]. It is much
more readable to explicitly break from the loop instead, so do this.

This means that the memory in priority queue will be reclaimed only upon
program exit, similar to the cases in which "ACK %s ready" is not
received. (A related problem occurs when do_fetch_pack() is invoked a
second time in the same process with a possibly non-empty priority
queue, but this will be solved in a subsequent patch in this patch set.)

[1] The rationale is further described in the originating commit
f2cba9299b ("fetch-pack: Finish negotation if remote replies "ACK %s
ready"", 2011-03-14).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 2812499a5..09f5c83c4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -517,10 +517,8 @@ static int find_common(struct fetch_pack_args *args,
 					mark_common(commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
-					if (ack == ACK_ready) {
-						clear_prio_queue(&rev_list);
+					if (ack == ACK_ready)
 						got_ready = 1;
-					}
 					break;
 					}
 				}
@@ -530,6 +528,8 @@ static int find_common(struct fetch_pack_args *args,
 				print_verbose(args, _("giving up"));
 				break; /* give up */
 			}
+			if (got_ready)
+				break;
 		}
 	}
 done:
@@ -1300,7 +1300,6 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 		}
 
 		if (!strcmp(reader->line, "ready")) {
-			clear_prio_queue(&rev_list);
 			received_ready = 1;
 			continue;
 		}
-- 
2.17.0.768.g1526ddbba1.dirty


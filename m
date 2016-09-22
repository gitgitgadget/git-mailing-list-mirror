Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCD31F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030381AbcIVShL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:37:11 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35617 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030364AbcIVShI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:37:08 -0400
Received: by mail-pa0-f49.google.com with SMTP id oz2so31733904pac.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1i187xRwseLRd2Ik1nW+3b6REGyNjGeFxPcvhCrVhMo=;
        b=DLE1xqBnxAJD4o8f+tTTFi5SrNBajOErH5+0HAXxctnxvKaASrYjDIeqPa94BdCU5c
         JSRjlJ4oG4NIn9yY2xx2nOnRN7YyydCrJp4uMnFm+/unm0oSSEUB/ySxSitKA0+ix3GO
         vixkUVK3sx+r/D2x0cD5D/Fdes3AwAgcfuADiFJQ81uBXNkRGIHOzyM+udHt8G0XIiXh
         xSHw4ZcF2MQ581VkWfU0o1byYbbQTMbRSxbkdmqvHR9CGeWiCVMOWZo1HWxZypNVbl0e
         /B5wtXR0Uj14pELWdMBSGbdPKQdMqKa7BrpYM10WrWlQ+WFpEFrLhFsooXW87OkUzbXR
         EnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1i187xRwseLRd2Ik1nW+3b6REGyNjGeFxPcvhCrVhMo=;
        b=joAzojMvKqFPRKCIcIuTmsLM7rMEostwOYq+KiFDaUhT32qsQKrwb70b+zHVYv2KeM
         CELkP/u2d6jNG6d9t6NPJuRhpcQcuSWrLhAJWJOj3+AKiWxeEN+XE4Wynta4D4JXRAiW
         ag7AmuHe4Ro0fnLJBOsVREb8nauQ8YPhCGkJwhxfqvqtP7G0DIUgZZ1TEitZdARrgbf1
         1hUOeMrMR2T71PA15PZjhgM8dR9mi2O04z8T1Q3hRnINqDq+XuOv5CFPga+LgOBjjvCa
         7/qc2gTPUxhhJGVv3FbLjujycneLqYMC1amwMwoLX86abBX+YQpEOjlbeayw7XkAboxg
         VAlw==
X-Gm-Message-State: AE9vXwPOFn9CO3R/dYNLh58WQnLG7j8FDqCwnBcNh9cM6YBLze6fZvhiJQqI8ZmbHQUt1zvh
X-Received: by 10.66.129.174 with SMTP id nx14mr5558631pab.167.1474569426924;
        Thu, 22 Sep 2016 11:37:06 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id x9sm5802715pff.19.2016.09.22.11.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Sep 2016 11:37:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fetch-pack: do not reset in_vain on non-novel acks
Date:   Thu, 22 Sep 2016 11:36:55 -0700
Message-Id: <5a258c5dbed0683760e2ffb1bd6a1749ea66b2d5.1474568670.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1474568670.git.jonathantanmy@google.com>
References: <cover.1474568670.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474568670.git.jonathantanmy@google.com>
References: <cover.1474568670.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The MAX_IN_VAIN mechanism was introduced in commit f061e5f ("fetch-pack:
give up after getting too many "ack continue"", 2006-05-24) to stop ref
negotiation if a number of consecutive "have"s have been sent with no
corresponding new acks. A use case (as described in that commit) is the
scenario in which the local repository has more roots than the remote
repository.

However, during a negotiation in which stateless RPCs are used,
MAX_IN_VAIN will (almost) never trigger (in the more-roots scenario
above and others) because in each new request, the client has to inform
the server of objects it already has and knows the server has (to remind
the server of the state), which the server then acks.

Make fetch-pack only consider novel acks (acks for objects for which the
client has never received an ack before in this session) as new acks for
the purpose of MAX_IN_VAIN.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 85e77af..1141e3c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -428,10 +428,18 @@ static int find_common(struct fetch_pack_args *args,
 						const char *hex = sha1_to_hex(result_sha1);
 						packet_buf_write(&req_buf, "have %s\n", hex);
 						state_len = req_buf.len;
-					}
+						/*
+						 * Reset in_vain because this
+						 * ack is a novel ack (that is,
+						 * an ack for this commit has
+						 * not been seen).
+						 */
+						in_vain = 0;
+					} else if (!args->stateless_rpc
+						   || ack != ACK_common)
+						in_vain = 0;
 					mark_common(commit, 0, 1);
 					retval = 0;
-					in_vain = 0;
 					got_continue = 1;
 					if (ack == ACK_ready) {
 						clear_prio_queue(&rev_list);
-- 
2.8.0.rc3.226.g39d4020


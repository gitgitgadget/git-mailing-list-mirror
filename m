Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BACC48BE5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2C0611AC
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFWSla (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFWSl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 14:41:29 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CBCC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:11 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a11so3588068ilf.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkXlk18dSLdUigBF6cVz0aclQQAWBEznZgJwSZZd55Y=;
        b=GiHrezrJ3sPGamuhscqdm0Tg6k323owK0fE/xBKsR5X8VGC9tmkqUaXxIuwL5Sfce+
         l3PCtiEKNSCLRQOQN+CQcu/G2B6LMCEYDuYwtJZ/S38pGM6xcS367H0PxMku1IO+URsV
         yVHmF6um4DHGWbgjbC48BIa4gKeanDkR4+ty5mmq7jpCAxLpqI2r0pKHVgG5rNz/TDbs
         Eav9kJKhcvRaDfOVfGTgkDNaeP5Tu2Pe65uEVgPxLqKbnfVhUoBLHiS//dpap2iCyNRJ
         GaU0Nm2u7PTgz+tD45vd3XIKAPuPds24hr6NCemVgWfHEwb/O2d5nA3sadwWAp16n3rL
         OaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkXlk18dSLdUigBF6cVz0aclQQAWBEznZgJwSZZd55Y=;
        b=H38dmTa9RuodnNRs0yMlKFwARmMFcbHSUz0MTZu/jBYhIFY0RcFlmbe8ec2FnzgNMy
         FbFBdeBAUJhFCEuhhScOmsZ17/G0M+wZXUcegjdm3vU5+2F0tUOlbU11UpH+MTlo6rVK
         a9QusFba/p9eHpxbBFRAB3yvO/fYWG27jO8HaBjcqf3RXAt5VntEdLX0XBYrTO7VyeEu
         vwGZZHUDdrND1+QsmMbfTWtULZkrglyp1fA+QlAN1+BRgp0ITlVnOCcTBM4XL3P6zvG3
         KyXpwOAeHM04fbRP/yRb+G8rbNQCj3c24JGOBqvPP8s2tApNnQk2ME6m/+QyJJmiGUPb
         RNug==
X-Gm-Message-State: AOAM531o460RwQooqeibo0442hYO0COyvP3aYUHXp0NitVhHkDnjhC1C
        LSsQjwQgO5c5ZBM9tQFCgTTJW7mbVmvENBQm
X-Google-Smtp-Source: ABdhPJxwpYUwb/cc+sfs09kCR/emFxtWGBqMBTDyNwlQ5AqdQ2txGzlCyumVhPj9AhxXtkcE1KF+9A==
X-Received: by 2002:a05:6e02:1c0d:: with SMTP id l13mr543580ilh.271.1624473550852;
        Wed, 23 Jun 2021 11:39:10 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id t6sm379626ils.72.2021.06.23.11.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:39:10 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:39:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 2/4] commit-graph: rewrite to use checksum_valid()
Message-ID: <64aa0aecbd977a6915c271b9c3c1da3c5043e01d.1624473543.git.me@ttaylorr.com>
References: <cover.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite an existing caller in `git commit-graph verify` to take
advantage of checksum_valid().

Note that the replacement isn't a verbatim cut-and-paste, since the new
function avoids using hashfile at all and instead talks to the_hash_algo
directly, but it is functionally equivalent.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2bcb4e0f89..1a2602da61 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2422,14 +2422,16 @@ static void graph_report(const char *fmt, ...)
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
 
+static int commit_graph_checksum_valid(struct commit_graph *g)
+{
+	return hashfile_checksum_valid(g->data, g->data_len);
+}
+
 int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
-	unsigned char checksum[GIT_MAX_HEXSZ];
 	int generation_zero = 0;
-	struct hashfile *f;
-	int devnull;
 	struct progress *progress = NULL;
 	int local_error = 0;
 
@@ -2442,11 +2444,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	if (verify_commit_graph_error)
 		return verify_commit_graph_error;
 
-	devnull = open("/dev/null", O_WRONLY);
-	f = hashfd(devnull, NULL);
-	hashwrite(f, g->data, g->data_len - g->hash_len);
-	finalize_hashfile(f, checksum, CSUM_CLOSE);
-	if (!hasheq(checksum, g->data + g->data_len - g->hash_len)) {
+	if (!commit_graph_checksum_valid(g)) {
 		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
 		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
 	}
-- 
2.31.1.163.ga65ce7f831


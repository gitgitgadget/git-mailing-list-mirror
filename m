Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B851FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbdFHXmV (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:21 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34484 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdFHXmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:13 -0400
Received: by mail-pg0-f50.google.com with SMTP id v18so20716308pgb.1
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+1iEoektNikS4E4/QEITw+0kB6MnP4Nnr4L0yV1mdsA=;
        b=ls6kOM3tYNfgrEJjO+FtwTs8edUVIO85APE7x8QcDrCoSTnCmFwrlJjC6Vwb/994pe
         Df2CESHS2Sp+R2p+BdU5fUn7KpA1c95LLkPeEX+TjrWe7LKnJWKTgIFx1HXhLVxBIBxi
         wn1l52x0widP6A6KSvIbGN9KQbPTm92O94E6CQzm11k47I1V3HebQJpmZIT2r4Lkg/FV
         LMjDy9O/SgSC6zqxulDEMHQVNBKDj3GBjG28PLDf+pi+c25fEgtHdQNkaV1vQLkBzYpE
         R18pSgDqwl5dGpRWNHfE2YjAm1vVtuHlgw97KvtrEz+BQMQj+vigXBLLAYf2zI11e+J3
         XnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+1iEoektNikS4E4/QEITw+0kB6MnP4Nnr4L0yV1mdsA=;
        b=Sr09SyZJYX4pFsieLnKU2er+S2/vATLSfRAj51s0CdT5e3NtlBex2R1W7ITUyb3Uff
         a5oHsfPwUffNV5LT7qF6ri87tEQ8f2mLi74trJFjM5ZgqWytbs9HP7bgxHjE+pXcmnlz
         TeCz0mfge24sDJIGMJak4KA+uF7gbiW8sii+3oplM6zmqGMOSc4XP5np6uBt1mS166yk
         Inmj8U7YDHK8WgNtQ9A4IJvxgXkmFi1TizEzcc+OGtI/qiTDPu0QfahHyiAzHs/nK2yS
         WfNRaPF68RYt62asApf3f2Thd8VEptgsS10/vptjFSaD5nEjKzC8EGiPY3sutDDAVlJP
         FhsA==
X-Gm-Message-State: AODbwcBISHRGRMqVFfqM1WFOTBhghYH8xkXG30zTRQs9NRDtCK46nwPJ
        bX5TMdKemaE1mNOyY4gO6w==
X-Received: by 10.84.225.146 with SMTP id u18mr37415873plj.264.1496965322039;
        Thu, 08 Jun 2017 16:42:02 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:42:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 28/32] ls-files: convert prune_cache to take an index
Date:   Thu,  8 Jun 2017 16:40:56 -0700
Message-Id: <20170608234100.188529-29-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 289c6b2a5..e2d8fb7f6 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -381,30 +381,31 @@ static void show_files(struct dir_struct *dir)
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
-static void prune_cache(const char *prefix, size_t prefixlen)
+static void prune_index(struct index_state *istate,
+			const char *prefix, size_t prefixlen)
 {
 	int pos;
 	unsigned int first, last;
 
 	if (!prefix)
 		return;
-	pos = cache_name_pos(prefix, prefixlen);
+	pos = index_name_pos(istate, prefix, prefixlen);
 	if (pos < 0)
 		pos = -pos-1;
 	first = pos;
-	last = active_nr;
+	last = istate->cache_nr;
 	while (last > first) {
 		int next = (last + first) >> 1;
-		const struct cache_entry *ce = active_cache[next];
+		const struct cache_entry *ce = istate->cache[next];
 		if (!strncmp(ce->name, prefix, prefixlen)) {
 			first = next+1;
 			continue;
 		}
 		last = next;
 	}
-	memmove(active_cache, active_cache + pos,
+	memmove(istate->cache, istate->cache + pos,
 		(last - pos) * sizeof(struct cache_entry *));
-	active_nr = last - pos;
+	istate->cache_nr = last - pos;
 }
 
 static int get_common_prefix_len(const char *common_prefix)
@@ -662,7 +663,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_cache(max_prefix, max_prefix_len);
+	prune_index(&the_index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
-- 
2.13.1.508.gb3defc5cc-goog


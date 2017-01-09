Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27531FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbdAITq7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 14:46:59 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34470 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763996AbdAITqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 14:46:35 -0500
Received: by mail-pf0-f179.google.com with SMTP id 127so33120836pfg.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=haDNMlqX+m9qFgSdrb57H+Gj8F890JHHKXi4LrRo5yw=;
        b=qwFEConOjDXvmYUarg/qcBZMh23LFuuiOFWu/06uGML/hmf2pCXtHE21nSfV3MscJy
         RtS7LfouOz+0kCASrWTpv3v4UWihkeBy/jsyM90llOs2YYcr95LLqvPgdztH2mi2KUbW
         b/zXkw3XbhEAwz8HCpSDSWlfjOQRmi+2ILnueuFaxaWFS6+Q4tjw1BxyKJgpfEiq/tB0
         KahYobmi12kAhm5tlfNDpcmpUP4rlx7EKsj4l8HIcTBf+mDosDy1Xzfe6D52n+s0Hm2f
         yWyT19jkHj1F5yGLL8eZkPV6IKbArNNG/3ryMVkyf4yNG38JQ3i8V26k/HFBB0CKWIPf
         mvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=haDNMlqX+m9qFgSdrb57H+Gj8F890JHHKXi4LrRo5yw=;
        b=byyEhhPVEfAgxy9Nl+8JbIGrOeHdzzXaXnYC16/NSYk2/ksmAoldihtJAVYy6Ckk34
         4Q/1G8xOjSlakiLtJi6Qml77AMGS3xHIt6Xu9GfBfzkIQIVYrFBaD/lqXVHVI4XuhaTK
         mRZ6HvryqKYcA77CCM0kZLiproxjbZGGrbRXuLuJlqsZK8ODVpJuB8Yh4OhnwwN6mP/g
         1HiMZHLyIcfePD8MqEG5vwFal0iL49zQejQDPjf6H0VdBvI00ELTQmPFFCCo7K8lY6Wy
         5PMGLMaAYejnYuejgrzOmTXQQ1hm9cnUEk0Ci4z1RqQ8vWHX2P04/lt7J3WoPkcn8qiX
         3snw==
X-Gm-Message-State: AIkVDXJjcq18I4oSdMgJNlVKQ+z0cdIfq1TZ+Nf3qkB+8aR4gOZdt8EVZQE2MrVZAoQrNvU1
X-Received: by 10.99.247.69 with SMTP id f5mr166228075pgk.81.1483991195075;
        Mon, 09 Jan 2017 11:46:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:45b6:2235:29e9:acb7])
        by smtp.gmail.com with ESMTPSA id c71sm182333165pga.22.2017.01.09.11.46.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jan 2017 11:46:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/5] unpack-trees: factor progress setup out of check_updates
Date:   Mon,  9 Jan 2017 11:46:19 -0800
Message-Id: <20170109194621.17013-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
In-Reply-To: <20170109194621.17013-1-sbeller@google.com>
References: <20170109194621.17013-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes check_updates shorter and easier to understand.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d443decb23..b564024472 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -218,9 +218,27 @@ static void unlink_entry(const struct cache_entry *ce)
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
 
-static int check_updates(struct unpack_trees_options *o)
+static struct progress *get_progress(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0, total = 0;
+	struct index_state *index = &o->result;
+
+	if (!o->update || !o->verbose_update)
+		return NULL;
+
+	for (; cnt < index->cache_nr; cnt++) {
+		const struct cache_entry *ce = index->cache[cnt];
+		if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
+			total++;
+	}
+
+	return start_progress_delay(_("Checking out files"),
+				    total, 50, 1);
+}
+
+static int check_updates(struct unpack_trees_options *o)
+{
+	unsigned cnt = 0;
 	int i, errs = 0;
 
 	struct progress *progress = NULL;
@@ -232,17 +250,7 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
-	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
-			const struct cache_entry *ce = index->cache[cnt];
-			if (ce->ce_flags & (CE_UPDATE | CE_WT_REMOVE))
-				total++;
-		}
-
-		progress = start_progress_delay(_("Checking out files"),
-						total, 50, 1);
-		cnt = 0;
-	}
+	progress = get_progress(o);
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
-- 
2.11.0.rc2.30.g7c4be45.dirty


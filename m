Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA721C2D0D2
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF08F2146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtaXD3pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLTWF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33196 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfLTWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so9853238edq.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gOPv5Og/2dZIAjomx53PBGA50t4FG/TL63zOrdFjvhQ=;
        b=jtaXD3pQQrfWOXCwQ+NypOHgB0ImkdNYESmplymLFlvQaVar/hI+VbeiczIJAtJ5Xd
         1BvIlWn3OxlMhMfSDXoJ0L9cHs+kJ4py3FvTEsorVniXq66YX+c/7LHqkXEewIdrerFv
         Rh0quaGjbxpkOTm8pU/XlCO4AGw/I9BRXI+Uszv+YstmKVHav3sqI48BoyH89sabOttl
         21NdDS2E3YBJTmPh0VQfYx4KeWqlyFeZDeZwATdxaXHmfVH5ZWJJSCvy8/GHl4hwVTZ9
         7MegW6JxO3T18Oc0xTIlWndke+OXSNEL3imVij+QfxxcPOdJo5vpVz+GpLkfdpB7Kx8E
         na7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gOPv5Og/2dZIAjomx53PBGA50t4FG/TL63zOrdFjvhQ=;
        b=oZKjDyvKVMLi4GaK+clZn1kLKKZmGQp0vH37FjrbUwTxiubOpHSEJOZ42k7/frLZ4Z
         cj+1vZjCClWiH1X80yMe0jGXrpa1dL129rbTwkZSwuiJib3mI2nDTkFkTw5wRag5S+lO
         ATnU6D+69lBaB4MwOMPHpnXKRQnDcH7heeTAIUUifbOgXFxeZKRBSayqAmLbo9W1mFs1
         TgJa/dpT5xWIpkl36ZwIKt5PibOWkKZxdU+YulTNw7sKuxGcO/q3yNrAgICjGPpzpITh
         nnYjdlPYtKsu5qyJa+GSWijiYRzkTm/GIwVrIWvOqpgCWDPflxvW26KwlquAGBfkrJQ6
         vckQ==
X-Gm-Message-State: APjAAAWm3C1jHifm8ylYkBfPympjDbasfchcovimSelVycdWnN6cSEQT
        6N3NBJBfYsidUwDYvf18XLnynfj+
X-Google-Smtp-Source: APXvYqynIcMOVFcPDzl9DzeWHxUWVqJzJ+hr8dxg4zhSRPi7NVS+5UgS8PBVeClh3zWn+KrxUIQY+g==
X-Received: by 2002:a05:6402:3046:: with SMTP id bu6mr18415908edb.139.1576879524948;
        Fri, 20 Dec 2019 14:05:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm1218948ejj.86.2019.12.20.14.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:24 -0800 (PST)
Message-Id: <a15f87fdcbea1a37a20a05135832b42f36f682f1.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:14 +0000
Subject: [PATCH 3/9] commit-graph: use MAX_NUM_CHUNKS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

This is a minor cleanup to make it easier to change the
number of chunks being written to the commit-graph in the future.

Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 61e60ff98a..8c4941eeaa 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -24,6 +24,7 @@
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
+#define MAX_NUM_CHUNKS 5
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -1381,8 +1382,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	int fd;
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
-	uint32_t chunk_ids[6];
-	uint64_t chunk_offsets[6];
+	uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
+	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
-- 
gitgitgadget


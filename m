Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BA31F454
	for <e@80x24.org>; Mon,  4 Nov 2019 09:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfKDJ7q (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 04:59:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55448 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDJ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 04:59:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id m17so6622048wmi.5
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 01:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEXow+GLcFQdob2KSCXujhv+iVrZ+dqu9kyWHDqBLJw=;
        b=ZZOS9/S+V6dGCJSfX4SWn3OvCbEZ85WiQPsDsagHjp7PIFR8qy+snMJwez7H3smZEB
         uefzsk3FINftfYT+P4Fhn/fIVpA5aED7CQ7X7qADv97gEKfxv+Y+dAwMhKd/5g3Q2141
         tQFSaWHR+l4xmob3gMf/nZEDQGf98vgYLSsSrxfxDmURknolDs01n7T6rtAXf0mh8pth
         Z8UWUKJ3VsYlT4UYw1xr4cYb4MOZAHu/XAOYT3cuQ7HJu1dahnGKxeqrX5Zh6Me7O34e
         ikCZqBMhntOwbkFE0svp/CM0JQkwv24AZg6U36HJfpyXc4hBI6/Dhb4yX3whB1hJ0C1D
         Qd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEXow+GLcFQdob2KSCXujhv+iVrZ+dqu9kyWHDqBLJw=;
        b=EHhcIqEgNej0gDzxJjtsJgXlQOz/s4867xGxRoorlN3jokhhiKnrYssZMoLeuFgOSB
         XIT9f/HoCu6xh23hXgPmHW3yCWNhcnZRuz++8atxqxNwILTErm8baAjERdGZE6p+8ufP
         dfHZTJjzpdAL2r+TYsEYhjyerZe0aJtELH2MFEsr1mDuerd5jqBZByzDHkR9cBIuCvpW
         yu3TV+2phG2LIpB5PfDeq2og/HojTNrymgkNAGAWrwVrRurQ1ElktlBIzbLtqwnIiaqT
         1kvknG0YxsMY8Rw+LY3SBeHHg2ohh9Xsx0aII+M0N98QE8dtCMv3F98zXWRezrJOQ6eS
         lofg==
X-Gm-Message-State: APjAAAVx8SUWPRSv0/oy/4wNawVuCWoUBQyjAkF2u6WZFAfdz5OPSuYm
        rGHo85+zJZ7vgQR/TJb3iDJfvsARcmGp0vJt
X-Google-Smtp-Source: APXvYqyg8plx/GdaLuxTl4mi1hYLs7EReJPqXNN2DZkHGM54w77nmTJYH7gxC/AGt0tFbaJpbc6QSg==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr22279950wmb.140.1572861583416;
        Mon, 04 Nov 2019 01:59:43 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.81.118.113])
        by smtp.gmail.com with ESMTPSA id j22sm23382554wrd.41.2019.11.04.01.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 01:59:42 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 31/32] commit-graph.c: fix code that could convert the result of an integer multiplication to a larger type
Date:   Mon,  4 Nov 2019 09:59:22 +0000
Message-Id: <20191104095923.116086-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.467.g566ccdd3e4.dirty
In-Reply-To: <20191104095923.116086-1-gitter.spiros@gmail.com>
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the LGTM warning fired by the rule that finds code that could convert the result of an integer
multiplication to a larger type. Since the conversion applies after the multiplication,
arithmetic overflow may still occur.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 commit-graph.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a0f868522b..0be15f1cd4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1415,8 +1415,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
+	chunk_offsets[2] = chunk_offsets[1] + (uint64_t)hashsz * ctx->commits.nr;
+	chunk_offsets[3] = chunk_offsets[2] + ((uint64_t)hashsz + 16) * ctx->commits.nr;
 
 	num_chunks = 3;
 	if (ctx->num_extra_edges) {
@@ -1426,7 +1426,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
-						hashsz * (ctx->num_commit_graphs_after - 1);
+						(uint64_t)hashsz * (ctx->num_commit_graphs_after - 1);
 		num_chunks++;
 	}
 
@@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			    num_chunks);
 		ctx->progress = start_delayed_progress(
 			progress_title.buf,
-			num_chunks * ctx->commits.nr);
+			(uint64_t)num_chunks * ctx->commits.nr);
 	}
 	write_graph_chunk_fanout(f, ctx);
 	write_graph_chunk_oids(f, hashsz, ctx);
-- 
2.24.0.rc0.467.g566ccdd3e4.dirty


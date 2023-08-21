Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3FEE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjHUVoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHUVoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 17:44:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7E11D
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d776e1f181bso715065276.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 14:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692654243; x=1693259043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8vuNFBcFdWPskEdv+zdwigDuglzVVzyTUSDJAmUDl4=;
        b=zSU7cnfSydgMAqKsuVknE20//pAtdZELU6xuRbtsDnEkJB6FOF9JE+qkQBIf/wRULk
         ruZsUt5uUIM4NQMdngzWwCv7vdqX8/C0dWsuBL6cvCkDBVInkBSmRtGK//PZbnK4ARRD
         p8tSr9M9hCFzlMnYwiiPlNOVVh2cvWaZlz68DjzFAFzNS6jfpCZjQkXStrorXfxRQc00
         JexpCkp6UApxXQwPCDJStxm2gHPDK462qAJTvoY78W4DKtVQEUqbBBUL/ErBkM50BEhk
         xohjEdbI5DVwe0F6R/Ca2ZUI/NMYsTXAGAfMB4sCcbSPx3HeH9QGVYvSs32YiuHyxPQD
         fZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692654243; x=1693259043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8vuNFBcFdWPskEdv+zdwigDuglzVVzyTUSDJAmUDl4=;
        b=al98CK5e+uqpFEyrYQO2Tpedx2lifUOvgeGn+z3hAIwlnJS9HPKVyeYuWBIhWOtFoV
         HyXbnNlvY5NgynJeBDSHknM7DcAKQyzZ99XywsTP5CCe+v1uMWRwcRvkHktKAQadi5Jv
         71vOhRZlkUFTd9b8ABecbZd9umBTOKVOkSokUuHJ+ppeITVxy0fOG14DJ1V2Drnw79Ae
         wD1+LyCz7GoNO1Wta56N4wjEHtvUpYjWgcTiBfYx/GTY9rAdIkcPeueGhKwWb0aH0/Fg
         CV4rfQ0+r4uk6Xf6fQJPpZNifPmhuYmZ6+0OSh4YQZn3NfPCBZiFj/gN0QbbNsNvCAT3
         Zc7g==
X-Gm-Message-State: AOJu0YzoAaNCsskE9VPWMjUjluMHFBX8+w9Y4iVUjENn7wU/2yxg05uy
        Nmhto8NHw4LmRG1zzjYyk7IBhcLkZViPNYW2n74+ag==
X-Google-Smtp-Source: AGHT+IESIVd6HcUuiNqRn8u54nhxBoERDdzZnUViiLGbtWdYm3GCXeFJYoZlSFtX9Mg58DXsj+6ptQ==
X-Received: by 2002:a25:9783:0:b0:d16:f35b:a35f with SMTP id i3-20020a259783000000b00d16f35ba35fmr7112905ybo.40.1692654243089;
        Mon, 21 Aug 2023 14:44:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f7-20020a5b0d47000000b00d0bad22d652sm1967033ybr.36.2023.08.21.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:44:02 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:44:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 02/15] t/helper/test-read-graph.c: extract `dump_graph_info()`
Message-ID: <9c129c733e689f02abafdc97011395653c2708d4.1692654233.git.me@ttaylorr.com>
References: <cover.1692654233.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1692654233.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..3375392f6c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -5,20 +5,8 @@
 #include "bloom.h"
 #include "setup.h"
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_info(struct commit_graph *graph)
 {
-	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
-
-	setup_git_directory();
-	odb = the_repository->objects->odb;
-
-	prepare_repo_settings(the_repository);
-
-	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
@@ -57,6 +45,23 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	if (graph->topo_levels)
 		printf(" topo_levels");
 	printf("\n");
+}
+
+int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+{
+	struct commit_graph *graph = NULL;
+	struct object_directory *odb;
+
+	setup_git_directory();
+	odb = the_repository->objects->odb;
+
+	prepare_repo_settings(the_repository);
+
+	graph = read_commit_graph_one(the_repository, odb);
+	if (!graph)
+		return 1;
+
+	dump_graph_info(graph);
 
 	UNLEAK(graph);
 
-- 
2.42.0.4.g52b49bb434


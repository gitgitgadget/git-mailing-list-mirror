Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE27C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjHASmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjHASmI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134C2706
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:41:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d05883d850fso6839432276.3
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915312; x=1691520112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QnT3tTtabfqqxs9nL9AlnwZ/6fBBSjxJKX5ob4ntlw=;
        b=MXCuON6YdWNM8yHjUiiOKhxL5fONZdHAPWlNwVKbdUaovDTP/75s/2hNA+7gtiFcoU
         99FQ5zr/9WYiQYEMSQdxx21jdkM6jXeKAL86dvGaJ3Gh2BDQztyKO/hwluRMRz2VpDVm
         EZ7ZgUBq+wxxOts+xchvNTmABxaH+menvnoU5AVbagAIipuEA92rRPRCl+b3UmHkjHnS
         UkRGUD6xFQLbjmAMsIDdW5dw006zGDxSMhG9/90JP8EMiv+6gNYDaTvBLN0XH80mYm/D
         nsqJEDekrBHuYMfBhxDyGQrv5DT/kWQqQcT2WMNWZfmbsOqOPUy3kwi9etTIbc4utU1+
         Wz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915312; x=1691520112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QnT3tTtabfqqxs9nL9AlnwZ/6fBBSjxJKX5ob4ntlw=;
        b=gP/xRZx8JkaiX88fhGM+MvsgMGBVCtXohvlvzdH2ymkjJlJPE/DIsxYqQv0cuaV/IV
         Ex01tEdXOXabFXpLrUjKmS5QMv2g6TPKi7qvSolOvnKbMej1UTRwczgm5LO+r5fd7aH2
         /Corhe1EWx8JpPGjWBlADANjjIoWYBl/L3Ppba2wZfeRYD40DwIPal3wr+VkLsMAuwaY
         HlJdCFtv2OnAiqaTKx7TMjPP4FzAR6WyvyYRxf4/oKbQNx99ipJB16LcdbyQdM9Cost2
         hXZ6GMB7vTFNJLCGCosoXclU0ERq8qyRzlQjvIIJGI4Mw+aP1cOo4Wcv2yYOp6bjXdJi
         F/Sg==
X-Gm-Message-State: ABy/qLbZSc4GEOqapsQgeev7Xd7EfO9zpEKJiNT9gzAh7HzvdmBVVqd8
        Dj4ijyonKpUaTUxkTtXN8WYB5FeM34hLFRxrSh6rWU6/YFOK51dNvKzHsZ1qhmB12xoHAn/EUS2
        YfkFN3ZgPc3+AF2L9pRToKpmtE3Oqq1cU+tANri54R/0LpCMT6KTm/ezgubpmiWt0epvNRbdRkk
        S7
X-Google-Smtp-Source: APBJJlHDC2BpDRN4qOdLEJczYIi5paOnvTTUOZ901B4TaHNOK9qJS7DXHQ9+fu5w7W2eKWiRmtohhnu7JxYMPkTmLcQs
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1804:b0:d07:cb52:a3cf with
 SMTP id cf4-20020a056902180400b00d07cb52a3cfmr92800ybb.5.1690915311935; Tue,
 01 Aug 2023 11:41:51 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:37 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1690912539.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <fc6346c039db46ad0c35c8464ae6e7c9fe976a0d.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 2/7] t/helper/test-read-graph.c: extract `dump_graph_info()`
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/helper/test-read-graph.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..c664928412 100644
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
@@ -57,8 +45,27 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
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
 
 	return 0;
 }
+
+
-- 
2.41.0.585.gd2178a4bd4-goog


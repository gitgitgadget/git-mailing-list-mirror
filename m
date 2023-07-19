Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F071EC001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGSRzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSRzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FE1FC8
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:46 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so7124893276.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689789345; x=1692381345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VjDFejuWKGlSbUdQaaJtU12JRYZV7Y0QRujYk6p/egM=;
        b=uefiDar9F1UpVga/AOk3TeWEUbNuy1J/CHY+LLPeWI7ffK5Tai5cy/sL/v/glDAfe6
         GLjNhnG2UxsLQ2d4Znah0PrnONYwTWRUkO+KLQm4HV1VOIIEUvS3Tgo3f9uoaJbEdJHn
         AxIvDaUVtomKyCpxj/eguSGrlVGSdJX8kLtD/4olLdzo+wL4SJmc9VZk3f1E4en3N/Ve
         8IihMdhgWGHDnptKlGMJUNTlPxIg3/prQz/XrhV8KyPoO13JyXDRGT99HqvwF67ra5gI
         rJ4AHpybxYoM6qCcI2zuf0P2ZSYD7/MitVb2UUDxJwkKmOAGc6Xrn4aYVTG5AK/MWZ+D
         7HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689789345; x=1692381345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjDFejuWKGlSbUdQaaJtU12JRYZV7Y0QRujYk6p/egM=;
        b=N8uXNYkw2FLb2uSRfnCbqUG7GoKrYg11TTmDoGWh+ylyxTOY9FIWanxHySOr413Qrk
         K6XnR1sqXupbtVT5WAqaFdfWStelzOkmgCWyr29TK9NKySZPA7De8nqEL5O9/WK3f355
         3W/A8mg+lPTeDBBq0ypW231/49CPtwDWzMFq5pXvkS2OIY42VDPnwYiHop5VpZzJkBb6
         ktVfV81vS/kC/PD8CNHP8Z9uK4bNSzASz0fE+Ttdt9COpNdKIaFBiGqaQY1dIk4Xh0Yr
         jqO357RZX/tEBVjCANLq6htl6QHEJs+2MZdDhwWueL+PYoVIgtXPR0cb33dY+GrYtbHD
         zd3w==
X-Gm-Message-State: ABy/qLY6Kibs6+AcMRNy4cXVvD7+NF06oDOTBMBKTvHK0iA1cX419Uf9
        epqPEbr7LdPmuKIfWvmKfd7zkyv9n3sBG1bcBE6w5g==
X-Google-Smtp-Source: APBJJlFw0XFlWpqmdgXcEDBBAghYFYEzB50XNgbgh+Er5EZkDxyWyQcHiVSuweFnhMT8C2uTcI5Gwg==
X-Received: by 2002:a5b:94a:0:b0:bff:242b:78d0 with SMTP id x10-20020a5b094a000000b00bff242b78d0mr2980585ybq.34.1689789345159;
        Wed, 19 Jul 2023 10:55:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t188-20020a2546c5000000b00c4f175716fcsm990112yba.20.2023.07.19.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:55:44 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:55:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t/helper/test-read-graph.c: extract `dump_graph_info()`
Message-ID: <215419bf3c21ce630ce6a8b06e5c1034c6d878f5.1689789226.git.me@ttaylorr.com>
References: <ZLgc5q0FrL1s7j0j@nand.local>
 <cover.1689789226.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689789226.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578f..c6649284123 100644
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
2.41.0.366.g215419bf3c2.dirty


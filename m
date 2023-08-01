Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE7C00528
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHASmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjHASmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:42:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C3D268C
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:41:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b107so73956277b3.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915316; x=1691520116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G19IhzqNLSoxiby4b6EqQurINKTfQBn8xfgBlFyGsbE=;
        b=aUb46+mNjI6xGPtoKUMn5QDRFKGs4gShSj+NqplUuL9/NBwhK0vBR93GhUJ4ET+iol
         D2DdsYfeXWuyrb2stiCriu0JNbYLUyoOqKYInjVjmRPLV4PIB/crVAhHdYy/P59a1ua7
         YWgsi9slExAdtbveQpd9WokUt6BOujOvfEo9ksu3+ViNT10epWoXwUv5zvQzY+GLJgmw
         p23Pok5o2D4QquwHxAW0xianGu/2pfdB+8rlEogoy1rJepyXWgHYVWEn6ozc159QPjLY
         UOY6tNvXYjR2+miH1i0cuHmraiMe02L0oKrPLj2lshiqm5zI2n9cSabOAO81vaVJk5ys
         MYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915316; x=1691520116;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G19IhzqNLSoxiby4b6EqQurINKTfQBn8xfgBlFyGsbE=;
        b=gxqSrF8rHkPOdyUueDrHdkpExJGIm8KRDfXRzgfCiUgXzxUtQmV8d4jh4TfeB+1kwN
         oaySU/1aHr6MtBsS4RyIlQ5FfBiSp/4WCpjtqW0ltZ6UzJpjv7RMShjGPiAUCkIt+p1z
         iZSm8h+1kOB04UCB5N586BuMnr13trL+xZQxWmuS+/2sWvvcfRrVaNrDpqAG2+uW70d/
         a+mVQxONdZiPwKEnNZAwyMMJxovbR+6IEyBAVyR94FaL/SjSavXHwanWGLWv9c7ad7D5
         cjmPGFNSFZWfLWXr8hEBgfDqjb/3c5Uhnpi83t2ow2ioVK9CFLsXmEbI3hQrY049iwSp
         N0AQ==
X-Gm-Message-State: ABy/qLbxnKfRgzvqYwGm6qQq3TbJp0PkfjS/svY55ABddIGY4fglzdq+
        7AwzniCpaQCs3BsKIyukAJkRrJwlO0q7VaQRk9U1DkCusBNerVhMowBgvTQuDI8EKFxPOdJQtda
        skmub0HEWpaDplUULn1V2I56QaDypuoWpWWSuwPKxOTpwlvKTSAM2Jmhp1VkMqnZnn/rrhMBVZ2
        JX
X-Google-Smtp-Source: APBJJlGTDNZTR1gOLH4SdkCS+POap2nzSJXN8VyZPGaEY2XqTf4R29PwF55yLzbY6z8ruhV08EHG0wI+m2cirLJ6KpJC
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:a487:6e54:d296:9521])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:564:b0:d0f:a0a6:8e87 with
 SMTP id a4-20020a056902056400b00d0fa0a68e87mr82972ybt.2.1690915315949; Tue,
 01 Aug 2023 11:41:55 -0700 (PDT)
Date:   Tue,  1 Aug 2023 11:41:39 -0700
In-Reply-To: <cover.1690912539.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com> <cover.1690912539.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <2ade832a230af797ed844947e5e7e90cdbc77c26.1690912539.git.jonathantanmy@google.com>
Subject: [PATCH v7 4/7] t/helper/test-read-graph: implement `bloom-filters` mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/helper/test-read-graph.c | 42 +++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index c664928412..da9ac8584d 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -47,10 +47,32 @@ static void dump_graph_info(struct commit_graph *graph)
 	printf("\n");
 }
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_bloom_filters(struct commit_graph *graph)
+{
+	uint32_t i;
+
+	for (i = 0; i < graph->num_commits + graph->num_commits_in_base; i++) {
+		struct bloom_filter filter = { 0 };
+		size_t j;
+
+		if (load_bloom_filter_from_graph(graph, &filter, i) < 0) {
+			fprintf(stderr, "missing Bloom filter for graph "
+				"position %"PRIu32"\n", i);
+			continue;
+		}
+
+		for (j = 0; j < filter.len; j++)
+			printf("%02x", filter.data[j]);
+		if (filter.len)
+			printf("\n");
+	}
+}
+
+int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb;
+	int ret = 0;
 
 	setup_git_directory();
 	odb = the_repository->objects->odb;
@@ -58,14 +80,24 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	prepare_repo_settings(the_repository);
 
 	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
+	if (!graph) {
+		ret = 1;
+		goto done;
+	}
 
-	dump_graph_info(graph);
+	if (argc <= 1)
+		dump_graph_info(graph);
+	else if (!strcmp(argv[1], "bloom-filters"))
+		dump_graph_bloom_filters(graph);
+	else {
+		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
+		ret = 1;
+	}
 
+done:
 	UNLEAK(graph);
 
-	return 0;
+	return ret;
 }
 
 
-- 
2.41.0.585.gd2178a4bd4-goog


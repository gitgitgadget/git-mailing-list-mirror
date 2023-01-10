Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D038AC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjAJFoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjAJFoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0174101A
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fy8so25713098ejc.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orc6TrvkTPrWftmX63U4k1quqb1g2tUq7Rkvv4qxuWk=;
        b=Kz24v13749qaMTa5D6FAFLMcbvDw7dyXtV9VSEqcsauHDg+Fi5goQBhZLjV2f6RxCx
         /disbL1vNze6NkdkJEBENL3IOr+7sZAnGpCjN3umkDlTR2XQsc4o+wBe2CjPvfLcByoy
         SRjt3CxomQZD+tMKWX8SEOpvIPKy9PJyxt+btUZsCEcHhTjncMTq5ujnjebm34yQ/Jc7
         OM3fEnMIixhT228BSjemYnKbpvN9BOcDDFW41hfHtnkN64X9VzPBPL6zUcJcF0mh7w0x
         VFwcuxw6OJufDDrO/6sRLhR1nN4ujRSg+bf+sSI3VraJdPWHZvW91jsSthd3iqVJENkY
         56AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orc6TrvkTPrWftmX63U4k1quqb1g2tUq7Rkvv4qxuWk=;
        b=yPMqcIoUyuFFo8r+az9UR7BMTUdao5zokfCxItHsZHgx2dn/S9SOwJVjCc9IKZn69w
         zHNJ5G3LB8JALVCotCM8BAiAub6WGBGYJmoa9GucQViAM6AjTbu+wQ21+w9bKKH6XG6Q
         2kKiz4ALyP4eDKGre7jyTDNDad261Xc6LRkaBdfbrSRvmqAiGb1KcFirmuH2TNlfxpTJ
         PWnpzOI/cCWhamq6DOgWdXuppBy8U/3Bd9WmIaAdC3gDR60Dcs09Km2hkNql820BCqDu
         KYyJpuSXEN8NI+DnyGonUj205ECM54oIhr5qxE1Ts0gCbzjJhH0uZ49ACOTjUNYoKOv7
         Hw8Q==
X-Gm-Message-State: AFqh2kqkwNt46lYk4U1bmiBscaJuZN9SDavrGhHZy/aSTdZIGm7JuEM+
        TEasPE8nHHyrpV2mRk4hSIFRZ4rogv2Bmg==
X-Google-Smtp-Source: AMrXdXv4NCVhORSaFVFTDLxPG8FhumiOtwVvTOPuyKIF2etJBDNI+sVhfpPmWP/9HjRhBXnsH6x4MA==
X-Received: by 2002:a17:907:8c82:b0:7c0:f7b2:b19a with SMTP id td2-20020a1709078c8200b007c0f7b2b19amr62610196ejc.27.1673329433308;
        Mon, 09 Jan 2023 21:43:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 03/19] commit-graph: use free_commit_graph() instead of UNLEAK()
Date:   Tue, 10 Jan 2023 06:43:23 +0100
Message-Id: <patch-v3-03.19-8cc8060cd92-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 0bfb48e6723 (builtin/commit-graph.c: UNLEAK variables, 2018-10-03)
this was made to UNLEAK(), but we can just as easily invoke the
free_commit_graph() function added in c3756d5b7fc (commit-graph: add
free_commit_graph, 2018-07-11) instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e8f77f535f3..0102ac8540e 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -67,6 +67,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	int fd;
 	struct stat st;
 	int flags = 0;
+	int ret;
 
 	static struct option builtin_commit_graph_verify_options[] = {
 		OPT_BOOL(0, "shallow", &opts.shallow,
@@ -111,8 +112,9 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	if (!graph)
 		return !!open_ok;
 
-	UNLEAK(graph);
-	return verify_commit_graph(the_repository, graph, flags);
+	ret = verify_commit_graph(the_repository, graph, flags);
+	free_commit_graph(graph);
+	return ret;
 }
 
 extern int read_replace_refs;
-- 
2.39.0.1195.gabc92c078c4


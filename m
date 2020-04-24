Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F493C55191
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C61320706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqMAHNKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgDXPMq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbgDXPMp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:12:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47768C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h69so4758193pgc.8
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Svij7AqIu1IfO1+ocfAXfydIcw/vut33rQEygmYm5k=;
        b=IqMAHNKSz495sMWxticW3h66WMug5h027Ly0WnmWD1kr+Fwmuw0wsyW4r8bhGMeVNg
         bm8jFLouQeN5J8jLHLlAIQgnO4qLO/ysQB7wYIEyMeu5YksCppqVlaEyS9d9vWemkzj8
         vhLwXYkqT8RFlij9MpZFFDaVnjDExlZIOpHyd7BMCxspnlwMCrzhIaOXvgULhYUaF1QY
         yU1QSTc11TPXN9pEAa0rZ+K3o+JH+hKFWE9ADSDy6wQNbXelYcuoM+hyT7SFqT5hv6GG
         1EoA+DVGBSv82YeEaWlMsyp8A9KmPFhkHQBnrd8dzqVhC8y1dJr+ywSHc3ivCARlxgIX
         aYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Svij7AqIu1IfO1+ocfAXfydIcw/vut33rQEygmYm5k=;
        b=igrjZeRBZvmTM2e8NuEbqy3K0J+7zOlJiKG6+WpwERysj/NPZfsMVlWLz3g7AAN9kU
         ytWVPrEJ90MG4UIGxTLaAl012aB+QRe+Go83X9t4PDhf0UnVhhlDRyUNhFiXmYtWLlwW
         dfKFjtU+fcJleMVBRybBt5Qn5Zfuk3b9E5l0Ggv2JGrAeSuK1fMbw//m1xQ/Du1/xbbN
         f62N9dsBWGeb5K1VK7p/shnvn12O9ASs15crHJ/VeY3r2vQ8zOZRSexGLx0WqffWLlIR
         KITVSsqFwTRl7XNBbDBcbGYdPH9rR48OE38G9ljyxqtHIpjJFPj30CB4UhDDiBeWPcLi
         clLQ==
X-Gm-Message-State: AGi0PuY4UdvSSwpfjsu/g4A8nJcIYHouU/or6xjJ9Dl9K2N5gIke+cWb
        fb0Pq79OeTeKRczh8AQHPLyETzPP
X-Google-Smtp-Source: APiQypLKkPAdGs7RjH212tN0W5h5ACovcOOLD5n0Q51OYqmsr4r79pGjttZ9EXGXHxho6750kbScyA==
X-Received: by 2002:a62:a504:: with SMTP id v4mr3662639pfm.117.1587741164640;
        Fri, 24 Apr 2020 08:12:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id f99sm5078429pjg.22.2020.04.24.08.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:12:44 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/4] graph.c: limit linkage of internal variable
Date:   Fri, 24 Apr 2020 22:12:32 +0700
Message-Id: <39f8d85c2f16081415741351c16fb34d74924d3c.1587740959.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587740959.git.congdanhqx@gmail.com>
References: <cover.1587648870.git.congdanhqx@gmail.com> <cover.1587740959.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/graph.c b/graph.c
index 4fb25ad464..4cd9915075 100644
--- a/graph.c
+++ b/graph.c
@@ -1055,7 +1055,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 		graph_update_state(graph, GRAPH_COLLAPSING);
 }
 
-const char merge_chars[] = {'/', '|', '\\'};
+static const char merge_chars[] = {'/', '|', '\\'};
 
 static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
 {
-- 
2.26.2.384.g435bf60bd5


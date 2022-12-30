Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B7BC3DA7A
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiL3CS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiL3CSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:45 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A8B1705F
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:44 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so48720336ejc.4
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ue8HkUEhcsSu+wXsYg/oJCiIcWNWJ0EmEuOtVxLQfAU=;
        b=NLHRWsahwSB5kDohfa80Vz2hfb5nyOoavv72vcU+858SiSqMQ7q6qL+v20YH3VE+cj
         5iF6nP/esZAwjEGurJKAXIf0D0gO2skFh/LIrNHSq9Nhd+I5XfbwQs7pzmGVOMOdYK5Y
         o1AK1WxzsZI0EGzrjn3C3qM0P/HZYS9axcXF4885crw7CfH/POp4IQPZ4OC2Ery6OOzd
         LOqoiw2hw570cinbV3jhysEp7P+K53iyo2Gn6nhYKuf8c52YT6T58PcIwWFeof41jPPS
         PP1WXtQx6Ha9Ucxtzsakq52QASGugYyCxD+ycsXVHoJ7wP1Ak/oeZicFv/Qp+oWPdEwu
         pt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ue8HkUEhcsSu+wXsYg/oJCiIcWNWJ0EmEuOtVxLQfAU=;
        b=6gPIy3wn9T+y2oVmOVZQaCGY3ktTF2vGAL4op/jmkBW8tPBb7mVF3guqJ8bLRY15un
         cRw0HYo8CgACuuEOUKsfaDr3jwM+KClqEwAGo0AOqxXcujMhl3hcpcpMzphLkIHaPyBG
         HAJtSrvVAVjFBCy09CGQ5G8V3fAIR0j3MZwtR4Oh0sUQWczEE2Mnh+QQGpvLrVuiIk+k
         zIBIhqIJ3qUjgW8bdiTNi03UIkSe7AeSf6MYPMt7Nn4cmdSIP/Dah+DWlgFMfgSrA7Sr
         IJXSncDtpRSJ3K6+3VKil4O1F0f61Dm/PokyYbXue1XXWfeYXdQP4HXmyzTboXtBh1Uq
         f4yA==
X-Gm-Message-State: AFqh2kqCv1xI8eB3IbfjMZiWQ99RK+0IyCLMVvAndTmuIhe4SLBlyKs7
        OfGsdk3aBbFxdHjS1t3gDr7Tvrt2Z34AIg==
X-Google-Smtp-Source: AMrXdXvc7TWeZWBrJQjMf+bHlsy1WM3g23Ce7vMfRBzZkAwQcmd6CJ8wurCrKYWVhAK+xu+XfFl6bw==
X-Received: by 2002:a17:907:a0d0:b0:7c1:55aa:2e84 with SMTP id hw16-20020a170907a0d000b007c155aa2e84mr23880124ejc.1.1672366722356;
        Thu, 29 Dec 2022 18:18:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/20] commit-graph: use free() instead of UNLEAK()
Date:   Fri, 30 Dec 2022 03:18:18 +0100
Message-Id: <patch-v2-03.20-a840a1cb330-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc


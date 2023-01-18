Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D17C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjARMqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjARMqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476BB241E1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so25205638ejb.9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaSBqhwqTjB2hNqh3m5vH/RC9JqHAeewvEHTqaNglZE=;
        b=GHKwiHGkjxoYk0JUARFYmOFUAnqlNpeH27xbITYohPkZQeFHKpsJXSe8vPHoBM66Lg
         T7wjDZxn5yZ1SltKHOvehKWalXFju7HKauUJlojaooXZBv818xQuQyQ7yitCKJKYOzpt
         LKg/oE6NTxn8B0IZM4CAgrRLcyzsUzeysJx5DpnCXrxbTLY7kYhZCX/7xTdaxjj3qP6e
         gtAV9hGoOZNyMgxk1o93LHBvIV+qj6jZRuJvL8wDKy3WB3cH2k/Ye5cVQSGTNt/CF+Dz
         31gAXfBuZjeGHzJfQTvclPKAt+/GPPcmTWx28aQG6fhx+fMgBser5lNwtJV/RdyKg3g/
         UXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaSBqhwqTjB2hNqh3m5vH/RC9JqHAeewvEHTqaNglZE=;
        b=gIooOITtNXtksteGzi2QQd93YebTLoaEPKpJXKjX8wMM4j3LY2Ugo69j2oZsoPBXqK
         e/mlJlr5xCtMO2EXGcf3N+hTn2+gq7aSocKgI+pHVo0pc/SPQ+GrJJ9a1aNovi7VSuCP
         sp2cLSt8heS6b8DwmPqel2h9LNRj1p9f5+FMlJ+qvDQAKwwfpa0ixMXPgkUrJNjSq/GF
         dkyXzTiCLMZCqrAeFAbLDTH5nI9S+QjxqTU7wUD8DLI79eL5I0GmXm0AjW4rteewklQs
         4Ig9K11ydY8Ug/7boVEixIlgJe56WNhIsbKOD4LghY0O8Af05s1yB6ZyrQT3RWvfcWV2
         KZOQ==
X-Gm-Message-State: AFqh2ko3s5DoErIJNiz16SAmti6xrqZhDJN1d4cQ5//KH59QnLJH6FcX
        shVWkcg3zo0mPvvl2xJXu/BB1cLmCQZE1w==
X-Google-Smtp-Source: AMrXdXt8XNZ3rOBV0TnPz75QezWqQbvu6yNUYh9n8Djvu9pkeUlbZayyCO68LZ17Du/yJ/XDefWEbA==
X-Received: by 2002:a17:906:244b:b0:7be:fb2c:c112 with SMTP id a11-20020a170906244b00b007befb2cc112mr6425846ejb.66.1674043716899;
        Wed, 18 Jan 2023 04:08:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/19] commit-graph: use free_commit_graph() instead of UNLEAK()
Date:   Wed, 18 Jan 2023 13:08:16 +0100
Message-Id: <patch-v5-03.19-01b6229f18a-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d


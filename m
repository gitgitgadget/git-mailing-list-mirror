Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B2C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAQRLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjAQRLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2382134562
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v10so44794358edi.8
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaSBqhwqTjB2hNqh3m5vH/RC9JqHAeewvEHTqaNglZE=;
        b=Xqj73dKzaj64Jl8Q0t4AwLG+t2Hgb+Ic1lwGSmz9ZTEJDuaoWd5cb4iHHXAbL5u9HP
         MgzspGtq+9k6zznsOcjnS3N3kAE1ilFxmlcB3n3ljTWc4awpjzryBGZqOVrDHjrbnZAd
         bTO2+dNj+XcDjdtcZZzGd5pSV/ixURWodKu2UMm/w+hEaQ8UrcxtKdYDKdXcgOlCpkWr
         sZqiYDaa8kxJhDq9SkM4KUm/RIvMa3CnM9i+b/PaZbKomXYgdwph1h3KtBwUb91Zfbc4
         I3GKLPzSzu8GFp82CCUr89SJP2/X5HF3uQnXg3x58eXxJ93xc2ZyVC/a6yiBdMoXuuek
         7uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaSBqhwqTjB2hNqh3m5vH/RC9JqHAeewvEHTqaNglZE=;
        b=Z5HMYdLKQnb1yuR5d/VdGAa5tUkn/Pdvk0ETo83bW84eBXOfh3T2HL5MbzASke97Tk
         f9LQck1Ard+NZEEDS1mMdZRxLi5zGuME6PT5qSGZrDTqXNDoTkdGl2FvofNCpi0AIfJU
         FSoqDZ5sXM5mQn1d3N2vK6Lryxq4F67BdQHCC4ZM6XJ+TmVhpAVjhqIlYm5Fl200CmbR
         52mUSykfWXTQZUhxmdn9hMNvxgegX0KbSOHRMMibIT8fPjY8/TAm5Q3yCx1GeUaPnPIN
         8KmFbzhozgWg+GXsGvR6VcRSHB1juBZGDfBFEwA8L+mE32HQ8qrBQjSeuxB6oMsiJxnF
         QiQA==
X-Gm-Message-State: AFqh2koi7tITq8GYjZi66aVyzEDVfDvdvElnLJ7+C5d6fSg2rgjK0ehh
        bNQ+2gUpHTWovkWw35scZl/R46CEvqxtng==
X-Google-Smtp-Source: AMrXdXulKnZU8taBHuOTEmn/roysaAzF+OrF+BLfZez+dMKHkiC4SljmRh13I1ovip2ajeP1x/+t4g==
X-Received: by 2002:a05:6402:2b92:b0:45a:7d2:9b35 with SMTP id fj18-20020a0564022b9200b0045a07d29b35mr3985412edb.0.1673975489233;
        Tue, 17 Jan 2023 09:11:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/19] commit-graph: use free_commit_graph() instead of UNLEAK()
Date:   Tue, 17 Jan 2023 18:11:08 +0100
Message-Id: <patch-v4-03.19-8e98d7c4ebf-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
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


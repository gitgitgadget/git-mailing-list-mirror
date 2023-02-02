Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABC8C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjBBJxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjBBJxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C62D9039
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3289620wma.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4TEZEiX6R0VS5kl1AYrgTkik40WretknH+ZEUFqHK0=;
        b=UFCvTXUVN5p83QwnABr1wAwkEyNLh2pFoKrjCIZXj4V4clTPeVetD8bZsKS1tudnEY
         pdDDUcv0oLwMe/q0YvOcml/u3dCg1xmJORRAnQB0eU5ZtwML7KrQynf/l6LVXP6wHMsB
         dTwcd8waryZwy4qeoxF2x7RAq74bbckfaTbJWDHuIzVrnaEs7K/Rp85wJSA5Cvrj2djQ
         Ez9JD+0jZHKAqOIx2Fswh9UofJpxcKcPj1AEMADimJoQuO366eXi9sIloYB31sBDMaem
         4OPUj6SW90a6ulTbvigAwGJHlbiUSZu2KeFxmb1WwKCivJvaFy9dycbVtVqyfBH47Pus
         0ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4TEZEiX6R0VS5kl1AYrgTkik40WretknH+ZEUFqHK0=;
        b=XECbjcFQn220DAwHpjuVOAPau/Tn/+JxHoN+3LwWhcxlkawgjWh0R/do0gST/jTUTS
         LgfplW4ZZJ3KFan9/U+HN1r8DHyxTiNocA36GtkkVQidp67fLPQB07yGmczKhIX8+6eE
         ALiOx+sPhW8aPSsyLppajWgvn+K48HbeGUqq0HyOM1VtlJIQF9Huk7Z+vRv81m1emMwU
         BMxOvGhMVngSrnLbdL4C/jHIvS+nr1LBpuQChnrdQyoiUdCl/VFUPtLOFSChE88o6PyA
         lPRRZpoRamplUI5Ia9tHJ3rYc6vbSVZsy7d8PTeoa31qlsHH5GcsuPzdhZ+D0DSBmUpS
         vqkw==
X-Gm-Message-State: AO0yUKVjWJ7EtAEf3/xY9sDGKikDLHVPXKwNrRxbHP43R8lVJmdPa1Q9
        wByDA8QSjbdUrvbH0H/kydH3mxf4CXwfKaUl
X-Google-Smtp-Source: AK7set/OhrGZLNqKlbn8bNk2m9YXwcYlyeyLP5d8btUKJAjrCEIObKnH0fn561fYwi4/ZExTPNR0kg==
X-Received: by 2002:a7b:ce15:0:b0:3d9:f769:2115 with SMTP id m21-20020a7bce15000000b003d9f7692115mr5266232wmc.26.1675331578552;
        Thu, 02 Feb 2023 01:52:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:52:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 03/19] commit-graph: use free_commit_graph() instead of UNLEAK()
Date:   Thu,  2 Feb 2023 10:52:34 +0100
Message-Id: <patch-v6-03.19-cf0dddf4e8c-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
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
2.39.1.1392.g63e6d408230


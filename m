Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4EC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBFXIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBFXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:15 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D347297
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:13 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hr39so9157767ejc.7
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKgNgTEMH5UV/souo70w8ddn/zIWhZuap7B0+j1e0EU=;
        b=JP2dxiju1IZH5Fe0cR7u04lU+r1t9MNTkjpKmNiGM5f0J+6n6RK4J61tBgDO1e563f
         JgOk64WbIX8tM1gxuuE/14Sw6bg/qBXlhzeOlEsgIp68cgiuvI86g7G2jSU4eanUyj1X
         hty744dPTlKTqsl+ewift6INrcabYx7jfDKeokhRtQ87TrYKpKXFU3B6hZRcIp/nmwL7
         4cG+5qgHCOwv0fE8rKnDcMb87n4dO/AvTc02PxfR+IZwVY6uzKWQgfK9NTzjfee+9n2i
         8oOig2KcA2FBQzNlx0YSLJTRUZxF2FASAQQdcYZ3TDM4PEs8MAx7/Agp5Sti4Rh9tIuM
         bWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKgNgTEMH5UV/souo70w8ddn/zIWhZuap7B0+j1e0EU=;
        b=SdND65HrCR4uZf25aWkr8hEZvbdmurwWYhQOlZjeerwhkK8rBPz5MqJN2ohbgVSOGP
         wNMJhdEyi+1D/LMwmFkLtjCJ6r3apr3scu0Y+zVulP2nD4aRcruV09HHM2vBFmh8Xihv
         bdpg0tyJti0hA2/rGyvXtQyJ89J2Tt87aIkU76N6aJvZo3q5fg1AkgaGOqRUuyv3PAdM
         Zn1GwYIytUaEjgtbxU62qOH+W5XzGL6Sg5SeZkZKeNnHeB9rdX28pz1dTKgmAicd8G73
         XkzZRzJDilYAF4Jt+v3BFaHmbVGRshEcMPyxK3G602xQ6Eu/B6froiU03qxM6Cv8c94n
         /owA==
X-Gm-Message-State: AO0yUKVjVYDzDQGud5TcAyNw22KIJj8CrADZzH8Mg+pYjO8aAfqhCMBT
        QIui/Wsn1FjOINg1OLX89gWkrV+kkpcI3bbi
X-Google-Smtp-Source: AK7set+pUled7JbNLNOoFJ6vPirI+Uz3fLvNshOZdT7BN4CAzgdkeyCiq2eMg/pWl1aE49uEMCwQkQ==
X-Received: by 2002:a17:906:f56:b0:88c:5a80:a7bb with SMTP id h22-20020a1709060f5600b0088c5a80a7bbmr1110649ejj.6.1675724891740;
        Mon, 06 Feb 2023 15:08:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 03/19] commit-graph: use free_commit_graph() instead of UNLEAK()
Date:   Tue,  7 Feb 2023 00:07:38 +0100
Message-Id: <patch-v7-03.19-ea9ee63b37a-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c


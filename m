Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5AEC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiCDSdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbiCDSdY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C02A73B
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k24so4449208wrd.7
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHcRiiVN/HVvoD45UThhpIxV30rpZypcV+d76eM6ca4=;
        b=m/1QTSi71JZZWkxnXm9Pq1fFvG1UXobo0ftOHSnWtvvW8v5G8Od/oBQjAgPhjYphEO
         EbQh9fh9//YTWGn0Uwc/qbo9w/eoZQGVWx1vjwE4PM8ZKD0zXNxwAFemx37BtY16ai/2
         vBtdbu5SZBO0TwffTROKgFZndPQ2j1lfGJrSpiEZjqjHqH2+xi7gWXn+vXrHV1r5TG9c
         8B0dlQVmk6zlbt52kpkmlFDv/VY5cU9qVCkBYSewlQO6TVMWuWAskv6i7E3MIV7BcS8f
         lC5wnaEr7qYDe6ub3WsXy4LOL+P09m1hPclVnivCo0EFwcc5f8pCzUcVyaMa91Gx8o/Z
         TYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHcRiiVN/HVvoD45UThhpIxV30rpZypcV+d76eM6ca4=;
        b=ZB8hhwIshKGuncnXv+xnGXqGK0MDJ6WEEm04vMVrSPCmKVBHYwn8KL8SkapArFO8u8
         VVNxpdPAkQVv3MHWKt3V/+gxNnRunTJXl5AEv6pSpq7ukmdWZtvA+Wp28Mo+pBuU0qRN
         cHornGLbVLvl1s4tlkbU3fwSJ0q1uyz76IHR9so89FjFodCwfNxsrheJXl7hpyYfrCsc
         +hrys/W76fWu6K5NXaLmFIwCp9i0oQ+1HpOANaeyvudg2hbncIumfIFIMPcjvjpp4D/G
         zTxNFb02Xs9HPP9u2Ox7KdY0CzRD/zeY6pPLA1lBtB8Xp47ssp/dOfi0uMc3fscO/wVM
         +maQ==
X-Gm-Message-State: AOAM530cvMlY44neZ3Y8sW61gVO7TBH686XfJbiQAP/HOq5rgD5fjw19
        PMKpp/4gVDkDrri8GgiRTQT4N5YrRCe1RQ==
X-Google-Smtp-Source: ABdhPJymlaiL2w2QjMhnPiB1yWRvfk61sVG3ln5bzaoXkp/lJwYuM3Ea3Ja7yFymNSLx8fY2CKFfXg==
X-Received: by 2002:adf:e2cf:0:b0:1ed:a702:5ef4 with SMTP id d15-20020adfe2cf000000b001eda7025ef4mr8452wrj.487.1646418749328;
        Fri, 04 Mar 2022 10:32:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/14] submodule--helper: fix trivial leak in module_add()
Date:   Fri,  4 Mar 2022 19:32:11 +0100
Message-Id: <patch-v2-08.14-af3ca2f0b5f-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in a6226fd772b (submodule--helper:
convert the bulk of cmd_add() to C, 2021-08-10). If "realrepo" isn't a
copy of the "repo" member we should free() it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eeacefcc383..13b4841327d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3309,6 +3309,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 {
 	int force = 0, quiet = 0, progress = 0, dissociate = 0;
 	struct add_data add_data = ADD_DATA_INIT;
+	char *to_free = NULL;
 
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
@@ -3360,7 +3361,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 			      "of the working tree"));
 
 		/* dereference source url relative to parent's url */
-		add_data.realrepo = resolve_relative_url(add_data.repo, NULL, 1);
+		to_free = resolve_relative_url(add_data.repo, NULL, 1);
+		add_data.realrepo = to_free;
 	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
 		add_data.realrepo = add_data.repo;
 	} else {
@@ -3413,6 +3415,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	}
 	configure_added_submodule(&add_data);
 	free(add_data.sm_path);
+	free(to_free);
 
 	return 0;
 }
-- 
2.35.1.1248.gb68c9165ad8


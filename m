Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F8C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbiBWScV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243907AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD04B863
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so1925507wms.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v9RFMQ7zWfgEqIwSaWdpAS9Bc5xyQgRqjjpEu14/g1s=;
        b=KtGT6wbKSWJal+gXD3/9SB7ZKOMMU6ZzPlNi2JzCGa+RC2K2RVwVq+AC84Tw08oE2w
         p2TQ/4DKC3KzmanN8jKFInHENTz61FRwxiA7VnaR62UIN2n7eavIHhfxFNdNKKa3LRsx
         HKZ/poXPKP8FGypkRFMQbw3qVDExyNEneZCX45q1lan61N1ph6Vyd1vLFaPke+I0ob9L
         HrJqWqjbdJaDU2lNx7aG8jimNZ0v7TSFcLy+VL4u4xySG5G/y68TSKzQEFu3DONnvsVW
         Jp21KpNBQ+SxSv4aqjd9MI2Em7p/r6KB8VHib1i/ophbuDj1g+1IQcjDzLoEMyfKT5NH
         ynKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v9RFMQ7zWfgEqIwSaWdpAS9Bc5xyQgRqjjpEu14/g1s=;
        b=VoxpXwVGPZLGxyhN/F3xEOqdv1chM68wdrSuhUrFjwhAkFn5vbs8CPuY4/r00sktsn
         sHkRXRsWB6h4EAdapeDypAkklIwtlFaQlP8xucjD6gTgRhjefaoS2XNo40OkPlEw00Zb
         s0l/dlO7Ejryiuqqf7Bak84SS4359kjFe68Bu0d1ZP+Hc4fmPPIQbNcs1czAiWG9WWU9
         kPat6WmlJNMeypc+ImjNrVgwjAj7WajZ/a9TZ6a1PaHwPGfZTQ9BKiUdBQKoj10J7soI
         2slC9LsULUdypPq8cMmogLtPhtJY3XLc6+I0ovHiWmNPmejG2oyrQly1qii5eIAbGO1h
         SS1A==
X-Gm-Message-State: AOAM532jlQ7/5VxJZGKmM34tvQAxlyEn3T3TSrIZ0YfGVSK+8mL2a/Rj
        fhY+biDprWSH5q0KWygGDy7MtIOLKBU=
X-Google-Smtp-Source: ABdhPJwIfOyMEBJY0ztz7OeUsbit2UvqR/Nt7vpkyz5WTpNiLM+vXn5v83QFw+Wdd/cQ90opm9DiBQ==
X-Received: by 2002:a1c:f413:0:b0:37b:d1de:5762 with SMTP id z19-20020a1cf413000000b0037bd1de5762mr804040wma.108.1645641082663;
        Wed, 23 Feb 2022 10:31:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm272974wre.102.2022.02.23.10.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:22 -0800 (PST)
Message-Id: <42d351f4aae9532d2787e72ae4be2e08fe614f44.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:55 +0000
Subject: [PATCH 17/25] fetch: fetch bundles before fetching original data
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

If a user cloned using a bundle URI, then they might want to re-use it
to download new bundles during 'git fetch' before fetching the remaining
objects from the origin server. Use the 'fetch.bundleURI' config as the
indicator for whether this extra step should happen.

Do not fetch bundles if --dry-run is specified.

RFC-TODO: add tests.

RFC-TODO: update Documentation/git-fetch.txt

RFC-TODO: update Documentation/config/

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fetch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6f5e1578639..c0fece55632 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "bundle.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -2081,6 +2082,22 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	/* FETCH_HEAD never gets updated in --dry-run mode */
 	if (dry_run)
 		write_fetch_head = 0;
+	else {
+		/*
+		 * --dry-run mode skips bundle downloads, which might
+		 * update some refs.
+		 */
+		char *bundle_uri = NULL;
+		git_config_get_string("fetch.bundleuri", &bundle_uri);
+
+		if (bundle_uri) {
+			char *filter = NULL;
+			git_config_get_string("fetch.bundlefilter", &filter);
+			fetch_bundle_uri(bundle_uri, filter);
+			free(bundle_uri);
+			free(filter);
+		}
+	}
 
 	if (all) {
 		if (argc == 1)
-- 
gitgitgadget


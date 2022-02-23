Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BCAC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiBWScY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775074B862
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j22so14987675wrb.13
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M1drjjGdWYYVE/wOjGuoFe1tl2uD5YSXOdkKy/YTNkI=;
        b=T6GvC0ipO0DquIC3tPOl/38SUYRPZMwyZXn4ry8yQH9LH2dynDKs9rhacX3sOi6jHN
         kQUJtOzH5x0VUnT8rr7JBZhoW9HfFfy82SlzPPNSOhjuLncuN6GULTcAtrkmVeDKzAZj
         NarhoXyeX++Q9W5h7NUWB5JgEfb0s0ljRHQ+rTJaYy4ZE8W2WYMTWdirUnglhkpuUbv3
         OSFiph6T0iuL3iOEK1qReKdNP2bP+zI5GGdQmEb0741DEibTieV0TreQYBwYIKWoJLHV
         2JSSQFSQxEB11todVYOvTXDrLILe4ox3hrNE3MCPCIBidihwz/1n+AlPRypEVYc5zupk
         FiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M1drjjGdWYYVE/wOjGuoFe1tl2uD5YSXOdkKy/YTNkI=;
        b=dSqXe4nRdle9UCQEpUqlpOg1g2qbYup8S0Pkh56D8eFkfa0eWvah4lgSCfx5zB3MbO
         H9Hgu1s6tD2Ziu5GRD8HqiqpNfJ0rdxDMAlfeOJPASetybCOPK74qdvBk8r+P8SFrISA
         Mer0PFuT574yAmmgcPIMkXkcssMcMyv9Q/fHmhsIxx1hl+4G2wAv34jyxO7TPJ898M89
         AzRE0Io5zyAN4LY+FlYW+7xIgOX44qG+GhRA8Wl1afbBeGhUWOnphbV9rczdDlUQXKZH
         NP3ujW4T3dqw/DqNt9h4W5SzB7ORs53OM+1Pl+QicN+UVUAz8g1B/6dc6doqbXQ5PYdf
         g4Qw==
X-Gm-Message-State: AOAM531n9sj7JoPnnw7jBtwz4sEfRpqOlPMr+2ek4FFjU4++m4R8Pc5o
        J+KAOo9M5RVQ3i7WCqdSc/ZPlYG9bkQ=
X-Google-Smtp-Source: ABdhPJwLchjiYTEgakcGGLKqNVWc7KUKUo8gmucH573nk2KdQLJkLdroD278/juzx2rHrz6bLLbMpA==
X-Received: by 2002:a05:6000:1846:b0:1ea:7f4d:c56f with SMTP id c6-20020a056000184600b001ea7f4dc56fmr675438wri.25.1645641081853;
        Wed, 23 Feb 2022 10:31:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm391767wri.35.2022.02.23.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:21 -0800 (PST)
Message-Id: <5f7f54e9205acbe072ad436e83e3e98a36f1df3b.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:54 +0000
Subject: [PATCH 16/25] bundle: only fetch bundles if timestamp is new
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

If a bundle server is providing a table of contents with timestamps for
the bundles, then we can store the most-recent timestamp and use that as
a test if the bundle server has any new information. Teach 'git bundle
fetch' to store the timestamp in the config file as
'fetch.bundleTimestamp' and compare the existing value to the
most-recent timestamp in the bundle server's table of contents. If the
new timestamp is at most the stored timestamp, then exit early (with
success). If the new timestamp is greater than the stored timestamp,
then continue with the normal fetch logic of downloading the most-recent
bundle until all missing objects are satisfied. Store that new timestamp
in the config for next time.

RFC-TODO: Update documentation of 'git bundle fetch' to match his new
behavior.

RFC-TODO: Add 'fetch.bundleTimestamp' to Documentation/config/

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index ec969a62ae1..cab99ee2b15 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -409,6 +409,9 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	struct remote_bundle_info *stack = NULL;
 	struct hashmap toc = { 0 };
 	const char *filter = NULL;
+	const char *timestamp_key = "fetch.bundletimestamp";
+	timestamp_t stored_time = 0;
+	timestamp_t max_time = 0;
 
 	struct option options[] = {
 		OPT_BOOL(0, "progress", &progress,
@@ -424,6 +427,8 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	if (!startup_info->have_repository)
 		die(_("'fetch' requires a repository"));
 
+	git_config_get_timestamp(timestamp_key, &stored_time);
+
 	/*
 	 * Step 1: determine protocol for uri, and download contents to
 	 * a temporary location.
@@ -445,7 +450,6 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	} else {
 		struct hashmap_iter iter;
 		struct remote_bundle_info *info;
-		timestamp_t max_time = 0;
 
 		/* populate a hashtable with all relevant bundles. */
 		used_hashmap = 1;
@@ -476,6 +480,13 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 				max_time = info->timestamp;
 			}
 		}
+
+		trace2_data_intmax("bundle", the_repository, "max_time", max_time);
+		trace2_data_intmax("bundle", the_repository, "stored_time", stored_time);
+
+		/* Skip fetching bundles if data isn't new enough. */
+		if (max_time <= stored_time)
+			goto cleanup;
 	}
 
 	/*
@@ -563,6 +574,14 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		stack = stack->stack_next;
 	}
 
+	if (max_time) {
+		struct strbuf tstr = STRBUF_INIT;
+		strbuf_addf(&tstr, "%"PRIuMAX"", max_time);
+		git_config_set_gently(timestamp_key, tstr.buf);
+		strbuf_release(&tstr);
+	}
+
+cleanup:
 	if (used_hashmap) {
 		struct hashmap_iter iter;
 		struct remote_bundle_info *info;
-- 
gitgitgadget


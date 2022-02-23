Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7678AC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiBWScK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiBWSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908745AE4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f17so16230133wrh.7
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x8827e6tp2kO2qZ735l3t7QGL5QSAt3RhPUIWuYgixg=;
        b=cTUPHe7q2hDFBxPDkUC9wLGfqPYVAEspZF+De1PKGlU9pFGtNwTInL4IuaLMmjYzmT
         BM5hlGKJOZNRSVJ3r3l7/LC1gzRAyyQEe6UuahXobroPWiPVapMCs4y4vd8YLL58lhvW
         OBUhnYrJUg2IbStc1OnQKL+j26QK1d0Clk+7RHNJ3HrRiqTNXGSLPjEuylgsx99hrcO2
         NwE01AAnrnZbxRcJOIPDjHQyqbxh3rosJW2dCbJlW30ZKgQHnVwP45ACkSIb8QGaGO4t
         g5ktJymCs0DotL+fsUPa4aBbEfyD/1XeSaSVd07TqQ1VOTHhRyUNg8rLkTdc0epTCim5
         m4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x8827e6tp2kO2qZ735l3t7QGL5QSAt3RhPUIWuYgixg=;
        b=tIwzTni7r4/I1JDXLUalvr9Z4trNMmtBmjfIrw00oqqvA5YdzcHAWOvHfPjDm/ihqF
         uogPqlFaK7ZBAkEnT8ggk88kuJfU9G3Z4tcFWHeV9saLQx99pYfCa81vn13iUtyvCKTa
         e+in6mWayle43Bd3cGRlow7RJbROJMbGtW00GorAFLwPZ72arz2jfdRLusrricYi9Krl
         GUZVsY0rDcqAW4LxMs89JsfcyqLTOI5dSWmFsJJjgdJ1Hufw03k9zHJB+hZE6yi6CDT/
         r8XTl7cBS5l1a5AaV7DnL7iTcnz0ZyZJNwfhguu/y1hxFM7rZezmZq4eCs/JeIIK8O4K
         3RLw==
X-Gm-Message-State: AOAM532OCUUX6gig95JqdKUy8VehznGOuxCl1VCkWVuzTtU0119q1HKY
        V45s6xS6KynYFcx34X+vAVYv01c0m7k=
X-Google-Smtp-Source: ABdhPJwmP61ubEjGQt8G0FvS8V97KyQXNmPWa5tzmIEtCkg2BE7dYJ/nBFrvwZepV7L3t2IM3BuNbA==
X-Received: by 2002:a5d:52ca:0:b0:1e5:8cbc:7f2e with SMTP id r10-20020a5d52ca000000b001e58cbc7f2emr670323wrv.309.1645641076549;
        Wed, 23 Feb 2022 10:31:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm252746wmb.19.2022.02.23.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:16 -0800 (PST)
Message-Id: <bdd5c664cde070a93d7e698aff2ab11ce7557ee2.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:49 +0000
Subject: [PATCH 11/25] bundle: allow relative URLs in table of contents
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

When hosting bundle data, it can be helpful to distribute that data
across multiple CDNs. This might require a change in the base URI, all
the way to the domain name. If all bundles require an absolute URI in
their 'uri' value, then every push to a CDN would require altering the
table of contents to match the expected domain and exact location within
it.

Allow the table of contents to specify a relative URI for the bundles.
This allows easier distribution of bundle data.

RFC-TODO: An earlier change referenced relative URLs, but it was not
implemented until this change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 27da5e3737f..ec969a62ae1 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "remote.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -453,6 +454,8 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
 		/* initialize stack using timestamp heuristic. */
 		hashmap_for_each_entry(&toc, &iter, info, ent) {
+			char *old_uri;
+
 			/* Skip if filter does not match. */
 			if (!filter && info->filter_str)
 				continue;
@@ -460,6 +463,10 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 			    (!info->filter_str || strcasecmp(filter, info->filter_str)))
 				continue;
 
+			old_uri = info->uri;
+			info->uri = relative_url(bundle_uri, info->uri, NULL);
+			free(old_uri);
+
 			/*
 			 * Now that the filter matches, start with the
 			 * bundle with largest timestamp.
-- 
gitgitgadget


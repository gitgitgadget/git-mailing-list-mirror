Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F406C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiBWScM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiBWSbq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:46 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487714B416
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c18-20020a7bc852000000b003806ce86c6dso2103982wml.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gk7hwcevbSQEOI3ogjwQ6/G/ReEKIjYaCr5lOLD/awU=;
        b=dwFKRG9FYKQWdJ5NSphVxPfeWyOirI2jfTjvERZJCesgx1QAzEm9fVR1czBqC7zvqk
         zJlfseaFrfHufTVLublsDOCet68Kl91ZfmaTl4kJTLnb9SxDdLNMTDSOvos5NkwOCtXq
         wmWL96QCBlgAzHXDGlCtJmDr9Qtu6ZTa39MoI9GX5n/eTA7lgMNrCaW4uAHjj5Qux6bd
         bpIfF1nhczIf/q3eiBAOuSPjlfl+98/vlwJ/JN5Cp979c8AuPzmNJcuSAtvexFyiF97W
         n7NDN6ljXVWQiDwE2cYcIktpoUzNiUBrp76wlNaWpFfncALevNVGsti49Lxv9SOEyzho
         AHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gk7hwcevbSQEOI3ogjwQ6/G/ReEKIjYaCr5lOLD/awU=;
        b=Os8GTahfVQA078siivyvsgwqId7iF6jZvmNpkp3X3QUQ/LnSF6IiuMFcIG98OxM86Y
         YC43EdtUGPO7irLLRYrwmUkIwYHlZrl9Gu3lLw8LXKbhaQ6DPPuHjuR09mkSYcPfuM2Y
         sMbBCDNv3BzI8biTzU0aQ4JS7tdO4VakQ9HT08o6hrhTdnYavNqdq8iRyrBzjtX9U5g5
         LDYivE1HhTJsLlPaPmT0Yrn3rio3hS8QzPQJsOGvRURLDtgHl1kZiHo/sc32xTc5eq/g
         I2Nfo/YmU6Jjw5lfvXOUjZm60XMbKtka+PaTcy6QVzzSi/l1w+doWpxfr9361/myOodX
         1QyA==
X-Gm-Message-State: AOAM530kM9e/FK12Y1U1odG0l9fk3aIZISQFGqmx9Zx6GU1CBtEmoJqJ
        C0Hie6NNQqNQ2WhYbghXqqPV70iBfjQ=
X-Google-Smtp-Source: ABdhPJwcqZ2FYfcvZ+h0Nb91OF2MTityydREWKs6WquZDCxD1E5Hg3AyLKfW71FDYtaVLR+9CJppag==
X-Received: by 2002:a1c:a915:0:b0:380:e3de:b78f with SMTP id s21-20020a1ca915000000b00380e3deb78fmr6134867wme.19.1645641075644;
        Wed, 23 Feb 2022 10:31:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31sm282236wms.4.2022.02.23.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:15 -0800 (PST)
Message-Id: <fa0e83b39dd3c3bb16e932c39aff080a1fdf8fe4.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:48 +0000
Subject: [PATCH 10/25] bundle: add --filter option to 'fetch'
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

When a repository uses an object filter for partial clone, the 'git
bundle fetch' command should try to download bundles that match that
filter.

Teach 'git bundle fetch' to take a '--filter' option and then only
consider bundles that match that filter (or lack thereof). This allows
the bundle server to advertise different sets of bundles for different
filters.

Add some verification to be sure that the bundle we downloaded actually
uses that filter. This is especially important when no filter is
requested but the downloaded bundle _does_ have a filter.

RFC-TODO: add tests for the happy path.

RFC-TODO: add tests for these validations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 66f3b3c9376..27da5e3737f 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "config.h"
 #include "packfile.h"
+#include "list-objects-filter-options.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -406,10 +407,13 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	};
 	struct remote_bundle_info *stack = NULL;
 	struct hashmap toc = { 0 };
+	const char *filter = NULL;
 
 	struct option options[] = {
 		OPT_BOOL(0, "progress", &progress,
 			 N_("show progress meter")),
+		OPT_STRING(0, "filter", &filter,
+			   N_("filter-spec"), N_("only install bundles matching this filter")),
 		OPT_END()
 	};
 
@@ -449,6 +453,17 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
 		/* initialize stack using timestamp heuristic. */
 		hashmap_for_each_entry(&toc, &iter, info, ent) {
+			/* Skip if filter does not match. */
+			if (!filter && info->filter_str)
+				continue;
+			if (filter &&
+			    (!info->filter_str || strcasecmp(filter, info->filter_str)))
+				continue;
+
+			/*
+			 * Now that the filter matches, start with the
+			 * bundle with largest timestamp.
+			 */
 			if (info->timestamp > max_time || !stack) {
 				stack = info;
 				max_time = info->timestamp;
@@ -468,6 +483,7 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	while (stack) {
 		int valid = 1;
 		int bundle_fd;
+		const char *filter_str = NULL;
 		struct string_list_item *prereq;
 		struct bundle_header header = BUNDLE_HEADER_INIT;
 
@@ -483,6 +499,16 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		if (bundle_fd < 0)
 			die(_("failed to read bundle from '%s'"), stack->uri);
 
+		if (header.filter)
+			filter_str = list_objects_filter_spec(header.filter);
+
+		if (filter && (!filter_str || strcasecmp(filter, filter_str)))
+			die(_("bundle from '%s' does not match expected filter"),
+			    stack->uri);
+		if (!filter && filter_str)
+			die(_("bundle from '%s' has an unexpected filter"),
+			    stack->uri);
+
 		reprepare_packed_git(the_repository);
 		for_each_string_list_item(prereq, &header.prerequisites) {
 			struct object_info info = OBJECT_INFO_INIT;
-- 
gitgitgadget


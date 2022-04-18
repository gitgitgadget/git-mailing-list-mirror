Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9158C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347059AbiDRR2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbiDRR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E6344FE
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8635094wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQ12NVVcNyMOFVSyVlw1atTyWFi8Za7hyho5pf1/YVM=;
        b=UuaX81gtndrt3W4DI0F6LV/0Tk4zsXuydarT+tr5RZYWygStLquKc14gVnOOHd0HAY
         HGf8f4y67ZEdmclUX0KCOWt18ZGcER49LGCdlm6XAwbhJPmbBW/dDGiC105anp3Uj2DE
         fQ/ESSiTeDqM065nkv5w7CEKCQtqHwVIGarLNre1vSj2/0R6wqCNlvoyapeoEb0JMKP/
         SZ8P42rIXDTqAlWr5lPtYtLOJ5/xoEUKUszkL28d4fCutw8jyMq7kMPIwwyH01yExM0A
         mDVbhAHi8/s+/ocQUUK1tKMr+8js51WV4BwaiT2BJH0i6zR0rhVTJCri3izXRbdrcTJJ
         TTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQ12NVVcNyMOFVSyVlw1atTyWFi8Za7hyho5pf1/YVM=;
        b=vCB1o8CLGBAAFz6xkDeTt7Fy9WkiVkDPRsCFKdriQvztKfbbMjTIPF5qKPTfVf2sBB
         GVrhJ0TG9JkcyM3tBaUeUDLHZv9Osj83G3qZRLCBWQi1vPfSQO4OT6ykQnCpIr+ozYbI
         OKiITzbJrix12I4Dqz7XVal63y2Is+J5jpW+abwmW+9BJiMPnIxgom+pCPuK7qCwvvZR
         8173lmg4QFkenM8UGRAG8iz4IG1xF4I2I9qhFrqbw8mSJt/Ptv6KNdvLwoKiK6JCSTQX
         ISi2LZ4HG1Idt9+8GkvC+Gt8T2A4hrNsXJmhMwj+cepWJoYAuvlaPKLzmdvEruERZ3MV
         QZhg==
X-Gm-Message-State: AOAM531xIKO98h9WaMwX3n/G5/RamqDyS7WiHjQXuF2ywpF4vzqpjkm+
        qzS8fs8zjX13cf/YXlzVhPg+hATuosXXGA==
X-Google-Smtp-Source: ABdhPJxePGPPi3VtHl3AmG4UP8+WwGpikXQCcPLnE+vx93puoBz1M+SUNmZeTAI77fmOeauRl42Sjw==
X-Received: by 2002:a05:600c:5114:b0:38e:bd9c:9cb0 with SMTP id o20-20020a05600c511400b0038ebd9c9cb0mr15800726wms.153.1650302661197;
        Mon, 18 Apr 2022 10:24:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 20/36] bundle: add --filter option to 'fetch'
Date:   Mon, 18 Apr 2022 19:23:37 +0200
Message-Id: <RFC-patch-v2-20.36-c3a60a9bc72-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 255d7aa774b..711e0863a16 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -9,6 +9,7 @@
 #include "refs.h"
 #include "config.h"
 #include "packfile.h"
+#include "list-objects-filter-options.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -410,10 +411,13 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
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
 
@@ -453,6 +457,17 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
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
@@ -472,6 +487,7 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 	while (stack) {
 		int valid = 1;
 		int bundle_fd;
+		const char *filter_str = NULL;
 		struct string_list_item *prereq;
 		struct bundle_header header = BUNDLE_HEADER_INIT;
 
@@ -487,6 +503,16 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 		if (bundle_fd < 0)
 			die(_("failed to read bundle from '%s'"), stack->uri);
 
+		if (header.filter.choice)
+			filter_str = list_objects_filter_spec(&header.filter);
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
2.36.0.rc2.902.g60576bbc845


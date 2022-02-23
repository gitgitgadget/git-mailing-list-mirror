Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59229C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiBWRzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiBWRzu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03AAE5D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y5so3789748wmi.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2uvoAv8r7xSnCh6eMu60yhWRWmcE78KKGIGJIpmlJQA=;
        b=UQvH4+otMB6/0OegciWEapNksKXhMYY4G2FoDwsi0bpE5CjDTXl2SL+rmcg8iM5O6S
         JGK12UU1MfmXHmAxAGbu/Qxya1atKan7m5edIYRyXJal7b1quhAbbgKT175zAE5iH7kC
         QGXj8ulUdoV06sIM3wrtdM8d05uaqLgvVA4nOiEQ0v/r0rTJd1CkNVwWxqvjZCDUnSYD
         q61e+En69OVdrkUGVsoxiT3UdsC6FotReRA6dkO3C5AlUNCRCa+1kIU7BZJxH9R6E5K+
         PLDnsEtFVKdKweiVhhc/IB3g5/RVyMfoZ8SUHYJ3vAsa43cM2QUX32vZTy1AnT/wkmFZ
         AM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2uvoAv8r7xSnCh6eMu60yhWRWmcE78KKGIGJIpmlJQA=;
        b=IUQMp9YmKKoHw4uwCHfgDFrqhHUrIj1H0N0sWZleL+sQuOVPdD1WEcpFF8iTzz5DW9
         OhkKYsj9LCu2xVzLEpSbwoebzMcIQtiN8c4J12y+eGQH1708Rk2/6C5WlzUVw5wEleTa
         VmDZH72gJsLvJcRXVnhXLfe2iROnab9JI/56Utf46yycDEOlMH/p4/Ss3RiPplS9s6y8
         Zt7eh5ZoroyeBSgY0BUDsMId/9p/VMmW9zMl59inZ3+baq4hUq8tfRp5l9jcCh1S4+tD
         oUIaWNeM8MnTjDLEygE67Bh170uGqpP/xOLLNydH21G0qhIXud8aimDXdUu5kkSRKy+1
         n/DQ==
X-Gm-Message-State: AOAM53233F8I8gcenq2KUOWdTKUHwS+DQklV9sTbJsha3XF/yg5TohgJ
        zcDR1ro7w68BF19WJKRoLelQHS7+VAA=
X-Google-Smtp-Source: ABdhPJy7jdpw7e471nHarHKaKqJSswqK3Kb1xvI0oFIaOa/ykHjryCUgTUKGgEqLZbw6/Sf6tu77vA==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr8394754wmi.67.1645638920636;
        Wed, 23 Feb 2022 09:55:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm174450wrr.94.2022.02.23.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:20 -0800 (PST)
Message-Id: <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:08 +0000
Subject: [PATCH 08/11] bundle: parse filter capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The v3 bundle format has capabilities, allowing newer versions of Git to
create bundles with newer features. Older versions that do not
understand these new capabilities will fail with a helpful warning.

Create a new capability allowing Git to understand that the contained
pack-file is filtered according to some object filter. Typically, this
filter will be "blob:none" for a blobless partial clone.

This change teaches Git to parse this capability, place its value in the
bundle header, and demonstrate this understanding by adding a message to
'git bundle verify'.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c                      | 17 ++++++++++++++++-
 bundle.h                      |  3 +++
 list-objects-filter-options.c |  2 +-
 list-objects-filter-options.h |  5 +++++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index dc56db9a50a..2afced4d991 100644
--- a/bundle.c
+++ b/bundle.c
@@ -11,7 +11,7 @@
 #include "run-command.h"
 #include "refs.h"
 #include "strvec.h"
-
+#include "list-objects-filter-options.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -33,6 +33,8 @@ void bundle_header_release(struct bundle_header *header)
 {
 	string_list_clear(&header->prerequisites, 1);
 	string_list_clear(&header->references, 1);
+	list_objects_filter_release(header->filter);
+	free(header->filter);
 }
 
 static int parse_capability(struct bundle_header *header, const char *capability)
@@ -45,6 +47,11 @@ static int parse_capability(struct bundle_header *header, const char *capability
 		header->hash_algo = &hash_algos[algo];
 		return 0;
 	}
+	if (skip_prefix(capability, "filter=", &arg)) {
+		CALLOC_ARRAY(header->filter, 1);
+		parse_list_objects_filter(header->filter, arg);
+		return 0;
+	}
 	return error(_("unknown capability '%s'"), capability);
 }
 
@@ -220,6 +227,8 @@ int verify_bundle(struct repository *r,
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
+	revs.filter = header->filter;
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
@@ -259,6 +268,12 @@ int verify_bundle(struct repository *r,
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
+
+		if (header->filter) {
+			printf_ln("The bundle uses this filter: %s",
+				  list_objects_filter_spec(header->filter));
+		}
+
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
diff --git a/bundle.h b/bundle.h
index 06009fe6b1f..eb026153d56 100644
--- a/bundle.h
+++ b/bundle.h
@@ -5,11 +5,14 @@
 #include "cache.h"
 #include "string-list.h"
 
+struct list_objects_filter_options;
+
 struct bundle_header {
 	unsigned version;
 	struct string_list prerequisites;
 	struct string_list references;
 	const struct git_hash_algo *hash_algo;
+	struct list_objects_filter_options *filter;
 };
 
 #define BUNDLE_HEADER_INIT \
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fd8d59f653a..b9d10770e4f 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -55,7 +55,7 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
  * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
  * convenience of the current command.
  */
-static int gently_parse_list_objects_filter(
+int gently_parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf)
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index da5b6737e27..347a99c28cf 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -72,6 +72,11 @@ struct list_objects_filter_options {
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
 
+int gently_parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	struct strbuf *errbuf);
+
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options);
 
-- 
gitgitgadget


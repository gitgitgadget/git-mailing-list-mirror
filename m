Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF1C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbiDRR21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbiDRR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6982340ED
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u3so19316847wrg.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DadF40bZKPjOOj+NnygGPAOiCeH7k1Z+qeGEx7Ixnpc=;
        b=qGekEjmQD9fEXdKO/KvIjl4SMoqhW3tNr0BPD/HVxePfuuXONpvtD82DBTOhaIMPmG
         K+5+7n2OqumCm8WLtNV7tKFhdhXCTiawJYlYaNA8k+y847M2PZVg9kedl00P6/nL5TdX
         N0x83/W7yADWLYZ9KEoZWNyltZifoAk5belyW0uFXaII2jp9lJkwnnLrny7ZVdOlv1gL
         ZC3Qp8v5cY3IA6e63mVRL3yQHe7hpA1jd8xAU44qH8Cfx2Gb8nl1GfWLeBU1bUlO5zyB
         OWdmwU/6VlbSZ0gMOEe/NxGgQJ3kzEmCw3mlk6r/l8YKFzGcso0hpmZkJpo6xubH1FPj
         JY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DadF40bZKPjOOj+NnygGPAOiCeH7k1Z+qeGEx7Ixnpc=;
        b=QB9CxxF3spvweVTTKijpKyYsmZWQF0BhAxFtlZh3uEH5N0Gv47qfb26ctcPrS66uIs
         JIRXQ/3j34L23/q464RXb19ietM+W7eUJFD60c+YmxNewzhorSGO6XE0j0k4e7quvrA7
         q3XGrWvcDZTnyUuiFLbepaJ4Wot9mdGPTOD5VWBLHmNqclZTPyM03B5c0OrB1e83rSPc
         DHYvQKHtBW+aIcIllghPpGBH3fhjHjPveimeDyOlZ75jOYnjaLsd4nbuYXdRPHvupeK4
         m9A+1oMHxH+5azj7yQKOAQSrGfMs3BJDEg/up1eua3Tky8Do4FmCT19UzAmwNJBuDpuf
         vUjA==
X-Gm-Message-State: AOAM532IMySX6irjRNO0yq5pqP54YCAyY8FuT/Q9toipSL0fQEsUkGUE
        09U9XMMOqkRzxVgE7YYfijyPO8PF4MawXQ==
X-Google-Smtp-Source: ABdhPJw96AS4ikki6PAg2Ksk07uIgUkQVRUG/80pedcyzqqGkNioMd0EQuYP+B48S6J7RitQ8PVM4A==
X-Received: by 2002:a05:6000:1002:b0:207:a28a:c86a with SMTP id a2-20020a056000100200b00207a28ac86amr8862939wrx.361.1650302662068;
        Mon, 18 Apr 2022 10:24:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:21 -0700 (PDT)
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
Subject: [RFC PATCH v2 21/36] bundle: allow relative URLs in table of contents
Date:   Mon, 18 Apr 2022 19:23:38 +0200
Message-Id: <RFC-patch-v2-21.36-c08406cd9c2-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 711e0863a16..c55d5215181 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "remote.h"
 
 /*
  * Basic handler for bundle files to connect repositories via sneakernet.
@@ -457,6 +458,8 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
 
 		/* initialize stack using timestamp heuristic. */
 		hashmap_for_each_entry(&toc, &iter, info, ent) {
+			char *old_uri;
+
 			/* Skip if filter does not match. */
 			if (!filter && info->filter_str)
 				continue;
@@ -464,6 +467,10 @@ static int cmd_bundle_fetch(int argc, const char **argv, const char *prefix)
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
2.36.0.rc2.902.g60576bbc845


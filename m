Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D61FC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbiDRR27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347095AbiDRR1O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7160C344D4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so8635410wml.2
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMtgEb3nmyRuBZmxFOIxnfS1libNL0XVpODObhDsB9A=;
        b=hP/kDNRpKBq9eG6DnMyodXx95zoXBI78Fjq1v0eAa/kI9kDKV93GOkAd6lTgNpUrqF
         IJbsqxkhwilVA01OPd5iyzgmYN3FuP2iXmf95HD1ee/xYphWGgxtFy3O5xS5kd21BjNj
         SrmCEzIq5jvs9Wm/caGxlF5Y8vacvyz4qJ6UOWTiH8aXjrJjN55XuSuLTOm+lUL9KNzz
         nyw8CUgXDQZSY2bSKDQBV3PCN+dxfS8/cDwr8zzRi4yhbHsMiBffGxRcoE6Izcrap/0j
         o279qshLDxy/W4oi8XJ3XyR0/qGLWyfGfQa6E4v5G0ob4eW9M5+iEwTypmxfNDwDB3s3
         pMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMtgEb3nmyRuBZmxFOIxnfS1libNL0XVpODObhDsB9A=;
        b=3skGB7IodbLQ1NNKCD9iBSufxC2z8tZAPUNa9Q3uocdUYIxLpcdzTD06KiVSgd59jb
         vT+gFWgCUky3P3ZqogI00/XWPprAB9+3eaOz5HxPZsEeFQBRWF3kr9zeIXwwcp+DWSzu
         5QqdYrCOoKl+aKtcimlrIG89yF1VTzeJZktLTXjhnxr23sGxGU0VQJc5SRqX6i3i+CJy
         YQY9i3ug4aqE2kkNbE85ag1ZlbEOBVNr5kyk8BKKbs5f46u7TV/12ZQ7KEKDBJIKAML5
         HwxW9WFVq6sby6FIC4EX4ZbKh6OO6p5al4q1HVGNcDXGIsrJt0J8Boar7Hh3TDGCQgP7
         U+GQ==
X-Gm-Message-State: AOAM530IISxa4GrnzQpLjj/k6vjge56e4eY2nSAHvJbugbyW/lgFedpx
        5d4WHZl/g4KIn2a6qncPADGHWRG50NKT/Q==
X-Google-Smtp-Source: ABdhPJxrWnJhwCr4nErX4mE5CxBJ1CkwPWir3foUIJnAj7vJjHPt5SuZCdK7sGytBprqEjuELSarWA==
X-Received: by 2002:a05:600c:4fd3:b0:392:94ee:d2a4 with SMTP id o19-20020a05600c4fd300b0039294eed2a4mr6801610wmq.167.1650302672795;
        Mon, 18 Apr 2022 10:24:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:32 -0700 (PDT)
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
Subject: [RFC PATCH v2 32/36] clone: use server-recommended bundle URI
Date:   Mon, 18 Apr 2022 19:23:49 +0200
Message-Id: <RFC-patch-v2-32.36-2b424bedfc5-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

After the ref advertisement initializes the connection between the
client and the remote, use the 'features' capability (if available) to
get a list of recommended features from the server.

In this change, we only update the bundle URI setting. The bundles are
downloaded immediately afterwards if the bundle URI becomes non-null.

RFC-TODO: don't overwrite a given --bundle-uri option.
RFC-TODO: implement the other capabilities.
RFC-TODO: guard this entire request behind opt-in config.
RFC-TODO: prevent using an HTTP(S) URI when in an SSH clone.
RFC-TODO: prevent using a local path for the bundle URI.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index af64bd273b7..81c14a9f5d7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -890,6 +890,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 	int filter_submodules = 0;
+	struct string_list *feature_list = NULL;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1241,11 +1242,23 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
-	/*
-	 * NOTE: The bundle URI download takes place after transport_get_remote_refs()
-	 * because a later change will introduce a check for recommended features,
-	 * which might include a recommended bundle URI.
-	 */
+	feature_list = transport_remote_features(transport);
+
+	if (feature_list) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, feature_list) {
+			char *value;
+			char *equals = strchr(item->string, '=');
+
+			if (!equals)
+				continue;
+			*equals = '\0';
+			value = equals + 1;
+
+			if (!strcmp(item->string, "bundleuri"))
+				bundle_uri = value;
+		}
+	}
 
 	/*
 	 * Before fetching from the remote, download and install bundle
@@ -1265,7 +1278,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (filter)
 			git_config_set("fetch.bundlefilter", filter);
 
-		if (!fetch_bundle_uri(bundle_uri, filter))
+		if (fetch_bundle_uri(bundle_uri, filter))
 			warning(_("failed to fetch objects from bundle URI '%s'"),
 				bundle_uri);
 	}
-- 
2.36.0.rc2.902.g60576bbc845


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB101FA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiJZPgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiJZPgl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:36:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214B120EDF
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso1823285wma.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBxMwIrrD3RIY1ple08MOu9ais1lOY9tvPLWM8rylAQ=;
        b=iyOuT00psqdp3bm4dpvuh39X0PyXM0m794nZzCze07pjat/d0VeRVwDQMzwHk/C9+t
         Xzk27qOH65rx5KeFIEGDEKusfV4LLakMI80Ve6TEPqhQ6zKXheBAjPC+EWRUJzjZoDRD
         UFgUjsFD3LtNdAUPdRRpy0ayaGrWXf5APLV+i/90MKqX2J/4D8Ysu7ZjQTt/vmc4TAtA
         QBq2B/c/T/wK5atEhHxOFDJeHM09dSzv08tha8qlaROHvCbQnhz2mCCjXZ7jE6X9QhCy
         G/iQT/lIWCUFXHkIAEWOGHKeM5wumdiUMumq0sHOanPov1oZDbz1tpMrp8yN1FsNENg4
         jcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBxMwIrrD3RIY1ple08MOu9ais1lOY9tvPLWM8rylAQ=;
        b=NorEccdpT00Jlv2+jCPDy5FsyuFAlk2SAO1hP6oheBv6pAMbYmKH4hzqQPtlvRkH/K
         8Q4rE5e+njK8Mlbe8xDXnEBag3lVqI0LoCX3rS8OkRV4e9/qjsb9/Ak9a3M3B7faSd+C
         GX0rtO0CocGhG2aYM8DLCSAt4LaWLyq0e/QvOXvUD0u/G2nrE14/XS7udj8NydNA2Wys
         wuhsLg3zgqI8H/RWNpL36WF+qQlwB4rv1xN5pkJtjrmlertEzPnJ4tLE5C/KzarnjtUy
         qUurQ4Xb19OAPQWEvPKQYDTwxZSJIiVNWixdw7SsArDy+QnB+42z6cXpbHJ64/2BYisG
         cCVw==
X-Gm-Message-State: ACrzQf35Jyk/Wu6OUn4jSjkoT0kravRQ2OqPNqrefksS63rW1M/4VYs9
        sq3i+sRPRay9/zR0oonng1mez0UdTfPaAQ==
X-Google-Smtp-Source: AMsMyM53YsZy9SHat40G3fbdYsGNEBtzh8iNzTQdoFb6Kj1LDgHtYLRiJQFnpWzBA1+Rzy8AqmrJYA==
X-Received: by 2002:a05:600c:1d0f:b0:3c6:bfa9:9ef6 with SMTP id l15-20020a05600c1d0f00b003c6bfa99ef6mr2966060wms.136.1666798598445;
        Wed, 26 Oct 2022 08:36:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] config API: mark *_multi() with RESULT_MUST_BE_USED
Date:   Wed, 26 Oct 2022 17:35:16 +0200
Message-Id: <patch-03.10-3519d3de010-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the RESULT_MUST_BE_USED attribute to assert that all users of
the *_multi() API use the return values, in the preceding commit
"for-each-repo" started using the return value meaningfully.

This requires changing versioncmp() so that we use the "ret" versions
of the return values, and don't implicitly rely on
"deprecated_prereleases" being set to NULL if the key didn't exist.

See 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
return values, 2022-09-01) for the introduction of
RESULT_MUST_BE_USED.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.h     |  6 ++++++
 versioncmp.c | 22 +++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/config.h b/config.h
index c88619b7dcf..a5710c5856e 100644
--- a/config.h
+++ b/config.h
@@ -470,6 +470,7 @@ int git_configset_add_parameters(struct config_set *cs);
  * The caller should not free or modify the returned pointer, as it is
  * owned by the cache.
  */
+RESULT_MUST_BE_USED
 int git_configset_get_value_multi(struct config_set *cs, const char *key,
 				  const struct string_list **dest);
 
@@ -478,6 +479,7 @@ int git_configset_get_value_multi(struct config_set *cs, const char *key,
  * value is < 0. Use it for keys known to pass git_config_parse_key(),
  * i.e. those hardcoded in the code, and never user-provided keys.
  */
+RESULT_MUST_BE_USED
 int git_configset_get_knownkey_value_multi(struct config_set *cs,
 					   const char *const key,
 					   const struct string_list **dest);
@@ -514,9 +516,11 @@ struct repository;
 void repo_config(struct repository *repo, config_fn_t fn, void *data);
 int repo_config_get_value(struct repository *repo,
 			  const char *key, const char **value);
+RESULT_MUST_BE_USED
 int repo_config_get_value_multi(struct repository *repo,
 				const char *key,
 				const struct string_list **dest);
+RESULT_MUST_BE_USED
 int repo_config_get_knownkey_value_multi(struct repository *repo,
 					 const char *const key,
 					 const struct string_list **dest);
@@ -571,6 +575,7 @@ int git_config_get_value(const char *key, const char **value);
  * The caller should not free or modify the returned pointer, as it is
  * owned by the cache.
  */
+RESULT_MUST_BE_USED
 int git_config_get_value_multi(const char *key,
 			       const struct string_list **dest);
 
@@ -579,6 +584,7 @@ int git_config_get_value_multi(const char *key,
  * git_configset_get_knownkey_value_multi() does for
  * git_configset_get_value_multi().
  */
+RESULT_MUST_BE_USED
 int git_config_get_knownkey_value_multi(const char *const key,
 					const struct string_list **dest);
 
diff --git a/versioncmp.c b/versioncmp.c
index 9064478dc4a..effe1a6a6be 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -160,19 +160,23 @@ int versioncmp(const char *s1, const char *s2)
 	}
 
 	if (!initialized) {
-		const struct string_list *deprecated_prereleases = NULL;
+		const struct string_list *deprecated_prereleases;
+		int prereleases_ret, deprecated_prereleases_ret;
 
 		initialized = 1;
-		git_config_get_knownkey_value_multi("versionsort.suffix",
-						 &prereleases);
-		git_config_get_value_multi("versionsort.prereleasesuffix",
-					   &deprecated_prereleases);
-
-		if (prereleases) {
-			if (deprecated_prereleases)
+		prereleases_ret =
+			git_config_get_knownkey_value_multi("versionsort.suffix",
+							    &prereleases);
+		deprecated_prereleases_ret =
+			git_config_get_knownkey_value_multi("versionsort.prereleasesuffix",
+							    &deprecated_prereleases);
+
+		if (!prereleases_ret) {
+			if (!deprecated_prereleases_ret)
 				warning("ignoring versionsort.prereleasesuffix because versionsort.suffix is set");
-		} else
+		} else if (!deprecated_prereleases_ret) {
 			prereleases = deprecated_prereleases;
+		}
 	}
 	if (prereleases && swap_prereleases(s1, s2, (const char *) p1 - s1 - 1,
 					    &diff))
-- 
2.38.0.1251.g3eefdfb5e7a


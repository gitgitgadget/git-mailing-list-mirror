Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23822C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B567611C8
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345612AbhIPTBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhIPTBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED8C0F26D3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so1693639wmj.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdpeHGQKkg4iF0cjwL3b3FZnx2VmBmJZc9NjbHzJ3+8=;
        b=mRDSgSHIGUn+3bW5k3bvg01C497Ji9TGVzAfGudKzK4mBsyarAmbXwHLWM9kMOA6Nf
         S21nCXbhO8pOUEvk9Af5VegjVE/fl4vMTtqG6R7wEfE+BFXUqsDy358rxTtFRmZzLW5n
         TM1lfbx/XU5+2NAA8fRrCMvOXcv4xqTo34w/UAHX+awKsa8/WoLn8fbeAMKMM0yLZtnj
         7Ku2ZnmJEoXH43+NeavDyv1m9Y0twnhWbCXyEDROq6AqCD0GmxzNFdLttShDqE71lJMD
         khjhA5m82QQaWe1utetrYFwVSZ2QxZg+z8K9Jpo9gwRqTtN8wloO9vFKdC7OLGbG8pEC
         M83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdpeHGQKkg4iF0cjwL3b3FZnx2VmBmJZc9NjbHzJ3+8=;
        b=HqaYsf24YC3Ly6dSSGwZk1JrQ6Z5U3DXIcXfYCQcZOy02YafYt0u1cnwoVbrosqf/Q
         dsJGpIodKhndFFiCCSNIBRmUzqxyo0Efdegl4DSq//o7i+OjDQpxStVq4DONbe0O7idm
         JOnHScD9Yeip5RE6a2Z6nfWhZFBXxqDaOgij5Uz2X6tgG5dTz2nv4IFuofZxb4yLpVUW
         Lb5juzHit4cvwI1pVjh0qjuJE8RtsppczuYAU6key0IsJ287SWlOnqtDAng8JbUvLMkT
         Qn171f9AvJ9zOh8fOS+wnW8Qyrb+cDrxCZwy+vA8rRo9GtwV+ej0Jyy4Aapsw+k8SN1Y
         IzKw==
X-Gm-Message-State: AOAM530yKrJWYAre7/36H0u9wm8tl3kfB7NkA7caGT2zu7RsvKi9tIgP
        rwAUsq13TBnh5w6L1HRBKlMqQxqiITvzpA==
X-Google-Smtp-Source: ABdhPJx8zSKJvL+RfHwbTZ//pwpHqdXxJMXU5Y7l3Z1+FP/KFSxVP39D41XCZ3V/hYNzdUX1r1yJvg==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr6465255wma.170.1631817042978;
        Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j98sm4365700wrj.88.2021.09.16.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] read-cache & fetch-negotiator: check "enum" values in switch()
Date:   Thu, 16 Sep 2021 20:30:34 +0200
Message-Id: <patch-v2-3.5-9f1bb0496ed-20210916T182918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change tweak_untracked_cache() in "read-cache.c" to use a switch() to
have the compiler assert that we checked all possible values in the
"enum untracked_cache_setting" type, and likewise remove the "default"
case in fetch_negotiator_init() in favor of checking for
"FETCH_NEGOTIATION_UNSET" and "FETCH_NEGOTIATION_NONE".

See ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
for when the "unset" and "keep" handling for core.untrackedCache was
consolidated, and aaf633c2ad1 (repo-settings: create
feature.experimental setting, 2019-08-13) for the addition of the
"default" pattern in "fetch-negotiator.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-negotiator.c |  3 ++-
 read-cache.c       | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 57ed5784e14..e7b5878be7c 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -19,7 +19,8 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 
 	case FETCH_NEGOTIATION_DEFAULT:
-	default:
+	case FETCH_NEGOTIATION_UNSET:
+	case FETCH_NEGOTIATION_NONE:
 		default_negotiator_init(negotiator);
 		return;
 	}
diff --git a/read-cache.c b/read-cache.c
index 9048ef9e905..9dd84d69f00 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1944,13 +1944,18 @@ static void tweak_untracked_cache(struct index_state *istate)
 
 	prepare_repo_settings(r);
 
-	if (r->settings.core_untracked_cache  == UNTRACKED_CACHE_REMOVE) {
+	switch (r->settings.core_untracked_cache) {
+	case UNTRACKED_CACHE_REMOVE:
 		remove_untracked_cache(istate);
-		return;
-	}
-
-	if (r->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE)
+		break;
+	case UNTRACKED_CACHE_WRITE:
 		add_untracked_cache(istate);
+		break;
+	case UNTRACKED_CACHE_UNSET:
+	case UNTRACKED_CACHE_KEEP:
+		break;
+	}
+	return;
 }
 
 static void tweak_split_index(struct index_state *istate)
-- 
2.33.0.1092.g44c994ea1be


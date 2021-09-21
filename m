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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28085C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D21611C5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhIUNOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhIUNOm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:14:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC80DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so5797021wrw.13
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAV57uDkKQnLyNDH9m6cm+VqhOjIxoN2SD/Poeh17iQ=;
        b=hZT6efJP+8AnGk/gBlcxlMA5yrywdJ81huB4XVtCRIvKEo2CGeUD4No0VbAL9zWLZj
         XdCcin60nku3AjcIytIf518EPoY+TS/Fc7/qsPZ/u7byQMyQcEmSAcHnwUb2KQtAoTQW
         wXupfcANe3HeKnDmUcPiN17p08IydY8fGgvyzEEIWITOAKW1ZHIS0aobzR54CSv3B2iQ
         mMZ88KmeLSpUvvmS3jjDdSLCUCDw+ktqtVctnD+VPtxNMLU5ps3uyfGq11Hl/9CGx1+k
         mwuVSb86mkUfdhBmhpeo+Yuu6a6vYJHlp0p4DTKNfIx3uz7x+zbxcH3dqZ7JDNyf9Zoi
         lttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAV57uDkKQnLyNDH9m6cm+VqhOjIxoN2SD/Poeh17iQ=;
        b=BIbUZbzNhhlsOyRyNa4woHQHpTG0PswnIpwFRO0Kv2zh4nH5yfw8Uot7pPaebM8PmN
         EN7a3BEqztn4zruscp9u6BSZwiXgR2NXC8QCWWxRbBJN4L3TZN0DCBfE9e/3cnAPu0P1
         YPt+8s7hZOQBJV/BOKcrpOtp8bKZcoJPAVU5n84nUmlkR9OdBfGYY+Pxq7++ShhqddBA
         zvLYqnMh5buJ+v/3qXbpwccbbgbbFtxFogU7cSLCnULv2lpI5cwdL3IqkyiG+eYS3VhM
         1WdQGu/AsUzzfWZUuVkg68LebqPI/gOsEHCfz9YOuYxqIEhlKmaGAbWiFkPITBMXKQZS
         nXXA==
X-Gm-Message-State: AOAM530l7ivoLbJrTvb0KNymZ8sP+Tf5Pid18jiiGxjTwoCbWsNKcJxw
        iKGVLxNvI8UsBbplcg6i9MtKqctHGg/EQA==
X-Google-Smtp-Source: ABdhPJyDs5T8d4l88HHHEmxqZxdwPod0vskLOUyNrVRKUNjCwx/3pVp2Jp4bWfTkprQQaJrx2rBwJQ==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr12377561wro.306.1632229991844;
        Tue, 21 Sep 2021 06:13:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm2733260wml.44.2021.09.21.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:13:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/5] read-cache & fetch-negotiator: check "enum" values in switch()
Date:   Tue, 21 Sep 2021 15:13:01 +0200
Message-Id: <patch-v4-3.5-b36b23ee173-20210921T131003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
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

As will be discussed in a subsequent we'll only ever have either of
these set to FETCH_NEGOTIATION_NONE, FETCH_NEGOTIATION_UNSET and
UNTRACKED_CACHE_UNSET within the prepare_repo_settings() function
itself. In preparation for fixing that code let's add a BUG() here to
mark this as unreachable code.

See ad0fb659993 (repo-settings: parse core.untrackedCache, 2019-08-13)
for when the "unset" and "keep" handling for core.untrackedCache was
consolidated, and aaf633c2ad1 (repo-settings: create
feature.experimental setting, 2019-08-13) for the addition of the
"default" pattern in "fetch-negotiator.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-negotiator.c |  4 +++-
 read-cache.c       | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 57ed5784e14..e61e40cb299 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -19,8 +19,10 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 
 	case FETCH_NEGOTIATION_DEFAULT:
-	default:
 		default_negotiator_init(negotiator);
 		return;
+	case FETCH_NEGOTIATION_NONE:
+	case FETCH_NEGOTIATION_UNSET:
+		BUG("FETCH_NEGOTIATION_{NONE,UNSET} used outside of prepare_repo_settings()!");
 	}
 }
diff --git a/read-cache.c b/read-cache.c
index f5d4385c408..e4ae35ccdb2 100644
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
+	case UNTRACKED_CACHE_KEEP:
+		break;
+	case UNTRACKED_CACHE_UNSET:
+		BUG("UNTRACKED_CACHE_UNSET used outside of prepare_repo_settings()!");
+	}
 }
 
 static void tweak_split_index(struct index_state *istate)
-- 
2.33.0.1098.gf02a64c1a2d


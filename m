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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F4C4332F
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DABE61212
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhISIsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhISIsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:48:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F6DC061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so13293233wmc.0
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mM3Z+oAJuUsvBxBGmGKvCeF23cGlFiPbMicsHB83nM8=;
        b=nT5KgkuTmmh2CzyLaxUCEhgTVCkHQEEZ4XdNCwsgC49FfZlxRPxjdQjbmaj9nCZyA+
         TrlzKJAZCuuLcVpAEg8oUJsVizutAHfGxqLt1FLYyAxVamKXZu6LJMN4k9wrd4RW47ft
         mm4Avht4DnWMsXbfzumymE4fAnonPX/JNoNlXTYxHN7h0d/B+NIheYcl5es+r8ed1+0G
         KtmtNhX+bo+VVd7yZrKpCC7KdNlu9w51noUvyYP/tBeC6Hul5KfbZ7x5UwvLphNBzM+G
         SLEo5+GWob/8FLdLN/wCQEtp2QkmEgKsMW28heEG/OrWNlr8hbKf5o4HL3qRzmOVn5LM
         Mmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mM3Z+oAJuUsvBxBGmGKvCeF23cGlFiPbMicsHB83nM8=;
        b=lh6GD02arQ8U576e/QH8l6X8GTdCfWgtEx0jN3DaLYL8xzpzECwpHbLhFTYB+Btf1N
         SZca5zM7r/L18q3Tu3xktm3E7CvioEzZ14Ry74nYYZHKu7yVweUpBtJ4RZO0qzsoWB/5
         RB96s8jHTfswXEROUniNmZqgsLuwLH10LLwoV0wkc7AW5mdby/nrwAuuGO3ZvTDNvmCZ
         qrfK2v8AyeMjpulO3IRBi2Uj1+//OfstCpGveL9zupp3o62phnqaW8OKLArtpYYoy+d9
         7vCaJ5pNS6OM81V1iJAyPdVnYQB5SJiFyLBTSf1d+jaJR2mkclIUBeitefNAAL+0t4W4
         AUwg==
X-Gm-Message-State: AOAM531ZDgu3tz2r/OBsJ81gkwL0Url/T88koSOo4pVXR2IIyoK8tOsx
        m8f98FJ3mw4dQ4QWoip71EIa1dUBMkXEEQ==
X-Google-Smtp-Source: ABdhPJwzNgCUGu566XMuYfZQJgejbjt6rw1+MnH5pCwgvf3P31J4gTnocOjqC3Db+CVd6RLR0hE5HQ==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr23815813wml.190.1632041244116;
        Sun, 19 Sep 2021 01:47:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i67sm7884497wmi.41.2021.09.19.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:47:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] read-cache & fetch-negotiator: check "enum" values in switch()
Date:   Sun, 19 Sep 2021 10:47:17 +0200
Message-Id: <patch-v3-3.5-d837d905825-20210919T084703Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
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
index 57ed5784e14..237f92b8696 100644
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
+		BUG("FETCH_NEGOTIATION_UNSET only in prepare_repo_settings()");
 	}
 }
diff --git a/read-cache.c b/read-cache.c
index 9048ef9e905..6918dc3d8b2 100644
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
+		BUG("UNTRACKED_CACHE_UNSET only in prepare_repo_settings()");
+	}
 }
 
 static void tweak_split_index(struct index_state *istate)
-- 
2.33.0.1092.g44c994ea1be


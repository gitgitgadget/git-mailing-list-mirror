Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6638DC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354542AbiDBKwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354504AbiDBKv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBE140749
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c10so10606454ejs.13
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzxF1Qg8cpRe+RvN1HFCK5YoHNkK1QJ46Kn1S7KPcfM=;
        b=HCl/ox/FKxr0rEtdlr1QYIydasNcspfrwkEn290vUf7K6Ly+DFthYPTQKwPxjjCQNh
         IhiszKJOu/UKU927kH3k36vytfH7AhU5MymR7eTurnItOybloJvuaUrJrbXPhG2IdKtT
         46lfvOF11lEATNJxbEPF08caW+f3FU2Uz/HpdG46JERt1BUleLl5gEsXZ1WxAsdBApyM
         eaGttCdj6dKdc3Lz4K+IgSfbpPPlPqGo9p5r5+7FSJfpahXUYkHwK4KFBurqRzVFJhED
         oEM3lCf3i0EYqaObM7Iweou7smNDEOQ25w6xIWByb5eoAxhlXmZDwuNQF5+uYke36QLH
         d5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzxF1Qg8cpRe+RvN1HFCK5YoHNkK1QJ46Kn1S7KPcfM=;
        b=1c0opT8Bz79x2BVX7SXLNf1OJctAiPcrjd8W4TK0xYSo7PP5UQrT7VeDs3LODESd+T
         l3fI46zjlinx9hiFcQwyxAs1+aIZe+02ptSZgnMqc0H/46cExbZsbPh+JiIUzceaAYtJ
         L+zdfmSslLx12XaWL21XfaMUUVAuhoaeNdDX/tRRYtjrR9la/TtdqwCDRc+mtzy8uMZ7
         xswt88yqm2Qbn4NBIQ/C38b0sYcgMX8784fRN23cZLtAJhwBH8wGBi6NxT9442UjU6nO
         1OAB0nmdkjmCs/f3fzPVAa5m8LNhzOw70dmUYqwI7zgNrZgwxCJSNQ0UhcfDfqM02Iux
         Zw/Q==
X-Gm-Message-State: AOAM5320xTgSyQDQ72DcMGVanrHrYvl7PZQbcqiqjCsTBXpjIouIB+L/
        PEDFPj9jrmoiLSLETB112gEC1bLp8bznQA==
X-Google-Smtp-Source: ABdhPJwWPexJD2gFl/nrPnpsw2w9kVTPFR0CRVfat5SI2aUGliDAr8RcJx62VH4MBlyaLhaL5CGZrQ==
X-Received: by 2002:a17:906:2991:b0:6cd:ac19:ce34 with SMTP id x17-20020a170906299100b006cdac19ce34mr3415892eje.746.1648896596546;
        Sat, 02 Apr 2022 03:49:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/27] revisions API users: use release_revisions() in http-push.c
Date:   Sat,  2 Apr 2022 12:49:26 +0200
Message-Id: <patch-v5-12.27-1918ca0a85d-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of cmd_main() in http-push.c we need to move the
deceleration of the "struct rev-list" into the loop over the
"remote_refs" when adding a release_revisions().

We'd previously set up the "revs" for each remote, but would
potentially leak memory on each one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index f0c044dcf76..01e7c2ac5c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1689,7 +1689,6 @@ int cmd_main(int argc, const char **argv)
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
-	struct rev_info revs;
 	int delete_branch = 0;
 	int force_delete = 0;
 	int objects_to_send;
@@ -1825,6 +1824,7 @@ int cmd_main(int argc, const char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
+		struct rev_info revs;
 		struct strvec commit_argv = STRVEC_INIT;
 
 		if (!ref->peer_ref)
@@ -1941,6 +1941,7 @@ int cmd_main(int argc, const char **argv)
 		unlock_remote(ref_lock);
 		check_locks();
 		strvec_clear(&commit_argv);
+		release_revisions(&revs);
 	}
 
 	/* Update remote server info if appropriate */
-- 
2.35.1.1585.gd85f8dcb745


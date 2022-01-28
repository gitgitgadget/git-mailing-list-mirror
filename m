Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29376C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 12:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiA1M47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 07:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbiA1M4x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 07:56:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE7C06173B
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ka4so15661213ejc.11
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuRnl1B0GVM0rjWwdd5Dfk2Uz9XQ0l12YM/NwcRHcP4=;
        b=Ak+S/nz8X3Fy7BDh71CItUxyXVgGtwFpBxziK6M+/2O/GVFAiQGJKrTXMInWUdcDYa
         Nadargevl6Fc/V+Ks5Ux+wCYMaWTim22jNAsElkvif6HA75kSWVwSuAZ468kZcmV9odR
         6SCzPLunvbJnB0D3HwHmpbDVxc10OEU09daIMD0caxRuF9YrgEW3o0+DhzXY9LUSomj3
         jsqwQpCavNsR5VXWo94EQNJosFP0GJNhnbn+dNwhAqGVrA8cBCh3GcDskbLlpsfRgo5b
         uNRqAFvaGGG1FYYKitO3xhlYfDUVHe1KxgO2i30KKPsxvOiQaDerXfSwhHsIXFLbCgC9
         PtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuRnl1B0GVM0rjWwdd5Dfk2Uz9XQ0l12YM/NwcRHcP4=;
        b=GJYGvC1d2AYRd3gMfInMg6ttwWfPeb3e5ScOFxHhWVNYA74w8RP7AYxpsX2GOd462Y
         cCD7iclBrpcsth50hJapFT3bAG44xJYsVq2kC9jHxTcCjrac/up6jvbZ6Q9wc/ovZgal
         tHYut/iNMQIBJlveZ1Y5EDGxgz3/LOCWBacWhL3NiVUXVJtetW/8wfudgUC9S9nEKbeQ
         LgPrqFzKaxf3v2sN9c4eol6SNFXxnds/4TBR9THCMV5j9PSOX8R+xOoV7ATqrb1RlwWT
         VijTDm7lpqlisYLj1s6O6cUhsSBmEAkIWkeOUa8jKJAahuGXjWMt3DN7BJ4zjgtNKxsj
         /IWA==
X-Gm-Message-State: AOAM532qgmVOJE8GEINleIjFMjsMJc70ZCr0KdGFFwTSL4LbGb4Ug3hX
        DFxDWFS2skuEoUA7ENgTNg6hnYHRcFti0A==
X-Google-Smtp-Source: ABdhPJw5YDsr9ts95sVeh/ThPWg1gFhUPrF5DB7SRg1IGPEbqsXpeEsGUBaz53cQL+mlbtpMQSdglA==
X-Received: by 2002:a17:906:3b9a:: with SMTP id u26mr6988866ejf.125.1643374611311;
        Fri, 28 Jan 2022 04:56:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g8sm10154691ejt.26.2022.01.28.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 04:56:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 5/9] builtin/submodule--helper.c: reformat designated initializers
Date:   Fri, 28 Jan 2022 13:56:36 +0100
Message-Id: <patch-v5-5.9-fa815e37f9f-20220128T125206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.914.ge5c8aab0d5b
In-Reply-To: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

The second hunk here will make a subsequent commit's diff smaller, and
let's do the first and third hunks while we're at it so that we
consistently format all of these.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db71e6f4ec8..9f79bdf4d51 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1654,7 +1654,10 @@ struct module_clone_data {
 	unsigned int require_init: 1;
 	int single_branch;
 };
-#define MODULE_CLONE_DATA_INIT { .reference = STRING_LIST_INIT_NODUP, .single_branch = -1 }
+#define MODULE_CLONE_DATA_INIT { \
+	.reference = STRING_LIST_INIT_NODUP, \
+	.single_branch = -1, \
+}
 
 struct submodule_alternate_setup {
 	const char *submodule_name;
@@ -2047,7 +2050,9 @@ struct update_data {
 	unsigned int nofetch: 1;
 	unsigned int just_cloned: 1;
 };
-#define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
+#define UPDATE_DATA_INIT { \
+	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
+}
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
@@ -3013,7 +3018,9 @@ struct add_data {
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
 };
-#define ADD_DATA_INIT { .depth = -1 }
+#define ADD_DATA_INIT { \
+	.depth = -1, \
+}
 
 static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 {
-- 
2.35.0.914.ge5c8aab0d5b


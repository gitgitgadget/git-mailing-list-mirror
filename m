Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D4C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 05:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCQFB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 01:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCQFBU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 01:01:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B04B06F4
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j2so3343689wrh.9
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679029278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ickpqw+K6y4SumjjnKJNV2kz2xj6SGxndDC7UGmBHA=;
        b=OKUmwZUymeNuoioXpqX0rASWtNTJ9rjGvwAjk2hwZ9Vbn6klb1hY1e1SlMtkNT7DF5
         O8Ak/1ZuQtw/eMCgRV0EXvNyTBGu62RmtAIATzWpPXe6L4ALloL4f+zL9Bga6EI0K5Wp
         PyoztvdT1nws/a47Vo3nyoRUSDYlGYTzaXOZHhu5ZRE2SfVufk0AESsspk18m8PDlWiC
         A6G0KU+BmMdCbBLECuQr3OMDDlw1LnMM/u7fjvLKb4SWGa/1cIpp3sR1YXZbDWMuESEj
         0K/dsRLGezSzk2+wJV1rgJdzRFRtLRJdyHFR/dwWa57CcWhuj1rcrOR70/FBd+AtcZsD
         Jw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679029278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ickpqw+K6y4SumjjnKJNV2kz2xj6SGxndDC7UGmBHA=;
        b=GkggaRWf3fps+ylGnY1sBaD3Z8y3AArNBrCKSdE16z+0xBA1dVKhNo+LABXDWrtqHO
         Hf0hblT12zeLuAjfuLb3k4RSHWeCLUVjbP5alIvSgFF6Rn+xggTSkyfFlFonC9pfpSxs
         +6aYvG+QrmK28D7DYbibUUpgIlZBKZuHzE0vPISDF9guPaC2dBrUH4mtKYx0pWjw1j+N
         qGLFF+q3WHjePExaBe7bQFuqYji4jWjzU6HYu+cRqJN18uFfjZV5n9Q7lsDJ31otPf/u
         vlHxKPkQWJeXG9vdsCqXzLFm2h7xqqbKN5GO8s8lHkSbCHjcKTOAUVVmF+4seX5xtbV5
         06VQ==
X-Gm-Message-State: AO0yUKV7VVoRDLrUd0w29BmrM8pTjdQ9iIjh5fMMDr23oZi4cvVUC2XZ
        r6JfZH7nVApuVIFgFxM3/H18CGBqEeSAYQ==
X-Google-Smtp-Source: AK7set/hj9KQPpYNhZkscBemkPKrCo5VbmGHomCDBorvCO4H9L6hPhBHzY2GbE1nkhJK8hZjh/3swA==
X-Received: by 2002:a5d:6044:0:b0:2cf:e956:9740 with SMTP id j4-20020a5d6044000000b002cfe9569740mr1186134wrt.6.1679029277636;
        Thu, 16 Mar 2023 22:01:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm1027844wrq.10.2023.03.16.22.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:01:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 3/5] config API: add a config_origin_type_name() helper
Date:   Fri, 17 Mar 2023 06:01:08 +0100
Message-Id: <RFC-patch-3.5-e0055e2865e-20230317T042408Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a config_origin_type_name() helper function. In a subsequent
commit we'll want to invoke this part of current_config_origin_type()
without requiring the global "current_config_kvi" or "cf" state.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 25 +++++++++++++++----------
 config.h |  6 ++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index a4105c456c3..a65e7bb36d3 100644
--- a/config.c
+++ b/config.c
@@ -3766,17 +3766,8 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-const char *current_config_origin_type(void)
+const char *config_origin_type_name(enum config_origin_type type)
 {
-	enum config_origin_type type;
-
-	if (current_config_kvi)
-		type = current_config_kvi->origin_type;
-	else if(cf)
-		type = cf->origin_type;
-	else
-		BUG("current_config_origin_type called outside config callback");
-
 	switch (type) {
 	case CONFIG_ORIGIN_BLOB:
 		return "blob";
@@ -3793,6 +3784,20 @@ const char *current_config_origin_type(void)
 	}
 }
 
+const char *current_config_origin_type(void)
+{
+	enum config_origin_type type;
+
+	if (current_config_kvi)
+		type = current_config_kvi->origin_type;
+	else if(cf)
+		type = cf->origin_type;
+	else
+		BUG("current_config_origin_type called outside config callback");
+
+	return config_origin_type_name(type);
+}
+
 const char *config_scope_name(enum config_scope scope)
 {
 	switch (scope) {
diff --git a/config.h b/config.h
index 571b92d674a..a9cb01e9405 100644
--- a/config.h
+++ b/config.h
@@ -117,6 +117,12 @@ struct key_value_info {
 	enum config_scope scope;
 };
 
+/**
+ * Given the "enum config_origin_type origin_type"
+ * (e.g. CONFIG_ORIGIN_BLOB) return a string (e.g. "blob").
+ */
+const char *config_origin_type_name(enum config_origin_type type);
+
 /**
  * A config callback function takes three parameters:
  *
-- 
2.40.0.rc1.1034.g5867a1b10c5


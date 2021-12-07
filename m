Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553AC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhLGSaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbhLGSaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB81C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q3so31324490wru.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/O8bHhUxDMa41Tqf6exYAnCWkIawO+t9x0+zEUa20R0=;
        b=bFLnhcj5mT6jWYq+4J0DkCmDDqzn2Z5r2zNa3K+e+4HMAwWjIRQ/wOQk4++7BV4f2N
         zngc8q364A/dqGic4QxRRaGvXzGKmJT3vVJwK+uK87EJUr9SNwxlmyqx9eLCMr9oqPU5
         3tR1qUmzxVTFkAP1FtL/Ywa8L+grMgOe8LUBY0vfKB0T3pFqR87kMoSpqdkqbvV4o4hs
         1jOoSMdFzo/dmni35aQdSUV6y9W0DTa2f6nM8TztDmbroRVRR/C/XEQdyYf7fmEI3Gnk
         4wVctePXXBjO2ESvV36pc+nqXwEIVOZF31Oo6mnHhZWbWeMjbidVWIv2mSRnCz8aqxBi
         PLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/O8bHhUxDMa41Tqf6exYAnCWkIawO+t9x0+zEUa20R0=;
        b=03TKnOuGAzwLLXVMqckRjnVxO4WXtBrRMFJ0fjMhEebBHcrZT1v4XZmIebcCTOCX2m
         uSkOsE+9riq/mCx66qrMbXu1dTMjlyV/pGFiegxY5FTMyGGvj77V63qERM1JXvZTM5rB
         tmh6ZOtbWOT6JsTHFY5WR4reuf8ybMSLL3Fbbag0HPxzbk0dEPvljz9a3Ld0MZPH/hYi
         8Ns+Ce2DKKsUrZSVGp6VOUHRhvSJeTxAKOid2kxRQzEj9uVoRDMDAeX2UyhTfQjqb9z2
         yrfE7FvN+eNe+UpSWaLdZ1tdG53Of1mH1K7JgZm31smiumMffkzqux0FGIxLqulDr1XR
         trwA==
X-Gm-Message-State: AOAM530CS2mY2Z5bS8GQoHdFJLjoqhK//kKZCw9wkYt3s/nCLoQ3FGnd
        zZmu1zWz19LDaawcTGi9zVvkvww2kSnhCQ==
X-Google-Smtp-Source: ABdhPJzAbKviawQQndqtzB5s4Kjg3qWKGvzsSbH+vOPymXVPjtjzCvu4vxkRhYATIU3LZbQT6OGGwA==
X-Received: by 2002:adf:a48e:: with SMTP id g14mr53078226wrb.474.1638901602977;
        Tue, 07 Dec 2021 10:26:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:26:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] config API: use get_error_routine(), not vreportf()
Date:   Tue,  7 Dec 2021 19:26:34 +0100
Message-Id: <patch-v2-6.6-42132406731-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the git_die_config() function added in 5a80e97c827 (config: add
`git_die_config()` to the config-set API, 2014-08-07) to use the
public callbacks in the usage.[ch] API instead of the the underlying
vreportf() function.

In preceding commits the rest of the vreportf() users outside of
usage.c was migrated to die_message(), so we can now make it "static".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c          | 3 ++-
 git-compat-util.h | 1 -
 usage.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index c5873f3a706..e96b8fdb62d 100644
--- a/config.c
+++ b/config.c
@@ -2555,11 +2555,12 @@ void git_die_config(const char *key, const char *err, ...)
 {
 	const struct string_list *values;
 	struct key_value_info *kv_info;
+	report_fn error_fn = get_error_routine();
 
 	if (err) {
 		va_list params;
 		va_start(params, err);
-		vreportf("error: ", err, params);
+		error_fn(err, params);
 		va_end(params);
 	}
 	values = git_config_get_value_multi(key);
diff --git a/git-compat-util.h b/git-compat-util.h
index c6c6f7d6b51..bdb3977b9ec 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -474,7 +474,6 @@ static inline int git_has_dir_sep(const char *path)
 struct strbuf;
 
 /* General helper functions */
-void vreportf(const char *prefix, const char *err, va_list params);
 NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
 NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/usage.c b/usage.c
index 3d09e8eea48..9943dd8742e 100644
--- a/usage.c
+++ b/usage.c
@@ -6,7 +6,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-void vreportf(const char *prefix, const char *err, va_list params)
+static void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
 	char *p, *pend = msg + sizeof(msg);
-- 
2.34.1.898.g5a552c2e5f0


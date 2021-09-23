Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C96DC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554AC6103D
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhIWKc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbhIWKcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1DC061766
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so15659987wrv.10
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlSVT1qHT1kHzD+vGRjkeQg1ql1/kBBjlh4kCrGOKps=;
        b=KH29NOkIG3GyFGkWIpblm5ks3qQuH1LaVKCuMM/BACcl39PpQPYYVAkgP/JCiOF0gy
         SICE/ieGSduiGI4zNjBAY6qgazOb7p5fmshCvBt1+Jl9bJ/DRaTSpqqfYqkknKZ50182
         rrTnFN7khJ0cbRRKHSCFaqUOuVat4yV1ubBuNOVFc46j6ugvBzAZuTjOsza+oGUMgBM6
         7BXM/YGzgBlKko8yIMutsZwLofvMEGr1VybI755VhGvqFm9KQnl9ML+xzQmMZxEpPler
         vyzH9INAHEAv5YMFqyoES8INfw0fhFsRGTCTRTyqP8StXZ5Ndm4dwDkbhKj7OpqMrHpb
         KR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlSVT1qHT1kHzD+vGRjkeQg1ql1/kBBjlh4kCrGOKps=;
        b=R/pwC3/0qBw+8R6UdIFZ7rS7vWCTD1cUlg7nsDSoimVR1uLs4VPD0vikBIw5f7cJGN
         Os+81bDO7I+CNwRs71mXTX0ZhzU0uRaykkkrz0ueChA2xcb7VmA+hbgmUfoivYDm4rR7
         UF53A298ra8IiHvTNG2jjyMy205mtya/GFhFyjSPV4qSa9PE4eIHY0AvsHfn/uemoOzv
         FpXRPSXS4y/peeI+tITwoWx8o1GTebeLcw0JJ/0sAXJSntegDCKLJGw1xgXoRuK1O/rk
         g7QrDTXFGU6HKhrry8SgKwDyHszNUlWM6D+SukWKgnPrKBOJu7dhiki54z827bXVLKZz
         QlAQ==
X-Gm-Message-State: AOAM533kJ7jDKNhYkp6HraNI6uKwnIJRxRNBRYNr8uZt8Zbyw4RUOR2M
        CyksmeL6EfJw4wWshYiZ2DdKac55IVQTOA==
X-Google-Smtp-Source: ABdhPJzEqsbXLGcRTqYylihtZTzbeU5Ky3KmpZbgT/Gksd4lwIUavEwBF/gjhZ5UVqtGA7Qi8tD8mQ==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr3531138wmj.184.1632393075341;
        Thu, 23 Sep 2021 03:31:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/8] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Thu, 23 Sep 2021 12:30:01 +0200
Message-Id: <patch-6.8-db8893afee6-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Add a boolean version of the find_hook() function for those callers
who are only interested in checking whether the hook exists, not what
the path to it is.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 hook.c              | 5 +++++
 hook.h              | 5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index c30a360d695..a02c2540bb1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -82,7 +82,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (find_hook(hook[i]))
+		if (hook_exists(hook[i]))
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
 
diff --git a/hook.c b/hook.c
index ba70b314718..55e1145a4b7 100644
--- a/hook.c
+++ b/hook.c
@@ -35,3 +35,8 @@ const char *find_hook(const char *name)
 	}
 	return path.buf;
 }
+
+int hook_exists(const char *name)
+{
+	return !!find_hook(name);
+}
diff --git a/hook.h b/hook.h
index 68624f16059..6aa36fc7ff9 100644
--- a/hook.h
+++ b/hook.h
@@ -8,4 +8,9 @@
  */
 const char *find_hook(const char *name);
 
+/**
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 #endif
-- 
2.33.0.1229.g0a86d28df49


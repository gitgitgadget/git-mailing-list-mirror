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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01994C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE68060BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhHCTjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbhHCTj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EFCC061799
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so26426117wrx.9
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLtLR+JR4AprRu5HSIwBSpPnrCTD6gpOxNukHQY/1+A=;
        b=mso/6H4w8Vo536aErloaRy+KMsD54AOY5woo05cOhO2yGL+La3gJ1Ryx1uUHIvMaQE
         82rgxHuNV+LiS5UhkzeyfxuYjub3HeqncsghB83pr9BRvMOAg3KgFkGjjr9w6FYO0KMO
         2kTD1T1yJvJkIsjbJivLCN6Ptx+DrfJBm2Mr52KbuBEH3cbh5DKdyAXkAvzvdyhz9vpo
         aESdN+mYn575Sb6mukClfrOfEksNGXkj/xCYyqZlxVone0xAWjcJBCVp+Z9WL3Jt/l1V
         DX/q8P5ZImXT7BLz0tO2kX+xsaga5ahnBnln0zkuuzRX8p5Mt4vSQ4TYg8OL3/Ezz6iN
         rDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLtLR+JR4AprRu5HSIwBSpPnrCTD6gpOxNukHQY/1+A=;
        b=j9OA1BDrwFWzfkqv3sq45yKejGDtubaJ9UHfESrfb2+gesN2oryNiwfA5K0YEDn8da
         8lpqRyv4NuCbNxuixi+KUItVO4Ixall3GaocqVrZ+VOX5P4PshxsaIc6/suJVkjkr2+v
         g0YGNMOa8UzI7Vf4D2RZpybMJQjAHS5yhSZnoauaFfxSzX3LGqVz560HT6PQG9RJQV40
         TbrBepai0bQV4rD4pnsmvqQ9H73pffmtipV1SxkbEDjhLpuE5ewe5lr21j8DwMOm+DLh
         et5outy2y0TnBV8YcPDeXjTgBkmvSIdZ/oPhpfGGCx7/Xus4pf5hv1DDa4zLgcypNq9N
         Nvzg==
X-Gm-Message-State: AOAM532llgIe23LNAvR8kkbq6b+DQB7KdSM8BdmQ+Ldq/Yv7scBsPDRh
        PK7n9m94F/gIjtOxIPYv5in7GpqMy3a2Cw==
X-Google-Smtp-Source: ABdhPJysfZLt3biaOEijL5i3rCACJNULMy7hL0M4QxNwiTfO7xUdroGhtURtX5m3xLUAXEO9NqJjNg==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr24418432wrx.103.1628019555002;
        Tue, 03 Aug 2021 12:39:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/36] hook.c: add a hook_exists() wrapper and use it in bugreport.c
Date:   Tue,  3 Aug 2021 21:38:31 +0200
Message-Id: <patch-v4-05.36-3514e0c0251-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
index 596f079a7f9..941c8d5e270 100644
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
index c4dbef1d0ef..97cd799a320 100644
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
index 68624f16059..4c547ac15e5 100644
--- a/hook.h
+++ b/hook.h
@@ -8,4 +8,9 @@
  */
 const char *find_hook(const char *name);
 
+/*
+ * A boolean version of find_hook()
+ */
+int hook_exists(const char *hookname);
+
 #endif
-- 
2.33.0.rc0.595.ge31e012651d


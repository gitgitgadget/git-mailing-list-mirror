Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F34C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5D6613D2
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhGJIuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbhGJIuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 04:50:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587F1C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m2so4626917wrq.2
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 01:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwWp208rj4+tGo08T+Uye1D0o7Jh9/GQUewrBeaKGXU=;
        b=nZ9WroWCrfnorGF1QqSmlIOCQ8QDp3HYT81CWxh3OhsoU6DNT7jR81lbTE4bc0BaVi
         6BvU0RkC0QMtE/OpcsX5XFTDeEtOna2IDslWHRg11nf6aZmGcPL67UuSLfwgIKBjaNuq
         r72ezYydCkiCFI1VhmLKkls23gUSHjpSLbm5QNn2zVQsPGLCzl0X98Eam5cVESUXYTbv
         iVcgsbmkk+42Z0MZLeP3bq0xhBkPVkqaq7xpcKY2FKcuaz5TLRYHpeuK7crI4k9g7Q7S
         lyW/mBxC2I4jjkO5WU/hYNk2mozTA941uh3sfVlu9I8LihL/sbMBQS0MlmnxTdZF8qj4
         YEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwWp208rj4+tGo08T+Uye1D0o7Jh9/GQUewrBeaKGXU=;
        b=mYfhXVHrwVk4m6eDO0YxSFvuz6Pa3HaCUAjHA98IcSej8EOTMzJtA9BEvKWoE7RJxD
         Q+eLCKyMyPPifcismdPrnsdWO++Ef5EzVHmupCCK8nWrOrkWJiJehVloBwDbLt/S+KGH
         F3v8812OtyB2tiGkjaXQ76mbd9tCFJfhY4siW0R5z7VUsLqWXPCIcm/mxC8vDyUExhM4
         D+kOeEgPnkQEDdQI9RAYlXHMJO4hF8leb1nIozZ8/F2zTbeLH1r15RLGhUNpb9EcpExu
         5w7O1T1AueMsbejYDsqLRyLH04IhyeIDiWdtVAMGGQcs19L3A6mKHSA2AG63yD20hTnh
         wxtg==
X-Gm-Message-State: AOAM533YNYGPZNnnjzmLkhRuN3pB0p+hQGS8trMq/uN3UmvIQEE8ZGJO
        nLxbY0JNALJZh74frFBD3N/A7DH2ZWq7Zw==
X-Google-Smtp-Source: ABdhPJzX0cN8peHnU9DP4vAeOC3uVlOKEI1XCqHC2Pr1G/vvHmmRfCVfGYL7BCB38+x23r+zZ0eyRQ==
X-Received: by 2002:adf:dc8b:: with SMTP id r11mr47847656wrj.363.1625906855702;
        Sat, 10 Jul 2021 01:47:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x8sm165769wrt.93.2021.07.10.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 01:47:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] *.c static functions: don't forward-declare __attribute__
Date:   Sat, 10 Jul 2021 10:47:27 +0200
Message-Id: <patch-1.6-a855bfceb2c-20210710T084445Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9cf6d3357aa (Add git-index-pack utility, 2005-10-12) and
466dbc42f58 (receive-pack: Send internal errors over side-band #2,
2010-02-10) we added these static functions and forward-declared their
__attribute__((printf)).

I think this may have been to work around some compiler limitation at
the time, but in any case we have a lot of code that uses the briefer
way of declaring these that I'm using here, so if we had any such
issues with compilers we'd have seen them already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/index-pack.c   | 4 +---
 builtin/receive-pack.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3fbc5d70777..8336466865c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -369,9 +369,7 @@ static void parse_pack_header(void)
 	use(sizeof(struct pack_header));
 }
 
-static NORETURN void bad_object(off_t offset, const char *format,
-		       ...) __attribute__((format (printf, 2, 3)));
-
+__attribute__((format (printf, 2, 3)))
 static NORETURN void bad_object(off_t offset, const char *format, ...)
 {
 	va_list params;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a34742513ac..2d1f97e1ca7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -425,9 +425,6 @@ static int proc_receive_ref_matches(struct command *cmd)
 	return 0;
 }
 
-static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
-
 static void report_message(const char *prefix, const char *err, va_list params)
 {
 	int sz;
@@ -445,6 +442,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
 		xwrite(2, msg, sz);
 }
 
+__attribute__((format (printf, 1, 2)))
 static void rp_warning(const char *err, ...)
 {
 	va_list params;
@@ -453,6 +451,7 @@ static void rp_warning(const char *err, ...)
 	va_end(params);
 }
 
+__attribute__((format (printf, 1, 2)))
 static void rp_error(const char *err, ...)
 {
 	va_list params;
-- 
2.32.0.636.g43e71d69cff


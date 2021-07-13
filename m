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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7C7C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AF5606A5
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMIIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhGMIIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:08:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489B2C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l7so28344058wrv.7
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dslKaYUbJj628knJ/DIHRtHZ6OoT95Cd25nYVQb7lN4=;
        b=WWNVtZTCdGKYAKjqSLQoPA3+7NUZXoH3efwy1R4XPzZ/KVhd009hIV2RnXnuxGc2+O
         7uprcAH7s4/8z1cZWIkmWQhz3mM+o1DmYGVIIrSD6vHNUL68rvqvRv5HlAqp/hvoJNtI
         OIXhpMX8tIT7HJxqzya1oXX72QH8Cy9/JHwcdVKmBD+yBCEpGYeccqAkaqDL+/DitSzg
         FzB7V4GfWhzBTdZ+j9VlBwM8VfWqFAJuNVCtSDHSJbD38EpHFVp+PXsIUYHCvmL2QKxW
         cd7tUDsoGxELEa32ZJNNglSq5mwcaWHjvbFj9SLrDVFOmJNsRBdm5mS2/DVGUMZG2t5/
         lW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dslKaYUbJj628knJ/DIHRtHZ6OoT95Cd25nYVQb7lN4=;
        b=AecKwJiMLxbel/p0R/KhijeavCQyry1oY+ZGQUziyopspH3xHBFyjZdKmhpG9y73TH
         TwDEwChGbe93ROjj500J3ZudLKtLSc2950WFPPQP6KwLUPBHP7ZaAo0Q/mgmUrEFvyzx
         /Tt9TQQTp5r4VfMnzcFHsDIGjCZPr26UsrNwv92qSK6Rp2NIShZOP1QF4nkCKHU9dQwo
         6mI4divE8QE2VwVRwt3i8oHD3GGXMz/sN0kKuGpjT6/x7z4wMAufGU49dIvh9rQRRigD
         VzK3y2VxhJotL5V6ojuZ7xdTvlwl1SpqGpBN/mRtH1G/a6hLI6WKSt3Nls4UZSqsvhfr
         srVQ==
X-Gm-Message-State: AOAM533cVWYaOka08PfXWfzZduj4Gn/GVAHiEtkF0O3yDdPuToW2fTGf
        kCupiLQtCDhnQt8ZjxkvqqCmg8ff8qNv8Q==
X-Google-Smtp-Source: ABdhPJzkQDjQ+2U2CWgEWjxjk+H4dWWJqM3+YIrbtGSlDHlZyWThlo6+wqkIGYiWS2FvYA3B7LuOFw==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr4011938wru.48.1626163524630;
        Tue, 13 Jul 2021 01:05:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z11sm17156772wru.65.2021.07.13.01.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:05:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] *.c static functions: don't forward-declare __attribute__
Date:   Tue, 13 Jul 2021 10:05:16 +0200
Message-Id: <patch-1.6-a855bfceb2-20210713T080411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210710T084445Z-avarab@gmail.com> <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
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
index 3fbc5d7077..8336466865 100644
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
index a34742513a..2d1f97e1ca 100644
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
2.32.0-dev


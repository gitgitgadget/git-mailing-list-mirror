Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D78C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiCDNMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiCDNMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:12:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F3360ABC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:11:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ay10so12646323wrb.6
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=fMvRl4h/fanebrP5dlRHisvRofIjp58PSliTs9GG+BU=;
        b=nWyyMqjz2oD0a+tWOgCftP9uaVwbq+2u2XyEPokUC+eFch4K5GJJGmgXnFkKE6vuJI
         VBXM1dyyo57XUz5XMbb6Z1PuXUVJadNRLHL3mALqHoCD5te1i4sHI2o7btvPGS/Nf9d2
         nG7ozo0p6J6xK8LFkdvtfPttL55bVyJts6zqoS5OB9AlwJeRj4nifJev5Y5LziJZAr2C
         MmKxlt3YrWqx7wN89OwP/N6hfbRYk+HFoNhb0+WxGjhpBXEX9uvhtJTwO2oEGcuTbOCf
         GtPB27HIviAfnUgl4zjiNQmxfswJH08csXzPnwcp9V9OzK/bIK/oXYbXx4yKsfyKzbvv
         2N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=fMvRl4h/fanebrP5dlRHisvRofIjp58PSliTs9GG+BU=;
        b=RLIwSA6j3M72JxBFVG3xzeLy7hCk6L7Hft1/t4ls0GntoU8zyJgcRZByPEyFBIbkfa
         IPKrP/dgLV1vS0VtgS9enxRy3ok4pVUcZi/3fS4Bs09gimxsbG/pZ2bcsGlr9KmvYh87
         8ba3b0g1lOKeWY5+559V/nMCOWBgaUVqEJEgYRWkURRMAjGjQP4vwhgG1hVU2VdJ/zdB
         uigOr/9l8EsqZRkP8eOaSVd4u+aCQA/lDPCRe0NhWEyT1n1QbCx54yh3AZiATjCvX927
         uhs5NffNez9thlu4q7x3VjIpgPFUmcNOmcRa92k2MJefo9HK6oUxXfmOWtTIx1+/JaCU
         1USA==
X-Gm-Message-State: AOAM533GQsan1NRVGgIUw6GqcPO9NOySb0D60dGk+1sMrCF+xlot4XkQ
        O4qrghElphxZEE9jyWYlKabu9UYRAUA=
X-Google-Smtp-Source: ABdhPJy6HZsqj79bmr0e68JZ6AZKs7M+UdBETrx+iZiO2aIQOKUBZKkRFUFgbfCGEbs1Pe+CfQ5TOA==
X-Received: by 2002:a5d:5687:0:b0:1f0:9663:c80e with SMTP id f7-20020a5d5687000000b001f09663c80emr1823200wrv.343.1646399492133;
        Fri, 04 Mar 2022 05:11:32 -0800 (PST)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b001f0494de239sm4634042wrr.21.2022.03.04.05.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:11:31 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/4] terminal: use flags for save_term()
Date:   Fri,  4 Mar 2022 13:11:23 +0000
Message-Id: <20220304131126.8293-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304131126.8293-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The next commit will add another flag in addition to the existing
full_duplex so change the function signature to take an unsigned flags
argument. Also alter the functions that call save_term() so that they
can pass flags down to it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 41 +++++++++++++++++++++--------------------
 compat/terminal.h |  5 ++++-
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index d882dfa06e..bad8e04cd8 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -34,7 +34,7 @@ void restore_term(void)
 	sigchain_pop_common();
 }
 
-int save_term(int full_duplex)
+int save_term(unsigned flags)
 {
 	if (term_fd < 0)
 		term_fd = open("/dev/tty", O_RDWR);
@@ -47,11 +47,11 @@ int save_term(int full_duplex)
 	return 0;
 }
 
-static int disable_bits(tcflag_t bits)
+static int disable_bits(unsigned flags, tcflag_t bits)
 {
 	struct termios t;
 
-	if (save_term(0) < 0)
+	if (save_term(flags) < 0)
 		goto error;
 
 	t = old_term;
@@ -71,14 +71,14 @@ static int disable_bits(tcflag_t bits)
 	return -1;
 }
 
-static int disable_echo(void)
+static int disable_echo(unsigned flags)
 {
-	return disable_bits(ECHO);
+	return disable_bits(flags, ECHO);
 }
 
-static int enable_non_canonical(void)
+static int enable_non_canonical(unsigned flags)
 {
-	return disable_bits(ICANON | ECHO);
+	return disable_bits(flags, ICANON | ECHO);
 }
 
 #elif defined(GIT_WINDOWS_NATIVE)
@@ -126,15 +126,15 @@ void restore_term(void)
 	hconin = hconout = INVALID_HANDLE_VALUE;
 }
 
-int save_term(int full_duplex)
+int save_term(unsigned flags)
 {
 	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
 	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
 	    FILE_ATTRIBUTE_NORMAL, NULL);
 	if (hconin == INVALID_HANDLE_VALUE)
 		return -1;
 
-	if (full_duplex) {
+	if (flags & SAVE_TERM_DUPLEX) {
 		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
 			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
 			FILE_ATTRIBUTE_NORMAL, NULL);
@@ -154,7 +154,7 @@ int save_term(int full_duplex)
 	return -1;
 }
 
-static int disable_bits(DWORD bits)
+static int disable_bits(unsigned flags, DWORD bits)
 {
 	if (use_stty) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -191,7 +191,7 @@ static int disable_bits(DWORD bits)
 		use_stty = 0;
 	}
 
-	if (save_term(0) < 0)
+	if (save_term(flags) < 0)
 		return -1;
 
 	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
@@ -204,14 +204,15 @@ static int disable_bits(DWORD bits)
 	return 0;
 }
 
-static int disable_echo(void)
+static int disable_echo(unsigned flags)
 {
-	return disable_bits(ENABLE_ECHO_INPUT);
+	return disable_bits(ENABLE_ECHO_INPUT, flags);
 }
 
-static int enable_non_canonical(void)
+static int enable_non_canonical(unsigned flags)
 {
-	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT);
+	return disable_bits(ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT,
+			    flags);
 }
 
 /*
@@ -267,7 +268,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
 		return NULL;
 	}
 
-	if (!echo && disable_echo()) {
+	if (!echo && disable_echo(0)) {
 		fclose(input_fh);
 		fclose(output_fh);
 		return NULL;
@@ -361,7 +362,7 @@ int read_key_without_echo(struct strbuf *buf)
 	static int warning_displayed;
 	int ch;
 
-	if (warning_displayed || enable_non_canonical() < 0) {
+	if (warning_displayed || enable_non_canonical(0) < 0) {
 		if (!warning_displayed) {
 			warning("reading single keystrokes not supported on "
 				"this platform; reading line instead");
@@ -413,10 +414,10 @@ int read_key_without_echo(struct strbuf *buf)
 
 #else
 
-int save_term(int full_duplex)
+int save_term(unsigned flags)
 {
-	/* full_duplex == 1, but no support available */
-	return -full_duplex;
+	/* no duplex support available */
+	return -!!(flags & SAVE_TERM_DUPLEX);
 }
 
 void restore_term(void)
diff --git a/compat/terminal.h b/compat/terminal.h
index 0fb9fa147c..f24b91390d 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,14 +1,17 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+/* Save input and output settings */
+#define SAVE_TERM_DUPLEX (1u << 0)
+
 /*
  * Save the terminal attributes so they can be restored later by a
  * call to restore_term(). Note that every successful call to
  * save_term() must be matched by a call to restore_term() even if the
  * attributes have not been changed. Returns 0 on success, -1 on
  * failure.
  */
-int save_term(int full_duplex);
+int save_term(unsigned flags);
 /* Restore the terminal attributes that were saved with save_term() */
 void restore_term(void);
 
-- 
2.35.1


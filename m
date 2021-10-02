Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF6C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7CAD61002
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhJBPjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhJBPjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 11:39:02 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4EC0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 08:37:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c6-20020a9d2786000000b005471981d559so15529310otb.5
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gineKfzyvSzPeef1CKzhggBXEXK5egBpqRHaxn9bU9Q=;
        b=XkTp3a6XizzOPgxUBSOTpx6oluyrf6U93+kp7MGA2TGXb07T4amT5JfYV7CsNj5Be/
         +dWrRTxzZiPjF84m39cOs9pAd/TjB37OQpj6J9TOk568ND5l1I2Q1Yp5X1HLTkCog0uz
         yaf/P5z2GyrZjC9MiXichwKgoYzNKz2C0xUjUzERUlFUuLcra0z/Tjnx0SQV8K1DgAWV
         8HWVjGDyrKnBWwqxD2wz7xJsU4L8BCKUeF/PlxAaYd3jtsfAOhp+TPBDvvx6KyAtjgfb
         tLn35asEHT8jW8WoIHVSZCH3wjON7sSP4ozvYAOtyddOFwZVrk7com9TMP5A2/vqFoAF
         qhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gineKfzyvSzPeef1CKzhggBXEXK5egBpqRHaxn9bU9Q=;
        b=OQtets3xFKTSaiXjgdQedrCAVgDzB5dsGV6ZncrKsx8ER0tdmzLXFbZoNzR/M55PU5
         lYUHjHc+L35UhhE+1Ddh+lkQEfQaL/QnOEsdfBGcI2uZVqvOntY0Jt8IOz3LZQSBekAG
         SVB9yQejR1pRHwLyqT9OsV72wgOqO1bLvM4CA73tCmADghaCJq4BBdLuujxS4PrSPElV
         mmzbFlmxu4G9fc1qyPddYEtMVS/lTp+88A8i8mcN9ixQYFbxBz6xlq24X+r5mzm2qp5G
         djPLuafkIbMKszj+XRumvqMoOXb0s0QNe1UkoqXEVAPnDaC04M0P1KCOw2LJxs2fYFUm
         /peg==
X-Gm-Message-State: AOAM532n2QsN0JR3VZ3BaEU3m4pJBaNwhTa3umwvD4ZigB5v2RSergEp
        qmrGclTDaSMlFiCMfIdkGrQlTFJY4KtqXg==
X-Google-Smtp-Source: ABdhPJzu4MldxWkGBvf3r9/RRY/FnGxj9Xf0KbB0A01vp1TTwPk3sRgGoRwzIwxFCgwMpg4fB4+iBQ==
X-Received: by 2002:a05:6830:2146:: with SMTP id r6mr3044753otd.1.1633189035283;
        Sat, 02 Oct 2021 08:37:15 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r188sm1719987oie.7.2021.10.02.08.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Oct 2021 08:37:15 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 1/2] terminal: teach git how to save/restore its terminal settings
Date:   Sat,  2 Oct 2021 08:36:53 -0700
Message-Id: <20211002153654.52443-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211002153654.52443-1-carenas@gmail.com>
References: <20211002153654.52443-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two functions to push/pop the terminal settings using either
the POSIX or Windows console functions, and refactor the current
code to use them.

This will allow for the state of the terminal to be saved and
restored around a child that might need to change them (ex vi)
and might not restore them properly upon exit.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/terminal.c | 72 ++++++++++++++++++++++++++++++++++++++---------
 compat/terminal.h |  3 ++
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 43b73ddc75..d3f858fe94 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -25,25 +25,38 @@ static void restore_term_on_signal(int sig)
 static int term_fd = -1;
 static struct termios old_term;
 
-static void restore_term(void)
+void pop_term(void)
 {
 	if (term_fd < 0)
 		return;
 
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
+}
+
+static void restore_term(void)
+{
+	pop_term();
+
 	close(term_fd);
 	term_fd = -1;
 }
 
+int push_term(int full_duplex)
+{
+	if (term_fd < 0)
+		term_fd = open("/dev/tty", O_RDWR);
+
+	return (term_fd < 0) ? -1 : tcgetattr(term_fd, &old_term);
+}
+
 static int disable_bits(tcflag_t bits)
 {
 	struct termios t;
 
-	term_fd = open("/dev/tty", O_RDWR);
-	if (tcgetattr(term_fd, &t) < 0)
+	if (push_term(0) < 0)
 		goto error;
 
-	old_term = t;
+	t = old_term;
 	sigchain_push_common(restore_term_on_signal);
 
 	t.c_lflag &= ~bits;
@@ -75,7 +88,22 @@ static int enable_non_canonical(void)
 static int use_stty = 1;
 static struct string_list stty_restore = STRING_LIST_INIT_DUP;
 static HANDLE hconin = INVALID_HANDLE_VALUE;
-static DWORD cmode;
+static HANDLE hconout = INVALID_HANDLE_VALUE;
+static DWORD cmode_in, cmode_out;
+
+void pop_term(void)
+{
+	if (hconin == INVALID_HANDLE_VALUE)
+		return;
+
+	SetConsoleMode(hconin, cmode_in);
+	CloseHandle(hconin);
+	if (cmodeout) {
+		assert(hconout != INVALID_HANDLE_VALUE);
+		SetConsoleMode(hconout, cmode_out);
+		CloseHandle(hconout);
+	}
+}
 
 static void restore_term(void)
 {
@@ -94,12 +122,34 @@ static void restore_term(void)
 		return;
 	}
 
+	pop_term();
+	hconin = hconout = INVALID_HANDLE_VALUE;
+}
+
+int push_term(int full_duplex)
+{
+	hconin = CreateFileA("CONIN$", GENERIC_READ | GENERIC_WRITE,
+	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
+	    FILE_ATTRIBUTE_NORMAL, NULL);
 	if (hconin == INVALID_HANDLE_VALUE)
-		return;
+		return -1;
+
+	if (full_duplex) {
+		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
+			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
+			FILE_ATTRIBUTE_NORMAL, NULL);
+		if (hconout == INVALID_HANDLE_VALUE)
+			goto error;
 
-	SetConsoleMode(hconin, cmode);
+		GetConsoleMode(hconout, &cmode_out);
+	}
+
+	GetConsoleMode(hconin, &cmode_in);
+	return 0;
+error:
 	CloseHandle(hconin);
 	hconin = INVALID_HANDLE_VALUE;
+	return -1;
 }
 
 static int disable_bits(DWORD bits)
@@ -135,15 +185,11 @@ static int disable_bits(DWORD bits)
 		use_stty = 0;
 	}
 
-	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
-	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
-	    FILE_ATTRIBUTE_NORMAL, NULL);
-	if (hconin == INVALID_HANDLE_VALUE)
+	if (push_term(0) < 0)
 		return -1;
 
-	GetConsoleMode(hconin, &cmode);
 	sigchain_push_common(restore_term_on_signal);
-	if (!SetConsoleMode(hconin, cmode & ~bits)) {
+	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
 		CloseHandle(hconin);
 		hconin = INVALID_HANDLE_VALUE;
 		return -1;
diff --git a/compat/terminal.h b/compat/terminal.h
index a9d52b8464..5cc19116b7 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,6 +1,9 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+int push_term(int full_duplex);
+void pop_term(void);
+
 char *git_terminal_prompt(const char *prompt, int echo);
 
 /* Read a single keystroke, without echoing it to the terminal */
-- 
2.33.0.955.gee03ddbf0e


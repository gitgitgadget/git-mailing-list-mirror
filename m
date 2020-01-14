Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33797C33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEAE24670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bx0SWYgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgANSoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36201 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgANSoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:44:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so13268330wru.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=Bx0SWYgkLeUeyvxylLXa4/bxK0H3ThHOPQNHZ8bH3+ZBg0vyhMWCtKne3ER2Thiycg
         v8kMoIkG/YRLAt61hZ2iA6zMYIhAyD6ydjASAp5ek1VDVQphqfjQD3pjpH13jVQH/8Uf
         z1pvJMAmNFf6+uUWjiKu5wWsRvo0leC+1fPoK6bgsqfz/0HcL4b8gLoIhJbJTYpKbkXM
         1bMgbmfUl/lLJlCz2YsAkGhdKOq8kDyPsmetVTx/VWfbozCAhjxUs0b+FwqqEIXYXuRo
         vnOtsDi1kxJ8CnDjYpdBzTzSi7XeaBmLK2Bl1aocRZDOhY1BaLzyJp67T+lkzojBQBnd
         jlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SoINhosxY8bQOCleNIF9uXXAb4CbGyczHohOpNqVWPc=;
        b=Sj1BisqYaqjqT8jlR2kCnQfwttGhl9ib7miabO67ZhpXLeqt1Pjm5EfVWIrPebYFym
         yPetXFttaTgHLUUGOSdsnRNGHNOfFf+SRBMsDkw04B/3cd0AEXL/u48UViVVBSxZlVHX
         F2PfG4+odJI3OBAcabsIUc9Ztg8oySzFPQz8lEKWvY6njWvzLXK1zszgzruSXpgZ953Y
         z1ynLOXXdQKxRenGScZsS67ZsISPgmFaCem60+KCPd/QBcWKQdBP8qBmWr7q74AAuW1S
         OdDQOXgBvGtRBKWAIYWS54lxp2zm0t14ymu6J3W2v6fqpbHI2BEWZMlMnPXSbVyxrw6f
         gasQ==
X-Gm-Message-State: APjAAAWb6VUW0LTocQqpD9BmwJ8DqFXi16pD/xwjkZs0DtHjQxd5hIju
        urnswgifazM4FkSbu7KRDIsIg5r6
X-Google-Smtp-Source: APXvYqzMEArxym/TFx7SviywV+7HzkXwPXvUb3SUsyaOxgB2bpcPEPjstE6q0SwEyDC7nmuklCFpzw==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr25438598wrk.53.1579027438380;
        Tue, 14 Jan 2020 10:43:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm22081582wrg.27.2020.01.14.10.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:57 -0800 (PST)
Message-Id: <09a8946303720f8abd168d0590d421c1dbbbd71a.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:47 +0000
Subject: [PATCH v4 04/10] terminal: make the code of disable_echo() reusable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to introduce the function `enable_non_canonical()`, which
shares almost the complete code with `disable_echo()`.

Let's prepare for that, by refactoring out that shared code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index fa13ee672d..1fb40b3a0a 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -32,7 +32,7 @@ static void restore_term(void)
 	term_fd = -1;
 }
 
-static int disable_echo(void)
+static int disable_bits(tcflag_t bits)
 {
 	struct termios t;
 
@@ -43,7 +43,7 @@ static int disable_echo(void)
 	old_term = t;
 	sigchain_push_common(restore_term_on_signal);
 
-	t.c_lflag &= ~ECHO;
+	t.c_lflag &= ~bits;
 	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
 		return 0;
 
@@ -53,6 +53,11 @@ static int disable_echo(void)
 	return -1;
 }
 
+static int disable_echo(void)
+{
+	return disable_bits(ECHO);
+}
+
 #elif defined(GIT_WINDOWS_NATIVE)
 
 #define INPUT_PATH "CONIN$"
@@ -72,7 +77,7 @@ static void restore_term(void)
 	hconin = INVALID_HANDLE_VALUE;
 }
 
-static int disable_echo(void)
+static int disable_bits(DWORD bits)
 {
 	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
 	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
@@ -82,7 +87,7 @@ static int disable_echo(void)
 
 	GetConsoleMode(hconin, &cmode);
 	sigchain_push_common(restore_term_on_signal);
-	if (!SetConsoleMode(hconin, cmode & (~ENABLE_ECHO_INPUT))) {
+	if (!SetConsoleMode(hconin, cmode & ~bits)) {
 		CloseHandle(hconin);
 		hconin = INVALID_HANDLE_VALUE;
 		return -1;
@@ -91,6 +96,12 @@ static int disable_echo(void)
 	return 0;
 }
 
+static int disable_echo(void)
+{
+	return disable_bits(ENABLE_ECHO_INPUT);
+}
+
+
 #endif
 
 #ifndef FORCE_TEXT
-- 
gitgitgadget


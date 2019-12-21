Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411ECC2D0D2
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1A6206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNpQVMGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLUWmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34783 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUWmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so12074522edw.1
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=sNpQVMGvQ67Ux4KJX77fy8lIbq6z8T5sj4cyvLtUMmvQBErrT2ahIcCX67/6ynREE1
         AaP7trzgqiAsPqBZ1BE25sziUCUEOXoZVUGTXy74TSNYt1AfM1CCLreXO0l6rFwgoTCD
         qx6vcqJoEY5qIOwMHyajJ8u6jsYVZTK8+5Q1IEjs6SC7nFIWgrAIElA1IGNWXc1pDnON
         0FL+RwJDlPFZK4vLdM5KhBclGPQsCvcS+OhpZcdGPwJA75v6qDWDKj/Ar3Z47wAgRhVn
         hw15+0uZDo5iU9VvIavtSHLGLXlb7yW7HwE8aCk5W2oB2shYb5Ge39L51B1hRJlUww/B
         o/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=C2ay+Yyme+LZ+E7SKcIuvHgYBSOhQOy8qjjxK412Dqh38NqIxg33JQQ5Wehdq3gvEQ
         3QBDt4iCs3ZGaE90ubfzWekB97w9tSPa7lo1T7MQAJ5ce7exwesVNI6TRsu7czhzmInU
         MSO9mkR+CgcZcfn40/DlFhQZqTXG7efQcDem3+GQyoOSd2UL4hxjnFBGjPv12uelJxzb
         x+6vt/N0PMZQQ7E0Uajgk2he1A1H0iVJBDyBzieQIM3IPD5H2rbAFPgm3VwIKdu63orC
         FbYGtNzsdbPOoZy5WRNACThmrfGZuH9+8+W8puXgIxFJe6lxTSOI2XbPs9k6sGBfQCZI
         Y32w==
X-Gm-Message-State: APjAAAULDW6GXqOcDzW4mG4eCEJo7gmK0pnBUj6k7tuCiniuIVjkIkDU
        Q3inRqYdFCSODCeUSva+yNS7E3th
X-Google-Smtp-Source: APXvYqzuUaVhMkOqGorjFnf+B9z+F2XP0pg30Yg7fqJwD2e0Ci1axSYzfcByClamLI2WWu3njeoM3w==
X-Received: by 2002:aa7:d285:: with SMTP id w5mr23845664edq.246.1576968124687;
        Sat, 21 Dec 2019 14:42:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm1664992ejf.77.2019.12.21.14.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:04 -0800 (PST)
Message-Id: <a77fa914da14c84ff2ebadd26fbcac97456aae04.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:55 +0000
Subject: [PATCH 4/9] terminal: accommodate Git for Windows' default terminal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows' Git Bash runs in MinTTY by default, which does not have
a Win32 Console instance, but uses MSYS2 pseudo terminals instead.

This is a problem, as Git for Windows does not want to use the MSYS2
emulation layer for Git itself, and therefore has no direct way to
interact with that pseudo terminal.

As a workaround, use the `stty` utility (which is included in Git for
Windows, and which *is* an MSYS2 program, so it knows how to deal with
the pseudo terminal).

Note: If Git runs in a regular CMD or PowerShell window, there *is* a
regular Win32 Console to work with. This is not a problem for the MSYS2
`stty`: it copes with this scenario just fine.

Also note that we introduce support for more bits than would be
necessary for a mere `disable_echo()` here, in preparation for the
upcoming `enable_non_canonical()` function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/terminal.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/compat/terminal.c b/compat/terminal.c
index 1fb40b3a0a..16e9949da1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -2,6 +2,8 @@
 #include "compat/terminal.h"
 #include "sigchain.h"
 #include "strbuf.h"
+#include "run-command.h"
+#include "string-list.h"
 
 #if defined(HAVE_DEV_TTY) || defined(GIT_WINDOWS_NATIVE)
 
@@ -64,11 +66,28 @@ static int disable_echo(void)
 #define OUTPUT_PATH "CONOUT$"
 #define FORCE_TEXT "t"
 
+static int use_stty = 1;
+static struct string_list stty_restore = STRING_LIST_INIT_DUP;
 static HANDLE hconin = INVALID_HANDLE_VALUE;
 static DWORD cmode;
 
 static void restore_term(void)
 {
+	if (use_stty) {
+		int i;
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		if (stty_restore.nr == 0)
+			return;
+
+		argv_array_push(&cp.args, "stty");
+		for (i = 0; i < stty_restore.nr; i++)
+			argv_array_push(&cp.args, stty_restore.items[i].string);
+		run_command(&cp);
+		string_list_clear(&stty_restore, 0);
+		return;
+	}
+
 	if (hconin == INVALID_HANDLE_VALUE)
 		return;
 
@@ -79,6 +98,37 @@ static void restore_term(void)
 
 static int disable_bits(DWORD bits)
 {
+	if (use_stty) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+
+		argv_array_push(&cp.args, "stty");
+
+		if (bits & ENABLE_LINE_INPUT) {
+			string_list_append(&stty_restore, "icanon");
+			argv_array_push(&cp.args, "-icanon");
+		}
+
+		if (bits & ENABLE_ECHO_INPUT) {
+			string_list_append(&stty_restore, "echo");
+			argv_array_push(&cp.args, "-echo");
+		}
+
+		if (bits & ENABLE_PROCESSED_INPUT) {
+			string_list_append(&stty_restore, "-ignbrk");
+			string_list_append(&stty_restore, "intr");
+			string_list_append(&stty_restore, "^c");
+			argv_array_push(&cp.args, "ignbrk");
+			argv_array_push(&cp.args, "intr");
+			argv_array_push(&cp.args, "");
+		}
+
+		if (run_command(&cp) == 0)
+			return 0;
+
+		/* `stty` could not be executed; access the Console directly */
+		use_stty = 0;
+	}
+
 	hconin = CreateFile("CONIN$", GENERIC_READ | GENERIC_WRITE,
 	    FILE_SHARE_READ, NULL, OPEN_EXISTING,
 	    FILE_ATTRIBUTE_NORMAL, NULL);
-- 
gitgitgadget


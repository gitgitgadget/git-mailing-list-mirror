Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53EC33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4A24658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiFQaWOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgANSoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32814 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANSoA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:44:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so13285183wrq.0
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=aiFQaWOlI0osu2RNLcQFNdRRG89HK1dxr9uKI6/ofE7QzcpRqWHs2o5FSVSvG10KuM
         v+D8A7v3GkMQy0QaYtrDJJEWhF3Moge1Km42TAtLFYO4OyYoe/SEYd9QwHWiNHM5ntwb
         5nPf1J6LABCie1jjvMGQ8ouCSa7ArjkUtSBUeb5vc2qJmPFPxyUVxbeBSDnUoj9XHX3n
         RgWQgNr6ZAwIS8Is+l9BCJ1kQotXC6YVHbSuOBKMxS8FJchTAaOvHTbD8T+KnX3puEeE
         iKAFrCes3KxgYpJljhaKeNzJxEWy9SfZydiE6Z2Z3WjC5TyuL6lP4pi8qLuXpiDdt7VF
         zoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Pd7gm9sA8KWwnCXzcqZeBD0/pHyKhrgKove5Fa6H3tg=;
        b=FNRwBGE/WCE6t81SuYi5/cb4H10Bxz5agQowpsBgWt0H5+ntX3Rcuaa1MW5PPJ+jF+
         BL4DCxFFMe5dWxwLKNI/Xa1Kqrs5XgezyHkAmtmOx7Z0jgFGndP7WKb2OKxEHZkQF0NP
         AI6T3ekLxL82cZ0sqs7EZc5eeyIIinG/D+NVzGWCcxB97rh+8AOAu+Gha8aFwwnvxNb3
         iaOmqKSsRK/WIZF/SjdUmJGPcswHJ8sD2Xb5H89Jy4xRih1j80808FG74ix8OBfZdeda
         LWAGWDPrGJ7OLTFN0dFtXyYNQlbZPBLJ3Ar7n3BWRWC4iQ3bmybIBmooIU7OrhZn3fu2
         ndMA==
X-Gm-Message-State: APjAAAWHGFO8tT7tmi0Okimzwt7iaGpHJyiHkLtf0yE6jvOXkPn60OI+
        vG2wxi+5oniOw9vSchBe0ZFu8gNQ
X-Google-Smtp-Source: APXvYqzkOL4KEu4g4uEtOAe7YhABiSZ+5vAGnp8kN4+AiRpTHmPvAzDFsIzqHcpYayCHiPmHN/zI3g==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr25421419wrn.212.1579027439115;
        Tue, 14 Jan 2020 10:43:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm20281663wrx.71.2020.01.14.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:58 -0800 (PST)
Message-Id: <a81304cb76e127c78c0d6e69520477e6862df7f5.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:48 +0000
Subject: [PATCH v4 05/10] terminal: accommodate Git for Windows' default
 terminal
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


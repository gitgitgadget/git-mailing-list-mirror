Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2E8C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 10:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiBPKyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 05:54:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiBPKyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 05:54:49 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616FE2A0D41
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso3407171wmq.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X5+y37D64SVxOZkUzRq70rzAHHnrxuFXCTpJxGTtxCA=;
        b=GaidUoGzR59n40duMIoLf+jSEdJpP6Z9xRZwMb3wEkXe+VMr1kN8sdlGpF7C6FAqO6
         F+W/5ygp2+dHt5+mTmWwnlxFrSuhYoWJ5BtqyGKMMWop6SISxtuTBEWYsSdxbb34xko8
         kFTGCimd7c+xSPK+X+q6A/4osugqXAD2bJVBSaefUxCjC4jyb5CYmeSAGrzInUKCCNL/
         DTNE02JCzA+uSK3LJb1bXS209p5IdzBytqPALZ4ReX583XMHppED1fZc1jV0MO59/6xa
         5qPQFoJTRd3VKdGLhu281Ggyog2lL4WLBVO2H66PG1aGFSPikLIiy9EF4ysA8/R/tvj5
         z6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X5+y37D64SVxOZkUzRq70rzAHHnrxuFXCTpJxGTtxCA=;
        b=U3WHmUycDxF0avyHXlYsUUM57vLYkC6HWt/2U0GiXZHYORj4kRrDdS2c8d+J59CZ+5
         ZSU7PpICFjGOT9IYrEsH785HyhZfTxcuUL0vcNsFjW9p5tLMSvXDjh7OXDmJsfkXluWL
         MTIaPiDl/EHh0zGaWNQWEXpO8UGrMms639jDN8VdtjonwA/w88/b5EsfVrhviF22DIbK
         cBnwuEhKST2YJhBxLDrfvCDhXF3gMoSM1CNIqsw9Lu4Jj0x05WCFyMFMx8XmOfKWJsfY
         bUM/fiP+RVXwKrPiBqEBQ8E1oVHvT32qXUpGbtKOEikdjauDUaFjP4b7qTpjNnntE+A6
         J4pw==
X-Gm-Message-State: AOAM5328WF6FZd+edYHvJOVsvytgh/oPfH3YNAvketB+Cqy4M9ZwTmwG
        Mgba+j24e748kXTzsGlrfFkjWjqguuk=
X-Google-Smtp-Source: ABdhPJwbzuKvk+tb3dokuFh1QZlT0lDnHbjY6QOjEKJWUN804xMet6XqaWg+tIEqhTcBgiKtm5VOAQ==
X-Received: by 2002:a05:600c:3589:b0:37b:b9fb:f939 with SMTP id p9-20020a05600c358900b0037bb9fbf939mr1020296wmq.188.1645008874807;
        Wed, 16 Feb 2022 02:54:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm17433637wmk.38.2022.02.16.02.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 02:54:34 -0800 (PST)
Message-Id: <9a3c2cea0f904130e944842c3f1d2f31a6b7e95b.1645008873.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 10:54:30 +0000
Subject: [PATCH 1/3] terminal: pop signal handler when terminal is restored
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When disable_bits() changes the terminal attributes it uses
sigchain_push_common() to restore the terminal if a signal is received
before restore_term() is called. However there is no corresponding
call to sigchain_pop_common() when the settings are restored so the
signal handler is left on the sigchain stack. This leaves the stack
unbalanced so code such as

sigchain_push_common(my_handler);
...
read_key_without_echo(...);
...
sigchain_pop_common();

pops the handler pushed by disable_bits() rather than the one it
intended to. Additionally "git add -p" changes the terminal settings
every time it reads a key press so the stack can grow significantly.

In order to fix this save_term() now sets up the signal handler so
restore_term() can unconditionally call sigchain_pop_common(). There
are no callers of save_term() outside of terminal.c as the only
external caller was removed by e3f7e01b50 ("Revert "editor: save and
reset terminal after calling EDITOR"", 2021-11-22). Any future callers
of save_term() should benefit from having the signal handler set up
for them. For example if we reinstate the code to protect against an
editor failing to restore the terminal attributes we would want that
code to restore the terminal attributes on SIGINT. (As an aside
run_command() installs a signal handler that waits for the child
before re-raising the signal so we would be guaranteed to restore the
settings after the child has exited.)

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 17 +++++++++++++----
 compat/terminal.h |  8 ++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 5b903e7c7e3..20803badd03 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -11,7 +11,7 @@
 static void restore_term_on_signal(int sig)
 {
 	restore_term();
-	sigchain_pop(sig);
+	/* restore_term calls sigchain_pop_common */
 	raise(sig);
 }
 
@@ -31,14 +31,20 @@ void restore_term(void)
 	tcsetattr(term_fd, TCSAFLUSH, &old_term);
 	close(term_fd);
 	term_fd = -1;
+	sigchain_pop_common();
 }
 
 int save_term(int full_duplex)
 {
 	if (term_fd < 0)
 		term_fd = open("/dev/tty", O_RDWR);
+	if (term_fd < 0)
+		return -1;
+	if (tcgetattr(term_fd, &old_term) < 0)
+		return -1;
+	sigchain_push_common(restore_term_on_signal);
 
-	return (term_fd < 0) ? -1 : tcgetattr(term_fd, &old_term);
+	return 0;
 }
 
 static int disable_bits(tcflag_t bits)
@@ -49,12 +55,12 @@ static int disable_bits(tcflag_t bits)
 		goto error;
 
 	t = old_term;
-	sigchain_push_common(restore_term_on_signal);
 
 	t.c_lflag &= ~bits;
 	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
 		return 0;
 
+	sigchain_pop_common();
 error:
 	close(term_fd);
 	term_fd = -1;
@@ -100,6 +106,8 @@ void restore_term(void)
 		return;
 	}
 
+	sigchain_pop_common();
+
 	if (hconin == INVALID_HANDLE_VALUE)
 		return;
 
@@ -134,6 +142,7 @@ int save_term(int full_duplex)
 
 	GetConsoleMode(hconin, &cmode_in);
 	use_stty = 0;
+	sigchain_push_common(restore_term_on_signal);
 	return 0;
 error:
 	CloseHandle(hconin);
@@ -177,10 +186,10 @@ static int disable_bits(DWORD bits)
 	if (save_term(0) < 0)
 		return -1;
 
-	sigchain_push_common(restore_term_on_signal);
 	if (!SetConsoleMode(hconin, cmode_in & ~bits)) {
 		CloseHandle(hconin);
 		hconin = INVALID_HANDLE_VALUE;
+		sigchain_pop_common();
 		return -1;
 	}
 
diff --git a/compat/terminal.h b/compat/terminal.h
index e1770c575b2..0fb9fa147c4 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -1,7 +1,15 @@
 #ifndef COMPAT_TERMINAL_H
 #define COMPAT_TERMINAL_H
 
+/*
+ * Save the terminal attributes so they can be restored later by a
+ * call to restore_term(). Note that every successful call to
+ * save_term() must be matched by a call to restore_term() even if the
+ * attributes have not been changed. Returns 0 on success, -1 on
+ * failure.
+ */
 int save_term(int full_duplex);
+/* Restore the terminal attributes that were saved with save_term() */
 void restore_term(void);
 
 char *git_terminal_prompt(const char *prompt, int echo);
-- 
gitgitgadget


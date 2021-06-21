Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E3C49EA2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851D360FF2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhFURIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhFURIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:08:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C0C0619FE
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:58:02 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a11so20477098wrt.13
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2GFUgRHMjoEP7gqIPYmqnU88aWfgsVaRizS/mwjYzKk=;
        b=rSs06UJ33OVPrOFBaIVxGV8aqpnlKOGjhInyst7Ht7RD0aAKC/MhnGJnKT6D69OIls
         5Nl/WCKQVGuSCghnEo9mrdkNTZZv1SXeeZ3r+bHWmQpiTu0sclzcyKfq+T8ugu4KIco9
         zOjCmJLQgdvdiLXFS0jdsUEi28OEju8BB4PpU/YmIRJQ6ocXOtq+3vq0l15uQJ4FGw4N
         Xnz7sOkD+BH3nN6+MN9ieot4nJzrvpPrfPFNSdqbD5dHY91RK7MSu5xNf2AsLHVpg2/i
         7kxk1oXTzs0+sTUQzdInfwisKf1fYfd+B22ShwtHpFvnkKNJzoay72wlecMwdcH20PwQ
         M/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2GFUgRHMjoEP7gqIPYmqnU88aWfgsVaRizS/mwjYzKk=;
        b=oyr+yG8RkUMoYrd/YpOclNkc7tHW99/rNaCj6TpvY7XQfAgyIZF/DaniKUNORZFfYM
         KzXvt/7jbCGnAUIoEbMWMLictm2yo7XxxXwkHG0fBHGx2ZpeRT9zA0QH2srYkY/wBEfN
         XSiFgGx49mP7rYOj62fr6Zu6OGOtpGQtmCOy+CXYulI4V/3+hpfERJi/MpdPYVk98Sny
         gBf1mJHQ9hpC7kZ5Kxr6qYxguXw6S+gq0AlFnlJiOpghQ/G/TMAwez6VtHRf0Dfe+O2/
         JiqiXFN55timBnku9aRX1AyjHTz2i1j9/E++3NcPLNdVGKIb49zytdevLMCntr7OzIr1
         qmEw==
X-Gm-Message-State: AOAM533LGaGw639GbI5VhqmzX2DKITaRiA8iiSrWrGYZdgX/fnk9kLPC
        kKSX+72JbB486QXxvC0zPyXBgN8GF7s=
X-Google-Smtp-Source: ABdhPJwG/ZbPruNK1wy/2/M8qJgAqNt0S7hSz2SAaDR1BKvcmUDGaIiLevcntndzX7iLJR9JYZH/Lg==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr30413014wrw.310.1624294681221;
        Mon, 21 Jun 2021 09:58:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm156110wmf.3.2021.06.21.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:58:00 -0700 (PDT)
Message-Id: <pull.982.v3.git.1624294679495.gitgitgadget@gmail.com>
In-Reply-To: <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com>
References: <pull.982.v2.git.1623847092299.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Jun 2021 16:57:58 +0000
Subject: [PATCH v3] pager: avoid setting COLUMNS when we're guessing its value
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We query `TIOCGWINSZ` in Git to determine the correct value for
`COLUMNS`, and then set that environment variable.

If `TIOCGWINSZ` is not available, we fall back to the hard-coded value
80 _and still_ set the environment variable.

On Windows this is a problem. The reason is that Git for
Windows uses a version of `less` that relies on the MSYS2 runtime to
interact with the pseudo terminal (typically inside a MinTTY window,
which is also aware of the MSYS2 runtime). Both MinTTY and `less.exe`
interact with that pseudo terminal via `ioctl()` calls (which the MSYS2
runtime emulates even if there is no such thing on Windows).
Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
the `COLUMNS` variable over asking ncurses itself.

But `git.exe` itself is _not_ aware of the MSYS2 runtime, or for that
matter of that pseudo terminal, and has no way to call `ioctl()` or
`TIOCGWINSZ`.

Therefore, `git.exe` will fall back to hard-coding 80 columns, no matter
what the actual terminal size is.

But `less.exe` is totally able to interact with the MSYS2 runtime and
would not actually require Git's help (which actually makes things
worse here). So let's not override `COLUMNS` on Windows.

Let's just not set `COLUMNS` unless we managed to query the actual value
from the terminal.

This fixes https://github.com/git-for-windows/git/issues/3235

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    pager: do not unnecessarily set COLUMNS on Windows
    
    A recent upgrade of the "less" package in Git for Windows causes
    problems. Here is a work-around.
    
    Changes since v2:
    
     * We no longer avoid setting COLUMNS based on the Operating Systems and
       the presence of TIOCGWINSZ, but set a flag specifically when we
       successfully queried the terminal's dimensions, and otherwise skip
       the setenv(COLUMNS) call.
    
    Changes since v1:
    
     * The commit message was reworded to clarify the underlying issue
       better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-982%2Fdscho%2Ffix-duplicated-lines-when-moving-in-pager-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-982/dscho/fix-duplicated-lines-when-moving-in-pager-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/982

Range-diff vs v2:

 1:  82099e53bbc9 ! 1:  fe2ee68de43e pager: do not unnecessarily set COLUMNS on Windows
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    pager: do not unnecessarily set COLUMNS on Windows
     +    pager: avoid setting COLUMNS when we're guessing its value
      
     -    Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
     -    the `COLUMNS` variable over asking ncurses itself.
     +    We query `TIOCGWINSZ` in Git to determine the correct value for
     +    `COLUMNS`, and then set that environment variable.
      
     -    This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
     -    determine the correct value for `COLUMNS`, and then set that environment
     -    variable.
     +    If `TIOCGWINSZ` is not available, we fall back to the hard-coded value
     +    80 _and still_ set the environment variable.
      
     -    However, on Windows it _is_ a problem. The reason is that Git for
     +    On Windows this is a problem. The reason is that Git for
          Windows uses a version of `less` that relies on the MSYS2 runtime to
          interact with the pseudo terminal (typically inside a MinTTY window,
          which is also aware of the MSYS2 runtime). Both MinTTY and `less.exe`
          interact with that pseudo terminal via `ioctl()` calls (which the MSYS2
          runtime emulates even if there is no such thing on Windows).
     +    Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
     +    the `COLUMNS` variable over asking ncurses itself.
      
          But `git.exe` itself is _not_ aware of the MSYS2 runtime, or for that
          matter of that pseudo terminal, and has no way to call `ioctl()` or
     @@ Commit message
          would not actually require Git's help (which actually makes things
          worse here). So let's not override `COLUMNS` on Windows.
      
     -    Note: we do this _only_ on Windows, and _only_ if `TIOCGWINSZ` is not
     -    defined, to reduce any potential undesired fall-out from this patch.
     +    Let's just not set `COLUMNS` unless we managed to query the actual value
     +    from the terminal.
      
          This fixes https://github.com/git-for-windows/git/issues/3235
      
     +    Co-authored-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## pager.c ##
     +@@
     + static struct child_process pager_process = CHILD_PROCESS_INIT;
     + static const char *pager_program;
     + 
     ++/* Is the value coming back from term_columns() just a guess? */
     ++static int term_columns_guessed;
     ++
     ++
     + static void close_pager_fds(void)
     + {
     + 	/* signal EOF to pager */
      @@ pager.c: void setup_pager(void)
     - 	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
     - 	 * to communicate it to any sub-processes.
     - 	 */
     -+#if !defined(WIN32) || defined(TIOCGWINSZ)
       	{
       		char buf[64];
       		xsnprintf(buf, sizeof(buf), "%d", term_columns());
     - 		setenv("COLUMNS", buf, 0);
     +-		setenv("COLUMNS", buf, 0);
     ++		if (!term_columns_guessed)
     ++			setenv("COLUMNS", buf, 0);
       	}
     -+#endif
       
       	setenv("GIT_PAGER_IN_USE", "true", 1);
     +@@ pager.c: int term_columns(void)
     + 		return term_columns_at_startup;
     + 
     + 	term_columns_at_startup = 80;
     ++	term_columns_guessed = 1;
     + 
     + 	col_string = getenv("COLUMNS");
     +-	if (col_string && (n_cols = atoi(col_string)) > 0)
     ++	if (col_string && (n_cols = atoi(col_string)) > 0) {
     + 		term_columns_at_startup = n_cols;
     ++		term_columns_guessed = 0;
     ++	}
     + #ifdef TIOCGWINSZ
     + 	else {
     + 		struct winsize ws;
     +-		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
     ++		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
     + 			term_columns_at_startup = ws.ws_col;
     ++			term_columns_guessed = 0;
     ++		}
     + 	}
     + #endif
       


 pager.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index 3d37dd7adaa2..52f27a6765c8 100644
--- a/pager.c
+++ b/pager.c
@@ -11,6 +11,10 @@
 static struct child_process pager_process = CHILD_PROCESS_INIT;
 static const char *pager_program;
 
+/* Is the value coming back from term_columns() just a guess? */
+static int term_columns_guessed;
+
+
 static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
@@ -114,7 +118,8 @@ void setup_pager(void)
 	{
 		char buf[64];
 		xsnprintf(buf, sizeof(buf), "%d", term_columns());
-		setenv("COLUMNS", buf, 0);
+		if (!term_columns_guessed)
+			setenv("COLUMNS", buf, 0);
 	}
 
 	setenv("GIT_PAGER_IN_USE", "true", 1);
@@ -158,15 +163,20 @@ int term_columns(void)
 		return term_columns_at_startup;
 
 	term_columns_at_startup = 80;
+	term_columns_guessed = 1;
 
 	col_string = getenv("COLUMNS");
-	if (col_string && (n_cols = atoi(col_string)) > 0)
+	if (col_string && (n_cols = atoi(col_string)) > 0) {
 		term_columns_at_startup = n_cols;
+		term_columns_guessed = 0;
+	}
 #ifdef TIOCGWINSZ
 	else {
 		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col)
+		if (!ioctl(1, TIOCGWINSZ, &ws) && ws.ws_col) {
 			term_columns_at_startup = ws.ws_col;
+			term_columns_guessed = 0;
+		}
 	}
 #endif
 

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget

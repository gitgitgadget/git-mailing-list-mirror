Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiCDNMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiCDNMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:12:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0F1B45C0
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:11:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so4978716wma.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=NPEMsN0F3SCoBPcIhcH21JDnWJgXiVPVbr0+v7/Cc9c=;
        b=ZMSUzqEiUPQj4l8OsBfQjeO52JYo/6qANPeEkMUDWH9sOosM2mbkspckkaOcnSwDkd
         fhVmCJk7aOvkfeVCxDpJbksppanWe8TRw8+C1vgaso8NtoEPH9ApnjqhGvxQWiW5+iQx
         p7QKlu8WTKEJWFuhK3rt31Bajy5QocrirYr5tZxl9KT1X1XAqZrK3zr5ko2mxSdZI+JV
         +Mv9rV86ybZANGbDnu9K4JK3xtCgvBJh/KryP4A5Tc7MQwUnaBgccjVByT/C4SeEpqtx
         jslJ5NJln+S5LAUE6maDnX7Bc3UYCjnSvwNwQy87OrV0GJC/iyE72arfJPf8k41EDcWY
         YuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=NPEMsN0F3SCoBPcIhcH21JDnWJgXiVPVbr0+v7/Cc9c=;
        b=4wH7Ajpl5ixBs31ymd0dxcsC3CuMqcWlqWslRa8VbTpR/6cKwW/12qQsvd9eYSaBBb
         LfIKX8y3xL79s9JwL8oWOPo6j6og7lmelcjfih60h8Fd/Hn+O/g2sZ2tuXnF1sFZKcGW
         jcSSpzl2DLi2mKuotmHG7Ff9G0LHpXsgkZ6G58+Icy/qRVBXwnCBRJzGWhrHrHGkR+Mx
         6yF5YTrgUOh/juzo3tTvYa3WxAYyNuzj2+MgK77yeBQyer83OJAoHTV2pfA8zjsbUnq2
         l1zEL73BphjXUK8cLQGocWuvs8yF+JK1/9P9W2apNcmMktaQOhmDlwbOLL0f2JtclotG
         vfSQ==
X-Gm-Message-State: AOAM531LFHUK51otk/0mOjxigGnoaRCcr5wsyuj+HdrQ4+n3RbMQ/dkv
        r1GtaVqUSZSCftl0JYl71x0XDk5kDkI=
X-Google-Smtp-Source: ABdhPJwl3+Ja0/1ddJyabSGmx1O/kWRXVGDZwIdC1lFF1ifae5hVWYXN0EcOEA4nFperA0+LiNO0gw==
X-Received: by 2002:a1c:6a14:0:b0:383:a58c:3635 with SMTP id f20-20020a1c6a14000000b00383a58c3635mr7535416wmc.129.1646399493976;
        Fri, 04 Mar 2022 05:11:33 -0800 (PST)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b001f0494de239sm4634042wrr.21.2022.03.04.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 05:11:33 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/4] terminal: restore settings on SIGTSTP
Date:   Fri,  4 Mar 2022 13:11:26 +0000
Message-Id: <20220304131126.8293-5-phillip.wood123@gmail.com>
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

If the user suspends git while it is waiting for a keypress reset the
terminal before stopping and restore the settings when git resumes. If
the user tries to resume in the background print an error
message (taking care to use async safe functions) before stopping
again. Ideally we would reprint the prompt for the user when git
resumes but this patch just restarts the read().

The signal handler is established with sigaction() rather than using
sigchain_push() as this allows us to control the signal mask when the
handler is invoked and ensure SA_RESTART is used to restart the
read() when resuming.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 124 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 5d516ff546..79ab54c2f8 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "compat/terminal.h"
 #include "sigchain.h"
 #include "strbuf.h"
@@ -23,6 +23,89 @@ static void restore_term_on_signal(int sig)
 static int term_fd = -1;
 static struct termios old_term;
 
+static char *background_resume_msg;
+static char *restore_error_msg;
+static volatile sig_atomic_t ttou_received;
+
+static void write_msg(const char *msg)
+{
+	write_in_full(2, msg, strlen(msg));
+	write_in_full(2, "\n", 1);
+}
+
+static void print_background_resume_msg(int signo)
+{
+	int saved_errno = errno;
+	sigset_t mask;
+	struct sigaction old_sa;
+	struct sigaction sa = { .sa_handler = SIG_DFL };
+
+	ttou_received = 1;
+	write_msg(background_resume_msg);
+	sigaction(signo, &sa, &old_sa);
+	raise(signo);
+	sigemptyset(&mask);
+	sigaddset(&mask, signo);
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+	/* Stopped here */
+	sigprocmask(SIG_BLOCK, &mask, NULL);
+	sigaction(signo, &old_sa, NULL);
+	errno = saved_errno;
+}
+
+static void restore_terminal_on_suspend(int signo)
+{
+	int saved_errno = errno;
+	int res;
+	struct termios t;
+	sigset_t mask;
+	struct sigaction old_sa;
+	struct sigaction sa = { .sa_handler = SIG_DFL };
+	int can_restore = 1;
+
+	if (tcgetattr(term_fd, &t) < 0)
+		can_restore = 0;
+
+	if (tcsetattr(term_fd, TCSAFLUSH, &old_term) < 0)
+		write_msg(restore_error_msg);
+
+	sigaction(signo, &sa, &old_sa);
+	raise(signo);
+	sigemptyset(&mask);
+	sigaddset(&mask, signo);
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+	/* Stopped here */
+	sigprocmask(SIG_BLOCK, &mask, NULL);
+	sigaction(signo, &old_sa, NULL);
+	if (!can_restore) {
+		write_msg(restore_error_msg);
+		goto out;
+	}
+	/*
+	 * If we resume in the background then we receive SIGTTOU when calling
+	 * tcsetattr() below. Set up a handler to print an error message in that
+	 * case.
+	 */
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGTTOU);
+	sa.sa_mask = old_sa.sa_mask;
+	sa.sa_handler = print_background_resume_msg;
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGTTOU, &sa, &old_sa);
+ again:
+	ttou_received = 0;
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+	res = tcsetattr(term_fd, TCSAFLUSH, &t);
+	sigprocmask(SIG_BLOCK, &mask, NULL);
+	if (ttou_received)
+		goto again;
+	else if (res < 0)
+		write_msg(restore_error_msg);
+	sigaction(SIGTTOU, &old_sa, NULL);
+ out:
+	errno = saved_errno;
+}
+
 void restore_term(void)
 {
 	if (term_fd < 0)
@@ -32,10 +115,19 @@ void restore_term(void)
 	close(term_fd);
 	term_fd = -1;
 	sigchain_pop_common();
+	if (restore_error_msg) {
+		signal(SIGTTIN, SIG_DFL);
+		signal(SIGTTOU, SIG_DFL);
+		signal(SIGTSTP, SIG_DFL);
+		FREE_AND_NULL(restore_error_msg);
+		FREE_AND_NULL(background_resume_msg);
+	}
 }
 
 int save_term(unsigned flags)
 {
+	struct sigaction sa;
+
 	if (term_fd < 0)
 		term_fd = (flags & SAVE_TERM_STDIN) ? 0
 						    : open("/dev/tty", O_RDWR);
@@ -44,6 +136,26 @@ int save_term(unsigned flags)
 	if (tcgetattr(term_fd, &old_term) < 0)
 		return -1;
 	sigchain_push_common(restore_term_on_signal);
+	/*
+	 * If job control is disabled then the shell will have set the
+	 * disposition of SIGTSTP to SIG_IGN.
+	 */
+	sigaction(SIGTSTP, NULL, &sa);
+	if (sa.sa_handler == SIG_IGN)
+		return 0;
+
+	/* avoid calling gettext() from signal handler */
+	background_resume_msg = xstrdup(_("error: cannot resume in the background"));
+	restore_error_msg = xstrdup(_("error: cannot restore terminal settings"));
+	sa.sa_handler = restore_terminal_on_suspend;
+	sa.sa_flags = SA_RESTART;
+	sigemptyset(&sa.sa_mask);
+	sigaddset(&sa.sa_mask, SIGTSTP);
+	sigaddset(&sa.sa_mask, SIGTTIN);
+	sigaddset(&sa.sa_mask, SIGTTOU);
+	sigaction(SIGTSTP, &sa, NULL);
+	sigaction(SIGTTIN, &sa, NULL);
+	sigaction(SIGTTOU, &sa, NULL);
 
 	return 0;
 }
@@ -93,6 +205,7 @@ static int getchar_with_timeout(int timeout)
 	fd_set readfds;
 	int res;
 
+ again:
 	if (timeout >= 0) {
 		tv.tv_sec = timeout / 1000;
 		tv.tv_usec = (timeout % 1000) * 1000;
@@ -102,9 +215,12 @@ static int getchar_with_timeout(int timeout)
 	FD_ZERO(&readfds);
 	FD_SET(0, &readfds);
 	res = select(1, &readfds, NULL, NULL, tvp);
-	if (res < 0)
-		return EOF;
-
+	if (res < 0) {
+		if (errno == EINTR)
+			goto again;
+		else
+			return EOF;
+	}
 	return getchar();
 }
 
-- 
2.35.1


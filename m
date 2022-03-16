Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E6BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357799AbiCPSza (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbiCPSz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:55:29 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFF205E7
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r7so1885930wmq.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=F30XXhDXHyDc4Ipmeo3rsVg/3tmU2oUm1LSwOj36GqY=;
        b=p5Y+rPM6Mxls5MRatpNo9uUmjUQ8f3DKdGjLfWuFuoqtqsFQhpfhEBnSyZVvENeRs4
         DH7mWdOL8DtMHD2J6/gSWaL+3HBqQDRNg4CipUuh65H6nfucLE+2TICJimv3AFef3+at
         7R+ukOQi7r8SoKPpoymCoNBPpVj+VxJd4HOjZROjMKJVOfztXu4fsXJJwrxYQtMfWSYm
         CmzSkLapggKwqV59pf9eov02FTmIXNVpAMvVekyeuiiVAPp+ebt22Af+xNgNbU+GkBOg
         01vikwA30Xom7leO0tbREfXHlSfWWDj1LNLHFFgg2BatXDTbk5U8XRB0qh6014Vv78wX
         eh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=F30XXhDXHyDc4Ipmeo3rsVg/3tmU2oUm1LSwOj36GqY=;
        b=nAfnKHUQUuIiBwJwo7OzB1tV+iWpanxKpcyh/qGP4FzygvMFiRJkb0v2tJBc4CfHqW
         7HX8+Z2TFIBJjwJ/dOp0NrUDr8ktfSqZU3MlzB5dC6Qb6+E/XaPcWSX3YqxEfnFxS2HM
         QAZ275aoo7+wNfIiZNi4n1kgmq+H7rKZ/z9HZlyZGYrfegYAYMzZvAprZqNTKMiXxcF8
         QsZzYi3eehJR/HI4hoYLNIRO0dMLy+HauFxm3VM2o9fSs3JlqwstfBo6uYFi5SzYvvDc
         75biCwT9OFa1KzLTf8cAB12gJbvv3jjJiAn593pX4sSGiyk15OJ2s9yVpGSu8W+ZmVnw
         s94w==
X-Gm-Message-State: AOAM5322zXs2ROHsvAp4l3vq3zJvW8/DA6xefDsbDDw/BmmYlIlHtnED
        6Dq+g9Z16qMh4XAZ3km26ymkCyNGLxQgBw==
X-Google-Smtp-Source: ABdhPJwyVj6laWYaUsEV2G+cugAORu+Yz/sOJNMW26G1I5Ut7ozu4zcVeFklEvtuBnHzxKTcw5z7+g==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id p17-20020a05600c065100b003813d7b40e0mr8490141wmm.17.1647456852041;
        Wed, 16 Mar 2022 11:54:12 -0700 (PDT)
Received: from localhost.localdomain (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm2409144wrw.91.2022.03.16.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 11:54:11 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 0/4] builtin add -p: hopefully final readkey fixes
Date:   Wed, 16 Mar 2022 18:54:01 +0000
Message-Id: <20220316185405.29551-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304131126.8293-1-phillip.wood123@gmail.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thank to Junio for his comments on V3.
Changes since V3:
 * Patch 2
   - only close tty_fd if it is open and SAVE_TERM_STDIN was not
     requested
   - close tty_fd in save_term() if there is an error.
   - folded long line
 * Patch 4
   - add a comment explaining the purpose of write_err()

There's an updated conflict resolution after the range-diff at the end
of this message.

V3 Cover Letter:

Thanks to Ævar, Carlo and Dscho for their comments on V2.
Changes since V2:
 * Patch 1
   - fix save_term() prototype (thanks to Carlo)
 * Patch 2
   - avoid closing tty_fd if it is stdin
 * Patch 3
   - removed redundant #include (thanks to Ævar)
   - handle select() timeout correctly
 * Patch 4
   - reset job signals if settcattr() fails

These patches are based on a merge of pw/single-key-interactive and
master. There are a couple of simple textual conflicts with
'cb/save-term-across-editor-invocation' and unfortunately some
semantic conflicts as well. A diff on top of the textual resolution
which handles the semantic conflicts is given after the range-diff at
the end of this message.

V2 Cover Letter:

Thanks to Ramsay and Ævar for their comments on V1.
Changes since V1:
 * Patch 1
   - use an enum for save_term()'s flags (suggested by Ævar)
   - fixed argument order in the windows code (thanks to Ramsay)
 * Patch 2
   - fixed a typo in a comment (thanks to Ramsay)
 * Patch 4
   - stopped duplicating the strings returned by gettext() (suggested by
     Ævar)
   - reworked error message handling in the signal handler to add an
     "error: " prefix (suggested by Ævar)
   - tweaked the background resume error message

V1 Cover Letter:

Fix the remaining issues that I'm aware of when using the built in
"add -p" with interactive.singlekey that are stopping it from being
merged to master. The first three patches make sure that we call
tcsetattr() and the same file descriptor that we use for read() and
work around poll() being broken when reading from terminals on
macos. The final patch is more of an improvement rather than a bug fix
(the same issue already exists in the perl version) and could proceed
separately.

Unfortunately these patches conflict with
'cb/save-term-across-editor-invocation' as well as the textual
conflicts there is a semantic conflict as the argument to save_term()
is changed so the code in editor.c will need updating.

These patches are based on 'pw/single-key-interactive'


Phillip Wood (4):
  terminal: use flags for save_term()
  terminal: don't assume stdin is /dev/tty
  terminal: work around macos poll() bug
  terminal: restore settings on SIGTSTP

 compat/terminal.c | 238 +++++++++++++++++++++++++++++++++++++++-------
 compat/terminal.h |   9 +-
 2 files changed, 211 insertions(+), 36 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  2c4c5424d7 terminal: use flags for save_term()
1:  cf9275c40c ! 2:  405a69852f terminal: don't assume stdin is /dev/tty
    @@ Commit message
     
      ## compat/terminal.c ##
     @@ compat/terminal.c: static void restore_term_on_signal(int sig)
    + #define INPUT_PATH "/dev/tty"
    + #define OUTPUT_PATH "/dev/tty"
    + 
    ++static volatile sig_atomic_t term_fd_needs_closing;
      static int term_fd = -1;
      static struct termios old_term;
      
     +static void close_term_fd(void)
     +{
    -+	if (term_fd)
    ++	if (term_fd_needs_closing)
     +		close(term_fd);
    ++	term_fd_needs_closing = 0;
     +	term_fd = -1;
     +}
     +
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
      {
      	if (term_fd < 0)
     -		term_fd = open("/dev/tty", O_RDWR);
    -+		term_fd = (flags & SAVE_TERM_STDIN) ? 0
    -+						    : open("/dev/tty", O_RDWR);
    ++		term_fd = ((flags & SAVE_TERM_STDIN)
    ++			   ? 0
    ++			   : open("/dev/tty", O_RDWR));
      	if (term_fd < 0)
      		return -1;
    - 	if (tcgetattr(term_fd, &old_term) < 0)
    +-	if (tcgetattr(term_fd, &old_term) < 0)
    ++	term_fd_needs_closing = !(flags & SAVE_TERM_STDIN);
    ++	if (tcgetattr(term_fd, &old_term) < 0) {
    ++		close_term_fd();
    + 		return -1;
    ++	}
    + 	sigchain_push_common(restore_term_on_signal);
    + 
    + 	return 0;
     @@ compat/terminal.c: static int disable_bits(enum save_term_flags flags, tcflag_t bits)
    + 	struct termios t;
    + 
    + 	if (save_term(flags) < 0)
    +-		goto error;
    ++		return -1;
    + 
    + 	t = old_term;
    + 
    +@@ compat/terminal.c: static int disable_bits(enum save_term_flags flags, tcflag_t bits)
    + 		return 0;
      
      	sigchain_pop_common();
    - error:
    +-error:
     -	close(term_fd);
     -	term_fd = -1;
     +	close_term_fd();
2:  4828d63ce5 = 3:  70bc6e9c06 terminal: work around macos poll() bug
3:  3185bc5223 ! 4:  f38d162f75 terminal: restore settings on SIGTSTP
    @@ compat/terminal.c
      #include "compat/terminal.h"
      #include "sigchain.h"
      #include "strbuf.h"
    -@@ compat/terminal.c: static void restore_term_on_signal(int sig)
    +@@ compat/terminal.c: static volatile sig_atomic_t term_fd_needs_closing;
      static int term_fd = -1;
      static struct termios old_term;
      
     +static const char *background_resume_msg;
     +static const char *restore_error_msg;
     +static volatile sig_atomic_t ttou_received;
     +
    ++/* async safe error function for use by signal handlers. */
     +static void write_err(const char *msg)
     +{
     +	write_in_full(2, "error: ", strlen("error: "));
    @@ compat/terminal.c: static void restore_term_on_signal(int sig)
     +
      static void close_term_fd(void)
      {
    - 	if (term_fd)
    + 	if (term_fd_needs_closing)
     @@ compat/terminal.c: void restore_term(void)
      	tcsetattr(term_fd, TCSAFLUSH, &old_term);
      	close_term_fd();
    @@ compat/terminal.c: void restore_term(void)
     +	struct sigaction sa;
     +
      	if (term_fd < 0)
    - 		term_fd = (flags & SAVE_TERM_STDIN) ? 0
    - 						    : open("/dev/tty", O_RDWR);
    + 		term_fd = ((flags & SAVE_TERM_STDIN)
    + 			   ? 0
     @@ compat/terminal.c: int save_term(enum save_term_flags flags)
    - 	if (tcgetattr(term_fd, &old_term) < 0)
      		return -1;
    + 	}
      	sigchain_push_common(restore_term_on_signal);
     +	/*
     +	 * If job control is disabled then the shell will have set the
    @@ compat/terminal.c: static int disable_bits(enum save_term_flags flags, tcflag_t
      
      	sigchain_pop_common();
     +	reset_job_signals();
    - error:
      	close_term_fd();
      	return -1;
    + }
     @@ compat/terminal.c: static int getchar_with_timeout(int timeout)
      	fd_set readfds;
      	int res;

Conflict Resolution:
diff --cc compat/terminal.c
index 7db330c52d,8743df6c9a..1bfa92584a
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@@ -134,47 -29,31 +134,56 @@@ void restore_term(void
  		return;

  	tcsetattr(term_fd, TCSAFLUSH, &old_term);
 -
 -	close(term_fd);
 -	term_fd = -1;
 +	close_term_fd();
  	sigchain_pop_common();
 +	reset_job_signals();
  }

+ static int is_controlling_terminal(int fd)
+ {
+ 	return (getpgid(0) == tcgetpgrp(fd));
+ }
+
 -int save_term(int full_duplex)
 +int save_term(enum save_term_flags flags)
  {
 +	struct sigaction sa;
 +
  	if (term_fd < 0)
 -		term_fd = open("/dev/tty", O_RDWR);
 +		term_fd = ((flags & SAVE_TERM_STDIN)
 +			   ? 0
 +			   : open("/dev/tty", O_RDWR));
  	if (term_fd < 0)
  		return -1;
 -	if (full_duplex && !is_controlling_terminal(term_fd)) {
 -		close(term_fd);
 -		term_fd = -1;
 +	term_fd_needs_closing = !(flags & SAVE_TERM_STDIN);
++	if ((flags & SAVE_TERM_DUPLEX) && !is_controlling_terminal(term_fd)) {
++		close_term_fd();
+ 		return -1;
+ 	}
 -	if (tcgetattr(term_fd, &old_term) < 0)
 +	if (tcgetattr(term_fd, &old_term) < 0) {
 +		close_term_fd();
  		return -1;
 +	}
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
 +	background_resume_msg = _("cannot resume in the background, please use 'fg' to resume");
 +	restore_error_msg = _("cannot restore terminal settings");
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
diff --cc editor.c
index 8b9648281d,6c5c95e6a2..192d6ea75d
--- a/editor.c
+++ b/editor.c
@@@ -48,6 -49,16 +49,16 @@@ const char *git_sequence_editor(void
  	return editor;
  }

+ static int prepare_term(const char *editor)
+ {
+ 	int need_saverestore = !strcmp(editor, DEFAULT_EDITOR);
+
+ 	git_config_get_bool("editor.stty", &need_saverestore);
+ 	if (need_saverestore)
 -		return save_term(1);
++		return save_term(SAVE_TERM_DUPLEX);
+ 	return 0;
+ }
+
  static int launch_specified_editor(const char *editor, const char *path,
  				   struct strbuf *buffer, const char *const *env)
  {
-- 
2.35.1


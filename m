Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1880DC433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiCEODG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiCEODF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 09:03:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B4D580CD
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:02:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o1so13083394edc.3
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=enVzkIPO361F00Yz8I+oL9yM0rGtGL0ikvLIhrC+s08=;
        b=pZACBGQqOqiItPsLa4Q9FPCE+ps7XQDqK9QysPIl128P5zhqkgvE1/kZsXcR+JAHrf
         d00jEobH1D2Tu3czVHIiupJRekU0+lIbykBWVISFg2pPaI67GJld2DKVDd7p7g+m1UWZ
         ubz8SK7s1jF7VfMObYJlUlVX8Awgxg4oYRymsXovLpSB8uNv+D94C4aj6S/EcTYH00qF
         j88J22Eu0sGQM275HezHqhc5rMIgDpAuYooONEMm3o7rTsdaSaccvZw3QHe6yfWM2ET2
         lqzcigATs3MjvJ8NK47jQFrBnxHmLCbkZTyMs16V3aF64iqgUZHp/aFW7S1EN3QLvWY7
         6E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=enVzkIPO361F00Yz8I+oL9yM0rGtGL0ikvLIhrC+s08=;
        b=OTUNcsDJ3u6fzhGOGvqGdM09l78yzCEsy/0R1LZiFpmyjQ5gOSDqfLjw5v4tMMxXJZ
         PsQv7vOCmWUmCsGbe4GQ5VU17kLJgcF7VpvsMaGnX4RcpdLrZFB5kuAohX1NZznQ/czM
         cJlrwIsvMj87nL1bEH/AdRzC7XcGwewr6sDkouoTvD+wsXvWaY864DnTPlq6rmZr0Qxa
         OPMlZIaRUPKZZgEnqXbj16jOiFP+roRn1VGItm2D2ZZt3fJYGJgGe0IDd03kA7S39rbJ
         vcNhLurORMLChrBhviBZbTPA48N33ZJ5CHWO7RN3ZJVjtcAg4vy8PaptHJa/vjuwDP73
         r34g==
X-Gm-Message-State: AOAM533+hYb2iAO1+zCCu1vmp6+OrtL2epwI+LIJikyyE8FuEgrXiiup
        rj/c6Men2+nw5A4sA3xNoaI=
X-Google-Smtp-Source: ABdhPJx0uRtJ4x1yDOhBKM7T1h5ECltmsF4azKynIbeOXUOhhxfJ49oUhcimIWFwGgD5aU6BcdAB4w==
X-Received: by 2002:a05:6402:492:b0:404:c4bf:8b7e with SMTP id k18-20020a056402049200b00404c4bf8b7emr3031170edv.318.1646488933273;
        Sat, 05 Mar 2022 06:02:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709066b9400b006dabdbc8350sm1634770ejr.30.2022.03.05.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 06:02:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQUz5-000WI1-V7;
        Sat, 05 Mar 2022 15:02:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] terminal: restore settings on SIGTSTP
Date:   Sat, 05 Mar 2022 14:59:33 +0100
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-5-phillip.wood123@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220304131126.8293-5-phillip.wood123@gmail.com>
Message-ID: <220305.86bkyk4hwc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 04 2022, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the user suspends git while it is waiting for a keypress reset the
> terminal before stopping and restore the settings when git resumes. If
> the user tries to resume in the background print an error
> message (taking care to use async safe functions) before stopping
> again. Ideally we would reprint the prompt for the user when git
> resumes but this patch just restarts the read().
>
> The signal handler is established with sigaction() rather than using
> sigchain_push() as this allows us to control the signal mask when the
> handler is invoked and ensure SA_RESTART is used to restart the
> read() when resuming.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  compat/terminal.c | 124 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 120 insertions(+), 4 deletions(-)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 5d516ff546..79ab54c2f8 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -1,4 +1,4 @@
> -#include "git-compat-util.h"
> +#include "cache.h"
>  #include "compat/terminal.h"
>  #include "sigchain.h"
>  #include "strbuf.h"
> @@ -23,6 +23,89 @@ static void restore_term_on_signal(int sig)
>  static int term_fd = -1;
>  static struct termios old_term;
>  
> +static char *background_resume_msg;
> +static char *restore_error_msg;
> +static volatile sig_atomic_t ttou_received;
> +
> +static void write_msg(const char *msg)
> +{
> +	write_in_full(2, msg, strlen(msg));
> +	write_in_full(2, "\n", 1);
> +}
> +
> +static void print_background_resume_msg(int signo)
> +{
> +	int saved_errno = errno;
> +	sigset_t mask;
> +	struct sigaction old_sa;
> +	struct sigaction sa = { .sa_handler = SIG_DFL };
> +
> +	ttou_received = 1;
> +	write_msg(background_resume_msg);
> +	sigaction(signo, &sa, &old_sa);
> +	raise(signo);
> +	sigemptyset(&mask);
> +	sigaddset(&mask, signo);
> +	sigprocmask(SIG_UNBLOCK, &mask, NULL);
> +	/* Stopped here */
> +	sigprocmask(SIG_BLOCK, &mask, NULL);
> +	sigaction(signo, &old_sa, NULL);
> +	errno = saved_errno;
> +}
> +
> +static void restore_terminal_on_suspend(int signo)
> +{
> +	int saved_errno = errno;
> +	int res;
> +	struct termios t;
> +	sigset_t mask;
> +	struct sigaction old_sa;
> +	struct sigaction sa = { .sa_handler = SIG_DFL };
> +	int can_restore = 1;
> +
> +	if (tcgetattr(term_fd, &t) < 0)
> +		can_restore = 0;
> +
> +	if (tcsetattr(term_fd, TCSAFLUSH, &old_term) < 0)
> +		write_msg(restore_error_msg);
> +
> +	sigaction(signo, &sa, &old_sa);
> +	raise(signo);
> +	sigemptyset(&mask);
> +	sigaddset(&mask, signo);
> +	sigprocmask(SIG_UNBLOCK, &mask, NULL);
> +	/* Stopped here */
> +	sigprocmask(SIG_BLOCK, &mask, NULL);
> +	sigaction(signo, &old_sa, NULL);
> +	if (!can_restore) {
> +		write_msg(restore_error_msg);
> +		goto out;
> +	}
> +	/*
> +	 * If we resume in the background then we receive SIGTTOU when calling
> +	 * tcsetattr() below. Set up a handler to print an error message in that
> +	 * case.
> +	 */
> +	sigemptyset(&mask);
> +	sigaddset(&mask, SIGTTOU);
> +	sa.sa_mask = old_sa.sa_mask;
> +	sa.sa_handler = print_background_resume_msg;
> +	sa.sa_flags = SA_RESTART;
> +	sigaction(SIGTTOU, &sa, &old_sa);
> + again:
> +	ttou_received = 0;
> +	sigprocmask(SIG_UNBLOCK, &mask, NULL);
> +	res = tcsetattr(term_fd, TCSAFLUSH, &t);
> +	sigprocmask(SIG_BLOCK, &mask, NULL);
> +	if (ttou_received)
> +		goto again;
> +	else if (res < 0)
> +		write_msg(restore_error_msg);
> +	sigaction(SIGTTOU, &old_sa, NULL);
> + out:
> +	errno = saved_errno;
> +}
> +
>  void restore_term(void)
>  {
>  	if (term_fd < 0)
> @@ -32,10 +115,19 @@ void restore_term(void)
>  	close(term_fd);
>  	term_fd = -1;
>  	sigchain_pop_common();
> +	if (restore_error_msg) {
> +		signal(SIGTTIN, SIG_DFL);
> +		signal(SIGTTOU, SIG_DFL);
> +		signal(SIGTSTP, SIG_DFL);
> +		FREE_AND_NULL(restore_error_msg);
> +		FREE_AND_NULL(background_resume_msg);
> +	}
>  }
>  
>  int save_term(unsigned flags)
>  {
> +	struct sigaction sa;
> +
>  	if (term_fd < 0)
>  		term_fd = (flags & SAVE_TERM_STDIN) ? 0
>  						    : open("/dev/tty", O_RDWR);
> @@ -44,6 +136,26 @@ int save_term(unsigned flags)
>  	if (tcgetattr(term_fd, &old_term) < 0)
>  		return -1;
>  	sigchain_push_common(restore_term_on_signal);
> +	/*
> +	 * If job control is disabled then the shell will have set the
> +	 * disposition of SIGTSTP to SIG_IGN.
> +	 */
> +	sigaction(SIGTSTP, NULL, &sa);
> +	if (sa.sa_handler == SIG_IGN)
> +		return 0;
> +
> +	/* avoid calling gettext() from signal handler */
> +	background_resume_msg = xstrdup(_("error: cannot resume in the background"));
> +	restore_error_msg = xstrdup(_("error: cannot restore terminal settings"));

You don't need to xstrdup() the return values of gettext() (here _()),
you'll get a pointer to static storage that's safe to hold on to for the
duration of the program.

In this case I think it would make sense to skip "error: " from the
message itself.

Eventually we'll get to making usage.c have that prefix translated, and
can have some utility function exposed there (I have WIP patches for
this already since a while ago).

To translators it'll look like the same thing, and avoid churn when we
make the "error: " prefix translatable.

Aside: If you do keep the xstrdup() (perhaps an xstrfmt() with the above
advice...) doesn't it make sense to add the "\n" here, so you'll have
one write_in_full() above?

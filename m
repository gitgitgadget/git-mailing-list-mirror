Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B479620960
	for <e@80x24.org>; Thu, 13 Apr 2017 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbdDMXhO (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 19:37:14 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36087 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752365AbdDMXhM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 19:37:12 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so36769342pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qo0fmncqMYOS9ICU937TkZBza+pIHt5j9SAPC0I4YLU=;
        b=gZGXGOvlj/GM81QTngQcOR0Bjmq2ilz7qJ94VecjE762ZM6OZvTmCUveJizA6gujZV
         +DH+Ao/VKVVOXF83IALxS7jW4pFH9qtL6PmZJiVYyB1h0cuM9RvCip+6CP5DuEX6mLoo
         I5+MRXraV0B37Fj4YBixoC8HLrFs7CMNzmxAo8wsn3mUI4XOrHiywtqtkEBaZli43AWC
         XlMp250ZVg/inggj19esWefx12ixadxWbnMa/MRE8M4ATO7kBbEUhbarW45NcB+jBgip
         LA1whxKRFmdD/aQY87X57YMuN9pAidn2xdeWu/508krFiUjU/7p12kBizWIdAgggxgRI
         RKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qo0fmncqMYOS9ICU937TkZBza+pIHt5j9SAPC0I4YLU=;
        b=KKjwF47tePLLKBiaEn4XZszkv+cjZNivl8Jlmi5P1RGyotA2ASYkHddDbrZAqEahHi
         Hn3cOX8G1oI+pS7H+vRX96nyH2fMI2KUDPYLeB2fH07L4U9KoUhDRdi8Ol3pomKXTRgP
         UJXA6d+sy5f02U06pCr5izbzzY9+JUMtBz7MrbVqqROssncD9YNnQQu37xkHespUUnWV
         NmkAg3xJO5OOCOa3fcJ6t8maNd0Pf3C7tqm7REWUtkOYispNTlPVj375eO0WzQuq+Flm
         27Xpk9W0htWcD2vbmKXXw3HsS8jP2DXCsdfd2EsoqLfAvIYngMOEnxpj1tgSVl6Uyoq1
         IzUQ==
X-Gm-Message-State: AN3rC/4Gg70S/ay6p+TK+w5sJDqtfrjzk3+pmRu1y5wWvDrQI/OlN6PJ
        c9aR1J8lA/pMUDQL
X-Received: by 10.99.3.18 with SMTP id 18mr126646pgd.105.1492126631029;
        Thu, 13 Apr 2017 16:37:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id 66sm179561pfd.45.2017.04.13.16.37.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 16:37:10 -0700 (PDT)
Date:   Thu, 13 Apr 2017 16:37:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 7/6] run-command: block signals between fork and execve
Message-ID: <20170413233708.GA13936@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413211428.GA5961@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413211428.GA5961@whir>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Eric Wong wrote:
> Brandon Williams <bmwill@google.com> wrote:
> > v2 does a bit of restructuring based on comments from reviewers.  I took the
> > patch by Eric and broke it up and tweaked it a bit to flow better with v2.  I
> > left out the part of Eric's patch which did signal manipulation as I wasn't
> > experienced enough to know what it was doing or why it was necessary.  Though I
> > believe the code is structured in such a way that Eric could make another patch
> > on top of this series with just the signal changes.
> 
> Yeah, I think a separate commit message might be necessary to
> explain the signal changes.

Perfect!  I'll carry the changes along in the reroll.

> 
> -------8<-----
> Subject: [PATCH] run-command: block signals between fork and execve
> 
> Signal handlers of the parent firing in the forked child may
> have unintended side effects.  Rather than auditing every signal
> handler we have and will ever have, block signals while forking
> and restore default signal handlers in the child before execve.
> 
> Restoring default signal handlers is required because
> execve does not unblock signals, it only restores default
> signal handlers.  So we must restore them with sigprocmask
> before execve, leaving a window when signal handlers
> we control can fire in the child.  Continue ignoring
> ignored signals, but reset the rest to defaults.
> 
> Similarly, disable pthread cancellation to future-proof our code
> in case we start using cancellation; as cancellation is
> implemented with signals in glibc.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>   Changes from my original in <20170411070534.GA10552@whir>:
> 
>   - fixed typo in NO_PTHREADS code
> 
>   - dropped fflush(NULL) before fork, consider us screwed anyways
>     if the child uses stdio
> 
>   - respect SIG_IGN in child; that seems to be the prevailing
>     wisdom from reading https://ewontfix.com/7/ and process.c
>     in ruby (git clone https://github.com/ruby/ruby.git)
> 
>  run-command.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/run-command.c b/run-command.c
> index 1c36e692d..59a8b4806 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -213,6 +213,7 @@ static int child_notifier = -1;
>  
>  enum child_errcode {
>  	CHILD_ERR_CHDIR,
> +	CHILD_ERR_SIGPROCMASK,
>  	CHILD_ERR_ENOENT,
>  	CHILD_ERR_SILENT,
>  	CHILD_ERR_ERRNO,
> @@ -277,6 +278,8 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
>  		error_errno("exec '%s': cd to '%s' failed",
>  			    cmd->argv[0], cmd->dir);
>  		break;
> +	case CHILD_ERR_SIGPROCMASK:
> +		error_errno("sigprocmask failed restoring signals");
>  	case CHILD_ERR_ENOENT:
>  		error_errno("cannot run %s", cmd->argv[0]);
>  		break;
> @@ -388,6 +391,53 @@ static char **prep_childenv(const char *const *deltaenv)
>  }
>  #endif
>  
> +struct atfork_state {
> +#ifndef NO_PTHREADS
> +	int cs;
> +#endif
> +	sigset_t old;
> +};
> +
> +#ifndef NO_PTHREADS
> +static void bug_die(int err, const char *msg)
> +{
> +	if (err) {
> +		errno = err;
> +		die_errno("BUG: %s", msg);
> +	}
> +}
> +#endif
> +
> +static void atfork_prepare(struct atfork_state *as)
> +{
> +	sigset_t all;
> +
> +	if (sigfillset(&all))
> +		die_errno("sigfillset");
> +#ifdef NO_PTHREADS
> +	if (sigprocmask(SIG_SETMASK, &all, &as->old))
> +		die_errno("sigprocmask");
> +#else
> +	bug_die(pthread_sigmask(SIG_SETMASK, &all, &as->old),
> +		"blocking all signals");
> +	bug_die(pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &as->cs),
> +		"disabling cancellation");
> +#endif
> +}
> +
> +static void atfork_parent(struct atfork_state *as)
> +{
> +#ifdef NO_PTHREADS
> +	if (sigprocmask(SIG_SETMASK, &as->old, NULL))
> +		die_errno("sigprocmask");
> +#else
> +	bug_die(pthread_setcancelstate(as->cs, NULL),
> +		"re-enabling cancellation");
> +	bug_die(pthread_sigmask(SIG_SETMASK, &as->old, NULL),
> +		"restoring signal mask");
> +#endif
> +}
> +
>  static inline void set_cloexec(int fd)
>  {
>  	int flags = fcntl(fd, F_GETFD);
> @@ -511,6 +561,7 @@ int start_command(struct child_process *cmd)
>  	char **childenv;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
>  	struct child_err cerr;
> +	struct atfork_state as;
>  
>  	if (pipe(notify_pipe))
>  		notify_pipe[0] = notify_pipe[1] = -1;
> @@ -524,6 +575,7 @@ int start_command(struct child_process *cmd)
>  
>  	prepare_cmd(&argv, cmd);
>  	childenv = prep_childenv(cmd->env);
> +	atfork_prepare(&as);
>  
>  	/*
>  	 * NOTE: In order to prevent deadlocking when using threads special
> @@ -537,6 +589,7 @@ int start_command(struct child_process *cmd)
>  	cmd->pid = fork();
>  	failed_errno = errno;
>  	if (!cmd->pid) {
> +		int sig;
>  		/*
>  		 * Ensure the default die/error/warn routines do not get
>  		 * called, they can take stdio locks and malloc.
> @@ -584,6 +637,21 @@ int start_command(struct child_process *cmd)
>  		if (cmd->dir && chdir(cmd->dir))
>  			child_die(CHILD_ERR_CHDIR);
>  
> +		/*
> +		 * restore default signal handlers here, in case
> +		 * we catch a signal right before execve below
> +		 */
> +		for (sig = 1; sig < NSIG; sig++) {
> +			sighandler_t old = signal(sig, SIG_DFL);
> +
> +			/* ignored signals get reset to SIG_DFL on execve */
> +			if (old == SIG_IGN)
> +				signal(sig, SIG_IGN);
> +		}
> +
> +		if (sigprocmask(SIG_SETMASK, &as.old, NULL) != 0)
> +			child_die(CHILD_ERR_SIGPROCMASK);
> +
>  		execve(argv.argv[0], (char *const *) argv.argv,
>  		       (char *const *) childenv);
>  
> @@ -595,6 +663,7 @@ int start_command(struct child_process *cmd)
>  			child_die(CHILD_ERR_ERRNO);
>  		}
>  	}
> +	atfork_parent(&as);
>  	if (cmd->pid < 0)
>  		error_errno("cannot fork() for %s", cmd->argv[0]);
>  	else if (cmd->clean_on_exit)
> -- 
> EW

-- 
Brandon Williams

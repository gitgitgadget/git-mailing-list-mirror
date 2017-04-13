Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87FE920960
	for <e@80x24.org>; Thu, 13 Apr 2017 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdDMVOw (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 17:14:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34945 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdDMVOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 17:14:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id g2so13592589pge.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o3Q8/FXs7QWkwHhqFuzmu4kaya0njCK93zfDCbYjogw=;
        b=Of1GjpsfIDwqizDlUignFePhdVCYXZR12pLzA/u1tv1YePsPWzJRhViIyE6SQMEzsn
         /5GEv1NP+tuY6NLgrf8ATioLu4sf4mfjwBxhJStAtyGJjCx/oaZu6fbvJmSujA2tf4Mu
         zYRKWxfRoqASl5F5TgpTSlxdfW2NoBsw46eGOKVGLml2z0rTrRjLaoiUH14KMiSPCjnF
         SS+klf/SvM/DLlAtQglkARI4l+W03958CTFf+Wy1J2K9FsKaRbxkyi+ZjmdSs99tj4hz
         HVUz3A8nrtI6YspzdJC2cjJbg5guUt26EVDCzzKS4HfMwbvHxCxp9efdQzCpUzDiyIgw
         6/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o3Q8/FXs7QWkwHhqFuzmu4kaya0njCK93zfDCbYjogw=;
        b=AmM9J5uY1sPX1gY9FWzLLpO/i6HyqlmiadeUG9gVkRYoVWTC3wJ4GqGeYH64P9c5uu
         ukOMUBBejfjKVWG5YLe52p8mIrOGq0qtwYE/bg8UaT6UgpVqnaFyIhcfJnwxL5FO5YCW
         dIMkCFf8i7Ki29JRSWK9xXGAhKHCu4qlA9T9Oub89kLmyENypsu7HVgtkymjXfKNjWNs
         MnGJYau0iGTTMNwDF2AkdZk1uLDzk2TvwuTQu3Fs15LXGrP9X70leUEoklINaPUQNRX7
         bKnqt1YY7ALrP6gktRUpl5I5KHXDBZY7I9uTT66QADRJexxPBQpJqaD15lJOu01o2wdh
         Puyg==
X-Gm-Message-State: AN3rC/7QJ9bFSteKa9/MvXrqIzvXu2cebg8jqe0nB8lOKrlVJn2Cx4OQ
        Jp/8/VcSoObGLw==
X-Received: by 10.84.176.100 with SMTP id u91mr5392137plb.39.1492118089793;
        Thu, 13 Apr 2017 14:14:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:40ae:ac27:c1a2:6a87])
        by smtp.gmail.com with ESMTPSA id r7sm19531026pgn.26.2017.04.13.14.14.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 14:14:49 -0700 (PDT)
Date:   Thu, 13 Apr 2017 14:14:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH v2 2/6] run-command: prepare command before forking
Message-ID: <20170413211447.GC10084@aiede.mtv.corp.google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413183252.4713-3-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> In order to avoid allocation between 'fork()' and 'exec()' the argv
> array used in the exec call is prepared prior to forking the process.

nit: s/(the argv array.*) is prepared/prepare \1/

Git's commit messages are in the imperative mood, as if they are
ordering the code or the computer to do something.

More importantly, the commit message is a good place to explain some
of the motivation behind the patch so that people can understand what
the patch is for by reading it without having to dig into mailing list
archives and get the discussion there.

E.g. this could say

- that grep tests are intermittently failing in configurations using
  some versions of tcmalloc

- that the cause is interaction between fork and threads: malloc holds
  a lock that those versions of tcmalloc doesn't release in a
  pthread_atfork handler

- that according to [1] we need to only call async-signal-safe
  operations between fork and exec.  Using malloc to build the argv
  array isn't async-signal-safe

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/fork.html

> In addition to this, the function used to exec is changed from
> 'execvp()' to 'execv()' as the (p) variant of exec has the potential to
> call malloc during the path resolution it performs.

*puzzled* is execvp actually allowed to call malloc?

Could this part go in a separate patch?  That would make it easier to
review.

[...]
> +++ b/run-command.c
[...]
> +	/*
> +	 * If there are no '/' characters in the command then perform a path
> +	 * lookup and use the resolved path as the command to exec.  If there
> +	 * are no '/' characters or if the command wasn't found in the path,
> +	 * have exec attempt to invoke the command directly.
> +	 */
> +	if (!strchr(out->argv[0], '/')) {
> +		char *program = locate_in_PATH(out->argv[0]);
> +		if (program) {
> +			free((char *)out->argv[0]);
> +			out->argv[0] = program;
> +		}
> +	}

This does one half of what execvp does but leaves out the other half.
http://pubs.opengroup.org/onlinepubs/009695399/functions/exec.html
explains:

  There are two distinct ways in which the contents of the process
  image file may cause the execution to fail, distinguished by the
  setting of errno to either [ENOEXEC] or [EINVAL] (see the ERRORS
  section). In the cases where the other members of the exec family of
  functions would fail and set errno to [ENOEXEC], the execlp() and
  execvp() functions shall execute a command interpreter and the
  environment of the executed command shall be as if the process
  invoked the sh utility using execl() as follows:

  execl(<shell path>, arg0, file, arg1, ..., (char *)0);

I think this is what the first patch in the series was about.  Do we
want to drop that support?

I think we need to keep it, since it is easy for authors of e.g.
credential helpers to accidentally rely on it.

[...]
> @@ -437,12 +458,9 @@ int start_command(struct child_process *cmd)
>  					unsetenv(*cmd->env);
>  			}
>  		}
> -		if (cmd->git_cmd)
> -			execv_git_cmd(cmd->argv);
> -		else if (cmd->use_shell)
> -			execv_shell_cmd(cmd->argv);
> -		else
> -			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
> +
> +		execv(argv.argv[0], (char *const *) argv.argv);

What happens in the case sane_execvp was trying to handle?  Does
prepare_cmd need error handling for when the command isn't found?

Sorry this got so fussy.

Thanks and hope that helps,
Jonathan

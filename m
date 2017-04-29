Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF1B207E4
	for <e@80x24.org>; Sat, 29 Apr 2017 00:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423987AbdD2A2R (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 20:28:17 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33700 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164617AbdD2A2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 20:28:15 -0400
Received: by mail-pf0-f175.google.com with SMTP id q20so1460282pfg.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ls7T8/4IFgmrEAJ3HQnJSJO28x7csMka3+dNWt4++KE=;
        b=JSK/WLEW8DjlcYW6sFJthRlphc96Mv+cdqsnOLXmK8uBmW0u01mZ42xrfn2zTjLXMp
         n8888TNe31+qn0emUsKBIUa0cuCnxnPN2C4s0mcTJAhC+GXRGPu74z9XWBeI/txiWTLn
         SVAgF9XRoJdcVYgDNOXFQljtoOXZTHbobUSwQWxqnR6kpqkwLzQfOCgAyK/HKWLANrLR
         y1Ak/dxy1jTaZSF4aIOMhzHvBukrtVYudVV7BmQ2JXiw34VeL//6vrokZHEmEk07FBMN
         bhbJynYNfy8jGqfPW1lAR1zXc6RuoU2yByU39mGK8lgmtYtpgevzW7uDOcaVZSspOKpw
         hmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ls7T8/4IFgmrEAJ3HQnJSJO28x7csMka3+dNWt4++KE=;
        b=Atb2LXNPejx3Sq2gkB6HydfMULt/D3G8vbIZHJfU9J97evAg83bG5jQv09zRwAAiq8
         6dHmwvKE91g6oJjSifWgF3wU/y1blNaA57GTprJy39VjbQslsm8Cb/l+FexUFvepIZNM
         yN6T8K3yZHVs5tFu3UW3blTSbhYW1dUQZtzzFCFPoDvmoehfl514F2I+t2V3aCYuBFiW
         xq5YqSJWAX3UxKEyLnScjic3d2NiAeXnporFvPg+OHaJ4Javk+yI9G/0NKz9WC8VqaII
         yZk5+nzcc4mapLFl8Dumg2GfphQAc1ppW4hSB3qFVTp2K0eEeiMllxALr6yfXTsrezi4
         GQOg==
X-Gm-Message-State: AN3rC/5I/fRLe6ygSPTyeqUGl3TXjXgOV+gr4S0scfW1wUXD6hyVD+FE
        FoOdpN8Pd3r3t6JYGCVOF0AQIw6efoq2
X-Received: by 10.98.72.88 with SMTP id v85mr15091911pfa.8.1493425694632; Fri,
 28 Apr 2017 17:28:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 17:28:14 -0700 (PDT)
In-Reply-To: <20170428235402.162251-6-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com> <20170428235402.162251-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 17:28:14 -0700
Message-ID: <CAGZ79kZzpyw0ijiM12TwMHAx1Ung-xKPEm2rVY9803hvk=+UMQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] submodule: improve submodule_has_commits
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 4:54 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach 'submodule_has_commits()' to ensure that if a commit exists in a
> submodule, that it is also reachable from a ref.
>
> This is a prepritory step prior to merging the logic which checkes for

s/prepritory/preparatory/
s/checkes/checks/

This is the first commit in the series that changes user observable behavior,
I guess there will be tests in a later patch? Can you elaborate in this commit
message more about why it is useful (or at least harmless for performing
this check in the case of fetch/push)?

> diff --git a/submodule.c b/submodule.c
> index 3bcf44521..100d31d39 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -648,6 +648,30 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
>                 return 0;
>
>         oid_array_for_each_unique(commits, check_has_commit, &has_commit);
> +
> +       if (has_commit) {
> +               /*
> +                * Even if the submodule is checked out and the commit is
> +                * present, make sure it is reachable from a ref.
> +                */
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               struct strbuf out = STRBUF_INIT;
> +
> +               argv_array_pushl(&cp.args, "rev-list", "-n", "1", NULL);
> +               oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
> +               argv_array_pushl(&cp.args, "--not", "--all", NULL);
> +
> +               prepare_submodule_repo_env(&cp.env_array);
> +               cp.git_cmd = 1;
> +               cp.no_stdin = 1;
> +               cp.dir = path;
> +
> +               if (capture_command(&cp, &out, 1024) || out.len)
> +                       has_commit = 0;

So if we fail to launch capture_command, we assume we do not
have the commits?

capture_command can fail for reasons that are hard to track down
or even spurious (OOM due to excessive output, disk failure,
corrupt repo, error in executing the process, getting a signal and
so on), some of them are ok to ignore, others should never be ignored.

So I'd rather die on capture_command, and inspect out.len only
in case of successful capturing.

In addition to that we're only interested if there is any output,
such that we can optimize further:
c.f. http://public-inbox.org/git/20170324223848.GH31294@aiede.mtv.corp.google.com/

    if (start_command(&cp))
        die("cannot start git-rev-list in submodule'%s', sub->path);

    /* read only one character, if any */
    if (xread(cp.out, &tmp, 1);
        has_commit = 0;

    /*
     * close cp.out, such that the child may get SIGPIPE, upon which
     * it dies (silently, maybe we need to suppress cp.err ?)
     */
    close(cp.out);

    /*
     * Though we need to be nitpicky about finish_command IIUC by now:
     * TODO(sbeller): if this turns out to be true, fixup is_submodule_modified
    */
    int code = finish_command(&cp);
    if (!code && code != 128 + SIGPIPE)
        die("git rev-list failed in submodule'%s'", sub->path);

Upon rereading the patch, I notice the '-n 1', which would make the
optimized code above useless, so just consider it food for thought.

Thanks,
Stefan

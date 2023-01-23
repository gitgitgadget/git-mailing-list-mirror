Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD61C25B4E
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 02:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjAWCBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 21:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjAWCBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 21:01:49 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105D10A91
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 18:01:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so7003072pji.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 18:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRwcWgy+TIfVjm2BjajJiwE9L/VnjhH++x2f8sYaFSE=;
        b=F1h/kTU+jWhgwinwV/ARX9Y2cxpHHE2ze7ThzrFdtKbG+tJ5hyZC/XtK/ZfvuM6cCv
         Fqp9vW/ZUAFNnT/THFSN6oyi9IZMjkHmufVHIjguxfnImIKcublaHwFGU/i1xkYmPj3j
         kS+Z5NHFS2lOSHmy/3JR26owxemFdCopRm7On8XklP4JgNGxUUgGzIq22KFJsxJvTrww
         s6DHI9gZLdvxk1l0MznEybMLUxbRyedddTlEYg+w58XxCakpdJWv6npFtbLdq2485EQH
         8zgt/dDXlt4IcKKP33nqPUg0qCB4+1uaLjwjpbT9DKMEVhVqj33XTKE+E0UAAUsakYL8
         jFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRwcWgy+TIfVjm2BjajJiwE9L/VnjhH++x2f8sYaFSE=;
        b=i3rMGxcLXHTgvt5TGbRGNNMECmmGpmIcKFrqItyBAVWYmz0HzCMmjN7aa6wxwTBtaV
         XU2tyIRLF0E2xsGMa2HQdUMlSp711TanyeO2K1ChD1unIpD3/q0O6Cmh9ikvCBxF1PX7
         IstI3xB8LQL+YTWHKVdu0eW32dAWmn+yS/BMsQSFnsOQS1QBpmYzcZMr7oVJHCFFMZPl
         QbllblkEFxqxRWfx89ZSFQYJFC1Hv0itVSDTkXttsOybTtnunxvoPoE7f1o4LP4EkkDs
         jmveUxUZDanlD2L2t2n1mwBbo92KstYEPXBNSG9CGj0IQ0GIP0EdSGuKyiIpNKcNENjl
         icqw==
X-Gm-Message-State: AFqh2ko7gXGaWs2nQlG7G+S7NvcW5fK+NxA7KP+EhowpdA0oD0jmyqh3
        WOK8WiJD43TQh9BwbNaKUPA=
X-Google-Smtp-Source: AMrXdXuJO/M/qQqEX8WLf3EFhyNiRXa7o7/coZKmQ09lZMqFgWJigOknlTwlfwf4SVTNklOBThtOuQ==
X-Received: by 2002:a05:6a20:bf15:b0:b8:8ad6:ee34 with SMTP id gc21-20020a056a20bf1500b000b88ad6ee34mr22724974pzb.51.1674439307430;
        Sun, 22 Jan 2023 18:01:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902a41100b0017a032d7ae4sm18423704plq.104.2023.01.22.18.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 18:01:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] bisect: fix "reset" when branch is checked out elsewhere
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
Date:   Sun, 22 Jan 2023 18:01:46 -0800
In-Reply-To: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 22 Jan 2023 02:38:10 +0100")
Message-ID: <xmqqo7qqovp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
> have a safety valve in checkout/switch to prevent the same branch from
> being checked out simultaneously in multiple worktrees.
>
> If a branch is bisected in a worktree while also being checked out in
> another worktree; when the bisection is finished, checking out the
> branch back in the current worktree may fail.

True.  But we should explain why failing is a bad thing here.  After
all, "git checkout foo" to check out a branch 'foo' that is being
used in a different worktree linked to the same repository fails,
and that is a GOOD thing.  Is the logic behind your "may fail and
that is a bad thing" something like this?

    When "git bisect reset" goes back to the branch, it used to error
    out if the same branch is checked out in a different worktree.
    Since this can happen only after the end-user deliberately checked
    out the branch twice, erroring out does not contribute to any
    safety.

Having said that...

> @@ -245,7 +245,8 @@ static int bisect_reset(const char *commit)
>  		struct child_process cmd = CHILD_PROCESS_INIT;
>  
>  		cmd.git_cmd = 1;
> -		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
> +		strvec_pushl(&cmd.args, "checkout", "--ignore-other-worktrees",
> +				branch.buf, "--", NULL);

"git bisect reset" does take an arbitrary commit or branch name,
which may not be the original branch the user was on.  If the
user did not have any branch checked out twice, can they do
something like

    $ git checkout foo
    $ git bisect start HEAD HEAD~20
    ... bisect session finds the first bad commit ...
    $ git bisect reset bar

where 'foo' is checked out only in this worktree?  What happens if
'bar' has been checked out in a different worktree linked to the
same repository while this bisect was going on?  The current code
may fail due to the safety "checkout" has, but isn't that exactly
what we want?  I.e. prevent 'bar' from being checked out twice by
mistake?  Giving 'bar' on the command line of "bisect reset" is
likely because the user wants to start working on that branch,
without necessarily knowing that they already have a worktree that
checked out the branch elsewhere---in other words, isn't that a lazy
folks' shorthand for "git bisect reset && git checkout bar"?

If we loosen the safety only when bisect_reset() receives NULL to
its commit parameter, i.e. we are going back to the original branch,
the damage might be limited to narrower use cases, but I still am
not sure if the loosening is worth it.

IIUC, the scenario that may be helped would go like this:

    ... another worktree has 'foo' checked out ...
    $ git checkout --ignore-other-worktrees foo
    $ git bisect start HEAD HEAD~20
    ... bisect session finds the first bad commit ...
    $ git bisect reset

The last step wants to go back to 'foo', and it may be more
convenient if it did not fail to go back to the risky state the user
originally created.  But doesn't the error message already tell us
how to go back after this step refuses to recreate such a risky
state?  It sugests "git bisect reset <commit>" to switch to a
detached HEAD, so presumably, after seeing the above fail and
reading the error message, the user could do

    $ git bisect reset foo^{commit}

to finish the bisect session and detach the head at 'foo', and then
the "usual" mantra to recreate the risky state that 'foo' is checked
out twice can be done, i.e.

    $ git checkout --ignore-other-worktrees foo

So, I am not sure if this is a good idea in general.

Or do I misunderstand why you think "checking out may fail" is a bad
thing?

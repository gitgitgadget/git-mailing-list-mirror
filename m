From: Stefan Beller <sbeller@google.com>
Subject: Re: Git submodule regression in 2.7.0+
Date: Wed, 24 Feb 2016 12:53:44 -0800
Message-ID: <CAGZ79kY4X8Df0wHYka9AVcjBp3LXJ=LG220YjJYmL0C5aSYbBA@mail.gmail.com>
References: <CABD8wQkN8bLQzqtUru9X+Mxji8U4UoUVdiioCNrJsWEzwcL50g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Caleb Jorden <cjorden@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:53:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgRT-0004kj-19
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbcBXUxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:53:46 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36138 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbcBXUxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:53:46 -0500
Received: by mail-io0-f172.google.com with SMTP id l127so65920051iof.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 12:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a8LbzOzIpqC9tgzev0p0CMU4P+YHh9M3Ed1BwievGJk=;
        b=ZwoDwJeV+GvQMjKvJKMaYQ4zpTiSnnqAC/gkLIgn1sPmjLXs+3GLRDPwDU8UPMm6DK
         VpolPpg4V2X0IyIJdSc+8LnXAoYIZPzOA8u094UzLXCN1Hr31LM/9Qi8GsYCiCCX2y4Q
         36nws8S2XgvFX1aHxN+e2HUy+QJe3rQgyPDlsyGWAPD49p74F6QommId2rqVzqPrrxw9
         TolFjT5FkswMcZRHXbOSNH16hO7qWbGdnQT4o9IeozPOj5muBfwrzPjXGjoNVWnXM/Ef
         czNn2wA877fIyJRAQq7ZOKZPHUfGHdJhotHkReEbHllViACjqcCyzdBCK4unIm8TbttC
         vcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=a8LbzOzIpqC9tgzev0p0CMU4P+YHh9M3Ed1BwievGJk=;
        b=Y3LdTeH3ewqv3qA28kX6SvnRsQ7CHC8gDOQXsrvF/2/e+owaSXn5B2xyqlBY291Yiu
         TENMQvIADF2imSM7noXQhPYtX480KZwY/vL+9U/tikVIkkdLNj/Q7V+f20Qst8H4TvE1
         Ra4OAXmAfS3mThqgEvCNVAqB9dTbqxbqkECLFDl13B6Hq5aBynHv3HAHxDgTK/v5bBd1
         pRggsQQqRE4VSQ+EYgLxgfYXxXO9JVtJyRMPdqLVEmN1w6hXFtlvKXc4+8QB9FEuBnkz
         zF4Rl+3nqI9Lr/KJuOM9uNyGHz9PpCBolaCiH9010rE8ZlC7PVEjddSH8UOmE6Y0nweg
         S3EQ==
X-Gm-Message-State: AG10YOQ6Zjlie572KaAUVzcF3GfJ8eai8yZPGR6zAbXHaEnBzPV7phuB/K85ooD5PB4aps1SMJnKjZGvVNTfTTqw
X-Received: by 10.50.180.35 with SMTP id dl3mr12955194igc.94.1456347225014;
 Wed, 24 Feb 2016 12:53:45 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 24 Feb 2016 12:53:44 -0800 (PST)
In-Reply-To: <CABD8wQkN8bLQzqtUru9X+Mxji8U4UoUVdiioCNrJsWEzwcL50g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287227>

On Wed, Feb 24, 2016 at 11:35 AM, Caleb Jorden <cjorden@gmail.com> wrote:
> Git community,
>
> I have hit a rather significant regression in recent versions of Git,
> when using submodules.  I have narrowed it down to a simple set of
> commands that demonstrates the problem (commands for a unix-style OS):
>
> ---- Start list of commands to reproduce issue ----
> mkdir -p test/a/b
> cd test
> git init
> cd a/b
> git init
> echo hello > testfile1
> git add .
> git commit -m "test1"
> cd ../..
> mkdir -p 1/b
> cd 1/b
> git init
> echo hi > testfile2
> git add .
> git commit -m "test2"
> cd ../..
> git submodule add /a/b a/b
> git submodule add /1/b 1/b
> git commit -m "first submodule commit"
> git submodule--helper list a/b
> ---- End list of commands ----
>
> On my machines, this shows 1/b, not a/b.
>
> It seems that the submodule--helper (at least for the list command) is
> not properly taking into account the path in the repository, but
> rather just the submodule name itself.

The error is in submodule--helper.c module_list_compute 45
where I would expect

    if (!S_ISGITLINK(ce->ce_mode) ||
       !match_pathspec(pathspec, ce->name, ce_namelen(ce),
       max_prefix_len, ps_matched, 1))
        continue;

to fail if ce->name== 1/b and the pathspec is setup for a/b.
(I verified these using gdb, the condition doesn't trigger and
continues in the code instead of following the 'continue' statement.

Maybe the setup of the 'pathspec' is wrong using the flags

    parse_pathspec(pathspec, 0,
          PATHSPEC_PREFER_FULL |
          PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
          prefix, argv);

>
> This manifests itself if you have a Git repo that uses submodules that
> has been updated (or just cloned), and you want to specifically update
> a single submodule (which is where this problem was discovered).  If
> you run in "git submodule update <submodule path>", and you have two
> submodules with the same name (but in different paths in the
> repository), then you will update the first one found
> (lexicographically, as far as I can tell), every time.  There may be
> other operations on submodules that are impacted as well, but I have
> not explored them completely.

Nearly all 'git submodule <commands>' use 'git submodule--helper list',
so I'd expect other breakages indeed.


>
> This may seem like a contrived situation, but this problem was found
> in a live repo that uses submodules (albeit a private one).
>
> Note that this behavior changed in 2.7.0 and is still current (happens
> in 2.7.1, 2.7.2, and master in git repo as of 2/23/2016).  Prior to
> 2.7.0 (which introduced the submodule--helper command) the behavior
> for this was as expected - the entire path was taken into account for
> the submodule update command.  This has been observed on a Gentoo
> machine (x86_64), as well as numerous Ubuntu installs (x86_64, 14.04).
> This occurs both with the ubuntu git PPA (Git stable releases "Ubuntu
> Git Maintainers" team, 2.7.1 at the time of this writing) and from a
> fresh compile of 2.7.2 from source.
>
> This regression can be fixed in 2.7.2 if one reverts the three commits
> which introduced submodule--helper.c file and associated changes
> (ee8838d157761acf4cc38f2378277dc894c10eb0,
> 0ea306ef1701d6f42e74d3c33addfcd630248904, and
> 74703a1e4dfc5affcb8944e78b53f0817b492246).  Just to be clear, I am not
> advocating reverting these changes - I would rather see the
> submodule--helper.c work continue, but also see this fixed.
>
> I have not yet had the time to dive into the code to find what the
> problem is, but I wanted to make sure this was reported so that others
> who may be hitting this can be aware of it.  Also, I wanted to make
> Stefan Beller aware of this, as he seems to still be working on the
> submodule--helper.c code.

Thanks for pointing out the problem, I'll look into it.
Sorry to break your use case.

>
> I am not currently subscribed to the Git mailing list, so please CC me
> in any response.

Thanks,
Stefan
>
> Regards,
>
> Caleb Jorden
> cjorden@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9384C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1E20B80
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="os8BEzcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKZIW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgKZIW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 03:22:59 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1AC0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 00:22:59 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so1298467edt.9
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 00:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZGWqwarKDYicPLOBx76lEKJCYu6DGQSsQTejXaFCDE=;
        b=os8BEzcUl3yqEynJkWn5/uI0KAgYw0FNe5PmsgnQgMtppuV3L7nHynzmbvN4Wn4GE9
         f4CLnZ6y087MDFb9HpH/BH6NPAI6kWWPksqLmHZe1Mv9q+6Wuvw0j1jqDHNS20nXRVH3
         DE3r4FYwgz/sjiVpLw7gSyjZTZvswS5dY41tT5bQdXh7a4VOjFo1i1Zez/YdzysjQWTH
         QWxanP0MV1XdAN+PIkTlmcQPWAFSueJ0YzauJlINTjRyeLfTTgikekcj50dvZO48hGDw
         5iwElf4c3+AQTGU9g93Rf4KltnW9iTfjP9OQy5IRQDBKI+Y9QC/Xc2jCAdV0UWfh23VZ
         uTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZGWqwarKDYicPLOBx76lEKJCYu6DGQSsQTejXaFCDE=;
        b=daUicSBFhvcqI+HiDVIzggfEIlcwUCo6JueAOnBoGapjVybxLIBrsggvM6cbSffQ55
         qa8V9vBgb+285m3BdTA5etpcpWHbXbjyvBt9IVQnw7aJ5NHpiszuNOtHvsZsvKTCjEnT
         zxqHbk56vwP+1crg3Jeb4chB3F5kLVDOUOjl7UGy+wQpABX5RIOesScHP2bvKLrwpWze
         XsND3Oi2P7j3XXi6HHx0DLEzUqOA06ltc6AJHjUbyDTBbaCDZSwIMcKEsWR+u5DLzJ/Y
         xMdkvl862j2pIIojgUq64y9oTfnDd4NYhRzqjxh0wz2ZC4+t2VRaZrak3QPmcO8NUmqP
         ttsw==
X-Gm-Message-State: AOAM531QssmCB9kMO9sRMmlr6WYOY+rqRpME0WHNMBbG6BjeRIqpOICO
        6SrduLp+lzdFoJDW/ye+zvw=
X-Google-Smtp-Source: ABdhPJxxEvGR+JNV+IhK0qpUdnKfyIXjdiCAnpgmD7tffH2+dfey+hSVJnpoClk5S3BTRVu5tcvpcQ==
X-Received: by 2002:a05:6402:b4c:: with SMTP id bx12mr1439616edb.196.1606378977837;
        Thu, 26 Nov 2020 00:22:57 -0800 (PST)
Received: from contrib-buster.localdomain ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id w16sm2634576eds.81.2020.11.26.00.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 00:22:57 -0800 (PST)
Date:   Thu, 26 Nov 2020 08:22:55 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
Message-ID: <20201126082255.yyxx2kpskj3td5og@contrib-buster.localdomain>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
 <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 12:22:40PM -0500, Derrick Stolee wrote:
> On 11/24/2020 11:44 AM, Rafael Silva wrote:
> > The "git maintenance run" and "git maintenance start" commands holds a
> > file-based lock at the .git/maintenance.lock and .git/schedule.lock
> > respectively. These locks are used to ensure only one maintenance process
> > is executed at the time as both operations involves writing data into
> > the git repository.
> > 
> > The path to the lock file is built using the "the_repository->objects->odb->path"
> > that results in SEGFAULT when we have no repository available as
> > "the_repository->objects->odb" is set to NULL.
> > 
> > Let's teach the maintenance_run_tasks() and update_background_schedule() to return
> > an error and fails the command when we have no repository available.
> 
> Thank you for noticing this problem, and for a quick fix.
> 
> While I don't necessarily have a problem with this approach, perhaps
> it would be more robust to change the options in git.c to require a
> GIT_DIR, as in this diff?
> 
> -- >8 --
> 
> diff --git a/git.c b/git.c
> index 1cab64b5d1..c3dabd2553 100644
> --- a/git.c
> +++ b/git.c
> @@ -530,7 +530,7 @@ static struct cmd_struct commands[] = {
>         { "ls-tree", cmd_ls_tree, RUN_SETUP },
>         { "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
>         { "mailsplit", cmd_mailsplit, NO_PARSEOPT },
> -       { "maintenance", cmd_maintenance, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +       { "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
>         { "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
>         { "merge-base", cmd_merge_base, RUN_SETUP },
>         { "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
> 
> -- >8 --
> 

Thank you for the review and the attached patch!

> If the above code change fixes your test (below), then that would
> probably be a safer change.

I agree, switching the maintenance command option to use RUN_SETUP
seems like a nicer approach here. Given the all current operations
requires the command to be executed inside the a git repository this
will make the command consistent across the subcommand. 

Also, it seems this provides an opportunity to cleanup the
register and unregister subcommands that currently implement the
check to ensure the commands are running from a git repository.

> 
> The reason to use RUN_SETUP_GENTLY was probably due to some thought
> of modifying the background maintenance schedule without being in a
> Git repository. However, we currently run the [un]register logic
> inside of the stop|start subcommands, so a GIT_DIR is required there,
> too.
> 

Indeed. Aside from this reason, another concern that I have is that
switching the validation to all subcommands (on this case by switching
the maintenance command option) will change a bit the behaviour of register
subcommand. Currently, the behaviour of "register" subcommand is to return
with 0 without any messages when running outside of repository and switching
will make the command fail instead.

Nevertheless, I am inclined to go with your suggestion given that it seems
better approach to support the automatically and make the behaviour
consistent for all subcommands given that changing the behaviour of
"git maintenance register" command will (hopefully) be okay.

Thanks,
Rafael

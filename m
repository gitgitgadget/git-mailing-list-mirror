Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5288C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB16139A
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhEEMUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhEEMUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:20:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD46C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:19:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x188so1836857pfd.7
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kmeoPC2CDSv7mr0CeipajmeNB1mXTMlkOsxDrlybkWA=;
        b=n2ysse42V2bT1gbMqSJN9JvqUgZ0+L6gJRvgRj2xV1CDuZDdfZHHaVPZmWYEMzEkoQ
         4jvvnbtp/uWQuFplNlYHH+/RON7VvRyfs0lZrveCuSAzeT/omIz1R/t5lNa9UwsYryCI
         7IMnQUDv+mBWKu54UoSOY2zCdLqlL4VGW56O+uxXywaCuKWpNLaiEL6WQLjKpcYtznDt
         ADajCB77WRFfbbhf3FYirE68KfGXD7IT2RF0Fodt9k3r+K6IRQdgWJOiOVUxx12dMl+B
         sxo8zv5Nlh8TxsXp2kRBO4UoYGouY6KQB/U+b7ZddLYwNPY3LSw0StzohnR1kibWUeNW
         r+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kmeoPC2CDSv7mr0CeipajmeNB1mXTMlkOsxDrlybkWA=;
        b=lCOibxq0+f4VDn7Gs9E9TB89NGorJ4rN8V/BnhkZAcxEhoz9GFbzmuRu51a84x0JtD
         eV97kfhlvfR2VtL0CaPG99ZIfmXnATvqXqxVLwkNpxetK/S0zyFI/g1wvm9FQe8upxQJ
         2ChwlwcWHGhkbWhjqgPQ3JMCgBMTtjK+CAoshmi3arvS/Jld9nwFRkxOeACqxciv031t
         QI0HTsR2uY+h+NeNlNljlh0t+SATJ4rCjLXorUW5DuiAdHJgYTGU7MIYkblzf7VFX0fM
         MwCeLo/R9Mx2H0yKAqyXa99tJTY54T40m9puCEC8TI7r36k65xOhwHXnX7+p5eg/9Azb
         OwRQ==
X-Gm-Message-State: AOAM530vXqeyXaqp6AmRu873zUorAyj61KJ34sOQOK7NFBiCxahaNmAU
        sfebnJYukCvJT7nr+IkqAvw=
X-Google-Smtp-Source: ABdhPJw/PpVRZlzRROJbrQktw0dgbPyw2ElsdaeeMzYp6UvTNRDkQVBJ5PKFe6ioa6MvRGLJaTZY0Q==
X-Received: by 2002:aa7:848f:0:b029:28f:916b:a220 with SMTP id u15-20020aa7848f0000b029028f916ba220mr2897769pfn.10.1620217176696;
        Wed, 05 May 2021 05:19:36 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id z23sm12132901pjh.44.2021.05.05.05.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:19:36 -0700 (PDT)
Date:   Wed, 5 May 2021 19:19:33 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
Message-ID: <YJKNVX5Nq64wAfvA@danh.dev>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
 <b1153c47-05cf-877c-587b-8205d8d32816@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1153c47-05cf-877c-587b-8205d8d32816@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-02 15:10:05+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 02/05/2021 07:45, Eric Sunshine wrote:
> > On Sat, May 1, 2021 at 10:59 AM Lénaïc Huard <lenaic@lhuard.fr> wrote:
> > > The existing mechanism for scheduling background maintenance is done
> > > through cron. On Linux systems managed by systemd, systemd provides an
> > > alternative to schedule recurring tasks: systemd timers.
> > 
> > Thanks for working on this. While `cron` has been the go-to standard
> > for decades, `systemd` is certainly widespread enough that it makes
> > sense to support it, as well.
> 
> Yes, thank you for working on this, it will be very useful to users like me
> who use a linux distribution that does not install a cron daemon by default
> but relies on systemd instead.
> 
> > > The main motivations to implement systemd timers in addition to cron
> > > are:
> > > * cron is optional and Linux systems running systemd might not have it
> > >    installed.
> > > * The execution of `crontab -l` can tell us if cron is installed but not
> > >    if the daemon is actually running.
> 
> Can we use systemctl to see if it is running (and enabled so we know it will
> be restarted after a reboot)?

Not sure if I understand this suggestion.
However, non-systemd systems doesn't have systemctl command to begin
with.

> > > * With systemd, each service is run in its own cgroup and its logs are
> > >    tagged by the service inside journald. With cron, all scheduled tasks
> > >    are running in the cron daemon cgroup and all the logs of the
> > >    user-scheduled tasks are pretended to belong to the system cron
> > >    service.
> > >    Concretely, a user that doesn’t have access to the system logs won’t
> > >    have access to the log of its own tasks scheduled by cron whereas he
> > >    will have access to the log of its own tasks scheduled by systemd
> > >    timer.
> > 
> > The last point is somewhat compelling. A potential counterargument is
> > that `cron` does send email to the user by default if any output is
> > generated by the cron job. However, it seems quite likely these days
> > that many systems either won't have local mail service enabled or the
> > user won't bother checking the local mailbox. It's a minor point, but
> > if you re-roll it might make sense for the commit message to expand
> > the last point by saying that although `cron` attempts to send email,
> > that email may go unseen by the user.
> > 
> > > In order to schedule git maintenance, we need two unit template files:
> > > * ~/.config/systemd/user/git-maintenance@.service
> > >    to define the command to be started by systemd and
> > > * ~/.config/systemd/user/git-maintenance@.timer
> > >    to define the schedule at which the command should be run.

I think it would be better to change ~/.config here to
$XDG_CONFIG_HOME, as others also points out in another comments.

[..snip..]

> > > +`git maintenance start` will overwrite these files and start the timer
> > > +again with `systemctl --user`, so any customization should be done by
> > > +creating a drop-in file
> > > +`~/.config/systemd/user/git-maintenance@.service.d/*.conf`.

Ditto.

> > Will `systemd` users generally understand what filename to create in
> > the "...@.service.d/" directory, and will they know what to populate
> > the file with? (Genuine question; I've never dealt with that.)
> 
> I think it would be helpful to explicitly mention the file names (I don't
> think I could tell you what they are without reading the relevant systemd
> man page)

[..snip..]

> > > +static char *systemd_timer_timer_filename()
> > > +{
> > > +       const char *filename = "~/.config/systemd/user/git-maintenance@.timer";
> > > +       char *expanded = expand_user_path(filename, 0);
> > > +       if (!expanded)
> > > +               die(_("failed to expand path '%s'"), filename);
> > > +
> > > +       return expanded;
> > > +}
> > 
> > I was curious whether this would fail if `.config/systemd/user/`
> > didn't already exist, but looking at the implementation of
> > expand_user_path() , I see that it doesn't require the path to already
> > exist if you pass 0 for the second argument as you do here. Okay.
> 
> Do we need to worry about $XDG_CONFIG_HOME rather than hard coding
> "~/.config/". There is a function xdg_config_home() that takes care of this.

-- 
Danh

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18502C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiCJSlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiCJSln (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:41:43 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968A18CC6E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:40:42 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id o6so9027342ljp.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIDYTh3BFhIz6t60LglGPpwzu4lCvxYYn2I6O2Pho+M=;
        b=Ux4KEWbetGujW7gveeSXzSttBjvUKrZOvxubiTquuhXQWXfg/eFgbCZdN24MTXEey9
         4Ya2E3brEnu3zriv1KuzForlUBhD3aUC4SJ6N89TpVzPwYF8zV7CdOshL3MOBPaJZBgS
         AdLu42PYPizjwSS9J4GTrEheXHeFdxuBm7T2b4nbz7ICqF+xE8TFFAICAq9xNj7lpIik
         jzmm1mGNS+lVhEQFws9fEL1pa20dy/BxxCw0tCsyH4yZ10fDLdWSjUNymYDD2euli2TF
         qdGM8ZbIxkoFbg/Gy9qnHNE7FVqeFKbi0rPALnfUEAC8Sy9AojMUN7MZePNdjRohhLH7
         cZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIDYTh3BFhIz6t60LglGPpwzu4lCvxYYn2I6O2Pho+M=;
        b=PsgOeKh7nSd6LRk+2uPQgu8o0Qj3QezIPc696bLO4ADKMEQgqO34rLWBnakw0igvlw
         zrFw6gTycRCqo2jIcA5baeEqW2gr2T3WgzH/SOHJ2Ogx0DMjJ8Gn/RzhogrPJjCrs0q2
         Ockv3OElzVB+wXHYMzC80655bSLcmB662HM8JFoa3ykQ0giLprsaZJUxoHIlqFCJSxZB
         sGVoz7fABnuzShv8zGg1oOm7AU3uCLn6AAzy76plaMQm2SatJ8NBbsaKbrplGjuf22d7
         tZ5LP8MvFREWb6p69TYzmxRmTMloGpYxtnCGQaTovCZWD1KLyZ3x2o7sma+5r1frx65v
         BlHw==
X-Gm-Message-State: AOAM530bfx5to6wgaLcVk1UaQ45UKB//gnZhhANuLnhrYsSDzzYw4XWw
        ypl75Q/kakavWMvhItpb4WcNg51d9Voc9BCJ8/Y=
X-Google-Smtp-Source: ABdhPJwRC7Ya+9tfP5pDit3CEDiOdSA74fwIqwo7/PlGAWbtNiSdu0hJzf8nZ1jVIiuZIlmOR/Od6Bz7Ub9xjVUd1ms=
X-Received: by 2002:a05:651c:241:b0:23e:42c1:2e4 with SMTP id
 x1-20020a05651c024100b0023e42c102e4mr3819958ljn.406.1646937640719; Thu, 10
 Mar 2022 10:40:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <50e39f698a7c0cc06d3bc060e6dbc539ea693241.1646905589.git.ps@pks.im> <xmqqwnh1g19q.fsf@gitster.g>
In-Reply-To: <xmqqwnh1g19q.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 10:40:29 -0800
Message-ID: <CANQDOdeK8CZmBqaWZgY17qrfPbwMHvq+=CYS_nsRHdg6aarwEA@mail.gmail.com>
Subject: Re: [PATCH 6/8] core.fsync: add `fsync_component()` wrapper which
 doesn't die
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 9:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > We have a `fsync_component_or_die()` helper function which only syncs
> > changes to disk in case the corresponding config is enabled by the user.
> > This wrapper will always die on an error though, which makes it
> > insufficient for new callsites we are about to add.
>
> You can replace "which makes it ..." part with a bit more concrete
> description to save suspense from the readers.
>
>     fsync_component_or_die() that dies upon an error is not useful
>     for callers with their own error handling or recovery logic,
>     like ref transaction API.
>
>     Split fsync_component() out that returns an error to help them.
>
> > -void fsync_or_die(int fd, const char *);
> > +int maybe_fsync(int fd);
> > ...
> > +static inline int fsync_component(enum fsync_component component, int fd)
> > +{
> > +     if (fsync_components & component)
> > +             return maybe_fsync(fd);
> > +     return 0;
> > +}
> >
> >  static inline void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
> >  {
> > -     if (fsync_components & component)
> > -             fsync_or_die(fd, msg);
> > +     if (fsync_component(component, fd) < 0)
> > +             die_errno("fsync error on '%s'", msg);
> >  }
>
> I think in the eventuall reroll, these "static inline" functions on
> the I/O code path will become real functions in write-or-die.c but
> other than that this reorganization looks sensible.
>
> Thanks.
>

Yes, that will be part of v6 of the base changeset.

> > diff --git a/write-or-die.c b/write-or-die.c
> > index 9faa5f9f56..4a5455ce46 100644
> > --- a/write-or-die.c
> > +++ b/write-or-die.c
> > @@ -56,19 +56,21 @@ void fprintf_or_die(FILE *f, const char *fmt, ...)
> >       }
> >  }
> >
> > -void fsync_or_die(int fd, const char *msg)
> > +int maybe_fsync(int fd)
> >  {
> >       if (use_fsync < 0)
> >               use_fsync = git_env_bool("GIT_TEST_FSYNC", 1);
> >       if (!use_fsync)
> > -             return;
> > +             return 0;
> >
> >       if (fsync_method == FSYNC_METHOD_WRITEOUT_ONLY &&
> >           git_fsync(fd, FSYNC_WRITEOUT_ONLY) >= 0)
> > -             return;
> > +             return 0;
> >
> >       if (git_fsync(fd, FSYNC_HARDWARE_FLUSH) < 0)
> > -             die_errno("fsync error on '%s'", msg);
> > +             return -1;
> > +
> > +     return 0;
> >  }
> >
> >  void write_or_die(int fd, const void *buf, size_t count)

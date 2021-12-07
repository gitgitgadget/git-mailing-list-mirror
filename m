Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109A2C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 23:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhLHACm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhLHACm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 19:02:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625DC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 15:59:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z7so1957969lfi.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 15:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fXJG+2EPxLXnKSHeFsss1d03jIcyQEFXQXzOVbQqaq4=;
        b=mFJdVFPlAcdBLNDMidP76JW5Sl9oNODJSyTkvxJzN0Tpb8HWYZv0fs4j7y8DLSenvU
         bH7Rc09wxXnw0JOKBIpx9ShH7LbIeEYL8yODQ3YTygmw8ajTaHMtQy3e0uz76lTrrqaf
         nnaK9mEd5pM2EnDTxN4KUFDiJV0qW4X194nrKN2F5S+wZvEvtONoAYXFOu/oqrHRzBOQ
         9D6Nun94l9IU9XsPKIq8uj4zQPks8dpRPm4tK87y11gLsiEjDJk4ZbA/RacX04gzKjMh
         ZAXqUdY5UWCTPk51wGeb6ANtnz5BuXP//tu9UapAMkpW2lg01Z7huqc15PPglDbGTWf7
         NJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fXJG+2EPxLXnKSHeFsss1d03jIcyQEFXQXzOVbQqaq4=;
        b=htjQIOjV8VAvaMb3poGgpmxnWhBWwFaGBskqGMomeVy7T0vT1f/QHL+zj/hAjr76u5
         /WMcrSM4H5BPGNsMh2rRoHQq6QBi9Ejf3YzlU9bFZD2guUIj5XtKjRkkw/YUkDFZGQFW
         TLzx5dPU9mWi5MtNjsJFJjbXNNqwQ2lM9rlZ7qeBGQ0uBoFUopDYJOe9y1Q3zQOjop5q
         1ct6S7Mp/s2RDWNS4Y50kL6d7nhJO1XuHflxeCv5sTuxSh6txgEHnOx/GDb322LsHU8/
         el02yzvAGWnxLnII0W3+n8YxcNd2JOTMkGRg6vooI7bGDe6a6StTvvm9LyMbLb6nwYxR
         zwpQ==
X-Gm-Message-State: AOAM530t+NxcBWw55YkvLncyocgBZtfILIhPeAVQhsk/bkULHg3AE4G0
        yHR1/PDPel3OnRHsw9V6Va8zX8OgwF3VdcZNZ70=
X-Google-Smtp-Source: ABdhPJyUz31njAaM9CCYtK2CcSiJt8fwZp1OLHkruXX5bwJm4/RBGz0LlbsIDs6D3KXjhfHsj6T5+ql0ODCFYZIUW20=
X-Received: by 2002:a05:6512:3182:: with SMTP id i2mr42290473lfe.241.1638921549028;
 Tue, 07 Dec 2021 15:59:09 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <e79522cbdd4feb45b062b75225475f34039d1866.1638845211.git.gitgitgadget@gmail.com>
 <211207.861r2opplg.gmgdl@evledraar.gmail.com>
In-Reply-To: <211207.861r2opplg.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Dec 2021 15:58:57 -0800
Message-ID: <CANQDOdf8C4-haK9=Q_J4Cid8bQALnmGDm=SvatRbaVf+tkzqLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] core.fsyncmethod: add writeout-only mode
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 4:27 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > This commit introduces the `core.fsyncmethod` configuration
>
> Just a commit msg nit: core.fsyncMethod (I see the docs etc. are using
> it camelCased, good..

Will fix.

> > diff --git a/compat/win32/flush.c b/compat/win32/flush.c
> > new file mode 100644
> > index 00000000000..75324c24ee7
> > --- /dev/null
> > +++ b/compat/win32/flush.c
> > @@ -0,0 +1,28 @@
> > +#include "../../git-compat-util.h"
>
> nit: Just FWIW I think the better thing is '#include
> "git-compat-util.h"', i.e. we're compiling at the top-level and have
> added it to -I.
>
> (I know a lot of compat/ and contrib/ and even main-tree stuff does
> that, but just FWIW it's not needed).
>

Will fix.

> > +     if (!strcmp(var, "core.fsyncmethod")) {
> > +             if (!value)
> > +                     return config_error_nonbool(var);
> > +             if (!strcmp(value, "fsync"))
> > +                     fsync_method =3D FSYNC_METHOD_FSYNC;
> > +             else if (!strcmp(value, "writeout-only"))
> > +                     fsync_method =3D FSYNC_METHOD_WRITEOUT_ONLY;
> > +             else
>
> As a non-nit comment I think this config schema looks great so far.
>
> > +                     warning(_("unknown %s value '%s'"), var, value);
>
> Just a suggestion maybe something slightly scarier like:
>
>     "unknown core.fsyncMethod value '%s'; config from future git version?=
 ignoring requested fsync strategy"
>
> Also using the nicer camelCased version instead of "var" (also helps
> translators with context...)
>

Will fix.  The motivation for this scheme was to 'factor' the messages
so there would be less to translate. But I see now that the message
doesn't have enough context to translate reasonably.

> > +int git_fsync(int fd, enum fsync_action action)
> > +{
> > +     switch (action) {
> > +     case FSYNC_WRITEOUT_ONLY:
> > +
> > +#ifdef __APPLE__
> > +             /*
> > +              * on macOS, fsync just causes filesystem cache writeback=
 but does not
> > +              * flush hardware caches.
> > +              */
> > +             return fsync(fd);
> > +#endif
> > +
> > +#ifdef HAVE_SYNC_FILE_RANGE
> > +             /*
> > +              * On linux 2.6.17 and above, sync_file_range is the way =
to issue
> > +              * a writeback without a hardware flush. An offset of 0 a=
nd size of 0
> > +              * indicates writeout of the entire file and the wait fla=
gs ensure that all
> > +              * dirty data is written to the disk (potentially in a di=
sk-side cache)
> > +              * before we continue.
> > +              */
> > +
> > +             return sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEF=
ORE |
> > +                                              SYNC_FILE_RANGE_WRITE |
> > +                                              SYNC_FILE_RANGE_WAIT_AFT=
ER);
> > +#endif
> > +
> > +#ifdef fsync_no_flush
> > +             return fsync_no_flush(fd);
> > +#endif
> > +
> > +             errno =3D ENOSYS;
> > +             return -1;
> > +
> > +     case FSYNC_HARDWARE_FLUSH:
> > +             /*
> > +              * On some platforms fsync may return EINTR. Try again in=
 this
> > +              * case, since callers asking for a hardware flush may di=
e if
> > +              * this function returns an error.
> > +              */
> > +             for (;;) {
> > +                     int err;
> > +#ifdef __APPLE__
> > +                     err =3D fcntl(fd, F_FULLFSYNC);
> > +#else
> > +                     err =3D fsync(fd);
> > +#endif
> > +                     if (err >=3D 0 || errno !=3D EINTR)
> > +                             return err;
> > +             }
> > +
> > +     default:
> > +             BUG("unexpected git_fsync(%d) call", action);
>
> Don't include such "default" cases, you have an exhaustive "enum", if
> you skip it the compiler will check this for you.
>

Junio gave the feedback to include this "default:" case in the switch
[1].  Removing the default leads to the "error: control reaches end of
non-void function" on gcc. Fixing that error and adding a trial option
does give the exhaustiveness error that you're talking about.  I'd
rather just leave this as-is since the BUG() obviates the need for an
in-practice-unreachable return statement.

[1] https://lore.kernel.org/git/xmqqfsu70x58.fsf@gitster.g/

> > +     }
> > +}
> > +
> >  static int warn_if_unremovable(const char *op, const char *file, int r=
c)
>
> Just a code nit: I think it's very much preferred if possible to have as
> much of code like this compile on all platforms. See the series at
> 4002e87cb25 (grep: remove #ifdef NO_PTHREADS, 2018-11-03) is part of for
> a good example.
>
> Maybe not worth it in this case since they're not nested ifdef's.
>
> I'm basically thinking of something (also re Patrick's comment on the
> 2nd patch) where we have a platform_fsync() whose return
> value/arguments/whatever capture this "I want to return now" or "you
> should be looping" and takes the enum_fsync_action" strategy.
>
> Then the git_fsync() would be the platform-independent looping etc., and
> another funciton would do the "one fsync at a time, maybe call me
> again".
>
> Maybe it would suck more, just food for thought... :)

I'm going to introduce a new static function called fsync_loop which
does the looping and I'll call it from git_fsync.  That appears to be
the cleanest to me to address your and Patrick's feedback.

Thanks,
Neeraj

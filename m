Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8BFC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A1260EB1
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhGWQxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhGWQxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:53:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A365C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:33:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t14so2674189oiw.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ssC1zmIYQYnNpd+Yw6xbUNkS38SOJTFwn9rsYguar4Y=;
        b=IjUFxbnO3jIFrZsgGegntq9VC3hrIphpsmNNpeOh7aUaSRuRbCzDOI8OKIXawAZXd3
         nIxsa2Crnp12xE+SaGIhknQOouY3ho6b1y0TJTLU2hPayhWMAzHuqCuFBhDgAVsM4xVx
         h48dPXRG80AklwyD+5v+oj3ED+RvxAPqJK1VjMKtXYRW0/JXVVePFNG7n26S3ZF5EF6F
         CfMWYz2UgNayDsxdEVJB97wzP069R9ItfknoBFZutm3ZpPPdnuLBBPF9Z/I3CjErlSSQ
         2y9Xl137qWF8uFyqQ3g5OOB97Xznu4gWWB/NijHnziTdI7dQHSwbr0aoZBrscjIITooC
         EaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ssC1zmIYQYnNpd+Yw6xbUNkS38SOJTFwn9rsYguar4Y=;
        b=nCO3qe73qSWrRUiloLFftWmRuxVIQK8j0UZyjd1IjU017f47DnN2uNp8eIOnkC2Qq5
         mx2RMnKbPkcMQ8wneoqGYmItzaecRzf4KtXtDDMsWXvIMN5xlurtEY801GhCWuZrsjBO
         gTZajG5c5N1oliTVYS6M1utB5EDb92Ho/iumNxoXs8uzMorQ2CRIc0AVIVqaNkB+iIXE
         BUtTIkR8xvlQx7nmOOy/VBZcHqDoK6we0trbCX6reWElczkYdkuLzYPkgrRC0zR9KfB5
         nh6hoeJY+dkVKxZ/dtOFdDP34odiGVKuofpnqXNjxb4q2Tpa+cS+GZ2y5lT0fpRFkKUV
         M9nQ==
X-Gm-Message-State: AOAM533E3L0PhyA6/HqUsLJOD7Rx7LoB7wcITGOCxl7iPJZVCgMyWQ+K
        vzDzeBUB6GHvvU9ru8+hLxk=
X-Google-Smtp-Source: ABdhPJwTEjOhClHVbA2Ya/KFtQ51KzHYqhZ+8HRYRjggP7OlD2vrfCsbWTzLh0bZNbP6L029TcqVog==
X-Received: by 2002:aca:d682:: with SMTP id n124mr3836405oig.128.1627061636631;
        Fri, 23 Jul 2021 10:33:56 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m19sm5824043otp.55.2021.07.23.10.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:33:56 -0700 (PDT)
Date:   Fri, 23 Jul 2021 12:33:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60fafd8295996_defb208dc@natae.notmuch>
In-Reply-To: <YPnwBu4oMA9K445J@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-5-emilyshaffer@google.com>
 <87lf66y6pd.fsf@evledraar.gmail.com>
 <YPnwBu4oMA9K445J@google.com>
Subject: Re: [PATCH 4/9] hook: treat hookdir hook specially
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Emily,

Emily Shaffer wrote:
> On Fri, Jul 16, 2021 at 10:58:34AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> > On Thu, Jul 15 2021, Emily Shaffer wrote:
> > =

> > > Soon, we will allow users to specify hooks using the config. These
> > > config-specified hooks may require different child_process options =
than
> > > hook executables in the gitdir. So, let's differentiate between hoo=
ks
> > > coming from the gitdir and hooks coming from the config.
> > >
> > > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > > ---
> > >  hook.c | 3 ++-
> > >  hook.h | 2 ++
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hook.c b/hook.c
> > > index 19138a8290..3a588cb055 100644
> > > --- a/hook.c
> > > +++ b/hook.c
> > > @@ -117,6 +117,7 @@ struct list_head* hook_list(const char* hooknam=
e)
> > >  		struct hook *to_add =3D xmalloc(sizeof(*to_add));
> > >  		to_add->hook_path =3D hook_path;
> > >  		to_add->feed_pipe_cb_data =3D NULL;
> > > +		to_add->from_hookdir =3D 1;
> > >  		list_add_tail(&to_add->list, hook_head);
> > >  	}
> > >  =

> > > @@ -200,7 +201,7 @@ static int pick_next_hook(struct child_process =
*cp,
> > >  	cp->dir =3D hook_cb->options->dir;
> > >  =

> > >  	/* add command */
> > > -	if (hook_cb->options->absolute_path)
> > > +	if (run_me->from_hookdir && hook_cb->options->absolute_path)
> > >  		strvec_push(&cp->args, absolute_path(run_me->hook_path));
> > >  	else
> > >  		strvec_push(&cp->args, run_me->hook_path);
> > > diff --git a/hook.h b/hook.h
> > > index 586ddf40bb..60389cd8cd 100644
> > > --- a/hook.h
> > > +++ b/hook.h
> > > @@ -22,6 +22,8 @@ struct hook {
> > >  	/* The path to the hook */
> > >  	const char *hook_path;
> > >  =

> > > +	unsigned from_hookdir : 1;
> > > +
> > >  	/*
> > >  	 * Use this to keep state for your feed_pipe_fn if you are using
> > >  	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
> > =

> > The "from_hookdir" looks like it isn't used until 6/9, and maybe the
> > absolute_path change too? In any case this seems like a carried-forwa=
rd
> > rebase of
> > https://lore.kernel.org/git/20210311021037.3001235-5-emilyshaffer@goo=
gle.com/
> > or some version thereof.
> > =

> > At this point I tihnk it would be way better to squash this and other=

> > such changes that basically add a field to a struct that isn't used y=
et
> > into whatever commit use/need them.
> =

> I think at this point we run into you and me having different
> patch-storytelling styles - which probably is what led to the big topic=

> restart in the first place ;)

Yes, but as a reader of the story I prefer not to have to read the
entire thing in order to understand it. I prefer each page to tell a
small story.

> I'd prefer to see the "start using config too" patch stay as small as i=
t
> can; that's why I ended up with a handful of minor setup commits and
> then one "and now here's config" commit.

I'm in favor of small patches too, but not to the point where the patch
is not useful by itself.

This is where where patch storytelling and actual storytelling differ:
we don't need Chekhov's guns.

> Even if it's different from how you would tell it - is it wrong? (And i=
f
> it is, that's fine, and I'll change it, but I don't think it is - that'=
s
> why I structured the series this way.)

It's not wrong.

But one of the strongest advantages of open source is that you can have
many more reviewers than in closed source, and following Linus's law:
"given enough eyeballs, all bugs are shallow", that's a great thing.

But in order to fully take advantage of that you need to write patches
in a way that armchair reviewers can simply take a cursory look at the
patch and figure out that's obviously correct.

Putting my armchair reviewer hat I cannot do that for this particular
patch, I would need to do more work to make sense of it, and while I'm
writing this message to explains that, others will simply skip it, and
that's a lost opportunity.

Cheers.

-- =

Felipe Contreras=

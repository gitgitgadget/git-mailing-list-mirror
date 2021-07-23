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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D6C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2903B60E52
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 09:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhGWIsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGWIsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:48:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB83AC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:28:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r16so926860edt.7
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9U+2ZxaHZoR4CdXrOQPvOBLdMlovLUfX5h9qXpxp8Ss=;
        b=beej9bsHaya0OigQY0xcmj8Br/dTYNQuwbFm88ll0iljVn5k5j1xOEdDk6S780hANY
         NJduLTEqXA+otgLQ1PVWOfpxDn3IA72WNZhwUZmC6pI2YXr+8B6RdHniLrF86W9SQvxH
         vaUSCIydh2IHyVJ+Cp8WOsxJY8R8ee40Oxm++NyCOZgUA71QqImU3ZEx99XxfSstp90B
         asycKWUHITs3Sj2bGM2wcBzkWnR8Ypoa0b2KRSjDLk5DkRLH3J0ryOTx0E9bSBkjkAy8
         GTBqFgxgiODuiI/b2pFGVAnSTJJV6TZGbFqUvcZ7lDkz5p0pKRHgqI14MI5ByLDXEANj
         S43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9U+2ZxaHZoR4CdXrOQPvOBLdMlovLUfX5h9qXpxp8Ss=;
        b=QBFmHpsdKy7AOtHyTxJonieFuL/g/kESKOAMLNkaYAaZxmgHaQElSRiUOBqN/OhaCB
         Yke6dhz6qskwMGE2DXTFycyFzSw7Y2EzX+3zy22UrH7hp7FYswP8Y6Lmwt3MtSUfIKlc
         V+GN4DptWQCqA9boo/Ar/WUhZn4FM2fFqlMOfA2iB6f2oR3CGUekawlM0PaAN+duS7Yl
         fm/bbCxwxbXbLuM8yrgeAG4b+2zvMQRPT6gwuQiJLeLE8tsLPUcd/fSh+VMYfoZdg31t
         N5WYOhrvjWiBEk2CzsMshlPzKnXms2Td2ZDN1kIQjbtFLPQN6N2ZeF3ZTNFXRmuY6g/R
         h9rg==
X-Gm-Message-State: AOAM531T1QyvkuNIK/9zY7IJwIwm7qijmfNhLdj1+WnQUeAIXMCKG1xo
        YiyKEr1Ew/WLdKHDjD3rabY=
X-Google-Smtp-Source: ABdhPJymco1ksNyntxv7c/fCKDAJ5NkNTuTZJmrFR39qmkcMeFC66pmLfMNMBBFBxVAtyesKUNZGFw==
X-Received: by 2002:aa7:d703:: with SMTP id t3mr4511774edq.50.1627032513302;
        Fri, 23 Jul 2021 02:28:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d2sm10312317ejo.13.2021.07.23.02.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:28:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/9] hook: treat hookdir hook specially
Date:   Fri, 23 Jul 2021 11:26:56 +0200
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-5-emilyshaffer@google.com>
 <87lf66y6pd.fsf@evledraar.gmail.com> <YPnwBu4oMA9K445J@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPnwBu4oMA9K445J@google.com>
Message-ID: <8735s5tm3t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, Emily Shaffer wrote:

> On Fri, Jul 16, 2021 at 10:58:34AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>>=20
>> On Thu, Jul 15 2021, Emily Shaffer wrote:
>>=20
>> > Soon, we will allow users to specify hooks using the config. These
>> > config-specified hooks may require different child_process options than
>> > hook executables in the gitdir. So, let's differentiate between hooks
>> > coming from the gitdir and hooks coming from the config.
>> >
>> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> > ---
>> >  hook.c | 3 ++-
>> >  hook.h | 2 ++
>> >  2 files changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hook.c b/hook.c
>> > index 19138a8290..3a588cb055 100644
>> > --- a/hook.c
>> > +++ b/hook.c
>> > @@ -117,6 +117,7 @@ struct list_head* hook_list(const char* hookname)
>> >  		struct hook *to_add =3D xmalloc(sizeof(*to_add));
>> >  		to_add->hook_path =3D hook_path;
>> >  		to_add->feed_pipe_cb_data =3D NULL;
>> > +		to_add->from_hookdir =3D 1;
>> >  		list_add_tail(&to_add->list, hook_head);
>> >  	}
>> >=20=20
>> > @@ -200,7 +201,7 @@ static int pick_next_hook(struct child_process *cp,
>> >  	cp->dir =3D hook_cb->options->dir;
>> >=20=20
>> >  	/* add command */
>> > -	if (hook_cb->options->absolute_path)
>> > +	if (run_me->from_hookdir && hook_cb->options->absolute_path)
>> >  		strvec_push(&cp->args, absolute_path(run_me->hook_path));
>> >  	else
>> >  		strvec_push(&cp->args, run_me->hook_path);
>> > diff --git a/hook.h b/hook.h
>> > index 586ddf40bb..60389cd8cd 100644
>> > --- a/hook.h
>> > +++ b/hook.h
>> > @@ -22,6 +22,8 @@ struct hook {
>> >  	/* The path to the hook */
>> >  	const char *hook_path;
>> >=20=20
>> > +	unsigned from_hookdir : 1;
>> > +
>> >  	/*
>> >  	 * Use this to keep state for your feed_pipe_fn if you are using
>> >  	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
>>=20
>> The "from_hookdir" looks like it isn't used until 6/9, and maybe the
>> absolute_path change too? In any case this seems like a carried-forward
>> rebase of
>> https://lore.kernel.org/git/20210311021037.3001235-5-emilyshaffer@google=
.com/
>> or some version thereof.
>>=20
>> At this point I tihnk it would be way better to squash this and other
>> such changes that basically add a field to a struct that isn't used yet
>> into whatever commit use/need them.
>
> I think at this point we run into you and me having different
> patch-storytelling styles - which probably is what led to the big topic
> restart in the first place ;)
>
> I'd prefer to see the "start using config too" patch stay as small as it
> can; that's why I ended up with a handful of minor setup commits and
> then one "and now here's config" commit.
>
> Even if it's different from how you would tell it - is it wrong? (And if
> it is, that's fine, and I'll change it, but I don't think it is - that's
> why I structured the series this way.)

It's not wrong, if you'd like it that way sure.

The only reason I nudged you about it was that I assumed you'd perhaps
mostly rebased these one-at-a-time on top of the base topic, before the
base topic the patches were much larger.

There is some arbitrary cut-off-limit where it makes sense to split the
addition of code to be used later with the actual use, and that limit is
a matter of taste.

I thought perhaps given the base topic some of these patches should be
squshed given their new size, but if you've looked at them and think
it's fine as-is let's leave it at that.

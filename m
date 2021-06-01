Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9DC4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9030613AD
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFAKub (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbhFAKua (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 06:50:30 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DCAC061756
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 03:48:49 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h19-20020a9d6f930000b02903c0c4560e99so481300otq.1
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 03:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=LDpWMtYcp+oQqrWUUXroNfbnCxx38wWH2L8dT1oJ0d0=;
        b=AXyLQ29QX+atgulIYf6njFXayOGTtaWtpBQw8BpUjIYuUnu3Ucmt7FtIf5xPTv25UK
         POgZksY5e19Athti0rdqIIA5STvILwtGXcFpZ+GUUVRbYh6Efu5+fYs8G7qrZ9j6PiPr
         nJQ92NRpJnAvkc00x9f2UonfxkvzmW6YewUAd4yTLlARo3dhhs5nFpWJVWQkwbXwW9Cm
         hLpZj9+49xuasU/Q9B3DE/3Io0bgc9aV5AlW9v9c7xIcZ3hVfQC4GTVBdXf7M4laDAXj
         LbgOGEnql+QkrPUeRAmT8PN8T8mkJQ1/PQbSE5ECawOVDm1DRe3yvin8BBpkr2xYsXTH
         9V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=LDpWMtYcp+oQqrWUUXroNfbnCxx38wWH2L8dT1oJ0d0=;
        b=ijNsZSoszArNHJvQj0Ag6t31QYPgVS+DrbxTBH+73p9w53Hj5an7v8sq1mutbBh1ym
         nB0SroFrh4MnFq1RCPie05TWqtOc3EzCoByRsi486gdiCg7wXA9r85c8IWHLcjcNTNzc
         n1GGTccTI5sgNrX4DYJs8bKB/K5oYa+hGu2+p48z/FsQVGfOwqe1pPNG+j2L60IQWCjs
         1lWOt4Vqo3WK49VoQelMj9TmJfo0mNkfZ+Bgp+FaNPvj4Smkk5IjV5QOwe5XIN07hk0q
         915XT+vbWqf9uMQlz7pyvH/zJG7WmZyXDGzfHw2mudioR6A/5YAXO4j6P4rkCuqWQHDg
         rMlw==
X-Gm-Message-State: AOAM530SfamxrtMb86jXGObSpYQDP8bHtLfsQOaKvWBO2HsTQpy6uP+4
        yyHHMyvErgpsXYh9Wm2yB6Y=
X-Google-Smtp-Source: ABdhPJyEMO4ysPFm+eQOTIvX70AzIqQKRnx+naD9FXkiee597jemD5hbEIMwFT1nPJsOBUBskhqYYQ==
X-Received: by 2002:a05:6830:22d3:: with SMTP id q19mr21106749otc.258.1622544528303;
        Tue, 01 Jun 2021 03:48:48 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s24sm3342277ooh.28.2021.06.01.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 03:48:47 -0700 (PDT)
Date:   Tue, 01 Jun 2021 05:48:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b61089ba63d_e40ca20894@natae.notmuch>
In-Reply-To: <YLXl5+ronWhcGh13@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-01 01:24:01-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > The premise is simple: git.git developers are experts in git, and the=
refore
> > they have fine-tuned their ~/.gitconfig to a point that is pretty far=

> > from what any newcomer will experience for a long time.
> > =

> > How long can you survive with a pristine configuration?
> > =

> > Plenty of developers take many things in their configuration for
> > granted, they forget what the default behavior is, or worse: they for=
get
> > they actually have configured log.decorate, and are surprised when th=
ey
> > discover the reason they could not reproduce a bug report.
> =

> OK, the person that forgot having log.decorate configured is me.

Right. That's just the most recent instance I could think of, but I'm
sure similar versions have happened to all of us.

> > Now and then I cleanup my configuration to be reminded of that fact.
> > =

> > Anybody remembers merge.defaultToUpstream, and what `git merge` witho=
ut
> > arguments used to do? [1] What about sendemail.chainReplyTo? [2]
> > =

> > It's important that we force ourselves to experience what an
> > unconfigured git setup looks like, even if it's just for a little bit=
.
> > =

> > So the challenge is this:
> > =

> >   1. Remove all the configuration that is not essential (just leave
> >      user.name and user.email or equivalent)
> =

> How about alias? It's part of my muscle memory.

No aliases.

If a new user doesn't have them, neither should you.

All VCSs have default aliases, and I advocated for git to do the same
[1], but it wasn't accepted.

The whole point is to suffer like them.

> >   2. Pick 2 configurations you think you can't live without. You are =
not
> >      allowed to change them afterwards.
> =

> Something is essential when working on constantly integration tree,
> I don't want to make my life hard:
> =

> * rerere.enabled =3D true
> * rerere.autoupdate =3D true

If the defaults make your life hard, then shouldn't we change the
defaults?

For starters, which is the command you use? `git merge`? If so, maybe
`git merge` should have a --rerere option to enable rerere. There are
some --rerere-autoupdate, but no --rerere.

Additionally, who doesn't want autoupdate when rerere is manually
enabled?

If we all want autoupdate enabled (at least I do), maybe the default
should be flipped, so all you need in your configuration is:

  rerere.enabled =3D true

But, if we are already on this topic... who wants rerere disabled by
default?

> Something is there to shut up advice, I can live without those
> configuration value, though (I don't use git-pull these days, anyway):
> =

> * pull.rebase =3D false

Can you train your fingers to type `git pull --no-rebase` for a while?

> Working with patch based need:
> =

> * sendemail.smtpserver
> * sendemail.smtpencryption
> * sendemail.smtpuser
> * credential.helper

You could use msmtp instead, but fine, let's make an exception for
transmission of patches (credentials, SMTP, etc.) These are not options
that can be changed in git.gt by default.

But only the essentials, no sendemail.confirm.

> My GnuPG key is Ed25519, and gpg v2 in my machine is named gpg2, so:
> * gpg.program =3D gpg2

You could have an alias in your ~/bin directory:

  ln -s /usr/bin/gpg2 ~/bin/gpg

That way you don't need to configure every program.

But fine, this is an exception too. The location of programs is not
something that can be changed by default.

> And I would like to try new shiny features:
> =

> * feature.experimental =3D true

Interesting. I didn't know that existed, and I advocated for a
similar configuration: core.mode [2].

But if most newcomers can live without it, I'm sure you can too for a
bit.

> >   3. Every day you can add 1 additional configuration (and update it =
the
> >      next day).
> >   4. The moment you add a 4th configuration you lose.
> =

> So, my baseline already requires 8 key-value pairs (ignoring alias and
> pull.rebase). I'm lost already.

With the exceptions I think you only need these:

 * rerere.enabled =3D true
 * rerere.autoupdate =3D true


But the point is that if you can't live with git defaults, that should
tell us something.

Cheers.

[1] https://lore.kernel.org/git/1379791221-29925-1-git-send-email-felipe.=
contreras@gmail.com/
[2] https://lore.kernel.org/git/1381561485-20252-1-git-send-email-felipe.=
contreras@gmail.com/

-- =

Felipe Contreras=

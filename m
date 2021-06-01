Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA22C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 11:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5080F61287
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 11:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhFALmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFALmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 07:42:01 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08647C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 04:40:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n12so7238043pgs.13
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 04:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=92NM6H8Dagk/9DDIZTIhks+FSn1vRzCn8szXwhWRzXg=;
        b=ixpTaLLGjCibt5mZYGoQWzlXo0p28BXGG2bwVvOYem/XS9XOKmpJNJfIelJPEZSq4r
         KrAYwipL8T9B5J6nz/7u0/xAKPraO0k9IphccgVDz8woNd/H2sXl2eI626koBtO7TN/d
         hZ/voczMnvRY/K2FjO1mhbM2XPAH5+0ZPSfbyN2ZT9Q+uUjCYF51EMuNkNUkKzFcrjHW
         A8yXoLF0Yy6NAW420aM3JN9FUYw+4cOHEnwxqKLUSp/YiKA0xlyPYjTx3Bi+651It3J1
         S+A7gKlMBeefirifvx8bgphbnW+0S+qcNGSFOOQA2qG6VBpzKEVK2vOf+8urJmEuGN5n
         a0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=92NM6H8Dagk/9DDIZTIhks+FSn1vRzCn8szXwhWRzXg=;
        b=l0sSMzi5a8p5oa6wV/zIweZt5+4rFohmFV42Y39NBH0BiyIXtsVSnhrySW+4qVIou+
         KQuythKJYU7RCLOnEjUYFOQE/8Ym4YzZ/Pe3qFahQTtqlGvMqOj+222tEJVbdOrD/z7Q
         /f43TRp9fFH8pon+N8pYie+OuTclveCQthhNkdnjkKg/UcfurXTugDiln0nLdmuWJjhb
         twbL5rfwFyW7b2C8cpM6nnCzX5Sl3htjWs3PZ7aRz+aYkprZlmDHRATXHrPSasTlgPeR
         W3pCBk9ZWx4FPaf2jctEQSDtJX9MNd+QI26g8lLfn0J81NyDhiB7O4bv1OhyNn3eO+zX
         BUzw==
X-Gm-Message-State: AOAM530oegPLYOoIIVDRMw7yMpocclcVsZ8dqAmRtrigsxqjT7PUtDbC
        UVt1WLwpUom6MY4QVfzSx2VB3dOcv64+GQ==
X-Google-Smtp-Source: ABdhPJxLNyAyMgsX1oaHr+HgfO/Pv3P/KOLCdXpKecA9nU4vlRPsR7I6m7ZAE4UsK4gxOjxPgcoTKQ==
X-Received: by 2002:a62:1701:0:b029:2e9:a8ed:fcce with SMTP id 1-20020a6217010000b02902e9a8edfccemr16113818pfx.19.1622547618336;
        Tue, 01 Jun 2021 04:40:18 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id p17sm2133266pjg.54.2021.06.01.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:40:17 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:40:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Message-ID: <YLYcnwZQAEoSQKsG@danh.dev>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <YLXl5+ronWhcGh13@danh.dev>
 <60b61089ba63d_e40ca20894@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b61089ba63d_e40ca20894@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-01 05:48:41-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> Đoàn Trần Công Danh wrote:
> > On 2021-06-01 01:24:01-0500, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > > The premise is simple: git.git developers are experts in git, and therefore
> > > they have fine-tuned their ~/.gitconfig to a point that is pretty far
> > > from what any newcomer will experience for a long time.
> > > 
> > > How long can you survive with a pristine configuration?
> > > 
> > > Plenty of developers take many things in their configuration for
> > > granted, they forget what the default behavior is, or worse: they forget
> > > they actually have configured log.decorate, and are surprised when they
> > > discover the reason they could not reproduce a bug report.
> > 
> > OK, the person that forgot having log.decorate configured is me.
> 
> Right. That's just the most recent instance I could think of, but I'm
> sure similar versions have happened to all of us.
> 
> > > Now and then I cleanup my configuration to be reminded of that fact.
> > > 
> > > Anybody remembers merge.defaultToUpstream, and what `git merge` without
> > > arguments used to do? [1] What about sendemail.chainReplyTo? [2]
> > > 
> > > It's important that we force ourselves to experience what an
> > > unconfigured git setup looks like, even if it's just for a little bit.
> > > 
> > > So the challenge is this:
> > > 
> > >   1. Remove all the configuration that is not essential (just leave
> > >      user.name and user.email or equivalent)
> > 
> > How about alias? It's part of my muscle memory.
> 
> No aliases.
> 
> If a new user doesn't have them, neither should you.
> 
> All VCSs have default aliases, and I advocated for git to do the same
> [1], but it wasn't accepted.
> 
> The whole point is to suffer like them.

OK.

> 
> > >   2. Pick 2 configurations you think you can't live without. You are not
> > >      allowed to change them afterwards.
> > 
> > Something is essential when working on constantly integration tree,
> > I don't want to make my life hard:
> > 
> > * rerere.enabled = true
> > * rerere.autoupdate = true
> 
> If the defaults make your life hard, then shouldn't we change the
> defaults?
> 
> For starters, which is the command you use? `git merge`? If so, maybe
> `git merge` should have a --rerere option to enable rerere. There are
> some --rerere-autoupdate, but no --rerere.

I think both pull, merge, rebase, cherry-pick, revert, checkout,
switch, apply, am will be affected by rerere.

> Additionally, who doesn't want autoupdate when rerere is manually
> enabled?

Dun know. I guess someone applies other people patches
with their rerere logs.

> If we all want autoupdate enabled (at least I do), maybe the default
> should be flipped, so all you need in your configuration is:
> 
>   rerere.enabled = true
> 
> But, if we are already on this topic... who wants rerere disabled by
> default?
> 
> > Something is there to shut up advice, I can live without those
> > configuration value, though (I don't use git-pull these days, anyway):
> > 
> > * pull.rebase = false
> 
> Can you train your fingers to type `git pull --no-rebase` for a while?

I don't use git-pull nowaday, so, I don't care.

> 
> > Working with patch based need:
> > 
> > * sendemail.smtpserver
> > * sendemail.smtpencryption
> > * sendemail.smtpuser
> > * credential.helper
> 
> You could use msmtp instead, but fine, let's make an exception for
> transmission of patches (credentials, SMTP, etc.) These are not options
> that can be changed in git.gt by default.
> 
> But only the essentials, no sendemail.confirm.
> 
> > My GnuPG key is Ed25519, and gpg v2 in my machine is named gpg2, so:
> > * gpg.program = gpg2
> 
> You could have an alias in your ~/bin directory:
> 
>   ln -s /usr/bin/gpg2 ~/bin/gpg
> 
> That way you don't need to configure every program.

Fair!

> But fine, this is an exception too. The location of programs is not
> something that can be changed by default.
> 
> > And I would like to try new shiny features:
> > 
> > * feature.experimental = true
> 
> Interesting. I didn't know that existed, and I advocated for a
> similar configuration: core.mode [2].
> 
> But if most newcomers can live without it, I'm sure you can too for a
> bit.

The point of trying new shiny features is dogfooding ourselves and
report bugs early, if any.

> > >   3. Every day you can add 1 additional configuration (and update it the
> > >      next day).
> > >   4. The moment you add a 4th configuration you lose.
> > 
> > So, my baseline already requires 8 key-value pairs (ignoring alias and
> > pull.rebase). I'm lost already.
> 
> With the exceptions I think you only need these:
> 
>  * rerere.enabled = true
>  * rerere.autoupdate = true

OK, let's start there.

-- 
Danh

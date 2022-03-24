Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0CCC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 22:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355539AbiCXWtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiCXWtq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 18:49:46 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C02E0B3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:48:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o6so8118319ljp.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 15:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xQ0QbQSpd9HpWS2wAbd8EJInJz2//qgKSjQBB5QzDU=;
        b=T1qwTYZRxhAP7rXO+4MtQNC70rLM1JQjGPohpkvDgRpX0/4kECbO/fEnbNF0NAJvl8
         avUyBuY0ZLhl1dAryUNvQnW8RDOHuWRowWV6Dn4GYrmuxcjqao9VEzZJa0kakpCfGvJy
         HPh5gSDYoAsqJ7mhthEzK2c9x2jo1PPwgT+JyVQyyHZeTl1rsgZgcJQFTtfeVXt1hrG9
         y+EtM5V5TuZJ2vdHnD/e8XLA/odWrmBaq7UFClvbEzDSSlaOhJ5Wow+mg5xMAytJDCbJ
         SK2Dv4+hxdUU0Gxn+2dEwIr+LNFmwDq0/a7qXdcPDPlDpSckSJFG+YaVskffEHGQIgSe
         xjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xQ0QbQSpd9HpWS2wAbd8EJInJz2//qgKSjQBB5QzDU=;
        b=FsQ6KzjrKLQs44WDA9W9ifQsYISncMQcdwIQ7YzFidaoxmJKKRbfzfsY/qihZrtb1N
         ab0rLQsCzzpxzr9VLeCkAV3hhQn01eosqC0lp6LHXCf2SQREr6moKAkV3+bvekA2+W03
         MeWIXAhISqXgt8/gw4L+jlI9AjVIgBgv7FZSsIqvlf4etLR+l36311KdMTihwZW6JtS2
         otGkfsLDwZwpQHfGDcp74HKsAvwqd43v+PHX9ovSmSm5KkmOhIr8PLG9aGgQI7Ieoval
         biUNPFh4My7U+dk8COONbHuq6Kfip7vBe/UJEvwB9gBJiNom+fdQfS5EfYQyZkOvu5uA
         kq2g==
X-Gm-Message-State: AOAM532T8QihE327EhCVI+q+S/A1QiYbkB0BVngU+lC0P32Vw3kC6h6R
        VqMPIE5ps0gAdOB+iE15GF04abI/tYqi8iuziWvjTFLb17DF2g==
X-Google-Smtp-Source: ABdhPJzXqDEoGhrPW5wWIMiYNFVyRWCyQZmekHHEFFebE4pfW9nTP9tFNIknLko+SwxPs2QFFCyK6AvsZiMu3SKY7pU=
X-Received: by 2002:a2e:b88b:0:b0:249:8a0b:ad3d with SMTP id
 r11-20020a2eb88b000000b002498a0bad3dmr5962850ljp.53.1648162090002; Thu, 24
 Mar 2022 15:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+ZGDOUKrNRdf-7+SBoVhPkAmyHEtt==AJ=jBDWGkOUcz=n4BA@mail.gmail.com>
 <CAJoAoZmo4bJgGdYQeM4XtRJHOpm4z7Gvg=qpUc4xa7Ap=v++UA@mail.gmail.com> <Yjziu8nU/SZ7SyH0@nand.local>
In-Reply-To: <Yjziu8nU/SZ7SyH0@nand.local>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 24 Mar 2022 15:47:58 -0700
Message-ID: <CAJoAoZmfLaxTGGQRaR8D0-L3pH563z6_04UUwBo7GY1A14Ebww@mail.gmail.com>
Subject: Re: bug report: pre-push hook
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?Honza_Proke=C5=A1?= <proke.j@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 24, 2022 at 2:29 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Mar 24, 2022 at 11:30:16AM -0700, Emily Shaffer wrote:
> > > What happened instead? (Actual behavior)
> > > Tests seem to execute on the background, but I do not see output
> >
> > I wonder - are you printing your test output to stdout, or stderr?
> > stderr of the hook is printed to stdout of the Git process, so that
> > may be why.
>
> I didn't think that we redirected the pre-push (or any) hook's stderr to
> stdout in the parent process. I wrote a small pre-push hook which is
> just:
>
>     $ cat .git/hooks/pre-push
>     #!/bin/sh
>
>     echo >&2 "hi!"
>
> and then:
>
>     $ git.compile push ttaylorr --dry-run 2>foo
>     $ grep hi foo
>     hi!
>
> But I might be holding it wrong, since I am not a frequent user of
> hooks.

Ah, it seems I'm completely mistaken :) Sorry for the misinfo. Urk.

Having a look in 'master', run_pre_push_hook() does not use hook.c
machinery yet at all; it also seems like it doesn't try to capture
stdout from the pre-push child process anyways. That makes me ask "how
did this ever work?" which brings me back to wanting a small hook we
can try to reproduce with from Honza :)

 - Emily

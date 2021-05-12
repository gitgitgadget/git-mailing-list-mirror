Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E29DC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3A061278
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhELBpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhELBpu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:45:50 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF93C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:44:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so9062749otg.2
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=gI/3BAUkUzKk0ChjFNcnvI5OIC+bQ3JUTY46PWSn6D4=;
        b=TXficahoa5Hy+imfjqOhVRULz7X0hxFkattsLGGiA0nkZ9EzUl81vEEl0sl+XyjzqT
         kIzuO4zxX/Z9kn+SYg1GTZQzcX8IdqMGw+0tiVMyPS1//BYYouecAWLLfzigNX16EoLG
         hBlgO00Avl477ngIR2ROINDjij+Z4K0H+3zSqGZ54fzw4eEX8fkSOMS5SMlIoiB+F90N
         O7MqXJeylYDqgfFgYnsGxIFgwRo/QUxiZ92eEiwwTUHSUTYiKU7teP3sxMPgz4un0fav
         pAFPw4fWL8OV/TXI6r3coPwJmtPcoTr6N5/5W7wg9VpjnjnvWbyjLRvb9IFc1L/cpdMN
         8UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=gI/3BAUkUzKk0ChjFNcnvI5OIC+bQ3JUTY46PWSn6D4=;
        b=SeWWq4Tne1XQEsQ0N2TWOv8lkWy0LvG3ZFePqc6gbXoAQgUXwiW+qxxJT2wK2hbyfW
         Cuyaugpbhv95mz5u2KZdZWH9N31i/xFzb/Pn8qCHnEGcgJtDiUxP1sFEz8QlDwzYA5nX
         TXbPTk0ZfP+F2hh6F9s7fI8YSj6kuOM3AbAbrnqjLoiBA0mLZOSStfGCN5xacmQDTcOe
         BwdHJPbXzqYfp8duGcWhCCT4N2d4/mhOdKDYJNqT9dzLEFx3OaCx6FJKZcngouLcc4zd
         sd1MGkYuULDgssE7h1FyTnOObncIWaSVUcZmvkPZJFEfFdr2t4kW8EN3/6hxuxeUsrAJ
         NrFw==
X-Gm-Message-State: AOAM530s/952+3BDQW17u+LRzaBoFtYDf3lL1VKGrK4qiGQvOtrfvK+r
        gWmbXeM/DflEui5P2qm/2yk=
X-Google-Smtp-Source: ABdhPJzZmyXBPxkWQKObQ4HMiVnvZXztddTnLNtqWhFQGR6D+CwEi8/Vdg0pVpIpaBpkqQDMQqYLPQ==
X-Received: by 2002:a9d:17e9:: with SMTP id j96mr29069996otj.143.1620783882247;
        Tue, 11 May 2021 18:44:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id x2sm3681615ooe.13.2021.05.11.18.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:44:41 -0700 (PDT)
Date:   Tue, 11 May 2021 20:44:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <609b330873c0a_678ff20833@natae.notmuch>
In-Reply-To: <YJsPuU5eLO8TkY2L@camp.crustytoothpaste.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
 <YJsPuU5eLO8TkY2L@camp.crustytoothpaste.net>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-11 at 04:27:54, Felipe Contreras wrote:
> > I've never understood developers worried about how the bleeding edge
> > would build in ancient platforms, when ancient platforms don't care
> > about the bleeding edge.
> 
> Debian stable is a common environment to do development on.  I know
> people who do use it for Git development, so I suspect we'll want to
> continue to support it.

I didn't mean to suggest otherwise.

> Yes, people _can_ run "gem install asciidoctor", but people who are not
> Ruby developers generally would prefer a distro package over installing
> one-off gems, especially since getting the binaries into PATH is tricky
> with gem.

Yes, but there's only so much we can hold hands with our users.

If a user:

 1. Uses an acient distribution
 2. Wants to build the documentation
 3. Enables USE_ASCIIDOCTOR
 4. Doesn't know Ruby
 5. Wants to use distribution packages
 6. Is bothered by the output

I think it's valid for the project to say "you are on your own". In
fact, not really that because if they contact the mailing list we would
help them.

The only thing we could do is print a warning if they try to build with
versions of asciidoctor that we know are problematic.

That being said; it's not "tricky" to get binaries into your PATH:

  export PATH="$GEM_HOME/bin:$PATH"

And you don't need to get gem binaries into your PATH:

  export GEM_HOME=/tmp/gems
  gem install asciidoctor
  make USE_ASCIIDOCTOR=YesPlease ASCIIDOC=$GEM_HOME/bin/asciidoctor doc

Works just fine without modifying PATH.

> > > It's not too hard to install an updated gem, but not quite as nice as
> > > using the system package (it also makes things weird for building the
> > > stable Debian package itself, which would want to rely only on other
> > > packages; but of course any proposed change to the doc toolchain would
> > > be for new versions, and would not get backported there anyway).
> > 
> > Anyone trying to build git master on top of Debian stable 1. probably
> > can live with the output of the current doc toolchain, and 2. probably
> > doesn't exist.
> 
> I believe I have just demonstrated that 2 is false above.

I meant trying to build the documentation of git on git master.

> > > > I think what I'm arguing for is
> > > > 
> > > >   1) switch the default to asciidoctor,
> > > >   2) enable optionally using it without xmlto,
> > > >   3) figure out what broke and fix it, and document which is the minimum
> > > >      asciidoctor version we're going to bother with for (2),
> > > >   4) lather, rinse, repeat (3),
> > > >   5) switch the default to not using xmlto,
> > > >   6) drop the xmlto way of generating the manpages(?).
> > > 
> > > I'm unclear when support for python asciidoc goes away here. Is it part
> > > of step 6 (because it does not have another way of generating them)? Or
> > > does it live on forever as a non-default legacy system? I'd prefer not,
> > > but as long as we are clear about the primary target and leave it up to
> > > people interested in the legacy to do the compat fixes, that might be
> > > OK.
> > 
> > How about we leave the legacy system in place as an alternative, and
> > decide later what to do with it?
> 
> I think it would be fine to just leave it in place for now and let
> people decide which toolchain they'd like to use.

Agreed.

-- 
Felipe Contreras

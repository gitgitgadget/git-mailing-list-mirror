Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A539C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 21:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB49161073
	for <git@archiver.kernel.org>; Fri, 21 May 2021 21:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhEUVmA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUVl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 17:41:58 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678FC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 14:40:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so8151140otk.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=moEYBAvurDms+Tr+lEhVw+amBm0P92DiCL4i5S42Bfk=;
        b=vX8qCkhnseMRi/JWK4GkpzF6BDVIURkR/2aL74531uCEZ8Jso1xJPqPI4URn81dIhb
         d1f4NZOqUvh4RYa2hBc8gvNb/gzp0rKTqbWOpYMtlgvwTmpy2ljBtyEV5vWn/x/TP9zt
         XjCHZwf72zf7gBdaGdTj9l/lwtj59yKa3m9HgmQlfrTQ7rEJUIFtTHBIKoD6rlUjSmrr
         hmAwQfJl3PX0Ou6BmgcY88/xFh4A875sHQ00dtXOpUdzQIszqJOqpJ30EbM8UNJSnoSq
         r8IUmSDXJW8efum8Clx+HJCwx39mMXJ20UMmj/DV4oz2f2j6jACBXMO7bGl+EV7jSNZs
         0GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=moEYBAvurDms+Tr+lEhVw+amBm0P92DiCL4i5S42Bfk=;
        b=oC4IVhVFANfomwg2bEBEbFlkR2U1zVbGvAyllrJFcgjl6dm8SxshbD/AAJmRZzsNzm
         ILQ+kzAZd/aowx2X+kv6UGum5IymGgO0RMcc4yvOeg4JGcgu12UzmPs+wIwk1MvobusA
         Hz0L1Coj1wmaft1RHCNHquCubr4vht+5EARQ4nwnjZqdMBVqhYnvWLKJ99u8t/2acgIn
         fLpB60CyJFhRDW9iZW8WrbRg3wwcMoZj4C8XQvJdvs6Ldxb452XO6aUe6/+W5yUVc4oy
         2TmZaIkt/zcDJRMhFtyqR6dSVFATvQJ5mEf4wMnYiGF/i0//9Z0S03dhF6YIgPNpJiNP
         2faw==
X-Gm-Message-State: AOAM532K0oAjmITOgwuXircDVqexzIYdsj6GMWo/pQWgknvqlJwKhYuM
        3vszfE3WnjHrM08Jin8YQbU=
X-Google-Smtp-Source: ABdhPJxSeNRJWkHam6cRpg/iOpm+vVryZAE0XFnPFLY75K/d1fM9oFYUlQnp3BMhts2J82cNSbx9sQ==
X-Received: by 2002:a05:6830:110:: with SMTP id i16mr9862920otp.249.1621633232885;
        Fri, 21 May 2021 14:40:32 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 88sm1491864ott.51.2021.05.21.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:40:32 -0700 (PDT)
Date:   Fri, 21 May 2021 16:40:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a828cebd2f1_77e4f208b2@natae.notmuch>
In-Reply-To: <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <xmqqbl94smjb.fsf@gitster.g>
 <YKdy5jhHgG2who27@coredump.intra.peff.net>
 <60a7f57fe3301_5503920831@natae.notmuch>
 <YKgXXCvWYI9rjKJT@coredump.intra.peff.net>
Subject: Re: [PATCH v4] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, May 21, 2021 at 01:01:35PM -0500, Felipe Contreras wrote:
> 
> > > I still don't understand what we gain by making this a Git feature,
> > 
> > What do we gain by making `git diff` output color?
> 
> Huh? Git is outputting the diff. Who else would output the color?

Do you think our users know or care which binary has the final
connection to the tty?

Many probably think git is sending the output to `diff --color -u`, and
it doesn't matter at all.

> > > Why would we do that versus saying: if you want to change the colors in
> > > the tool that Git calls, then configure the tool?
> > 
> > Once again... How?
> 
> By exporting the environment variables that ask it to do so, just like
> you showed already?

Exporting MANPAGER is not enough. That would only work on systems that
have SGR disabled.

The user would have to in addition export GROFF_NO_SGR=1, but that would
disble groff color for everything, which may not be what the user wants.

There is no MANGROFFNOSGR.

> > > If you like to see colors in manpages, why not configure "man" (either
> > > by setting these environment variables all the time, or by triggering
> > > them in MANPAGER)?
> > 
> > Let me try that...
> > 
> >   MANPAGER="less -Dd+r -Du+b -Ds+m" git help git
> > 
> > It doesn't work.
> 
>   ESC=$(printf '\33')
>   export MANCOLORS="LESS_TERMCAP_md=$ESC[31m LESS_TERMCAP_me=$ESC[0m"
>   export MANPAGER='sh -c "eval $MANCOLORS less"'
>   man ls
>   git help git

That still doesn't work here.

https://snipboard.io/GmhRtU.jpg

I see the default docbook colos generated by groff, but not the ones you
specified (both on `man` and `git help`).

I need to do this as well:

  export GROFF_NO_SGR=1

Your system probably has groff's SGR disabled in /usr/share/groff/site-tmac/man.local

It's not that simple.

There is in fact a way to configure man to do what we want here but if
*nobody* knows what that way is, then does it really matter?

Cheers.

-- 
Felipe Contreras

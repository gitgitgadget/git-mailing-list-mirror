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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4F3C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85D9613F6
	for <git@archiver.kernel.org>; Fri, 14 May 2021 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhENTER (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbhENTEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 15:04:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76166C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:03:04 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c3so405416oic.8
        for <git@vger.kernel.org>; Fri, 14 May 2021 12:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Q3Cca8GK3ZhN8V9T5pVWLNd4iGtc4hjgzWTU2tsq19s=;
        b=vBfV0rS7PFCfy/HxByfbp/Pt+d/rYAV4TSlCxkIxvjhdklHhDvE30cddnOw+7rq6+8
         1GKJUkYhB9/NIrV8TRH99CPUTB4KtItvnAxQp62/ssi78UQ3ixv2TQy+uQCCdOrM7Z4p
         PKnQK+GUlBsXjq6HSgIAj+f/STwhtsf4MJ3IpSp8Yphj+bnCMdAhKpPVmVdnR85aibhP
         97fp7qAFxbCeDDmxy2ZoyVgLa7siAInt05AEznUIY+WouyLcLHXCvpoKeAFSkNfITQAB
         8sXmbsON3ArL62g7d6SBnc1rK4h4YHyfWK+UCKeYsb5DhnTChSrDHg+CwmS90opYQfUm
         4l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Q3Cca8GK3ZhN8V9T5pVWLNd4iGtc4hjgzWTU2tsq19s=;
        b=sWZybIKIHe5OVcgM5l6uMxaT1XuFBzrT539cu+rLN3/pm7OYkg+8o0mnv/6zk95FDu
         xR5gLA/oHvdE2C1jCdg4Hv+K0iAIhWQjobHzAISWfEWBEHRyHftd0ssYPlOriOepJoqt
         Id2wiFDJyAM6+IY0kBvnF6Ayt0LlnTmw9O69oQ+f9q/2hIEAdJFFznAur3X29rjRNxY0
         t72Oz/CZ3lva57Gsw0X5o1J/R+T4CiL7SBoFAAaGt7lfAs320dwAcjhoUnBocG8E5qd1
         HaBgdBN9imFdbICtEOhzC8Nwsn5lLpFA7uVplPlveWNtSr/9hBsj4okf3ioSP6ulyPds
         bkUA==
X-Gm-Message-State: AOAM531Y3ygLbrXNr5z1Qe2zO7CrjzGflwhx2pMeDy3vqCkHG+z0uKdo
        L4wHV5TYMu1+L1fgZpFLn9I=
X-Google-Smtp-Source: ABdhPJxdu2Xj9MmNNoijW/kl5VP7mTKRqe6h38MuDsvnvoZoW1qDQHlqPtbsoVjRwYutj9I3hMFaZg==
X-Received: by 2002:aca:3385:: with SMTP id z127mr34694480oiz.23.1621018983600;
        Fri, 14 May 2021 12:03:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p1sm1537724otk.58.2021.05.14.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 12:03:03 -0700 (PDT)
Date:   Fri, 14 May 2021 14:02:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609ec960cc2f8_43127208a4@natae.notmuch>
In-Reply-To: <YJ24WIpnwE4LBOMt@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <609b5c85b7c61_678ff20848@natae.notmuch>
 <YJ24WIpnwE4LBOMt@camp.crustytoothpaste.net>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-12 at 04:41:41, Felipe Contreras wrote:
> > brian m. carlson wrote:
> > > since some common distros are > still on 1.5.
> > 
> > Are "some common distros" namely Debian stable *exclusively*?
> > 
> > If so, I would consider flipping the default the other way around,
> > espececially since it's only te default shipped by the Debian stable
> > packages (easily fixed by `gem install asciidoctor`).
> 
> CentOS 7 and Ubuntu 18.04 also ship 1.5.  CentOS 8 does not appear to
> ship Asciidoctor at all.

I does not matter what version of asciidoctor they *ship* with.... At all.

I happen to have accesss to an Ubuntu 18.04 machine...

  time gem install --user-install asciidoctor
  real	0m3.179s

It took me 3 seconds to get asciidoctor-2.0.15.

Ubuntu 18.04 ships with ruby 2.5.1p57 (2018-03-29 revision 63029). And
that's all you need.

> > > If users are using a more modern toolchain or don't care
> > > about the rendering issues, they can enable the option.
> > 
> > The other way around: if users are using an ancient distribution they
> > can disable the option.
> 
> Debian stable is not ancient.  It is less than two years old, which for
> a Linux distro or any operating system distribution, is not at all
> considered even reasonably old.

I guess your definition of what's "old" and mine are *very* different.

But the problem doesn't come from when the distribution was released,
but when the packages *inside* the distribution were released.

> I am not going to propose or give my approval to a change that causes
> problems building Git with the distro packages on Debian stable or the
> latest Ubuntu LTS, in any way, shape, or form.  People should be able to
> use the distro packages if that's most convenient.

My proposed changes do not cause any problems building Git with any
distro package on Debian stable or the latest Ubuntu LTS in any way,
shape or form.

> > > Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > 
> > Commit-message-by: brian m. carlson <sandals@crustytoothpaste.net>
> > 
> > I certainly would not want to pretend to have written the text above.
> 
> I'll reroll with the author reset.

Thats is not what I just requested.

> > > diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> > > index d906a00803..40fa87b121 100644
> > > --- a/Documentation/asciidoctor-extensions.rb
> > > +++ b/Documentation/asciidoctor-extensions.rb
> > > @@ -15,6 +15,8 @@ module Git
> > >            "#{target}(#{attrs[1]})</ulink>"
> > >          elsif parent.document.basebackend? 'html'
> > >            %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
> > > +        elsif parent.document.basebackend? 'manpage'
> > > +          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
> > 
> > I still prefer my original version, especially since:
> > 
> >  1. I suspect most git developers are familiar with printf directives:
> >     %s.
> >  2. Where is that \\fP coming from? I don't see that with xmlto, nor the
> >     publicly genrated man pages[1].
> 
> That's coming from my knowledge of troff, having used it extensively
> over the years, and my general hesitance to affect global state.

Good. Send it as a *separate* patch.

Most people in the mailing list are trying to **minimize** the diff
between asciidoc+docbook and asciidoctor, not piggyback improvements.

If you want to flex your troff knowledge do it as a separate patch,
without my authorship, or s-o-b line.

> >  3. Doesn't work on my machine without my original \e; I see
> >     "\fBgittutorial\fR(7)".
> 
> Works just fine on my system using Asciidoctor 2.0.12.  The \e would
> insert an additional escape character and shouldn't be needed unless
> we're in copy mode (which we should not be here).

I fail to see how that could work since asciidoctor replaces '\'
with '\(rs'.

This is a simple test that reproduces the issue:

  ruby -r asciidoctor <<\EOF | groff -Tascii -man | less
  puts Asciidoctor.convert("This is a \\fBtest\\fR.", backend: :manpage)
  EOF

Those that work in your machine?

This happens both with v2.0.12 and the latest master (2.0.16.dev).

Cheers.

-- 
Felipe Contreras

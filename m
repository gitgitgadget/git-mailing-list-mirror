Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C38C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNMkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDNMkt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:40:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB3B44E
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:40:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id x22-20020a9d6296000000b006a42c37ddcdso3335161otk.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681476007; x=1684068007;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3a61vEJDeUh+3FN2l/GoMLUbRyPMyvUXptAT4ie23y4=;
        b=cHnSsk8KrgVTpjNRvmh/sRfWrf19vXmcH01bO0M8Uij+s9VPe3OuJgVxF8tAvacFFg
         /aRFXIFenalilS2Rr9AYnMJo7n3JFi+ieKQMQbcuSqbMF30MpQvK5YTzSpmD6JylfxBR
         dY+YUJ9Ua+th5YhlpJ5so1qfYqt3lu8x4+r2qBlCHmi1Nj/y87LDFiAzdJWpZzfkzNod
         OIYyxlPaCRYmA2NYbwxx559W+Sc56+BFbFG1nbI8kv+2zq7XUpjYg5psCm8U8uJVm/3K
         UqZq2td4kghhyu7VdUY0I6581VzFatzTKE1I4vA1LVMN812voApWbE00gd0Fyt0Q9XWD
         yzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681476007; x=1684068007;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3a61vEJDeUh+3FN2l/GoMLUbRyPMyvUXptAT4ie23y4=;
        b=V1Rbo+nnvE+SyybIJ3vZv3cVGEIFiEIEAX4AQOAHtoXu+Fsx3iuy8+0tanzga5OGvQ
         SppFRPJhKf/kAKZT1T8KT9kF5rKbk/yQfGGOj1Ryo6DqeehdHUvYlkxEx6VJzIImyqKQ
         46EAgljyaRb90nJlDgUMkExc9gsaIzODAtrD0w+vwiuY6Tw+wFPHRyks7S8AvFPLtDsq
         5/kCbAQDWlbdQ7MgOr3j+85HHXcFfoTxrKivzNI5TdW5Oi9Snx9/ObboVhwC2JNPzILp
         LxLJO1rg/NG+NeznE02vx2ve6bTX9OL6biVc8AKBrXhNN0gk3ZlzhTX7vtCQGJ3BdJhU
         utDQ==
X-Gm-Message-State: AAQBX9fYELhT3mR5l0Jy4iqNihrwvwQ3e/Es57ee9+EWXfBGPcGbw/dL
        qOPb4qz5YJ9AIybMKDHPH2k=
X-Google-Smtp-Source: AKy350ZUEdhibA1JLGd77GLp2XtM0WJdCzWuWKSn07Bvv355e3cXVhdWXO8K9DeX9Ou+24N0sn+lIg==
X-Received: by 2002:a9d:7ac1:0:b0:69d:793c:a722 with SMTP id m1-20020a9d7ac1000000b0069d793ca722mr2443733otn.13.1681476007037;
        Fri, 14 Apr 2023 05:40:07 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g17-20020a9d6191000000b006a1394ea9f3sm1637478otk.30.2023.04.14.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:40:06 -0700 (PDT)
Date:   Fri, 14 Apr 2023 06:40:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <643949a57396c_5b7e62948d@chronos.notmuch>
In-Reply-To: <20230414070449.GA540206@coredump.intra.peff.net>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Apr 13, 2023 at 01:47:22AM -0600, Felipe Contreras wrote:
> 
> > manpages expect the date of the last revision, if that is not found
> > DocBook Stylesheets go through a series of hacks to generate one with
> > the format `%d/%d/%Y` which is not ideal.
> > 
> > In addition to this format not being standard, different tools generate
> > dates with different formats.
> > 
> > There's no need for any confusion if we specify the revision date, so
> > let's do so.
> 
> That seems like a good goal, and should reduce our asciidoc/asciidoctor
> diff considerably.
> 
> > This patch requires [1] to actually work, and has a simple conflict with
> > [2], so it's written on top of both.
> > 
> > [1] https://lore.kernel.org/git/20230323221523.52472-1-felipe.contreras@gmail.com/
> > [2] https://lore.kernel.org/git/20230408001829.11031-1-felipe.contreras@gmail.com/
> 
> I wasted a bit of time trying this out, so let me elaborate on "actually
> work" for the benefit of other reviewers. Without the patch in [1]
> (which is 8806120de6c on fc/remove-header-workarounds-for-asciidoc),
> this patch works as advertised with asciidoctor, but has no effect with
> asciidoc.  The reason is that asciidoc puts the <date> tags in the
> header, and the custom header removed by 8806120de6c suppresses
> asciidoc's default header entirely (so a workaround would be to include
> the <date> tags in our custom header, but I don't see any reason not to
> just build on top of 8806120de6c, as you did here).

Yes, I also "wasted" a bit of time comparing the custom header introduced in
7ef195ba3e (Documentation: Add version information to man pages, 2007-03-25) to
what is in asciidoc and the difference is simple:

--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -56,6 +56,9 @@ ifdef::backend-docbook[]
 [header]
 template::[header-declarations]
 <refentry>
+<refentryinfo>
+template::[docinfo]
+</refentryinfo>
 <refmeta>
 <refentrytitle>{mantitle}</refentrytitle>
 <manvolnum>{manvolnum}</manvolnum>

This is of course not needed if we get rid of that custom header, but I sent
the patch anyway for reference in a semi-unrelated patch series [1].

But to me the rationale is simple: the information isn't there because we are
overriding the asciidoc header and not putting it there.

> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 3133ea3182..b629176d7d 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -144,13 +144,16 @@ man5dir = $(mandir)/man5
> >  man7dir = $(mandir)/man7
> >  # DESTDIR =
> >  
> > +GIT_DATE := $(shell git show --quiet --pretty='%as')
> 
> What will/should this do in a distribution tarball, where we won't have
> a Git repository at all? I think we'll just end up with a blank date in
> the xml file, though it looks like docbook turns that into today's date
> in the result.
> 
> That's not _too_ bad, but feels a bit inconsistent (and it uses the
> format you're trying to get rid of!).
> 
> It would be nicer to populate the date variable in that case, like we do
> for GIT_VERSION. I think that could look something like this:

Indeed, that would be better, but that totally can be done in a separate patch,
or a separate series even.

The perfect doesn't have to be the enemy of the good, and that can be done
later.

In the meantime something is better than nothing.

For the record, the GIT-VERSION-GEN script can be simplified a lot, I had a
patch from 2013 around, cleaned it up, and sent it a new series, so it should
be easier to implement this on top of that [2].

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2ccc3a9bc9..307634a94f 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -144,8 +144,6 @@ man5dir = $(mandir)/man5
>  man7dir = $(mandir)/man7
>  # DESTDIR =
>  
> -GIT_DATE := $(shell git show --quiet --pretty='%as')
> -
>  ASCIIDOC = asciidoc
>  ASCIIDOC_EXTRA =
>  ASCIIDOC_HTML = xhtml11
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 9a1111af9b..14903bd261 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -10,7 +10,8 @@ LF='
>  # then try git-describe, then default.
>  if test -f version
>  then
> -	VN=$(cat version) || VN="$DEF_VER"
> +	VN=$(cut -d" " -f1 version) || VN="$DEF_VER"
> +	DN=$(cut -d" " -f2 version) || DN=""

Although this works, I have an issue with doing multiple unnecessary forks.

This does the same, no?

  read VN DN <version

Cheers.

[1] https://lore.kernel.org/git/20230413115745.116063-3-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20230414121841.373980-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E55C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 05:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501A0613E9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 05:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhELFEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 01:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhELFEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 01:04:23 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A3C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:03:15 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so19537603otp.11
        for <git@vger.kernel.org>; Tue, 11 May 2021 22:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JH+vQc8yWujNYd3v0llYrpusMQ7TBcAnmyc6aQpYh2w=;
        b=u6F2dRNRx8eytuT9uLynYWb3n9Cmoe5f56kfCJDn/G2q2KmYLujvSulXA1lBw3Uupd
         7nzliGxwFL4GmMmKRtHW4W85kd6hVnKv4PY69Pi3TfNlYJ+t84ASzgf921kCV/6x/Hrs
         8NNCFLt4v0w3dm+9YbZ+2eMVYJY/bAuMt6e1ba+dg7OW3ONC2viul2Ur8pZv8IY/HIUa
         gSsWYgMn0NspGhwkc+2Ra7UqXZDWOrTmsC+s/aLLM24DuWNe25i2hSbgpVUP3aQoMFZe
         hI08wZy35VKXeWh1AxJgQkoNuvBPYcJl98UCdTJ+ynxMFoa/EBX44Na1DE7JW9LCw0OL
         tkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JH+vQc8yWujNYd3v0llYrpusMQ7TBcAnmyc6aQpYh2w=;
        b=adJ1+PlWyVObFSKZIkVPu560YOeNLyExQOdYnEPXdzOQcJ4+kS766BWWsATu0u/bQp
         17nKX9nxi7dIGPIvFXK2vxU0RTRzHPYbzXzZWU2ZCDf+S/xQzqI/M1dDYf1r18zDdo1K
         DMOW9rT3PqfRsLkYLte9CuAT7mn5ec9/6qxk7mwjEBbfNx1QrMFE7+a3QAfm+D2i+H5C
         hgBRuVjg9EdVMlF3dlIleYJDhYq7UA+DbZ8GpcP8qXRICF71gIQnqId4oIcmVbaEwy/I
         QLvgJ+ee/e7GfoymQ3hifwJP4FhsY5fl8TYQoxUHW7s67m10aZtwz32iFQdT5W09t79m
         KB5g==
X-Gm-Message-State: AOAM5306dJgHtZlXCnxXvirSMJh0aoIZwVrO6BcAESS9TK+OiYQh6Qvv
        vqbSeH8DsIz94B+LYTEotCAACzBBCb5xFA==
X-Google-Smtp-Source: ABdhPJw71KUvtAq6i3tK4Ak2llxWg9sLZpq6duN8lhym2mR8+M2CPTSIwIuDp96SWvh4Ic1GvKfqSg==
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr28960644otn.285.1620795795160;
        Tue, 11 May 2021 22:03:15 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a12sm4244900oti.12.2021.05.11.22.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 22:03:14 -0700 (PDT)
Date:   Wed, 12 May 2021 00:03:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Message-ID: <609b618e663bd_678ff208ec@natae.notmuch>
In-Reply-To: <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya wrote:
> On 12/05/21 09.11, brian m. carlson wrote:
> > From: Felipe Contreras <felipe.contreras@gmail.com>
> > 
> > Asciidoctor contains a converter to generate man pages.  In some
> > environments, where building only the manual pages and not the other
> > documentation is desired, installing a toolchain for building
> > DocBook-based manual pages may be burdensome, and using Asciidoctor
> > directly may be easier, so let's add an option to build manual pages
> > using Asciidoctor without the DocBook toolchain.
> 
> I have concern: I currently generate manpages with Asciidoctor+xmlto. Does
> this change affects people using xmlto?

His proposed change: no, but mine does.

> > We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> > contain proper handling of the apostrophe, which is controlled normally
> > by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> > as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> > instead of a Unicode apostrophe in text, so as to make copy and pasting
> > commands easier.  These newer versions of Asciidoctor detect groff and
> > do the right thing in all cases, so the GNU_ROFF option is obsolete in
> > this case.
> 
> At what version of Asciidoctor the apostrophe handling is corrected?

I will look into this, but in my opinion it's not worth complicating the
doc toolchain for ancient distributions.

The only time people are going to notice something is when:

 1. They build git with USE_ASCIIDOCTOR=YesPlease
    USE_ASCIIDOCTOR_MANPAGE=YesPlease
 2. They use an ancient distribution
 3. They use the ancient distribution's asciidoctor packages, instead of
    Ruby's asciidoctor gem
 4. They open a manpage generated by this process
 5. They select text that specifically has an apostrophe
 6. They copy this text
 7. They paste this text somewhere else

Then, they *might* see some issue.

Yeah, let's not worry about about this *too much*.

> > Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > I've preserved Felipe's authorship on this patch because much of it is
> > his work.  However, I have made some substantial changes here with which
> > I suspect he will disagree, in addition to expanding on the commit
> > message, so if he would prefer, I can reroll with the authorship
> > changed.  I have no preference myself.
> > 
> >   Documentation/Makefile                  | 10 ++++++++++
> >   Documentation/asciidoctor-extensions.rb |  2 ++
> >   Makefile                                |  3 +++
> >   3 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 2aae4c9cbb..536d9a5f3d 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -196,6 +196,9 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
> >   DBLATEX_COMMON =
> >   XMLTO_EXTRA += --skip-validation
> >   XMLTO_EXTRA += -x manpage.xsl
> > +ifdef USE_ASCIIDOCTOR_MANPAGE
> > +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> I think "ASCIIDOCTOR_TO_MAN" would be good alternative name here, since
> this command generates manpage from asciidoctor.

All the current TXT_TO_* definitions use asciidoc.

Moreover, I'm currently working on some cleanup patches to make
TXT_TO_MAN work with asciidoc + xmlto, so this is future-proof.

> > --- a/Makefile
> > +++ b/Makefile
> > @@ -285,6 +285,9 @@ all::
> >   # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
> >   # documentation.
> >   #
> > +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
> > +# instead of building manual pages from DocBook.
> > +#
> The wording should be "...instead of building manual pages from DocBook with
> xmlto".

That's why in my opinion it should be the other way around:
USE_ASCIIDOCTOR_XMLTO=No.

Then the expalantion is not even needed, because you can deduce it from
the name of the configuration variable.

Cheers.

-- 
Felipe Contreras

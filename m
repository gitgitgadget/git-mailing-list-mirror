Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D661C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F250613C8
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhELEmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELEmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:42:54 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D6C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:41:47 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso4691810oov.10
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7G8SgAPgzRnu2yldXLIg2LZFhWQ2c8xf9zxkfFRJJFQ=;
        b=S0WdN44+rQtWyEwN5trPGKxG64Qpd7ekisGQKAnmvEGDQ+MWKWLVVhsa4XK6ovOdbk
         qsddTlnurprj3bL4QtftJICUMBft4VblcNmosuNbmyOZiDRqKApxau1bhsp3PPDTENsv
         tRm55Ja5jCZawZMjy6ecIIr3GXzEIEr1YHSisGwVDmenFh+tBJFXi1SaPkED2D2HwvV1
         xXCOqoML9L9UwBNe55qmvcQJ+m+6ijHoQElEyX3YOmZDWjNoda7p4l/A38hZT4f51pYK
         OOjT/PHReqpd+teWjf4JybWnUn5n99P10y/EqI/dXDjJa5F6icJ0WaO5fTeKTLvYkFAe
         XV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7G8SgAPgzRnu2yldXLIg2LZFhWQ2c8xf9zxkfFRJJFQ=;
        b=LkzV8nQWowRRsGj0R5ZVvWeGY5LV9Gmh+s//iiPRiqzhYMYRAwoFaLqXTCvNyCO7It
         QzZ4DZg+wqyGPO6rhG9YEGssfD/VtzYt9UqFhutn0YURnfpwUfIp5PXqjBsa+CWU4Wcw
         vq8mXDBSgZfx81P7ZjoP+875SbhOnZ/+qIVJYsr1CHZEPMnLi4vuHJt+p+g41tI/vHly
         GCN4bVUraLtXCeTCrejHfkNi9xZhjCtmoPZ0E7RdeClt1uf5RlQxkvBLZG2rZR4S2+e8
         MejPeG7zCdr0B3ywjGEOUxzVMCh8gsXZ18FHG3sll0yI5TeEZFfgLtAYsCkyRK1ZyXbf
         gLGQ==
X-Gm-Message-State: AOAM530PHGpaM7l5gGn1IbU9JxSDCiXaMfNWKjOKuo0VJ43Lq4cTxp6g
        +wk8sQ6VMhGhVMnthUf01C0=
X-Google-Smtp-Source: ABdhPJyuCQxqu3UHkDCcMjUMV2UdY4XAsUBt/hyu0N/8Y4pM8jfBTkhDw+lgzPUBNt3Wuua7RZ8sfA==
X-Received: by 2002:a4a:b24b:: with SMTP id i11mr7557443ooo.17.1620794506745;
        Tue, 11 May 2021 21:41:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v1sm4156471ott.32.2021.05.11.21.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 21:41:46 -0700 (PDT)
Date:   Tue, 11 May 2021 23:41:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609b5c85b7c61_678ff20848@natae.notmuch>
In-Reply-To: <20210512021138.63598-1-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
Subject: RE: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Asciidoctor contains a converter to generate man pages.  In some
> environments, where building only the manual pages and not the other
> documentation is desired, installing a toolchain for building
> DocBook-based manual pages may be burdensome, and using Asciidoctor
> directly may be easier, so let's add an option to build manual pages
> using Asciidoctor without the DocBook toolchain.
> 
> We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> contain proper handling of the apostrophe, which is controlled normally
> by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> instead of a Unicode apostrophe in text, so as to make copy and pasting
> commands easier.  These newer versions of Asciidoctor detect groff and
> do the right thing in all cases, so the GNU_ROFF option is obsolete in
> this case.
> 
> We also need to update the code that tells Asciidoctor how to format our
> linkgit macros so that it can output proper code for man pages.  Be
> careful to reset the font to the previous after the change.  In order to
> do so, we must reset to the previous after each font change so the
> previous state at the end is the state before our inserted text, since
> troff only remembers one previous font.
> 
> Because Asciidoctor versions before 2.0 had a few problems with man page
> output, let's default this to off for now,

> since some common distros are > still on 1.5.

Are "some common distros" namely Debian stable *exclusively*?

If so, I would consider flipping the default the other way around,
espececially since it's only te default shipped by the Debian stable
packages (easily fixed by `gem install asciidoctor`).

> If users are using a more modern toolchain or don't care
> about the rendering issues, they can enable the option.

The other way around: if users are using an ancient distribution they
can disable the option.

> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Commit-message-by: brian m. carlson <sandals@crustytoothpaste.net>

I certainly would not want to pretend to have written the text above.

> ---
> I've preserved Felipe's authorship on this patch because much of it is
> his work.  However, I have made some substantial changes here with which
> I suspect he will disagree, in addition to expanding on the commit
> message, so if he would prefer, I can reroll with the authorship
> changed.  I have no preference myself.

Hard to tell in this frankenstein commit. I'd be fine with a
Commit-message-by line.

>  Documentation/Makefile                  | 10 ++++++++++
>  Documentation/asciidoctor-extensions.rb |  2 ++
>  Makefile                                |  3 +++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2aae4c9cbb..536d9a5f3d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -196,6 +196,9 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =
>  XMLTO_EXTRA += --skip-validation
>  XMLTO_EXTRA += -x manpage.xsl
> +ifdef USE_ASCIIDOCTOR_MANPAGE

I'd do:

  ifndef USE_ASCIIDOCTOR_XMLTO

(the other way around)

> +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
> +endif
>  endif
>  
>  SHELL_PATH ?= $(SHELL)

> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> index d906a00803..40fa87b121 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -15,6 +15,8 @@ module Git
>            "#{target}(#{attrs[1]})</ulink>"
>          elsif parent.document.basebackend? 'html'
>            %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
> +        elsif parent.document.basebackend? 'manpage'
> +          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)

I still prefer my original version, especially since:

 1. I suspect most git developers are familiar with printf directives:
    %s.
 2. Where is that \\fP coming from? I don't see that with xmlto, nor the
    publicly genrated man pages[1].
 3. Doesn't work on my machine without my original \e; I see
    "\fBgittutorial\fR(7)".

I don't see any way this is an improvement.

Cheers.

[1] https://git.kernel.org/pub/scm/git/git-manpages.git/tree/man1/git.1

-- 
Felipe Contreras

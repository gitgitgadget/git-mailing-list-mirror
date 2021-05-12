Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99698C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649FD61943
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhELCuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELCuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:50:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187DC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:49:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p17so11766976plf.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6YZW82k5E7QjtJSURLLoGgm3wdZlC81CqCRHiaDMktA=;
        b=WU6dMvYKf062lQeJsKDdTz6CeXSy7iQc+EtIYJ5GsltaYS2/dH1fyMGxmWbMRLJ7MB
         Eeppxu4YE8X3SOu2OmMHHlehrhwkT9qRL3qoSryok0yuryB/24BzTJJtBj9UiOOTM+e+
         ca5cS45w30CkUdiRB4qwaLS7NY6KgyTuwwUekJoLVNvHn/+s0J9Buhl4gybXVkha0o4y
         ancdtwjS7eR++0Zf8ZcrynKHtywtRXINyPtfv8h+DZQCO3MgEI7XuunBz2yIUP9wAsoH
         lmEcodbnT2sTay/UXypDm9x6OhsUB7BPfCwjaparyypC8e47KSDTyfXZGEcm838DPCWg
         YVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6YZW82k5E7QjtJSURLLoGgm3wdZlC81CqCRHiaDMktA=;
        b=kUlQWUA4MiKMla4yL5wNQ96olQsU4cxjN0QCqjTQ7LQ0/1xw3C5dcEifoCZN1KhbWg
         6bT2n70EU+e+QYPJVtzVKQut9K9tTakDugC4hwhHPwCeMuchu5vLInCD/sjzjlo2FKx/
         brH+DShL5txoEmw7R1wzD22PUbOq9dFoQO0EZd+LuMrSPK92346crnYgGZYlEBom/laa
         4P98aaKl5nOcyKCoJtRBtG5l22N4N1xgOa2Wy3tmIxp/YdMln/SH9PiaN6xIQYsMettu
         B/vtANNu2XJfbcSV9NVJjWPgv7QTZdgaRDiK6nr0PTWDy5ppHSjCEb98484blVlgxoUU
         +z5A==
X-Gm-Message-State: AOAM530moHl7LwWFUEjL4Q3iE99M+YN3CjqMOl2FTyFJIYs3T3wLBPav
        xvzK3aAPidltVzSzrULrQv8=
X-Google-Smtp-Source: ABdhPJw7OOhd7bv6gmF2KRXCdqxCm8UTZiruWfROtAH+RrrTXjbax7yrodVawbdSoSUFhe7pNLkDLA==
X-Received: by 2002:a17:902:c104:b029:ef:836e:15d6 with SMTP id 4-20020a170902c104b02900ef836e15d6mr507528pli.39.1620787743048;
        Tue, 11 May 2021 19:49:03 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-46.three.co.id. [116.206.28.46])
        by smtp.gmail.com with ESMTPSA id i5sm2642248pfd.159.2021.05.11.19.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 19:49:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] doc: add an option to have Asciidoctor build man
 pages directly
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6d56412a-cc67-22fc-717f-9fa218264b40@gmail.com>
Date:   Wed, 12 May 2021 09:48:59 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512021138.63598-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/21 09.11, brian m. carlson wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Asciidoctor contains a converter to generate man pages.  In some
> environments, where building only the manual pages and not the other
> documentation is desired, installing a toolchain for building
> DocBook-based manual pages may be burdensome, and using Asciidoctor
> directly may be easier, so let's add an option to build manual pages
> using Asciidoctor without the DocBook toolchain.

I have concern: I currently generate manpages with Asciidoctor+xmlto. Does
this change affects people using xmlto?

> We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
> contain proper handling of the apostrophe, which is controlled normally
> by the GNU_ROFF option.  This option for the DocBook toolchain, as well
> as newer versions of Asciidoctor, makes groff output an ASCII apostrophe
> instead of a Unicode apostrophe in text, so as to make copy and pasting
> commands easier.  These newer versions of Asciidoctor detect groff and
> do the right thing in all cases, so the GNU_ROFF option is obsolete in
> this case.

At what version of Asciidoctor the apostrophe handling is corrected?

> We also need to update the code that tells Asciidoctor how to format our
> linkgit macros so that it can output proper code for man pages.  Be
> careful to reset the font to the previous after the change.  In order to
> do so, we must reset to the previous after each font change so the
> previous state at the end is the state before our inserted text, since
> troff only remembers one previous font.
> 
> Because Asciidoctor versions before 2.0 had a few problems with man page
> output, let's default this to off for now, since some common distros are
> still on 1.5.  If users are using a more modern toolchain or don't care
> about the rendering issues, they can enable the option.

Maybe when distros upgraded shipped Asciidoctor version to 2.0, we can
bump the version requirement.

> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I've preserved Felipe's authorship on this patch because much of it is
> his work.  However, I have made some substantial changes here with which
> I suspect he will disagree, in addition to expanding on the commit
> message, so if he would prefer, I can reroll with the authorship
> changed.  I have no preference myself.
> 
>   Documentation/Makefile                  | 10 ++++++++++
>   Documentation/asciidoctor-extensions.rb |  2 ++
>   Makefile                                |  3 +++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2aae4c9cbb..536d9a5f3d 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -196,6 +196,9 @@ ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
>   DBLATEX_COMMON =
>   XMLTO_EXTRA += --skip-validation
>   XMLTO_EXTRA += -x manpage.xsl
> +ifdef USE_ASCIIDOCTOR_MANPAGE
> +TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
I think "ASCIIDOCTOR_TO_MAN" would be good alternative name here, since
this command generates manpage from asciidoctor.
> +endif
>   endif
>   
>   SHELL_PATH ?= $(SHELL)
> @@ -367,9 +370,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-AS
>   manpage-base-url.xsl: manpage-base-url.xsl.in
>   	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
>   
> +ifdef TXT_TO_MAN
> +%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
> +	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> +	$(TXT_TO_MAN) -o $@+ $< && \
> +	mv $@+ $@
> +else
>   %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
>   	$(QUIET_XMLTO)$(RM) $@ && \
>   	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +endif
>   
>   %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
>   	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
> index d906a00803..40fa87b121 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -15,6 +15,8 @@ module Git
>             "#{target}(#{attrs[1]})</ulink>"
>           elsif parent.document.basebackend? 'html'
>             %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
> +        elsif parent.document.basebackend? 'manpage'
> +          %(\\fB#{target}\\fP\\fR(#{attrs[1]})\\fP)
>           elsif parent.document.basebackend? 'docbook'
>             "<citerefentry>\n" \
>               "<refentrytitle>#{target}</refentrytitle>" \
> diff --git a/Makefile b/Makefile
> index 93664d6714..cb75dec314 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -285,6 +285,9 @@ all::
>   # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
>   # documentation.
>   #
> +# Define USE_ASCIIDOCTOR_MANPAGE to use Asciidoctor's manual page backend
> +# instead of building manual pages from DocBook.
> +#
The wording should be "...instead of building manual pages from DocBook with
xmlto".
>   # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
>   # Extensions Lab if you have it available.
>   #
> 

Thanks for my review.

-- 
An old man doll... just what I always wanted! - Clara

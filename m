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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF24C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685C8613DA
	for <git@archiver.kernel.org>; Wed, 12 May 2021 04:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhELEoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 00:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELEoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 00:44:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DC7C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:43:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so2618345pjb.4
        for <git@vger.kernel.org>; Tue, 11 May 2021 21:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4pENtYwAocyg99BsPsRwZsiw+XTEiFpdvBgV095Bas8=;
        b=FUi7DlyOL+ak3o5ELXty3T4Brh43Skwh+d6Z7EBH64wekEp9USNUBnX3u+p6Bw7MRD
         IvV8BLQS+ytRwRqnqrNw3KZtLMf9Ya5Pq81HMb075yGG6A+yMOY2hl7nX/uMfWyDerde
         QzFjbydUxLMvnZvV6EDaFbUNMY3iQOldvF9Siks2/Jb8pF7tZjF0eNF9RArf/crIeBgm
         3DQAJsfrF80LtsCpnH2nTJGfMtREz4ljp9v+gfc4315HhjoHTO3nePOhl2dXiV9emyrt
         e0VFgZNsjOLbW26A1FdDbVvsakPDEed3JAEX72GbKgvDgc3PlOlL3zU7vOVyxek9Jjo1
         xs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4pENtYwAocyg99BsPsRwZsiw+XTEiFpdvBgV095Bas8=;
        b=dRpiA9n4245QTL3rGsuJofN+rd5QLsyBtGgEhTWszNOtj7TTlhXFMcFtnrm62N9Ruu
         hMiBOgn6hVLmRtKQqlS0Ju6nbBpMvD8+8YmW3UOh5RdQuQ46Xyyv090siwP4RAd09URy
         0aOJTF7HzoaZ516T9HKBhVlw72yZBGNeebdbQljpcBGbkzcbUIB1wslob2mmb1QMyjWX
         IZa7iCUK67CJJgW4klbxblU8BHf8NFZsrUWdNb/qzGWlJ36ebbiBna+kQQ2LaLfDiD4j
         q7MlphIYpmD95x4Liu80YyaitPojE7+XDabD5Q0SY5UMwrAc0RDTMpETRGWqD0pFaNkf
         7KGA==
X-Gm-Message-State: AOAM531ZCMk4dYXGLml3HCBll/APTzMFGiXqRhXFVOH4BSy6Q4CJnVzk
        r5U8LuXHpRFANgoQgSobPAaRvf9CRlkwkg==
X-Google-Smtp-Source: ABdhPJwxXu2nv498n6V0yWv4V8hYfYuer8n8XPeN3q2ce5ePPHM6DLTktDuoyQXHBHZ8VbeUG0GXPA==
X-Received: by 2002:a17:90b:194:: with SMTP id t20mr37709144pjs.83.1620794597618;
        Tue, 11 May 2021 21:43:17 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-52.three.co.id. [116.206.12.52])
        by smtp.gmail.com with ESMTPSA id y17sm6130904pfr.119.2021.05.11.21.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 21:43:17 -0700 (PDT)
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
Message-ID: <117a0b3b-ae7a-ffe7-feee-ae659c588920@gmail.com>
Date:   Wed, 12 May 2021 11:43:14 +0700
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

Another review below.

On 12/05/21 09.11, brian m. carlson wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>> Asciidoctor contains a converter to generate man pages.  In some
> environments, where building only the manual pages and not the other
> documentation is desired, installing a toolchain for building
> DocBook-based manual pages may be burdensome, and using Asciidoctor
> directly may be easier, so let's add an option to build manual pages
> using Asciidoctor without the DocBook toolchain.
> > We generally require Asciidoctor 1.5, but versions before 1.5.3 didn't
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
> output, let's default this to off for now, since some common distros are
> still on 1.5.  If users are using a more modern toolchain or don't care
> about the rendering issues, they can enable the option.
> 
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---

It is customary for multi-patches patch series to have a cover letter.
For example, when I send a patch that add corrections to an existing
patch series, I can add permalink of that series' cover letter to be
clear that my patch is applied on top of another patch series.

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

Does USE_ASCIIDOCTOR_MANPAGE imply USE_ASCIIDOCTOR?

>   # Define ASCIIDOCTOR_EXTENSIONS_LAB to point to the location of the Asciidoctor
>   # Extensions Lab if you have it available.
>   #
> 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

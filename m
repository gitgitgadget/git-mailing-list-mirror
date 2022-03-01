Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81760C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiCARSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiCARSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:18:22 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC8B63C4
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:17:39 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5795816D249;
        Tue,  1 Mar 2022 12:17:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HKHPDF6mNRM0PyI03t20d+2zuei1k9GclVGQtg
        oyDaM=; b=LeBkyM6Nizu0Z4vsrwzbIf0TOLXpUiIHYe+nWbnGnYNRggjVDI1KNK
        v/bLYLwPQIvSCqSPN70GHHJ9peT/zMDMdKff6fBJ/Ob8rAfiECUjuHhffwwKqeVi
        l4qhN/Vyjx4l5EIRrR6zvtE9fWoPN/Al2fCYf8X0Fqsu3CcI/ibCI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BD7D16D248;
        Tue,  1 Mar 2022 12:17:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77A0D16D246;
        Tue,  1 Mar 2022 12:17:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
        <20220301155431.2534136-1-jaydeepjd.8914@gmail.com>
Date:   Tue, 01 Mar 2022 09:17:34 -0800
In-Reply-To: <20220301155431.2534136-1-jaydeepjd.8914@gmail.com> (Jaydeep
        P. Das's message of "Tue, 1 Mar 2022 21:24:31 +0530")
Message-ID: <xmqq8rttsic1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CCA8E6A-9983-11EC-A404-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jaydeep P Das <jaydeepjd.8914@gmail.com> writes:

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index a71dad2674..4b36d51beb 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -829,6 +829,8 @@ patterns are available:
>  
>  - `java` suitable for source code in the Java language.
>  
> +- `kotlin` suitable for source code in the Kotlin language.
> +
>  - `markdown` suitable for Markdown documents.
>  
>  - `matlab` suitable for source code in the MATLAB and Octave languages.

I do not speak the language, but hopefully those who do will find
issues and help us correct them if there still are any.  The patch
organization looks good.  Will queue.

Thanks.

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..f23f098f19 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,13 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*[ \t]*)$",
> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> +	 "|[-+*/<>%&^|=!]="
> +	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

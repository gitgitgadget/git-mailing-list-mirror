Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB8C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiCAJd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiCAJdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:33:25 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9657A3889
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:32:36 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B86C2189281;
        Tue,  1 Mar 2022 04:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=XjdZbG3nESRJigrw1TiLg/RcubJ7Lo8IFTpiaIS3ZPE=; b=pHCd
        eKrsADfG3yDKcvBpaZ41ox9GyrK48kximaktf53tPwdkA7d/3GlTU/IPzfy1RrmI
        S4KxCpgyDbRTUYCpv1Aka+McSK4Gfs9v467P8KXGd7L/jaNXexjgOKrw2UOOH4YC
        SvvK5pkm0fy73vaWGUKd/zpNwVjiDrEdqNJfauY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B11FF189280;
        Tue,  1 Mar 2022 04:32:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E460A18927F;
        Tue,  1 Mar 2022 04:32:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] userdiff: Add diff driver for Kotlin lang and tests
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
        <20220301070226.2477769-2-jaydeepjd.8914@gmail.com>
Date:   Tue, 01 Mar 2022 01:32:30 -0800
Message-ID: <xmqqy21urpap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84F9F77E-9942-11EC-B72E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jaydeep P Das <jaydeepjd.8914@gmail.com> writes:

> Subject: Re: [PATCH] userdiff: Add diff driver for Kotlin lang and tests

"Add" -> "add".  "lang and tests" -> "language".

> The xfuncname pattern finds func/class declarations in diffs to
> display as a hunk header.

Yes, but an entry for a language in userdiff.c consists of the
funcname pattern AND the word_regex.  And I think the patch is
adding both, not just funcname pattern.

> This patch adds xfuncname regex and some respective
> tests for Kotlin language.
>
> Also modifies `Documentation./gitattributes.txt` to state
> the same.

See Documenation/SubmittingPatches::[[imperative-mood]].

But it probably is better to leave these unsaid.  The patterns,
tests and documentation updates go hand in hand.

>  11 files changed, 59 insertions(+)
>  create mode 100644 t/t4018/kotlin-class
>  create mode 100644 t/t4018/kotlin-enum-class
>  create mode 100644 t/t4018/kotlin-fun
>  create mode 100644 t/t4018/kotlin-inheritace-class
>  create mode 100644 t/t4018/kotlin-inline-class
>  create mode 100644 t/t4018/kotlin-interface
>  create mode 100644 t/t4018/kotlin-nested-fun
>  create mode 100644 t/t4018/kotlin-public-class
>  create mode 100644 t/t4018/kotlin-sealed-class
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index a71dad2674..94d06dc337 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -829,6 +829,8 @@ patterns are available:
>  
>  - `java` suitable for source code in the Java language.
>  
> +- `kotlin` suitable for source code in the Kotlin language
> +
>  - `markdown` suitable for Markdown documents.

The entries before and after this new one both end with a full stop,
and this new entry should do the same.

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..a6cc6dc3b7 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,14 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 /* fun, class, interface, declarations */
> +  	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*[ \t]*)$",

With the three keywords clearly visible in the pattern, the comment
looks somewhat redundant.  I dunno.

> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> +	 "|[-+*/<>%&^|=!]="
> +	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),

The latter half is word regex, which is tested in t4034 to at least
ensure that it is well formed.  We can also add t/t4034/$language/
to see the patterns hit the word boundary as expected.

>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

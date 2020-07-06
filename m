Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56536C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 06:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D92A2073E
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 06:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZUtT5/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGFGjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 02:39:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60892 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgGFGjN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 02:39:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78BDEC2E63;
        Mon,  6 Jul 2020 02:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UZCcl4Q5+reYQMvR3WidVCzaK2g=; b=iZUtT5
        /C9pef54SbE7D98Q12+ceZVPmYdxUPNE3pCHnX8IjBMnEv4qC89IveZje++olv9v
        H+5TUPTd6+v0h2Sg+92epQdXHt119MXnMk9CmAytaMwfjWlk7UEfj335yoEiAHIV
        dWKGAD1rjCqPJKejdF+sZH4uQDufty9FZRhXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m00OAZyUEvA+1JgkWQrom8jUYe4Ola+9
        9mFrJKxEltNutqfxXM6R/cSUeqqr7PUKlJVoRVt5WOjRyzY2bf/qbhZuDPkcvu7x
        /KFmDdfCDSos1t6Gf+wyHoM62l1aBW77pMGVs+wJhmjdJvSpuIe58iC7jW2H3QXD
        5wsJXT76CWQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63D68C2E62;
        Mon,  6 Jul 2020 02:39:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5F71C2E61;
        Mon,  6 Jul 2020 02:39:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Martin Bektchiev via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Martin Bektchiev <martinb@gmail.com>,
        Martin Bektchiev <martin.bektchiev@progress.com>
Subject: Re: [PATCH] commit: correctly escape @ of stashes
References: <pull.815.git.git.1593768655179.gitgitgadget@gmail.com>
Date:   Sun, 05 Jul 2020 23:39:04 -0700
In-Reply-To: <pull.815.git.git.1593768655179.gitgitgadget@gmail.com> (Martin
        Bektchiev via GitGitGadget's message of "Fri, 03 Jul 2020 09:30:55
        +0000")
Message-ID: <xmqqv9j19mgn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63DEA096-BF53-11EA-B596-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Martin Bektchiev via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Martin Bektchiev <martin.bektchiev@progress.com>
>
> Autocomplete suggestions for stashes are broken due to `stash@`
> being suggested without escaping.

What is unclear to readers of this sentence is why '@' needs to be
quoted in the first place.  '@' is not like '$' that has a syntactic
significance to the shell.

In fact, I just tried

    $ git stash show stas<TAB>

in a test repository where there is only one stash entry and got it
completed to

    $ git stash show stash@{0}

and pressing <Enter> from this state did exactly what I expected to
see.

> Reproducible on `GNU bash, version 3.2.57(1)-release` and
> `macOS Catalina 10.15.5`.

What did you reproduce?  The completion gave me "stash@{0}" (without
surrounding double quotes) in my above experiment?  If so, that does
seem reproducible, but I do not see "suggestions ... are broken" here.

> @@ -2999,12 +2999,14 @@ _git_stash ()
>  				__git_complete_refs
>  			else
>  				__gitcomp_nl "$(__git stash list \
> -						| sed -n -e 's/:.*//p')"
> +						| sed -n -e 's/:.*//p' \
> +						| sed 's/@/\\@/')"

This is not a new problem introduced by this patch, but we should
get rid of these unnecessary backslashes and pipe at the beginning
of the second line, both of which make the resulting code harder
than necessary to read.  Ending the line with '|' pipe would give
enough clue to the shell that you haven't finished talking to it,
and you can continue to the next line without any backslashes just
fine.

>  			fi
>  			;;
>  		show,*|apply,*|drop,*|pop,*)
>  			__gitcomp_nl "$(__git stash list \
> -					| sed -n -e 's/:.*//p')"
> +					| sed -n -e 's/:.*//p' \
> +					| sed 's/@/\\@/')"

Ditto.

>  			;;
>  		*)
>  			;;
>
> base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e

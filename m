Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC2DC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796D422582
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLGHq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:46:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58677 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGHq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 02:46:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA272A97C4;
        Mon,  7 Dec 2020 02:45:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IHGegsMPWQBbzq5lAKrDaD5eveA=; b=wcdi6n
        xnS+LK2jUsUotgxQFOm4PwKD1rb56mw5z4TUqYPM9UfajI0xYx0ZTkrbqGmZcLKg
        h0+9NuTU1A9WhDTEAx9EPvyWfW7MwtCh6+J9Hx+5gxwQUy1XfM4T8pbfzfjx8cKj
        3FPvXPMEE8X0iQkg9vjKLOtuDyrIZzgYvDZeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tTEntjT2VtkzSGyFilJJeRipKC4M8jW4
        sb5stVmo7fPIZXDWAXP2iY9djnmyjzmLamKFIM9m9x/+E9x/Wkuqqxao7TLm9rfs
        eHKz0mh6VtqTSFOmo/fqpTq38cNy7S6jw577pDUfllORKIiiUy9d8KcISffJ1Zs7
        hEetCMUUQr8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2C7CA97C3;
        Mon,  7 Dec 2020 02:45:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 275A7A97C2;
        Mon,  7 Dec 2020 02:45:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
References: <3e085045-99d5-29ee-ed3f-076b1b8bb6b6@ramsayjones.plus.com>
Date:   Sun, 06 Dec 2020 23:45:43 -0800
In-Reply-To: <3e085045-99d5-29ee-ed3f-076b1b8bb6b6@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 7 Dec 2020 00:32:54 +0000")
Message-ID: <xmqqy2iaawk8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 362C1F44-3860-11EB-8811-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> The 'clean' target is still noticeably slow on cygwin, despite the
> substantial improvement made by the previous patch. For example, the
> second invocation of 'make clean' below:
>
>   $ make clean >/dev/null 2>&1
>   $ make clean
>   ...
>   make[1]: Entering directory '/home/ramsay/git/Documentation'
>   make[2]: Entering directory '/home/ramsay/git'
>   make[2]: 'GIT-VERSION-FILE' is up to date.
>   make[2]: Leaving directory '/home/ramsay/git'
>   ...
>   $
>
> has been timed at 12.364s on my laptop (on old core i5-4200M @ 2.50GHz,
> 8GB RAM, 1TB HDD).
>
> Notice that the 'clean' target is making a nested call to the parent
> Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
> the previous patch, there would have been _two_ such invocations).
> This is to ensure that the $(GIT_VERSION) make variable is set, once
> that file had been included.  However, the 'clean' target does not use
> the $(GIT_VERSION) variable, so this is wasted effort.
>
> In order to eliminate such wasted effort, use the value of the internal
> $(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
> target is not 'clean'. (This drops the time down to 10.361s, on my laptop,
> giving an improvement of 16.20%).

Again, nicely explained.

>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  Documentation/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 652d57a1b6..5c680024eb 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -272,7 +272,9 @@ install-html: html
>  ../GIT-VERSION-FILE: FORCE
>  	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
>  
> +ifneq ($(MAKECMDGOALS),clean)
>  -include ../GIT-VERSION-FILE
> +endif
>  
>  #
>  # Determine "include::" file references in asciidoc files.

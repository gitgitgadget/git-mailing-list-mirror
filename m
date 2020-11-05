Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAFAC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D671E20728
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="De5K2Itb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgKEVwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:52:54 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55217 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbgKEVwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:52:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D28D0FA153;
        Thu,  5 Nov 2020 16:52:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7527enJw8J+Pa+9tKYuxVWvVvTU=; b=De5K2I
        tbWneOlmH4moHMMHlJ+ykJ+oBdRx+lYCpZRNjS07BdTGgOCgeJONbu/P26esUw4p
        vPqar3p6K+ooFQuNUfvqexo+lXWUKduCFk9NdQIRL1acUyQq+UBfHQ7GQTYPT6Vy
        ZRYyvWJrWWQRjN1DHXFywqrJdolfyJC6RtXuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BcOPonsVEFg5Uw7H1ALNv1qdvQqHAgqj
        gFaNXCbgPwBiTfYzlBUJvfGpcYRpr0smR4Cncg7zy2jtUpKgR2S4dBhrLAlsLr+Y
        8dz2kBrM+C0IpcxGwTtC1II1qeGy6KpljL47KfVPvEIeMRaf19P+ZCFbVrQRwrOA
        6vcXxbLkfi0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC3A8FA150;
        Thu,  5 Nov 2020 16:52:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 021BCFA14F;
        Thu,  5 Nov 2020 16:52:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
References: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
Date:   Thu, 05 Nov 2020 13:52:48 -0800
In-Reply-To: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 5 Nov 2020 21:03:49 +0000")
Message-ID: <xmqqy2jfh3nz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F840EE8-1FB1-11EB-9CF3-E43E2BB96649-77302942!pb-smtp20.pobox.com
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

This obviously relies on the fact that none of our build products to
be cleaned are named using $(GIT_VERSION)---in other words, if our
cleaning rule contained

	rm -f git-$(GIT_VERSION)-manual.html

this optimization would not work well.

Luckily, I think we use GIT_VERSION only to engrave version number
in the resulting document, and it does not affect the name of the
build product, so this change is safe, I think.

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

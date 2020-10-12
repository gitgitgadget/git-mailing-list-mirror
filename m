Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6504C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC0320757
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o7ChpqjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbgJLTUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:20:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63291 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgJLTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:20:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 27382F810D;
        Mon, 12 Oct 2020 15:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=X+20nww1E40v
        al/bBLCf6PCLpiY=; b=o7ChpqjAKvD8aHiqDrEZwrXh5O20vD3IU4+uSN+/OPdH
        FwkSKUVlQB69LbhrHqpSSL9K7k0itzDn9km7MHVItCtbJ/22HxlZsCtFU47w995b
        wVEviIBOAlCSxlcFqAHY3oHAdagMNm0sufiHdh/BNPx/S6qsQdX3pjEj11of5bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bmQZcj
        dk6Tiq5tu3+DzO7WOeN1WfruxwpodNM0m/vnkCXFULHp5mcSxDRabgRzO/curYWH
        OAO0IDI2my5a6HQY6VHVVyogtFCWB1YgnUyxK+B1McPBGd8PViMYgi+U6U8WjnSq
        tbUjc5novgZHQ+OGXcoKO/F+USCtmqGLiLTVk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D09BF810C;
        Mon, 12 Oct 2020 15:20:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6617FF810B;
        Mon, 12 Oct 2020 15:20:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: use git init/add/commit/archive for dist-doc
References: <40da2404-8504-e134-7176-f3429c081f12@web.de>
Date:   Mon, 12 Oct 2020 12:20:47 -0700
In-Reply-To: <40da2404-8504-e134-7176-f3429c081f12@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 10 Oct 2020 18:45:18 +0200")
Message-ID: <xmqqft6jp7xs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 094E6C5A-0CC0-11EB-AB94-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Reduce the dependency on external tools by generating the distribution
> archives for HTML documentation and manpages using git commands instead
> of tar. This gives the archive entries the same meta data as those in
> the dist archive for binaries.

Hmph.  I vaguely recall somebody on a more exotic platform wanted
our "tar" invocations to be tweakable as their "tar" lacked options
or something like that, and hopefully pushing our build procedure in
this direction would help them.

Will queue.  Thanks.

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 95571ee3fc..b7f3708292 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3105,11 +3105,15 @@ artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SC=
RIPT_LIB) $(OTHER_PROGRAMS) \
>  htmldocs =3D git-htmldocs-$(GIT_VERSION)
>  manpages =3D git-manpages-$(GIT_VERSION)
>  .PHONY: dist-doc distclean
> -dist-doc:
> +dist-doc: git$X
>  	$(RM) -r .doc-tmp-dir
>  	mkdir .doc-tmp-dir
>  	$(MAKE) -C Documentation WEBDOC_DEST=3D../.doc-tmp-dir install-webdoc
> -	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar $(TAR_DIST_EXTRA_OPTS=
) .
> +	./git -C .doc-tmp-dir init
> +	./git -C .doc-tmp-dir add .
> +	./git -C .doc-tmp-dir commit -m htmldocs
> +	./git -C .doc-tmp-dir archive --format=3Dtar --prefix=3D./ HEAD^{tree=
} \
> +		> $(htmldocs).tar
>  	gzip -n -9 -f $(htmldocs).tar
>  	:
>  	$(RM) -r .doc-tmp-dir
> @@ -3119,7 +3123,11 @@ dist-doc:
>  		man5dir=3D../.doc-tmp-dir/man5 \
>  		man7dir=3D../.doc-tmp-dir/man7 \
>  		install
> -	cd .doc-tmp-dir && $(TAR) cf ../$(manpages).tar $(TAR_DIST_EXTRA_OPTS=
) .
> +	./git -C .doc-tmp-dir init
> +	./git -C .doc-tmp-dir add .
> +	./git -C .doc-tmp-dir commit -m manpages
> +	./git -C .doc-tmp-dir archive --format=3Dtar --prefix=3D./ HEAD^{tree=
} \
> +		> $(manpages).tar
>  	gzip -n -9 -f $(manpages).tar
>  	$(RM) -r .doc-tmp-dir
>
> --
> 2.28.0

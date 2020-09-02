Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E62C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EEB208C7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g3cH5mHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBTor (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:44:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50268 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBToq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:44:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D85E6AC02;
        Wed,  2 Sep 2020 15:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sTSFWH2q4Wxr
        tgDbi0KKMA+D9Uk=; b=g3cH5mHopLmVWi47PbMcJP4QG6mpbHMZ9DVyweIUbYIx
        UWca7xYbUIgcAJcp9/akQ54eXVNaTZt33SrlFhw9rZu0EvWAshKAeWK0IL+lu89T
        jwVvYP+gZlAnMnhVVHg0v6ZbGgXYU2Vh1dU2kAUCobXpbKOkjmDvsD5j8cwq8Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=fTBucn
        0u+9dYmCufu/RkgFWVCOv3TJA79fKWtOQXAfebpUvwDZLWrj+NHi/81p8n65nRub
        nZPpXvtQYXMOgvEkWkCAlMm10WOWX7fVpoopktzh+y+kQqhvLTk+83WLKuu+qy2K
        ADOgKvRbMymY2+6ypue9YrwvrsHPd4vGAXXYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94DCB6AC01;
        Wed,  2 Sep 2020 15:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BD0B6AC00;
        Wed,  2 Sep 2020 15:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'git'" <git@vger.kernel.org>
Subject: Re: [Suggestion] Documentation: quick-install-man not propagating DESTDIR
References: <077a01d680af$2ad65510$8082ff30$@nexbridge.com>
Date:   Wed, 02 Sep 2020 12:44:41 -0700
In-Reply-To: <077a01d680af$2ad65510$8082ff30$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 1 Sep 2020 18:28:02 -0400")
Message-ID: <xmqqft80arpy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BEBC8BAC-ED54-11EA-A402-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> The make quick-install-man rule is not propagating DESTDIR when GNU Mak=
e
> 4.2.1 is used.

I wonder, instead of having to change all "$(MAKE) -C elsewhere", we
can add DESTDIR to the list of variables that are exported.

... goes and looks ...

Hmph, DESTDIR is exported together with DIFF, TAR, INSTALL and
SHELL_PATH.  We do rely on SHELL_PATH to be exported correctly to
t/Makefile for "make test" to work, so it is puzzling.

It is doubly puzzling that we use $(INSTALL) in Documentation/Makefile
on the same line as $(DESTDIR) is used, and apparently you are not
reporting problem on that one.

> It seems like a bit of a nit to report this, but I discovered that the
> installation is not putting the manuals in the same place as git. It=E2=
=80=99s a
> pretty simple fix. I can put a patch together if desired.

I do not think we want that patch.  Instead I think we'd want a
patch that uses the same trick as what makes INSTALL work.

Thanks.

> diff --git a/Makefile b/Makefile
> index 372139f1f2..dae2d99a7f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2992,10 +2992,10 @@ install-gitweb:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C gitweb install
>
> install-doc: install-man-perl
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install =
DESTDIR=3D$(DESTDIR)
>
> install-man: install-man-perl
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install-=
man
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install-=
man DESTDIR=3D$(DESTDIR)
>
> install-man-perl: man-perl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(INSTALL) -d -m 755 '$(DEST=
DIR_SQ)$(mandir_SQ)/man3'
> @@ -3006,19 +3006,19 @@ install-html:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation ins=
tall-html
>
> install-info:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install-=
info
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install-=
info DESTDIR=3D$(DESTDIR)
>
> install-pdf:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install-=
pdf
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation install-=
pdf DESTDIR=3D$(DESTDIR)
>
> quick-install-doc:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation quick-in=
stall
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation quick-in=
stall DESTDIR=3D$(DESTDIR)
>
> quick-install-man:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation quick-in=
stall-man
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation quick-in=
stall-man DESTDIR=3D$(DESTDIR)
>
> quick-install-html:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation quick-in=
stall-html
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) -C Documentation quick-in=
stall-html DESTDIR=3D$(DESTDIR)
>
> -- Brief whoami:
> NonStop developer since approximately 211288444200000000
> UNIX developer since approximately 421664400
> -- In my real life, I talk too much.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C15C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D26610F8
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 23:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhKIXNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:13:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60981 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhKIXNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 18:13:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 059601566DB;
        Tue,  9 Nov 2021 18:10:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ryGzFjE6rAu0
        /8oLdQzU/2XcIQ1x4csbowxxkepmEVQ=; b=xjg1R9/T3jhdQPQEvHdNoL3tYUNZ
        9/udUfXnoUB40Ldjma10M2dZOh2RMeIMkn9TP1hB4Iy13KDR+Ux46k8C2DS2glDe
        4co8eN/Q3aVJJlZ3htOZ44Kyw9sZRgkncOzzZluH35Jysz/n5L+bpUXSm2n2ZbKO
        4iB7NUpu1jOTBnk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0FF71566DA;
        Tue,  9 Nov 2021 18:10:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5BDD91566D8;
        Tue,  9 Nov 2021 18:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/16] Makefile: clean perl/build/ even with NO_PERL=Y
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
        <patch-02.16-2d8049f792c-20211106T205717Z-avarab@gmail.com>
Date:   Tue, 09 Nov 2021 15:10:21 -0800
In-Reply-To: <patch-02.16-2d8049f792c-20211106T205717Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 6 Nov
 2021 22:03:03
        +0100")
Message-ID: <xmqqwnlhylgi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36F93612-41B2-11EC-AD6D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a regression in 499c29394ce (Makefile: allow building without
> perl, 2009-04-03) where we'd stop cleaning the perl/* directory
> because NO_PERL was defined, thus leaving behind litter if the flag at
> "clean" time didn't match that of build time.
>
> In 499c29394ce this was done to avoid relying on the perl/Makefile.PL,
> but since my 20d2a30f8ff (Makefile: replace perl/Makefile.PL with
> simple make rules, 2017-12-10) we can clean things in that directory
> unconditionally.

Nicely analyzed. And it is a nice touch to move the removal next to
where we remove the Python stuff.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9f57c34e954..82eb8ea446b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3234,6 +3234,7 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(HCC)
>  	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
>  	$(RM) -r po/build/
> +	$(RM) -r perl/build/
>  	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags=
 cscope*
>  	$(RM) -r .dist-tmp-dir .doc-tmp-dir
>  	$(RM) $(GIT_TARNAME).tar.gz
> @@ -3242,7 +3243,6 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
>  ifndef NO_PERL
>  	$(MAKE) -C gitweb clean
> -	$(RM) -r perl/build/
>  endif
>  	$(MAKE) -C templates/ clean
>  	$(MAKE) -C t/ clean

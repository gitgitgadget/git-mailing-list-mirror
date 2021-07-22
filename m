Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8ABC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 16:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3676861241
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 16:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhGVQQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 12:16:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60615 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbhGVQPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 12:15:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D308CA6CB;
        Thu, 22 Jul 2021 12:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7rgGZTGRJdQB
        EAjJGhN/HMze17syLwznvJYUd4Yrk4o=; b=JvkTT1mwGdiR4u3uKfwH86c+m/uX
        JTlY9xmEG0e/qBGYzuhGYD0WI7ja+cDf8SXvrrpAcheK6a2yw9blKu0funECzPtt
        qFQK1jUjOexuhw2BUNR91u80FOMCitxa+7vzDfyxMksl7YIKH5sdFhAoYUKXK0aA
        EwdRIqhEbQ7LoBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 867A3CA6CA;
        Thu, 22 Jul 2021 12:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC246CA6C9;
        Thu, 22 Jul 2021 12:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/5] Makefile: the "cscope" target always creates a
 "cscope.out"
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
        <patch-4.5-f8d151f1f6a-20210721T231900Z-avarab@gmail.com>
Date:   Thu, 22 Jul 2021 09:55:31 -0700
In-Reply-To: <patch-4.5-f8d151f1f6a-20210721T231900Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 01:23:05 +0200")
Message-ID: <xmqqk0li9tks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A0C3E3A4-EB0D-11EB-BB46-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In the preceding commit the "cscope" target was changed to be a phony
> alias for the "cscope.out" target.
>
> The cscope target was added in a2a9150bf06 (makefile: Add a cscope
> target, 2007-10-06), and has always referred to cscope* instead of to
> cscope.out.
>
> As far as I can tell this ambiguity was never needed. The
> "-fcscope.out" (note, no whitespace) argument is enabled by default,
> but let's provide it explicitly for good measure.

Isn't it because we anticipated possible use of options like '-q' in
the future that we clean and ignore cscope* instead of the single
cscope.out and nothing else?

   $ echo *.c | xargs cscope -b -q; git clean -n -x
   Would remove cscope.in.out
   Would remove cscope.out
   Would remove cscope.po.out

I know we currently care only about cscope.out and it is perfectly
fine to make the phony cscope depend on cscope.out only, but I'd
feel safer to keep the exclude patterns and $(RM) clean rule to
catch them.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  .gitignore | 2 +-
>  Makefile   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 311841f9bed..d74029c1ca7 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -217,7 +217,7 @@
>  /.vscode/
>  /tags
>  /TAGS
> -/cscope*
> +/cscope.out
>  /compile_commands.json
>  *.hcc
>  *.obj
> diff --git a/Makefile b/Makefile
> index 18895d94ffa..730ff23b923 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2752,8 +2752,8 @@ tags: $(FOUND_SOURCE_FILES)
>  	mv tags+ tags
> =20
>  cscope.out: $(FOUND_SOURCE_FILES)
> -	$(QUIET_GEN)$(RM) cscope* && \
> -	echo $(FOUND_SOURCE_FILES) | xargs cscope -b
> +	$(QUIET_GEN)$(RM) cscope.out && \
> +	echo $(FOUND_SOURCE_FILES) | xargs cscope -f$@ -b
> =20
>  .PHONY: cscope
>  cscope: cscope.out
> @@ -3230,7 +3230,7 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(HCC)
>  	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
>  	$(RM) -r po/build/
> -	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags=
 cscope*
> +	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags=
 cscope.out
>  	$(RM) -r .dist-tmp-dir .doc-tmp-dir
>  	$(RM) $(GIT_TARNAME).tar.gz
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7FA20193
	for <e@80x24.org>; Thu,  1 Sep 2016 21:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbcIAVAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:00:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755315AbcIAVAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C1C03706D;
        Thu,  1 Sep 2016 13:43:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B0yckXUfFGoSCWpHUW2qSE6Al5M=; b=UgUyZ3
        TgNBWa+sFM8fodMKlziNct4ngC5M+Yq3wN1bknV2/FPvygg748bM38x25SAVhoJ5
        Sej6JmoX6oHWHvYoDqHwW9gPfgTwAOWjTmFtEBKbG9HQo1NpWGoqTJ7GAoN4wz/6
        bWpSHlfhrwmk831lTSG7CF5oS46eoSpqwtXZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M0DOgxwV9ApvaOOFmuiFmAOeuypOmrS0
        lb6AfMagmy9PzbT7eeNmwej2Gsb31oT/wzg9hMasTz/EwPBd1ry8QZ622OJOUt6B
        9IUbmgNKeD3bxt+8Ztun6e8XXSyWxVC4gbHmq/LHJd3GVKm2T3707l0Vp7QN8D63
        99wGyckSZv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44D623706C;
        Thu,  1 Sep 2016 13:43:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB85B3706A;
        Thu,  1 Sep 2016 13:43:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make dist: allow using an installed version of git
References: <20160827102929.GA11769@hurricane>
Date:   Thu, 01 Sep 2016 10:43:38 -0700
In-Reply-To: <20160827102929.GA11769@hurricane> (Dennis Kaarsemaker's message
        of "Sat, 27 Aug 2016 12:29:33 +0200")
Message-ID: <xmqq4m5zy0qd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EB47CEE-706B-11E6-B7C7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> b1de9de2 back in 2005 ensured that we could create a tarball with 'make
> dist' even if git wasn't installed yet. These days however, chances are
> higher that a git version is available. Add a config.mak knob to allow
> people to choose to use the installed version of git to create the
> tarball and avoid the overhead of building git-archive.

Thanks, but not interested.

We do not know what vintage of "git" happens to be installed on the
platform, but we know how "git archive" we ship with the source
ought to behave.

>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  Makefile | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index d96ecb7..3dabb75 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -378,6 +378,9 @@ all::
>  #
>  # to say "export LESS=FRX (and LV=-c) if the environment variable
>  # LESS (and LV) is not set, respectively".
> +#
> +# Define USE_INSTALLED_GIT_ARCHIVE if you don't want to build git-archive as
> +# part of 'make dist', but are happy to rely on a git version on you $PATH
>  
>  GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -2423,8 +2426,15 @@ quick-install-html:
>  ### Maintainer's dist rules
>  
>  GIT_TARNAME = git-$(GIT_VERSION)
> -dist: git-archive$(X) configure
> -	./git-archive --format=tar \
> +ifndef USE_INSTALLED_GIT_ARCHIVE
> +	GIT_ARCHIVE = ./git-archive$(X)
> +	GIT_ARCHIVE_DEP = git-archive$(X)
> +else
> +	GIT_ARCHIVE = git archive
> +	GIT_ARCHIVE_DEP =
> +endif
> +dist: $(GIT_ARCHIVE_DEP) configure
> +	$(GIT_ARCHIVE) --format=tar \
>  		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
>  	@mkdir -p $(GIT_TARNAME)
>  	@cp configure $(GIT_TARNAME)

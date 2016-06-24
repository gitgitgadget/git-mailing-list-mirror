Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6438B1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 22:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbcFXWOQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 18:14:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751081AbcFXWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 18:14:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0629F26960;
	Fri, 24 Jun 2016 18:14:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYyEhpisEUtoVZZhAedRkoRGfLA=; b=yg3IF5
	J0xYf9nnYnDp5f+d0eA/BDstBIP8XRivAq9Xvv/s69hyuJ4HgUQeASjPzRU2cETL
	ihEZPvLKqmcv+moGeBhgvdgpz9ZegGLWOT8xzk1cYx6BZD/SMQDCQFqac0c+vtSD
	thVZ+LsmElbcpPhBpmVIAvV48p+fibgCJkBys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xfUYGV1XLOvMlzZPdA8o4mvMOHwA0Huy
	I8nFPnHU4jJAxbePYz5YehaXqbFkXoudNogdEqefuMqH5hxAjmcq5wsY/u7Zj+Cf
	E8/IHkfSUbR5Rh2E5NKHeBxllrueGRnLX14ORQiBazJycVrMtbrYeYwQSwfyLeeT
	IUv4GfhriNs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2C7B2695F;
	Fri, 24 Jun 2016 18:14:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CB202695E;
	Fri, 24 Jun 2016 18:14:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] diff: let --output=<file> default to --no-color
References: <100cea0edf4f0986c000eb945a5e5955b8b59787.1466604435.git.johannes.schindelin@gmx.de>
Date:	Fri, 24 Jun 2016 15:14:11 -0700
In-Reply-To: <100cea0edf4f0986c000eb945a5e5955b8b59787.1466604435.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 22 Jun 2016 16:41:07 +0200
	(CEST)")
Message-ID: <xmqqshw2dyks.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBAB6F5A-3A58-11E6-9246-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is highly unlikely that any user would want to see ANSI color
> sequences in a file. So let's stop doing that by default.
>
> This is a backwards-incompatible change.
>
> The reason this was not caught earlier is most likely that either
> --output=<file> is not used, or only when stdout is redirected
> anyway.
>
> Technically, we do not default to --no-color here. Instead, we try to
> override the GIT_COLOR_AUTO default because it would let want_color()
> test whether stdout (instead of the specified file) is connected to a
> terminal. Practically, we require the user to require color "always"
> to force writing ANSI color sequences to the output file.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/diff-o-v1
>
> 	Just something I noted while working on a bit more consistency
> 	with the diffopt.file patches.
>
> 	This is a backwards-incompatible change, though. So I extracted it
> 	from the patch series.

I think this is a bugfix.  Even though we are writing to a file that
is separate from the standard output (because we explicitly opened
that file outselves), --color=auto would still let want_color() make
the decision based on isatty(1) with hardcoded 1.  That does not
simply make sense.

If we imagine that your format-patch series with 06/10 and 07/10
swapped, then the "do not freopen(), instead point opened file with
diffopt.file" step would be seen as introducing the same bug as the
bug this patch fixes, so in that sense it is an equivalent to 06/10.
We do not need to view this patch as a compatibility-breaking
change, I would think.

Perhaps I should tweak 06/10 to assign GIT_COLOR_NEVER not 0 while
queuing it.

Thanks.

>  diff.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index fa78fc1..b66b9be 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3977,6 +3977,8 @@ int diff_opt_parse(struct diff_options *options,
>  		if (!options->file)
>  			die_errno("Could not open '%s'", path);
>  		options->close_file = 1;
> +		if (options->use_color != GIT_COLOR_ALWAYS)
> +			options->use_color = GIT_COLOR_NEVER;
>  		return argcount;
>  	} else
>  		return 0;

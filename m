Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE6DC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCC5207DE
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GU8FaNsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHSTjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:39:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52438 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHSTje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:39:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 281A2F0886;
        Wed, 19 Aug 2020 15:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mQrlPVSfjA14EfM1in23bEgddlY=; b=GU8FaN
        sNLPB7Pw1yc+Iugu6Pq5s8SItpzMolptUshqT5svh7yyGqHQskDwRb78sQeqdbgM
        2Qb0KKMz1TiKYNxQolu7di8ale1EB/LYEzmTvIVc/QdwJm8IfBHiJQcFy01Gbeii
        DdcY6vwRndS1S4dPpbIBei23Scvz5Q+AP78kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GGi/N/u+ptyPHSeohoctaxEXr7COCCJn
        r/YXTT/xdUcSx3G3qubHwYzGEdy6H4vuepRnOCgQ6+qfxi0vxBBg36SiCu0xgynM
        tD2wm3fOPRUYUiPpTXLkUvtZSTOEP80xEEbLcVri6xjISvGSlUBXcTh7MuILWOL7
        eMLZa6/tzfk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 20AB0F0885;
        Wed, 19 Aug 2020 15:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 65478F0883;
        Wed, 19 Aug 2020 15:39:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] parse-options: add --git-completion-helper-all
References: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
        <20200819175047.692962-2-rtzoeller@rtzoeller.com>
Date:   Wed, 19 Aug 2020 12:39:24 -0700
In-Reply-To: <20200819175047.692962-2-rtzoeller@rtzoeller.com> (Ryan Zoeller's
        message of "Wed, 19 Aug 2020 17:51:08 +0000")
Message-ID: <xmqqeeo2togj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0C7FA92-E253-11EA-A5AF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ryan Zoeller <rtzoeller@rtzoeller.com> writes:

> --git-completion-helper excludes hidden options, such as --allow-empty
> for git commit. This is typically helpful, but occasionally we want
> auto-completion for obscure flags.

Hits from "git grep -B2 OPT_NOCOMPLETE" tells me that these are
mostly unsafe options.  Those who accept the risk by saying
"complete all" should be allowed to see them.

The same with OPT_HIDDEN (including OPT_HIDDEN_<TYPE>) gives us a
mixed bag.  Many are unsafe, some are uncommon and the rest are
discouraged, or old synonym to some other option that does get
completed.  I am not sure if letting them be completed is an overall
win or makes the output from "git cmd --<TAB><TAB>" too noisy.

> --git-completion-helper-all returns
> all options, even if they are marked as hidden or nocomplete.

If it is "occasinally", why is the removal of OPT_HIDDEN in
show_negated_gitcomp() unconditional?

> Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
> ---
>  parse-options.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index c57618d537..cc7239e1c6 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -535,8 +535,9 @@ static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
>  
>  		if (!opts->long_name)
>  			continue;
> -		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
> -			continue;
> +		/* Don't check PARSE_OPT_HIDDEN or PARSE_OPT_NOCOMPLETE,
> +		 * we expect the caller to handle these appropriately.
> +		 */

	/*
	 * Style: our multi-line comments should begin with
	 * slash-asterisk alone on its own line, and end with
	 * asterisk-slash also on its own line, like this.
	 */

We do not run around and fix existing style violations that would
only raise the patch noise, but we try not to introduce new
violators.

I am not sure what the new comment says is justifiable.  The only
caller of show_negated_gitcomp() is in show_gitcomp() where the
function looped over the options and showed the options normally,
honoring these two flags, but then the original list of options
are passed to this function without filtering any option element
on the list that are marked with these bits, so "the caller"
apparently is not interested in handling the elements with these
bits when making the decision to show "--no-<option>" form itself;
it farms it out to show_negated_gitcomp() and expects the function
to do "the right thing".  Am I misleading the code?


>  		if (opts->flags & PARSE_OPT_NONEG)
>  			continue;
>  
> @@ -572,7 +573,7 @@ static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
>  	}
>  }
>  
> -static int show_gitcomp(const struct option *opts)
> +static int show_gitcomp(const struct option *opts, int show_all)
>  {
>  	const struct option *original_opts = opts;
>  	int nr_noopts = 0;
> @@ -582,7 +583,8 @@ static int show_gitcomp(const struct option *opts)
>  
>  		if (!opts->long_name)
>  			continue;
> -		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
> +		if (!show_all &&
> +			(opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE)))
>  			continue;
>  
>  		switch (opts->type) {
> @@ -723,9 +725,13 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
>  		if (internal_help && ctx->total == 1 && !strcmp(arg + 1, "h"))
>  			goto show_usage;
>  
> -		/* lone --git-completion-helper is asked by git-completion.bash */
> +		/* lone --git-completion-helper and --git-completion-helper-all
> +		 * are asked by git-completion.bash
> +		 */

Ditto.

>  		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
> -			return show_gitcomp(options);
> +			return show_gitcomp(options, 0);
> +		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper-all"))
> +			return show_gitcomp(options, 1);

This is not your fault, but the micro-optimization to avoid
comparison between *arg (which already is known to be "-") and "-"
is not worth the reduced readability.  

		if (ctx->total == 1 && !strcmp(arg, "--git-completion-helper"))
			return show_gitcomp(options, 0);
		if (ctx->total == 1 && !strcmp(arg, "--git-completion-helper-all"))
			return show_gitcomp(options, 1);

would be much clearer for readers to know what is going on.

With an extra "const char *rest" variable in the same scope as
"const char *arg",

		if (ctx->total == 1 && 
		    !skip_prefix(arg, "--git-completion-helper", &rest) && 
		    (!*rest || !strcmp(rest, "-all")))
			return show_gitcomp(options, *rest);

would further avoid repetitions, but some folks may find it a bit
too dense.  I dunno.

>  
>  		if (arg[1] != '-') {
>  			ctx->opt = arg + 1;

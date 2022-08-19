Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A31C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350067AbiHSSCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350331AbiHSSCI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:02:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0513866137
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:48:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h24so5974426wrb.8
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=m+24wK3xO/P1pLdfrs1lVLIiKi56/y5h/h+z7vj17XI=;
        b=gblO5TtAlXtoNwMh6xX2InELwyNAz18vo8c1z6OocZGoV44yDA4YhbPWS+lwx7/hIU
         i/lDgpBQU/vEjHSVv43zZBt62chK5pXFvtzB6fnTC9roOGTxn6yCvcx51IiJmO5qW2gD
         WZBUxzeIGfyI99tkdNHuTKFo9PeZbvenyV6woWNmCkXnM2eCrGgGB8W8DTJBHWalNcmc
         uGicSTLB6LNlf66Pr+pg6HP6FZtgNHuB9vAHaN8mpBvwzXr6jnJ5p1kTe5R6HCkxykD0
         bRF6LoGApw1isepg8NHITQJcK+t56lSz8DEsmxRxJ0Lz4nQ7YaqqC54PXnwdxbv9ReZP
         ExIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=m+24wK3xO/P1pLdfrs1lVLIiKi56/y5h/h+z7vj17XI=;
        b=udnqv+7b5HjuHx4oqIJrdEeE4pWKnvfpXFLqZJwoEVbF1PRCnXUlBQrsbsjc1szWdy
         lY+zv88cUY4VHgv7QLpAFP8fwCIIkpwzVt2yTL/rboakEezi2GFSzQfQHUhVUWqrz2yE
         F/WPNVRPemn8MZ39+aiJLqJZuQNCuN7ysJR+YS+e49kNlhGImAyL85sY4BV7M/f2/wak
         6lZBmBfs9rwYq47zcjyeSWpHLKTMF/jAFXhIa4yU7FGO9GBE3LCRH5sEVZOWsy3pNz/o
         Fp2Xn9diUYmow0ICZQIYKpQA4jtmJqEX4IJ18XQ8XjDoYpTYLj0wPKflbAkd1jqjLEaJ
         Bu9Q==
X-Gm-Message-State: ACgBeo1bzxjy7n3DXnLVyRsBzIf7GGJA5dK2b+9sbyrmLj4+mkS3Ner/
        wCPySGXvwRU/c+kUcY4NkMc=
X-Google-Smtp-Source: AA6agR7eLYtaQjIVUBhGOUsboTO/CYYnxJCTWAslOaMT6N5goHtXdcQhyPzSeipxuvqAmLnokbyQsg==
X-Received: by 2002:a05:6000:69a:b0:223:664f:15b8 with SMTP id bo26-20020a056000069a00b00223664f15b8mr5172526wrb.356.1660931319953;
        Fri, 19 Aug 2022 10:48:39 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5f2cc2f1dsm9628736wmq.42.2022.08.19.10.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:48:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP66o-000par-0Z;
        Fri, 19 Aug 2022 19:48:38 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/20] parse-options: add support for parsing
 subcommands
Date:   Fri, 19 Aug 2022 19:33:46 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-10-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-10-szeder.dev@gmail.com>
Message-ID: <220819.86bksg6s5l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> +static enum parse_opt_result parse_subcommand(const char *arg,
> +					      const struct option *options)
> +{
> +	for (; options->type !=3D OPTION_END; options++)
> +		if (options->type =3D=3D OPTION_SUBCOMMAND &&
> +		    !strcmp(options->long_name, arg)) {
> +			*(parse_opt_subcommand_fn **)options->value =3D options->subcommand_f=
n;

Nit: Maybe do the cast by assigning to an intermediate variable? Would
make this less dense, and since we already have {}-braces...

> +			return PARSE_OPT_SUBCOMMAND;
> +		}
> +
> +	return PARSE_OPT_UNKNOWN;
> +}
> +
>  static void check_typos(const char *arg, const struct option *options)
>  {
>  	if (strlen(arg) < 3)
> @@ -442,6 +457,7 @@ static void check_typos(const char *arg, const struct=
 option *options)
>  static void parse_options_check(const struct option *opts)
>  {
>  	char short_opts[128];
> +	void *subcommand_value =3D NULL;
>=20=20
>  	memset(short_opts, '\0', sizeof(short_opts));
>  	for (; opts->type !=3D OPTION_END; opts++) {
> @@ -489,6 +505,14 @@ static void parse_options_check(const struct option =
*opts)
>  			       "Are you using parse_options_step() directly?\n"
>  			       "That case is not supported yet.");
>  			break;
> +		case OPTION_SUBCOMMAND:
> +			if (!opts->value || !opts->subcommand_fn)
> +				optbug(opts, "OPTION_SUBCOMMAND needs a value and a subcommand funct=
ion");

Better split into two IMO:

	if (!opts->value)
		optbug(opts, "OPTION_SUBCOMMAND needs a value");
	if (!opts->subcommand_fn)
		optbug(opts, "OPTION_SUBCOMMAND needs a subcommand_fn");

Then if we have extra checks we don't need to keep adding to a dense ||
and amend an existing string.

> +static int has_subcommands(const struct option *options)
> +{
> +	for (; options->type !=3D OPTION_END; options++)
> +		if (options->type =3D=3D OPTION_SUBCOMMAND)
> +			return 1;
> +	return 0;
> +}

I wondered if parse_options_check() couldn't take a "int
*has_subcommands", since we already loop through the options to check it
as part of the checks there (but we'd need to re-arrange them).

Not for optimization, just wondering if it would make the code flow
clearer, maybe not.

> +	if (ctx->has_subcommands) {
> +		if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
> +			BUG("subcommands are incompatible with PARSE_OPT_STOP_AT_NON_OPTION");
> +		if (!(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
> +			if (flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
> +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN_OPT un=
less in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
> +			if (flags & PARSE_OPT_KEEP_DASHDASH)
> +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_DASHDASH unles=
s in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");

MM, very long lines. Maybe something like:

	BUG("%s flag cannot be combined with %s, unless %s is also provided", ...);

> +		}
> +	}
>  	if ((flags & PARSE_OPT_KEEP_UNKNOWN_OPT) &&
>  	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
>  	    !(flags & PARSE_OPT_ONE_SHOT))
> @@ -589,6 +634,7 @@ static int show_gitcomp(const struct option *opts, in=
t show_all)
>  	int nr_noopts =3D 0;
>=20=20
>  	for (; opts->type !=3D OPTION_END; opts++) {
> +		const char *prefix =3D "--";

Ah, here we have a prefix variable, but it's more of an "infix"... :)

> +					return PARSE_OPT_DONE;
> +				error(_("unknown subcommand: `%s'"), arg);
> +				usage_with_options(usagestr, options);

ditto earlier patch comment about usage_msg_opt() (also applies below)

> +			case PARSE_OPT_NON_OPTION:
> +				/* Impossible. */

We could just skip this comment as...
> +				BUG("parse_subcommand() cannot return these");

...this makes it clear.

>  	case PARSE_OPT_DONE:
> +		if (ctx.has_subcommands &&
> +		    !(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
> +			error(_("need a subcommand"));
> +			usage_with_options(usagestr, options);

ditto.

> +typedef int parse_opt_subcommand_fn(int argc, const char **argv,
> +				    const char *prefix);

We usually define function typedefs like:

	typedef int (*parse_opt_subcommand_fn)(...);

But I see that...

>  	enum parse_opt_type type;
> @@ -145,6 +155,7 @@ struct option {
>  	intptr_t defval;
>  	parse_opt_ll_cb *ll_callback;
>  	intptr_t extra;
> +	parse_opt_subcommand_fn *subcommand_fn;

You're doing this consistently with parse_opt_ll_cb etc., fair enough.

> +#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
> +	.type =3D OPTION_SUBCOMMAND, \
> +	.long_name =3D (l), \
> +	.value =3D (v), \
> +	.flags =3D (f), \

Nice to see this form

> +	.subcommand_fn =3D (fn) }

Almost all other such decls end with:

		.foo =3D bar, \
	}

I.e. we put the closing "}" at the start of the line.

> +#define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)

I think this would be more readable as:

	#define OPT_SUBCOMMAND(l, v, fn) \
		OPT_SUBCOMMAND_F((l), (v), (fn), 0)

Which both aligns nicely, and isn't using a \t in the middle of the line
(which in any case we'll end up aligning with nothing else, as the names
are all different lengths, if other things continue using this pattern.
>  	enum parse_opt_flags flags;
> +	unsigned has_subcommands;

Maybe make it: "unsigned has_subcommands:1"?

> +	printf("fn: subcmd_one\n");

s/printf/puts/g here

> +	print_args(argc, argv);
> +	return 0;
> +}
> +
> +static int subcmd_two(int argc, const char **argv, const char *prefix)
> +{
> +	printf("fn: subcmd_two\n");

ditto.


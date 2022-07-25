Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE388C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 14:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiGYO7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYO7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 10:59:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF00310FE4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:59:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so21079249ejb.6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=k0IjI0EwRktTWykBoN8VQDrJqV8jgrk83ANe4tVDcyg=;
        b=O6z6bvUVhZtv08s50TMGOBtLXUfClKqKtxyTU7DRdUrc/QWWJS2e5PRJp7jkE73hlU
         xhNxnl7U5Ny2j30pFGguiL3RmUp2tumhFaJUZWMW/9ACzN45DoTXylyTtBJtnv8YQ++S
         V4/ALuYHOwfgiiY5JTMD31Y9OXbu69dDT85VvcdKp/qmOfoy2JwNy94KFIhJ0fdD88Le
         k5nK07Emth2uEWkKnmtdw134pnhN+EU5yZNqPQrtDnP61P10O9NXWTj4OlVeXQcAKDJ/
         lHwOLMXBv/ynV1Tr5oz0FJ3jnul4Rzi3emvjghGydmKDEXr1SieUko+5Lq2JeXRleInx
         UGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=k0IjI0EwRktTWykBoN8VQDrJqV8jgrk83ANe4tVDcyg=;
        b=f8bty9b4iEveVMwCKzuu+wXi66oJXb0YnJ1ivWwLzCukcHwHJzbqPT6qIlT4aqjY4L
         1iL7LrxXwWJw3A96RqmqswIsaFKczxt+kn3JCZv69E8bmxmFPI3TUnnRvVuAJ/31qjnT
         lzGoPAm6tKlUP0lGHDD5wtIBIPTPIGnhAw6/1wY0qr3HnWKfphEnQqJAfW0cPDVah03K
         SF1BchO1Uu9TDRwSkfyn2SwvEgD5P/tSTcDmoJE5TvggRxhlWth2CyeCeS+WweaDWsoG
         JWYjxOb7rVJa5Zob/nY0yv914soHJn5hQKcSFaYvd78Qzbd2RmTCMdcBX/+oc1aZegy6
         9Ytg==
X-Gm-Message-State: AJIora/izDXhcZ9hZv7lISVXTD7xuU3xlsuDnG7Eve2UTQgiIQOSzicH
        /O9zbPTyVG5OQOsi8TaYQondx59C3gE=
X-Google-Smtp-Source: AGRyM1sMQKs1eo7mmO+B4GpSziCIo1azgy971nmZ6MOt+xspaKFxUUzyfRwceNFXYZMwcbie+bYGCw==
X-Received: by 2002:a17:907:c2a:b0:72b:8119:4da9 with SMTP id ga42-20020a1709070c2a00b0072b81194da9mr10307071ejc.746.1658761158025;
        Mon, 25 Jul 2022 07:59:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f5-20020a50fc85000000b0043bc4b28464sm7208301edq.34.2022.07.25.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:59:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFzYC-005ktN-PZ;
        Mon, 25 Jul 2022 16:59:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/20] parse-options: add support for parsing subcommands
Date:   Mon, 25 Jul 2022 16:43:30 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-10-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725123857.2773963-10-szeder.dev@gmail.com>
Message-ID: <220725.86a68xp7az.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, SZEDER G=C3=A1bor wrote:

> Several Git commands have subcommands to implement mutually exclusive
> "operation modes", and they usually parse their subcommand argument
> with a bunch of if-else if statements.

I'll need do look this over in more details, just some comments on the
non-meaty parts for now:

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 02e39420b6..a9fe8cf7a6 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -920,6 +920,7 @@ int cmd_blame(int argc, const char **argv, const char=
 *prefix)
>  			break;
>  		case PARSE_OPT_HELP:
>  		case PARSE_OPT_ERROR:
> +		case PARSE_OPT_SUBCOMMAND:
>  			exit(129);
>  		case PARSE_OPT_COMPLETE:
>  			exit(0);
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 086dfee45a..7a1e1fe7c0 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -381,6 +381,7 @@ int cmd_shortlog(int argc, const char **argv, const c=
har *prefix)
>  			break;
>  		case PARSE_OPT_HELP:
>  		case PARSE_OPT_ERROR:
> +		case PARSE_OPT_SUBCOMMAND:
>  			exit(129);
>  		case PARSE_OPT_COMPLETE:
>  			exit(0);

This feels a bit like carrying forward an API wart, i.e. shouldn't we
instead BUG() if we are returning a PARSE_OPT_SUBCOMMAND from
parse_options_step() for options lists that don't have
PARSE_OPT_SUBCOMMAND in them?

I.e. is this even reachable, or just something to suppress the compiler
complaining about missing enum labels?

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
> +			if (!subcommand_value)
> +				subcommand_value =3D opts->value;
> +			else if (subcommand_value !=3D opts->value)
> +				optbug(opts, "all OPTION_SUBCOMMANDs need the same value");
> +			break;
>  		default:
>  			; /* ok. (usually accepts an argument) */
>  		}

This addition looks good...

> @@ -499,6 +523,14 @@ static void parse_options_check(const struct option =
*opts)
>  	BUG_if_bug("invalid 'struct option'");
>  }
>=20=20
> +static int has_subcommands(const struct option *options)
> +{
> +	for (; options->type !=3D OPTION_END; options++)
> +		if (options->type =3D=3D OPTION_SUBCOMMAND)
> +			return 1;
> +	return 0;
> +}

...but why not...

>  static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
>  				  int argc, const char **argv, const char *prefix,
>  				  const struct option *options,
> @@ -515,6 +547,19 @@ static void parse_options_start_1(struct parse_opt_c=
tx_t *ctx,
>  	ctx->prefix =3D prefix;
>  	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>  	ctx->flags =3D flags;
> +	ctx->has_subcommands =3D has_subcommands(options);
> +	if (!ctx->has_subcommands && (flags & PARSE_OPT_SUBCOMMAND_OPTIONAL))
> +		BUG("Using PARSE_OPT_SUBCOMMAND_OPTIONAL without subcommands");
> +	if (ctx->has_subcommands) {
> +		if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
> +			BUG("subcommands are incompatible with PARSE_OPT_STOP_AT_NON_OPTION");
> +		if (!(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
> +			if (flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
> +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN unless=
 in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
> +			if (flags & PARSE_OPT_KEEP_DASHDASH)
> +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_DASHDASH unles=
s in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
> +		}
> +	}

...move this into parse_options_check()? I.e. we'd need to loop over the
list once, but it seems like this should belong there.

We have an existing bug in-tree due to usage_with_options() not doing a
parse_options_check() (I have a local fix...), checking this sort of
thing there instead of in parse_options_start() is therefore the right
thing to do, i.e. we shoudl have a one-stop "does this options variable
look sane?".

> +				error(_("unknown subcommand: %s"), arg);

s/%s/'%s'/ while we're at it, perhaps?

> +				usage_with_options(usagestr, options);
> +			case PARSE_OPT_COMPLETE:
> +			case PARSE_OPT_HELP:
> +			case PARSE_OPT_ERROR:
> +			case PARSE_OPT_DONE:
> +			case PARSE_OPT_NON_OPTION:
> +				BUG("parse_subcommand() cannot return these");

nit: BUG("got bad %d", v) or whatever, i.e. say what we got?

> @@ -206,6 +217,11 @@ struct option {
>  #define OPT_ALIAS(s, l, source_long_name) \
>  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
>=20=20
> +#define OPT_SUBCOMMAND(l, v, fn)      { OPTION_SUBCOMMAND, 0, (l), (v), =
NULL, \
> +					NULL, 0, NULL, 0, NULL, 0, (fn) }
> +#define OPT_SUBCOMMAND_F(l, v, fn, f) { OPTION_SUBCOMMAND, 0, (l), (v), =
NULL, \
> +					NULL, (f), NULL, 0, NULL, 0, (fn) }

Nit, I know you're carrying forward existing patterns, but since that
all pre-dated designated init perhaps we could just (untested):
=09
	#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
		.type =3D OPTION_SUBCOMMAND, \
		.long_name =3D (l), \
		.value =3D (v), \
		.ll_callback =3D (fn), \
	}
	#define OPT_SUBCOMMAND(l, v, fn) OPT_SUBCOMMAND_F((l), (v), (fn), 0)

Which IMO is much nicer. I have some patches somewhere to convert these
to saner patterns (I think not designated init, but the X() can be
defined in terms of X_F() like that, but since this is new we can use
designated init all the way...

> +{
> +	int i;

Nit: missing \n (usual style of variable decl);

> +		error("'cmd' is mandatory");
> +		usage_with_options(usage, test_flag_options);

nit: I think you want usage_msg_optf() or usage_msg_opt().

> +test_expect_success 'subcommand - no subcommand shows error and usage' '
> +	test_expect_code 129 test-tool parse-subcommand cmd 2>err &&
> +	grep "^error: need a subcommand" err &&
> +	grep ^usage: err
> +'
> +
> +test_expect_success 'subcommand - subcommand after -- shows error and us=
age' '
> +	test_expect_code 129 test-tool parse-subcommand cmd -- subcmd-one 2>err=
 &&
> +	grep "^error: need a subcommand" err &&
> +	grep ^usage: err
> +'
> +
> +test_expect_success 'subcommand - subcommand after --end-of-options show=
s error and usage' '
> +	test_expect_code 129 test-tool parse-subcommand cmd --end-of-options su=
bcmd-one 2>err &&
> +	grep "^error: need a subcommand" err &&
> +	grep ^usage: err
> +'
> +
> +test_expect_success 'subcommand - unknown subcommand shows error and usa=
ge' '
> +	test_expect_code 129 test-tool parse-subcommand cmd nope 2>err &&
> +	grep "^error: unknown subcommand: nope" err &&
> +	grep ^usage: err
> +'
> +
> +test_expect_success 'subcommand - subcommands cannot be abbreviated' '
> +	test_expect_code 129 test-tool parse-subcommand cmd subcmd-o 2>err &&
> +	grep "^error: unknown subcommand: subcmd-o$" err &&
> +	grep ^usage: err
> +'
> +
> +test_expect_success 'subcommand - no negated subcommands' '
> +	test_expect_code 129 test-tool parse-subcommand cmd no-subcmd-one 2>err=
 &&
> +	grep "^error: unknown subcommand: no-subcmd-one" err &&
> +	grep ^usage: err
> +'

Creating a trivial helper for this seems worthile, then something like:

	that_helper "expected error here" -- arg u ments to test-tool parse-subcom=
mand



> +test_expect_success 'subcommand - simple' '
> +	test-tool parse-subcommand cmd subcmd-two >actual &&
> +	cat >expect <<-\EOF &&
> +	opt: 0
> +	fn: subcmd_two
> +	arg 00: subcmd-two
> +	EOF
> +	test_cmp expect actual
> +'

Ditto, perhaps? I.e.

	new_hepler arg u ments <<-\EOF
        expected
        goes here
       	EOF

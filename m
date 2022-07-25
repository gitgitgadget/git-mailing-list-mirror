Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F78EC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiGYTwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 15:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiGYTwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 15:52:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57E963B0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 12:52:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mf4so22546948ejc.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0aJnlhvwCocbPEXDT2YmPJ4VoIMQSwkGF3otOeWPUWM=;
        b=m7n30g7LHLYgRiFyJqkGvtkV+z7vtLqzNOvwzYueaqgt49kfFsx7kYCuLpm+htBZV1
         ObC8v9awFE2BkGEzd9IADseiR5fA2fclPcgQRvRH8iUZOx+VsFbJ/JRBcthzX1aVrXDe
         WKkzUb0t2/h6VWGSZXAmF4rlUPzExMn1GeMC9nXwzhyhN/+JkUCUZny7oyeP04DM9ipL
         pmiOJXv1L06fd9vkAZdTzVMYkTusa7Bt4hsGTk6nDvWOcONClfjICfPA5xKEIJY+hvGs
         VXdtDPxaTdXTYs+ACcVTUedngRzxGYOFPa+Q7VcWlX/4kqZ45prvmMBXMxr0u5ai5lXo
         D4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0aJnlhvwCocbPEXDT2YmPJ4VoIMQSwkGF3otOeWPUWM=;
        b=MN7vkc21urBcIy/R0x9qcjzGfPxtkHyrXdBRN0/GiLMBxNSu9YRywoFQ/fb5T5DW2Z
         GvOQ2B7UJpMneY5JYeYLNV9trS/c0mBl/fog+aqCzW+KDgQfpLGYQTqO/VWW+Rxp7mQn
         KierlC3IyhUOJB7HgcAZGnNSlTkrXMGPljQr1xeSj6edi7lTIB3yv/ebNNkooVtl59Bg
         zLaUf3/nzI3/gBrU9P/qbA/qu77E/vPp9nc7MiArxuwi9/msKQUfgMRlLF4uYC8rYPNG
         CaxatnVrAfHSGnCqCygV40wAYR529b++5LpL4v1zNik9YnWHE4qTHSZcXvuv3xnnCbkg
         t6Bg==
X-Gm-Message-State: AJIora//mjWaaqxEdnBSKF9cYfDcg9wwL0Mg0oz0Kf7rekl36TWrHqdX
        eUQ2zv1UdvPStgpW7t32yHpGcQ6IjCM=
X-Google-Smtp-Source: AGRyM1s3Z4cn0wTrRZ879QIKVYZzUJCdjC6TM6HzyGEKF+8PYpV9YkmAE6+K+cDYWhCAbTPJ6FqFzQ==
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id 29-20020a170906029d00b006f018d87be0mr10714071ejf.561.1658778732734;
        Mon, 25 Jul 2022 12:52:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jw7-20020a170906e94700b00715705dd23asm5669662ejb.89.2022.07.25.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:52:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oG47f-005szI-3N;
        Mon, 25 Jul 2022 21:52:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/20] parse-options: add support for parsing subcommands
Date:   Mon, 25 Jul 2022 21:41:52 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-10-szeder.dev@gmail.com>
 <220725.86a68xp7az.gmgdl@evledraar.gmail.com>
 <20220725192947.GB2543@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725192947.GB2543@szeder.dev>
Message-ID: <220725.86wnc1nf6c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, SZEDER G=C3=A1bor wrote:

> On Mon, Jul 25, 2022 at 04:43:30PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > diff --git a/builtin/blame.c b/builtin/blame.c
>> > index 02e39420b6..a9fe8cf7a6 100644
>> > --- a/builtin/blame.c
>> > +++ b/builtin/blame.c
>> > @@ -920,6 +920,7 @@ int cmd_blame(int argc, const char **argv, const c=
har *prefix)
>> >  			break;
>> >  		case PARSE_OPT_HELP:
>> >  		case PARSE_OPT_ERROR:
>> > +		case PARSE_OPT_SUBCOMMAND:
>> >  			exit(129);
>> >  		case PARSE_OPT_COMPLETE:
>> >  			exit(0);
>> > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
>> > index 086dfee45a..7a1e1fe7c0 100644
>> > --- a/builtin/shortlog.c
>> > +++ b/builtin/shortlog.c
>> > @@ -381,6 +381,7 @@ int cmd_shortlog(int argc, const char **argv, cons=
t char *prefix)
>> >  			break;
>> >  		case PARSE_OPT_HELP:
>> >  		case PARSE_OPT_ERROR:
>> > +		case PARSE_OPT_SUBCOMMAND:
>> >  			exit(129);
>> >  		case PARSE_OPT_COMPLETE:
>> >  			exit(0);
>>=20
>> This feels a bit like carrying forward an API wart, i.e. shouldn't we
>> instead BUG() if we are returning a PARSE_OPT_SUBCOMMAND from
>> parse_options_step() for options lists that don't have
>> PARSE_OPT_SUBCOMMAND in them?
>>=20
>> I.e. is this even reachable, or just something to suppress the compiler
>> complaining about missing enum labels?
>
> I think it's as good as unreachable, because neither of these two
> commands have subcommands.  However, without these hunks the compiler
> invoked with '-Wswitch' (implied by '-Wall') does indeed complain.

Yeah, we should add a case, but let's just do:

	case PARSE_OPT_SUBCOMMAND:
		BUG("unreachable");

>> ...but why not...
>>=20
>> >  static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
>> >  				  int argc, const char **argv, const char *prefix,
>> >  				  const struct option *options,
>> > @@ -515,6 +547,19 @@ static void parse_options_start_1(struct parse_op=
t_ctx_t *ctx,
>> >  	ctx->prefix =3D prefix;
>> >  	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>> >  	ctx->flags =3D flags;
>> > +	ctx->has_subcommands =3D has_subcommands(options);
>> > +	if (!ctx->has_subcommands && (flags & PARSE_OPT_SUBCOMMAND_OPTIONAL))
>> > +		BUG("Using PARSE_OPT_SUBCOMMAND_OPTIONAL without subcommands");
>> > +	if (ctx->has_subcommands) {
>> > +		if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
>> > +			BUG("subcommands are incompatible with PARSE_OPT_STOP_AT_NON_OPTIO=
N");
>> > +		if (!(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
>> > +			if (flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
>> > +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN unl=
ess in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
>> > +			if (flags & PARSE_OPT_KEEP_DASHDASH)
>> > +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_DASHDASH un=
less in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
>> > +		}
>> > +	}
>>=20
>> ...move this into parse_options_check()? I.e. we'd need to loop over the
>> list once, but it seems like this should belong there.
>>=20
>> We have an existing bug in-tree due to usage_with_options() not doing a
>> parse_options_check() (I have a local fix...), checking this sort of
>> thing there instead of in parse_options_start() is therefore the right
>> thing to do, i.e. we shoudl have a one-stop "does this options variable
>> look sane?".
>
> The checks added in this hunk (and the existing checks in the hunk's
> after-context) are not about the elements of the 'struct option'
> array, like the checks in parse_options_check(), but rather about the
> sensibility of parse_options()'s 'parse_opt_flags' parameter.
> usage_with_options() doesn't have (and doesn't at all need) such a
> parameter.

Ah, sorry, I was just confused. FWIW it's because I split out *that*
part into another helper a while ago:
https://github.com/avar/git/commit/55dda82a409

Which might be worthhile doing/stealing heere while we're at it,
i.e. the flags checking has become quite ab ig part of
parse_options_start_1(), or just leave it for later...

>> > +				error(_("unknown subcommand: %s"), arg);
>>=20
>> s/%s/'%s'/ while we're at it, perhaps?
>
> Indeed, though it should be `%s', because that's what surrounds
> unknown switches and options in the corresponding error messages.
>
>> > +				usage_with_options(usagestr, options);
>> > +			case PARSE_OPT_COMPLETE:
>> > +			case PARSE_OPT_HELP:
>> > +			case PARSE_OPT_ERROR:
>> > +			case PARSE_OPT_DONE:
>> > +			case PARSE_OPT_NON_OPTION:
>> > +				BUG("parse_subcommand() cannot return these");
>>=20
>> nit: BUG("got bad %d", v) or whatever, i.e. say what we got?
>
> All these are impossible, so I don't think it matters.  This is
> another case of the compiler with '-Wswitch' complaining, and follows
> suit of similar switch statements after the calls to parse_short_opt()
> and parse_long_opt() functions.

*nod*, and this one's a BUG(), which is good...

>> > @@ -206,6 +217,11 @@ struct option {
>> >  #define OPT_ALIAS(s, l, source_long_name) \
>> >  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
>> >=20=20
>> > +#define OPT_SUBCOMMAND(l, v, fn)      { OPTION_SUBCOMMAND, 0, (l), (v=
), NULL, \
>> > +					NULL, 0, NULL, 0, NULL, 0, (fn) }
>> > +#define OPT_SUBCOMMAND_F(l, v, fn, f) { OPTION_SUBCOMMAND, 0, (l), (v=
), NULL, \
>> > +					NULL, (f), NULL, 0, NULL, 0, (fn) }
>>=20
>> Nit, I know you're carrying forward existing patterns, but since that
>> all pre-dated designated init perhaps we could just (untested):
>>=20=09
>> 	#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
>> 		.type =3D OPTION_SUBCOMMAND, \
>> 		.long_name =3D (l), \
>> 		.value =3D (v), \
>> 		.ll_callback =3D (fn), \
>> 	}
>> 	#define OPT_SUBCOMMAND(l, v, fn) OPT_SUBCOMMAND_F((l), (v), (fn), 0)
>>=20
>> Which IMO is much nicer. I have some patches somewhere to convert these
>> to saner patterns (I think not designated init, but the X() can be
>> defined in terms of X_F() like that, but since this is new we can use
>> designated init all the way...
>
> Oh, I love this idea!  But are we there yet?  I remember the weather
> balloon about designated initializers, but I'm not sure whether we've
> already made the decision to allow them.

Yes, we've got a thoroughly hard dependency on that part of C99 for a
while now, and it's OK to add new ones (especially in cases like these,
where it makes thigs easier to read).

> If we do, then I'm inclined
> to volunteer to clean up all those OPT_* macros in 'parse-options.h'
> with designated initializers,=20

Sounds good, you might want to steal this & perhaps some things on the
same branch: https://github.com/avar/git/commit/a1a5e9c68c8

I didn't convert them to designated init, but some macros are "missing",
some are needlessy copy/pasted when X_F() could be defined in terms of
X() etc.

FWIW I thought it would eventually make sense to rename the members of
the struct itself, so we'd e.g. just have a "t" and "l" name, so we
could use that inline instead of the OPT_*() (we could use the long
names too, but that would probably be too verbose).

That would allow adding optional arguments, which e.g. would be handy
for things like "...and here's a list of what options this is
incompatible with".

>
>> > +{
>> > +	int i;
>>=20
>> Nit: missing \n (usual style of variable decl);
>
> Hm, speaking of newer C features, what about 'for (int i =3D 0; ...)'?

Junio says this November, but see:
https://lore.kernel.org/git/220725.86zggxpfed.gmgdl@evledraar.gmail.com/

>> > +		error("'cmd' is mandatory");
>> > +		usage_with_options(usage, test_flag_options);
>>=20
>> nit: I think you want usage_msg_optf() or usage_msg_opt().
>
> Maybe... but I don't know what they do ;)  Though I remember removing
> a couple of similar error() and usage_with_options() pairs from the
> builtin commands.

It's just helpers for "usage_with_options, except with a message, e.g.:

	$ ./git cat-file a b c
	fatal: only two arguments allowed in <type> <object> mode, not 3

	usage: git cat-file <type> <object>


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467D8C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 19:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiGYT3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiGYT3w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 15:29:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078391FCC6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 12:29:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c72so12391849edf.8
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 12:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BuUWBaLfgVPuMWnZT3URDAjI9Ge5smZXpDce8EF8TE0=;
        b=Htb09OqUcqJAwU2IyKNFZwdx0NhQ3t1gs92HC7AmHUYmUHeDzkMScOVDNdIr8BNei0
         oVsiyoyiV/PDnj7OHPXR3DemElw2dMpKzr5RNqLhiulN68ptMf3bZnvbgpgmX6X1uIF2
         CWqoM/uoArYtTe+jCVCcYIWtHQcniFRzc0NIWJSmu5KWaW5AS90J6jAV9xkwPbbH3ES1
         QT9ZAHErbVffV7o9u3hTxsYSDL179VQnnWXBFoXW9W7JQE0+YzzsYIHiCUg90Ni/W5L5
         9tIxBlPsiNpfRp2M2TdfVo5xeJsk3CWz8OsI9z6ZYMR5ecgtQrgd3961JcXuMJ8MN/eG
         DwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BuUWBaLfgVPuMWnZT3URDAjI9Ge5smZXpDce8EF8TE0=;
        b=WjQkg89EnVu7F4BizFZOzd6mB20gw6TxmvICZfNU/kGF71Agdv3T+o9dNe3D0Y1Nba
         eisEaa2kc0eBFPsBDol9XQYR5JQ4FBtZOXfkBFsImLdv2xB9e7pUqpg4qsAU1L6A8+6U
         bE61ZbKkh7tOpUBa+ADoCAgHa1tdd0akMLD3Xf140B/XoHP3zA+n5hFAR/AGkLTA9+cb
         j0Ipf5wrpM51yj1rWDDpouak0f5yoVGjpHav30KspSyGsnpYPitaNmmmiDzQq1EBCTVb
         W3XEHlqonu8zZH+OMg12EV8BqjXABTalDw+kIjPKQV9sybBsRzzLEc2ljcj7xJzJTxjs
         bZTg==
X-Gm-Message-State: AJIora+Os4I+8rN6ZeAOm4b5PbxrkYMpillkpVzwp/P0Fw8e9DGrnOwW
        QyPNz54pZM0HL/uuK+G+2RbH5MWUk98=
X-Google-Smtp-Source: AGRyM1v8klnGaCw7E887Vp8DjtgYeBUSd62gXQg5bBF7xPUd1KsvifLPGzaGl+T559SwLu6odjKzzw==
X-Received: by 2002:a05:6402:4311:b0:43c:3515:bda2 with SMTP id m17-20020a056402431100b0043c3515bda2mr2761408edc.288.1658777389317;
        Mon, 25 Jul 2022 12:29:49 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b006f3ef214e13sm5635791ejg.121.2022.07.25.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:29:48 -0700 (PDT)
Date:   Mon, 25 Jul 2022 21:29:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/20] parse-options: add support for parsing subcommands
Message-ID: <20220725192947.GB2543@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-10-szeder.dev@gmail.com>
 <220725.86a68xp7az.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220725.86a68xp7az.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 04:43:30PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 02e39420b6..a9fe8cf7a6 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -920,6 +920,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
> >  			break;
> >  		case PARSE_OPT_HELP:
> >  		case PARSE_OPT_ERROR:
> > +		case PARSE_OPT_SUBCOMMAND:
> >  			exit(129);
> >  		case PARSE_OPT_COMPLETE:
> >  			exit(0);
> > diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> > index 086dfee45a..7a1e1fe7c0 100644
> > --- a/builtin/shortlog.c
> > +++ b/builtin/shortlog.c
> > @@ -381,6 +381,7 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
> >  			break;
> >  		case PARSE_OPT_HELP:
> >  		case PARSE_OPT_ERROR:
> > +		case PARSE_OPT_SUBCOMMAND:
> >  			exit(129);
> >  		case PARSE_OPT_COMPLETE:
> >  			exit(0);
> 
> This feels a bit like carrying forward an API wart, i.e. shouldn't we
> instead BUG() if we are returning a PARSE_OPT_SUBCOMMAND from
> parse_options_step() for options lists that don't have
> PARSE_OPT_SUBCOMMAND in them?
> 
> I.e. is this even reachable, or just something to suppress the compiler
> complaining about missing enum labels?

I think it's as good as unreachable, because neither of these two
commands have subcommands.  However, without these hunks the compiler
invoked with '-Wswitch' (implied by '-Wall') does indeed complain.
 
> ...but why not...
> 
> >  static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
> >  				  int argc, const char **argv, const char *prefix,
> >  				  const struct option *options,
> > @@ -515,6 +547,19 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
> >  	ctx->prefix = prefix;
> >  	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
> >  	ctx->flags = flags;
> > +	ctx->has_subcommands = has_subcommands(options);
> > +	if (!ctx->has_subcommands && (flags & PARSE_OPT_SUBCOMMAND_OPTIONAL))
> > +		BUG("Using PARSE_OPT_SUBCOMMAND_OPTIONAL without subcommands");
> > +	if (ctx->has_subcommands) {
> > +		if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
> > +			BUG("subcommands are incompatible with PARSE_OPT_STOP_AT_NON_OPTION");
> > +		if (!(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
> > +			if (flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
> > +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
> > +			if (flags & PARSE_OPT_KEEP_DASHDASH)
> > +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_DASHDASH unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
> > +		}
> > +	}
> 
> ...move this into parse_options_check()? I.e. we'd need to loop over the
> list once, but it seems like this should belong there.
> 
> We have an existing bug in-tree due to usage_with_options() not doing a
> parse_options_check() (I have a local fix...), checking this sort of
> thing there instead of in parse_options_start() is therefore the right
> thing to do, i.e. we shoudl have a one-stop "does this options variable
> look sane?".

The checks added in this hunk (and the existing checks in the hunk's
after-context) are not about the elements of the 'struct option'
array, like the checks in parse_options_check(), but rather about the
sensibility of parse_options()'s 'parse_opt_flags' parameter.
usage_with_options() doesn't have (and doesn't at all need) such a
parameter.

> > +				error(_("unknown subcommand: %s"), arg);
> 
> s/%s/'%s'/ while we're at it, perhaps?

Indeed, though it should be `%s', because that's what surrounds
unknown switches and options in the corresponding error messages.

> > +				usage_with_options(usagestr, options);
> > +			case PARSE_OPT_COMPLETE:
> > +			case PARSE_OPT_HELP:
> > +			case PARSE_OPT_ERROR:
> > +			case PARSE_OPT_DONE:
> > +			case PARSE_OPT_NON_OPTION:
> > +				BUG("parse_subcommand() cannot return these");
> 
> nit: BUG("got bad %d", v) or whatever, i.e. say what we got?

All these are impossible, so I don't think it matters.  This is
another case of the compiler with '-Wswitch' complaining, and follows
suit of similar switch statements after the calls to parse_short_opt()
and parse_long_opt() functions.

> > @@ -206,6 +217,11 @@ struct option {
> >  #define OPT_ALIAS(s, l, source_long_name) \
> >  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
> >  
> > +#define OPT_SUBCOMMAND(l, v, fn)      { OPTION_SUBCOMMAND, 0, (l), (v), NULL, \
> > +					NULL, 0, NULL, 0, NULL, 0, (fn) }
> > +#define OPT_SUBCOMMAND_F(l, v, fn, f) { OPTION_SUBCOMMAND, 0, (l), (v), NULL, \
> > +					NULL, (f), NULL, 0, NULL, 0, (fn) }
> 
> Nit, I know you're carrying forward existing patterns, but since that
> all pre-dated designated init perhaps we could just (untested):
> 	
> 	#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
> 		.type = OPTION_SUBCOMMAND, \
> 		.long_name = (l), \
> 		.value = (v), \
> 		.ll_callback = (fn), \
> 	}
> 	#define OPT_SUBCOMMAND(l, v, fn) OPT_SUBCOMMAND_F((l), (v), (fn), 0)
> 
> Which IMO is much nicer. I have some patches somewhere to convert these
> to saner patterns (I think not designated init, but the X() can be
> defined in terms of X_F() like that, but since this is new we can use
> designated init all the way...

Oh, I love this idea!  But are we there yet?  I remember the weather
balloon about designated initializers, but I'm not sure whether we've
already made the decision to allow them.  If we do, then I'm inclined
to volunteer to clean up all those OPT_* macros in 'parse-options.h'
with designated initializers, 

> > +{
> > +	int i;
> 
> Nit: missing \n (usual style of variable decl);

Hm, speaking of newer C features, what about 'for (int i = 0; ...)'?

> > +		error("'cmd' is mandatory");
> > +		usage_with_options(usage, test_flag_options);
> 
> nit: I think you want usage_msg_optf() or usage_msg_opt().

Maybe... but I don't know what they do ;)  Though I remember removing
a couple of similar error() and usage_with_options() pairs from the
builtin commands.


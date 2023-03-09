Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD5C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCIQmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 11:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCIQmY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 11:42:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537A61A8E
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 08:31:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x11so2551983pln.12
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678379498;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyluZoMjsQIm5orksAtHVZ5CCqq0K32N16N/SOQg3FU=;
        b=NBSeXhFVvDT3Qbzg+n2ntAfZCQ81zd6QGOESaJeiQQta4QHhRxvf8CVb4OBcxU+jqe
         ih8E6ZWvgC6FANiYd2KImE8LbaqN1OQdE3jpRnu3V1+onE/xj+it+m4JDCr/g0/tPBt4
         wfGlJUiGOFRgyQeQEmU83cz9IrFJBzcowYMad0B7nQ5xIIybQVcb0ZldHTwDvbRiqpvm
         hgiqwcR1+TaT7tXS7FeZHEwT5C2fjPDlXjhtG3iYEYNm13kqUsHbm6kxQnWlcYojBuTE
         PpKFaEikAeMNVGbCa4M4HaxywZ4vSaeLAJEvhOl24v/AWzLvGUjSjHiMxi1pc38KYUVe
         2oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678379498;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyluZoMjsQIm5orksAtHVZ5CCqq0K32N16N/SOQg3FU=;
        b=O5UUS9VCiMcCchjH+qix+YpDIvgNAEXB3OXYNr7cfFcrQPLDJ5jGrQK8q74BIbuFFB
         tY5DW3Q36Zlc2Js6uAW7nezWvxM+I/hsXCTzSfqnZ5Ac60eAtCN4Iqv8CkNpAZUDh/8H
         sMEgCJaTaZv+ucE50cmzoeLI3zNGdQvMuNZ6hjbJqQ8o958TRGPuG/sg4KOzdQenBAFv
         jeCv9uzO4J6irmPeoAKyYw7vBYeQmZRumVwqVAjzk/kxP50L+v8rYR2fw1i74Zvr5RM4
         Om2RXtOpe19nk8dmXxb3LVu2D/AEh7MccQgiB2wW21VJhteo9DA3/Ud9j5d9gv2Y6O02
         4Chg==
X-Gm-Message-State: AO0yUKV0qhw5q3Ebk0kyxyoPF04Vae1h/FBzhDfeU5PGPcQDmY/NgcJ/
        SzeNvrVsl4Q2mj6Mi+p/S1zkHb/Om8Q=
X-Google-Smtp-Source: AK7set8cMO2c5w+0k6BpUZNBRkrOsBz7mfR36ISSXTh0RYBGa4NB9lcRG+VnEdsv0dz9uOoF66EGmg==
X-Received: by 2002:a17:90b:17d2:b0:231:24c1:8028 with SMTP id me18-20020a17090b17d200b0023124c18028mr22357831pjb.29.1678379498000;
        Thu, 09 Mar 2023 08:31:38 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a304600b002348d711ebbsm150900pjl.16.2023.03.09.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 08:31:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
        <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 08:31:37 -0800
In-Reply-To: <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 01:09:54 -0500")
Message-ID: <xmqq5yb9q42e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This isn't strictly necessary for the series, but it seemed like a gap.
> You can always do:
>
>   git -c diff.noprefix=false -c diff.mnemonicprefix=false ...
>
> but that's rather a mouthful.

or "git diff --src-prefix=a/ --dst-prefix=b/"

>
> Note that there isn't a command-line equivalent for mnemonicprefix,
> either. I don't think it's worth adding unless somebody really wants it.

I don't either.  We already have src-prefix and dst-prefix.

> +--default-prefix::
> +	Use the default source and destination prefixes ("a/" and "b/").
> +	This is usually the default already, but may be used to override
> +	config such as `diff.noprefix`.

OK.

> +static int diff_opt_default_prefix(const struct option *opt,
> +				   const char *optarg, int unset)
> +{
> +	struct diff_options *options = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(optarg);

OK.  It is a bit unsatisfactory that we already said this does not
take negative form or any argument in the option[] array, and still
have to do this, but that is completely outside the topic of this
series.

> +	diff_set_default_prefix(options);
> +	return 0;
> +}
> +
>  static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
>  					     const struct option *opt,
>  					     const char *arg, int unset)
> @@ -5564,6 +5575,9 @@ struct option *add_diff_options(const struct option *opts,
>  		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
>  			       N_("do not show any source or destination prefix"),
>  			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
> +		OPT_CALLBACK_F(0, "default-prefix", options, NULL,
> +			       N_("use default prefixes a/ and b/"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_default_prefix),
>  		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
>  			      N_("show context between diff hunks up to the specified number of lines"),
>  			      PARSE_OPT_NONEG),

Thanks.

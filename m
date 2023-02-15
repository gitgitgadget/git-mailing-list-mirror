Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81760C6379F
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjBOCi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjBOCiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:38:23 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087653251B
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:38:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gd1so6119047pjb.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4rbeqqVNs7FSrRm34vFPO1jSwvfOz7/FaSqO9j8AOw=;
        b=Y+h5SIkNIQ7sIsZJfNR4J6lqI8qg1tIdGANpLx/MnMem7lDY36jzTMsjey9oemIhWw
         kYihIZO+fIe5Qx+GbKVcnkRGDajRpvP/EB+/9tdAcbI0+tevstVoTVzDWZ/4c4mVGmtV
         o2G5mex3Cd4uWocPr0eTbKeBD5fBY/sRIdVEPxFd2jr8bkPw4JJ2JyC674LamNCKmG3c
         DYlvI+81H+ZFRTK0yBDeRqM+tOEjj092yiDyI3Sn9ZIXx7k+2oOaP2XrC9Xf1sH+XvbH
         Aux+BCtPKlNeHJ3u7rkTFJ1tuwc2ete18153kHhvQ9LiJN7Yxi6KaJQZL8DK9IR8V1S4
         Ukew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4rbeqqVNs7FSrRm34vFPO1jSwvfOz7/FaSqO9j8AOw=;
        b=MszQLtiqDiJd/nY5YrYnxobLmzMgLI69xWpKg8Qg6Tt2KQITV/1QK157oGyDtEOkEB
         4T7FjTHaEoASSUcfqesPNtW3S1Je1QMcCJp3+38qu3sPxAnUl0Z8NOA9wMRWCmGG+dB5
         cSqjw4Ng9B24Zg6FBG5sXZYQ+SNUgiiNabrEowceYDwI+NIKiHITjUYyU6jrHhFgDXNS
         pxDD4dLsnzbUZs5KUkl5YBDEZVbWhaMKuGy2PEJedTPHzInhdTjPqGA1XPVGTuFSfOAe
         R9b4/EWBytdpgYQw7QxiEd1dhsnNogHJqTpNYM6q7NiXQmgr7P0eLcJeL5QQLJZ7E2/g
         2myA==
X-Gm-Message-State: AO0yUKUh7YBgceTHjdsnPCZ2XuPQBM1RYKTQB1VydcPwKCbnJrU+5YH0
        onZJuR/WC+LBE3kvhWaWC1c=
X-Google-Smtp-Source: AK7set8plF2Mvw6RJTAsV+1Y2vay744VWqRVFVlTuOyasVVFu8FQ0OLhW5wUrH3ST4S0aTrYEhpmHg==
X-Received: by 2002:a17:903:1c6:b0:199:30c3:b3f0 with SMTP id e6-20020a17090301c600b0019930c3b3f0mr802184plh.11.1676428701258;
        Tue, 14 Feb 2023 18:38:21 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b0019904abc93dsm10883581plj.250.2023.02.14.18.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:38:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
Date:   Tue, 14 Feb 2023 18:38:20 -0800
In-Reply-To: <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Tue, 14 Feb 2023 21:40:18
        +0000")
Message-ID: <xmqqk00j3b6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> The diff option parsing for --minimal, --patience, --histgoram can all
> be consolidated into one function. This is a preparatory step for the
> subsequent commit which teaches diff to keep track of whether or not a
> diff algorithm has been set via the command line.

Everybody other than patience used to be just a bit-op but now
everybody is a callback?

> diff --git a/diff.c b/diff.c
> index 329eebf16a0..92a0eab942e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3437,6 +3437,22 @@ static int diff_filepair_is_phoney(struct diff_filespec *one,
>  	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
>  }
>  
> +static int set_diff_algorithm(struct diff_options *opts,
> +			      const char *alg)
> +{
> +	long value = parse_algorithm_value(alg);
> +
> +	if (value < 0)
> +		return 1;
> +
> +	/* clear out previous settings */
> +	DIFF_XDL_CLR(opts, NEED_MINIMAL);
> +	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> +	opts->xdl_opts |= value;
> +
> +	return 0;
> +}

The above is a faithful copy of diff_opt_diff_algorithm(), except
that it returns 1 (not -1) on failure, which is unexpected in this
codebase, and should be corrected if this patch gets rerolled.

>  static void builtin_diff(const char *name_a,
>  			 const char *name_b,
>  			 struct diff_filespec *one,
> @@ -5107,17 +5123,40 @@ static int diff_opt_diff_algorithm(const struct option *opt,
>  				   const char *arg, int unset)
>  {
>  	struct diff_options *options = opt->value;
> -	long value = parse_algorithm_value(arg);
>  
>  	BUG_ON_OPT_NEG(unset);
> -	if (value < 0)
> +
> +	if (set_diff_algorithm(options, arg))
>  		return error(_("option diff-algorithm accepts \"myers\", "
>  			       "\"minimal\", \"patience\" and \"histogram\""));
>  
> -	/* clear out previous settings */
> -	DIFF_XDL_CLR(options, NEED_MINIMAL);
> -	options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> -	options->xdl_opts |= value;
> +	return 0;
> +}

This version of diff_opt_diff_algorithm() behaves identically from
the version before this patch, which is excellent.

> +static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	struct diff_options *options = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	if (!strcmp(opt->long_name, "patience")) {
> +		size_t i;
> +		/*
> +		 * Both --patience and --anchored use PATIENCE_DIFF
> +		 * internally, so remove any anchors previously
> +		 * specified.
> +		 */
> +		for (i = 0; i < options->anchors_nr; i++)
> +			free(options->anchors[i]);
> +		options->anchors_nr = 0;
> +	}
> +
> +	if (set_diff_algorithm(options, opt->long_name))
> +		BUG("available diff algorithms include \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\"");
> +
>  	return 0;
>  }

Calling this instead of diff_opt_patience() would make "--patience"
parsed identically as before without this patch, which is excellent.

> @@ -5562,9 +5581,10 @@ struct option *add_diff_options(const struct option *opts,
>  			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
>  
>  		OPT_GROUP(N_("Diff algorithm options")),
> -		OPT_BIT(0, "minimal", &options->xdl_opts,
> -			N_("produce the smallest possible diff"),
> -			XDF_NEED_MINIMAL),
> +		OPT_CALLBACK_F(0, "minimal", options, NULL,
> +			       N_("produce the smallest possible diff"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +			       diff_opt_diff_algorithm_no_arg),

I offhand cannot say that these two are equivalent, even though they
ought to be (otherwise this patch would break things).  The callback
seems to do much more than just a simple "flip the NEED_MINIMAL bit
on".

> -		OPT_BITOP(0, "histogram", &options->xdl_opts,
> -			  N_("generate diff using the \"histogram diff\" algorithm"),
> -			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
> +			       diff_opt_diff_algorithm_no_arg),
> +		OPT_CALLBACK_F(0, "histogram", options, NULL,
> +			       N_("generate diff using the \"histogram diff\" algorithm"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
> +			       diff_opt_diff_algorithm_no_arg),

Likewise.

By nature, patience (and anchored) needs to do much more than
everybody else, so it almost feels that it is OK (and preferable,
even) to leave it a special case to make the distinction stand out.
Consolidating everybody else who are much simpler to share the
more complex callback does not look like a good change to me, at
least at the first glance.

Thanks.

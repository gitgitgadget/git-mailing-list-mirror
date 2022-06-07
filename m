Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D078DC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbiFGITA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbiFGIS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:18:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF92AC6D
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:18:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fu3so32114721ejc.7
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=p3Bi3RweDx2mGPT8ZRgBY0yGnr/faeTJswBCbI/GsV8=;
        b=oPQeKHeAk4Ji/o04TLYUnSq/VNliYP7IzsWvuPDXb4bdCOnIXo55Sar6XZo13gLLa2
         x3Kt6YEiGOtVuHYnuk44Tslm2wGV0sXMrS9v8Ql30a5DRKz/Z5Xeb1T1ZBaRc2AuKmMx
         bQnct+8DGj9F7U3F/D76xpxRo0ikofECb7+8ipytF2AIfC8bPwBldzrFwIw0Do/etzFt
         b3ksyf9h1t4QnhvhJgqdFlqBQELrj8sx+s7B2e3VFxGz0UEpuXG5dhWuCFpfMZcpsSE/
         UsFX5VKzdn7hl6qh1IWXpD+9Do0+1sL5QngfOoOXQn9DAKm/4BpT9VDCdbRt0n0NiE4D
         pQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=p3Bi3RweDx2mGPT8ZRgBY0yGnr/faeTJswBCbI/GsV8=;
        b=B9oyYUSdVRRUrWDBgkABREgUUg27jREaNSeHYJoWd2mqsBE60K+eCv25LTPlRLGRp6
         0+OgtHEr0SIV4bCnqn7jJvWy+4g4sIbclcmFVm0BRhti4vtWHESWVz7Pc4fzcaBw18Jc
         JK2gbqtBZNdBzJM5qNNChD/p9ZvvGsw8c3T8w3HDQa4+Wt1fwZ+JK5u1oyBwgXKxLc5z
         kfnoKTMtu+KR+WBNN9Ki2BMPG/+Y0jl/Okrm0JBkovaklwyCNY/LB50sLywbiHwfz2Tb
         djmr89dONNJheQYG6HBn86segxSFBuGOqA02DYUUFcCFrYRC977sZfNKZdtqUUbjFIAM
         fkfQ==
X-Gm-Message-State: AOAM530clWW4aVsAXmtkpHlkgN+qCneyIWBvMESPNU2wPjcQRaF6gTl7
        5pLElvm9oFFo0Jki+qcwbd2aHJRJ3XQ=
X-Google-Smtp-Source: ABdhPJzUGPd8rozPpMTU6FQx7Djc5+lMtcgjFj81gm4fxUzPSUpMHCj7e1FS+rU2Fxfh8cfVQGnsMw==
X-Received: by 2002:a17:906:9f1c:b0:711:cdda:a01f with SMTP id fy28-20020a1709069f1c00b00711cddaa01fmr9193385ejc.372.1654589934982;
        Tue, 07 Jun 2022 01:18:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7c70f000000b0042bc97322desm10238897edq.43.2022.06.07.01.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:18:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyUQN-002MFh-Du;
        Tue, 07 Jun 2022 10:18:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] builtin/show-ref.c: limit output with `--count`
Date:   Tue, 07 Jun 2022 10:07:32 +0200
References: <cover.1654552560.git.me@ttaylorr.com>
 <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
Message-ID: <220607.86r140vqc4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 06 2022, Taylor Blau wrote:

> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
> index ab4d271925..28256c04dd 100644
> --- a/Documentation/git-show-ref.txt
> +++ b/Documentation/git-show-ref.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  [verse]
>  'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
>  	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
> -	     [--heads] [--] [<pattern>...]
> +	     [--heads] [--count=<n>] [--] [<pattern>...]

In addition to what Junio noted, the SYNOPSIS is now inaccurate per your
documentation. I.e. if this option is incompatible with --verify and
--exclude-existing we should use "|" to indicate that, e.g.:

	[ [--verify] [--exclude-existing] | --count=<n> ]

> +	if (max_count) {
> +		int compatible = 0;
> +
> +		if (max_count < 0)
> +			error(_("invalid --count argument: (`%d' < 0)"),
> +			      max_count);
> +		else if (verify)
> +			error(_("--count is incompatible with %s"), "--verify");
> +		else if (exclude_arg)
> +			error(_("--count is incompatible with %s"),
> +			      "--exclude-existing");
> +		else
> +			compatible = 1;
> +
> +		if (!compatible)
> +			usage_with_options(show_ref_usage, show_ref_options);

Instead of this "int compatible" and if/else-if" just use usage_msg_optf().

That or die_for_incompatible_opt4(), at least the new _() messages
should make use of the same translations. I.e. we recently made these
parameterized.

> +	}
> +
>  	if (exclude_arg)
>  		return exclude_existing(exclude_existing_arg);
>  
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index 9252a581ab..b79e114c1e 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -196,4 +196,25 @@ test_expect_success 'show-ref --verify with dangling ref' '
>  	)
>  '
>  
> +test_expect_success 'show-ref --count limits relevant output' '
> +	git show-ref --heads --count=1 >out &&
> +	test_line_count = 1 out
> +'
> +
> +test_expect_success 'show-ref --count rejects invalid input' '
> +	test_must_fail git show-ref --count=-1 2>err &&
> +	grep "invalid ..count argument: (.-1. < 0)" err

The use of .. here seems odd...

> +'
> +
> +test_expect_success 'show-ref --count incompatible with --verify' '
> +	test_must_fail git show-ref --count=1 --verify HEAD 2>err &&
> +	grep "..count is incompatible with ..verify" err

...i.e. this looks like a way to avoid "--" at the beginning, but then
why use it in the middle of the regex?

> +test_expect_success 'show-ref --count incompatible with --exclude-existing' '
> +	echo "refs/heads/main" >in &&
> +	test_must_fail git show-ref --count=1 --exclude-existing <in 2>err &&
> +	grep "..count is incompatible with ..exclude.existing" err

Seems like you could avoid it entirely by escaping it, e.g. "[-]-" at
the beginning, or in this case I think "test_expect_code 129" would be
more than sufficient, we use that to test "had usage spewed at us"
elsewhere.

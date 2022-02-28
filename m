Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE3DC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiB1PkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiB1Pj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:39:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1C22BF1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:39:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id h15so18162755edv.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nWZPgFOO5CTOSQxPuGc3Fd/d71OroxU0iF44EVuS2yY=;
        b=AaFdR+Br6M/O9p3TnmsBD3Vv80NqOkwFplgFyHuI4osma0x+hbBfvnwmf0w24Sihaq
         w1OILizd8W2Q9/P/bEcjk0hwoc8+fwW8oBI4sdZP7IRxaWlVpcVY6SD7AWoB1HrdvhYC
         fX4iydGINcZS3dSKurhxTfekD010ULpTLXHTx1hMZkuY4B4xCVNrqWtX1x5syPRn3QkY
         5sLnCYKzKSSdE7ZefKTC+FNSegQ//C62ubHk4S3ARAw5TVgM1xxOESa9/3PGJxIQcEOe
         4F5zTNlSnqHrSznERQBM29YsryApt5o62j+h0G29+012OQva1LqQf+ibijUMcc2fOG2S
         Lf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nWZPgFOO5CTOSQxPuGc3Fd/d71OroxU0iF44EVuS2yY=;
        b=ed3N67rafLFbw4rXy1WzzZHuhvVPLa0Riwg1BsEZLi/PFmT2bVQSkRwqJgITzQnM5s
         5/DK8PsTDGz+51qi8aY3UaCvOZT+9u1a1pU2Liyy3/C6kdnjiH5uVIFIiEJZK4MXurOS
         cgr68nLG/pdhbAre+846mzrMPNTK5o2K2rkmOZzSPyP49K8C8A+/Z22nL24+ZJk04rnm
         NK/J62Z5HpGEwerb+58/dzX/l6huMiGRyiEFgeVFr662EMd8Tke+9WSEgp/FYF5ybHzn
         vmZCmoqCmitzPgRGcSRlhpbQJt1JO9nA001j2WNh6nHe3pbotdDLbJrFpW9SYHUuhTma
         S5YA==
X-Gm-Message-State: AOAM533GmutXiwex3tY1+bbK//cgPLyATKdXW9x/JxR2oHaHrfe2Fqrz
        EHt8LPoXBI5mYheekorIXh4+tVXuMGs=
X-Google-Smtp-Source: ABdhPJxV1llXFwTeW6IXxgRIX2bV8GndIQrtaWr/PyB4I39z/PVu9EbdipjDz1ANrAoyiWVWnNp2fw==
X-Received: by 2002:aa7:cd81:0:b0:410:d64e:aa31 with SMTP id x1-20020aa7cd81000000b00410d64eaa31mr20283757edv.167.1646062759103;
        Mon, 28 Feb 2022 07:39:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u23-20020a50c057000000b00410b61ed5dcsm6317195edd.87.2022.02.28.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:39:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOi7K-001R8I-0x;
        Mon, 28 Feb 2022 16:39:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/4] commit-graph: start parsing generation v2 (again)
Date:   Mon, 28 Feb 2022 16:30:39 +0100
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <pull.1163.v2.git.1646056423.gitgitgadget@gmail.com>
 <5bc6a7660d897ca6c52eabba8fb9ecfb6304dabb.1646056423.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <5bc6a7660d897ca6c52eabba8fb9ecfb6304dabb.1646056423.git.gitgitgadget@gmail.com>
Message-ID: <220228.86czj73sre.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +	GENERATION_VERSION=2
> +	if test ! -z "$3"

TIL this works somewhere :)

I thought it *might* be unportable behavior (but didn't check at
first), but it's not! We have a few such cases already.

But IMO much less puzzling would be at least:

    if ! test -z "$3"

Or in this case, more plainly:

    if test -n "$3"

> +	then
> +		GENERATION_VERSION=$3
> +	fi
> +	OPTIONS=
> +	if test $GENERATION_VERSION -gt 1
> +	then
> +		OPTIONS=" read_generation_data"
> +	fi

Or actually, since we don't use $GENERATION_VERSION further down setting
it to a default etc. here seems a bit odd. Perhaps something closer to:

    if test $# -eq 3 && test $3 -gt 1

It's also possible to be more clever as e.g.:

    test "${3:-2}" -gt 1

But that hardly seems worth it...

>  NUM_COMMITS=9
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 778fa418de2..669ddc645fa 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -30,11 +30,16 @@ graph_read_expect() {
>  	then
>  		NUM_BASE=$2
>  	fi
> +	OPTIONS=
> +	if test -z "$3"
> +	then
> +		OPTIONS=" read_generation_data"
> +	fi
>  	cat >expect <<- EOF
>  	header: 43475048 1 $(test_oid oid_version) 4 $NUM_BASE
>  	num_commits: $1
>  	chunks: oid_fanout oid_lookup commit_metadata generation_data
> -	options:
> +	options:$OPTIONS
>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output

Not a new issue, but it would be nice to have the mostly copy/pasted
code in a lib-commit-graph.sh or something, but probably too distracting
for this small series...

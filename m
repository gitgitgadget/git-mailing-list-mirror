Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833EC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D02360F13
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 16:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhISQbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhISQbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 12:31:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54222C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 09:29:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v5so50555005edc.2
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WmbwTVYwC9BBcBDnOrSDTYAxFrFXMkbpG375QFVMenM=;
        b=Y90iY5km/hE/i52j/zKc6u/E4yJfyqU1c8UFNNqAQuLPGdXqAYXHg0h4GjwS5VQmP4
         SF/PhNE1i0akrXitaM4fkGyu4fFhD6bDgZl3XYb64BMGnRtV6h9hW1LrbDM229q1cjdc
         m/+hxLE3B2Lk7oFN2u4nlMz9oWBAaxBffHroi1yQul4pk7gyPB+pF36FeGhvFzCAGsQ/
         9QrFT6yAb3h0JGVP4MLt2SrTZbljL2C9I1J27nGQG53nmihHZALHaFRmNb/+BP0ykohp
         6kDUpo4btSJgQzQvwWXXP1oqAEpGYrPZz5d5mCQnBS7FO+BqDDIN/brfrQGbX4WhOBsI
         cSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WmbwTVYwC9BBcBDnOrSDTYAxFrFXMkbpG375QFVMenM=;
        b=mqAnhTXNKmXoXHj9B3aKxlJHk4ErRk4DulT7X7kldfN4ukf6hCjNF6hZjEzHQfYOdj
         Jlj9wbkoyXLIidLNn+WXcl6E0QEWngW28PWvTFAsYkqmwDxekNEUr6AAsZHXi8qh9dpS
         OYOmPrNZDbGy9T1el7K80yfR9UwdN9aLoZRnyJAjvNhT/fU7GQLVnE4g6QguTBo5TX3C
         QnntSole3txhWIkessYntvDbtsc6W5p2a6Rgfbyst4SXSv+1/W0rFOQbDdupRcEKCBUp
         MbzD8K+t0Pr5zQfXpBU4c2uD/Gaf5+sejqlmEJpUA2r8y7eGHq5qm2BBn8xsPtlXM5JP
         cvbA==
X-Gm-Message-State: AOAM532hcyfArh2goMUX7LCMcg1l8FbpA/wkh6Iz+JcVIfvxOXqMNTJv
        1CCyasM/NnjkuRrkyYmbxwSiiNwLAARVGA==
X-Google-Smtp-Source: ABdhPJygbtJf0MBJN67oKJcZI/siWgGc7TbA80Y+/aYkPzdw0UUfrrsFBp4/Ki8VGih+8wAQtOp45A==
X-Received: by 2002:a17:906:468a:: with SMTP id a10mr23719059ejr.523.1632068979225;
        Sun, 19 Sep 2021 09:29:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l16sm5067022eje.67.2021.09.19.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 09:29:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
Date:   Sun, 19 Sep 2021 18:13:43 +0200
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
 <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
Message-ID: <87o88obkb1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> My equivalent version for these fixes is obviously more verbose but IMHO
> not that ugly (and as safe)
>
> It avoids the need to UNLEAK early by changing the program flow also for
> the early return so the cleanup could be centralized in one single
> function.
>
> Both, the cmdline and mailmap arrays (and the objects they accumulate)
> are cleaned in a "reusable" way.
>
> Note that the cleaning of the "name" in the cmdline item throws a warning
> as shown below which I intentionally didn't fix, as it would seem that
> either the use of const there or the need to strdup is wrong.  So hope
> someone that knows this code better could chime in.

It should just be a "char *", I got that wrong in my version posted in
the side-thread[1] & mentioned in the side-reply[2].

(I think I got it right in some earlier version days ago, it should be a
'char *' like anyting we malloc, but brainfart when re-doing/re-basing
those changes).

Yours here below has a bug where you free() rev_cmdline_info items, you
need to use release_revisions_cmdline_rev().

I should have said in [2], but thanks a lot to you and Andrzej for
following up on the mess in t0000-basic.sh addressed by my v7
re-roll. It'll be really nice to get some of these leaks fixed & tested
for.

I think I was rather curt in [2] after a long debugging session, just
saying I appreciate it. Hopefully we can figure out some plan for mostly
pulling in the same direction with regards to the way forward.

1. https://github.com/git/git/commit/06380cd4f56f4c542685eb7aa79e28285fe02c=
55
2. https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/

> Carlo
> ------ >8 ------
> Subject: [PATCH] builtin/log: leaks from `git show` in t0000
>
> obviously not ready, since the following will need to be corrected:
>
>   revision.c:1496:8: warning: passing 'const char *' to parameter of type=
 'void *' discards qualifiers [-Wincompatible-pointer-types-discards-qualif=
iers]
>                   free(info->rev[i].name);
>                        ^~~~~~~~~~~~~~~~~
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  builtin/log.c |  8 ++++++--
>  revision.c    | 20 ++++++++++++++++++++
>  revision.h    |  5 +++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index f75d87e8d7..1b1c1f53f4 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -645,8 +645,10 @@ int cmd_show(int argc, const char **argv, const char=
 *prefix)
>  	opt.tweak =3D show_setup_revisions_tweak;
>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
>=20=20
> -	if (!rev.no_walk)
> -		return cmd_log_walk(&rev);
> +	if (!rev.no_walk) {
> +		ret =3D cmd_log_walk(&rev);
> +		goto done;
> +	}
>=20=20
>  	count =3D rev.pending.nr;
>  	objects =3D rev.pending.objects;
> @@ -702,6 +704,8 @@ int cmd_show(int argc, const char **argv, const char =
*prefix)
>  		}
>  	}
>  	free(objects);
> +done:
> +	repo_clear_revisions(&rev);
>  	return ret;
>  }
>=20=20
> diff --git a/revision.c b/revision.c
> index 0dabb5a0bc..ce62192dd8 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1487,6 +1487,18 @@ static void add_rev_cmdline(struct rev_info *revs,
>  	info->nr++;
>  }
>=20=20
> +static void clear_rev_cmdline(struct rev_info *revs)
> +{
> +	struct rev_cmdline_info *info =3D &revs->cmdline;
> +	size_t i, nr =3D info->nr;
> +
> +	for (i =3D 0; i < nr; i++)
> +		free(info->rev[i].name);
> +
> +	FREE_AND_NULL(info->rev);
> +	info->nr =3D info->alloc =3D 0;
> +}
> +
>  static void add_rev_cmdline_list(struct rev_info *revs,
>  				 struct commit_list *commit_list,
>  				 int whence,
> @@ -1845,6 +1857,14 @@ void repo_init_revisions(struct repository *r,
>  	init_display_notes(&revs->notes_opt);
>  }
>=20=20
> +void repo_clear_revisions(struct rev_info *revs)
> +{
> +	if (revs->mailmap)
> +		clear_mailmap(revs->mailmap);
> +	FREE_AND_NULL(revs->mailmap);
> +	clear_rev_cmdline(revs);
> +}
> +
>  static void add_pending_commit_list(struct rev_info *revs,
>  				    struct commit_list *commit_list,
>  				    unsigned int flags)
> diff --git a/revision.h b/revision.h
> index 0c65a760ee..f695c41cee 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -358,6 +358,11 @@ void repo_init_revisions(struct repository *r,
>  			 struct rev_info *revs,
>  			 const char *prefix);
>=20=20
> +/*
> + * Free all structures dynamically allocated for the provided rev_info
> + */
> +void repo_clear_revisions(struct rev_info *revs);
> +
>  /**
>   * Parse revision information, filling in the `rev_info` structure, and
>   * removing the used arguments from the argument list. Returns the number


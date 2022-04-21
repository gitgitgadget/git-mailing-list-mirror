Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D75AC4167B
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 15:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390370AbiDUP7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390363AbiDUP71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:59:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422934705B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:56:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l7so10999484ejn.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EgOFK9tREzqbDQne96+1CVAdNLsVEbGLGRiuXsiUq84=;
        b=K2HKa++AuUgMywF699hTkvfQbKE/NqF9P5KsQ/uBQv5TI4ETqgqE0Bn/nYhSWFJpJM
         Npe0fvMmP9XVeSFdOJujKZ5h+E/yFDPAqdaR45vWL+e/EP4VQMwhzd3nj0LvKuWwBhZP
         p+vkBkLuIM1fK5WQuLPNUpQov0/pghSsZ5q0GM2fd9swLcbfJQpb2NPRwg9lnn2u8kED
         n1aQSZ42/4cAINH+qUQ2OWuQ3KB/YBx1eCRnIvopOhZr6SkfSq74NIWqIeUFT3hFZh+t
         fnlp2GbmHI1jj2g7/H+7xYJ7RyWR24iYA6nmG4kUWQEVjbmkcZsPULqDBvfGMdIE5oZ/
         a6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EgOFK9tREzqbDQne96+1CVAdNLsVEbGLGRiuXsiUq84=;
        b=ti4xlUAGuZUT6AjxZx9LI4zd/CIBogsmfxdCFTyRej50xOTBaGeDZGIkInUYUtGWZT
         nwufy1QJdm/ohuWBDwH+PLR+QXAnNLz3teD4+OQngTZJ2gxAeKuTlJLN6vhhcTcJ7Voj
         4hZZF1x1gpQKMXUIRk5MvG95TN3/eYoFcQWUOD4edGpUgF6MvLtm0VBJLsB+lxrGFQc3
         9c71PISevD5F4wq7Sq2d73v4JcaVPFXwl1D6zLmO8PNwSHEvoNbRu68l+xp3W0AzmPir
         Rp/2IvvdMGwsl43UFSsRdbC5Q7j8T+HMPlTgA6xR9rHm1uYovh+1Q6UNJoaKRfZWTBGQ
         cS4Q==
X-Gm-Message-State: AOAM531VcTyxbbEQEi+f5a6X6gVukVnCTpaI9yjzov554CyeNOQbAEY/
        kJWxEYa7JQek+UUrIIZlmPw=
X-Google-Smtp-Source: ABdhPJz98VOZQXQ9BjIqBKRlSHzJ4KMRondEGOKlgHsf1tzfUFxIBx284BAAFgeHTKgh6I5LqIB1Fw==
X-Received: by 2002:a17:907:7252:b0:6df:75cc:615e with SMTP id ds18-20020a170907725200b006df75cc615emr140856ejc.683.1650556589622;
        Thu, 21 Apr 2022 08:56:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm11663551edu.51.2022.04.21.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:56:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhZAS-0082Jz-HR;
        Thu, 21 Apr 2022 17:56:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: Re: [PATCH v2 4/5] bitmap: add trace2 outputs during open "bitmap"
 file
Date:   Thu, 21 Apr 2022 17:51:30 +0200
References: <cover.1650547400.git.dyroneteng@gmail.com>
 <2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com>
Message-ID: <220421.86k0bi77mb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 21 2022, Teng Long wrote:

Thanks for following up..

>   19:38:43.007840 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.35.1.582.g8e9092487a
>   19:38:43.007874 common-main.c:50             | d0 | main                     | start        |     |  0.000305 |           |              | /opt/git/master/bin/git rev-list --test-bitmap HEAD

It's really helpful to have these full examples in the commit
message. Thanks.

> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -312,9 +312,12 @@ char *pack_bitmap_filename(struct packed_git *p)
>  static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  			      struct multi_pack_index *midx)
>  {
> +	int fd;
>  	struct stat st;
>  	char *bitmap_name = midx_bitmap_filename(midx);
> -	int fd = git_open(bitmap_name);
> +	trace2_data_string("midx", the_repository, "try to open bitmap",
> +			   bitmap_name);
> +	fd = git_open(bitmap_name);
>  
>  	free(bitmap_name);

Hrm, so re my comment on 5/5 are you trying to use the "try to open" as
a timer to see what our start time is?

I think probably not, in which case this whole variable flip-around is
something we won't need.

But if we do actually need it perhaps a sub-region for the timing?


> @@ -511,11 +530,18 @@ static int open_midx_bitmap(struct repository *r,
>  static int open_bitmap(struct repository *r,
>  		       struct bitmap_index *bitmap_git)
>  {
> -	assert(!bitmap_git->map);
> +	int ret = -1;
>  
> -	if (!open_midx_bitmap(r, bitmap_git))
> -		return 0;
> -	return open_pack_bitmap(r, bitmap_git);
> +	assert(!bitmap_git->map);
> +	trace2_region_enter("pack-bitmap", "open_bitmap", r);
> +	if (!open_midx_bitmap(r, bitmap_git)) {
> +		ret = 0;

Nit: I think these "goto" patterns are best if your "int ret = N" picks
an "N" which is the default that you'll "goto", i.e. if you pick "ret =
0" you'll just need "goto done" here....

> +		goto done;
> +	}
> +	ret = open_pack_bitmap(r, bitmap_git);

...which we may then override here.

Just saves you the assignment and the {}, but it tends to add up in
longer functions.

> +done:
> +	trace2_region_leave("pack-bitmap", "open_bitmap", r);
> +	return ret;
>  }

Looks good, aside from the 5/5 comments that much of the data string
logging looks like it becomes redundant in the end due to error() giving
us the same thing.

>  struct bitmap_index *prepare_bitmap_git(struct repository *r)
> diff --git a/repo-settings.c b/repo-settings.c
> index b4fbd16cdc..5bc7a97a6d 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -8,6 +8,7 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
>  {
>  	if (repo_config_get_bool(r, key, dest))
>  		*dest = def;
> +	trace2_data_string("config", r, key, *dest ? "true" : "false");
>  }
>  
>  void prepare_repo_settings(struct repository *r)
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index eb63b71852..664cb88b0b 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -421,8 +421,8 @@ test_expect_success 'complains about multiple pack bitmaps' '
>  		test_line_count = 2 bitmaps &&
>  
>  		git rev-list --use-bitmap-index HEAD 2>err &&
> -		grep "a bitmap has been opened" err &&
> -		grep "ignoring extra bitmap file" err
> +		grep "warning: a normal or midx bitmap already has been opened" err &&
> +		grep "warning: ignoring extra bitmap file" err
>  	)
>  '


I haven't tested but part of this test change looks like it'll break
under bisect, i.e. you changed 1/2 of these strings in 3/5. Did you try
with "git rebase -i -x 'make test T=t*bitmap*" or similar?

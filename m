Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF82C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhL0BLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhL0BL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:11:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9419C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:11:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so29487679wra.6
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XJxF2wGvHWXYOdl3nFePGwTcJq/m8LbBUmkyKKzwfH4=;
        b=V5tYD/YL2PmLHIJIVy7r5SQewiIaaiuLhWl/qGPkPnhPsLo/oOWnYXd/Yc1MzM8NON
         /Atmhyt1n1RP1iGNKsHtmfGQ23J68JZRHoEFBSsFeGp3HJH7mFf6C5G7MeNOazsUVami
         KY0/G7FsbWdgVU+3MMo0oEccUpm5SaCuuFJWy8PJiTISADnZ1W8ZpXc0rwXMuoyxYUgG
         Jqyxo9o93TgOUdCe2+AVFseinjzw4DxqoyEBFYTV8OH1xrAgBh8x6Y5fckJyrS3bHjcv
         GNvLGU/zSQnPAGed7fglQgoW6ic0ctiYLrqlWp2+ukoXnxR3zrtEN/IqlJwbkHYthMrM
         CFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XJxF2wGvHWXYOdl3nFePGwTcJq/m8LbBUmkyKKzwfH4=;
        b=KTSjWkCmnsrv2vpYUGeBESPAM3qeaVOPY9U2xiPbHJj5f69hr3CaqWvL0f44PVyE6G
         rreln9IoNmCHwjkbM812TJubrd72V/BcJ+NJFFfjsMlcdPbPe9HiJ0TvEd2nj9Xy26Ir
         qL8MGpYag8vkpw3S3BpWuEBUPQuToOq0CRtNnzOKW8H9wHJB50eUBf5ANrdOQYStU2o8
         e6R7KmVXpi9NCRpEDzFaEkIobBjhRSbQPN20FR/c1DB1jfzD17m7GIcP6LVbVFgNmUOx
         GEVwh78d9nEjX6tgyg6EoNeE2Gm1eNr2Luclh/9AV2OLvT/ZZiuTbCz9ZrsyQua+meCr
         WaDw==
X-Gm-Message-State: AOAM530NV2xWhHSathXEgT1o0mMvXosde9pjgmYoSGAJnXuVSmAv8E5R
        bo7hwlLUKSUvLWTU1Zi3bOw=
X-Google-Smtp-Source: ABdhPJzvSa3bQz1a6+gPh5TAri51uEaC7mFsIJuo+mLscWVa4Txpf/CnaTHhyQQp/Ug2ywRwLoBSVg==
X-Received: by 2002:a5d:6c6a:: with SMTP id r10mr11106451wrz.349.1640567487339;
        Sun, 26 Dec 2021 17:11:27 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id l8sm14338031wrv.25.2021.12.26.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:11:27 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:11:25 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 5/7] progress.c: add temporary variable from progress
 struct
Message-ID: <20211227011125.bbczjt3wctfobfso@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-5.7-c2303bfd130-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v7-5.7-c2303bfd130-20211217T041945Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 05:25:00AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Add a temporary "progress" variable for the dereferenced p_progress
> pointer to a "struct progress *". Before 98a13647408 (trace2: log
> progress time and throughput, 2020-05-12) we didn't dereference
> "p_progress" in this function, now that we do it's easier to read the
> code if we work with a "progress" struct pointer like everywhere else,
> instead of a pointer to a pointer.

This message contains lots of nice details, but some of that is only really
useful after reading the diff. You mention the parameter's name but not the
function name (other combinations would make more sense).
I'd maybe write it like this, trying to follow our usual cadence of
diagnosis -> action:

	Since 98a13647408 (trace2: log progress time and throughput, 2020-05-12)
	stop_progress() dereferences a "struct progress **" parameter in several
	places. Extract a dereferenced variable (like in stop_progress_msg()) to
	reduce clutter and make it clearer who needs to write to this parameter.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  progress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index 680c6a8bf93..76a95cb7322 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -325,15 +325,16 @@ void stop_progress(struct progress **p_progress)
>  	finish_if_sparse(*p_progress);
>  
>  	if (*p_progress) {
> +		struct progress *progress = *p_progress;

Yeah, it's a good idea to reduce uses of the struct progress ** parameter.
Why not do this even earlier in this function:

	struct progress *progress;

	if (!p_progress)
		BUG("don't provide NULL to stop_progress");
	progress = *p_progress;

	finish_if_sparse(progress);

	if (progress) {
		...
	}

	stop_progress_msg(p_progress, _("done"));

this way we only need to dereference once (right next to the null check)
and it's clearer that stop_progress_msg() is the only one who wants to modify
the parameter.

>  		trace2_data_intmax("progress", the_repository, "total_objects",
>  				   (*p_progress)->total);

s/(\*p_progress)/progress/, same in the next line

>  
>  		if ((*p_progress)->throughput)
>  			trace2_data_intmax("progress", the_repository,
>  					   "total_bytes",
> -					   (*p_progress)->throughput->curr_total);
> +					   progress->throughput->curr_total);
>  
> -		trace2_region_leave("progress", (*p_progress)->title, the_repository);
> +		trace2_region_leave("progress", progress->title, the_repository);
>  	}
>  
>  	stop_progress_msg(p_progress, _("done"));
> -- 
> 2.34.1.1119.g7a3fc8778ee
> 

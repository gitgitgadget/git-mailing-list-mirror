Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82ADC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiKUX1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKUX1W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:27:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCA4D33A4
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:27:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so15649329pjc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiODtaGUFpfyXDqoX6i3T2/s2LRi8hEB3rGk795rlJQ=;
        b=nZ6OgSfk/516cXVAdKZ+AOOS5TMsHMMAyqBMVfh04YFnY++Dj08u5GZB9+HT1d72dT
         SfoXN2+2fRhT0oZNX6P+cHaFX2D+wQzJ7JV7NJ10KYw9/Z6vxMxmJlNnKkcnIzrwq6md
         ZOvE7BVksOZgAJjjroWoPxyWKNefK7rl/X+kB0H8KPUpmLhPOVh3NkdOv8a0rNzYcgAQ
         OXQl91XaWEtOyNzd610ZWdHQzdJGjyo9nMDsWsOdHhD95l2P46+knE+JFKczuOflPANV
         T3w+HKb40eIDOK2QadloeBDitq+DfgWvS29PbRyqZSr8wXV+Da3k5kEgCFxY84JKLEY3
         nJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiODtaGUFpfyXDqoX6i3T2/s2LRi8hEB3rGk795rlJQ=;
        b=Fhv1+U9Dkk3koVKdEIy8pdDQdKCvIQBbVzXpcgOsnP9Gc48iVrSuSghQdgs5PkgeLo
         Y/GbMAAYqA7rCZLEgDeYsa39w+RwaWkWvTe/9arlIpSxq+VbvWqDkNFDhUqNeJXsLEd1
         9O/yYC7YsNn4gGQR5dPuABBZnGVqZrdgRq0cVUKDgb2UV2EariBWaTHO74i8VHLTOf8+
         YpqFZ7mO8gFQ3jgB9l9BYgrmojuOvsyVKRKNZYBNvP85Hgz2AKbrHtiHRY8IF+4ND9K+
         cAO+YzMQV+GgyBZbNV4bHYjTv+KKHs4AtHcCwmu3+61Dq5jyoLt284UrhYNsSjOjiibJ
         6vbA==
X-Gm-Message-State: ANoB5pmdMKTvAve5ZjLPbY08E91OBa95l8COfTD1SPfztX3uu3pLGBnD
        vyIO7uXRTZhgcgi98mmYURr7mCjnOKhk9Q==
X-Google-Smtp-Source: AA0mqf6Xq+EClQQG6Jm7KgwtaNJwrz8tW7L3e8o1156+u4zqoA+38bmPRbzLEmBuG7Wi/zdAk45TSw==
X-Received: by 2002:a17:90a:70c5:b0:218:985d:25a0 with SMTP id a5-20020a17090a70c500b00218985d25a0mr13624106pjm.168.1669073240610;
        Mon, 21 Nov 2022 15:27:20 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f4-20020aa79684000000b00561b3ee73f6sm9467140pfk.144.2022.11.21.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:27:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v4 3/4] pack-bitmap.c: break out of the bitmap loop
 early if not tracing
References: <cover.1669032425.git.dyroneteng@gmail.com>
        <f6c5b45bdcfd05eba2984163edf38d9915255047.1669032426.git.dyroneteng@gmail.com>
Date:   Tue, 22 Nov 2022 08:27:19 +0900
In-Reply-To: <f6c5b45bdcfd05eba2984163edf38d9915255047.1669032426.git.dyroneteng@gmail.com>
        (Teng Long's message of "Mon, 21 Nov 2022 20:16:14 +0800")
Message-ID: <xmqqfsebvqg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> When we successfully open a bitmap, we will continue to try to open
> other packs, and when trace2 is enabled, we will report any subsequent
> bitmap ignored information in the log. So when we find that trace2 is
> not enabled, we can actually terminate the loop early.

The above took me a few reads to understand what it wants to say,
probably because the "and when trace2 is enabled" comes a bit too
late to explain why "try to open other" is done.  After reading it a
few times, here is what I think it wants to say:

    After opening a bitmap successfully, we try opening others only
    because we want to report that other bitmap files are ignored in
    the trace2 log.  When trace2 is not enabled, we do not have to
    do any of that.



>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index aaa2d9a104..3b6c2f804a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -527,8 +527,15 @@ static int open_pack_bitmap(struct repository *r,
>  	assert(!bitmap_git->map);
>  
>  	for (p = get_all_packs(r); p; p = p->next) {
> -		if (open_pack_bitmap_1(bitmap_git, p) == 0)
> +		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
>  			ret = 0;
> +			/*
> +			 * The only reason to keep looking is to report
> +			 * duplicates.
> +			 */
> +			if (!trace2_is_enabled())
> +				break;
> +		}
>  	}
>  
>  	return ret;

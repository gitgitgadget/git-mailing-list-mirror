Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEEC3526D
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 15:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbiAZPJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPJD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 10:09:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8382BC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:09:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r10so38370478edt.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EO8QW5EaWm/vzlXTi5RLAFzAPvabhLnqD2cOVTA9Zrw=;
        b=HTsYHEoBmFX6bi3aNbTdRPMKNDGZ7sfNdyGDml/a0JTIEzCbSAZeXOiA7+d9QDgF3J
         5esX08qVWHIUSh6PgqloGmAwxbd+WYLGnwGVuP2gRXD+3qof+bbQU9fQXnzzeUuW16Y8
         Ygax3yfb4M4q/O9XOZINMhC+TDzqkfdZwXWfHk870HNjU3IZJCnVd1L/YPgWmDmw2T28
         YpYSZjQ6HvQnhUko2l/a+Tq+ObAKg20hmZEiJHCIxb50DG1iVvY1s6Rruu40phEXT/EH
         huaHGagtdU9lMzgVYyL4XEBWxomREBIYa3R92gk4MEAAsqnOfflZJul2p9P+s8KQBhY2
         OsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EO8QW5EaWm/vzlXTi5RLAFzAPvabhLnqD2cOVTA9Zrw=;
        b=FG3CrOwmFtu3za5EU9fg/47u7ExrjNtmmwzrvYWwRrU9cuSHttAPEb6sFtitXuYK/H
         UtC0W/shZvpIwBzHUQgh1E+c4EOR2LpXNnDOGknjjtocO0l//EgiwYZQANVRsLIzO8Qx
         edYm61frtaE18kp6Y8EB7OIZj/aPtzT1lc7GNpoqERnh2R2lT/xvoJy1vbO1VLSwHRiV
         xARPOdb9bTZ8ddSpS06PbmWhjfhehYKL17eYlNvLxTe+E49Xm9KXygEi7q+RVAPfQVj2
         /ycHhgMGEybCU/J5Qjdp8Xh3qENPPjqasJVMN1AjGDcPtxic/KMmFEATQnfN8HQlRQNt
         OhVA==
X-Gm-Message-State: AOAM530FI8dGnAd7IvZ2iOduT58lqEa9+eJGAid5WYVy3Y5GaQltU2rc
        vjS9EnlBU97iIO58ugZjLU8=
X-Google-Smtp-Source: ABdhPJwbTY4CP0QfcD6puglVgemmm94k7X9Lx9RUQoIzp4ugsIKAJJXlrVFr476a5xrCSSx3bhOFEg==
X-Received: by 2002:a05:6402:298e:: with SMTP id eq14mr24869529edb.195.1643209741073;
        Wed, 26 Jan 2022 07:09:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d5sm9883075edz.78.2022.01.26.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:09:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCjut-003ALf-Up;
        Wed, 26 Jan 2022 16:08:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 9/9] pack-bitmap.c: gracefully fallback after opening
 pack/MIDX
Date:   Wed, 26 Jan 2022 16:08:07 +0100
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <581b723792c2bec1ba66025c7ebb0344d5541865.1643150456.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <581b723792c2bec1ba66025c7ebb0344d5541865.1643150456.git.me@ttaylorr.com>
Message-ID: <220126.86pmoeedpw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Taylor Blau wrote:

> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index d05ab716f6..f775fc1ce6 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -397,4 +397,32 @@ test_expect_success 'pack.preferBitmapTips' '
>  	)
>  '
>  
> +test_expect_success 'complains about multiple pack bitmaps' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&

Nit: the "rm -rf" isn't needed per the comment on 1/9...

> +	(
> +		cd repo &&
> +
> +		test_commit base &&
> +
> +		git repack -adb &&
> +		bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
> +		mv "$bitmap" "$bitmap.bak" &&
> +
> +		test_commit other &&
> +		git repack -ab &&
> +
> +		mv "$bitmap.bak" "$bitmap" &&
> +
> +		find .git/objects/pack -type f -name "*.pack" >packs &&
> +		find .git/objects/pack -type f -name "*.bitmap" >bitmaps &&
> +		test_line_count = 2 packs &&
> +		test_line_count = 2 bitmaps &&
> +
> +		git rev-list --use-bitmap-index HEAD 2>err &&
> +		grep "ignoring extra bitmap file" err
> +	)
> +'
> +
>  test_done
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index c0924074c4..3c1ecc7e25 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -266,4 +266,23 @@ test_expect_success 'hash-cache values are propagated from pack bitmaps' '
>  	)
>  '
>  
> +test_expect_success 'graceful fallback when missing reverse index' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(

...and here either, where we're adding a new test to the same file.

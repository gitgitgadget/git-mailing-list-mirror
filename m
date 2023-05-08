Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D3C7EE2D
	for <git@archiver.kernel.org>; Mon,  8 May 2023 20:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjEHUyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 16:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjEHUx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 16:53:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEDE6EB1
        for <git@vger.kernel.org>; Mon,  8 May 2023 13:53:44 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-55a76ed088aso75221297b3.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683579219; x=1686171219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3kfZ4Juryf+4AyQFbCgvOXx84I5l10ElXcCBMylLfg=;
        b=Wa+5TRQzmddX09+XrORPtY820xlBRwLZHDhlcKQcogc/uQb97moH0NaVnulPb1Yolv
         cuqzFriMsQSWHb4mZR+o3ltoRvcaWfOaiOwgR34YPFNCbjHATck6zwoUNlWYK+gBJo+2
         ZlqIWc2akj1CDNtQ9cO1pAHxnuU6o2EnQK9PGb7831vglAqi2WZnpdgC7GFuKFP4FWeM
         F3oqrXeymui8o9cggfVsfEC8K60DbrKhIK2YzOo5YE341JSFbmoQcCzMuz9zYRsUctUt
         B2pltcf8t3NL84t4JeA+BXEQYuJukr9Go70yAr2IpJ44BxjVzn5M2K6TLIt+S5OX5e/D
         AUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579219; x=1686171219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3kfZ4Juryf+4AyQFbCgvOXx84I5l10ElXcCBMylLfg=;
        b=a4OeywaJjCddCc49VCr9RNdUmznrIX9DDMH+GY3ONoDMO8NH6H1xcCsKfbJW6YA16L
         3SUe7BydBqU6OPlUqZbXnVdxefNBb6RQKiTipnvGEwOeuQb1pcZwhrn1QEVY0T+XUT8p
         ZsIc7VvfPvhn6ztCztKiv08FrggypVDVC0k+p+8nrhbcsJwFdS1RfxMbqWpnuw+QG6I3
         AhL9Lmqa6QP/guuvag97RIaiDv5VMmDj3PK5KBLAugedf1kz/jhN7TahKMKzFM39wr40
         RQGpm5f5Gytsn9AJK9imweReqzW78F0yC5tkVw4WBmwa2h0Ip65jvSmI4N/CYpcUSBHa
         0lCQ==
X-Gm-Message-State: AC+VfDxLQyV2L7ro0+u7dGuLbn2HqJUd2/PQBMz9VJ2bXN9EHDCsXySq
        p0y+k1FyeOZWco1/YtbTNQcKsJwC1V/KnRplCg==
X-Google-Smtp-Source: ACHHUZ4S4WYpsWOlJ/QYpp3Rqc3VkZ+5ree+oWwgzQ7DBS9R9/YYscWaSf58Xm85q+Hw4OJ3a9MGxQ==
X-Received: by 2002:a81:bb4f:0:b0:552:c391:7262 with SMTP id a15-20020a81bb4f000000b00552c3917262mr12171791ywl.50.1683579219008;
        Mon, 08 May 2023 13:53:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e98b:9e8:a1f6:592b? ([2600:1700:e72:80a0:e98b:9e8:a1f6:592b])
        by smtp.gmail.com with ESMTPSA id y1-20020a81a101000000b0055a07585a91sm2791199ywg.11.2023.05.08.13.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:53:38 -0700 (PDT)
Message-ID: <673a2b60-0556-fc2b-edf7-f2a19ef5dcbe@github.com>
Date:   Mon, 8 May 2023 16:53:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 3/3] pack-bitmap.c: use commit boundary during bitmap
 traversal
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <cover.1683567065.git.me@ttaylorr.com>
 <8a8f41e0c410f9160b8ff922333c13ed68f7334b.1683567065.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <8a8f41e0c410f9160b8ff922333c13ed68f7334b.1683567065.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2023 1:38 PM, Taylor Blau wrote:

> -	/*
> -	 * if we have a HAVES list, but none of those haves is contained
> -	 * in the packfile that has a bitmap, we don't have anything to
> -	 * optimize here
> -	 */
> -	if (haves && !in_bitmapped_pack(bitmap_git, haves))
> -		goto cleanup;
> +	use_boundary_traversal = git_env_bool(GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL, -1);
> +	if (use_boundary_traversal < 0) {
> +		prepare_repo_settings(revs->repo);
> +		use_boundary_traversal = revs->repo->settings.pack_use_bitmap_boundary_traversal;
> +	}
> +
> +	if (!use_boundary_traversal) {
> +		/*
> +		 * if we have a HAVES list, but none of those haves is contained
> +		 * in the packfile that has a bitmap, we don't have anything to
> +		 * optimize here
> +		 */
> +		if (haves && !in_bitmapped_pack(bitmap_git, haves))
> +			goto cleanup;
> +	}

I was reading along, nodding my head, until I came across this comment.
I recognize that it's moved from an existing place, but this seems very
strange and incorrect.

Is this implying that if the 'haves' are not in the bitmapped pack, then
we _can't_ construct a bitmap representing the objects they can reach?

Do we not have the ability to extend the object order beyond the bitmapped
pack in-memory in a way that allows us to provide bit positions for the
objects not in the bitmapped pack?

I can understand saying "it might be more expensive to construct a bitmap
here, because we need to walk into the bitmapped pack before we have a
hope of hitting a bitmap." However, that's far from "we don't have anything
to optimize".

This comment is from fff42755efc (pack-bitmap: add support for bitmap
indexes, 2013-12-21), and perhaps at that time we didn't have the ability
to construct a reachability bitmap across the non-bitmapped pack.

Something to think about removing in the future, but not a blocker for
this series. Getting it out of the way for the boundary-based walk makes
even more sense because the commits to check are those in the boundary,
not the haves themselves.
 
> +test_expect_success 'boundary-based traversal is used when requested' '
> +	git repack -a -d --write-bitmap-index &&
> +
> +	for argv in \
> +		"git -c pack.useBitmapBoundaryTraversal=true" \
> +		"git -c feature.experimental=true" \
> +		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 git"
> +	do
> +		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
> +			--use-bitmap-index second..other 2>perf" &&
> +		grep "\"region_enter\".*\"label\":\"haves/boundary\"" perf ||
> +			return 1
> +	done &&
> +
> +	for argv in \
> +		"git -c pack.useBitmapBoundaryTraversal=false" \
> +		"git -c feature.experimental=true -c pack.useBitmapBoundaryTraversal=false" \
> +		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c pack.useBitmapBoundaryTraversal=true" \
> +		"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=0 git -c feature.experimental=true"

This ordering (GIT_TEST_*=0 overrides config) seems backwards to me, but
it doesn't really matter since it's a GIT_TEST_* variable. Thanks for
including tests so the order is documented.

> +	do
> +		eval "GIT_TRACE2_EVENT=1 $argv rev-list --objects \
> +			--use-bitmap-index second..other 2>perf" &&
> +		grep "\"region_enter\".*\"label\":\"haves/classic\"" perf ||
> +			return 1

nit: you should be able to use 'test_region' here. Probably not worth
a re-roll, as everything else looks good to me.

Thanks,
-Stolee

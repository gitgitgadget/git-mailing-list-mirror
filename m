Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27D2C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDED20848
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 00:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MdFL19vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBOAp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:45:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43171 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBOAp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 19:45:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id u12so5404538pgb.10
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzfgZOHmX38i8koemjmkZNM+tH+o1Y8RRTdpVbJEHaQ=;
        b=MdFL19vsIuf/zo3z0mXZPgf85IUfkO269zyPBPj5tmRK/H1L3YwBYlWuRrb26fX9qB
         4r584EjjuoHk3amKhvq2g+kpS1Se4PyGEfc/UAVHRcgvyTcTwXDQVdkdUXmOUPtMRtNf
         crpa4gjyI1xt1wM/HGv0ouo8O3Hxwc3tkaiFHNs3++dGrbYfTnQpg++0smA6CZiWsVl9
         DYaBxXvGpd7SSFI8vZ92TOG89s0wRghNAnPKPjAPovNwUwRpImZoadyrdLhfnHD23kE/
         CgLXNH5O+MRlGC9nYiV6vCwPPFIR0kMV1UHiJA7NEqx1BqxviZimcq+KmmdaJEISL9oQ
         tpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzfgZOHmX38i8koemjmkZNM+tH+o1Y8RRTdpVbJEHaQ=;
        b=dusQibTn2tIgeIWK++9viCXwSpdsa5yckcB4rxAZbtZHySh59yYqvq4sjfKOc6ZCMq
         +lVL8LXdhGK8Hgm43ISuAAEuQtPc1PVYfnmhuOr66eK+0pxllZftnU3k/noDmPA5PTc5
         EJip3kF6mWsPdWp5ghVS65qfj/xe2q+ZqVwVGZvDuP0Q4toJ8KqtWQ97rK4JDwe9evle
         jHwzqkurJ8JQ53DxAEVmrYj9UVchiKm6Y+Wxdhl3pcvpf+1qqyeErEd20FmmKdZA4w+R
         I6EF3QTO7BpBennNCbdezlQMgR/0hHkpXoPSPp7idg8EUduP4ayKrqutiGvD1LzG2ZFf
         mKbg==
X-Gm-Message-State: APjAAAVF5B5mZJsapeOAVqE4lygpyKXMZBVUjempM3t4UJ5vrWu2poDS
        MAl2hmXTvlLOBAWmtrVjV0E/csoUU/anJQ==
X-Google-Smtp-Source: APXvYqwGZIEMtJYg2G7HzrcmLBTY5RyixVP5oQmOiBSXqvxvLSZM8RsBQr8pFVzPsHR6nsgOFYmuEQ==
X-Received: by 2002:a63:cd03:: with SMTP id i3mr6386959pgg.257.1581727556990;
        Fri, 14 Feb 2020 16:45:56 -0800 (PST)
Received: from localhost ([2600:100f:b02c:92d4:11e2:3a54:273f:b5fe])
        by smtp.gmail.com with ESMTPSA id v8sm8002235pff.151.2020.02.14.16.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 16:45:56 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:45:55 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/15] rev-list: allow bitmaps when counting objects
Message-ID: <20200215004555.GB15192@syl.local>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182222.GG150965@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182222.GG150965@coredump.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 01:22:22PM -0500, Jeff King wrote:
> The prior commit taught "--count --objects" to work without bitmaps. We
> should be able to get the same answer much more quickly with bitmaps.
>
> Note that we punt on the max_count case here. This perhaps _could_ be
> made to work if we find all of the boundary commits and treat them as
> UNINTERESTING, subtracting them (and their reachable objects) from the
> set we return. That implies an actual commit traversal, but we'd still
> be faster due to avoiding opening up any trees. Given the complexity and
> the fact that anyone is unlikely to want this, it makes sense to just
> fall back to the non-bitmap case for now.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/rev-list.c      | 21 ++++++++++++++++++---
>  t/t5310-pack-bitmaps.sh |  6 ++++++
>  2 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 9452123988..70f3207ecc 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -374,7 +374,10 @@ static inline int parse_missing_action_value(const char *value)
>
>  static int try_bitmap_count(struct rev_info *revs)
>  {
> -	uint32_t commit_count;
> +	uint32_t commit_count = 0,
> +		 tag_count = 0,
> +		 tree_count = 0,
> +		 blob_count = 0;

Hmm, I don't usually see the comma-separated declaration/initialization
in git.git. Is there a reason you did it here? Not that I really mind
one way or the other, just interested.

>  	int max_count;
>  	struct bitmap_index *bitmap_git;
>
> @@ -389,6 +392,15 @@ static int try_bitmap_count(struct rev_info *revs)
>  	if (revs->left_right || revs->cherry_mark)
>  		return -1;
>
> +	/*
> +	 * If we're counting reachable objects, we can't handle a max count of
> +	 * commits to traverse, since we don't know which objects go with which
> +	 * commit.
> +	 */
> +	if (revs->max_count >= 0 &&
> +	    (revs->tag_objects || revs->tree_objects || revs->blob_objects))

An aside unrelated to the patch at hand: the expression

  (revs->tag_objects || revs->tree_objects || revs->blob_objects)

does occur in an awful lot of places throughout this file. Do you
imagine it'd be useful to pull this check out into its own function,
perhaps as a preparatory patch in a later version of this series?

I'm also not fussed if you don't think that such a change would be
useful, it's just an observation I had after seeing this expression a
few times.

> +		return -1;
> +
>  	/*
>  	 * This must be saved before doing any walking, since the revision
>  	 * machinery will count it down to zero while traversing.
> @@ -399,11 +411,14 @@ static int try_bitmap_count(struct rev_info *revs)
>  	if (!bitmap_git)
>  		return -1;
>
> -	count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
> +	count_bitmap_commit_list(bitmap_git, &commit_count,
> +				 revs->tree_objects ? &tree_count : NULL,
> +				 revs->blob_objects ? &blob_count : NULL,
> +				 revs->tag_objects ? &tag_count : NULL);
>  	if (max_count >= 0 && max_count < commit_count)
>  		commit_count = max_count;
>
> -	printf("%d\n", commit_count);
> +	printf("%d\n", commit_count + tree_count + blob_count + tag_count);
>  	free_bitmap_index(bitmap_git);
>  	return 0;
>  }
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 6640329ebf..7ba7d294a5 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -74,6 +74,12 @@ rev_list_tests() {
>  		test_cmp expect actual
>  	'
>
> +	test_expect_success "counting objects via bitmap ($state)" '
> +		git rev-list --count --objects HEAD >expect &&
> +		git rev-list --use-bitmap-index --count --objects HEAD >actual &&
> +		test_cmp expect actual
> +	'
> +
>  	test_expect_success "enumerate --objects ($state)" '
>  		git rev-list --objects --use-bitmap-index HEAD >tmp &&
>  		cut -d" " -f1 <tmp >tmp2 &&
> --
> 2.25.0.796.gcc29325708

Your tests look good to me, too.

Thanks,
Taylor

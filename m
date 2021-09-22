Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02FC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FB6610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbhIVWlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhIVWlK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 18:41:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F336C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:39:40 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q8-20020aa79828000000b0043d5595dad4so2578701pfl.13
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9YAjKQ47RYk4oBp7wVuvvgSprI8fuBtDPuF2Gs5kfWA=;
        b=KvD7AYc9nPX2iOFZIuRZZsaR2ikwGBLOWbxiTQKarOz12Vo6ofew7DHQC4i1fz/hI/
         BYt3tBs419GgMyc72UOSOYit2iaEowcHY5vYyKjQlPrhV2EhdCOf6d2sAE/J8QL6+smS
         BfdXYrqUn2uOxUqsjr4BHGQ8fDMkGudGa1thHJDHzQFGKXOwVwPsFSAVK2DJYUNrve67
         fj/t0gQk449r0mLYd7TD5Wd4D8HDPVIeLcBdgubb/nRa0nSebC1sE85klJuZhHfA9LQA
         ul7VLBRww1wvZD7uP+lVLPkkdhf1NVlJ0ICEsGvD4/PfoBZghts89tV1iGLgIP5PJwVm
         EW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9YAjKQ47RYk4oBp7wVuvvgSprI8fuBtDPuF2Gs5kfWA=;
        b=DlY0+ILcvsOl59wt23TjymhUGWcmMT9umJB+EL2otAKl+zPARICXyrpys5Z04X/QdG
         COQzZmCG8gu0KobIFfIm4vrdmIq/i05A5nlsR+WVWtEYoVn0qqJ/xvInEJELyKy8b0Nl
         eNI3Pes/m/U/WTi0zQciMl5KMvbuAbBQCBJEJyq+8MOOh6KgJwYtP0sC30eFjbM9zg8F
         zZG/synhspF0F5h76cbcFOOa/d8a+GG7DCWwswja6CYUy1xWBtOsgUjoL9D47R630dXj
         G05EFIGFRc/wYYIxFKUlRQkNACqGXQ7GEgCD3ajCwAkWe17DxjvHmgAtX9xNH9HDxIyL
         +YgA==
X-Gm-Message-State: AOAM533EcycpXNAp3QJDb/91CTzrCIQS2FSl+Cnb58GvUgcR1dV3GXg+
        dH0/byyS5FdGrRY2JSDRb3BSXEHt381nZzrUsKhi
X-Google-Smtp-Source: ABdhPJxN9N6n76kQcA41yDQQgfnY018PgkilOIoCTXAL0s46OVWLqJm1nBczKjdJrQ6uRhxv7VmXzHINM3q8a6f1wK6Y
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9a0e:0:b0:44a:3ae2:825c with
 SMTP id w14-20020aa79a0e000000b0044a3ae2825cmr1089098pfj.28.1632350379882;
 Wed, 22 Sep 2021 15:39:39 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:39:35 -0700
In-Reply-To: <83dfdb8b125efe970659eeea1e5e88b09546c81e.1631730270.git.me@ttaylorr.com>
Message-Id: <20210922223936.2606010-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <83dfdb8b125efe970659eeea1e5e88b09546c81e.1631730270.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH v2 6/8] builtin/repack.c: support writing a MIDX while repacking
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -683,22 +755,41 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	}
>  	/* End of pack replacement. */
>  
> +	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
> +		const int hexsz = the_hash_algo->hexsz;
> +		string_list_sort(&names);
> +		for_each_string_list_item(item, &existing_packs) {
> +			char *sha1;
> +			size_t len = strlen(item->string);
> +			if (len < hexsz)
> +				continue;
> +			sha1 = item->string + len - hexsz;
> +			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);

OK, here is the tricky part. They are marked for deletion here...

> +		}
> +	}
> +
> +	if (write_midx) {
> +		struct string_list include = STRING_LIST_INIT_NODUP;
> +		midx_included_packs(&include, &existing_packs,
> +				    &existing_kept_packs, &names, geometry);

...the mark for deletion is taken into account during the execution of
midx_included_packs() (as can be seen by looking at that function)...

> +
> +		ret = write_midx_included_packs(&include,
> +						show_progress, write_bitmaps > 0);
> +
> +		string_list_clear(&include, 0);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>  	reprepare_packed_git(the_repository);
>  
>  	if (delete_redundant) {
>  		int opts = 0;
> -		if (pack_everything & ALL_INTO_ONE) {
> -			const int hexsz = the_hash_algo->hexsz;
> -			string_list_sort(&names);
> -			for_each_string_list_item(item, &existing_packs) {
> -				char *sha1;
> -				size_t len = strlen(item->string);
> -				if (len < hexsz)
> -					continue;
> -				sha1 = item->string + len - hexsz;
> -				if (!string_list_has_string(&names, sha1))
> -					remove_redundant_pack(packdir, item->string);
> -			}
> +		for_each_string_list_item(item, &existing_packs) {
> +			if (!item->util)
> +				continue;

...and the marks are also used here. I was at first confused about why
the functionality of midx_included_packs() depended on whether redundant
packs were marked for deletion - if they are redundant, shouldn't they
never be taken into account (regardless of whether we actually delete
them)? But I guess it makes sense as an overall design point that we
pass all packs that are to remain (so if they will be deleted, exclude
them, and if they will not be, include them).

I think a comment "mark this pack for deletion" at the point we write
the mark (so, where the cast to intptr_t is) is worthwhile. Other than
that, this patch looks good to me.

I (and the others in our review club) only managed to reach this patch.
I hope to get to the other 2 by the end of the week.

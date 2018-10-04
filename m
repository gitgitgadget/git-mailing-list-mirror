Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B721F453
	for <e@80x24.org>; Thu,  4 Oct 2018 21:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJEEde (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 00:33:34 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:38129 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEEdd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 00:33:33 -0400
Received: by mail-it1-f202.google.com with SMTP id d10so16209itk.3
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x86kjqHtYMqJ09lbozQ5IdxKY+7GS3woGcC1oHQgZZM=;
        b=ZpTV2jFOn7DE/YNSPTcnR4dHpzZcWAxLqttEHq2toj0Co//Kj3nlYUZowoH90yYN1m
         6qoiokLIIJCjZb9Ou8HKMIHOfmTdGzWhOtmwle2ihxBv0on45TCIFM4TbnVrfxtjOAtv
         YDqvMqds/tcTfvuzy0M4CfX+tw8ScQ5ewSN8kFzVjZjcgkIuiVfVO+6TyKvfzjfxAi1Y
         kYW+JcbIn4MQmPulyMdDiQn7p4ZCHdsgNOKjKdKc8KMyQ3KVT50x1+39YTju7+tGoXhY
         lREAJjeScOnkMkGAqU/UD0nS9yOpHCl+241rUZwD8E0RTB0QIT6vTeWYLvW8+/8rU9Ee
         7jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x86kjqHtYMqJ09lbozQ5IdxKY+7GS3woGcC1oHQgZZM=;
        b=TllaBe5B5mVVBMnUv0Hev9aXjxins4tlNqGvV4jRJW6HDWga1BC7YvX0DDIjgAzn6+
         HUqpJll27k56c8prj2DrDxb2JeEScAWxhrG9xhIACAinWWq7XfJegSrr0XCIvIk3SHY5
         h1cF8yGY8bkzOcDDo/PQ5Em8dEWMq8S5s3zfLPG+J4fdBS0hziJDr0aSmfx4bTkthcdx
         IY258mo7JKR4/rMHk74+T0SbzYwFlVy2gIvBSVYU3XK5IoeUt1RbOC1opH5ZHntVsSnW
         GPoDZSTXlx2/L9RUsgbRQze+Gpi3/WPU1CTj0NC+xiZpV1Kcvn9LM/zcgMrLron9J8hd
         JT4w==
X-Gm-Message-State: ABuFfoh0rLlEQRV5GvFSX3forttGj1sCbWKJlQtJ2xenr57CWmWscRfE
        zJIIBNGB2PeVRmjBbOIa0RT4qfL/wXL9B4YDSo4g
X-Google-Smtp-Source: ACcGV60jPgWL4XyKX5MTkBYNtrDYnVXaTlBuRQmzr6JFksfTWo69mj0/4YZMzKTP0YO20kJvCfrRy/8fawlNnbqsg6JC
X-Received: by 2002:a24:e48b:: with SMTP id o133-v6mr3978157ith.0.1538689097259;
 Thu, 04 Oct 2018 14:38:17 -0700 (PDT)
Date:   Thu,  4 Oct 2018 14:38:13 -0700
In-Reply-To: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
Message-Id: <20181004213813.158688-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <9f51ac28-73e9-2855-c650-7d695945e286@web.de>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     l.s.r@web.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Determine if the oidset needs to be populated upfront and then do that
> instead.  This duplicates a loop, but simplifies the existing one by
> separating concerns between the two.

[snip]

> +	if (strict) {
> +		for (i = 0; i < nr_sought; i++) {
> +			ref = sought[i];
> +			if (!is_unmatched_ref(ref))
> +				continue;
> +
> +			add_refs_to_oidset(&tip_oids, unmatched);
> +			add_refs_to_oidset(&tip_oids, newlist);
> +			break;
> +		}
> +	}
> +
>  	/* Append unmatched requests to the list */
>  	for (i = 0; i < nr_sought; i++) {
>  		ref = sought[i];
>  		if (!is_unmatched_ref(ref))
>  			continue;
>  
> -		if ((allow_unadvertised_object_request &
> -		     (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)) ||
> -		    tip_oids_contain(&tip_oids, unmatched, newlist,
> -				     &ref->old_oid)) {
> +		if (!strict || oidset_contains(&tip_oids, &ref->old_oid)) {
>  			ref->match_status = REF_MATCHED;
>  			*newtail = copy_ref(ref);
>  			newtail = &(*newtail)->next;

I don't think the concerns are truly separated - the first loop quoted
needs to know that in the second loop, tip_oids is accessed only if
there is at least one unmatched ref. Would it be better to expose the
size of the oidset and then use it in place of
"tip_oids->map.map.tablesize"? Checking for initialization (using
"tablesize") is conceptually different from checking the size, but in
this code, both initialization and the first increase in size occur upon
the first oidset_insert(), so we should still get the same result.

But if we do end up going with the approach in this patch, then this
patch is obviously correct.

I also looked at patch 1 of this patch set and it is obviously correct.
I didn't look at the other patches.

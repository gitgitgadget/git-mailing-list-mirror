Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF581F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391247AbfITPV4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:21:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36527 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390711AbfITPV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:21:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so9113408qtf.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KIw9PsWSUBsEF+IcJtewqmhc48j/g3nfE3GHcPMheMQ=;
        b=NFbUW7feoWhVipN9toNZaKETB6AjnSMQbNgWU3rUbC4E87RMQ8YFUh/oyqlaO40nrm
         xfDXVRKCm84dWYW1nEm6j0GTWxnKsga/MXZA2X8NHwJV/Qj1YQVg1hGnQVZBYjs/FFts
         yqnJD67aKPBuVW4xGjBobd4pjrGUz2aEenEqvWO3HjJ3wBHHiAL1fPY0tnhKmSqNI9kA
         zrk2oU2G8Iwhi8uwiDRkMX5xW21g1ZF1KzhIvf34wH+YTz/PmEIcEJY2M7t6fuT08IG9
         SZcNeKz89q5Stf8UUhRXQlpZl2YSpnL37dEL4qtROBms5QNFwu/Akbe7wQSomjteW5XS
         pf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KIw9PsWSUBsEF+IcJtewqmhc48j/g3nfE3GHcPMheMQ=;
        b=Tw64HwSVccVsfJcZTrjUXi4DtjOXjgeQSvB3C5vzwfnr4idk8KH0XqJLhVN3VjZjpS
         05Xws9egyRatPoVWY3+zr2mmbVm37VhyhPneDtqcvGkNoN3+XEgRu5ENY4p1+qmaJUBE
         o8e32Lla6KLPkApFQukhRmxtW84LuWz3Bda0VfunmP+BzGtkWGbGjUjWLmb+EMDkt2QK
         X8xEKj3ADQ35G7ctxbE62YxQuaxZfjLUvUxWki/2eHdk6gXJXCO7/MTTwPAd5LVo7EUG
         iZvDM5Gnp7CUCmPsSvSSZ+2Me0aMF2a6GChzgNfdnKYskCwERvxfZNno7/BfMa0h2tBi
         8How==
X-Gm-Message-State: APjAAAUBPiYIrut/gi33/mktt3zLa6bQgqv2MRg/t3ewdgYDbW1XCdDa
        LRZLz162fBBFm9XtraBl891mDc5hkSA=
X-Google-Smtp-Source: APXvYqxrPZ6gez8bGa9NSEKU7l1nGCy6zdbqKtroinug9DLv3eKdW6PeVjk/1TanH4yBq6PhineOYQ==
X-Received: by 2002:ac8:6796:: with SMTP id b22mr3614212qtp.95.1568992915023;
        Fri, 20 Sep 2019 08:21:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1010:89d8:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id b26sm1157519qkl.43.2019.09.20.08.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:21:54 -0700 (PDT)
Subject: Re: [PATCH 08/15] name-rev: pull out deref handling from the
 recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-9-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <38877cbe-084f-8da5-957a-6d545cf860b1@gmail.com>
Date:   Fri, 20 Sep 2019 11:21:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-9-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:47 PM, SZEDER Gábor wrote:
> The 'if (deref) { ... }' condition near the beginning of the recursive
> name_rev() function can only ever be true in the first invocation,
> because the 'deref' parameter is always 0 in the subsequent recursive
> invocations.
> 
> Extract this condition from the recursion into name_rev()'s caller and
> drop the function's 'deref' parameter.  This makes eliminating the
> recursion a bit easier to follow, and it will be moved back into
> name_rev() after the recursion is elminated.
> 
> Furthermore, drop the condition that die()s when both 'deref' and
> 'generation' are non-null (which should have been a BUG() to begin
> with).

These changes seem sensible. I look forward to seeing how deref is
reintroduced.

> Note that this change reintroduces the memory leak that was plugged in
> in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
> case, 2017-05-04), but a later patch in this series will plug it in
> again.

The memory leak is now for "tip_name" correct? Just tracking to make
sure it gets plugged later.

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index cb8ac2fa64..42cea5c881 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -102,30 +102,19 @@ static struct rev_name *create_or_update_name(struct commit *commit,
>  
>  static void name_rev(struct commit *commit,
>  		const char *tip_name, timestamp_t taggerdate,
> -		int generation, int distance, int from_tag,
> -		int deref)
> +		int generation, int distance, int from_tag)
>  {
>  	struct commit_list *parents;
>  	int parent_number = 1;
> -	char *to_free = NULL;
>  
>  	parse_commit(commit);
>  
>  	if (commit->date < cutoff)
>  		return;
>  
> -	if (deref) {
> -		tip_name = to_free = xstrfmt("%s^0", tip_name);
> -
> -		if (generation)
> -			die("generation: %d, but deref?", generation);
> -	}
> -
>  	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
> -				   distance, from_tag)) {
> -		free(to_free);
> +				   distance, from_tag))
>  		return;
> -	}
>  
>  	for (parents = commit->parents;
>  			parents;
> @@ -144,11 +133,11 @@ static void name_rev(struct commit *commit,
>  
>  			name_rev(parents->item, new_name, taggerdate, 0,
>  				 distance + MERGE_TRAVERSAL_WEIGHT,
> -				 from_tag, 0);
> +				 from_tag);
>  		} else {
>  			name_rev(parents->item, tip_name, taggerdate,
>  				 generation + 1, distance + 1,
> -				 from_tag, 0);
> +				 from_tag);
>  		}
>  	}
>  }
> @@ -280,12 +269,16 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  	if (o && o->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *)o;
>  		int from_tag = starts_with(path, "refs/tags/");
> +		const char *tip_name;
>  
>  		if (taggerdate == TIME_MAX)
>  			taggerdate = commit->date;
>  		path = name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
> -			 from_tag, deref);
> +		if (deref)
> +			tip_name = xstrfmt("%s^0", path);
> +		else
> +			tip_name = xstrdup(path);

(leak above, as noted in message).

> +		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
>  	}
>  	return 0;
>  }
> 

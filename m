Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93441F461
	for <e@80x24.org>; Fri,  6 Sep 2019 16:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391095AbfIFQwJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 12:52:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39960 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIFQwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 12:52:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so4880380pfb.7
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hH+AgVSWfGebkSQya94erO7ZDhPCZDT3tLXXbKQ77BU=;
        b=fxU9xw1W3Duc+1uSTSukk/tJ+NNDCoJRtR/C/SttvXxQVTCGD9LDRIlPk2RVxu/tuF
         XFb5qgHTK7PLKRaGcHR4rFZCv57OhO7sz2qXVPu43BZx5c1kFsTWBHgdNNYECPuduNJc
         9nY01igyDammMDe4g5rt6BfzcH6/4raKupb29PyXVVuYvx7hCU8AgQOKv7FQsbj/UL/p
         l1SVk7j+DD/n1bv12LT53SUJ1bVUgwXNXy+3FvBcQhUZZG1VI6ozYu11sh/63P3sJRRU
         r2yzPfU4chAub+1MYDTrdXGVezZqU/PnOGQur+iEMrI3dCeOhSxhlsC98ZRyUiuMggND
         sEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hH+AgVSWfGebkSQya94erO7ZDhPCZDT3tLXXbKQ77BU=;
        b=K80PkYM4WLnYeEM8G6H76Eji2zOZbbc7im6mTPg6ouQe2KfHQ9U+rTVvpg+rKjTFhJ
         q0x00wQ9MqVrNjJsL6T6eOZuLx1uWDK3JrICyFkAG5bkWDhHatAhOP78sv4Z8rnLG/XK
         mcMNo0T8H5OKVAuD8I+mDCvBVvM0sgWiinJOTNd1W+dhGE/ByXa56IJG0TwwJb5n2uVd
         XShXyF8KrWS5ViwlwOZzlZrxtYzKHP3amh1DUNTr9KyL6OR6V4R2xGXXSJPvUMsjX6Ck
         dnXjzPqm/Jj7c76oR5uTVPn3CLGMxAA58/xX2TRNEVechUGg5LDUqODTw4PDdBppAGQW
         fM5w==
X-Gm-Message-State: APjAAAWkVgmt1YyU/hZYC6RDvPQbFLsZSy3jgRBa80sKYfd2yQsvUqFg
        azs/2/xTC52P3mFzRLcGZEc=
X-Google-Smtp-Source: APXvYqxpf9gzfe6b4eFEByHAIUIYqcaBKzD2Ir7FkxF0liX9JswfWJoF3X5VZ05EP4HeREl9la7dMA==
X-Received: by 2002:a63:69c1:: with SMTP id e184mr8417234pgc.198.1567788727862;
        Fri, 06 Sep 2019 09:52:07 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id v7sm3278545pjr.29.2019.09.06.09.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:52:07 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <cover.1567720960.git.me@ttaylorr.com>
 <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
 <20190906061919.GA5122@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad34871d-bdc4-5b52-eff4-da03c6be1004@gmail.com>
Date:   Fri, 6 Sep 2019 12:51:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190906061919.GA5122@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2019 2:19 AM, Jeff King wrote:
> On Thu, Sep 05, 2019 at 06:04:57PM -0400, Taylor Blau wrote:
> 
>> @@ -846,7 +847,11 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>>  		if (parse_commit_no_graph(*list))
>>  			die(_("unable to parse commit %s"),
>>  				oid_to_hex(&(*list)->object.oid));
>> -		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
>> +		tree = get_commit_tree_oid(*list);
>> +		if (!tree)
>> +			die(_("unable to get tree for %s"),
>> +				oid_to_hex(&(*list)->object.oid));
>> +		hashwrite(f, tree->hash, hash_len);
> 
> Yeah, I think this is a good stop-gap to protect ourselves, until a time
> when parse_commit() and friends consistently warn us about the breakage.
> 
>> diff --git a/commit.c b/commit.c
>> index a98de16e3d..fab22cb740 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -358,7 +358,8 @@ struct tree *repo_get_commit_tree(struct repository *r,
>>  
>>  struct object_id *get_commit_tree_oid(const struct commit *commit)
>>  {
>> -	return &get_commit_tree(commit)->object.oid;
>> +	struct tree *tree = get_commit_tree(commit);
>> +	return tree ? &tree->object.oid : NULL;
>>  }
> 
> This one in theory benefits lots of other callsites, too, since it means
> we'll actually return NULL instead of nonsense like "8". But grepping
> around for calls to this function, I found literally zero of them
> actually bother checking for a NULL result. So there are probably dozens
> of similar segfaults waiting to happen in other code paths.
> Discouraging.
>
> This is sort-of attributable to my 834876630b (get_commit_tree(): return
> NULL for broken tree, 2019-04-09). Before then it was a BUG(). However,
> that state was relatively short-lived. Before 7b8a21dba1 (commit-graph:
> lazy-load trees for commits, 2018-04-06), we'd have similarly returned
> NULL (and anyway, BUG() is clearly wrong since it's a data error).
> 
> None of which argues against your patches, but it's kind of sad that the
> issue is present in so many code paths. I wonder if we could be handling
> this in a more central way, but I don't see how short of dying.

This is due to the mechanical conversion from using commit->tree->oid to
get_commit_tree_oid(commit). Those consumers were not checking if the
tree pointer was NULL, either, but they probably assumed that the
parse_commit() call would have failed earlier. Now that we are using this
method (for performance reasons to avoid creating too many 'struct tree's)
it makes sense to convert some of them to checking the return value more
carefully.

If we wanted the more invasive change of modifying every caller to check
 NULL and respond appropriately, that would be _best_, but is probably
not worth the effort.

Thanks,
-Stolee

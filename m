Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15772C33C9E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 00:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8A62467C
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 00:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZvkS0FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAOAIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:08:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40097 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgAOAIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 19:08:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so14049606qkg.7
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NehVIWYS9Z8E0exz78Jzut52ZSa/H59Ua6Dkb1UoHkI=;
        b=eZvkS0FVbnfihEAJDP2XJmKWBZT+drCKcMNXtp3tvR9aZ/ukqHZXkfYRHBsByBhtvq
         wnNzHaG69Sh+RrGCK5TreE1NPq5d4L+AjwuDZrwmJnirpMuaneU9oyUlMuH3b6czzyPA
         WVSy+2/ytkKMD3Rx4etot+H+Hn1geRewPh7JsnQ87Y2Knz9IqLZpBNug3SjBxqwlFL1R
         bnFgTyrzIsdk2e4oWS2hbLduaq0xSZJ1Escw3aa0bPpvWVvZWGM9EneOZ9LFAM7DO0hA
         dGcASWs1vfnTJwzv0CRXLASpdxOuZGEfOBMg2BwDJsCUz3XWAINg7mydkwbWfu7MKG1L
         08OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NehVIWYS9Z8E0exz78Jzut52ZSa/H59Ua6Dkb1UoHkI=;
        b=pGc219mtH8UlLYjqpmChfQrO9VA5mAX+lF+/2v4LVeF8skDwdC9CklYg1M/JHVr0Zq
         Lq1mP/j50xe4sx8K9Ul8JTQhBcYwx92kKFSdEbauaEcDiv46+XUJ1/nF2ic2nyaR84rR
         +0L+3os4v+fOpNbjduKTwmxgqwvjsQQtepkMllsbEOl5NNg5fDevQpz28wFXd5NIoI9f
         gk1wKljiXERWfyxz0wEU9W8Ez5zHj8BqYuKyxabmLBqYCV2DJu1jpt01Bq3lEq2TzPoB
         0ERaFl/FGCWwqVP8ETA7XKDZxIraONIE+DE+me8SkL5nsIUmGkMGcncmxTPT1kjIzMw2
         dP/A==
X-Gm-Message-State: APjAAAVWqcwH6mU9MoFd3k4Yyi6peeKhPs3xgFaSbqd7g9r3UQtaKD5K
        8GJ/Z2sG2VynLfGmMzwGhMg=
X-Google-Smtp-Source: APXvYqyrFuGwLUiBgMp6jj1/WxE7Pn7UeAD+pLzpLEN7Tb73tSrBEEye76x+0RzwutTurcHl9nlZHg==
X-Received: by 2002:a37:bfc5:: with SMTP id p188mr22708288qkf.283.1579046927517;
        Tue, 14 Jan 2020 16:08:47 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:14fc:be65:9350:cf67? ([2001:4898:a800:1012:c630:be65:9350:cf67])
        by smtp.gmail.com with ESMTPSA id v24sm8380346qtq.14.2020.01.14.16.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 16:08:47 -0800 (PST)
Subject: Re: [PATCH 8/9] revision.c: use bloom filters to speed up path based
 revision walks
To:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <72a2bbf6765a1e99a3a23372f801099a07fe11a5.1576879520.git.gitgitgadget@gmail.com>
 <86d0bqsuqc.fsf@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <706f7e8f-9211-36f0-1e83-cc98dbdd3ae1@gmail.com>
Date:   Tue, 14 Jan 2020 19:08:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <86d0bqsuqc.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/10/2020 7:27 PM, Jakub Narebski wrote:
> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>  		case REV_TREE_SAME:
>>  			if (!revs->simplify_history || !relevant_commit(p)) {
>>  				/* Even if a merge with an uninteresting
>> @@ -3342,6 +3376,33 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
>>  	}
>>  }
>>  
>> +static void prepare_to_use_bloom_filter(struct rev_info *revs)
> 
> All right, I see that pointers to bloom_key and bloom_filter_settings
> were added to the rev_info struct.  I understand why the former is here,
> but the latter seems to be there just as a shortcut (to not owned data),
> which is fine but a bit strange.
> 
> Or is the latter here to allow for Bloom filter settings to possibly
> change from commit-graph file in the chain to commit-graph file, and
> thus from commit to commit?
> 

The latter. The idea is to keep the implementation open to that 
possibility. Load the bloom filter settings from the commit graph file 
you are dealing with and use those settings to fill out the bloom_key.

>> +	const char *path;
>> +	size_t len;
>> +
>> +	if (!revs->commits)
>> +	    return;
> 
> When revs->commits may be NULL?  I understand that we need to have this
> check because we use revs->commits->item next (sidenote: can revs ever
> be NULL?).
> 
> Would `git log --all -- <path>` use Bloom filters (as it theoretically
> could)?
> 

I am being defensive about revs->commits being NULL for the reason you 
called out. 

And yes, `git log --all <path>` does use Bloom filters if provided a 
single pathspec and when following the first parent.  

>> +
>> +	if (!revs->repo->objects->commit_graph)
>> +		return;
>> +
>> +	revs->bloom_filter_settings = revs->repo->objects->commit_graph->settings;
>> +	if (!revs->bloom_filter_settings)
>> +		return;
> 
> All right, so if there is no commit graph, or the commit graph does not
> include Bloom filter data, there is nothing to do.
> 
> Though I worry that it would make Git do not use Bloom filter if the top
> commit-graph in the chain does not include Bloom filter data, while
> other commit-graph files do (and Git could have used that information to
> speed up the file history query).
> 

Thanks for bringing this up! I need to test this scenario out more. 

>> +
>> +printf "c7\nc4\nc1" > expect_file1
> 
> Doing things outside test is discouraged.  We can create a separate test
> that creates those expect_file* files, or it can be a part of 'create
> commits' test.
> 
> Anyway, instead of doing test without Bloom filters (something that
> should have been tested already by other parts of testsuite), and then
> doing the same test with Bloom filter, why not compare that the result
> without and with Bloom filter is the same.  The t5318-commit-graph.sh
> test does this with help of graph_git_two_modes() function:
> 
>   graph_git_two_modes () {
>   	git -c core.commitGraph=true  $1 >output
>   	git -c core.commitGraph=false $1 >expect
>   	test_cmp expect output
>   }
> 
> Sidenote: I wonder if it is high time to create t/lib-commit-graph.sh
> helper with, among others, this common function.
>

Thank you! I have restructured the test to do almost everything you 
have suggested. 

Also, a note for this v1 RFC series: I am working on proper formal tests 
right now. I didn't want to wait to get these nailed down before sending 
out the RFC series and getting the ball rolling. 

I have taken note of all the testing suggestions you have made in your 
review. They are very helpful and I appreciate it! 

Creating t/lib-commit-graph.sh helper would be orthogonal to this series,
so I will follow up with a separate series that does this. 

Cheers! 
Garima Singh

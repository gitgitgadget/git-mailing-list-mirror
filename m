Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02A9C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 12:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AFD20732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 12:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HehrQu3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgDMMIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgDMMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 08:08:53 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD0BC03BC86
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 05:08:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g14so590512otg.10
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K2ZVLZLg6hbKFbRRs4WDs0Mo/EXmad9p9254iynErnA=;
        b=HehrQu3WOS0ncM7+UEvxTy1drkyizYhdMfCRoEz15dEiTFT6sg24NL30vl/7LhNQg2
         W7VzPh2U0ObtMr4bYSvIZAXK3BpryA1XYd7upvolfffBIrpU7sXtc+2Gehb9sL8L3OtA
         wJNMEJjm94iZdiYSWuZ6ZmIBUWVQQgTG7yCUgIrl6aDVj1wVr2Tqo2zTbmuZNT8zx1km
         4Z4dQwV7o2YKOevFb+niJfszFR8N40OTc8AFTgaA/o4ME7bCfXqJaKYajZQuYCV7QKMC
         6ol+WvuOnk1EZEQNL+KOrlfRUG7UCEKe9M4KegT2/NovTnibVK6ch0XOIv1zA9iEPw+z
         EhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K2ZVLZLg6hbKFbRRs4WDs0Mo/EXmad9p9254iynErnA=;
        b=goUvCMvpIjLxSdeH2t9mIC71r3oje2+wbTsMygwdZGbOuSqWJlRHfFEHO9p8COgrvm
         mISHX39ugigoZhMrmAdr1PQqKmsw4jJw/450t9eewaa3QdqV7YVF0v3VnU6qoklBQ6M/
         0HEqVYHjKt2pO2EIvko7IbCC55fmVfc5Kb6nDQzi5IFjeB7qTaZ/CRB0m8m8PRsfbPG8
         jqF6N0VdF2ofLVX9u/OMs2PtH5hCI8GlY1bd03IMOYJlCIvWlnA/ggM4EoPD/BWubzRV
         yKNLWRcMemtoaRl47v37WpXzRt5mBq/9egg5tAV+jMtOcN+kkGuOXO8dPrkNA0+DHVn0
         z/kw==
X-Gm-Message-State: AGi0PuZ3Kfp5JAvy9Y4lEdeB4LCoAoiStxwbPuRNRmhCWLw7eu2Qq+Um
        dOb8c5NenOxrgaQY+aUfldA=
X-Google-Smtp-Source: APiQypJHXZjz0wj24L8+Pjcli5/X/Bsgpw5Bu02D8QD5+h2hMvpzzDCvgsOPD3xEo+RNW42IoM17dA==
X-Received: by 2002:a9d:7d8a:: with SMTP id j10mr2997438otn.266.1586779732460;
        Mon, 13 Apr 2020 05:08:52 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u127sm4697884oib.1.2020.04.13.05.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 05:08:51 -0700 (PDT)
Subject: Re: [PATCH 2/3] commit: write commit-graph with bloom filters
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <bb5ce39d0283f14095d87dd0645e641ae799f16c.1586566981.git.gitgitgadget@gmail.com>
 <xmqqa73hheip.fsf@gitster.c.googlers.com> <20200412205148.GB50412@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ef47003-784d-6a27-666d-5c916c4deb33@gmail.com>
Date:   Mon, 13 Apr 2020 08:08:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200412205148.GB50412@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/2020 4:51 PM, Taylor Blau wrote:
> On Sat, Apr 11, 2020 at 02:57:18PM -0700, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> diff --git a/builtin/commit.c b/builtin/commit.c
>>> index d3e7781e658..d2fdfdc4363 100644
>>> --- a/builtin/commit.c
>>> +++ b/builtin/commit.c
>>> @@ -1701,7 +1701,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>>  		      "not exceeded, and then \"git restore --staged :/\" to recover."));
>>>
>>>  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
>>> -	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
>>> +	    write_commit_graph_reachable(the_repository->objects->odb,
>>> +					 git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0) ? COMMIT_GRAPH_WRITE_BLOOM_FILTERS : 0,
>>> +					 NULL))
>>
>> Yuck.  That is doubly mouthful.
> 
> Yeah, this is quite a mouthful indeed. I think the most conservative fix
> would be something like:
> 
>   if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0)) {
>     enum commit_graph_write_flags flags = 0;
>     if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
>       flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
> 
>     if (write_commit_graph_reachable(the_repository->objects->odb,
>                                      flags, NULL)) {
>       /* ... */
>     }
>   }
> 
> and then ripping this knob out (as Junio suggests below, which I think
> is a wise suggestion) out would be straightforward.
> 
>> I wonder how much value we are getting by having this call here in
>> the first place.  This function being cmd_commit(), by definition we
>> won't be updating the graph file unless the test script does "git
>> commit".  We won't update the graph file upon "git rebase", "git
>> merge", "git pull", "git fetch", etc., so it is not like with this
>> hack, the test coverage for various traversal using the graph file
>> would magically be perfect.  We'd still need an explicit call to
>> "commit-graph write" at strategic places in the test scripts, no?
> 
> Yeah. It's definitely not a silver bullet for the reasons you mention,
> but I think that it is helping out in some common cases. For example,
> if we moved this check out to 'test_commit', then we'd be relying on
> tests to use that instead of 'git commit'. On the other hand, this
> catches either, since they both wind up in this builtin.
> 
> I guess you could push this check down much further to when we're about
> to write a new object, and--if that new object is a commit--update the
> commit-graph. That sounds awfully slow (and feels to me like a hack, but
> I can't justify whether it's more or less of a hack than we already
> have), but I think it would be OK, since this isn't the normal way to
> run tests.

If we keep this simple, or extract the process to a
"write_commit_graph_for_tests()" macro inside builtin.h, then we could
insert a commit-graph write in more places.

However, I think there is value in testing the "not every commit is
included in the commit-graph" case, which our current setup does quite
nicely. The one exception is that 'git merge' could benefit from this
snippet, so we cap off the commit-graph whenever a test script
"constructs" a repository to match a data shape.

>> How are we testing with and without bitmaps, and do we have a kludge
>> like this one for the feature, or do we use a different mechanism
>> to help writing tests easier to gain better coverage?
> 
> As far as I know after a brief search, we have no similar such mechanism
> for bitmaps, so commit-graphs are a unique instance.

I would not be against a similar mechanism for bitmaps, but this is
really important for commit-graphs. The difference lies in which users
have commit-graphs versus bitmaps. Now that commit-graphs are on by
default and written by 'git gc', client users get commit-graphs unless
they opt-out. We need to test as many scenarios as possible to avoid
causing them disruption.

Who uses bitmaps? Primarily Git servers. The scenarios run on those
repos are much more restricted, and those scenarios are tested with
bitmaps explicitly.

>> In any case, I can see why we want a separate knob specific to the
>> CHANGED_PATHS until the path filter part becomes as stable as the
>> rest of the graph file, but after some time, we should remove that
>> knob, and at that point, we always use the path filter whenever we
>> use commit-graph, so that we won't have to suffer from the ugliness.
>>
>> Wait.  I wonder if we can tweak the arrangement a bit so that this
>> layer does not need to know any more than GIT_TEST_COMMIT_GRAPH?
>>
>> For example, in commit-graph.c::write_commit_graph(), can we test
>> the CHANGED_PATHS environment variable and flip the .changed_paths
>> bit, no matter what the 'flags' argument to the function says?
> 
> It may be cleaner to have 'GIT_TEST_COMMIT_GRAPH' specify the flags that
> it wants as its value, but the additional coupling makes me somewhat
> uncomfortable.

It would be easy to insert it here: 

diff --git a/commit-graph.c b/commit-graph.c
index 77668629e2..3e8f36ce5c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1968,6 +1968,8 @@ int write_commit_graph(struct object_directory *odb,
        ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
        ctx->split_opts = split_opts;
        ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
+       if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
+               ctx->changed_paths = 1;
        ctx->total_bloom_filter_data_size = 0;
 
        if (ctx->split) {

The problem here is that if GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1 and
someone runs "git commit-graph write --no-changed-paths" then the
negation of that option is ignored. But this is a GIT_TEST_* variable,
and any test that requires that check could disable the enviroment
variable first.

Thanks,
-Stolee

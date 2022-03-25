Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3170DC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 16:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiCYQnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243097AbiCYQnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 12:43:12 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBCE09AC
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 09:41:38 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so8650601fac.7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ReGBo68iMGJ9VuZqvZONb0kANaiGFmRj4NcYtkKnPvA=;
        b=IK6/P/++e59IwSow223xdFV/vt41bUk+abJRc6TvK0CGIyNN4PiemLcm7IL5NqtloS
         vNeqZNS6WE/Nd84qjBGqVlqJae41/8HckkLnmqgYVjnRjZP66+ksztWQnirICAEcgWCs
         wuSdww+3GypihcUPvNqXJLlKkG9kwCmeukuzcnX7Pgdfr3i1JH6lDGALHXdez0G+3Lir
         XmAOW55Gg4/YrXa+eERzmgKXeIY2HcC9ajI9S4JFS8N2A0JAYe3x2LqtuF3Otew+YV1z
         3gcC0KSOyjw1PIC+8mu29gm1LunGtW7wjz7R+e78UZsieP73rnqMNxM25v/AF49Fb7vu
         frqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ReGBo68iMGJ9VuZqvZONb0kANaiGFmRj4NcYtkKnPvA=;
        b=JhMOQZZzvw7ygUeU30zuNKRfd/R4dttgbVHpUMosxhMycSl7Dwz6WyEIFrdjou0ymL
         kK6gjfTQSkODoDTKvMt220YJDc/qUV3MMEYp34VY6wAw2GDCFc/W4CATiA0YZTnUgWQd
         KtPLfhjjvlSkeiikdobans88PcciVeLx8FN1poExVlxPdTkgomFtHqpAWspJ6hRi1BF3
         SxgMrZd27/sBinQSuzuECcqL/qXtr+IU4jO4YMLJOdIVL5hHOLR8pWY7YPfgihxPwJCq
         UG126wPp42zV+llHO1SCuRLqE2PlJ9dPZdEUKHHN4g2gf73E4048NTPOcg33kPf5smc/
         BkGA==
X-Gm-Message-State: AOAM5325dcbMOFR14X5U6C4CmS+FIsLikPbE7XIJed9Om5/WE30Wh43b
        YF8xCuHob2GbQuS/pD+MCJaO
X-Google-Smtp-Source: ABdhPJx5Dvoc2THB0N3tYzomBFUvFFnjoktvprzHpVYfRMTJmtaZ8VUd3jH76x3L6adR/EuJgFqDaQ==
X-Received: by 2002:a05:6870:51cf:b0:da:4538:cae3 with SMTP id b15-20020a05687051cf00b000da4538cae3mr9601143oaj.21.1648226496368;
        Fri, 25 Mar 2022 09:41:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g8-20020acab608000000b002ecf38fb699sm3035942oif.38.2022.03.25.09.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:41:36 -0700 (PDT)
Message-ID: <8d368240-dae5-7a66-6c0c-9e0a960ca34c@github.com>
Date:   Fri, 25 Mar 2022 12:41:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pack-objects: lazily set up "struct rev_info", don't leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <patch-1.1-193534b0f07-20220325T121715Z-avarab@gmail.com>
 <d71fa968-be75-f4ad-ea6c-644f9d2b52d9@github.com>
 <220325.86r16qkodl.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220325.86r16qkodl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 12:00 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 25 2022, Derrick Stolee wrote:
> 
>> On 3/25/2022 10:25 AM, Ævar Arnfjörð Bjarmason wrote:
>>> In the preceding [1] (pack-objects: move revs out of
>>> get_object_list(), 2022-03-22) the "repo_init_revisions()" was moved
>>> to cmd_pack_objects() so that it unconditionally took place for all
>>> invocations of "git pack-objects".
>>>
>>> We'd thus start leaking memory, which is easily reproduced in
>>> e.g. git.git by feeding e83c5163316 (Initial revision of "git", the
>>> information manager from hell, 2005-04-07) to "git pack-objects";
>>>
>>>     $ echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects initial
>>>     [...]
>>> 	==19130==ERROR: LeakSanitizer: detected memory leaks
>>>
>>> 	Direct leak of 7120 byte(s) in 1 object(s) allocated from:
>>> 	    #0 0x455308 in __interceptor_malloc (/home/avar/g/git/git+0x455308)
>>> 	    #1 0x75b399 in do_xmalloc /home/avar/g/git/wrapper.c:41:8
>>> 	    #2 0x75b356 in xmalloc /home/avar/g/git/wrapper.c:62:9
>>> 	    #3 0x5d7609 in prep_parse_options /home/avar/g/git/diff.c:5647:2
>>> 	    #4 0x5d415a in repo_diff_setup /home/avar/g/git/diff.c:4621:2
>>> 	    #5 0x6dffbb in repo_init_revisions /home/avar/g/git/revision.c:1853:2
>>> 	    #6 0x4f599d in cmd_pack_objects /home/avar/g/git/builtin/pack-objects.c:3980:2
>>> 	    #7 0x4592ca in run_builtin /home/avar/g/git/git.c:465:11
>>> 	    #8 0x457d81 in handle_builtin /home/avar/g/git/git.c:718:3
>>> 	    #9 0x458ca5 in run_argv /home/avar/g/git/git.c:785:4
>>> 	    #10 0x457b40 in cmd_main /home/avar/g/git/git.c:916:19
>>> 	    #11 0x562259 in main /home/avar/g/git/common-main.c:56:11
>>> 	    #12 0x7fce792ac7ec in __libc_start_main csu/../csu/libc-start.c:332:16
>>> 	    #13 0x4300f9 in _start (/home/avar/g/git/git+0x4300f9)
>>>
>>> 	SUMMARY: LeakSanitizer: 7120 byte(s) leaked in 1 allocation(s).
>>> 	Aborted
>>>
>>> Narrowly fixing that commit would have been easy, just add call
>>> repo_init_revisions() right before get_object_list(), which is
>>> effectively what was done before that commit.
>>>
>>> But an unstated constraint when setting it up early is that it was
>>> needed for the subsequent [2] (pack-objects: parse --filter directly
>>> into revs.filter, 2022-03-22), i.e. we might have a --filter
>>> command-line option, and need to either have the "struct rev_info"
>>> setup when we encounter that option, or later.
>>>
>>> Let's just change the control flow so that we'll instead set up the
>>> "struct rev_info" only when we need it. Doing so leads to a bit more
>>> verbosity, but it's a lot clearer what we're doing and why.
>>
>> This makes sense.
>>
>>> We could furthermore combine the two get_object_list() invocations
>>> here by having repo_init_revisions() invoked on &pfd.revs, but I think
>>> clearly separating the two makes the flow clearer. Likewise
>>> redundantly but explicitly (i.e. redundant v.s. a "{ 0 }") "0" to
>>> "have_revs" early in cmd_pack_objects().
>>
>> I disagree, especially when you later want to make sure we free
>> the data from revs using your release_revisions().
> 
> Because we'll need two release_revisions() instead of one?

And it would be easy to miss one of the two if you are only testing
certain paths with leak-check on.

>>> This does add the future constraint to opt_parse_list_objects_filter()
>>> that we'll need to adjust this wrapper code if it looks at any other
>>> value of the "struct option" than the "value" member.
>>
>> So we are coupling ourselves to the implementation of this method.
> 
> Sure, but aren't all OPT_* where the macro is providing some custom
> callback coupling themselves to how it's implemented?

No, I mean that the callback function you are making here is coupling
itself to the existing callback function in a novel way.

I tried to find another example of a nested callback, but I didn't
even find another instance of creating a new 'struct option'.

>>> But that regression should be relatively easy to spot. I'm
>>> intentionally not initializing the "struct wrap" with e.g. "{ 0 }" so
>>> that various memory sanity checkers would spot that, we just
>>> initialize the "value" in po_filter_cb(). By doing this e.g. we'll die
>>> on e.g. this test if we were to use another member of "opt" in
>>> opt_parse_list_objects_filter()>
>>
>> So you are using uninitialized memory as a way to discover any
>> necessary changes to that coupling. I'm not sure this is super-safe
>> because we don't necessarily run memory checkers during CI builds.
>>
>> I'd rather have a consistently initialized chunk of data that would
>> behave predictably (and hopefully we'd discover it is behaving
>> incorrectly with that predictable behavior).
> 
> I'd like to keep this as-is, i.e. if you zero it out it might also
> behave unpredictably or even in undefined ways (e.g. a NULL ptr
> dereference). Likewise in my version, but it has the benefit of being
> caught by some tooling we have.

I guess by "predictable" I mean "well-defined" or "deterministic".

I don't want the build options to change how this works (for instance,
debug builds sometimes initialize data to zero).

>> +struct rev_info_maybe_empty {
>> +	int has_revs;
>> +	struct rev_info revs;
>> +};

Thinking about this a second time, perhaps it would be best to add
an "unsigned initialized:1;" to struct rev_info so we can look at
such a struct and know whether or not repo_init_revisions() has
been run or not. Avoids the custom struct and unifies a few things.

In particular, release_revisions() could choose to do nothing if
revs->initialized is false.

Further, a second repo_init_revisions() could do nothing if
revs->initialized is true. This allows us to safely "re-init"
without our own "if (has_revs)" checks...
>> 	else {
>> 		if (!pfd.have_revs) {
>> 			repo_init_revisions(the_repository, &pfd.revs, NULL);
>> 			pfd.have_revs = 1;
>> 		}
>> 		get_object_list(&pfd.revs, rp.nr, rp.v);
>> 	}

...making this just

	else {
		repo_init_revisions(the_repository, &revs, NULL);
		get_object_list(&revs. rp.nr, rp.v);
	}

> Conceptually I think the saving of that one line isn't worth it to the
> reader.
> 
> Then you'd need to read up and see exactly how pfd.revs gets mutated,
> and its callback etc., only to see we're just doing this to save
> ourselves a variable deceleration and a call to release_revisions().
> 
>> and then later you can add
>>
>> 	if (pfd.have_revs)
>> 		release_revisions(&pfd.revs);

And this would just be

	release_revisions(&revs);

>> to clear the memory in exactly one place.
> 
> Yeah, it would work. I'd just prefer control flow that's trivial to
> reason about over saving a couple of lines here.

I think having multiple revision things that can live at different
levels (one embedded in a custom struct, one not) is not trivial to
reason about. If we change the "is this initialized" indicator to be
within 'struct rev_info', then this gets simpler.

It seems to me that it is easier to track a single struct and release
the memory in one place based on its lifespan.

Thanks,
-Stolee

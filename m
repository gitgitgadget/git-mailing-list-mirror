Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C8C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiCJNeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiCJNeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:34:06 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB090148657
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:33:04 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so4077813otk.8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gMHO07JqA5gPB85Y6i3Ez/a5UvLcfWT/zNeDAeClTRA=;
        b=Hh8vtlnD6CU7NB2lEP3XdwzeJb1GqAb8HxTLBoaHiag4bO61+mEKjUTuFcqMmotKeG
         glEdqwjhN/S2S464qc7hx7yc2cs4cFG96q72ruN8gfFmNfBhfFE10kSVp/CF277Gf9NE
         xmK/rmQM221GMTLVogvUCwGZIJMz38DY4IwNkElN5zrZhF+iabyneKcvbHPGP6Q89FCG
         i7qUbU+60uevUZYEocRzUZFbkkS3JgORqGw/Smy8hwvS/Ajd3oks5P99Mr1fc7uRuI6Z
         pN+9aKIpzuAnUSRSsgnhKkhEXLMEOwch1KnWDAVJoq8kxLODZeBfZOizd5O8Ygqn+Ypu
         g/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gMHO07JqA5gPB85Y6i3Ez/a5UvLcfWT/zNeDAeClTRA=;
        b=N6SR7Gm3XP/3cav3gjO1ICZO7NbXM+qK6KQlHhJKa05KOP7nxWLJsjORU810mgtBqS
         /R48stxsgvBa3MlOGi7DgvQQxgD6a6z5ncxFbEdDZgFF95GS7nhjfCwio4TrwxBUpkL5
         olwWZotvSObKQh9tER+scrBk36UMDCc/SCoMJASCEoBNMtEmI3/1Vtd1TW+5QTpkQv9T
         OaXlWlFvc+Z8idpwh07MAQ/+wBW6Z+JZBQAZRP2wSuFtjIjFj7+9ENTqBSAvd4ijgvZe
         39hlnk9jUk8c+q6Sgt7q5T7WD13e+OdXoJoZYm66zuXVjuGhp50I4HNQMtEwBqvzplcO
         /DCw==
X-Gm-Message-State: AOAM532vaWHCq3QQa0S6C+Rb5M+cMA20iiT4UfTwXvmCJ4UKq7uAVkub
        BKdxmC3QCExPjaU72F2mAQzI
X-Google-Smtp-Source: ABdhPJyuy5WzYQ9yJ6qPv+b8WWbjlTrRJxnXq06CqmLICUTLEmhliyfYWVzPhXpxVIPbDtnuas4ggQ==
X-Received: by 2002:a9d:5:0:b0:5b2:2cac:4f4f with SMTP id 5-20020a9d0005000000b005b22cac4f4fmr2661305ota.48.1646919184179;
        Thu, 10 Mar 2022 05:33:04 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id ec47-20020a0568708c2f00b000d9ca2e1904sm2336722oab.45.2022.03.10.05.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 05:33:03 -0800 (PST)
Message-ID: <645650c1-7918-6985-a08b-cb47247b08d4@github.com>
Date:   Thu, 10 Mar 2022 08:33:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 04/13] pack-objects: use rev.filter when possible
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
 <ed22a77782bee97ef50fe1ff1a12fa2fa1470805.1646841703.git.gitgitgadget@gmail.com>
 <220310.86zglyj5xz.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220310.86zglyj5xz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2022 8:11 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 09 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> In builtin/pack-objects.c, we use a 'filter_options' global to populate
>> the --filter=<X> argument. The previous change created a pointer to a
>> filter option in 'struct rev_info', so we can use that pointer here as a
>> start to simplifying some usage of object filters.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  builtin/pack-objects.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index ba2006f2212..e5b7d015d7d 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
>>  
>>  static int get_object_list_from_bitmap(struct rev_info *revs)
>>  {
>> -	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
>> +	if (!(bitmap_git = prepare_bitmap_walk(revs, &revs->filter, 0)))
>>  		return -1;
>>  
>>  	if (pack_options_allow_reuse() &&
>> @@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
>>  	repo_init_revisions(the_repository, &revs, NULL);
>>  	save_commit_buffer = 0;
>>  	setup_revisions(ac, av, &revs, &s_r_opt);
>> +	list_objects_filter_copy(&revs.filter, &filter_options);
>>  
>>  	/* make sure shallows are read */
>>  	is_repository_shallow(the_repository);
>> @@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
>>  
>>  	if (!fn_show_object)
>>  		fn_show_object = show_object;
>> -	traverse_commit_list_filtered(&filter_options, &revs,
>> +	traverse_commit_list_filtered(&revs.filter, &revs,
>>  				      show_commit, fn_show_object, NULL,
>>  				      NULL);
> 
> Re your
> https://lore.kernel.org/git/77c8ef4b-5dce-401b-e703-cfa32e18c853@github.com/
> I was looking at how to handle the interaction between this and my
> revisions_release() series.
> 
> This adds a new memory leak, which can be seen with:
> 
>     make SANITIZE=leak
>     (cd t && ./t5532-fetch-proxy.sh -vixd)
> 
> I.e. this part is new:
>     
>     remote: Direct leak of 1 byte(s) in 1 object(s) allocated from:
>     remote:     #0 0x4552f8 in __interceptor_malloc (git+0x4552f8)
>     remote:     #1 0x75a089 in do_xmalloc wrapper.c:41:8
>     remote:     #2 0x75a046 in xmalloc wrapper.c:62:9
>     remote:     #3 0x62c692 in list_objects_filter_copy list-objects-filter-options.c:433:2
>     remote:     #4 0x4f70bf in get_object_list builtin/pack-objects.c:3730:2
>     remote:     #5 0x4f5e0e in cmd_pack_objects builtin/pack-objects.c:4157:3
>     remote:     #6 0x4592ba in run_builtin git.c:465:11
>     remote:     #7 0x457d71 in handle_builtin git.c:718:3
>     remote:     #8 0x458ca5 in run_argv git.c:785:4
>     remote:     #9 0x457b30 in cmd_main git.c:916:19
>     remote:     #10 0x563179 in main common-main.c:56:11
>     remote:     #11 0x7fddd2da67ec in __libc_start_main csu/../csu/libc-start.c:332:16
>     remote:     #12 0x4300e9 in _start (git+0x4300e9)
>     
> Of course it's not "new" in the sense that we in effect leaked this
> before, but it was still reachable, you're just changing it so that
> instead of being stored in the static "filter_options" variable in
> pack-objects.c we're storing it in "struct rev_info", which has a
> different lifetime.

True, and 'struct rev_info' is not being release in any way, either,
right?

> I think instead of me rebasing my series on top of yours and tangling
> the two up a better option is to just add a change to this, so after
> list_objects_filter_copy() do:
> 
>     UNLEAK(revs.filter);
> 
> Or, alternatively adding this to the end of the function (in which case
> Junio will need to deal with a minor textual conflict):
> 
>     list_objects_filter_release(&revs.filter);
> 
> Both of those make my series merged with "seen" (which has this change)
> pass with SANITIZE=leak + GIT_TEST_PASSING_SANITIZE_LEAK=true again.
> 
> You could do the same in your later change adding
> list_objects_filter_copy() to verify_bundle(), that one also adds a new
> leak, but happens not to cause test failures since the bundle.c code
> isn't otherwise marked as passing with SANITIZE=leak, it fails in
> various other ways.
> 
> Obviously we should do something about the actual leak eventually, but
> that can be done in some follow-up work to finish up the missing bits of
> release_revisions(), i.e. adding list_objects_filter_release() etc. to
> release_revisions().

I understand that you like to "show your work" by marking tests as
safe for leak-check by making the smallest changes possible, but your
series has a lot of small patches that do nothing but add a free() or
release_*() call instead of implementing the "right" release_revisions()
from the start.
 
> So I think just adding UNLEAK() here (and optionally, also to the
> bundle.c code) is the least invasive thing, if you & Junio are OK with
> that approach.

Could you send a patch that does just that, so we are sure to cover
the warnings you are seeing in your tests?

Thanks,
-Stolee

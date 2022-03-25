Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9BC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiCYTdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiCYTd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:33:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C956223BC7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q129so9180251oif.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=50OKsXb3Hx+vqKuh3+ysdsPm5apUUWiXy6G23pYO/U8=;
        b=AYJXuZhG9nNOqdeRK4cHM1MraN6nnBl9worQksRQMYeXNlQQNtRBLHrxIMErWOnVhw
         vD2jr2zrqsJuJUIwtZdGHoyfIprWfEyJTm5O6rMx29++waieEWIRCv3A67KSntl1NWY5
         pCXOjJWoAqOE1BYkLhD2FsiWFi2sWdYRXh5gXt/zIzC6ycDfrBk7zYOtuvBM5gE5jzCZ
         EU9tlXz4AJrFKFEOw7oQvvlQNd4cXtQJ3XChj2KvwZpdVL6cyeQXM0jZJRLzXNXg+e8w
         HzGZgWrvb0qcVYyi3EdSIQkSkwKxWFJBRahID0+wdT2MNJ21Vv+fsqKjXQDoOdOvdpyy
         Pyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=50OKsXb3Hx+vqKuh3+ysdsPm5apUUWiXy6G23pYO/U8=;
        b=WKNBtmW/79hiNxBQiZk1s0s3AT6bn2RALX90a4B755tEmqRSqCasm3slot39SGeIQ2
         xxHUy/8QTmfaz//6dgMw5odjlIpK8JeSh+WhYrCXsWIB92/ffKCHId9gQzUc0qupL6C9
         Pe9Y1kFylMq78mDA/T50ZG2JqPfs460iZ4TMaHNYQ252PvLEHPwWnKwn5ZlY1Se859Eb
         g3yFWnly2raGCLprMi0H+78kKYn0lZJ9L/lEPZ+wHYq5v7EIm1GFKcef7I6qjD9ZBLH8
         33lh5l16m0GljI+59P3CvS43plxqBcI4fuGio64GL3vnpjeueTRxPNswtCcG2wTl6wAZ
         2d7A==
X-Gm-Message-State: AOAM532BapsyxLhu2O1ddKkEHjBN9+k9Iq4Gwc7AeS1d0qz9RKovlxrY
        ZLvbIt457cwlT8AYJCHeZuXE
X-Google-Smtp-Source: ABdhPJygcUMd8SgXA4VAhPMIADSpnJX7g/Gh/o1c8nTbrXRpr2rT7X4c7f3TCw2MbhOg10FIg2bYgA==
X-Received: by 2002:a05:6808:10cb:b0:2da:88e4:e352 with SMTP id s11-20020a05680810cb00b002da88e4e352mr9974562ois.159.1648235305376;
        Fri, 25 Mar 2022 12:08:25 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i4-20020a4addc4000000b00324bd261e5fsm2525997oov.11.2022.03.25.12.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:08:25 -0700 (PDT)
Message-ID: <d90bb9c8-3155-ca5f-8363-154876a7ad0a@github.com>
Date:   Fri, 25 Mar 2022 15:08:23 -0400
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
 <8d368240-dae5-7a66-6c0c-9e0a960ca34c@github.com>
 <220325.86mthdlx59.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220325.86mthdlx59.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/2022 1:34 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 25 2022, Derrick Stolee wrote:
> 
>> On 3/25/2022 12:00 PM, Ævar Arnfjörð Bjarmason wrote:
>>>> +struct rev_info_maybe_empty {
>>>> +	int has_revs;
>>>> +	struct rev_info revs;
>>>> +};
>>
>> Thinking about this a second time, perhaps it would be best to add
>> an "unsigned initialized:1;" to struct rev_info so we can look at
>> such a struct and know whether or not repo_init_revisions() has
>> been run or not. Avoids the custom struct and unifies a few things.
>>
>> In particular, release_revisions() could choose to do nothing if
>> revs->initialized is false.
> 
> This plan won't work because that behavior is both undefined per the
> standard, and something that's wildly undefined in practice.
> 
> I.e. we initialize it on the stack, so it'll point to uninitialized
> memory, sometimes that bit will be 0, sometimes 1...
> 
> If you mean just initialize it to { 0 } or whatever that would work,
> yes, but if we're going to refactor all the callers to do that we might
> as well refactor the few missing bits that would be needed to initialize
> it statically, and drop the dynamic by default initialization...

Yes, I was assuming that we initialize all structs to all-zero,
but the existing failure to do this will cause such a change too
large for this issue.

> But FWIW I think a much more obvious thing to do overall would be to
> skip the whole "filter bust me in rev_info" refactoring part of your
> series and just add a trivial list_objects_filter_copy_attach() method,
> or do it inline with memcpy/memset.
> 
> I.e. to not touch the "filter" etc. callback stuff at all, still pass it
> to get_object_list(). Can't 2/5 and 3/5 in your series be replaced by
> this simpler and smaller change?:

> 	-	list_objects_filter_copy(&revs.filter, &filter_options);
> 	+	/* attach our CLI --filter to rev_info's filter */
> 	+	memcpy(&revs.filter, filter, sizeof(*filter));
> 	+	memset(filter, 0, sizeof(*filter));

Here, you are removing a deep copy with a shallow copy. After this,
freeing the arrays within revs.filter would cause a double-free when
freeing the arrays in the original filter_options.

If you went this way, then you could do a s/&filter_options/filter/
in the existing line.

> 	 	/* make sure shallows are read */
> 	 	is_repository_shallow(the_repository);
> 	@@ -3872,6 +3873,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> 	 	int rev_list_index = 0;
> 	 	int stdin_packs = 0;
> 	 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
> 	+	struct list_objects_filter_options filter_options = { 0 };
> 	 	struct option pack_objects_options[] = {
> 	 		OPT_SET_INT('q', "quiet", &progress,
> 	 			    N_("do not show progress meter"), 0),
> 	@@ -4154,7 +4156,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> 	 	} else if (!use_internal_rev_list) {
> 	 		read_object_list_from_stdin();
> 	 	} else {
> 	-		get_object_list(rp.nr, rp.v);
> 	+		get_object_list(rp.nr, rp.v, &filter_options);
> 	 	}
> 	 	cleanup_preferred_base();
> 	 	if (include_tag && nr_result)
> 
> And even most of that could be omitted by not removing the global
> "static struct" since pack-objects is a one-off anyway ... :)

Even if you fix the deep/shallow copy above, you still need to
clean up the filter in two places.

Thanks,
-Stolee

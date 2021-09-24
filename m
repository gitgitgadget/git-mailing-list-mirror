Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899AC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB386103D
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 13:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346611AbhIXNek (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346568AbhIXNec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD6C061A11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 06:29:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r1so9335350qta.12
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6obe3zU0oUXhwdTDhkOuQd48DAZCgLoI+gIS/YA6E4=;
        b=mJXQ0td3y3OxWXCvnn05PepFfLChh38iJ1KFQ1tt/8GjXC+B/ozOt2Zcrw4cfKgxIM
         C9KqvidJ4VCPoQgaSNGMboa2XvO1Qt88nzY8YObt0k6N9YzNF9SILFKxz1jJBoVoxwhf
         wyyCC1YUSxeKFUACxE6yWCN975amjlWd5UFdVvPtVFwB1ufJsx+AO4mA8fSFLUthoVzT
         Vq3bvUWP3kFYslAasiFK33O4VMaCEiYeSd2wQX7ReX0122kYRvXyH+/msRN1T4qQo9l5
         DMs1iUSUtoyY2qJYWJN0m578WCfYSYqg5RK1YCxm8E4bWBtBcpswcN1ekZFyzz77oXhB
         p81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6obe3zU0oUXhwdTDhkOuQd48DAZCgLoI+gIS/YA6E4=;
        b=yoNDxAYj7jc+VaN3XD8+nj6Nr7c8LP672JnKBcB1uZmEMUW1eilJrK0In2yLRoWkRg
         eHoiM/wzeD+d0ZartWmrzPmz5gCe0xJEndY0pE8tajiwKyKdrloNySwSy0QhcpjpWAUG
         OrI9XbhNabyu2vQVGILYp6oE5079FCeJsuMLxlDvaMWaPSBdzLsdMdMycvU0J+ceLcWh
         hdXoAzXSxy3dbPQvqvPJyNa+CI7KS8HmFN8gl1gE+3AtQjKIF4Fd9HC+MSXqcunJcd92
         TAk6y0w7dC2AmgxVAUSf0Mm1u1h1nzXWcE0rSYjP0K33vT45yIbyfIWpOxkxJJKAubup
         unBg==
X-Gm-Message-State: AOAM53257n3PeqbsHNEHCHmiSgox4VWpujX5Pii0WStQM/gXW/v1HOHy
        OiKa4dUc2ePxUNCYtRXmjNA3pNY2FUlaeA==
X-Google-Smtp-Source: ABdhPJxRuD4nogHV/USvnh+/OM4FWLXNmRcK6ILnyYlp8nfYJPqQqC+FMeUypTF2vEW3CgekmdxsGQ==
X-Received: by 2002:ac8:7b48:: with SMTP id m8mr4136587qtu.133.1632490157942;
        Fri, 24 Sep 2021 06:29:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90c9:2224:1ace:eb97? ([2600:1700:e72:80a0:90c9:2224:1ace:eb97])
        by smtp.gmail.com with ESMTPSA id o145sm6354105qke.120.2021.09.24.06.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 06:29:16 -0700 (PDT)
Message-ID: <a848a476-3993-6fa4-9fe0-3c96c46041a4@gmail.com>
Date:   Fri, 24 Sep 2021 09:29:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 03/14] dir: extract directory-matching logic
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
 <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
 <xmqqwnn8430s.fsf@gitster.g> <36475af0-1021-f59d-cb33-b3b402c13767@gmail.com>
 <a99a58ee-c3fe-501b-3116-8b54eaed0e53@gmail.com> <xmqqlf3nywuw.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqlf3nywuw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2021 2:23 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 9/23/2021 9:39 AM, Derrick Stolee wrote:
>>> On 9/22/2021 7:13 PM, Junio C Hamano wrote:
>>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>
>>>>> +static int path_matches_dir_pattern(const char *pathname,
>>>>> +				    int pathlen,
>>>>> +				    int *dtype,
>>>>> +				    struct path_pattern *pattern,
>>>>> +				    struct index_state *istate)
>>>>> +{
>>>>> +	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
>>>>> +	if (*dtype != DT_DIR)
>>>>> +		return 0;
>>>>> +
>>>>> +	return 1;
>>>>> +}
>>>>
>>>> The function name and parameter list have "pattern" but as far as I
>>>> can see any "matches" or "pattern" comes into the picture.  The code
>>>> in the caller after calling this function may be doing pattern
>>>> matching, but not this one.
>>>>
>>>> What this helper is doing is "signal if the pathname in the working
>>>> tree is supposed to be a directory with the return value, while
>>>> filling *dtype with what kind of thing it is."
>>>>
>>>> path_must_be_dir_in_working_tree() or something, perhaps?
>>>
>>> Yes, a rename would be prudent here. Thanks.
>>
>> Of course, when I go to amend the commit, the commit message says
>>
>> 	We will expand the path_matches_dir_pattern() method in a following
>> 	change.
>>
>> which means that more will follow that will actually care about the
>> pattern and matching as a directory.
>>
>> After looking at the extension in the next patch, do you still think a
>> rename is necessary?
> 
> When the focus and purpose of the function changes, it may warrant a
> rename to include "matching" or "pattern", but not before.
> 
> Or we might be seeing a premature refactoring with these two steps.
> Are we gaining multiple callers of this function before it gets
> extended to care about pattern and matching?  If not, perhaps
> teaching the inlined codepath about the pattern and matching in
> place first before extracting the code to a helper function for
> readability and reusability may help make the resulting series
> easier to follow, and we do not have to see a function with a
> misleading name.
 
Squashing these two patches together has the same effect, but
takes a little bit extra work to see that the re-used code is
the same. It's small enough that I don't see that as a huge
hurdle.

Thanks,
-Stolee

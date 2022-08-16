Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBD3C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiHPNub (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiHPNuW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 09:50:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA59DFB9
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 06:50:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a4so980400wrq.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=X0sFoZOtB5oSyap5vnk0CxsnDrpsR1UjjfuHj95YZPE=;
        b=bT85ixZcGwYzdYZx/UeBYNCGIS+WcJBIqqx+6w5AAx/XrqvosG7rOnB1IPrVOcHkPi
         kBWAuzT7uWp5LORggg76c7MAoXsQwSjdFSyQ28MLJIA0m20vKJQFnkhFhHYE3BhkBX8g
         GgIdiH+tBh3eMrpvtJ4v6PZEqVMiymCeDew3JjdN0Wgefjpf4xExBuyNJcORZ79+BoJJ
         zuuXgPxe/geXYHlD1eN6GcuZj7PzU3XHGvPqExX1fREp9xFOuCcfSVBfeVK9sBcC/voF
         7qeP7KxrDBvomVcwoOgn8pPzWTGSQ8xTeAr7Xd4hLir+hJbU2WneRDRg5CssHja+In+P
         egoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=X0sFoZOtB5oSyap5vnk0CxsnDrpsR1UjjfuHj95YZPE=;
        b=IOuP2tIQAvMR7mJqYpNnPgbZIYa7jd1PHhAW1tmqVbqdUJ2UrvbVA55zj9A+7UBg+/
         jpQDThXshFCUmHaEypl16vALQDGH9LJySCmFgCzwdWsz9yppxzX71eyu7ypY04EF3NQ7
         yt8yRzGoH7wdw8WqT7DcPtbcH/FV7F96VgIKkWT7FZccvd3FnxM85uGIEnIf7Q3jSGd5
         CaXbeoWeqN6IW2hZOSXoUGiclZMr9tE0LEfdCiVj3jAfUdoOXZd1sVZDj0M7nrzc9moJ
         ymq+oC2XBKWxuXqeFuFqSmsr9HgvKtvYM40ilG5wnBxRjj5Zm2u4QWrNn5gQdHAe0i7S
         soGA==
X-Gm-Message-State: ACgBeo3e48yaVH44NDhh4A639lzwbtfObHRfZcrK9WpaECfFnN5/5XG2
        goZxXeBEe15DkhjctUTF79s=
X-Google-Smtp-Source: AA6agR5AxdIYp3TIhNT457hg93OUexrgEkUnpA3apd0poWKmqqOpwOdQjeVc4MjqdgXnx3IE72V2/w==
X-Received: by 2002:a05:6000:790:b0:220:732c:9ee0 with SMTP id bu16-20020a056000079000b00220732c9ee0mr11387250wrb.183.1660657807432;
        Tue, 16 Aug 2022 06:50:07 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id bt22-20020a056000081600b002251e86241csm900443wrb.48.2022.08.16.06.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 06:50:07 -0700 (PDT)
Message-ID: <c5b01472-7da9-6051-b127-1a8b8ddd2944@gmail.com>
Date:   Tue, 16 Aug 2022 14:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
 <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
 <xmqqczd12zhv.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqczd12zhv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 15/08/2022 18:22, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Separate out calculating the merge base between onto and head from the
>> check for whether we can fast-forward or not. This means we can skip
>> the fast-forward checks when the rebase is forced and avoid
>> calculating the merge-base twice when --keep-base is given.

I should clarify that this is referring to the merge base of onto and 
upstream.

>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>> Note the unnecessary braces around "if (keep_base)" are added here
>> reduce the churn on the next commit.
>> ---
>>   builtin/rebase.c | 35 +++++++++++++++++++++++------------
>>   1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 6cf9c95f4e1..86ea731ca3a 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>>   	struct commit_list *merge_bases = NULL;
>>   	int res = 0;
>>   
>> -	merge_bases = get_merge_bases(onto, head);
>> -	if (!merge_bases || merge_bases->next) {
>> -		oidcpy(merge_base, null_oid());
>> +	if (is_null_oid(merge_base))
>>   		goto done;
>> -	}
>>   
>> -	oidcpy(merge_base, &merge_bases->item->object.oid);
>>   	if (!oideq(merge_base, &onto->object.oid))
>>   		goto done;
> 
> Looking at the change in "git show -W", it seems that this function
> no longer touches merge_bases at all, other than initializing it to
> NULL at the beginning and then calling free_commit_list() on it at
> the end.  Shouldn't it be removed?

There is still the line

	merge_bases = get_merge_bases(upstream, head);

lower down. I should remove the call to free_commit_list() just above 
that line though as it is no longer needed.

>> @@ -902,6 +898,20 @@ done:
>>   	return res && is_linear_history(onto, head);
>>   }
>>   
>> +static void fill_merge_base(struct rebase_options *options,
>> +			    struct object_id *merge_base)
>> +{
>> +	struct commit_list *merge_bases = NULL;
>> +
>> +	merge_bases = get_merge_bases(options->onto, options->orig_head);
>> +	if (!merge_bases || merge_bases->next)
>> +		oidcpy(merge_base, null_oid());
>> +	else
>> +		oidcpy(merge_base, &merge_bases->item->object.oid);
>> +
>> +	free_commit_list(merge_bases);
>> +}
>> +
>>   static int parse_opt_am(const struct option *opt, const char *arg, int unset)
>>   {
>>   	struct rebase_options *opts = opt->value;
>> @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   			die(_("Does not point to a valid commit '%s'"),
>>   				options.onto_name);
>>   	}
>> -
>> +	if (keep_base) {
>> +		oidcpy(&merge_base, &options.onto->object.oid);

This is actually unnecessary as we do

	options.onto = lookup_commit_reference_by_name(options.onto_name);

above when calculating onto.

>> +	} else {
>> +		fill_merge_base(&options, &merge_base);
>> +	}
> 
> No need for braces around single-statement block on either side.
> 
> This is not a new issue introduced by this patch per-se, but
> "merge_base" is becoming less and less accurate description of what
> this variable really is.  Perhaps it is a good time to rename it?

Yes, merge_base is not a very descriptive name as it prompts the 
question "merge base of which commits". I think base_commit or 
branch_base would be better.

> It is "the base commit to rebuild the history on top of", aka "onto
> commit", isn't it?

I think it is the base commit of the branch i.e. we rebase all the 
commits in the range merge_base..branch onto the "onto commit".

> We often use merge-base between the upstream and
> our tip of the history for it,

I'm pretty sure it is always the merge-base of the "onto commit" and our 
tip of the history. When using --keep-base we calculate the "onto 
commit" as the merge base of upstream and our tip of the history which 
makes it look were using that for merge_base but that commit is also the 
merge-base of the "onto commit" and our tip of history.

Best Wishes

Phillip

> but the variable often does not even
> hold the merge-base in it, not because we cannot compute a single
> merge-base but because depending on the operation mode we do not
> want to use merge-base for further operation using that variable.

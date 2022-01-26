Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A7C28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 14:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242384AbiAZOwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbiAZOwV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 09:52:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F31FC061748
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:52:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so26226990wrx.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4p85Auc2vlR13q5/sQ6+B+PkCCTFXjyR+Y50k90EXY8=;
        b=mPrYiUTFNSFgnGYmZ9pLPpsChdhph3dkOc8C3kfxPF2l2dTlZfK2QNYmumlXdswQ3Z
         j4iJ2CPgHaTIy93faMQ2mgjSCtZppwS6NAryQd/1hei53y+sKJ8DqgbI8mPlijhxfGmI
         sXEGt4bg/pajZNSHNyXVVZeho403EekAma68/pOsZhh9k4tkzolUnR43KQb1UndFe2tu
         86uYmOLpjfyletZ15qysebvKkMrM88zf++pc+PhJNeKfvfeT2unE2RvBE3pckRYplUio
         u/fTx4qps4uNg1cHIbyxqsgHO8kn+n7y9KmhT+hAZT9p4YMIn3fte4zE7FAihEiRsGO2
         2vFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4p85Auc2vlR13q5/sQ6+B+PkCCTFXjyR+Y50k90EXY8=;
        b=NT2+6FOn/2dZ9usX8fW/9LBASuCamPr2Du58LRCUUO1LXeR7RxUOE9qOfshcpBrxww
         0Ud/7u0T3Zq8NWZXJTQsryfN4ligtE31heK/ZhQc0HU/ocSfbozVW450nOcfcq+ECY9j
         vTprh8yLiPCDMZ46ZSggYCkwt3EpjlJIvZe/yKnn/mqYlpCiKVy4xBb5FEKz1raEpmK2
         uEp0dcVzQTezN1/lzbzfFbBuGnY1VyC3EqGcMXeJTu9SJJKh5qKsk02M+nRkc81TA/R+
         uF6lUyrgo5Uzr1Soz/+BYQ+OtGgmp9jMb6/UY38C2MFfnBMhCpZrQJL+o2oXvkkpe0xl
         cnNA==
X-Gm-Message-State: AOAM53341UMLThYFewvkMYyMsqnYSbWnsRUA4A9YjU6YQi3qybw/aeGQ
        CShzySv2JEHv+KuLI/orqJOm/BT7WZk=
X-Google-Smtp-Source: ABdhPJyWPkdCULY5y/77p1OoLyUXllafUECmKGrcqbOdF8RBXtPqPUduLh/Sa8hZWrVZnzb/wp5NKA==
X-Received: by 2002:a5d:6da4:: with SMTP id u4mr21193688wrs.629.1643208739611;
        Wed, 26 Jan 2022 06:52:19 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id n13sm3535752wms.8.2022.01.26.06.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:52:19 -0800 (PST)
Message-ID: <7b56e91b-a7c9-b7cb-356c-e9615b9459fa@gmail.com>
Date:   Wed, 26 Jan 2022 14:52:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 11/14] reset_head(): take struct rebase_head_opts
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
 <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
 <d170703e8334a6f082f18b9e5bde3be3a60deed7.1643202349.git.gitgitgadget@gmail.com>
 <220126.86fspafwg8.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220126.86fspafwg8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 26/01/2022 13:35, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jan 26 2022, Phillip Wood via GitGitGadget wrote:
> 
>> @@ -669,13 +672,15 @@ static int run_am(struct rebase_options *opts)
>>   
>>   	status = run_command(&format_patch);
>>   	if (status) {
>> +		struct reset_head_opts ropts = { 0 };
>>   		unlink(rebased_patches);
>>   		free(rebased_patches);
>>   		strvec_clear(&am.args);
>>   
>> -		reset_head(the_repository, &opts->orig_head,
>> -			   opts->head_name, 0,
>> -			   NULL, NULL, DEFAULT_REFLOG_ACTION);
>> +		ropts.oid = &opts->orig_head;
>> +		ropts.branch = opts->head_name;
>> +		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
>> +		reset_head(the_repository, &ropts);
>>   		error(_("\ngit encountered an error while preparing the "
>>   			"patches to replay\n"
>>   			"these revisions:\n"
> 
> Wouldn't these and the rest be easier to read as:
> 
> 	struct reset_head_opts ropts = {
> 		.oid = &opts->orig_head,
>                  .branch = opts->head_name,
>                  .default_reflog_action = DEFAULT_REFLOG_ACTION,
>          };

I did start out doing something like that but changed to the current 
style as I felt it made it easier to convert the calls correctly and for 
reviewers to verify that the conversion is correct when the deletion of 
the old function arguments is adjacent to the insertion of the new 
struct assignments and the assignments are in the same order as the old 
function arguments.

> ....
> 
> 
>> @@ -814,14 +819,17 @@ static int rebase_config(const char *var, const char *value, void *data)
>>   static int checkout_up_to_date(struct rebase_options *options)
>>   {
>>   	struct strbuf buf = STRBUF_INIT;
>> +	struct reset_head_opts ropts = { 0 };
>>   	int ret = 0;
>>   
>>   	strbuf_addf(&buf, "%s: checkout %s",
>>   		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
>>   		    options->switch_to);
>> -	if (reset_head(the_repository, &options->orig_head,
>> -		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
>> -		       NULL, buf.buf, NULL) < 0)
>> +	ropts.oid = &options->orig_head;
>> +	ropts.branch = options->head_name;
>> +	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>> +	ropts.head_msg = buf.buf;
> 
> ...and then for some of the ones like this "ropts.head_msg = buf.buf"
> assignment you just do that one immediately after the strbuf_addf() or
> whatever modifies it.
> 
> That way it's clear what options we get from the function arguments and
> can populate right away, and which ones we need to run some code in the
> function before we can update "ropts".

I'm not immediately clear why that matters. My priority was to keep the 
assignments in the same order an the old function arguments to make the 
conversion and review easier.

> [Ditto for the elided parts below]
> 
>>   #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
>>   
>> +/* Request a detached checkout */
>>   #define RESET_HEAD_DETACH (1<<0)
>> +/* Request a reset rather than a checkout */
>>   #define RESET_HEAD_HARD (1<<1)
>> +/* Run the post-checkout hook */
>>   #define RESET_HEAD_RUN_POST_CHECKOUT_HOOK (1<<2)
>> +/* Only update refs, do not touch the worktree */
>>   #define RESET_HEAD_REFS_ONLY (1<<3)
>> +/* Update ORIG_HEAD as well as HEAD */
>>   #define RESET_ORIG_HEAD (1<<4)
>>   
>> -int reset_head(struct repository *r, struct object_id *oid,
>> -	       const char *switch_to_branch, unsigned flags,
>> -	       const char *reflog_orig_head, const char *reflog_head,
>> -	       const char *default_reflog_action);
>> +struct reset_head_opts {
>> +	/*
>> +	 * The commit to checkout/reset to. Defaults to HEAD.
>> +	 */
>> +	const struct object_id *oid;
>> +	/*
>> +	 * Optional branch to switch to.
>> +	 */
>> +	const char *branch;
>> +	/*
>> +	 * Flags defined above.
>> +	 */
>> +	unsigned flags;
> 
> It's nice to make these sort of things an enum type for the reasons
> explained in 3f9ab7ccdea (parse-options.[ch]: consistently use "enum
> parse_opt_flags", 2021-10-08), i.e. gdb and the like will give you the
> labels in the debugger.

Yeah that's true but I'm not actually touching the flags here, just 
adding comments.

Best Wishes

Phillip
